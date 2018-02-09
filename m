Received: from eggs.gnu.org ([2001:4830:134:3::10]:41164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ekC0H-00041G-A7
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:58:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ekC0G-0007uy-73
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:58:25 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Feb 2018 16:58:07 +0000
Message-Id: <20180209165810.6668-9-peter.maydell@linaro.org>
In-Reply-To: <20180209165810.6668-1-peter.maydell@linaro.org>
References: <20180209165810.6668-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 08/11] hw/intc/armv7m_nvic: Fix
 byte-to-interrupt number conversions
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

In many of the NVIC registers relating to interrupts, we
have to convert from a byte offset within a register set
into the number of the first interrupt which is affected.
We were getting this wrong for:
 * reads of NVIC_ISPR<n>, NVIC_ISER<n>, NVIC_ICPR<n>, NVIC_ICER<n>,
   NVIC_IABR<n> -- in all these cases we were missing the "* 8"
   needed to convert from the byte offset to the interrupt number
   (since all these registers use one bit per interrupt)
 * writes of NVIC_IPR<n> had the opposite problem of a spurious
   "* 8" (since these registers use one byte per interrupt)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/intc/armv7m_nvic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index ea3b7cce14..c51151fa8a 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1724,7 +1724,7 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
         /* fall through */
     case 0x180 ... 0x1bf: /* NVIC Clear enable */
         val = 0;
-        startvec = offset - 0x180 + NVIC_FIRST_IRQ; /* vector # */
+        startvec = 8 * (offset - 0x180) + NVIC_FIRST_IRQ; /* vector # */
 
         for (i = 0, end = size * 8; i < end && startvec + i < s->num_irq; i++) {
             if (s->vectors[startvec + i].enabled &&
@@ -1738,7 +1738,7 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
         /* fall through */
     case 0x280 ... 0x2bf: /* NVIC Clear pend */
         val = 0;
-        startvec = offset - 0x280 + NVIC_FIRST_IRQ; /* vector # */
+        startvec = 8 * (offset - 0x280) + NVIC_FIRST_IRQ; /* vector # */
         for (i = 0, end = size * 8; i < end && startvec + i < s->num_irq; i++) {
             if (s->vectors[startvec + i].pending &&
                 (attrs.secure || s->itns[startvec + i])) {
@@ -1748,7 +1748,7 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
         break;
     case 0x300 ... 0x33f: /* NVIC Active */
         val = 0;
-        startvec = offset - 0x300 + NVIC_FIRST_IRQ; /* vector # */
+        startvec = 8 * (offset - 0x300) + NVIC_FIRST_IRQ; /* vector # */
 
         for (i = 0, end = size * 8; i < end && startvec + i < s->num_irq; i++) {
             if (s->vectors[startvec + i].active &&
@@ -1863,7 +1863,7 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
     case 0x300 ... 0x33f: /* NVIC Active */
         return MEMTX_OK; /* R/O */
     case 0x400 ... 0x5ef: /* NVIC Priority */
-        startvec = 8 * (offset - 0x400) + NVIC_FIRST_IRQ; /* vector # */
+        startvec = (offset - 0x400) + NVIC_FIRST_IRQ; /* vector # */
 
         for (i = 0; i < size && startvec + i < s->num_irq; i++) {
             if (attrs.secure || s->itns[startvec + i]) {
-- 
2.16.1
