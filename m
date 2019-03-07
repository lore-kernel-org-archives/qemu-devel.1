Received: from eggs.gnu.org ([209.51.188.92]:39788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wr5-0003XC-52
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wr1-0008Jo-Hr
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:51 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:35447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wr1-0008Ib-4d
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:47 -0500
Received: by mail-wm1-x335.google.com with SMTP id y15so10119991wma.0
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:47 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:42 +0100
Message-Id: <1551979804-6060-36-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 35/57] qos-test: virtio-blk test node
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

Convert tests/virtio-blk-test in qgraph test node,
virtio-blk-test. This test consumes a virtio-blk interface
and checks that its function return the expected values.

Some functions are implemented only for virtio-blk-pci, so they
don't consume virtio-blk, but virtio-blk-pci

Note that this test does not allocate any virtio-blk structure,
it's all done by the qtest walking graph mechanism.  The allocator
is also provided by qgraph; remove malloc-generic.c and malloc-generic.h
which are not used anymore.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include        |   6 +-
 tests/libqos/malloc-generic.c |  24 ---
 tests/libqos/malloc-generic.h |  18 --
 tests/libqtest.h              |   3 +
 tests/virtio-blk-test.c       | 474 ++++++++++++++++--------------------------
 5 files changed, 189 insertions(+), 336 deletions(-)
 delete mode 100644 tests/libqos/malloc-generic.c
 delete mode 100644 tests/libqos/malloc-generic.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5ef1b9b..1d3133e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -154,7 +154,6 @@ check-qtest-generic-y += tests/cdrom-test$(EXESUF)
 check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
 
 check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
-check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-scsi-test$(EXESUF)
 
 check-qtest-pci-y += tests/e1000-test$(EXESUF)
@@ -285,7 +284,6 @@ check-qtest-arm-y += tests/pca9552-test$(EXESUF)
 check-qtest-arm-y += tests/ds1338-test$(EXESUF)
 check-qtest-arm-y += tests/microbit-test$(EXESUF)
 check-qtest-arm-y += tests/m25p80-test$(EXESUF)
-check-qtest-arm-$(CONFIG_VIRTIO_BLK) += tests/virtio-blk-test$(EXESUF)
 check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
 check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
 check-qtest-arm-y += tests/hexloader-test$(EXESUF)
@@ -722,7 +720,7 @@ tests/test-crypto-block$(EXESUF): tests/test-crypto-block.o $(test-crypto-obj-y)
 libqgraph-obj-y = tests/libqos/qgraph.o
 
 libqos-obj-y = $(libqgraph-obj-y) tests/libqos/pci.o tests/libqos/fw_cfg.o
-libqos-obj-y += tests/libqos/malloc.o tests/libqos/malloc-generic.o
+libqos-obj-y += tests/libqos/malloc.o
 libqos-obj-y += tests/libqos/i2c.o tests/libqos/libqos.o
 libqos-spapr-obj-y = $(libqos-obj-y) tests/libqos/malloc-spapr.o
 libqos-spapr-obj-y += tests/libqos/libqos-spapr.o
@@ -764,6 +762,7 @@ qos-test-obj-y += tests/pci-test.o
 qos-test-obj-y += tests/sdhci-test.o
 qos-test-obj-y += tests/virtio-test.o
 qos-test-obj-$(CONFIG_VIRTFS) += tests/virtio-9p-test.o
+qos-test-obj-y += tests/virtio-blk-test.o
 qos-test-obj-y += tests/virtio-rng-test.o
 qos-test-obj-y += tests/virtio-serial-test.o
 
@@ -811,7 +810,6 @@ tests/vmxnet3-test$(EXESUF): tests/vmxnet3-test.o
 tests/ne2000-test$(EXESUF): tests/ne2000-test.o
 tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
 tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
-tests/virtio-blk-test$(EXESUF): tests/virtio-blk-test.o $(libqos-virtio-obj-y)
 tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
 tests/virtio-net-test$(EXESUF): tests/virtio-net-test.o $(libqos-pc-obj-y) $(libqos-virtio-obj-y)
 tests/virtio-scsi-test$(EXESUF): tests/virtio-scsi-test.o $(libqos-virtio-obj-y)
diff --git a/tests/libqos/malloc-generic.c b/tests/libqos/malloc-generic.c
deleted file mode 100644
index 766a308..0000000
--- a/tests/libqos/malloc-generic.c
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Basic libqos generic malloc support
- *
- * Copyright (c) 2014 Marc Marí
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#include "qemu/osdep.h"
-#include "libqos/malloc-generic.h"
-#include "libqos/malloc.h"
-
-/*
- * Mostly for valgrind happiness, but it does offer
- * a chokepoint for debugging guest memory leaks, too.
- */
-void generic_alloc_init(QGuestAllocator *s, uint64_t base_addr,
-                        uint64_t size, uint32_t page_size)
-{
-    uint64_t start = base_addr + (1 << 20); /* Start at 1MB */
-
-    alloc_init(s, 0, start, start + size, page_size);
-}
diff --git a/tests/libqos/malloc-generic.h b/tests/libqos/malloc-generic.h
deleted file mode 100644
index 40ea058..0000000
--- a/tests/libqos/malloc-generic.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * Basic libqos generic malloc support
- *
- * Copyright (c) 2014 Marc Marí
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#ifndef LIBQOS_MALLOC_GENERIC_H
-#define LIBQOS_MALLOC_GENERIC_H
-
-#include "libqos/malloc.h"
-
-void generic_alloc_init(QGuestAllocator *s, uint64_t base_addr, uint64_t size,
-                        uint32_t page_size);
-
-#endif
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 1a2f87e..a16acd5 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -17,6 +17,9 @@
 #ifndef LIBQTEST_H
 #define LIBQTEST_H
 
