Received: from eggs.gnu.org ([2001:4830:134:3::10]:42791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNNO-0001Zp-Dj
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNNN-0002Kn-8t
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:58:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dhNNM-0002K7-VX
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:58:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5F52C0587E3
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 21:58:19 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 14 Aug 2017 18:57:37 -0300
Message-Id: <20170814215748.5158-3-ehabkost@redhat.com>
In-Reply-To: <20170814215748.5158-1-ehabkost@redhat.com>
References: <20170814215748.5158-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v4 02/13] qapi: qobject_compare() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>

The helper function will be useful when writing support code to
deal with device slot information.

TODO: documentation is incomplete and unclear, needs to be
improved.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qapi/util.h    | 39 +++++++++++++++++++++++++++++
 qapi/qapi-util.c       | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/test-qapi-util.c | 53 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+)

diff --git a/include/qapi/util.h b/include/qapi/util.h
index 7436ed8..d4562c4 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -11,9 +11,48 @@
 #ifndef QAPI_UTIL_H
 #define QAPI_UTIL_H
 
+#include "qapi/qmp/qobject.h"
+#include "qapi-types.h"
+
 int qapi_enum_parse(const char * const lookup[], const char *buf,
                     int max, int def, Error **errp);
 
 int parse_qapi_name(const char *name, bool complete);
 
+/**
+ * qobject_compare:
+ *
+ * Compare the value of @a and @b.
+ *
+ * If @a and @b have the same type and the same value (see list
+ * of supported types below), return 0.
+ *
+ * If @a and @b are both strings, return strcmp(a, b).
+ *
+ * If @a and @b are numbers, return a negative value if a < b,
+ * and a positive value if a > b.
+ *
+ * Otherwise (if @a and @b are not the same, have different types,
+ * are of an unsupported type, or are different), return a non-zero value.
+ *
+ * Note that this function doesn't support some types, and may
+ * return false if the types are unsupported, or if the types don't
+ * match exactly.
+ *
+ * Supported types:
+ * - QTYPE_QNULL
+ * - QTYPE_QSTRING
+ * - QTYPE_QBOOL
+ * - QTYPE_QNUM (integers only)
+ * - QTYPE_QLIST
+ *
+ * Unsupported (always return false):
+ * - QTYPE_QNUM (non-integer values)
+ * - QTYPE_QDICT
+ *
+ * TODO: rewrite documentation to be clearer.
+ * TODO: support non-integer QTYPE_NUM values and QTYPE_QDICT.
+ */
+int qobject_compare(QObject *a, QObject *b);
+
 #endif
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 46eda7d..67c5e82 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -13,6 +13,9 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
+#include "qapi/qmp/qstring.h"
+#include "qapi/qmp/qnum.h"
+#include "qapi/qmp/qbool.h"
 #include "qapi/util.h"
 
 int qapi_enum_parse(const char * const lookup[], const char *buf,
@@ -80,3 +83,66 @@ int parse_qapi_name(const char *str, bool complete)
     }
     return p - str;
 }
