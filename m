Received: from eggs.gnu.org ([2001:4830:134:3::10]:51982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEp-0000Po-76
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEo-0004s2-8m
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqEn-0004r8-Vu
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:22 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:45 +0100
Message-Id: <1543851204-41186-33-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 32/71] tests/libqos: has_buggy_msi flag
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
index 041bfed..4247cda 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -123,6 +123,9 @@ void qpci_init_pc(QPCIBusPC *qpci, QTestState *qts, QGuestAllocator *alloc)
 {
     assert(qts);
 
+    /* tests can use pci-bus */
+    qpci->bus.has_buggy_msi = FALSE;
+
     qpci->bus.pio_readb = qpci_pc_pio_readb;
     qpci->bus.pio_readw = qpci_pc_pio_readw;
     qpci->bus.pio_readl = qpci_pc_pio_readl;
diff --git a/tests/libqos/pci-spapr.c b/tests/libqos/pci-spapr.c
index 24f2c2c..502a0e5 100644
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
