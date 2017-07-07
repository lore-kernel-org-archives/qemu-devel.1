Received: from eggs.gnu.org ([2001:4830:134:3::10]:36955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTSHG-00009t-Rq
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTSHD-00060Z-Bt
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dTSHD-0005zl-3N
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D4CCB8153
	for <qemu-devel@nongnu.org>; Fri,  7 Jul 2017 12:22:26 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  7 Jul 2017 09:22:13 -0300
Message-Id: <20170707122215.8819-2-ehabkost@redhat.com>
In-Reply-To: <20170707122215.8819-1-ehabkost@redhat.com>
References: <20170707122215.8819-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/3] tests: Simplify abstract-interfaces
 check with a helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

Add a new type_list_find() helper to device-introspect-test.c, to
simplify the code at test_abstract_interfaces().

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v2 -> v3:
* None, rebase only.

Changes v1 -> v2:
* (none)
---
 tests/device-introspect-test.c | 43 ++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
index b1abb2a..f1e6ddd 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -45,6 +45,22 @@ static QList *qom_list_types(const char *implements, bool abstract)
     return ret;
 }
 
+/* Find an entry on a list returned by qom-list-types */
+static QDict *type_list_find(QList *types, const char *name)
+{
+    QListEntry *e;
+
+    QLIST_FOREACH_ENTRY(types, e) {
+        QDict *d = qobject_to_qdict(qlist_entry_obj(e));
+        const char *ename = qdict_get_str(d, "name");
+        if (!strcmp(ename, name)) {
+            return d;
+        }
+    }
+
+    return NULL;
+}
+
 static QList *device_type_list(bool abstract)
 {
     return qom_list_types("device", abstract);
@@ -125,7 +141,7 @@ static void test_abstract_interfaces(void)
 {
     QList *all_types;
     QList *obj_types;
-    QListEntry *ae;
+    QListEntry *e;
 
     qtest_start(common_args);
     /* qom-list-types implements=interface would return any type
@@ -138,24 +154,15 @@ static void test_abstract_interfaces(void)
     all_types = qom_list_types(NULL, false);
     obj_types = qom_list_types("object", false);
 
-    QLIST_FOREACH_ENTRY(all_types, ae) {
-        QDict *at = qobject_to_qdict(qlist_entry_obj(ae));
-        const char *aname = qdict_get_str(at, "name");
-        QListEntry *oe;
-        const char *found = NULL;
-
-        QLIST_FOREACH_ENTRY(obj_types, oe) {
-            QDict *ot = qobject_to_qdict(qlist_entry_obj(oe));
-            const char *oname = qdict_get_str(ot, "name");
-            if (!strcmp(aname, oname)) {
-                found = oname;
-                break;
-            }
-        }
+    QLIST_FOREACH_ENTRY(all_types, e) {
+        QDict *d = qobject_to_qdict(qlist_entry_obj(e));
+
+        /*
+         * An interface (incorrectly) marked as non-abstract would
+         * appear on all_types, but not on obj_types:
+         */
+        g_assert(type_list_find(obj_types, qdict_get_str(d, "name")));
 
-        /* Using g_assert_cmpstr() will give more useful failure
-         * messages than g_assert(found) */
-        g_assert_cmpstr(aname, ==, found);
     }
 
     QDECREF(all_types);
-- 
2.9.4