+#include "qapi/qmp/qobject.h"
+#include "qapi/qmp/qdict.h"
+
 typedef struct QTestState QTestState;
 
 extern QTestState *global_qtest;
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 3a8126f..b02be02 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -10,20 +10,11 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/libqos-pc.h"
-#include "libqos/libqos-spapr.h"
-#include "libqos/virtio.h"
-#include "libqos/virtio-pci.h"
-#include "libqos/virtio-mmio.h"
-#include "libqos/malloc.h"
-#include "libqos/malloc-generic.h"
-#include "qapi/qmp/qdict.h"
 #include "qemu/bswap.h"
-#include "standard-headers/linux/virtio_ids.h"
-#include "standard-headers/linux/virtio_config.h"
-#include "standard-headers/linux/virtio_ring.h"
 #include "standard-headers/linux/virtio_blk.h"
 #include "standard-headers/linux/virtio_pci.h"
+#include "libqos/qgraph.h"
+#include "libqos/virtio-blk.h"
 
 /* TODO actually test the results and get rid of this */
 #define qmp_discard_response(...) qobject_unref(qmp(__VA_ARGS__))
@@ -31,13 +22,6 @@
 #define TEST_IMAGE_SIZE         (64 * 1024 * 1024)
 #define QVIRTIO_BLK_TIMEOUT_US  (30 * 1000 * 1000)
 #define PCI_SLOT_HP             0x06
-#define PCI_SLOT                0x04
-#define PCI_FN                  0x00
-
-#define MMIO_PAGE_SIZE          4096
-#define MMIO_DEV_BASE_ADDR      0x0A003E00
-#define MMIO_RAM_ADDR           0x40000000
-#define MMIO_RAM_SIZE           0x20000000
 
 typedef struct QVirtioBlkReq {
     uint32_t type;
@@ -47,84 +31,34 @@ typedef struct QVirtioBlkReq {
     uint8_t status;
 } QVirtioBlkReq;
 
+
 #ifdef HOST_WORDS_BIGENDIAN
 const bool host_is_big_endian = true;
 #else
 const bool host_is_big_endian; /* false */
 #endif
 
+static void drive_destroy(void *path)
+{
+    unlink(path);
+    g_free(path);
+    qos_invalidate_command_line();
+}
+
 static char *drive_create(void)
 {
     int fd, ret;
-    char *tmp_path = g_strdup("/tmp/qtest.XXXXXX");
+    char *t_path = g_strdup("/tmp/qtest.XXXXXX");
 
     /* Create a temporary raw image */
-    fd = mkstemp(tmp_path);
+    fd = mkstemp(t_path);
     g_assert_cmpint(fd, >=, 0);
     ret = ftruncate(fd, TEST_IMAGE_SIZE);
     g_assert_cmpint(ret, ==, 0);
     close(fd);
 
-    return tmp_path;
-}
-
-static QOSState *pci_test_start(void)
-{
-    QOSState *qs;
-    const char *arch = qtest_get_arch();
-    char *tmp_path;
-    const char *cmd = "-drive if=none,id=drive0,file=%s,format=raw "
-                      "-drive if=none,id=drive1,file=null-co://,format=raw "
-                      "-device virtio-blk-pci,id=drv0,drive=drive0,"
-                      "addr=%x.%x";
-
-    tmp_path = drive_create();
-
-    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        qs = qtest_pc_boot(cmd, tmp_path, PCI_SLOT, PCI_FN);
-    } else if (strcmp(arch, "ppc64") == 0) {
-        qs = qtest_spapr_boot(cmd, tmp_path, PCI_SLOT, PCI_FN);
-    } else {
-        g_printerr("virtio-blk tests are only available on x86 or ppc64\n");
-        exit(EXIT_FAILURE);
-    }
-    global_qtest = qs->qts;
-    unlink(tmp_path);
-    g_free(tmp_path);
-    return qs;
-}
-
-static void arm_test_start(void)
-{
-    char *tmp_path;
-
-    tmp_path = drive_create();
-
-    global_qtest = qtest_initf("-machine virt "
-                               "-drive if=none,id=drive0,file=%s,format=raw "
-                               "-device virtio-blk-device,drive=drive0",
-                               tmp_path);
-    unlink(tmp_path);
-    g_free(tmp_path);
-}
-
-static void test_end(void)
-{
-    qtest_end();
-}
-
-static QVirtioPCIDevice *virtio_blk_pci_init(QPCIBus *bus, int slot)
-{
-    QVirtioPCIDevice *dev;
-
-    dev = qvirtio_pci_device_find_slot(bus, VIRTIO_ID_BLOCK, slot);
-    g_assert(dev != NULL);
-    g_assert_cmphex(dev->vdev.device_type, ==, VIRTIO_ID_BLOCK);
-    g_assert_cmphex(dev->pdev->devfn, ==, ((slot << 3) | PCI_FN));
-
-    qvirtio_pci_device_enable(dev);
-    qvirtio_start_device(&dev->vdev);
-    return dev;
+    g_test_queue_destroy(drive_destroy, t_path);
+    return t_path;
 }
 
 static inline void virtio_blk_fix_request(QVirtioDevice *d, QVirtioBlkReq *req)