+
+static int qnum_compare(QNum *a, QNum *b)
+{
+    int64_t ia, ib;
+    bool va = qnum_get_try_int(a, &ia);
+    bool vb = qnum_get_try_int(b, &ib);
+
+    if (va && vb) {
+        return (ia < ib) ? -1 : (ia > ib) ? 1 : 0;
+    }
+
+    /*TODO: uint, double */
+    return -1;
+}
+
+static int qlist_compare(QList *a, QList *b)
+{
+    const QListEntry *ea, *eb;
+
+    for (ea = qlist_first(a), eb = qlist_first(b);
+         ea && eb;
+         ea = qlist_next(ea), eb = qlist_next(eb)) {
+        QObject *va = qlist_entry_obj(ea);
+        QObject *vb = qlist_entry_obj(eb);
+        int c = qobject_compare(va, vb);
+        if (c) {
+            return c;
+        }
+    }
+
+    if (eb) {
+        return -1;
+    } else if (ea) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+
+int qobject_compare(QObject *a, QObject *b)
+{
+    QType ta = qobject_type(a);
+    QType tb = qobject_type(b);
+
+    if (ta != tb) {
+        return -1;
+    }
+
+    switch (ta) {
+    case QTYPE_QNULL:
+        return true;
+    case QTYPE_QNUM:
+        return qnum_compare(qobject_to_qnum(a), qobject_to_qnum(b));
+    case QTYPE_QSTRING:
+        return strcmp(qstring_get_str(qobject_to_qstring(a)), qstring_get_str(qobject_to_qstring(b)));
+    case QTYPE_QBOOL:
+        return (int)qbool_get_bool(qobject_to_qbool(a)) - (int)qbool_get_bool(qobject_to_qbool(b));
+    case QTYPE_QLIST:
+        return qlist_compare(qobject_to_qlist(a), qobject_to_qlist(b));
+    default:
+        return -1;
+    }
+}
diff --git a/tests/test-qapi-util.c b/tests/test-qapi-util.c
index e869757..c0cf46c 100644
--- a/tests/test-qapi-util.c
+++ b/tests/test-qapi-util.c
@@ -13,6 +13,10 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/util.h"
+#include "qapi/qmp/qnum.h"
+#include "qapi/qmp/qstring.h"
+#include "qapi/qmp/qlist.h"
+#include "qapi/qmp/qjson.h"
 #include "test-qapi-types.h"
 
 static void test_qapi_enum_parse(void)
@@ -75,11 +79,60 @@ static void test_parse_qapi_name(void)
     g_assert(ret == -1);
 }
 
+static void test_qobject_compare(void)
+{
+    QString *a1 = qstring_from_str("abc");
+    QString *a2 = qstring_from_str("abc");
+    QString *b = qstring_from_str("bcd");
+    QNum *i1 = qnum_from_int(100);
+    QNum *i2 = qnum_from_int(100);
+    QNum *j = qnum_from_int(200);
+    QList *l1 = qlist_new();
+    QList *l2 = qlist_new();
+    QList *m = qlist_new();
+
+    qlist_append_int(l1, 100);
+    qlist_append_int(l1, 200);
+    qlist_append_int(l2, 100);
+    qlist_append_int(l2, 200);
+
+    qlist_append_int(m, 100);
+    qlist_append_int(m, 300);
+
+    g_assert_cmpint(qobject_compare(QOBJECT(a1), QOBJECT(a2)), ==, 0);
+    g_assert_cmpint(qobject_compare(QOBJECT(i1), QOBJECT(i2)), ==, 0);
+    g_assert_cmpint(qobject_compare(QOBJECT(l1), QOBJECT(l2)), ==, 0);
+
+    g_assert_cmpint(qobject_compare(QOBJECT(a1), QOBJECT(b)), <, 0);
+    g_assert_cmpint(qobject_compare(QOBJECT(b), QOBJECT(a1)), >, 0);
+
+    g_assert_cmpint(qobject_compare(QOBJECT(i1), QOBJECT(j)), <, 0);
+    g_assert_cmpint(qobject_compare(QOBJECT(j), QOBJECT(i1)), >, 0);
+
+    g_assert_cmpint(qobject_compare(QOBJECT(l1), QOBJECT(m)), <, 0);
+    g_assert_cmpint(qobject_compare(QOBJECT(m), QOBJECT(l1)), >, 0);
+
+    g_assert_cmpint(qobject_compare(QOBJECT(a1), QOBJECT(i1)), !=, 0);
+    g_assert_cmpint(qobject_compare(QOBJECT(a1), QOBJECT(l1)), !=, 0);
+    g_assert_cmpint(qobject_compare(QOBJECT(l1), QOBJECT(i1)), !=, 0);
+
+    QDECREF(a1);
+    QDECREF(a2);
+    QDECREF(b);
+    QDECREF(i1);
+    QDECREF(i2);
+    QDECREF(j);
+    QDECREF(l1);
+    QDECREF(l2);
+    QDECREF(m);
+}
+
 int main(int argc, char *argv[])
 {
     g_test_init(&argc, &argv, NULL);
     g_test_add_func("/qapi/util/qapi_enum_parse", test_qapi_enum_parse);
     g_test_add_func("/qapi/util/parse_qapi_name", test_parse_qapi_name);
+    g_test_add_func("/qapi/util/qobject_compare", test_qobject_compare);
     g_test_run();
     return 0;
 }
-- 
2.9.4
