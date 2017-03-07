Received: from eggs.gnu.org ([2001:4830:134:3::10]:34834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1clGv6-0003a4-FH
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:21:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1clGv2-0003Tq-LH
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:21:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1clGv2-0003Rq-5s
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:20:56 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2DF5215F57A
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 15:20:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v27FKqsR017438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 7 Mar 2017 10:20:53 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  7 Mar 2017 16:20:45 +0100
Message-Id: <1488900045-26344-25-git-send-email-armbru@redhat.com>
In-Reply-To: <1488900045-26344-1-git-send-email-armbru@redhat.com>
References: <1488900045-26344-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v4 24/24] keyval: Support lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Additionally permit non-negative integers as key components.  A
dictionary's keys must either be all integers or none.  If all keys
are integers, convert the dictionary to a list.  The set of keys must
be [0,N].

Examples:

* list.1=goner,list.0=null,list.1=eins,list.2=zwei
  is equivalent to JSON [ "null", "eins", "zwei" ]

* a.b.c=1,a.b.0=2
  is inconsistent: a.b.c clashes with a.b.0

* list.0=null,list.2=eins,list.2=zwei
  has a hole: list.1 is missing

Similar design flaw as for objects: there is no way to denote an empty
list.  While interpreting "key absent" as empty list seems natural
(removing a list member from the input string works when there are
multiple ones, so why not when there's just one), it doesn't work:
"key absent" already means "optional list absent", which isn't the
same as "empty list present".

Update the keyval object visitor to use this a.0 syntax in error
messages rather than the usual a[0].

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1488317230-26248-25-git-send-email-armbru@redhat.com>
[Off-by-one fix squashed in, as per Kevin's review]
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/qobject-input-visitor.c |   6 +-
 tests/test-keyval.c          | 122 +++++++++++++++++++++++++++++
 util/keyval.c                | 183 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 298 insertions(+), 13 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index b9acd86..865e948 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -41,6 +41,7 @@ struct QObjectInputVisitor {
 
     /* Root of visit at visitor creation. */
     QObject *root;
+    bool keyval;                /* Assume @root made with keyval_parse() */
 
     /* Stack of objects being visited (all entries will be either
      * QDict or QList). */
@@ -73,7 +74,9 @@ static const char *full_name_nth(QObjectInputVisitor *qiv, const char *name,
             g_string_prepend(qiv->errname, name ?: "<anonymous>");
             g_string_prepend_c(qiv->errname, '.');
         } else {
-            snprintf(buf, sizeof(buf), "[%u]", so->index);
+            snprintf(buf, sizeof(buf),
+                     qiv->keyval ? ".%u" : "[%u]",
+                     so->index);
             g_string_prepend(qiv->errname, buf);
         }
         name = so->name;
@@ -673,6 +676,7 @@ Visitor *qobject_input_visitor_new_keyval(QObject *obj)
     v->visitor.type_any = qobject_input_type_any;
     v->visitor.type_null = qobject_input_type_null;
     v->visitor.type_size = qobject_input_type_size_keyval;
+    v->keyval = true;
 
     return &v->visitor;
 }
diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index efe27cd..71288b0 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qemu/cutils.h"
 #include "qemu/option.h"
@@ -183,6 +184,72 @@ static void test_keyval_parse(void)
     g_assert(!qdict);
 }
 
+static void check_list012(QList *qlist)
+{
+    static const char *expected[] = { "null", "eins", "zwei" };
+    int i;
+    QString *qstr;
+
+    g_assert(qlist);
+    for (i = 0; i < ARRAY_SIZE(expected); i++) {
+        qstr = qobject_to_qstring(qlist_pop(qlist));
+        g_assert(qstr);
+        g_assert_cmpstr(qstring_get_str(qstr), ==, expected[i]);
+        QDECREF(qstr);
+    }
+    g_assert(qlist_empty(qlist));
+}
+
+static void test_keyval_parse_list(void)
+{
+    Error *err = NULL;
+    QDict *qdict, *sub_qdict;
+
+    /* Root can't be a list */
+    qdict = keyval_parse("0=1", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* List elements need not be in order */
+    qdict = keyval_parse("list.0=null,list.2=zwei,list.1=eins",
+                         NULL, &error_abort);
+    g_assert_cmpint(qdict_size(qdict), ==, 1);
+    check_list012(qdict_get_qlist(qdict, "list"));
+    QDECREF(qdict);
+
+    /* Multiple indexes, last one wins */
+    qdict = keyval_parse("list.1=goner,list.0=null,list.1=eins,list.2=zwei",
+                         NULL, &error_abort);
+    g_assert_cmpint(qdict_size(qdict), ==, 1);
+    check_list012(qdict_get_qlist(qdict, "list"));
+    QDECREF(qdict);
+
+    /* List at deeper nesting */
+    qdict = keyval_parse("a.list.1=eins,a.list.0=null,a.list.2=zwei",
+                         NULL, &error_abort);
+    g_assert_cmpint(qdict_size(qdict), ==, 1);
+    sub_qdict = qdict_get_qdict(qdict, "a");
+    g_assert_cmpint(qdict_size(sub_qdict), ==, 1);
+    check_list012(qdict_get_qlist(sub_qdict, "list"));
+    QDECREF(qdict);
+
+    /* Inconsistent dotted keys: both list and dictionary */
+    qdict = keyval_parse("a.b.c=1,a.b.0=2", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+    qdict = keyval_parse("a.0.c=1,a.b.c=2", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* Missing list indexes */
+    qdict = keyval_parse("list.2=lonely", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+    qdict = keyval_parse("list.0=null,list.2=eins,list.02=zwei", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+}
+
 static void test_keyval_visit_bool(void)
 {
     Error *err = NULL;
@@ -459,6 +526,59 @@ static void test_keyval_visit_dict(void)
     visit_free(v);
 }
 
+static void test_keyval_visit_list(void)
+{
+    Error *err = NULL;
+    Visitor *v;
+    QDict *qdict;
+    char *s;
+
+    qdict = keyval_parse("a.0=,a.1=I,a.2.0=II", NULL, &error_abort);
+    /* TODO empty list */
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_start_list(v, "a", NULL, 0, &error_abort);
+    visit_type_str(v, NULL, &s, &error_abort);
+    g_assert_cmpstr(s, ==, "");
+    g_free(s);
+    visit_type_str(v, NULL, &s, &error_abort);
+    g_assert_cmpstr(s, ==, "I");
+    g_free(s);
+    visit_start_list(v, NULL, NULL, 0, &error_abort);
+    visit_type_str(v, NULL, &s, &error_abort);
+    g_assert_cmpstr(s, ==, "II");
+    g_free(s);
+    visit_check_list(v, &error_abort);
+    visit_end_list(v, NULL);
+    visit_check_list(v, &error_abort);
+    visit_end_list(v, NULL);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    qdict = keyval_parse("a.0=,b.0.0=head", NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_start_list(v, "a", NULL, 0, &error_abort);
+    visit_check_list(v, &err);  /* a[0] unexpected */
+    error_free_or_abort(&err);
+    visit_end_list(v, NULL);
+    visit_start_list(v, "b", NULL, 0, &error_abort);
+    visit_start_list(v, NULL, NULL, 0, &error_abort);
+    visit_type_str(v, NULL, &s, &error_abort);
+    g_assert_cmpstr(s, ==, "head");
+    g_free(s);
+    visit_type_str(v, NULL, &s, &err); /* b[0][1] missing */
+    error_free_or_abort(&err);
+    visit_end_list(v, NULL);
+    visit_end_list(v, NULL);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+}
+
 static void test_keyval_visit_optional(void)
 {
     Visitor *v;
@@ -492,10 +612,12 @@ int main(int argc, char *argv[])
 {
     g_test_init(&argc, &argv, NULL);
     g_test_add_func("/keyval/keyval_parse", test_keyval_parse);
+    g_test_add_func("/keyval/keyval_parse/list", test_keyval_parse_list);
     g_test_add_func("/keyval/visit/bool", test_keyval_visit_bool);
     g_test_add_func("/keyval/visit/number", test_keyval_visit_number);
     g_test_add_func("/keyval/visit/size", test_keyval_visit_size);
     g_test_add_func("/keyval/visit/dict", test_keyval_visit_dict);
+    g_test_add_func("/keyval/visit/list", test_keyval_visit_list);
     g_test_add_func("/keyval/visit/optional", test_keyval_visit_optional);
     g_test_run();
     return 0;
diff --git a/util/keyval.c b/util/keyval.c
index cb484ef..f646b36 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -21,10 +21,12 @@
  *
  * Semantics defined by reduction to JSON:
  *
- *   key-vals defines a tree of objects rooted at R
+ *   key-vals is a tree of objects and arrays rooted at object R
  *   where for each key-val = key-fragment . ... = val in key-vals
  *       R op key-fragment op ... = val'
- *       where (left-associative) op is member reference L.key-fragment
+ *       where (left-associative) op is
+ *                 array subscript L[key-fragment] for numeric key-fragment
+ *                 member reference L.key-fragment otherwise
  *             val' is val with ',,' replaced by ','
  *   and only R may be empty.
  *
@@ -34,16 +36,16 @@
  *   doesn't have one, because R.a must be an object to satisfy a.b=1
  *   and a string to satisfy a=2.
  *
- * Key-fragments must be valid QAPI names.
+ * Key-fragments must be valid QAPI names or consist only of digits.
  *
  * The length of any key-fragment must be between 1 and 127.
  *
- * Design flaw: there is no way to denote an empty non-root object.
- * While interpreting "key absent" as empty object seems natural
+ * Design flaw: there is no way to denote an empty array or non-root
+ * object.  While interpreting "key absent" as empty seems natural
  * (removing a key-val from the input string removes the member when
  * there are more, so why not when it's the last), it doesn't work:
- * "key absent" already means "optional object absent", which isn't
- * the same as "empty object present".
+ * "key absent" already means "optional object/array absent", which
+ * isn't the same as "empty object/array present".
  *
  * Additional syntax for use with an implied key:
  *
@@ -51,17 +53,43 @@
  *   val-no-key   = / [^=,]* /
  *
  * where no-key is syntactic sugar for implied-key=val-no-key.
- *
- * TODO support lists
  */
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/util.h"
+#include "qemu/cutils.h"
 #include "qemu/option.h"
 
 /*
+ * Convert @key to a list index.
+ * Convert all leading digits to a (non-negative) number, capped at
+ * INT_MAX.
+ * If @end is non-null, assign a pointer to the first character after
+ * the number to *@end.
+ * Else, fail if any characters follow.
+ * On success, return the converted number.
+ * On failure, return a negative value.
+ * Note: since only digits are converted, no two keys can map to the
+ * same number, except by overflow to INT_MAX.
+ */
+static int key_to_index(const char *key, const char **end)
+{
+    int ret;
+    unsigned long index;
+
+    if (*key < '0' || *key > '9') {
+        return -EINVAL;
+    }
+    ret = qemu_strtoul(key, end, 10, &index);
+    if (ret) {
+        return ret == -ERANGE ? INT_MAX : ret;
+    }
+    return index <= INT_MAX ? index : INT_MAX;
+}
+
+/*
  * Ensure @cur maps @key_in_cur the right way.
  * If @value is null, it needs to map to a QDict, else to this
  * QString.
@@ -116,7 +144,7 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
                                     const char *implied_key,
                                     Error **errp)
 {
-    const char *key, *key_end, *s;
+    const char *key, *key_end, *s, *end;
     size_t len;
     char key_in_cur[128];
     QDict *cur;
@@ -140,8 +168,13 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
     cur = qdict;
     s = key;
     for (;;) {
-        ret = parse_qapi_name(s, false);
-        len = ret < 0 ? 0 : ret;
+        /* Want a key index (unless it's first) or a QAPI name */
+        if (s != key && key_to_index(s, &end) >= 0) {
+            len = end - s;
+        } else {
+            ret = parse_qapi_name(s, false);
+            len = ret < 0 ? 0 : ret;
+        }
         assert(s + len <= key_end);
         if (!len || (s + len < key_end && s[len] != '.')) {
             assert(key != implied_key);
@@ -208,6 +241,125 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
     return s;
 }
 
+static char *reassemble_key(GSList *key)
+{
+    GString *s = g_string_new("");
+    GSList *p;
+
+    for (p = key; p; p = p->next) {
+        g_string_prepend_c(s, '.');
+        g_string_prepend(s, (char *)p->data);
+    }
+
+    return g_string_free(s, FALSE);
+}
+
+/*
+ * Listify @cur recursively.
+ * Replace QDicts whose keys are all valid list indexes by QLists.
+ * @key_of_cur is the list of key fragments leading up to @cur.
+ * On success, return either @cur or its replacement.
+ * On failure, store an error through @errp and return NULL.
+ */
+static QObject *keyval_listify(QDict *cur, GSList *key_of_cur, Error **errp)
+{
+    GSList key_node;
+    bool has_index, has_member;
+    const QDictEntry *ent;
+    QDict *qdict;
+    QObject *val;
+    char *key;
+    size_t nelt;
+    QObject **elt;
+    int index, max_index, i;
+    QList *list;
+
+    key_node.next = key_of_cur;
+
+    /*
+     * Recursively listify @cur's members, and figure out whether @cur
+     * itself is to be listified.
+     */
+    has_index = false;
+    has_member = false;
+    for (ent = qdict_first(cur); ent; ent = qdict_next(cur, ent)) {
+        if (key_to_index(ent->key, NULL) >= 0) {
+            has_index = true;
+        } else {
+            has_member = true;
+        }
+
+        qdict = qobject_to_qdict(ent->value);
+        if (!qdict) {
+            continue;
+        }
+
+        key_node.data = ent->key;
+        val = keyval_listify(qdict, &key_node, errp);
+        if (!val) {
+            return NULL;
+        }
+        if (val != ent->value) {
+            qdict_put_obj(cur, ent->key, val);
+        }
+    }
+
+    if (has_index && has_member) {
+        key = reassemble_key(key_of_cur);
+        error_setg(errp, "Parameters '%s*' used inconsistently", key);
+        g_free(key);
+        return NULL;
+    }
+    if (!has_index) {
+        return QOBJECT(cur);
+    }
+
+    /* Copy @cur's values to @elt[] */
+    nelt = qdict_size(cur) + 1; /* one extra, for use as sentinel */
+    elt = g_new0(QObject *, nelt);
+    max_index = -1;
+    for (ent = qdict_first(cur); ent; ent = qdict_next(cur, ent)) {
+        index = key_to_index(ent->key, NULL);
+        assert(index >= 0);
+        if (index > max_index) {
+            max_index = index;
+        }
+        /*
+         * We iterate @nelt times.  If we get one exceeding @nelt
+         * here, we will put less than @nelt values into @elt[],
+         * triggering the error in the next loop.
+         */
+        if ((size_t)index >= nelt - 1) {
+            continue;
+        }
+        /* Even though dict keys are distinct, indexes need not be */
+        elt[index] = ent->value;
+    }
+
+    /*
+     * Make a list from @elt[], reporting any missing elements.
+     * If we dropped an index >= nelt in the previous loop, this loop
+     * will run into the sentinel and report index @nelt missing.
+     */
+    list = qlist_new();
+    assert(!elt[nelt-1]);       /* need the sentinel to be null */
+    for (i = 0; i < MIN(nelt, max_index + 1); i++) {
+        if (!elt[i]) {
+            key = reassemble_key(key_of_cur);
+            error_setg(errp, "Parameter '%s%d' missing", key, i);
+            g_free(key);
+            g_free(elt);
+            QDECREF(list);
+            return NULL;
+        }
+        qobject_incref(elt[i]);
+        qlist_append_obj(list, elt[i]);
+    }
+
+    g_free(elt);
+    return QOBJECT(list);
+}
+
 /*
  * Parse @params in QEMU's traditional KEY=VALUE,... syntax.
  * If @implied_key, the first KEY= can be omitted.  @implied_key is
@@ -219,6 +371,7 @@ QDict *keyval_parse(const char *params, const char *implied_key,
                     Error **errp)
 {
     QDict *qdict = qdict_new();
+    QObject *listified;
     const char *s;
 
     s = params;
@@ -231,5 +384,11 @@ QDict *keyval_parse(const char *params, const char *implied_key,
         implied_key = NULL;
     }
 
+    listified = keyval_listify(qdict, NULL, errp);
+    if (!listified) {
+        QDECREF(qdict);
+        return NULL;
+    }
+    assert(listified == QOBJECT(qdict));
     return qdict;
 }
-- 
2.7.4
