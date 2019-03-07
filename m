Received: from eggs.gnu.org ([209.51.188.92]:39774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wr4-0003WV-Fh
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wr2-0008LB-Vg
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:50 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wr2-0008KN-J7
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:48 -0500
Received: by mail-wm1-x343.google.com with SMTP id f65so10068740wma.2
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:48 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:44 +0100
Message-Id: <1551979804-6060-38-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 37/57] qos-test: virtio-net test node
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
 tests/virtio-net-test.c | 224 ++++++++++++++++--------------------------------
 2 files changed, 75 insertions(+), 152 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ec23364..f45d115 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -153,7 +153,6 @@ check-qtest-generic-y += tests/cdrom-test$(EXESUF)
 
 check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
 
-check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-scsi-test$(EXESUF)
 
 check-qtest-pci-y += tests/e1000-test$(EXESUF)
@@ -764,6 +763,7 @@ qos-test-obj-y += tests/sdhci-test.o
 qos-test-obj-y += tests/virtio-test.o
 qos-test-obj-$(CONFIG_VIRTFS) += tests/virtio-9p-test.o
 qos-test-obj-y += tests/virtio-blk-test.o
+qos-test-obj-y += tests/virtio-net-test.o
 qos-test-obj-y += tests/virtio-rng-test.o
 qos-test-obj-y += tests/virtio-serial-test.o
 
@@ -812,7 +812,6 @@ tests/ne2000-test$(EXESUF): tests/ne2000-test.o
 tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
 tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
 tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
-tests/virtio-net-test$(EXESUF): tests/virtio-net-test.o $(libqos-pc-obj-y) $(libqos-virtio-obj-y)
 tests/virtio-scsi-test$(EXESUF): tests/virtio-scsi-test.o $(libqos-virtio-obj-y)
 tests/tpci200-test$(EXESUF): tests/tpci200-test.o
 tests/display-vga-test$(EXESUF): tests/display-vga-test.o
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 653148e..2d3630c 100644
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
@@ -28,63 +21,8 @@
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
-GCC_FMT_ATTR(1, 2)
-static QOSState *pci_test_start(const char *cmd, ...)
-{
-    QOSState *qs;
-    va_list ap;
-    const char *arch = qtest_get_arch();
-
-    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        va_start(ap, cmd);
-        qs = qtest_pc_vboot(cmd, ap);
-        va_end(ap);
-    } else if (strcmp(arch, "ppc64") == 0) {
-        va_start(ap, cmd);
-        qs = qtest_spapr_vboot(cmd, ap);
-        va_end(ap);
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
@@ -194,128 +132,114 @@ static void rx_stop_cont_test(QVirtioDevice *dev,
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
-{
-    QVirtioPCIDevice *dev;
-    QOSState *qs;
-    QVirtQueuePCI *tx, *rx;
-    void (*func) (QVirtioDevice *dev,
-                  QGuestAllocator *alloc,
-                  QVirtQueue *rvq,
-                  QVirtQueue *tvq,
-                  int socket) = data;
-    int sv[2], ret;
+#endif
 
-    ret = socketpair(PF_UNIX, SOCK_STREAM, 0, sv);
-    g_assert_cmpint(ret, !=, -1);
+static void hotplug(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    const char *arch = qtest_get_arch();
 
-    qs = pci_test_start("-netdev socket,fd=%d,id=hs0 -device "
-                        "virtio-net-pci,netdev=hs0", sv[1]);
-    dev = virtio_net_pci_init(qs->pcibus, PCI_SLOT);
+    qtest_qmp_device_add("virtio-net-pci", "net1",
+                         "{'addr': %s}", stringify(PCI_SLOT_HP));
 
-    rx = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, &qs->alloc, 0);
-    tx = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, &qs->alloc, 1);
+    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        qpci_unplug_acpi_device_test("net1", PCI_SLOT_HP);
+    }
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
+}
+
+static void *virtio_net_test_setup(GString *cmd_line, void *arg)
+{
+    int ret;
+    int *sv = g_new(int, 2);
+
+    ret = socketpair(PF_UNIX, SOCK_STREAM, 0, sv);
+    g_assert_cmpint(ret, !=, -1);
+
+    g_string_append_printf(cmd_line, " -netdev socket,fd=%d,id=hs0 ", sv[1]);
+
+    g_test_queue_destroy(virtio_net_test_cleanup, sv);
+    return sv;
 }
 
