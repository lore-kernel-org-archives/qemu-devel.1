Received: from eggs.gnu.org ([2001:4830:134:3::10]:54457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9z3z-0005di-GE
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9z3y-0002dh-3J
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:57:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1g9z3x-0002dD-R6
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:57:06 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue,  9 Oct 2018 22:56:46 +0200
Message-Id: <20181009205652.10605-2-david@redhat.com>
In-Reply-To: <20181009205652.10605-1-david@redhat.com>
References: <20181009205652.10605-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 1/7] qapi: correctly parse uint64_t values
 from strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Hildenbrand <david@redhat.com>

Right now, we parse uint64_t values just like int64_t values, resulting
in negative values getting accepted and certain valid large numbers only
being representable as negative numbers. Also, reported errors indicate
that an int64_t is expected.

Parse uin64_t separately. Implementation inspired by original
parse_str() implementation.

E.g. we can now specify
    -device nvdimm,memdev=mem1,id=nv1,addr=0xFFFFFFFFC0000000
Instead of going via negative values
    -device nvdimm,memdev=mem1,id=nv1,addr=-0x40000000

Resulting in the same values

(qemu) info memory-devices
Memory device [nvdimm]: "nv1"
  addr: 0xffffffffc0000000
  slot: 0
  node: 0

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 qapi/string-input-visitor.c | 117 ++++++++++++++++++++++++++++++++----
 1 file changed, 106 insertions(+), 11 deletions(-)

diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index b3fdd0827d..af0a841152 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -19,6 +19,7 @@
 #include "qapi/qmp/qnull.h"
 #include "qemu/option.h"
 #include "qemu/queue.h"
+#include "qemu/cutils.h"
 #include "qemu/range.h"
 
 
@@ -44,7 +45,8 @@ static void free_range(void *range, void *dummy)
     g_free(range);
 }
 
-static int parse_str(StringInputVisitor *siv, const char *name, Error **errp)
+static int parse_str_int64(StringInputVisitor *siv, const char *name,
+                           Error **errp)
 {
     char *str = (char *) siv->string;
     long long start, end;
@@ -118,6 +120,75 @@ error:
     return -1;
 }
 
+static int parse_str_uint64(StringInputVisitor *siv, const char *name,
+                            Error **errp)
+{
+    const char *str = (char *) siv->string;
+    uint64_t start, end;
+    const char *endptr;
+    Range *cur;
+
+    if (siv->ranges) {
+        return 0;
+    }
+
+    if (!*str) {
+        return 0;
+    }
+
+    do {
+        if (!qemu_strtou64(str, &endptr, 0, &start)) {
+            if (*endptr == '\0') {
+                cur = g_malloc0(sizeof(*cur));
+                range_set_bounds(cur, start, start);
+                siv->ranges = range_list_insert(siv->ranges, cur);
+                cur = NULL;
+                str = NULL;
+            } else if (*endptr == '-') {
+                str = endptr + 1;
+                if (!qemu_strtou64(str, &endptr, 0, &end) && start <= end) {
+                    if (*endptr == '\0') {
+                        cur = g_malloc0(sizeof(*cur));
+                        range_set_bounds(cur, start, end);
+                        siv->ranges = range_list_insert(siv->ranges, cur);
+                        cur = NULL;
+                        str = NULL;
+                    } else if (*endptr == ',') {
+                        str = endptr + 1;
+                        cur = g_malloc0(sizeof(*cur));
+                        range_set_bounds(cur, start, end);
+                        siv->ranges = range_list_insert(siv->ranges, cur);
+                        cur = NULL;
+                    } else {
+                        goto error;
+                    }
+                } else {
+                    goto error;
+                }
+            } else if (*endptr == ',') {
+                str = endptr + 1;
+                cur = g_malloc0(sizeof(*cur));
+                range_set_bounds(cur, start, start);
+                siv->ranges = range_list_insert(siv->ranges, cur);
+                cur = NULL;
+            } else {
+                goto error;
+            }
+        } else {
+            goto error;
+        }
+    } while (str);
+
+    return 0;
+error:
+    g_list_foreach(siv->ranges, free_range, NULL);
+    g_list_free(siv->ranges);
+    siv->ranges = NULL;
+    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
+               "an uint64 value or range");
+    return -1;
+}
+
 static void
 start_list(Visitor *v, const char *name, GenericList **list, size_t size,
            Error **errp)
@@ -128,7 +199,7 @@ start_list(Visitor *v, const char *name, GenericList **list, size_t size,
     assert(list);
     siv->list = list;
 
-    if (parse_str(siv, name, errp) < 0) {
+    if (parse_str_int64(siv, name, errp) < 0) {
         *list = NULL;
         return;
     }
@@ -216,7 +287,7 @@ static void parse_type_int64(Visitor *v, const char *name, int64_t *obj,
 {
     StringInputVisitor *siv = to_siv(v);
 
-    if (parse_str(siv, name, errp) < 0) {
+    if (parse_str_int64(siv, name, errp) < 0) {
         return;
     }
 
@@ -252,15 +323,39 @@ error:
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
+
+    if (parse_str_uint64(siv, name, errp) < 0) {
+        return;
+    }
+
+    if (!siv->ranges) {
+        goto error;
+    }
+
+    if (!siv->cur_range) {
+        Range *r;
+
+        siv->cur_range = g_list_first(siv->ranges);
+        if (!siv->cur_range) {
+            goto error;
+        }
+
+        r = siv->cur_range->data;
+        if (!r) {
+            goto error;
+        }
+
+        siv->cur = range_lob(r);
     }
+
+    *obj = siv->cur;
+    siv->cur++;
+    return;
+
+error:
+    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
+               "an uint64 value or range");
 }
 
 static void parse_type_size(Visitor *v, const char *name, uint64_t *obj,
-- 
2.17.1
