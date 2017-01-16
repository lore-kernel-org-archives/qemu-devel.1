Received: from eggs.gnu.org ([2001:4830:134:3::10]:57880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAct-0000gU-J7
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAcs-0008U3-N2
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTAcs-0008Tv-Ex
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:22 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A3498553D
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 16:59:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Jan 2017 17:58:47 +0100
Message-Id: <20170116165916.8575-4-pbonzini@redhat.com>
In-Reply-To: <20170116165916.8575-1-pbonzini@redhat.com>
References: <20170116165916.8575-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/32] qom: Make all interface types abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>

From: Eduardo Habkost <ehabkost@redhat.com>

"qom-list-types abstract=false" currently returns all interface
types, as if they were not abstract. Fix this by making sure all
interface types are abstract.

All interface types have instance_size == 0, so we can use
it to set abstract=true on type_initialize().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <1481567461-2341-1-git-send-email-ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c                   |  6 +++++
 tests/device-introspect-test.c | 60 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 7a05e35..760fafb 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -272,6 +272,12 @@ static void type_initialize(TypeImpl *ti)
 
     ti->class_size = type_class_get_size(ti);
     ti->instance_size = type_object_get_size(ti);
+    /* Any type with zero instance_size is implicitly abstract.
+     * This means interface types are all abstract.
+     */
+    if (ti->instance_size == 0) {
+        ti->abstract = true;
+    }
 
     ti->class = g_malloc0(ti->class_size);
 
diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
index 37debc1..c5637cc 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -20,18 +20,24 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/qmp/qstring.h"
+#include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
 #include "libqtest.h"
 
 const char common_args[] = "-nodefaults -machine none";
 
-static QList *device_type_list(bool abstract)
+static QList *qom_list_types(const char *implements, bool abstract)
 {
     QDict *resp;
     QList *ret;
+    QDict *args = qdict_new();
 
+    qdict_put(args, "abstract", qbool_from_bool(abstract));
+    if (implements) {
+        qdict_put(args, "implements", qstring_from_str(implements));
+    }
     resp = qmp("{'execute': 'qom-list-types',"
-               " 'arguments': {'implements': 'device', 'abstract': %i}}",
-               abstract);
+               " 'arguments': %p }", args);
     g_assert(qdict_haskey(resp, "return"));
     ret = qdict_get_qlist(resp, "return");
     QINCREF(ret);
@@ -39,6 +45,11 @@ static QList *device_type_list(bool abstract)
     return ret;
 }
 
+static QList *device_type_list(bool abstract)
+{
+    return qom_list_types("device", abstract);
+}
+
 static void test_one_device(const char *type)
 {
     QDict *resp;
@@ -110,6 +121,48 @@ static void test_device_intro_concrete(void)
     qtest_end();
 }
 
+static void test_abstract_interfaces(void)
+{
+    QList *all_types;
+    QList *obj_types;
+    QListEntry *ae;
+
+    qtest_start(common_args);
+    /* qom-list-types implements=interface would return any type
+     * that implements _any_ interface (not just interface types),
+     * so use a trick to find the interface type names:
+     * - list all object types
+     * - list all types, and look for items that are not
+     *   on the first list
+     */
+    all_types = qom_list_types(NULL, false);
+    obj_types = qom_list_types("object", false);
+
+    QLIST_FOREACH_ENTRY(all_types, ae) {
+        QDict *at = qobject_to_qdict(qlist_entry_obj(ae));
+        const char *aname = qdict_get_str(at, "name");
+        QListEntry *oe;
+        const char *found = NULL;
+
+        QLIST_FOREACH_ENTRY(obj_types, oe) {
+            QDict *ot = qobject_to_qdict(qlist_entry_obj(oe));
+            const char *oname = qdict_get_str(ot, "name");
+            if (!strcmp(aname, oname)) {
+                found = oname;
+                break;
+            }
+        }
+
+        /* Using g_assert_cmpstr() will give more useful failure
+         * messages than g_assert(found) */
+        g_assert_cmpstr(aname, ==, found);
+    }
+
+    QDECREF(all_types);
+    QDECREF(obj_types);
+    qtest_end();
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -118,6 +171,7 @@ int main(int argc, char **argv)
     qtest_add_func("device/introspect/none", test_device_intro_none);
     qtest_add_func("device/introspect/abstract", test_device_intro_abstract);
     qtest_add_func("device/introspect/concrete", test_device_intro_concrete);
+    qtest_add_func("device/introspect/abstract-interfaces", test_abstract_interfaces);
 
     return g_test_run();
 }
-- 
2.9.3
