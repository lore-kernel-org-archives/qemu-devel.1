Received: from eggs.gnu.org ([2001:4830:134:3::10]:52800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNIHG-0005qN-CO
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNIGw-0004RL-UG
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gNIGr-0004Nm-Ao
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:27 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu, 15 Nov 2018 15:04:58 +0100
Message-Id: <20181115140501.7872-7-david@redhat.com>
In-Reply-To: <20181115140501.7872-1-david@redhat.com>
References: <20181115140501.7872-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 6/9] qapi: rewrite string-input-visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>

The input visitor has some problems right now, especially
- unsigned type "Range" is used to process signed ranges, resulting in
  inconsistent behavior and ugly/magical code
- uint64_t are parsed like int64_t, so big uint64_t values are not
  supported and error messages are misleading
- lists/ranges of int64_t are accepted although no list is parsed and
  we should rather report an error
- lists/ranges are preparsed using int64_t, making it hard to
  implement uint64_t values or uint64_t lists
- types that don't support lists don't bail out
- visiting beyond the end of a list is not handled properly

So let's rewrite it by getting rid of usage of the type "Range" and
properly supporting lists of int64_t and uint64_t (including ranges of
both types), fixing the above mentioned issues.

Lists of other types are not supported and will properly report an
error. Virtual walks are now supported.

Tests have to be fixed up:
- Two BUGs were hardcoded that are fixed now
- The string-input-visitor now actually returns a parsed list and not
  an ordered set.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/qapi/string-input-visitor.h |   4 +-
 qapi/string-input-visitor.c         | 410 ++++++++++++++++------------
 tests/test-string-input-visitor.c   |  18 +-
 3 files changed, 239 insertions(+), 193 deletions(-)

diff --git a/include/qapi/string-input-visitor.h b/include/qapi/string-input-visitor.h
index 33551340e3..921f3875b9 100644
--- a/include/qapi/string-input-visitor.h
+++ b/include/qapi/string-input-visitor.h
@@ -19,8 +19,8 @@ typedef struct StringInputVisitor StringInputVisitor;
 
 /*
  * The string input visitor does not implement support for visiting
- * QAPI structs, alternates, null, or arbitrary QTypes.  It also
- * requires a non-null list argument to visit_start_list().
+ * QAPI structs, alternates, null, or arbitrary QTypes. Only flat lists
+ * of integers (except type "size") are supported.
  */
 Visitor *string_input_visitor_new(const char *str);
 
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index b89c6c4e06..4113be01fb 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -4,10 +4,10 @@
  * Copyright Red Hat, Inc. 2012-2016
  *
  * Author: Paolo Bonzini <pbonzini@redhat.com>
+ *         David Hildenbrand <david@redhat.com>
  *
  * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
- *
  */
 
 #include "qemu/osdep.h"
@@ -18,21 +18,39 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qnull.h"
 #include "qemu/option.h"
-#include "qemu/queue.h"
-#include "qemu/range.h"
 #include "qemu/cutils.h"
 
+typedef enum ListMode {
+    /* no list parsing active / no list expected */
+    LM_NONE,
+    /* we have an unparsed string remaining */
+    LM_UNPARSED,
+    /* we have an unfinished int64 range */
+    LM_INT64_RANGE,
+    /* we have an unfinished uint64 range */
+    LM_UINT64_RANGE,
+    /* we have parsed the string completely and no range is remaining */
+    LM_END,
+} ListMode;
+
+typedef union RangeElement {
+    int64_t i64;
+    uint64_t u64;
+} RangeElement;
 
 struct StringInputVisitor
 {
     Visitor visitor;
 
-    GList *ranges;
-    GList *cur_range;
-    int64_t cur;
+    /* List parsing state */
+    ListMode lm;
+    RangeElement rangeNext;
+    RangeElement rangeEnd;
+    const char *unparsed_string;
+    void *list;
 
+    /* The original string to parse */
     const char *string;
-    void *list; /* Only needed for sanity checking the caller */
 };
 
 static StringInputVisitor *to_siv(Visitor *v)
