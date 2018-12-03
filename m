Received: from eggs.gnu.org ([2001:4830:134:3::10]:52346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFW-0001Kz-9n
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFV-0005h8-1y
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqFU-0005g4-NG
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:04 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:04 +0100
Message-Id: <1543851204-41186-52-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 51/71] qos-test: virtio-net test node
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

Convert tests/virtio-net-test in qgraph test node,
virtio-net-test. This test consumes a virtio-net interface
and checks that its function return the expected values.

Some functions are implemented only for virtio-net-pci, so they
don't consume virtio-net, but virtio-net-pci

Note that this test does not allocate any virtio-net structure,
it's all done by the qtest walking graph mechanism

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include  |   3 +-
 tests/virtio-net-test.c | 165 +++++++++++++++---------------------------------
 2 files changed, 53 insertions(+), 115 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 211c675..d300f60 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -143,7 +143,6 @@ check-qtest-generic-y += tests/cdrom-test$(EXESUF)
 
 check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
 
-check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-scsi-test$(EXESUF)
 
 check-qtest-pci-y += tests/e1000-test$(EXESUF)
@@ -690,6 +689,7 @@ qos-test-obj-y += tests/sdhci-test.o
 qos-test-obj-y += tests/virtio-test.o
 qos-test-obj-y += tests/virtio-9p-test.o
 qos-test-obj-y += tests/virtio-blk-test.o
+qos-test-obj-y += tests/virtio-net-test.o
 qos-test-obj-y += tests/virtio-rng-test.o
 qos-test-obj-y += tests/virtio-serial-test.o
 
@@ -737,7 +737,6 @@ tests/ne2000-test$(EXESUF): tests/ne2000-test.o
 tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
 tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
 tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
-tests/virtio-net-test$(EXESUF): tests/virtio-net-test.o $(libqos-pc-obj-y) $(libqos-virtio-obj-y)
 tests/virtio-scsi-test$(EXESUF): tests/virtio-scsi-test.o $(libqos-virtio-obj-y)
 tests/tpci200-test$(EXESUF): tests/tpci200-test.o
 tests/display-vga-test$(EXESUF): tests/display-vga-test.o
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index fa06d9b..c6550e1 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -9,18 +9,11 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "qemu-common.h"
-#include "qemu/sockets.h"
 #include "qemu/iov.h"
-#include "libqos/libqos-pc.h"
-#include "libqos/libqos-spapr.h"
-#include "libqos/virtio.h"
-#include "libqos/virtio-pci.h"
 #include "qapi/qmp/qdict.h"
-#include "qemu/bswap.h"
 #include "hw/virtio/virtio-net.h"
-#include "standard-headers/linux/virtio_ids.h"
-#include "standard-headers/linux/virtio_ring.h"
+#include "libqos/qgraph.h"
+#include "libqos/virtio-net.h"
 
 #define PCI_SLOT_HP             0x06
 #define PCI_SLOT                0x04
@@ -29,59 +22,8 @@
 #define QVIRTIO_NET_TIMEOUT_US (30 * 1000 * 1000)
 #define VNET_HDR_SIZE sizeof(struct virtio_net_hdr_mrg_rxbuf)
 
-static void test_end(void)
-{
-    qtest_end();
-}
-
 #ifndef _WIN32
 
-static QVirtioPCIDevice *virtio_net_pci_init(QPCIBus *bus, int slot)
-{
-    QVirtioPCIDevice *dev;
-
-    dev = qvirtio_pci_device_find(bus, VIRTIO_ID_NET);
-    g_assert(dev != NULL);
-    g_assert_cmphex(dev->vdev.device_type, ==, VIRTIO_ID_NET);
-
-    qvirtio_pci_device_enable(dev);
-    qvirtio_start_device(&dev->vdev);
-
-    return dev;
-}
-
-static QOSState *pci_test_start(int socket)
-{
-    QOSState *qs;
-    const char *arch = qtest_get_arch();
-    const char *cmd = "-netdev socket,fd=%d,id=hs0 -device "
-                      "virtio-net-pci,netdev=hs0";
-
-    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        qs = qtest_pc_boot(cmd, socket);
-    } else if (strcmp(arch, "ppc64") == 0) {
-        qs = qtest_spapr_boot(cmd, socket);
-    } else {
-        g_printerr("virtio-net tests are only available on x86 or ppc64\n");
-        exit(EXIT_FAILURE);
-    }
-    global_qtest = qs->qts;
-    return qs;
-}
-
-static void driver_init(QVirtioDevice *dev)
-{
-    uint32_t features;
-
-    features = qvirtio_get_features(dev);
-    features = features & ~(QVIRTIO_F_BAD_FEATURE |
-                            (1u << VIRTIO_RING_F_INDIRECT_DESC) |
-                            (1u << VIRTIO_RING_F_EVENT_IDX));
-    qvirtio_set_features(dev, features);
-
-    qvirtio_set_driver_ok(dev);
-}
-
 static void rx_test(QVirtioDevice *dev,
                     QGuestAllocator *alloc, QVirtQueue *vq,
                     int socket)
@@ -191,81 +133,78 @@ static void rx_stop_cont_test(QVirtioDevice *dev,
     guest_free(alloc, req_addr);
 }
 
