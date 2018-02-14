Received: from eggs.gnu.org ([2001:4830:134:3::10]:43440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elv7K-0006Ii-Ha
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elv7H-00078p-Cb
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:20:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58242 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1elv7H-00078K-5V
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:20:47 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 14 Feb 2018 12:20:19 +0100
Message-Id: <1518607234-17739-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1518607234-17739-1-git-send-email-thuth@redhat.com>
References: <1518607234-17739-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 03/18] libqos: Track QTestState with QPCIBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

When initializing a QPCIBus, track which QTestState the bus is
associated with (so that a later patch can then explicitly use
that test state for all communication on the bus, rather than
blindly relying on global_qtest).  Update the initialization
functions to take another parameter, and update all callers to
pass in state (for now, most callers get away with passing the
current global_qtest as the current state, although this required
fixing the order of initialization to ensure qtest_start() is
called before qpci_init*() in rtl8139-test, and provided an
opportunity to pass in the allocator in e1000e-test).

Touch up some allocations to use g_new0() rather than g_malloc()
while in the area, and simplify some code (all implementations
of QOSOps provide a .init_allocator() that never fails).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
[thuth: Removed hunk from vhost-user-test.c that is not required anymore,
 fixed conflict in qtest_vboot() and adjusted qpci_init_pc() in sdhci-test]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/ahci-test.c         |  2 +-
 tests/e1000e-test.c       |  6 +++---
 tests/i440fx-test.c       |  2 +-
 tests/ide-test.c          |  2 +-
 tests/libqos/ahci.c       |  4 ++--
 tests/libqos/ahci.h       |  2 +-
 tests/libqos/libqos.c     | 10 +++-------
 tests/libqos/libqos.h     |  2 +-
 tests/libqos/pci-pc.c     |  7 ++++---
 tests/libqos/pci-pc.h     |  2 +-
 tests/libqos/pci-spapr.c  |  7 ++++---
 tests/libqos/pci-spapr.h  |  2 +-
 tests/libqos/pci.h        |  1 +
 tests/q35-test.c          |  4 ++--
 tests/rtl8139-test.c      |  5 +++--
 tests/sdhci-test.c        |  2 +-
 tests/tco-test.c          |  2 +-
 tests/usb-hcd-ehci-test.c |  2 +-
 tests/vhost-user-test.c   |  2 +-
 19 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index 7aa5af4..e847c98 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -161,7 +161,7 @@ static AHCIQState *ahci_vboot(const char *cli, va_list ap)
     alloc_set_flags(s->parent->alloc, ALLOC_LEAK_ASSERT);
 
     /* Verify that we have an AHCI device present. */
-    s->dev = get_ahci_device(&s->fingerprint);
+    s->dev = get_ahci_device(s->parent->qts, &s->fingerprint);
 
     return s;
 }
diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
index c612dc6..d8085d9 100644
--- a/tests/e1000e-test.c
+++ b/tests/e1000e-test.c
@@ -392,12 +392,12 @@ static void data_test_init(e1000e_device *d)
     qtest_start(cmdline);
     g_free(cmdline);
 
-    test_bus = qpci_init_pc(NULL);
-    g_assert_nonnull(test_bus);
-
     test_alloc = pc_alloc_init();
     g_assert_nonnull(test_alloc);
 
+    test_bus = qpci_init_pc(global_qtest, test_alloc);
+    g_assert_nonnull(test_bus);
+
     e1000e_device_init(test_bus, d);
 }
 
diff --git a/tests/i440fx-test.c b/tests/i440fx-test.c
index e9d05c8..4390e55 100644
--- a/tests/i440fx-test.c
+++ b/tests/i440fx-test.c
@@ -38,7 +38,7 @@ static QPCIBus *test_start_get_bus(const TestData *s)
     cmdline = g_strdup_printf("-smp %d", s->num_cpus);
     qtest_start(cmdline);
     g_free(cmdline);
-    return qpci_init_pc(NULL);
+    return qpci_init_pc(global_qtest, NULL);
 }
 
 static void test_i440fx_defaults(gconstpointer opaque)