@@ -395,32 +329,21 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
     }
 }
 
-static void pci_basic(void)
+static void basic(void *obj, void *data, QGuestAllocator *t_alloc)
 {
-    QVirtioPCIDevice *dev;
-    QOSState *qs;
-    QVirtQueuePCI *vqpci;
-
-    qs = pci_test_start();
-    dev = virtio_blk_pci_init(qs->pcibus, PCI_SLOT);
-
-    vqpci = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, &qs->alloc, 0);
-
-    test_basic(&dev->vdev, &qs->alloc, &vqpci->vq);
+    QVirtioBlk *blk_if = obj;
+    QVirtQueue *vq;
+    vq = qvirtqueue_setup(blk_if->vdev, t_alloc, 0);
+    test_basic(blk_if->vdev, t_alloc, vq);
+    qvirtqueue_cleanup(blk_if->vdev->bus, vq, t_alloc);
 
-    /* End test */
-    qvirtqueue_cleanup(dev->vdev.bus, &vqpci->vq, &qs->alloc);
-    qvirtio_pci_device_disable(dev);
-    qvirtio_pci_device_free(dev);
-    g_free(dev);
-    qtest_shutdown(qs);
 }
 
-static void pci_indirect(void)
+static void indirect(void *obj, void *u_data, QGuestAllocator *t_alloc)
 {
-    QVirtioPCIDevice *dev;
-    QVirtQueuePCI *vqpci;
-    QOSState *qs;
+    QVirtQueue *vq;
+    QVirtioBlk *blk_if = obj;
+    QVirtioDevice *dev = blk_if->vdev;
     QVirtioBlkReq req;
     QVRingIndirectDesc *indirect;
     uint64_t req_addr;
@@ -430,22 +353,18 @@ static void pci_indirect(void)
     uint8_t status;
     char *data;
 
-    qs = pci_test_start();
-
-    dev = virtio_blk_pci_init(qs->pcibus, PCI_SLOT);
-
-    capacity = qvirtio_config_readq(&dev->vdev, 0);
+    capacity = qvirtio_config_readq(dev, 0);
     g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
 
-    features = qvirtio_get_features(&dev->vdev);
+    features = qvirtio_get_features(dev);
     g_assert_cmphex(features & (1u << VIRTIO_RING_F_INDIRECT_DESC), !=, 0);
     features = features & ~(QVIRTIO_F_BAD_FEATURE |
                             (1u << VIRTIO_RING_F_EVENT_IDX) |
                             (1u << VIRTIO_BLK_F_SCSI));
-    qvirtio_set_features(&dev->vdev, features);
+    qvirtio_set_features(dev, features);
 
-    vqpci = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, &qs->alloc, 0);
-    qvirtio_set_driver_ok(&dev->vdev);
+    vq = qvirtqueue_setup(dev, t_alloc, 0);
+    qvirtio_set_driver_ok(dev);
 
     /* Write request */
     req.type = VIRTIO_BLK_T_OUT;
@@ -454,23 +373,23 @@ static void pci_indirect(void)
     req.data = g_malloc0(512);
     strcpy(req.data, "TEST");
 
-    req_addr = virtio_blk_request(&qs->alloc, &dev->vdev, &req, 512);
+    req_addr = virtio_blk_request(t_alloc, dev, &req, 512);
 
     g_free(req.data);
 
-    indirect = qvring_indirect_desc_setup(&dev->vdev, &qs->alloc, 2);
+    indirect = qvring_indirect_desc_setup(dev, t_alloc, 2);
     qvring_indirect_desc_add(indirect, req_addr, 528, false);
     qvring_indirect_desc_add(indirect, req_addr + 528, 1, true);
-    free_head = qvirtqueue_add_indirect(&vqpci->vq, indirect);
-    qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);
+    free_head = qvirtqueue_add_indirect(vq, indirect);
+    qvirtqueue_kick(dev, vq, free_head);
 
