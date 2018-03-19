Received: from eggs.gnu.org ([2001:4830:134:3::10]:33836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1exrGi-00045c-F5
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1exrGh-0004AT-6I
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:39:52 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 19 Mar 2018 10:39:36 +0100
Message-Id: <1521452376-25099-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH] tests/device-introspect: Test devices with
 all machines, not only with "none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

Many device introspection crashes only happen if you are using a
certain machine, e.g.:

$ ppc-softmmu/qemu-system-ppc -S -M ref405ep,accel=qtest -qmp stdio
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 11, "major": 2},
 "package": "build-all"}, "capabilities": []}}
{ 'execute': 'qmp_capabilities' }
{"return": {}}
{ 'execute': 'device-list-properties',
  'arguments': {'typename': 'macio-newworld'}}
Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
Device 'serial0' is in use
Aborted (core dumped)

To be able to catch these problems, let's extend the device-introspect
test to check the devices on all machine types. Since this is a rather
slow operation, the test is only run in "SPEED=slow" mode.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 In case someone wants to help with creating some bug fix patches
 during the QEMU hard freeze phase: This test can now be used to
 trigger lots of introspection bugs that we were not aware of yet.
 I think most of the bugs are due to wrong handling of instance_init
 vs. realize functions.
 For Example:
 $ make check-qtest SPEED=slow
  GTESTER check-qtest-aarch64
 RAMBlock "integrator.flash" already registered, abort!
 Broken pipe
 GTester: last random seed: R02S8e52709605790d290d2c8261cefb8b0e
 Unsupported NIC model: lan9118
 Broken pipe
 GTester: last random seed: R02S326d4ea43bfce860ebe2d554192540f7
 qemu-system-aarch64: warning: nic lan9118.0 has no peer
 Unsupported NIC model: smc91c111
 Broken pipe
 GTester: last random seed: R02Se9783b450806f350a14e757b175e3dc4
 qemu-system-aarch64: missing SecureDigital device
 Broken pipe
 GTester: last random seed: R02S5c718b8f4c4fd48a358de8daafcf1b6f
 qemu-system-aarch64: warning: nic lan9118.0 has no peer
 Unexpected error in error_set_from_qdev_prop_error() at hw/core/qdev-properties.c:1095:
 Property 'allwinner-emac.netdev' can't take value 'hub0port0', it's in use
 Broken pipe
 GTester: last random seed: R02S597848ddcfdc76a695a946a9d4e50146
 qemu-system-aarch64: warning: nic ftgmac100.0 has no peer
 GTester: last random seed: R02Seea0f0b769a2161fa53a50479fd68d84
 qemu-system-aarch64: warning: nic imx.fec.0 has no peer
 qemu-system-aarch64: missing SecureDigital device
 Broken pipe
 GTester: last random seed: R02S9c2d3e34427162e7a56aa4ac859f1a6b
 Unsupported NIC model: virtio-net-pci
 Broken pipe
 GTester: last random seed: R02Sd61c0e9ed52d50a17c784213e5c6590c
 Unsupported NIC model: mv88w8618
 Broken pipe
 GTester: last random seed: R02Sbfaecfe58dd643f2faca218e3051d464
 qemu-system-aarch64: warning: nic mv88w8618_eth.0 has no peer
 qemu-system-aarch64: missing SecureDigital device
 Broken pipe
 Unsupported NIC model: xgmac
 Broken pipe
 GTester: last random seed: R02Sc61e65e884e364652c3a0c4190023565
 fsl,imx7: Only 2 CPUs are supported (4 requested)
 Broken pipe
 GTester: last random seed: R02S0cfda43bc17e3e052d5a994b2c96457b
 etc.

 tests/device-introspect-test.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
index b80058f..a9b9cf7 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -105,6 +105,8 @@ static void test_one_device(const char *type)
     QDict *resp;
     char *help, *qom_tree;
 
+    g_debug("Testing device '%s'", type);
+
     resp = qmp("{'execute': 'device-list-properties',"
                " 'arguments': {'typename': %s}}",
                type);
@@ -206,13 +208,13 @@ static void test_device_intro_abstract(void)
     qtest_end();
 }
 
-static void test_device_intro_concrete(void)
+static void test_device_intro_concrete(gconstpointer args)
 {
     QList *types;
     QListEntry *entry;
     const char *type;
 
-    qtest_start(common_args);
+    qtest_start((const char *)args);
     types = device_type_list(false);
 
     QLIST_FOREACH_ENTRY(types, entry) {
@@ -224,6 +226,7 @@ static void test_device_intro_concrete(void)
 
     QDECREF(types);
     qtest_end();
+    g_free((void *)args);
 }
 
 static void test_abstract_interfaces(void)
@@ -260,6 +263,26 @@ static void test_abstract_interfaces(void)
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
+    path = g_strdup_printf("device/introspect/concrete-defaults-%s", mname);
+    args = g_strdup_printf("-machine %s", mname);
+    qtest_add_data_func(path, args, test_device_intro_concrete);
+    g_free(path);
+
+    path = g_strdup_printf("device/introspect/concrete-nodefaults-%s", mname);
+    args = g_strdup_printf("-nodefaults -machine %s", mname);
+    qtest_add_data_func(path, args, test_device_intro_concrete);
+    g_free(path);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -268,8 +291,12 @@ int main(int argc, char **argv)
     qtest_add_func("device/introspect/list-fields", test_qom_list_fields);
     qtest_add_func("device/introspect/none", test_device_intro_none);
     qtest_add_func("device/introspect/abstract", test_device_intro_abstract);
-    qtest_add_func("device/introspect/concrete", test_device_intro_concrete);
     qtest_add_func("device/introspect/abstract-interfaces", test_abstract_interfaces);
+    qtest_add_data_func("device/introspect/concrete", g_strdup(common_args),
+                        test_device_intro_concrete);
+    if (g_test_slow()) {
+        qtest_cb_for_every_machine(add_machine_test_case);
+    }
 
     return g_test_run();
 }
-- 
1.8.3.1