-static void large_tx(gconstpointer data)
+static void large_tx(void *obj, void *data, QGuestAllocator *t_alloc)
 {
-    QVirtioPCIDevice *dev;
-    QOSState *qs;
-    QVirtQueuePCI *tx, *rx;
-    QVirtQueue *vq;
+    QVirtioNet *dev = obj;
+    QVirtQueue *vq = dev->queues[1];
     uint64_t req_addr;
     uint32_t free_head;
     size_t alloc_size = (size_t)data / 64;
     int i;
 
-    qs = pci_test_start("-netdev hubport,id=hp0,hubid=0 "
-                        "-device virtio-net-pci,netdev=hp0");
-    dev = virtio_net_pci_init(qs->pcibus, PCI_SLOT);
-
-    rx = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, qs->alloc, 0);
-    tx = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, qs->alloc, 1);
-
-    driver_init(&dev->vdev);
-    vq = &tx->vq;
-
     /* Bypass the limitation by pointing several descriptors to a single
      * smaller area */
-    req_addr = guest_alloc(qs->alloc, alloc_size);
+    req_addr = guest_alloc(t_alloc, alloc_size);
     free_head = qvirtqueue_add(vq, req_addr, alloc_size, false, true);
 
     for (i = 0; i < 64; i++) {
         qvirtqueue_add(vq, req_addr, alloc_size, false, i != 63);
     }
-    qvirtqueue_kick(&dev->vdev, vq, free_head);
+    qvirtqueue_kick(dev->vdev, vq, free_head);
 
-    qvirtio_wait_used_elem(&dev->vdev, vq, free_head, NULL,
+    qvirtio_wait_used_elem(dev->vdev, vq, free_head, NULL,
                            QVIRTIO_NET_TIMEOUT_US);
-
-    qvirtqueue_cleanup(dev->vdev.bus, &tx->vq, qs->alloc);
-    qvirtqueue_cleanup(dev->vdev.bus, &rx->vq, qs->alloc);
-    qvirtio_pci_device_disable(dev);
-    g_free(dev->pdev);
-    g_free(dev);
-    qtest_shutdown(qs);
+    guest_free(t_alloc, req_addr);
 }
-#endif
 
-static void hotplug(void)
+static void *virtio_net_test_setup_nosocket(GString *cmd_line, void *arg)
 {
-    const char *arch = qtest_get_arch();
-
-    qtest_start("-device virtio-net-pci");
-
-    qtest_qmp_device_add("virtio-net-pci", "net1",
-                         "{'addr': %s}", stringify(PCI_SLOT_HP));
-
-    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        qpci_unplug_acpi_device_test("net1", PCI_SLOT_HP);
-    }
-
-    test_end();
+    g_string_append(cmd_line, " -netdev hubport,hubid=0,id=hs0 ");
+    return arg;
 }
 
-int main(int argc, char **argv)
+static void register_virtio_net_test(void)
 {
-    g_test_init(&argc, &argv, NULL);
+    QOSGraphTestOptions opts = {
+        .before = virtio_net_test_setup,
+    };
+
+    qos_add_test("hotplug", "virtio-pci", hotplug, &opts);
 #ifndef _WIN32
-    qtest_add_data_func("/virtio/net/pci/basic", send_recv_test, pci_basic);
-    qtest_add_data_func("/virtio/net/pci/rx_stop_cont",
-                        stop_cont_test, pci_basic);
-    qtest_add_data_func("/virtio/net/pci/large_tx_uint_max",
-                        (gconstpointer)UINT_MAX, large_tx);
-    qtest_add_data_func("/virtio/net/pci/large_tx_net_bufsize",
-                        (gconstpointer)NET_BUFSIZE, large_tx);
+    qos_add_test("basic", "virtio-net", send_recv_test, &opts);
+    qos_add_test("rx_stop_cont", "virtio-net", stop_cont_test, &opts);
 #endif
-    qtest_add_func("/virtio/net/pci/hotplug", hotplug);
 
-    return g_test_run();
+    /* These tests do not need a loopback backend.  */
+    opts.before = virtio_net_test_setup_nosocket;
+    opts.arg = (gpointer)UINT_MAX;
+    qos_add_test("large_tx/uint_max", "virtio-net", large_tx, &opts);
+    opts.arg = (gpointer)NET_BUFSIZE;
+    qos_add_test("large_tx/net_bufsize", "virtio-net", large_tx, &opts);
 }
+
+libqos_init(register_virtio_net_test);
-- 
1.8.3.1
