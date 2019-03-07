Received: from eggs.gnu.org ([209.51.188.92]:39713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wr1-0003SS-4n
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqz-0008Hv-W0
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:47 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wqz-0008GN-NA
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:45 -0500
Received: by mail-wm1-x343.google.com with SMTP id n19so10054307wmi.1
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:44 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:40 +0100
Message-Id: <1551979804-6060-34-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 33/57] qos-test: virtio-rng test node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lviver@redhat.com, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Convert tests/virtio-rng-test in qgraph test node,
virtio-rng-test. This test consumes a virtio-rng interface
and checks that its function return the expected values.

Some functions are implemented only for virtio-rng-pci, so they
don't consume virtio-rng, but virtio-rng-pci

Note that this test does not allocate any virtio-rng structure,
it's all done by the qtest walking graph mechanism

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include  |  3 +--
 tests/virtio-rng-test.c | 27 +++++++--------------------
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2d2817e..ebf2212 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -155,7 +155,6 @@ check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
 
 check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
-check-qtest-virtio-y += tests/virtio-rng-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-scsi-test$(EXESUF)
 
 check-qtest-pci-y += tests/e1000-test$(EXESUF)
@@ -764,6 +763,7 @@ qos-test-obj-y += tests/pci-test.o
 qos-test-obj-y += tests/sdhci-test.o
 qos-test-obj-y += tests/virtio-test.o
 qos-test-obj-$(CONFIG_VIRTFS) += tests/virtio-9p-test.o
+qos-test-obj-y += tests/virtio-rng-test.o
 qos-test-obj-y += tests/virtio-serial-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
@@ -813,7 +813,6 @@ tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
 tests/virtio-blk-test$(EXESUF): tests/virtio-blk-test.o $(libqos-virtio-obj-y)
 tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
 tests/virtio-net-test$(EXESUF): tests/virtio-net-test.o $(libqos-pc-obj-y) $(libqos-virtio-obj-y)
-tests/virtio-rng-test$(EXESUF): tests/virtio-rng-test.o $(libqos-pc-obj-y)
 tests/virtio-scsi-test$(EXESUF): tests/virtio-scsi-test.o $(libqos-virtio-obj-y)
 tests/tpci200-test$(EXESUF): tests/tpci200-test.o
 tests/display-vga-test$(EXESUF): tests/display-vga-test.o
diff --git a/tests/virtio-rng-test.c b/tests/virtio-rng-test.c
index 657d9a4..5309c7c 100644
--- a/tests/virtio-rng-test.c
+++ b/tests/virtio-rng-test.c
@@ -9,16 +9,12 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/pci.h"
+#include "libqos/qgraph.h"
+#include "libqos/virtio-rng.h"
 
 #define PCI_SLOT_HP             0x06
 
-/* Tests only initialization so far. TODO: Replace with functional tests */
-static void pci_nop(void)
-{
-}
-
-static void hotplug(void)
+static void rng_hotplug(void *obj, void *data, QGuestAllocator *alloc)
 {
     const char *arch = qtest_get_arch();
 
@@ -30,18 +26,9 @@ static void hotplug(void)
     }
 }
 
-int main(int argc, char **argv)
+static void register_virtio_rng_test(void)
 {
-    int ret;
-
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/virtio/rng/pci/nop", pci_nop);
-    qtest_add_func("/virtio/rng/pci/hotplug", hotplug);
-
-    qtest_start("-device virtio-rng-pci");
-    ret = g_test_run();
-
-    qtest_end();
-
-    return ret;
+    qos_add_test("hotplug", "virtio-rng-pci", rng_hotplug, NULL);
 }
+
+libqos_init(register_virtio_rng_test);
-- 
1.8.3.1
