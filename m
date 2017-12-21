Received: from eggs.gnu.org ([2001:4830:134:3::10]:45874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1qd-0007vD-8T
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1qZ-0005gX-6Y
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS1qY-0005fz-Uc
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:19 -0500
Date: Thu, 21 Dec 2017 16:29:16 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-13-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 12/25] tests/pxe-test: Use table of testcases
 rather than open-coding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: David Gibson <david@gibson.dropbear.id.au>

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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/pxe-test.c | 86 +++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 64 insertions(+), 22 deletions(-)

diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index eb70aa2..4758ce7 100644
--- a/tests/pxe-test.c
+++ b/tests/pxe-test.c
@@ -22,14 +22,51 @@
 
 static char disk[] = "tests/pxe-test-disk-XXXXXX";
 
-static void test_pxe_one(const char *params, bool ipv6)
+typedef struct testdef {
+    const char *machine;    /* Machine type */
+    const char *model;      /* NIC device model */
+} testdef_t;
+
+static testdef_t x86_tests[] = {
+    { "pc", "e1000" },
+    { "pc", "virtio-net-pci" },
+    { NULL },
+};
+
+static testdef_t x86_tests_slow[] = {
+    { "pc", "ne2k_pci", },
+    { "pc", "i82550", },
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
+    { "pseries", "virtio-net-pci", },
+    { "pseries", "e1000" },
+    { NULL },
+};
+
+static testdef_t s390x_tests[] = {
+    { "s390-ccw-virtio", "virtio-net-ccw" },
+    { NULL },
+};
+
+static void test_pxe_one(const testdef_t *test, bool ipv6)
 {
     char *args;
 
-    args = g_strdup_printf("-machine accel=kvm:tcg -nodefaults -boot order=n "
-                           "-netdev user,id=" NETNAME ",tftp=./,bootfile=%s,"
-                           "ipv4=%s,ipv6=%s %s", disk, ipv6 ? "off" : "on",
-                           ipv6 ? "on" : "off", params);
+    args = g_strdup_printf(
+        "-machine %s,accel=kvm:tcg -nodefaults -boot order=n "
+        "-netdev user,id=" NETNAME ",tftp=./,bootfile=%s,ipv4=%s,ipv6=%s "
+        "-device %s,bootindex=1,netdev=" NETNAME,
+        test->machine, disk, ipv6 ? "off" : "on", ipv6 ? "on" : "off",
+        test->model);
 
     qtest_start(args);
     boot_sector_test();
@@ -39,12 +76,24 @@ static void test_pxe_one(const char *params, bool ipv6)
 
 static void test_pxe_ipv4(gconstpointer data)
 {
-    const char *model = data;
-    char *dev_arg;
+    const testdef_t *test = data;
 
-    dev_arg = g_strdup_printf("-device %s,netdev=" NETNAME, model);
-    test_pxe_one(dev_arg, false);
-    g_free(dev_arg);
+    test_pxe_one(test, false);
+}
+
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
@@ -59,24 +108,17 @@ int main(int argc, char *argv[])
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
MST