@@ -40,136 +58,43 @@ static StringInputVisitor *to_siv(Visitor *v)
     return container_of(v, StringInputVisitor, visitor);
 }
 
-static void free_range(void *range, void *dummy)
-{
-    g_free(range);
-}
-
-static int parse_str(StringInputVisitor *siv, const char *name, Error **errp)
-{
-    char *str = (char *) siv->string;
-    long long start, end;
-    Range *cur;
-    char *endptr;
-
-    if (siv->ranges) {
-        return 0;
-    }
-
-    if (!*str) {
-        return 0;
-    }
-
-    do {
-        errno = 0;
-        start = strtoll(str, &endptr, 0);
-        if (errno == 0 && endptr > str) {
-            if (*endptr == '\0') {
-                cur = g_malloc0(sizeof(*cur));
-                range_set_bounds(cur, start, start);
-                siv->ranges = range_list_insert(siv->ranges, cur);
-                cur = NULL;
-                str = NULL;
-            } else if (*endptr == '-') {
-                str = endptr + 1;
-                errno = 0;
-                end = strtoll(str, &endptr, 0);
-                if (errno == 0 && endptr > str && start <= end &&
-                    (start > INT64_MAX - 65536 ||
-                     end < start + 65536)) {
-                    if (*endptr == '\0') {
-                        cur = g_malloc0(sizeof(*cur));
-                        range_set_bounds(cur, start, end);
-                        siv->ranges = range_list_insert(siv->ranges, cur);
-                        cur = NULL;
-                        str = NULL;
-                    } else if (*endptr == ',') {
-                        str = endptr + 1;
-                        cur = g_malloc0(sizeof(*cur));
-                        range_set_bounds(cur, start, end);
-                        siv->ranges = range_list_insert(siv->ranges, cur);
-                        cur = NULL;
-                    } else {
-                        goto error;
-                    }
-                } else {
-                    goto error;
-                }
-            } else if (*endptr == ',') {
-                str = endptr + 1;
-                cur = g_malloc0(sizeof(*cur));
-                range_set_bounds(cur, start, start);
-                siv->ranges = range_list_insert(siv->ranges, cur);
-                cur = NULL;
-            } else {
-                goto error;
-            }
-        } else {
-            goto error;
-        }
-    } while (str);
-
-    return 0;
-error:
-    g_list_foreach(siv->ranges, free_range, NULL);
-    g_list_free(siv->ranges);
-    siv->ranges = NULL;
-    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
-               "an int64 value or range");
-    return -1;
-}
-
-static void
-start_list(Visitor *v, const char *name, GenericList **list, size_t size,
-           Error **errp)
+static void start_list(Visitor *v, const char *name, GenericList **list,
+                       size_t size, Error **errp)
 {
     StringInputVisitor *siv = to_siv(v);
 
-    /* We don't support visits without a list */
-    assert(list);
+    /* properly set the list parsing state */
+    assert(siv->lm == LM_NONE);
     siv->list = list;
+    siv->unparsed_string = siv->string;
 
-    if (parse_str(siv, name, errp) < 0) {
-        *list = NULL;
-        return;
-    }
-
-    siv->cur_range = g_list_first(siv->ranges);
-    if (siv->cur_range) {
-        Range *r = siv->cur_range->data;
-        if (r) {
-            siv->cur = range_lob(r);
+    if (!siv->string[0]) {
+        if (list) {
+            *list = NULL;
         }
-        *list = g_malloc0(size);
+        siv->lm = LM_END;
     } else {
-        *list = NULL;
+        if (list) {
+            *list = g_malloc0(size);
+        }
+        siv->lm = LM_UNPARSED;
     }
 }
 
 static GenericList *next_list(Visitor *v, GenericList *tail, size_t size)
 {
     StringInputVisitor *siv = to_siv(v);
-    Range *r;
 
-    if (!siv->ranges || !siv->cur_range) {
+    switch (siv->lm) {
+    case LM_END:
         return NULL;
-    }
-
-    r = siv->cur_range->data;
-    if (!r) {
-        return NULL;
-    }
-
-    if (!range_contains(r, siv->cur)) {
-        siv->cur_range = g_list_next(siv->cur_range);
-        if (!siv->cur_range) {
-            return NULL;
-        }
-        r = siv->cur_range->data;
-        if (!r) {
-            return NULL;
-        }
-        siv->cur = range_lob(r);
+    case LM_INT64_RANGE:
+    case LM_UINT64_RANGE:
+    case LM_UNPARSED:
+        /* we have an unparsed string or something left in a range */
+        break;
+    default:
+        abort();
     }
 
     tail->next = g_malloc0(size);
@@ -179,88 +104,215 @@ static GenericList *next_list(Visitor *v, GenericList *tail, size_t size)
 static void check_list(Visitor *v, Error **errp)
 {
     const StringInputVisitor *siv = to_siv(v);
-    Range *r;
-    GList *cur_range;
 
-    if (!siv->ranges || !siv->cur_range) {
+    switch (siv->lm) {
+    case LM_INT64_RANGE:
+    case LM_UINT64_RANGE:
+    case LM_UNPARSED:
+        error_setg(errp, "Fewer list elements expected");
         return;
-    }
-
-    r = siv->cur_range->data;
-    if (!r) {
+    case LM_END:
         return;
+    default:
+        abort();
     }
-
-    if (!range_contains(r, siv->cur)) {
-        cur_range = g_list_next(siv->cur_range);
-        if (!cur_range) {
-            return;
-        }
-        r = cur_range->data;
-        if (!r) {
-            return;
-        }
-    }
-
-    error_setg(errp, "Range contains too many values");
 }
 
 static void end_list(Visitor *v, void **obj)
 {
     StringInputVisitor *siv = to_siv(v);
 
+    assert(siv->lm != LM_NONE);
     assert(siv->list == obj);
+    siv->list = NULL;
+    siv->unparsed_string = NULL;
+    siv->lm = LM_NONE;
+}
+
+static int try_parse_int64_list_entry(StringInputVisitor *siv, int64_t *obj)
+{
+    const char *endptr;
+    int64_t start, end;
+
+    if (qemu_strtoi64(siv->unparsed_string, &endptr, 0, &start)) {
+        return -EINVAL;
+    }
+    end = start;
+
+    switch (endptr[0]) {
+    case '\0':
+        siv->unparsed_string = endptr;
+        break;
+    case ',':
+        siv->unparsed_string = endptr + 1;
+        break;
+    case '-':
+        /* parse the end of the range */
+        if (qemu_strtoi64(endptr + 1, &endptr, 0, &end)) {
+            return -EINVAL;
+        }
+        if (start > end) {
+            return -EINVAL;
+        }
+        switch (endptr[0]) {
+        case '\0':
+            siv->unparsed_string = endptr;
+            break;
+        case ',':
+            siv->unparsed_string = endptr + 1;
+            break;
+        default:
+            return -EINVAL;
+        }
+        break;
+    default:
+        return -EINVAL;
+    }
+
+    /* we have a proper range (with maybe only one element) */
+    siv->lm = LM_INT64_RANGE;
+    siv->rangeNext.i64 = start;
+    siv->rangeEnd.i64 = end;
+    return 0;
 }
 
 static void parse_type_int64(Visitor *v, const char *name, int64_t *obj,
                              Error **errp)
 {
     StringInputVisitor *siv = to_siv(v);
-
-    if (parse_str(siv, name, errp) < 0) {
+    int64_t val;
+
+    switch (siv->lm) {
+    case LM_NONE:
+        /* just parse a simple int64, bail out if not completely consumed */
+        if (qemu_strtoi64(siv->string, NULL, 0, &val)) {
+                error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                           name ? name : "null", "int64");
+            return;
+        }
+        *obj = val;
         return;
+    case LM_UNPARSED:
+        if (try_parse_int64_list_entry(siv, obj)) {
+            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
+                       "list of int64 values or ranges");
+            return;
+        }
+        assert(siv->lm == LM_INT64_RANGE);
+        /* FALLTHROUGH */
+    case LM_INT64_RANGE:
+        /* return the next element in the range */
+        assert(siv->rangeNext.i64 <= siv->rangeEnd.i64);
+        *obj = siv->rangeNext.i64++;
+
+        if (siv->rangeNext.i64 > siv->rangeEnd.i64 || *obj == INT64_MAX) {
+            /* end of range, check if there is more to parse */
+            if (siv->unparsed_string[0]) {
+                siv->lm = LM_UNPARSED;
+            } else {
+                siv->lm = LM_END;
+            }
+        }
+        return;
+    case LM_END:
+        error_setg(errp, "Fewer list elements expected");
+        return;
+    default:
+        abort();
     }
+}
 
-    if (!siv->ranges) {
-        goto error;
-    }
-
-    if (!siv->cur_range) {
-        Range *r;
+static int try_parse_uint64_list_entry(StringInputVisitor *siv, uint64_t *obj)
+{
+    const char *endptr;
+    uint64_t start, end;
 
-        siv->cur_range = g_list_first(siv->ranges);
-        if (!siv->cur_range) {
-            goto error;
+    /* parse a simple uint64 or range */
+    if (qemu_strtou64(siv->unparsed_string, &endptr, 0, &start)) {
+        return -EINVAL;
+    }
+    end = start;
+
+    switch (endptr[0]) {
+    case '\0':
+        siv->unparsed_string = endptr;
+        break;
+    case ',':
+        siv->unparsed_string = endptr + 1;
+        break;
+    case '-':
+        /* parse the end of the range */
+        if (qemu_strtou64(endptr + 1, &endptr, 0, &end)) {
+            return -EINVAL;
         }
-
-        r = siv->cur_range->data;
-        if (!r) {
-            goto error;
+        if (start > end) {
+            return -EINVAL;
         }
-
-        siv->cur = range_lob(r);
+        switch (endptr[0]) {
+        case '\0':
+            siv->unparsed_string = endptr;
+            break;
+        case ',':
+            siv->unparsed_string = endptr + 1;
+            break;
+        default:
+            return -EINVAL;
+        }
+        break;
+    default:
+        return -EINVAL;
     }
 
-    *obj = siv->cur;
-    siv->cur++;
-    return;
-
-error:
-    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
-               "an int64 value or range");
+    /* we have a proper range (with maybe only one element) */
+    siv->lm = LM_UINT64_RANGE;
+    siv->rangeNext.u64 = start;
+    siv->rangeEnd.u64 = end;
+    return 0;
 }
 
 static void parse_type_uint64(Visitor *v, const char *name, uint64_t *obj,
                               Error **errp)
 {
-    /* FIXME: parse_type_int64 mishandles values over INT64_MAX */
-    int64_t i;
-    Error *err = NULL;
-    parse_type_int64(v, name, &i, &err);
-    if (err) {
-        error_propagate(errp, err);
-    } else {
-        *obj = i;
+    StringInputVisitor *siv = to_siv(v);
+    uint64_t val;
+
+    switch (siv->lm) {
+    case LM_NONE:
+        /* just parse a simple uint64, bail out if not completely consumed */
+        if (qemu_strtou64(siv->string, NULL, 0, &val)) {
+            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
+                       "uint64");
+            return;
+        }
+        *obj = val;
+        return;
+    case LM_UNPARSED:
+        if (try_parse_uint64_list_entry(siv, obj)) {
+            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
+                       "list of uint64 values or ranges");
+            return;
+        }
+        assert(siv->lm == LM_UINT64_RANGE);
+        /* FALLTHROUGH */
+    case LM_UINT64_RANGE:
+        /* return the next element in the range */
+        assert(siv->rangeNext.u64 <= siv->rangeEnd.u64);
+        *obj = siv->rangeNext.u64++;
+
+        if (siv->rangeNext.u64 > siv->rangeEnd.u64 || *obj == UINT64_MAX) {
+            /* end of range, check if there is more to parse */
+            if (siv->unparsed_string[0]) {
+                siv->lm = LM_UNPARSED;
+            } else {
+                siv->lm = LM_END;
+            }
+        }
+        return;
+    case LM_END:
+        error_setg(errp, "Fewer list elements expected");
+        return;
+    default:
+        abort();
     }
 }
 
@@ -271,6 +323,7 @@ static void parse_type_size(Visitor *v, const char *name, uint64_t *obj,
     Error *err = NULL;
     uint64_t val;
 
+    assert(siv->lm == LM_NONE);
     parse_option_size(name, siv->string, &val, &err);
     if (err) {
         error_propagate(errp, err);
@@ -285,6 +338,7 @@ static void parse_type_bool(Visitor *v, const char *name, bool *obj,
 {
     StringInputVisitor *siv = to_siv(v);
 
+    assert(siv->lm == LM_NONE);
     if (!strcasecmp(siv->string, "on") ||
         !strcasecmp(siv->string, "yes") ||
         !strcasecmp(siv->string, "true")) {
@@ -307,6 +361,7 @@ static void parse_type_str(Visitor *v, const char *name, char **obj,
 {
     StringInputVisitor *siv = to_siv(v);
 
+    assert(siv->lm == LM_NONE);
     *obj = g_strdup(siv->string);
 }
 
@@ -316,6 +371,7 @@ static void parse_type_number(Visitor *v, const char *name, double *obj,
     StringInputVisitor *siv = to_siv(v);
     double val;
 
+    assert(siv->lm == LM_NONE);
     if (qemu_strtod_finite(siv->string, NULL, &val)) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
                    "number");
@@ -330,9 +386,10 @@ static void parse_type_null(Visitor *v, const char *name, QNull **obj,
 {
     StringInputVisitor *siv = to_siv(v);
 
+    assert(siv->lm == LM_NONE);
     *obj = NULL;
 
-    if (!siv->string || siv->string[0]) {
+    if (siv->string[0]) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
                    "null");
         return;
@@ -345,8 +402,6 @@ static void string_input_free(Visitor *v)
 {
     StringInputVisitor *siv = to_siv(v);
 
-    g_list_foreach(siv->ranges, free_range, NULL);
-    g_list_free(siv->ranges);
     g_free(siv);
 }
 
@@ -372,5 +427,6 @@ Visitor *string_input_visitor_new(const char *str)
     v->visitor.free = string_input_free;
 
     v->string = str;
+    v->lm = LM_NONE;
     return &v->visitor;
 }
diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index f55e0696c0..a198aedfce 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -92,16 +92,6 @@ static void check_ulist(Visitor *v, uint64_t *expected, size_t n)
     uint64List *tail;
     int i;
 
-    /* BUG: unsigned numbers above INT64_MAX don't work */
-    for (i = 0; i < n; i++) {
-        if (expected[i] > INT64_MAX) {
-            Error *err = NULL;
-            visit_type_uint64List(v, NULL, &res, &err);
-            error_free_or_abort(&err);
-            return;
-        }
-    }
-
     visit_type_uint64List(v, NULL, &res, &error_abort);
     tail = res;
     for (i = 0; i < n; i++) {
@@ -117,10 +107,10 @@ static void check_ulist(Visitor *v, uint64_t *expected, size_t n)
 static void test_visitor_in_intList(TestInputVisitorData *data,
                                     const void *unused)
 {
-    /* Note: the visitor *sorts* ranges *unsigned* */
-    int64_t expect1[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 20 };
+    int64_t expect1[] = { 1, 2, 0, 2, 3, 4, 20, 5, 6, 7,
+                          8, 9, 1, 2, 3, 4, 5, 6, 7, 8 };
     int64_t expect2[] = { 32767, -32768, -32767 };
-    int64_t expect3[] = { INT64_MAX, INT64_MIN };
+    int64_t expect3[] = { INT64_MIN, INT64_MAX };
     int64_t expect4[] = { 1 };
     uint64_t expect5[] = { UINT64_MAX };
     Error *err = NULL;
@@ -207,7 +197,7 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
     visit_type_int64(v, NULL, &tail->value, &err);
     g_assert_cmpint(tail->value, ==, 0);
     visit_type_int64(v, NULL, &val, &err);
-    g_assert_cmpint(val, ==, 1); /* BUG */
+    error_free_or_abort(&err);
     visit_check_list(v, &error_abort);
     visit_end_list(v, (void **)&res);
 
-- 
2.17.2
