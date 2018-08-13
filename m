Received: from eggs.gnu.org ([2001:4830:134:3::10]:43639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9sj-0007Hi-AD
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9si-00026v-9B
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:15:25 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 13 Aug 2018 12:14:30 +0200
Message-Id: <20180813101453.10200-11-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
References: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 10/33] tests/qgraph: has_buggy_msi flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, John Snow <jsnow@redhat.com>, Amit Shah <amit@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Greg Kurz <groug@kaod.org>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

The Qgraph framework makes any test using
pci bus run the same function using pci-pci and
pci-spapr bus. However, some tests are not ready to use
the spapr bus, due to a MSI bug. Until it does not get
fixed, this flag allows them to skip the test

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/libqos/pci-pc.c    | 3 +++
 tests/libqos/pci-spapr.c | 3 +++
 tests/libqos/pci.c       | 5 +++++
 tests/libqos/pci.h       | 3 +++
 4 files changed, 14 insertions(+)

diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index 93cbfbce6b..0cf87f51b5 100644
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
index 24f2c2c60d..502a0e5129 100644
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
index 080e87533e..d5bace9d6a 100644
--- a/tests/libqos/pci.c
+++ b/tests/libqos/pci.c
@@ -51,6 +51,11 @@ void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
     }
 }
 
+bool qpci_has_buggy_msi(QPCIDevice *dev)
+{
+    return dev->bus->has_buggy_msi;
+}
+
 static void qpci_device_set(QPCIDevice *dev, QPCIBus *bus, int devfn)
 {
     g_assert(dev);
diff --git a/tests/libqos/pci.h b/tests/libqos/pci.h
index bcfa6d85a4..5fb3c550c5 100644
--- a/tests/libqos/pci.h
+++ b/tests/libqos/pci.h
@@ -53,6 +53,7 @@ struct QPCIBus {
     QTestState *qts;
     uint16_t pio_alloc_ptr;
     uint64_t mmio_alloc_ptr, mmio_limit;
+    bool has_buggy_msi; /* TRUE for spapr, FALSE for pci */
 
 };
 
@@ -80,6 +81,8 @@ void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
                          void *data);
 QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn);
 void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr);
+/* returns the bus has_buggy_msi flag */
+bool qpci_has_buggy_msi(QPCIDevice *dev);
 
 void qpci_device_enable(QPCIDevice *dev);
 uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id);
-- 
2.17.1
