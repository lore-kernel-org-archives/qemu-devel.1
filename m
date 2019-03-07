Received: from eggs.gnu.org ([209.51.188.92]:39454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqi-00035X-Hi
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqh-00082Z-Ib
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:28 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:35437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wqh-00081s-A9
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:27 -0500
Received: by mail-wm1-x32d.google.com with SMTP id y15so10118955wma.0
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:27 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:25 +0100
Message-Id: <1551979804-6060-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/57] tests/libqos: has_buggy_msi flag
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

The Qgraph framework makes any test using
pci bus run the same function using pci-pci and
pci-spapr bus. However, some tests are not ready to use
the spapr bus, due to a MSI bug. Until it does not get
fixed, this flag allows them to skip the test

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/libqos/pci-pc.c    |  3 +++
 tests/libqos/pci-spapr.c |  3 +++
 tests/libqos/pci.c       | 14 ++++++++++++++
 tests/libqos/pci.h       |  4 ++++
 4 files changed, 24 insertions(+)

diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index d729ad4..4ab16fa 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -124,6 +124,9 @@ void qpci_init_pc(QPCIBusPC *qpci, QTestState *qts, QGuestAllocator *alloc)
 {
     assert(qts);
 
+    /* tests can use pci-bus */
+    qpci->bus.has_buggy_msi = FALSE;
+
     qpci->bus.pio_readb = qpci_pc_pio_readb;
     qpci->bus.pio_readw = qpci_pc_pio_readw;
     qpci->bus.pio_readl = qpci_pc_pio_readl;
diff --git a/tests/libqos/pci-spapr.c b/tests/libqos/pci-spapr.c
index d9b87a7..6925925 100644
--- a/tests/libqos/pci-spapr.c
+++ b/tests/libqos/pci-spapr.c
@@ -155,6 +155,9 @@ void qpci_init_spapr(QPCIBusSPAPR *qpci, QTestState *qts,
 {
     assert(qts);
 
+    /* tests cannot use spapr, needs to be fixed first */
+    qpci->bus.has_buggy_msi = TRUE;
+
     qpci->alloc = alloc;
 
     qpci->bus.pio_readb = qpci_spapr_pio_readb;
diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
index 8257904..662ee7a 100644
--- a/tests/libqos/pci.c
+++ b/tests/libqos/pci.c
@@ -51,6 +51,20 @@ void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
     }
 }
 
+bool qpci_has_buggy_msi(QPCIDevice *dev)
+{
+    return dev->bus->has_buggy_msi;
+}
+
+bool qpci_check_buggy_msi(QPCIDevice *dev)
+{
+    if (qpci_has_buggy_msi(dev)) {
+        g_test_skip("Skipping due to incomplete support for MSI");
+        return true;
+    }
+    return false;
+}
+
 static void qpci_device_set(QPCIDevice *dev, QPCIBus *bus, int devfn)
 {
     g_assert(dev);
diff --git a/tests/libqos/pci.h b/tests/libqos/pci.h
index 9fd521a..8e1d292 100644
--- a/tests/libqos/pci.h
+++ b/tests/libqos/pci.h
@@ -53,6 +53,7 @@ struct QPCIBus {
     QTestState *qts;
     uint16_t pio_alloc_ptr;
     uint64_t mmio_alloc_ptr, mmio_limit;
+    bool has_buggy_msi; /* TRUE for spapr, FALSE for pci */
 
 };
 
@@ -81,6 +82,9 @@ void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
 QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn);
 void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr);
 
+bool qpci_has_buggy_msi(QPCIDevice *dev);
+bool qpci_check_buggy_msi(QPCIDevice *dev);
+
 void qpci_device_enable(QPCIDevice *dev);
 uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id);
 void qpci_msix_enable(QPCIDevice *dev);
-- 
1.8.3.1