-    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head, NULL,
+    qvirtio_wait_used_elem(dev, vq, free_head, NULL,
                            QVIRTIO_BLK_TIMEOUT_US);
     status = readb(req_addr + 528);
     g_assert_cmpint(status, ==, 0);
 
     g_free(indirect);
-    guest_free(&qs->alloc, req_addr);
+    guest_free(t_alloc, req_addr);
 
     /* Read request */
     req.type = VIRTIO_BLK_T_IN;
@@ -479,17 +398,17 @@ static void pci_indirect(void)
     req.data = g_malloc0(512);
     strcpy(req.data, "TEST");
 
-    req_addr = virtio_blk_request(&qs->alloc, &dev->vdev, &req, 512);
+    req_addr = virtio_blk_request(t_alloc, dev, &req, 512);
 
     g_free(req.data);
 
-    indirect = qvring_indirect_desc_setup(&dev->vdev, &qs->alloc, 2);
+    indirect = qvring_indirect_desc_setup(dev, t_alloc, 2);
     qvring_indirect_desc_add(indirect, req_addr, 16, false);
     qvring_indirect_desc_add(indirect, req_addr + 16, 513, true);
-    free_head = qvirtqueue_add_indirect(&vqpci->vq, indirect);
-    qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);
+    free_head = qvirtqueue_add_indirect(vq, indirect);
+    qvirtqueue_kick(dev, vq, free_head);
 
-    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head, NULL,
+    qvirtio_wait_used_elem(dev, vq, free_head, NULL,
                            QVIRTIO_BLK_TIMEOUT_US);
     status = readb(req_addr + 528);
     g_assert_cmpint(status, ==, 0);
@@ -500,52 +419,37 @@ static void pci_indirect(void)
     g_free(data);
 
     g_free(indirect);
-    guest_free(&qs->alloc, req_addr);
-
-    /* End test */
-    qvirtqueue_cleanup(dev->vdev.bus, &vqpci->vq, &qs->alloc);
-    qvirtio_pci_device_disable(dev);
-    qvirtio_pci_device_free(dev);
-    g_free(dev);
-    qtest_shutdown(qs);
+    guest_free(t_alloc, req_addr);
+    qvirtqueue_cleanup(dev->bus, vq, t_alloc);
 }
 
-static void pci_config(void)
+static void config(void *obj, void *data, QGuestAllocator *t_alloc)
 {
-    QVirtioPCIDevice *dev;
-    QOSState *qs;
+    QVirtioBlk *blk_if = obj;
+    QVirtioDevice *dev = blk_if->vdev;
     int n_size = TEST_IMAGE_SIZE / 2;
     uint64_t capacity;
 
-    qs = pci_test_start();
-
-    dev = virtio_blk_pci_init(qs->pcibus, PCI_SLOT);
-
-    capacity = qvirtio_config_readq(&dev->vdev, 0);
+    capacity = qvirtio_config_readq(dev, 0);
     g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
 
-    qvirtio_set_driver_ok(&dev->vdev);
+    qvirtio_set_driver_ok(dev);
 
     qmp_discard_response("{ 'execute': 'block_resize', "
                          " 'arguments': { 'device': 'drive0', "
                          " 'size': %d } }", n_size);
-    qvirtio_wait_config_isr(&dev->vdev, QVIRTIO_BLK_TIMEOUT_US);
+    qvirtio_wait_config_isr(dev, QVIRTIO_BLK_TIMEOUT_US);
 
-    capacity = qvirtio_config_readq(&dev->vdev, 0);
+    capacity = qvirtio_config_readq(dev, 0);
     g_assert_cmpint(capacity, ==, n_size / 512);
-
-    qvirtio_pci_device_disable(dev);
-    qvirtio_pci_device_free(dev);
-    g_free(dev);
-
-    qtest_shutdown(qs);
 }
 
-static void pci_msix(void)
+static void msix(void *obj, void *u_data, QGuestAllocator *t_alloc)
 {
-    QVirtioPCIDevice *dev;
-    QOSState *qs;
-    QVirtQueuePCI *vqpci;
+    QVirtQueue *vq;
+    QVirtioBlkPCI *blk = obj;
+    QVirtioPCIDevice *pdev = &blk->pci_vdev;
+    QVirtioDevice *dev = &pdev->vdev;
     QVirtioBlkReq req;
     int n_size = TEST_IMAGE_SIZE / 2;
     uint64_t req_addr;
@@ -554,36 +458,38 @@ static void pci_msix(void)
     uint32_t free_head;
     uint8_t status;
     char *data;
+    QOSGraphObject *blk_object = obj;
+    QPCIDevice *pci_dev = blk_object->get_driver(blk_object, "pci-device");
 
-    qs = pci_test_start();
-
-    dev = virtio_blk_pci_init(qs->pcibus, PCI_SLOT);
-    qpci_msix_enable(dev->pdev);
+    if (qpci_check_buggy_msi(pci_dev)) {
+        return;
+    }
 
-    qvirtio_pci_set_msix_configuration_vector(dev, &qs->alloc, 0);
+    qpci_msix_enable(pdev->pdev);
+    qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);
 
