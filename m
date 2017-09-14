Received: from eggs.gnu.org ([2001:4830:134:3::10]:46452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJY-00084s-W0
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJY-0007xK-35
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dsYJX-0007vb-Sc
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:36 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJW-0005tE-JJ
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 18:52:34 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 18:52:50 +0100
Message-Id: <1505411573-27848-16-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
References: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 15/18] hw/pci-host/gpex: Set INTx index/gsi
 mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>

To implement INTx to gsi routing we need to pass the gpex host
bridge the gsi associated to each INTx index. Let's introduce
irq_num array and gpex_set_irq_num setter function.

Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Feng Kan <fkan@apm.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 1505296004-6798-2-git-send-email-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/pci-host/gpex.h |  3 +++
 hw/pci-host/gpex.c         | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
index 68c9348..aef38b8 100644
--- a/include/hw/pci-host/gpex.h
+++ b/include/hw/pci-host/gpex.h
@@ -51,6 +51,9 @@ typedef struct GPEXHost {
     MemoryRegion io_ioport;
     MemoryRegion io_mmio;
     qemu_irq irq[GPEX_NUM_IRQS];
+    int irq_num[GPEX_NUM_IRQS];
 } GPEXHost;
 
+int gpex_set_irq_num(GPEXHost *s, int index, int gsi);
+
 #endif /* HW_GPEX_H */
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 83084b9..41a884d 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -43,6 +43,16 @@ static void gpex_set_irq(void *opaque, int irq_num, int level)
     qemu_set_irq(s->irq[irq_num], level);
 }
 
+int gpex_set_irq_num(GPEXHost *s, int index, int gsi)
+{
+    if (index >= GPEX_NUM_IRQS) {
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
-- 
2.7.4
