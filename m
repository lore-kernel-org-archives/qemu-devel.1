Received: from eggs.gnu.org ([2001:4830:134:3::10]:54628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1etg53-0004cV-58
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 15:54:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1etg50-0007HE-13
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 15:54:33 -0500
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 7 Mar 2018 21:43:59 +0100
Message-Id: <20180307205427.3A2877456C6@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH] ppc440_pcix: Add dummy implementation of
 BRDGOPT registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

I don't know what should be the correct implementation for these so
these are just stored and returned as is without doing anything for
now only to silence warnings when u-boot accesses these registers.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc440_pcix.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index ab2626a..3f177d3 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -55,6 +55,8 @@ typedef struct PPC440PCIXState {
     PCIDevice *dev;
     struct PLBOutMap pom[PPC440_PCIX_NR_POMS];
     struct PLBInMap pim[PPC440_PCIX_NR_PIMS];
+    uint32_t brdgopt1;
+    uint32_t brdgopt2;
     uint32_t sts;
     qemu_irq irq[PCI_NUM_PINS];
     AddressSpace bm_as;
@@ -95,6 +97,8 @@ typedef struct PPC440PCIXState {
 #define PCIX0_PIM0SAH       0xf8
 #define PCIX0_PIM2SAH       0xfc
 
+#define PCIX0_BRDGOPT1      0x40
+#define PCIX0_BRDGOPT2      0x44
 #define PCIX0_STS           0xe0
 
 #define PCI_ALL_SIZE        (PPC440_REG_BASE + PPC440_REG_SIZE)
@@ -270,6 +274,12 @@ static void ppc440_pcix_reg_write4(void *opaque, hwaddr addr,
         ppc440_pcix_update_pim(s, 2);
         break;
 
+    case PCIX0_BRDGOPT1:
+        s->brdgopt1 = val;
+        break;
+    case PCIX0_BRDGOPT2:
+        s->brdgopt2 = val;
+        break;
     case PCIX0_STS:
         s->sts = val;
         break;
@@ -365,6 +375,12 @@ static uint64_t ppc440_pcix_reg_read4(void *opaque, hwaddr addr,
         val = s->pim[2].la >> 32;
         break;
 
+    case PCIX0_BRDGOPT1:
+        val = s->brdgopt1;
+        break;
+    case PCIX0_BRDGOPT2:
+        val = s->brdgopt2;
+        break;
     case PCIX0_STS:
         val = s->sts;
         break;
@@ -408,6 +424,8 @@ static void ppc440_pcix_reset(DeviceState *dev)
     for (i = 0; i < PPC440_PCIX_NR_PIMS; i++) {
         s->pim[i].sa = 0xffffffff00000000ULL;
     }
+    s->brdgopt1 = 0;
+    s->brdgopt2 = 0;
     s->sts = 0;
 }
 
-- 
2.7.6