-    capacity = qvirtio_config_readq(&dev->vdev, 0);
+    capacity = qvirtio_config_readq(dev, 0);
     g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
 
-    features = qvirtio_get_features(&dev->vdev);
+    features = qvirtio_get_features(dev);
     features = features & ~(QVIRTIO_F_BAD_FEATURE |
                             (1u << VIRTIO_RING_F_INDIRECT_DESC) |
                             (1u << VIRTIO_RING_F_EVENT_IDX) |
                             (1u << VIRTIO_BLK_F_SCSI));
-    qvirtio_set_features(&dev->vdev, features);
+    qvirtio_set_features(dev, features);
 
-    vqpci = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, &qs->alloc, 0);
-    qvirtqueue_pci_msix_setup(dev, vqpci, &qs->alloc, 1);
+    vq = qvirtqueue_setup(dev, t_alloc, 0);
+    qvirtqueue_pci_msix_setup(pdev, (QVirtQueuePCI *)vq, t_alloc, 1);
 
-    qvirtio_set_driver_ok(&dev->vdev);
+    qvirtio_set_driver_ok(dev);
 
     qmp_discard_response("{ 'execute': 'block_resize', "
                          " 'arguments': { 'device': 'drive0', "
                          " 'size': %d } }", n_size);
 
-    qvirtio_wait_config_isr(&dev->vdev, QVIRTIO_BLK_TIMEOUT_US);
+    qvirtio_wait_config_isr(dev, QVIRTIO_BLK_TIMEOUT_US);
 
-    capacity = qvirtio_config_readq(&dev->vdev, 0);
+    capacity = qvirtio_config_readq(dev, 0);
     g_assert_cmpint(capacity, ==, n_size / 512);
 
     /* Write request */
@@ -593,22 +499,22 @@ static void pci_msix(void)
     req.data = g_malloc0(512);
     strcpy(req.data, "TEST");
 
-    req_addr = virtio_blk_request(&qs->alloc, &dev->vdev, &req, 512);
+    req_addr = virtio_blk_request(t_alloc, dev, &req, 512);
 
     g_free(req.data);
 
-    free_head = qvirtqueue_add(&vqpci->vq, req_addr, 16, false, true);
-    qvirtqueue_add(&vqpci->vq, req_addr + 16, 512, false, true);
-    qvirtqueue_add(&vqpci->vq, req_addr + 528, 1, true, false);
-    qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);
+    free_head = qvirtqueue_add(vq, req_addr, 16, false, true);
+    qvirtqueue_add(vq, req_addr + 16, 512, false, true);
+    qvirtqueue_add(vq, req_addr + 528, 1, true, false);
+    qvirtqueue_kick(dev, vq, free_head);
 
-    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head, NULL,
+    qvirtio_wait_used_elem(dev, vq, free_head, NULL,
                            QVIRTIO_BLK_TIMEOUT_US);
 
     status = readb(req_addr + 528);
     g_assert_cmpint(status, ==, 0);
 
-    guest_free(&qs->alloc, req_addr);
+    guest_free(t_alloc, req_addr);
 
     /* Read request */
     req.type = VIRTIO_BLK_T_IN;
@@ -616,18 +522,18 @@ static void pci_msix(void)
     req.sector = 0;
     req.data = g_malloc0(512);
 
-    req_addr = virtio_blk_request(&qs->alloc, &dev->vdev, &req, 512);
+    req_addr = virtio_blk_request(t_alloc, dev, &req, 512);
 
     g_free(req.data);
 
-    free_head = qvirtqueue_add(&vqpci->vq, req_addr, 16, false, true);
-    qvirtqueue_add(&vqpci->vq, req_addr + 16, 512, true, true);
-    qvirtqueue_add(&vqpci->vq, req_addr + 528, 1, true, false);
+    free_head = qvirtqueue_add(vq, req_addr, 16, false, true);
+    qvirtqueue_add(vq, req_addr + 16, 512, true, true);
+    qvirtqueue_add(vq, req_addr + 528, 1, true, false);
 
-    qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);
+    qvirtqueue_kick(dev, vq, free_head);
 
 
-    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head, NULL,
+    qvirtio_wait_used_elem(dev, vq, free_head, NULL,
                            QVIRTIO_BLK_TIMEOUT_US);
 
     status = readb(req_addr + 528);
@@ -638,22 +544,19 @@ static void pci_msix(void)
     g_assert_cmpstr(data, ==, "TEST");
     g_free(data);
 
-    guest_free(&qs->alloc, req_addr);
+    guest_free(t_alloc, req_addr);
 
     /* End test */
-    qvirtqueue_cleanup(dev->vdev.bus, &vqpci->vq, &qs->alloc);
-    qpci_msix_disable(dev->pdev);
-    qvirtio_pci_device_disable(dev);
-    qvirtio_pci_device_free(dev);
-    g_free(dev);
-    qtest_shutdown(qs);
+    qpci_msix_disable(pdev->pdev);
+    qvirtqueue_cleanup(dev->bus, vq, t_alloc);
 }
 
