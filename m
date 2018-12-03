Received: from eggs.gnu.org ([2001:4830:134:3::10]:52261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFH-00011m-Tm
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFE-0005MZ-Df
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqFE-0005LZ-5D
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:48 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:00 +0100
Message-Id: <1543851204-41186-48-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 47/71] qos-test: virtio-rng test node
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
index 00ca6e8..a7c01a3 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -145,7 +145,6 @@ check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
 
 check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
-check-qtest-virtio-y += tests/virtio-rng-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-scsi-test$(EXESUF)
 
 check-qtest-pci-y += tests/e1000-test$(EXESUF)
@@ -690,6 +689,7 @@ qos-test-obj-y += tests/pci-test.o
 qos-test-obj-y += tests/sdhci-test.o
 qos-test-obj-y += tests/virtio-test.o
 qos-test-obj-y += tests/virtio-9p-test.o
+qos-test-obj-y += tests/virtio-rng-test.o
 qos-test-obj-y += tests/virtio-serial-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
@@ -738,7 +738,6 @@ tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
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
