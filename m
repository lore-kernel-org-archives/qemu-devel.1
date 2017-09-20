Received: from eggs.gnu.org ([2001:4830:134:3::10]:49461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dufPw-0007HN-95
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dufPt-0004aN-7O
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:51:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dufPs-0004Zx-Um
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:51:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D91E81E1E
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 09:02:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 20 Sep 2017 11:02:07 +0200
Message-Id: <1505898127-5914-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] tests/pxe: Test more NICs when running in
 SPEED=slow mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Victor Kaplansky <victork@redhat.com>

The pxe-test is a very good test to excercise NICs, thus we should use
it to test all NICs that can be used by the BIOS for booting via network.
However, to avoid that the default testing time increases too much, the
additional NICs are only tested in the "make check SPEED=slow" mode.

The virtio-net NIC on ppc64 is now also only tested in slow mode, since
the test on ppc64 is really quite slow and we've got test coverage for
virtio-net in big endian mode now on s390x, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/pxe-test.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index 0d70afc..937f29e 100644
--- a/tests/pxe-test.c
+++ b/tests/pxe-test.c
@@ -1,11 +1,12 @@
 /*
  * PXE test cases.
  *
- * Copyright (c) 2016 Red Hat Inc.
+ * Copyright (c) 2016, 2017 Red Hat Inc.
  *
  * Authors:
  *  Michael S. Tsirkin <mst@redhat.com>,
  *  Victor Kaplansky <victork@redhat.com>
+ *  Thomas Huth <thuth@redhat.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
@@ -36,14 +37,14 @@ static void test_pxe_one(const char *params, bool ipv6)
     g_free(args);
 }
 
-static void test_pxe_e1000(void)
+static void test_pxe_ipv4(gconstpointer data)
 {
-    test_pxe_one("-device e1000,netdev=" NETNAME, false);
-}
+    const char *model = data;
+    char *dev_arg;
 
-static void test_pxe_virtio_pci(void)
-{
-    test_pxe_one("-device virtio-net-pci,netdev=" NETNAME, false);
+    dev_arg = g_strdup_printf("-device %s,netdev=" NETNAME, model);
+    test_pxe_one(dev_arg, false);
+    g_free(dev_arg);
 }
 
 static void test_pxe_spapr_vlan(void)
@@ -68,11 +69,21 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        qtest_add_func("pxe/e1000", test_pxe_e1000);
-        qtest_add_func("pxe/virtio", test_pxe_virtio_pci);
+        qtest_add_data_func("pxe/e1000", "e1000", test_pxe_ipv4);
+        qtest_add_data_func("pxe/virtio", "virtio-net-pci", test_pxe_ipv4);
+        if (g_test_slow()) {
+            qtest_add_data_func("pxe/ne2000", "ne2k_pci", test_pxe_ipv4);
+            qtest_add_data_func("pxe/eepro100", "i82550", test_pxe_ipv4);
+            qtest_add_data_func("pxe/pcnet", "pcnet", test_pxe_ipv4);
+            qtest_add_data_func("pxe/rtl8139", "rtl8139", test_pxe_ipv4);
+            qtest_add_data_func("pxe/vmxnet3", "vmxnet3", test_pxe_ipv4);
+        }
     } else if (strcmp(arch, "ppc64") == 0) {
-        qtest_add_func("pxe/virtio", test_pxe_virtio_pci);
         qtest_add_func("pxe/spapr-vlan", test_pxe_spapr_vlan);
+        if (g_test_slow()) {
+            qtest_add_data_func("pxe/virtio", "virtio-net-pci", test_pxe_ipv4);
+            qtest_add_data_func("pxe/e1000", "e1000", test_pxe_ipv4);
+        }
     } else if (g_str_equal(arch, "s390x")) {
         qtest_add_func("pxe/virtio-ccw", test_pxe_virtio_ccw);
     }
-- 
1.8.3.1
