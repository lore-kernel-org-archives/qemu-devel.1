Received: from eggs.gnu.org ([2001:4830:134:3::10]:42179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frkuH-0003hf-2r
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frkuG-0007Qn-Dl
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:45 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 15:11:14 +0100
Message-Id: <20180820141116.9118-21-peter.maydell@linaro.org>
In-Reply-To: <20180820141116.9118-1-peter.maydell@linaro.org>
References: <20180820141116.9118-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 20/22] hw/ssi/pl022: Correct wrong DMACR and
 ICR handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

In the PL022, register offset 0x20 is the ICR, a write-only
interrupt-clear register.  Register offset 0x24 is DMACR, the DMA
control register.  We were incorrectly implementing (a stub version
of) DMACR at 0x20, and not implementing anything at 0x24.  Fix this
bug.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/pl022.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
index d310671d18e..e58247554cc 100644
--- a/hw/ssi/pl022.c
+++ b/hw/ssi/pl022.c
@@ -146,7 +146,7 @@ static uint64_t pl022_read(void *opaque, hwaddr offset,
         return s->is;
     case 0x1c: /* MIS */
         return s->im & s->is;
-    case 0x20: /* DMACR */
+    case 0x24: /* DMACR */
         /* Not implemented.  */
         return 0;
     default:
@@ -192,7 +192,15 @@ static void pl022_write(void *opaque, hwaddr offset,
         s->im = value;
         pl022_update(s);
         break;
-    case 0x20: /* DMACR */
+    case 0x20: /* ICR */
+        /*
+         * write-1-to-clear: bit 0 clears ROR, bit 1 clears RT;
+         * RX and TX interrupts cannot be cleared this way.
+         */
+        value &= PL022_INT_ROR | PL022_INT_RT;
+        s->is &= ~value;
+        break;
+    case 0x24: /* DMACR */
         if (value) {
             qemu_log_mask(LOG_UNIMP, "pl022: DMA not implemented\n");
         }
-- 
2.18.0
