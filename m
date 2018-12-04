Received: from eggs.gnu.org ([2001:4830:134:3::10]:58199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gUAmG-0007uo-Nz
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:30:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gUAmC-0001C4-VT
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:30:16 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  4 Dec 2018 13:29:50 +0000
Message-Id: <20181204132952.2601-4-peter.maydell@linaro.org>
In-Reply-To: <20181204132952.2601-1-peter.maydell@linaro.org>
References: <20181204132952.2601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/5] hw/sd/sdhci: Don't leak memory region in
 sdhci_sysbus_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

In sdhci_sysbus_realize() we override the initialization of
s->iomem that sdhci_common_realize() performs. However we
don't destroy the old memory region before reinitializing
it, which means that the memory allocated for mr->name in
memory_region_do_init() is leaked.

Since sdhci_initfn() already initializes s->io_ops to
&sdhci_mmio_ops, always use that in sdhci_common_realize()
and remove the now-unnecessary reinitialization of the
MMIO region from sdhci_sysbus_realize().

Spotted by clang's leak sanitizer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sdhci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 81bbf032794..83f1574ffdc 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1371,7 +1371,7 @@ static void sdhci_common_realize(SDHCIState *s, Error **errp)
     s->buf_maxsz = sdhci_get_fifolen(s);
     s->fifo_buffer = g_malloc0(s->buf_maxsz);
 
-    memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "sdhci",
+    memory_region_init_io(&s->iomem, OBJECT(s), s->io_ops, s, "sdhci",
                           SDHC_REGISTERS_MAP_SIZE);
 }
 
@@ -1565,9 +1565,6 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
 
     sysbus_init_irq(sbd, &s->irq);
 
-    memory_region_init_io(&s->iomem, OBJECT(s), s->io_ops, s, "sdhci",
-            SDHC_REGISTERS_MAP_SIZE);
-
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-- 
2.19.2
