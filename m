Received: from eggs.gnu.org ([2001:4830:134:3::10]:51679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEP-00085d-WD
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEO-0004KF-IG
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:27933)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqEO-0004JA-9y
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:56 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:29 +0100
Message-Id: <1543851204-41186-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 16/71] tests/libqos: rename qpci_init_pc and
 qpci_init_spapr functions
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

Rename qpci_init_pc in qpci_pc_new and qpci_init_spapr in qpci_spapr_new,
since theese function actually allocate a new pci struct and initialize it.
Changed QOSOps field name from qpci_init to qpci_new.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/e1000e-test.c         | 2 +-
 tests/i440fx-test.c         | 2 +-
 tests/ide-test.c            | 2 +-
 tests/libqos/ahci.c         | 2 +-
 tests/libqos/libqos-pc.c    | 2 +-
 tests/libqos/libqos-spapr.c | 2 +-
 tests/libqos/libqos.c       | 2 +-
 tests/libqos/libqos.h       | 2 +-
 tests/libqos/pci-pc.c       | 2 +-
 tests/libqos/pci-pc.h       | 9 ++++++++-
 tests/libqos/pci-spapr.c    | 2 +-
 tests/libqos/pci-spapr.h    | 2 +-
 tests/q35-test.c            | 4 ++--
 tests/rtl8139-test.c        | 2 +-
 tests/sdhci-test.c          | 2 +-
 tests/tco-test.c            | 2 +-
 tests/usb-hcd-ehci-test.c   | 2 +-
 tests/vhost-user-test.c     | 2 +-
 18 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
index c9408a5..5525589 100644
--- a/tests/e1000e-test.c
+++ b/tests/e1000e-test.c
@@ -395,7 +395,7 @@ static void data_test_init(e1000e_device *d)
     test_alloc = pc_alloc_init(global_qtest);
     g_assert_nonnull(test_alloc);
 
-    test_bus = qpci_init_pc(global_qtest, test_alloc);
+    test_bus = qpci_new_pc(global_qtest, test_alloc);
     g_assert_nonnull(test_bus);
 
     e1000e_device_init(test_bus, d);
diff --git a/tests/i440fx-test.c b/tests/i440fx-test.c
index 4390e55..69205b5 100644
--- a/tests/i440fx-test.c
+++ b/tests/i440fx-test.c
@@ -38,7 +38,7 @@ static QPCIBus *test_start_get_bus(const TestData *s)
     cmdline = g_strdup_printf("-smp %d", s->num_cpus);
     qtest_start(cmdline);
     g_free(cmdline);
-    return qpci_init_pc(global_qtest, NULL);
+    return qpci_new_pc(global_qtest, NULL);
 }
 
 static void test_i440fx_defaults(gconstpointer opaque)
diff --git a/tests/ide-test.c b/tests/ide-test.c
index f0280e6..8f5adae 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -157,7 +157,7 @@ static QPCIDevice *get_pci_device(QPCIBar *bmdma_bar, QPCIBar *ide_bar)
     uint16_t vendor_id, device_id;
 
     if (!pcibus) {
-        pcibus = qpci_init_pc(global_qtest, NULL);
+        pcibus = qpci_new_pc(global_qtest, NULL);
     }
 
     /* Find PCI device and verify it's the right one */
diff --git a/tests/libqos/ahci.c b/tests/libqos/ahci.c
index 63fbc9e..cc1b08e 100644
--- a/tests/libqos/ahci.c
+++ b/tests/libqos/ahci.c
@@ -130,7 +130,7 @@ QPCIDevice *get_ahci_device(QTestState *qts, uint32_t *fingerprint)
     uint32_t ahci_fingerprint;
     QPCIBus *pcibus;
 
-    pcibus = qpci_init_pc(qts, NULL);
+    pcibus = qpci_new_pc(qts, NULL);
 
     /* Find the AHCI PCI device and verify it's the right one. */
     ahci = qpci_device_find(pcibus, QPCI_DEVFN(0x1F, 0x02));
diff --git a/tests/libqos/libqos-pc.c b/tests/libqos/libqos-pc.c
index a9c1ace..293f9b6 100644
--- a/tests/libqos/libqos-pc.c
+++ b/tests/libqos/libqos-pc.c
@@ -6,7 +6,7 @@
 static QOSOps qos_ops = {
     .init_allocator = pc_alloc_init_flags,
     .uninit_allocator = pc_alloc_uninit,
-    .qpci_init = qpci_init_pc,
+    .qpci_new = qpci_new_pc,
     .qpci_free = qpci_free_pc,
     .shutdown = qtest_pc_shutdown,
 };
