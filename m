Received: from eggs.gnu.org ([2001:4830:134:3::10]:43673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e7O5y-0000Tc-QQ
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e7O5w-0006z2-6h
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:59:54 -0400
Received: from chuckie.co.uk ([82.165.15.123]:58395
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e7O5v-0006xw-Vm
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:59:52 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 25 Oct 2017 16:59:19 +0100
Message-Id: <1508947167-5304-6-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv4 05/13] sun4m_iommu: move TYPE_SUN4M_IOMMU
 declaration to sun4m.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This is in preparation to allow the type to be used elsewhere.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/dma/sun4m_iommu.c     |   14 --------------
 include/hw/sparc/sun4m.h |   16 ++++++++++++++++
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/hw/dma/sun4m_iommu.c b/hw/dma/sun4m_iommu.c
index 335ef63..840064b 100644
--- a/hw/dma/sun4m_iommu.c
+++ b/hw/dma/sun4m_iommu.c
@@ -36,7 +36,6 @@
  * http://mediacast.sun.com/users/Barton808/media/Sun4M_SystemArchitecture_edited2.pdf
  */
 
-#define IOMMU_NREGS         (4*4096/4)
 #define IOMMU_CTRL          (0x0000 >> 2)
 #define IOMMU_CTRL_IMPL     0xf0000000 /* Implementation */
 #define IOMMU_CTRL_VERS     0x0f000000 /* Version */
@@ -128,19 +127,6 @@
 #define IOMMU_PAGE_SIZE     (1 << IOMMU_PAGE_SHIFT)
 #define IOMMU_PAGE_MASK     ~(IOMMU_PAGE_SIZE - 1)
 
-#define TYPE_SUN4M_IOMMU "iommu"
-#define SUN4M_IOMMU(obj) OBJECT_CHECK(IOMMUState, (obj), TYPE_SUN4M_IOMMU)
-
-typedef struct IOMMUState {
-    SysBusDevice parent_obj;
-
-    MemoryRegion iomem;
-    uint32_t regs[IOMMU_NREGS];
-    hwaddr iostart;
-    qemu_irq irq;
-    uint32_t version;
-} IOMMUState;
-
 static uint64_t iommu_mem_read(void *opaque, hwaddr addr,
                                unsigned size)
 {
diff --git a/include/hw/sparc/sun4m.h b/include/hw/sparc/sun4m.h
index 580d87b..1f1cf91 100644
--- a/include/hw/sparc/sun4m.h
+++ b/include/hw/sparc/sun4m.h
@@ -4,10 +4,26 @@
 #include "qemu-common.h"
 #include "exec/hwaddr.h"
 #include "qapi/qmp/types.h"
+#include "hw/sysbus.h"
 
 /* Devices used by sparc32 system.  */
 
 /* iommu.c */
+#define TYPE_SUN4M_IOMMU "iommu"
+#define SUN4M_IOMMU(obj) OBJECT_CHECK(IOMMUState, (obj), TYPE_SUN4M_IOMMU)
+
+#define IOMMU_NREGS         (4 * 4096 / 4)
+
+typedef struct IOMMUState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t regs[IOMMU_NREGS];
+    hwaddr iostart;
+    qemu_irq irq;
+    uint32_t version;
+} IOMMUState;
+
 void sparc_iommu_memory_rw(void *opaque, hwaddr addr,
                                  uint8_t *buf, int len, int is_write);
 static inline void sparc_iommu_memory_read(void *opaque,
-- 
1.7.10.4