-static void pci_idx(void)
+static void idx(void *obj, void *u_data, QGuestAllocator *t_alloc)
 {
-    QVirtioPCIDevice *dev;
-    QOSState *qs;
-    QVirtQueuePCI *vqpci;
+    QVirtQueue *vq;
+    QVirtioBlkPCI *blk = obj;
+    QVirtioPCIDevice *pdev = &blk->pci_vdev;
+    QVirtioDevice *dev = &pdev->vdev;
     QVirtioBlkReq req;
     uint64_t req_addr;
     uint64_t capacity;
@@ -663,28 +566,30 @@ static void pci_idx(void)
     uint32_t desc_idx;
     uint8_t status;
     char *data;
+    QOSGraphObject *blk_object = obj;
+    QPCIDevice *pci_dev = blk_object->get_driver(blk_object, "pci-device");
 
-    qs = pci_test_start();
-
-    dev = virtio_blk_pci_init(qs->pcibus, PCI_SLOT);
-    qpci_msix_enable(dev->pdev);
+    if (qpci_check_buggy_msi(pci_dev)) {
+        return;
+    }
 
-    qvirtio_pci_set_msix_configuration_vector(dev, &qs->alloc, 0);
+    qpci_msix_enable(pdev->pdev);
+    qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);
 
-    capacity = qvirtio_config_readq(&dev->vdev, 0);
+    capacity = qvirtio_config_readq(dev, 0);
     g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
 
-    features = qvirtio_get_features(&dev->vdev);
+    features = qvirtio_get_features(dev);
     features = features & ~(QVIRTIO_F_BAD_FEATURE |
                             (1u << VIRTIO_RING_F_INDIRECT_DESC) |
                             (1u << VIRTIO_F_NOTIFY_ON_EMPTY) |
                             (1u << VIRTIO_BLK_F_SCSI));
-    qvirtio_set_features(&dev->vdev, features);
+    qvirtio_set_features(dev, features);
 
-    vqpci = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, &qs->alloc, 0);
-    qvirtqueue_pci_msix_setup(dev, vqpci, &qs->alloc, 1);
+    vq = qvirtqueue_setup(dev, t_alloc, 0);
+    qvirtqueue_pci_msix_setup(pdev, (QVirtQueuePCI *)vq, t_alloc, 1);
 
-    qvirtio_set_driver_ok(&dev->vdev);
+    qvirtio_set_driver_ok(dev);
 
     /* Write request */
     req.type = VIRTIO_BLK_T_OUT;
@@ -693,16 +598,16 @@ static void pci_idx(void)
     req.data = g_malloc0(512);
     strcpy(req.data, "TEST");
 
-    req_addr = virtio_blk_request(&qs->alloc, &dev->vdev, &req, 512);
+    req_addr = virtio_blk_request(t_alloc, dev, &req, 512);
 
     g_free(req.data);
 
-    free_head = qvirtqueue_add(&vqpci->vq, req_addr, 16, false, true);
-    qvirtqueue_add(&vqpci->vq, req_addr + 16, 512, false, true);
-    qvirtqueue_add(&vqpci->vq, req_addr + 528, 1, true, false);
-    qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);
+    free_head = qvirtqueue_add(vq, req_addr, 16, false, true);
+    qvirtqueue_add(vq, req_addr + 16, 512, false, true);
+    qvirtqueue_add(vq, req_addr + 528, 1, true, false);
+    qvirtqueue_kick(dev, vq, free_head);
 
-    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head, NULL,
+    qvirtio_wait_used_elem(dev, vq, free_head, NULL,
                            QVIRTIO_BLK_TIMEOUT_US);
 
     /* Write request */
@@ -712,25 +617,25 @@ static void pci_idx(void)
     req.data = g_malloc0(512);
     strcpy(req.data, "TEST");
 
-    req_addr = virtio_blk_request(&qs->alloc, &dev->vdev, &req, 512);
+    req_addr = virtio_blk_request(t_alloc, dev, &req, 512);
 
     g_free(req.data);
 
     /* Notify after processing the third request */
-    qvirtqueue_set_used_event(&vqpci->vq, 2);
-    free_head = qvirtqueue_add(&vqpci->vq, req_addr, 16, false, true);
-    qvirtqueue_add(&vqpci->vq, req_addr + 16, 512, false, true);
-    qvirtqueue_add(&vqpci->vq, req_addr + 528, 1, true, false);
-    qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);
+    qvirtqueue_set_used_event(vq, 2);
+    free_head = qvirtqueue_add(vq, req_addr, 16, false, true);
+    qvirtqueue_add(vq, req_addr + 16, 512, false, true);
+    qvirtqueue_add(vq, req_addr + 528, 1, true, false);
+    qvirtqueue_kick(dev, vq, free_head);
     write_head = free_head;
 
     /* No notification expected */
