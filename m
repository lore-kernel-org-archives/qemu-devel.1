Received: from eggs.gnu.org ([2001:4830:134:3::10]:40206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eNJOk-0004iL-SY
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:13:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eNJOj-0001Tr-QU
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:13:06 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Dec 2017 14:12:52 +0000
Message-Id: <1512742372-31517-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] hw/intc/armv7m: Support byte and halfword
 accesses to CFSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Andy Gross <andy.gross@linaro.org>

The Configurable Fault Status Register for ARMv7M and v8M is
supposed to be byte and halfword accessible, but we were only
implementing word accesses. Add support for the other access
sizes, which are used by the Zephyr RTOS.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reported-by: Andy Gross <andy.gross@linaro.org>
---
 hw/intc/armv7m_nvic.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 5d9c883..dc8e2f1 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -896,13 +896,6 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
             val |= (1 << 8);
         }
         return val;
-    case 0xd28: /* Configurable Fault Status.  */
-        /* The BFSR bits [15:8] are shared between security states
-         * and we store them in the NS copy
-         */
-        val = cpu->env.v7m.cfsr[attrs.secure];
-        val |= cpu->env.v7m.cfsr[M_REG_NS] & R_V7M_CFSR_BFSR_MASK;
-        return val;
     case 0xd2c: /* Hard Fault Status.  */
         return cpu->env.v7m.hfsr;
     case 0xd30: /* Debug Fault Status.  */
@@ -1280,15 +1273,6 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         s->vectors[ARMV7M_EXCP_DEBUG].active = (value & (1 << 8)) != 0;
         nvic_irq_update(s);
         break;
-    case 0xd28: /* Configurable Fault Status.  */
-        cpu->env.v7m.cfsr[attrs.secure] &= ~value; /* W1C */
-        if (attrs.secure) {
-            /* The BFSR bits [15:8] are shared between security states
-             * and we store them in the NS copy.
-             */
-            cpu->env.v7m.cfsr[M_REG_NS] &= ~(value & R_V7M_CFSR_BFSR_MASK);
-        }
-        break;
     case 0xd2c: /* Hard Fault Status.  */
         cpu->env.v7m.hfsr &= ~value; /* W1C */
         break;
@@ -1667,6 +1651,14 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
             val = deposit32(val, i * 8, 8, get_prio(s, hdlidx, sbank));
         }
         break;
+    case 0xd28 ... 0xd2b: /* Configurable Fault Status (CFSR) */
+        /* The BFSR bits [15:8] are shared between security states
+         * and we store them in the NS copy
+         */
+        val = s->cpu->env.v7m.cfsr[attrs.secure];
+        val |= s->cpu->env.v7m.cfsr[M_REG_NS] & R_V7M_CFSR_BFSR_MASK;
+        val = extract32(val, (offset - 0xd28) * 8, size * 8);
+        break;
     case 0xfe0 ... 0xfff: /* ID.  */
         if (offset & 3) {
             val = 0;
@@ -1765,6 +1757,20 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
         }
         nvic_irq_update(s);
         return MEMTX_OK;
+    case 0xd28 ... 0xd2b: /* Configurable Fault Status (CFSR) */
+        /* All bits are W1C, so construct 32 bit value with 0s in
+         * the parts not written by the access size
+         */
+        value <<= ((offset - 0xd28) * 8);
+
+        s->cpu->env.v7m.cfsr[attrs.secure] &= ~value;
+        if (attrs.secure) {
+            /* The BFSR bits [15:8] are shared between security states
+             * and we store them in the NS copy.
+             */
+            s->cpu->env.v7m.cfsr[M_REG_NS] &= ~(value & R_V7M_CFSR_BFSR_MASK);
+        }
+        return MEMTX_OK;
     }
     if (size == 4) {
         nvic_writel(s, offset, value, attrs);
-- 
2.7.4
