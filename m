Received: from eggs.gnu.org ([2001:4830:134:3::10]:52662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqGN-0002Om-UH
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:36:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqGM-0006dD-Re
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqGM-0006cb-KU
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:58 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:18 +0100
Message-Id: <1543851204-41186-66-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 65/71] qos-test: spapr-phb test node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>

From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Convert tests/spapr-phb-test to a qgraph test node,
spapr-phb-test. This test adds another
spapr-pci-host-bridge device in the
ppc64/pseries machine

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  3 +--
 tests/spapr-phb-test.c | 32 ++++++++++++++------------------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 351a729..9f19e31 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -217,7 +217,6 @@ check-qtest-ppc-y += tests/boot-serial-test$(EXESUF)
 check-qtest-ppc-y += tests/m48t59-test$(EXESUF)
 
 check-qtest-ppc64-y += $(check-qtest-ppc-y)
-check-qtest-ppc64-y += tests/spapr-phb-test$(EXESUF)
 check-qtest-ppc64-y += tests/pnv-xscom-test$(EXESUF)
 check-qtest-ppc64-y += tests/migration-test$(EXESUF)
 check-qtest-ppc64-y += tests/rtas-test$(EXESUF)
@@ -681,6 +680,7 @@ qos-test-obj-y += tests/nvme-test.o
 qos-test-obj-y += tests/pci-test.o
 qos-test-obj-y += tests/pcnet-test.o
 qos-test-obj-y += tests/sdhci-test.o
+qos-test-obj-y += tests/spapr-phb-test.o
 qos-test-obj-$(CONFIG_VHOST_NET_USER) += tests/vhost-user-test.o $(chardev-obj-y) $(test-io-obj-y)
 qos-test-obj-y += tests/virtio-test.o
 qos-test-obj-y += tests/virtio-9p-test.o
@@ -703,7 +703,6 @@ tests/rtc-test$(EXESUF): tests/rtc-test.o
 tests/m48t59-test$(EXESUF): tests/m48t59-test.o
 tests/hexloader-test$(EXESUF): tests/hexloader-test.o
 tests/endianness-test$(EXESUF): tests/endianness-test.o
-tests/spapr-phb-test$(EXESUF): tests/spapr-phb-test.o $(libqos-obj-y)
 tests/prom-env-test$(EXESUF): tests/prom-env-test.o $(libqos-obj-y)
 tests/rtas-test$(EXESUF): tests/rtas-test.o $(libqos-spapr-obj-y)
 tests/fdc-test$(EXESUF): tests/fdc-test.o
diff --git a/tests/spapr-phb-test.c b/tests/spapr-phb-test.c
index d3522ea..39b5766 100644
--- a/tests/spapr-phb-test.c
+++ b/tests/spapr-phb-test.c
@@ -7,29 +7,25 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
-#include "qemu/osdep.h"
 
+#include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/qgraph.h"
 
-#define TYPE_SPAPR_PCI_HOST_BRIDGE "spapr-pci-host-bridge"
-
-/* Tests only initialization so far. TODO: Replace with functional tests */
-static void test_phb_device(void)
+/* Tests only initialization so far. TODO: Replace with functional tests,
+ * for example by producing pci-bus.
+ */
+static void test_phb_device(void *obj, void *data, QGuestAllocator *alloc)
 {
 }
 
-int main(int argc, char **argv)
+static void register_phb_test(void)
 {
-    int ret;
-
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/spapr-phb/device", test_phb_device);
-
-    qtest_start("-device " TYPE_SPAPR_PCI_HOST_BRIDGE ",index=30");
-
-    ret = g_test_run();
-
-    qtest_end();
-
-    return ret;
+    qos_add_test("spapr-phb-test", "ppc64/pseries",
+                 test_phb_device, &(QOSGraphTestOptions) {
+                     .edge.before_cmd_line = "-device spapr-pci-host-bridge"
+                                             ",index=30",
+                 });
 }
+
+libqos_init(register_phb_test);
-- 
1.8.3.1