-    status = qvirtio_wait_status_byte_no_isr(&dev->vdev,
-                                             &vqpci->vq, req_addr + 528,
+    status = qvirtio_wait_status_byte_no_isr(dev,
+                                             vq, req_addr + 528,
                                              QVIRTIO_BLK_TIMEOUT_US);
     g_assert_cmpint(status, ==, 0);
 
-    guest_free(&qs->alloc, req_addr);
+    guest_free(t_alloc, req_addr);
 
     /* Read request */
     req.type = VIRTIO_BLK_T_IN;
@@ -738,20 +643,20 @@ static void pci_idx(void)
     req.sector = 1;
     req.data = g_malloc0(512);
 
-    req_addr = virtio_blk_request(&qs->alloc, &dev->vdev, &req, 512);
+    req_addr = virtio_blk_request(t_alloc, dev, &req, 512);
 
     g_free(req.data);
 
-    free_head = qvirtqueue_add(&vqpci->vq, req_addr, 16, false, true);
-    qvirtqueue_add(&vqpci->vq, req_addr + 16, 512, true, true);
-    qvirtqueue_add(&vqpci->vq, req_addr + 528, 1, true, false);
+    free_head = qvirtqueue_add(vq, req_addr, 16, false, true);
+    qvirtqueue_add(vq, req_addr + 16, 512, true, true);
+    qvirtqueue_add(vq, req_addr + 528, 1, true, false);
 
-    qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);
+    qvirtqueue_kick(dev, vq, free_head);
 
     /* We get just one notification for both requests */
-    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, write_head, NULL,
+    qvirtio_wait_used_elem(dev, vq, write_head, NULL,
                            QVIRTIO_BLK_TIMEOUT_US);
-    g_assert(qvirtqueue_get_buf(&vqpci->vq, &desc_idx, NULL));
+    g_assert(qvirtqueue_get_buf(vq, &desc_idx, NULL));
     g_assert_cmpint(desc_idx, ==, free_head);
 
     status = readb(req_addr + 528);
@@ -762,125 +667,114 @@ static void pci_idx(void)
     g_assert_cmpstr(data, ==, "TEST");
     g_free(data);
 
-    guest_free(&qs->alloc, req_addr);
+    guest_free(t_alloc, req_addr);
 
     /* End test */
-    qvirtqueue_cleanup(dev->vdev.bus, &vqpci->vq, &qs->alloc);
-    qpci_msix_disable(dev->pdev);
-    qvirtio_pci_device_disable(dev);
-    qvirtio_pci_device_free(dev);
-    g_free(dev);
-    qtest_shutdown(qs);
+    qpci_msix_disable(pdev->pdev);
+
+    qvirtqueue_cleanup(dev->bus, vq, t_alloc);
 }
 
-static void pci_hotplug(void)
+static void pci_hotplug(void *obj, void *data, QGuestAllocator *t_alloc)
 {
+    QVirtioPCIDevice *dev1 = obj;
     QVirtioPCIDevice *dev;
-    QOSState *qs;
-    const char *arch = qtest_get_arch();
-
-    qs = pci_test_start();
 
     /* plug secondary disk */
     qtest_qmp_device_add("virtio-blk-pci", "drv1",
                          "{'addr': %s, 'drive': 'drive1'}",
-                         stringify(PCI_SLOT_HP));
+                         stringify(PCI_SLOT_HP) ".0");
 
-    dev = virtio_blk_pci_init(qs->pcibus, PCI_SLOT_HP);
-    g_assert(dev);
+    dev = virtio_pci_new(dev1->pdev->bus,
+                         &(QPCIAddress) { .devfn = QPCI_DEVFN(PCI_SLOT_HP, 0) });
+    g_assert_nonnull(dev);
+    g_assert_cmpint(dev->vdev.device_type, ==, VIRTIO_ID_BLOCK);
     qvirtio_pci_device_disable(dev);
-    qvirtio_pci_device_free(dev);
-    g_free(dev);
+    qos_object_destroy((QOSGraphObject *)dev);
 
     /* unplug secondary disk */
-    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        qpci_unplug_acpi_device_test("drv1", PCI_SLOT_HP);
-    }
-    qtest_shutdown(qs);
+    qpci_unplug_acpi_device_test("drv1", PCI_SLOT_HP);
 }
 
 /*
  * Check that setting the vring addr on a non-existent virtqueue does
  * not crash.
  */
-static void test_nonexistent_virtqueue(void)
+static void test_nonexistent_virtqueue(void *obj, void *data,
+                                       QGuestAllocator *t_alloc)
 {
+    QVirtioBlkPCI *blk = obj;
+    QVirtioPCIDevice *pdev = &blk->pci_vdev;
     QPCIBar bar0;
-    QOSState *qs;
     QPCIDevice *dev;
 
-    qs = pci_test_start();
-    dev = qpci_device_find(qs->pcibus, QPCI_DEVFN(4, 0));
+    dev = qpci_device_find(pdev->pdev->bus, QPCI_DEVFN(4, 0));
     g_assert(dev != NULL);
-
     qpci_device_enable(dev);
+
     bar0 = qpci_iomap(dev, 0, NULL);
 
     qpci_io_writeb(dev, bar0, VIRTIO_PCI_QUEUE_SEL, 2);
     qpci_io_writel(dev, bar0, VIRTIO_PCI_QUEUE_PFN, 1);
 
+
     g_free(dev);
-    qtest_shutdown(qs);
 }
 
