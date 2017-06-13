Received: from eggs.gnu.org ([2001:4830:134:3::10]:47852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dKlv1-0007gc-9l
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dKlv0-0008En-Jp
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:31:39 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 13 Jun 2017 15:31:15 +0200
Message-Id: <1497360677-4780-2-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1497360677-4780-1-git-send-email-eric.auger@redhat.com>
References: <1497360677-4780-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/3] hw/pci-host/gpex: Set INTx index/gsi
 mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: christoffer.dall@linaro.org, agraf@suse.de, pranavkumar@linaro.org, drjones@redhat.com, wei@redhat.com

From: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>

To implement INTx to gsi routing we need to pass the gpex host
bridge the gsi associated to each INTx index. Let's introduce
irq_num array and gpex_set_irq_num setter function.

Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/pci-host/gpex.c         | 10 ++++++++++
 include/hw/pci-host/gpex.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index e2629ce..22367aa4 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -43,6 +43,16 @@ static void gpex_set_irq(void *opaque, int irq_num, int level)
     qemu_set_irq(s->irq[irq_num], level);
 }
 
+int gpex_set_irq_num(GPEXHost *s, int index, uint32_t gsi)
+{
+    if (index >=  GPEX_NUM_IRQS) {
+        return -EINVAL;
+    }
+
+    s->irq_num[index] = gsi;
+    return 0;
+}
+
 static void gpex_host_realize(DeviceState *dev, Error **errp)
 {
     PCIHostState *pci = PCI_HOST_BRIDGE(dev);
diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
index 68c9348..db26b3e 100644
--- a/include/hw/pci-host/gpex.h
+++ b/include/hw/pci-host/gpex.h
@@ -51,6 +51,9 @@ typedef struct GPEXHost {
     MemoryRegion io_ioport;
     MemoryRegion io_mmio;
     qemu_irq irq[GPEX_NUM_IRQS];
+    uint32_t irq_num[GPEX_NUM_IRQS];
 } GPEXHost;
 
+int gpex_set_irq_num(GPEXHost *s, int index, uint32_t gsi);
+
 #endif /* HW_GPEX_H */
-- 
2.5.5