diff --git a/tests/ide-test.c b/tests/ide-test.c
index be427e4..ed71db0 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -150,7 +150,7 @@ static QPCIDevice *get_pci_device(QPCIBar *bmdma_bar, QPCIBar *ide_bar)
     uint16_t vendor_id, device_id;
 
     if (!pcibus) {
-        pcibus = qpci_init_pc(NULL);
+        pcibus = qpci_init_pc(global_qtest, NULL);
     }
 
     /* Find PCI device and verify it's the right one */
diff --git a/tests/libqos/ahci.c b/tests/libqos/ahci.c
index 13c0749..40c532e 100644
--- a/tests/libqos/ahci.c
+++ b/tests/libqos/ahci.c
@@ -123,13 +123,13 @@ bool is_atapi(AHCIQState *ahci, uint8_t port)
 /**
  * Locate, verify, and return a handle to the AHCI device.
  */
-QPCIDevice *get_ahci_device(uint32_t *fingerprint)
+QPCIDevice *get_ahci_device(QTestState *qts, uint32_t *fingerprint)
 {
     QPCIDevice *ahci;
     uint32_t ahci_fingerprint;
     QPCIBus *pcibus;
 
-    pcibus = qpci_init_pc(NULL);
+    pcibus = qpci_init_pc(qts, NULL);
 
     /* Find the AHCI PCI device and verify it's the right one. */
     ahci = qpci_device_find(pcibus, QPCI_DEVFN(0x1F, 0x02));
diff --git a/tests/libqos/ahci.h b/tests/libqos/ahci.h
index 5f9627b..715ca1e 100644
--- a/tests/libqos/ahci.h
+++ b/tests/libqos/ahci.h
@@ -571,7 +571,7 @@ void ahci_free(AHCIQState *ahci, uint64_t addr);
 void ahci_clean_mem(AHCIQState *ahci);
 
 /* Device management */
-QPCIDevice *get_ahci_device(uint32_t *fingerprint);
+QPCIDevice *get_ahci_device(QTestState *qts, uint32_t *fingerprint);
 void free_ahci_device(QPCIDevice *dev);
 void ahci_pci_enable(AHCIQState *ahci);
 void start_ahci_device(AHCIQState *ahci);
diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index 306d4c0..18f08cf 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -18,18 +18,14 @@ QOSState *qtest_vboot(QOSOps *ops, const char *cmdline_fmt, va_list ap)
 {
     char *cmdline;
 
-    struct QOSState *qs = g_new(QOSState, 1);
+    QOSState *qs = g_new0(QOSState, 1);
 
     cmdline = g_strdup_vprintf(cmdline_fmt, ap);
     qs->qts = qtest_start(cmdline);
     qs->ops = ops;
     if (ops) {
-        if (ops->init_allocator) {
-            qs->alloc = ops->init_allocator(ALLOC_NO_FLAGS);
-        }
-        if (ops->qpci_init && qs->alloc) {
-            qs->pcibus = ops->qpci_init(qs->alloc);
-        }
+        qs->alloc = ops->init_allocator(ALLOC_NO_FLAGS);
+        qs->pcibus = ops->qpci_init(qs->qts, qs->alloc);
     }
 
     g_free(cmdline);
diff --git a/tests/libqos/libqos.h b/tests/libqos/libqos.h
index 2319697..78e5c04 100644
--- a/tests/libqos/libqos.h
+++ b/tests/libqos/libqos.h
@@ -10,7 +10,7 @@ typedef struct QOSState QOSState;
 typedef struct QOSOps {
     QGuestAllocator *(*init_allocator)(QAllocOpts);
     void (*uninit_allocator)(QGuestAllocator *);
-    QPCIBus *(*qpci_init)(QGuestAllocator *alloc);
+    QPCIBus *(*qpci_init)(QTestState *qts, QGuestAllocator *alloc);
     void (*qpci_free)(QPCIBus *bus);
     void (*shutdown)(QOSState *);
 } QOSOps;
diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index 368a8a6..a2daf61 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -115,11 +115,11 @@ static void qpci_pc_config_writel(QPCIBus *bus, int devfn, uint8_t offset, uint3
     outl(0xcfc, value);
 }
 
-QPCIBus *qpci_init_pc(QGuestAllocator *alloc)
+QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
 {
-    QPCIBusPC *ret;
+    QPCIBusPC *ret = g_new0(QPCIBusPC, 1);
 
-    ret = g_malloc(sizeof(*ret));
+    assert(qts);
 
     ret->bus.pio_readb = qpci_pc_pio_readb;
     ret->bus.pio_readw = qpci_pc_pio_readw;
@@ -142,6 +142,7 @@ QPCIBus *qpci_init_pc(QGuestAllocator *alloc)
     ret->bus.config_writew = qpci_pc_config_writew;
     ret->bus.config_writel = qpci_pc_config_writel;
 
+    ret->bus.qts = qts;
     ret->bus.pio_alloc_ptr = 0xc000;
     ret->bus.mmio_alloc_ptr = 0xE0000000;
     ret->bus.mmio_limit = 0x100000000ULL;
diff --git a/tests/libqos/pci-pc.h b/tests/libqos/pci-pc.h
index 9479b51..491eeac 100644
--- a/tests/libqos/pci-pc.h
+++ b/tests/libqos/pci-pc.h
@@ -16,7 +16,7 @@
 #include "libqos/pci.h"
 #include "libqos/malloc.h"
 
-QPCIBus *qpci_init_pc(QGuestAllocator *alloc);
+QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc);
 void     qpci_free_pc(QPCIBus *bus);
 
 #endif
diff --git a/tests/libqos/pci-spapr.c b/tests/libqos/pci-spapr.c
index 2043f1e..ef52fcb 100644
--- a/tests/libqos/pci-spapr.c
+++ b/tests/libqos/pci-spapr.c
@@ -154,11 +154,11 @@ static void qpci_spapr_config_writel(QPCIBus *bus, int devfn, uint8_t offset,
 #define SPAPR_PCI_MMIO32_WIN_SIZE    0x80000000 /* 2 GiB */
 #define SPAPR_PCI_IO_WIN_SIZE        0x10000
 
-QPCIBus *qpci_init_spapr(QGuestAllocator *alloc)
+QPCIBus *qpci_init_spapr(QTestState *qts, QGuestAllocator *alloc)
 {
-    QPCIBusSPAPR *ret;
+    QPCIBusSPAPR *ret = g_new0(QPCIBusSPAPR, 1);
 
-    ret = g_malloc(sizeof(*ret));
+    assert(qts);
 
     ret->alloc = alloc;
 
@@ -197,6 +197,7 @@ QPCIBus *qpci_init_spapr(QGuestAllocator *alloc)
     ret->mmio32.pci_base = SPAPR_PCI_MMIO32_WIN_SIZE;
     ret->mmio32.size = SPAPR_PCI_MMIO32_WIN_SIZE;
 
+    ret->bus.qts = qts;
     ret->bus.pio_alloc_ptr = 0xc000;
     ret->bus.mmio_alloc_ptr = ret->mmio32.pci_base;
     ret->bus.mmio_limit = ret->mmio32.pci_base + ret->mmio32.size;
diff --git a/tests/libqos/pci-spapr.h b/tests/libqos/pci-spapr.h
index 4192126..387686d 100644
--- a/tests/libqos/pci-spapr.h
+++ b/tests/libqos/pci-spapr.h
@@ -11,7 +11,7 @@
 #include "libqos/malloc.h"
 #include "libqos/pci.h"
 
-QPCIBus *qpci_init_spapr(QGuestAllocator *alloc);
+QPCIBus *qpci_init_spapr(QTestState *qts, QGuestAllocator *alloc);
 void     qpci_free_spapr(QPCIBus *bus);
 
 #endif
diff --git a/tests/libqos/pci.h b/tests/libqos/pci.h
index ed48061..429c382 100644
--- a/tests/libqos/pci.h
+++ b/tests/libqos/pci.h
@@ -48,6 +48,7 @@ struct QPCIBus {
     void (*config_writel)(QPCIBus *bus, int devfn,
                           uint8_t offset, uint32_t value);
 
+    QTestState *qts;
     uint16_t pio_alloc_ptr;
     uint64_t mmio_alloc_ptr, mmio_limit;
 };
diff --git a/tests/q35-test.c b/tests/q35-test.c
index 187d68f..3eaedf4 100644
--- a/tests/q35-test.c
+++ b/tests/q35-test.c
@@ -87,7 +87,7 @@ static void test_smram_lock(void)
 
     qtest_start("-M q35");
 
-    pcibus = qpci_init_pc(NULL);
+    pcibus = qpci_init_pc(global_qtest, NULL);
     g_assert(pcibus != NULL);
 
     pcidev = qpci_device_find(pcibus, 0);
@@ -146,7 +146,7 @@ static void test_tseg_size(const void *data)
     g_free(cmdline);
 
     /* locate the DRAM controller */
-    pcibus = qpci_init_pc(NULL);
+    pcibus = qpci_init_pc(global_qtest, NULL);
     g_assert(pcibus != NULL);
     pcidev = qpci_device_find(pcibus, 0);
     g_assert(pcidev != NULL);
diff --git a/tests/rtl8139-test.c b/tests/rtl8139-test.c
index 7de7dc4..68bfc42 100644
--- a/tests/rtl8139-test.c
+++ b/tests/rtl8139-test.c
@@ -35,7 +35,7 @@ static QPCIDevice *get_device(void)
 {
     QPCIDevice *dev;
 
-    pcibus = qpci_init_pc(NULL);
+    pcibus = qpci_init_pc(global_qtest, NULL);
     qpci_device_foreach(pcibus, 0x10ec, 0x8139, save_fn, &dev);
     g_assert(dev != NULL);
 
@@ -197,11 +197,12 @@ int main(int argc, char **argv)
 {
     int ret;
 
+    qtest_start("-device rtl8139");
+
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/rtl8139/nop", nop);
     qtest_add_func("/rtl8139/timer", test_init);
 
-    qtest_start("-device rtl8139");
     ret = g_test_run();
 
     qtest_end();
diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 493023f..6b3a532 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -187,7 +187,7 @@ static QSDHCI *machine_start(const struct sdhci_t *test)
         global_qtest = qtest_startf("-machine %s -device sdhci-pci",
                                     test->machine);
 
-        s->pci.bus = qpci_init_pc(NULL);
+        s->pci.bus = qpci_init_pc(global_qtest, NULL);
 
         /* Find PCI device and verify it's the right one */
         s->pci.dev = qpci_device_find(s->pci.bus, QPCI_DEVFN(4, 0));
diff --git a/tests/tco-test.c b/tests/tco-test.c
index cc7663d..aee17af 100644
--- a/tests/tco-test.c
+++ b/tests/tco-test.c
@@ -64,7 +64,7 @@ static void test_init(TestData *d)
     global_qtest = qs;
     qtest_irq_intercept_in(qs, "ioapic");
 
-    d->bus = qpci_init_pc(NULL);
+    d->bus = qpci_init_pc(qs, NULL);
     d->dev = qpci_device_find(d->bus, QPCI_DEVFN(0x1f, 0x00));
     g_assert(d->dev != NULL);
 
diff --git a/tests/usb-hcd-ehci-test.c b/tests/usb-hcd-ehci-test.c
index 944eb1c..55d4743 100644
--- a/tests/usb-hcd-ehci-test.c
+++ b/tests/usb-hcd-ehci-test.c
@@ -52,7 +52,7 @@ static void ehci_port_test(struct qhc *hc, int port, uint32_t expect)
 
 static void test_init(void)
 {
-    pcibus = qpci_init_pc(NULL);
+    pcibus = qpci_init_pc(global_qtest, NULL);
     g_assert(pcibus != NULL);
 
     qusb_pci_init_one(pcibus, &uhci1, QPCI_DEVFN(0x1d, 0), 4);
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index a217353..3f74511 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -180,7 +180,7 @@ static void init_virtio_dev(TestServer *s, uint32_t features_mask)
     uint32_t features;
     int i;
 
-    s->bus = qpci_init_pc(NULL);
+    s->bus = qpci_init_pc(global_qtest, NULL);
     g_assert_nonnull(s->bus);
 
     s->dev = qvirtio_pci_device_find(s->bus, VIRTIO_ID_NET);
-- 
1.8.3.1