-static void mmio_basic(void)
+static void resize(void *obj, void *data, QGuestAllocator *t_alloc)
 {
-    QVirtioMMIODevice *dev;
-    QVirtQueue *vq;
-    QGuestAllocator alloc;
+    QVirtioBlk *blk_if = obj;
+    QVirtioDevice *dev = blk_if->vdev;
     int n_size = TEST_IMAGE_SIZE / 2;
     uint64_t capacity;
+    QVirtQueue *vq;
 
-    arm_test_start();
-
-    dev = g_malloc0(sizeof(QVirtioMMIODevice));
-    qvirtio_mmio_init_device(dev, global_qtest, MMIO_DEV_BASE_ADDR, MMIO_PAGE_SIZE);
-    g_assert(dev != NULL);
-    g_assert_cmphex(dev->vdev.device_type, ==, VIRTIO_ID_BLOCK);
-
-    qvirtio_start_device(&dev->vdev);
-
-    generic_alloc_init(&alloc, MMIO_RAM_ADDR, MMIO_RAM_SIZE, MMIO_PAGE_SIZE);
-    vq = qvirtqueue_setup(&dev->vdev, &alloc, 0);
+    vq = qvirtqueue_setup(dev, t_alloc, 0);
 
-    test_basic(&dev->vdev, &alloc, vq);
+    test_basic(dev, t_alloc, vq);
 
     qmp_discard_response("{ 'execute': 'block_resize', "
                          " 'arguments': { 'device': 'drive0', "
                          " 'size': %d } }", n_size);
 
-    qvirtio_wait_queue_isr(&dev->vdev, vq, QVIRTIO_BLK_TIMEOUT_US);
+    qvirtio_wait_queue_isr(dev, vq, QVIRTIO_BLK_TIMEOUT_US);
 
-    capacity = qvirtio_config_readq(&dev->vdev, 0);
+    capacity = qvirtio_config_readq(dev, 0);
     g_assert_cmpint(capacity, ==, n_size / 512);
 
-    /* End test */
-    qvirtqueue_cleanup(dev->vdev.bus, vq, &alloc);
-    g_free(dev);
-    alloc_destroy(&alloc);
-    test_end();
+    qvirtqueue_cleanup(dev->bus, vq, t_alloc);
+
 }
 
-int main(int argc, char **argv)
+static void *virtio_blk_test_setup(GString *cmd_line, void *arg)
 {
-    const char *arch = qtest_get_arch();
-
-    g_test_init(&argc, &argv, NULL);
-
-    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0 ||
-        strcmp(arch, "ppc64") == 0) {
-        qtest_add_func("/virtio/blk/pci/basic", pci_basic);
-        qtest_add_func("/virtio/blk/pci/indirect", pci_indirect);
-        qtest_add_func("/virtio/blk/pci/config", pci_config);
-        qtest_add_func("/virtio/blk/pci/nxvirtq", test_nonexistent_virtqueue);
-        if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-            qtest_add_func("/virtio/blk/pci/msix", pci_msix);
-            qtest_add_func("/virtio/blk/pci/idx", pci_idx);
-        }
-        qtest_add_func("/virtio/blk/pci/hotplug", pci_hotplug);
-    } else if (strcmp(arch, "arm") == 0) {
-        qtest_add_func("/virtio/blk/mmio/basic", mmio_basic);
-    }
+    char *tmp_path = drive_create();
 
-    return g_test_run();
+    g_string_append_printf(cmd_line,
+                           " -drive if=none,id=drive0,file=%s,format=raw "
+                           "-drive if=none,id=drive1,file=null-co://,format=raw ",
+                           tmp_path);
+
+    return arg;
 }
+
+static void register_virtio_blk_test(void)
+{
+    QOSGraphTestOptions opts = {
+        .before = virtio_blk_test_setup,
+    };
+
+    qos_add_test("indirect", "virtio-blk", indirect, &opts);
+    qos_add_test("config", "virtio-blk", config, &opts);
+    qos_add_test("basic", "virtio-blk", basic, &opts);
+    qos_add_test("resize", "virtio-blk", resize, &opts);
+
+    /* tests just for virtio-blk-pci */
+    qos_add_test("msix", "virtio-blk-pci", msix, &opts);
+    qos_add_test("idx", "virtio-blk-pci", idx, &opts);
+    qos_add_test("nxvirtq", "virtio-blk-pci",
+                      test_nonexistent_virtqueue, &opts);
+    qos_add_test("hotplug", "virtio-blk-pci", pci_hotplug, &opts);
+}
+
+libqos_init(register_virtio_blk_test);
-- 
1.8.3.1
