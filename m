Received: from eggs.gnu.org ([2001:4830:134:3::10]:45202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgL-000331-AK
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgK-0003Ib-3j
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:37 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cROgJ-0003HX-SU
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:36 -0500
Received: by mail-wm0-x242.google.com with SMTP id r126so311495wmr.3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:35:35 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:34:57 +0100
Message-Id: <1484163327-111841-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/33] qom: Make all interface types abstract
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
1.8.3.1