diff --git a/tests/libqos/libqos-spapr.c b/tests/libqos/libqos-spapr.c
index a37791e..64addfe 100644
--- a/tests/libqos/libqos-spapr.c
+++ b/tests/libqos/libqos-spapr.c
@@ -6,7 +6,7 @@
 static QOSOps qos_ops = {
     .init_allocator = spapr_alloc_init_flags,
     .uninit_allocator = spapr_alloc_uninit,
-    .qpci_init = qpci_init_spapr,
+    .qpci_new = qpci_new_spapr,
     .qpci_free = qpci_free_spapr,
     .shutdown = qtest_spapr_shutdown,
 };
diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index c514187..6c91371 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -25,7 +25,7 @@ QOSState *qtest_vboot(QOSOps *ops, const char *cmdline_fmt, va_list ap)
     qs->ops = ops;
     if (ops) {
         qs->alloc = ops->init_allocator(qs->qts, ALLOC_NO_FLAGS);
-        qs->pcibus = ops->qpci_init(qs->qts, qs->alloc);
+        qs->pcibus = ops->qpci_new(qs->qts, qs->alloc);
     }
 
     g_free(cmdline);
diff --git a/tests/libqos/libqos.h b/tests/libqos/libqos.h
index 07d4b93..1af6035 100644
--- a/tests/libqos/libqos.h
+++ b/tests/libqos/libqos.h
@@ -10,7 +10,7 @@ typedef struct QOSState QOSState;
 typedef struct QOSOps {
     QGuestAllocator *(*init_allocator)(QTestState *qts, QAllocOpts);
     void (*uninit_allocator)(QGuestAllocator *);
-    QPCIBus *(*qpci_init)(QTestState *qts, QGuestAllocator *alloc);
+    QPCIBus *(*qpci_new)(QTestState *qts, QGuestAllocator *alloc);
     void (*qpci_free)(QPCIBus *bus);
     void (*shutdown)(QOSState *);
 } QOSOps;
diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index 585f528..d21f3e8 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -115,7 +115,7 @@ static void qpci_pc_config_writel(QPCIBus *bus, int devfn, uint8_t offset, uint3
     outl(0xcfc, value);
 }
 
-QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
+QPCIBus *qpci_new_pc(QTestState *qts, QGuestAllocator *alloc)
 {
     QPCIBusPC *ret = g_new0(QPCIBusPC, 1);
 
diff --git a/tests/libqos/pci-pc.h b/tests/libqos/pci-pc.h
index 491eeac..84cc300 100644
--- a/tests/libqos/pci-pc.h
+++ b/tests/libqos/pci-pc.h
@@ -16,7 +16,14 @@
 #include "libqos/pci.h"
 #include "libqos/malloc.h"
 
-QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc);
+/* qpci_new_pc():
+* this function creates a new QPCIBusPC object,
+ * and properly initialize its fields.
+ *
+ * returns the QPCIBus *bus field of a newly
+ * allocated QPCIBusPC.
+ */
+QPCIBus *qpci_new_pc(QTestState *qts, QGuestAllocator *alloc);
 void     qpci_free_pc(QPCIBus *bus);
 
 #endif
