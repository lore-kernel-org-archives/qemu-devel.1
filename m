Received: from eggs.gnu.org ([2001:4830:134:3::10]:59310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqGZo-0001LO-0y
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 07:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqGZl-0003Tq-Nq
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 07:36:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59540 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fqGZh-0003Qs-1L
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 07:36:22 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 16 Aug 2018 13:35:57 +0200
Message-Id: <1534419358-10932-8-git-send-email-thuth@redhat.com>
In-Reply-To: <1534419358-10932-1-git-send-email-thuth@redhat.com>
References: <1534419358-10932-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 7/8] tests/device-introspect: Test with all
 machines, not only with "none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

Certain device introspection crashes used to only happen if you were
using a certain machine, e.g. if the machine was using serial_hd() or
nd_table[], and a device was trying to use these in its instance_init
function, too.

To be able to catch these problems, let's extend the device-introspect
test to check the devices on all machine types, with and without the
"-nodefaults" parameter (since this makes a difference sometimes, too).
Since this is a rather slow operation, and most of the problems are
already handled by testing with the "none" machine only, the test with
all machines is only run in the "make check SPEED=slow" mode.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/device-introspect-test.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
index a38193b..a25092d 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -221,13 +221,13 @@ static void test_device_intro_abstract(void)
     qtest_end();
 }
 
-static void test_device_intro_concrete(void)
+static void test_device_intro_concrete(const void *args)
 {
     QList *types;
     QListEntry *entry;
     const char *type;
 
-    qtest_start(common_args);
+    qtest_start(args);
     types = device_type_list(false);
 
     QLIST_FOREACH_ENTRY(types, entry) {
@@ -239,6 +239,7 @@ static void test_device_intro_concrete(void)
 
     qobject_unref(types);
     qtest_end();
+    g_free((void *)args);
 }
 
 static void test_abstract_interfaces(void)
@@ -275,6 +276,26 @@ static void test_abstract_interfaces(void)
     qtest_end();
 }
 
+static void add_machine_test_case(const char *mname)
+{
+    char *path, *args;
+
+    /* Ignore blacklisted machines */
+    if (g_str_equal("xenfv", mname) || g_str_equal("xenpv", mname)) {
+        return;
+    }
+
+    path = g_strdup_printf("device/introspect/concrete/defaults/%s", mname);
+    args = g_strdup_printf("-M %s", mname);
+    qtest_add_data_func(path, args, test_device_intro_concrete);
+    g_free(path);
+
+    path = g_strdup_printf("device/introspect/concrete/nodefaults/%s", mname);
+    args = g_strdup_printf("-nodefaults -M %s", mname);
+    qtest_add_data_func(path, args, test_device_intro_concrete);
+    g_free(path);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -283,8 +304,13 @@ int main(int argc, char **argv)
     qtest_add_func("device/introspect/list-fields", test_qom_list_fields);
     qtest_add_func("device/introspect/none", test_device_intro_none);
     qtest_add_func("device/introspect/abstract", test_device_intro_abstract);
-    qtest_add_func("device/introspect/concrete", test_device_intro_concrete);
     qtest_add_func("device/introspect/abstract-interfaces", test_abstract_interfaces);
+    if (g_test_quick()) {
+        qtest_add_data_func("device/introspect/concrete/defaults/none",
+                            g_strdup(common_args), test_device_intro_concrete);
+    } else {
+        qtest_cb_for_every_machine(add_machine_test_case, true);
+    }
 
     return g_test_run();
 }
-- 
1.8.3.1
