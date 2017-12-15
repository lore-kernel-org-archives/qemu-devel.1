Received: from eggs.gnu.org ([2001:4830:134:3::10]:58760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePn37-0000pQ-W6
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:17:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePn33-0007BT-Vb
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:17:01 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Dec 2017 21:16:49 +1100
Message-Id: <20171215101651.13911-3-david@gibson.dropbear.id.au>
In-Reply-To: <20171215101651.13911-1-david@gibson.dropbear.id.au>
References: <20171215101651.13911-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 2/4] tests/pxe-test: Use table of testcases
 rather than open-coding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: thuth@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Currently pxe-tests open codes the list of tests for each architecture.
This changes it to use tables of test parameters, somewhat similar to
boot-serial-test.

This adds the machine type into the table as well, giving us the ability
to perform tests on multiple machine types for architectures where there's
more than one machine type that matters.

NOTE: This changes the names of the tests in the output, to include the
      machine type and IPv4 vs. IPv6.  I'm not sure if this has the
      potential to break existing tooling.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/pxe-test.c | 94 +++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 72 insertions(+), 22 deletions(-)

diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index eb70aa2bc6..f9bca8976d 100644
--- a/tests/pxe-test.c
+++ b/tests/pxe-test.c
@@ -22,29 +22,86 @@
 
 static char disk[] = "tests/pxe-test-disk-XXXXXX";
 
-static void test_pxe_one(const char *params, bool ipv6)
+typedef struct testdef {
+    const char *machine;    /* Machine type */
+    const char *model;      /* NIC device model (human readable)*/
+    const char *extra;      /* Extra parameters, overriding default */
+} testdef_t;
+
+static testdef_t x86_tests[] = {
+    { "pc", "e1000" },
+    { "pc", "virtio", "-device virtio-net-pci,netdev=" NETNAME },
+    { NULL },
+};
+
+static testdef_t x86_tests_slow[] = {
+    { "pc", "ne2000", "-device ne2k_pci,netdev=" NETNAME },
+    { "pc", "eepro100", "-device i82550,netdev=" NETNAME },
+    { "pc", "rtl8139" },
+    { "pc", "vmxnet3" },
+    { NULL },
+};
+
+static testdef_t ppc64_tests[] = {
+    { "pseries", "spapr-vlan" },
+    { NULL },
+};
+
+static testdef_t ppc64_tests_slow[] = {
+    { "pseries", "virtio", "-device virtio-net-pci,netdev=" NETNAME },
+    { "pseries", "e1000" },
+    { NULL },
+};
+
+static testdef_t s390x_tests[] = {
+    { "s390-ccw-virtio", "virtio-ccw",
+      "-device virtio-net-ccw,bootindex=1,netdev=" NETNAME },
+    { NULL },
+};
+
+static void test_pxe_one(const testdef_t *test, bool ipv6)
 {
     char *args;
+    char *defextra;
+    const char *extra = test->extra;
+
+    defextra = g_strdup_printf("-device %s,netdev=" NETNAME, test->model);
+    if (!extra) {
+        extra = defextra;
+    }
 
-    args = g_strdup_printf("-machine accel=kvm:tcg -nodefaults -boot order=n "
-                           "-netdev user,id=" NETNAME ",tftp=./,bootfile=%s,"
-                           "ipv4=%s,ipv6=%s %s", disk, ipv6 ? "off" : "on",
-                           ipv6 ? "on" : "off", params);
+    args = g_strdup_printf(
+        "-machine %s,accel=kvm:tcg -nodefaults -boot order=n "
+        "-netdev user,id=" NETNAME ",tftp=./,bootfile=%s,ipv4=%s,ipv6=%s %s",
+        test->machine, disk, ipv6 ? "off" : "on", ipv6 ? "on" : "off", extra);
 
     qtest_start(args);
     boot_sector_test();
     qtest_quit(global_qtest);
     g_free(args);
+    g_free(defextra);
 }
 
 static void test_pxe_ipv4(gconstpointer data)
 {
-    const char *model = data;
-    char *dev_arg;
+    const testdef_t *test = data;
+
+    test_pxe_one(test, false);
+}
 
-    dev_arg = g_strdup_printf("-device %s,netdev=" NETNAME, model);
-    test_pxe_one(dev_arg, false);
-    g_free(dev_arg);
+static void test_batch(const testdef_t *tests)
+{
+    int i;
+
+    for (i = 0; tests[i].machine; i++) {
+        const testdef_t *test = &tests[i];
+        char *testname;
+
+        testname = g_strdup_printf("pxe/ipv4/%s/%s",
+                                   test->machine, test->model);
+        qtest_add_data_func(testname, test, test_pxe_ipv4);
+        g_free(testname);
+    }
 }
 
 int main(int argc, char *argv[])
@@ -59,24 +116,17 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        qtest_add_data_func("pxe/e1000", "e1000", test_pxe_ipv4);
-        qtest_add_data_func("pxe/virtio", "virtio-net-pci", test_pxe_ipv4);
+        test_batch(x86_tests);
         if (g_test_slow()) {
-            qtest_add_data_func("pxe/ne2000", "ne2k_pci", test_pxe_ipv4);
-            qtest_add_data_func("pxe/eepro100", "i82550", test_pxe_ipv4);
-            qtest_add_data_func("pxe/pcnet", "pcnet", test_pxe_ipv4);
-            qtest_add_data_func("pxe/rtl8139", "rtl8139", test_pxe_ipv4);
-            qtest_add_data_func("pxe/vmxnet3", "vmxnet3", test_pxe_ipv4);
+            test_batch(x86_tests_slow);
         }
     } else if (strcmp(arch, "ppc64") == 0) {
-        qtest_add_data_func("pxe/spapr-vlan", "spapr-vlan", test_pxe_ipv4);
+        test_batch(ppc64_tests);
         if (g_test_slow()) {
-            qtest_add_data_func("pxe/virtio", "virtio-net-pci", test_pxe_ipv4);
-            qtest_add_data_func("pxe/e1000", "e1000", test_pxe_ipv4);
+            test_batch(ppc64_tests_slow);
         }
     } else if (g_str_equal(arch, "s390x")) {
-        qtest_add_data_func("pxe/virtio-ccw",
-                            "virtio-net-ccw,bootindex=1", test_pxe_ipv4);
+        test_batch(s390x_tests);
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
-- 
2.14.3