-static void send_recv_test(QVirtioDevice *dev,
-                           QGuestAllocator *alloc, QVirtQueue *rvq,
-                           QVirtQueue *tvq, int socket)
+static void send_recv_test(void *obj, void *data, QGuestAllocator *t_alloc)
 {
-    rx_test(dev, alloc, rvq, socket);
-    tx_test(dev, alloc, tvq, socket);
+    QVirtioNet *net_if = obj;
+    QVirtioDevice *dev = net_if->vdev;
+    QVirtQueue *rx = net_if->rx;
+    QVirtQueue *tx = net_if->tx;
+    int *sv = data;
+
+    rx_test(dev, t_alloc, rx, sv[0]);
+    tx_test(dev, t_alloc, tx, sv[0]);
 }
 
-static void stop_cont_test(QVirtioDevice *dev,
-                           QGuestAllocator *alloc, QVirtQueue *rvq,
-                           QVirtQueue *tvq, int socket)
+static void stop_cont_test(void *obj, void *data, QGuestAllocator *t_alloc)
 {
-    rx_stop_cont_test(dev, alloc, rvq, socket);
+    QVirtioNet *net_if = obj;
+    QVirtioDevice *dev = net_if->vdev;
+    QVirtQueue *rx = net_if->rx;
+    int *sv = data;
+
+    rx_stop_cont_test(dev, t_alloc, rx, sv[0]);
 }
 
-static void pci_basic(gconstpointer data)
+#endif
+
+static void hotplug(void *obj, void *data, QGuestAllocator *t_alloc)
 {
-    QVirtioPCIDevice *dev;
-    QOSState *qs;
-    QVirtQueuePCI *tx, *rx;
-    void (*func) (QVirtioDevice *dev,
-                  QGuestAllocator *alloc,
-                  QVirtQueue *rvq,
-                  QVirtQueue *tvq,
-                  int socket) = data;
-    int sv[2], ret;
+    const char *arch = qtest_get_arch();
 
-    ret = socketpair(PF_UNIX, SOCK_STREAM, 0, sv);
-    g_assert_cmpint(ret, !=, -1);
+    qtest_qmp_device_add("virtio-net-pci", "net1",
+                         "{'addr': %s}", stringify(PCI_SLOT_HP));
 
-    qs = pci_test_start(sv[1]);
-    dev = virtio_net_pci_init(qs->pcibus, PCI_SLOT);
+    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        qpci_unplug_acpi_device_test("net1", PCI_SLOT_HP);
+    }
 
-    rx = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, &qs->alloc, 0);
-    tx = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, &qs->alloc, 1);
+}
 
-    driver_init(&dev->vdev);
-    func(&dev->vdev, &qs->alloc, &rx->vq, &tx->vq, sv[0]);
+static void virtio_net_test_cleanup(void *sockets)
+{
+    int *sv = sockets;
 
-    /* End test */
     close(sv[0]);
-    qvirtqueue_cleanup(dev->vdev.bus, &tx->vq, &qs->alloc);
-    qvirtqueue_cleanup(dev->vdev.bus, &rx->vq, &qs->alloc);
-    qvirtio_pci_device_disable(dev);
-    g_free(dev->pdev);
-    g_free(dev);
-    qtest_shutdown(qs);
+    qos_invalidate_command_line();
+    close(sv[1]);
+    g_free(sv);
 }
-#endif
 
-static void hotplug(void)
+static void *virtio_net_test_setup(GString *cmd_line, void *arg)
 {
-    const char *arch = qtest_get_arch();
-
-    qtest_start("-device virtio-net-pci");
+    int ret;
+    int *sv = g_new(int, 2);
 
-    qtest_qmp_device_add("virtio-net-pci", "net1",
-                         "{'addr': %s}", stringify(PCI_SLOT_HP));
+    ret = socketpair(PF_UNIX, SOCK_STREAM, 0, sv);
+    g_assert_cmpint(ret, !=, -1);
 
-    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        qpci_unplug_acpi_device_test("net1", PCI_SLOT_HP);
-    }
+    g_string_append_printf(cmd_line, " -netdev socket,fd=%d,id=hs0 ", sv[1]);
 
-    test_end();
+    g_test_queue_destroy(virtio_net_test_cleanup, sv);
+    return sv;
 }
 
-int main(int argc, char **argv)
+static void register_virtio_net_test(void)
 {
-    g_test_init(&argc, &argv, NULL);
+    QOSGraphTestOptions opts = {
+        .before = virtio_net_test_setup,
+    };
+
 #ifndef _WIN32
-    qtest_add_data_func("/virtio/net/pci/basic", send_recv_test, pci_basic);
-    qtest_add_data_func("/virtio/net/pci/rx_stop_cont",
-                        stop_cont_test, pci_basic);
+    qos_add_test("basic", "virtio-net", send_recv_test, &opts);
+    qos_add_test("rx_stop_cont", "virtio-net", stop_cont_test, &opts);
 #endif
-    qtest_add_func("/virtio/net/pci/hotplug", hotplug);
-
-    return g_test_run();
+    qos_add_test("hotplug", "virtio-pci", hotplug, &opts);
 }
+
+libqos_init(register_virtio_net_test);
-- 
1.8.3.1