diff --git a/tests/libqos/pci-spapr.c b/tests/libqos/pci-spapr.c
index c0f7e6d..f306cb7 100644
--- a/tests/libqos/pci-spapr.c
+++ b/tests/libqos/pci-spapr.c
@@ -160,7 +160,7 @@ static void qpci_spapr_config_writel(QPCIBus *bus, int devfn, uint8_t offset,
 #define SPAPR_PCI_MMIO32_WIN_SIZE    0x80000000 /* 2 GiB */
 #define SPAPR_PCI_IO_WIN_SIZE        0x10000
 
-QPCIBus *qpci_init_spapr(QTestState *qts, QGuestAllocator *alloc)
+QPCIBus *qpci_new_spapr(QTestState *qts, QGuestAllocator *alloc)
 {
     QPCIBusSPAPR *ret = g_new0(QPCIBusSPAPR, 1);
 
diff --git a/tests/libqos/pci-spapr.h b/tests/libqos/pci-spapr.h
index 387686d..177e8c0 100644
--- a/tests/libqos/pci-spapr.h
+++ b/tests/libqos/pci-spapr.h
@@ -11,7 +11,7 @@
 #include "libqos/malloc.h"
 #include "libqos/pci.h"
 
-QPCIBus *qpci_init_spapr(QTestState *qts, QGuestAllocator *alloc);
+QPCIBus *qpci_new_spapr(QTestState *qts, QGuestAllocator *alloc);
 void     qpci_free_spapr(QPCIBus *bus);
 
 #endif
diff --git a/tests/q35-test.c b/tests/q35-test.c
index 7ea7acc..34b34bc 100644
--- a/tests/q35-test.c
+++ b/tests/q35-test.c
@@ -87,7 +87,7 @@ static void test_smram_lock(void)
 
     qtest_start("-M q35");
 
-    pcibus = qpci_init_pc(global_qtest, NULL);
+    pcibus = qpci_new_pc(global_qtest, NULL);
     g_assert(pcibus != NULL);
 
     pcidev = qpci_device_find(pcibus, 0);
@@ -146,7 +146,7 @@ static void test_tseg_size(const void *data)
     g_free(cmdline);
 
     /* locate the DRAM controller */
-    pcibus = qpci_init_pc(global_qtest, NULL);
+    pcibus = qpci_new_pc(global_qtest, NULL);
     g_assert(pcibus != NULL);
     pcidev = qpci_device_find(pcibus, 0);
     g_assert(pcidev != NULL);
diff --git a/tests/rtl8139-test.c b/tests/rtl8139-test.c
index 68bfc42..a85c91f 100644
--- a/tests/rtl8139-test.c
+++ b/tests/rtl8139-test.c
@@ -35,7 +35,7 @@ static QPCIDevice *get_device(void)
 {
     QPCIDevice *dev;
 
-    pcibus = qpci_init_pc(global_qtest, NULL);
+    pcibus = qpci_new_pc(global_qtest, NULL);
     qpci_device_foreach(pcibus, 0x10ec, 0x8139, save_fn, &dev);
     g_assert(dev != NULL);
 
diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 982f5eb..28d481b 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -187,7 +187,7 @@ static QSDHCI *machine_start(const struct sdhci_t *test)
         global_qtest = qtest_initf("-machine %s -device sdhci-pci",
                                    test->machine);
 
-        s->pci.bus = qpci_init_pc(global_qtest, NULL);
+        s->pci.bus = qpci_new_pc(global_qtest, NULL);
 
         /* Find PCI device and verify it's the right one */
         s->pci.dev = qpci_device_find(s->pci.bus, QPCI_DEVFN(4, 0));
diff --git a/tests/tco-test.c b/tests/tco-test.c
index 6bee9a3..f89a42c 100644
--- a/tests/tco-test.c
+++ b/tests/tco-test.c
@@ -64,7 +64,7 @@ static void test_init(TestData *d)
     global_qtest = qs;
     qtest_irq_intercept_in(qs, "ioapic");
 
-    d->bus = qpci_init_pc(qs, NULL);
+    d->bus = qpci_new_pc(qs, NULL);
     d->dev = qpci_device_find(d->bus, QPCI_DEVFN(0x1f, 0x00));
     g_assert(d->dev != NULL);
 
diff --git a/tests/usb-hcd-ehci-test.c b/tests/usb-hcd-ehci-test.c
index f28ea27..8bc3e44 100644
--- a/tests/usb-hcd-ehci-test.c
+++ b/tests/usb-hcd-ehci-test.c
@@ -52,7 +52,7 @@ static void ehci_port_test(struct qhc *hc, int port, uint32_t expect)
 
 static void test_init(void)
 {
-    pcibus = qpci_init_pc(global_qtest, NULL);
+    pcibus = qpci_new_pc(global_qtest, NULL);
     g_assert(pcibus != NULL);
 
     qusb_pci_init_one(pcibus, &uhci1, QPCI_DEVFN(0x1d, 0), 4);
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index df8edb3..3414075 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -193,7 +193,7 @@ static void init_virtio_dev(QTestState *qts, TestServer *s, uint32_t features_ma
     uint32_t features;
     int i;
 
-    s->bus = qpci_init_pc(qts, NULL);
+    s->bus = qpci_new_pc(qts, NULL);
     g_assert_nonnull(s->bus);
 
     s->dev = qvirtio_pci_device_find(s->bus, VIRTIO_ID_NET);
-- 
1.8.3.1
