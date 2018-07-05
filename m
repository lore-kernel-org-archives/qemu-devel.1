Received: from eggs.gnu.org ([2001:4830:134:3::10]:36136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fbC9u-0000PW-Gh
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 17:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fbC9t-0000Bd-Ev
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 17:51:26 -0400
Received: from smtp39.i.mail.ru ([94.100.177.99]:52184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fbC9t-0000Ao-6x
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 17:51:25 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Fri,  6 Jul 2018 00:50:51 +0300
Message-Id: <20180705215052.8795-2-jusual@mail.ru>
In-Reply-To: <20180705215052.8795-1-jusual@mail.ru>
References: <20180705215052.8795-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v2 1/2] nvic: Handle ARMv6-M SCS reserved
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

Handle SCS reserved registers listed in ARMv6-M ARM D3.6.1.
All reserved registers are RAZ/WI. ARM_FEATURE_M_MAIN is used for the
checks, because these registers are reserved in ARMv8-M Baseline too.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 hw/intc/armv7m_nvic.c | 51 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index aba4510c70..7f71b336bd 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -865,6 +865,9 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         }
         return val;
     case 0xd10: /* System Control.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            goto bad_offset;
+        }
         return cpu->env.v7m.scr[attrs.secure];
     case 0xd14: /* Configuration Control.  */
         /* The BFHFNMIGN bit is the only non-banked bit; we
@@ -986,12 +989,21 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         }
         return val;
     case 0xd2c: /* Hard Fault Status.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
         return cpu->env.v7m.hfsr;
     case 0xd30: /* Debug Fault Status.  */
         return cpu->env.v7m.dfsr;
     case 0xd34: /* MMFAR MemManage Fault Address */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
         return cpu->env.v7m.mmfar[attrs.secure];
     case 0xd38: /* Bus Fault Address.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
         return cpu->env.v7m.bfar;
     case 0xd3c: /* Aux Fault Status.  */
         /* TODO: Implement fault status registers.  */
@@ -1287,6 +1299,9 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         }
         break;
     case 0xd10: /* System Control.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            goto bad_offset;
+        }
         /* We don't implement deep-sleep so these bits are RAZ/WI.
          * The other bits in the register are banked.
          * QEMU's implementation ignores SEVONPEND and SLEEPONEXIT, which
@@ -1388,15 +1403,24 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         nvic_irq_update(s);
         break;
     case 0xd2c: /* Hard Fault Status.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
         cpu->env.v7m.hfsr &= ~value; /* W1C */
         break;
     case 0xd30: /* Debug Fault Status.  */
         cpu->env.v7m.dfsr &= ~value; /* W1C */
         break;
     case 0xd34: /* Mem Manage Address.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+           goto bad_offset;
+        }
         cpu->env.v7m.mmfar[attrs.secure] = value;
         return;
     case 0xd38: /* Bus Fault Address.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
         cpu->env.v7m.bfar = value;
         return;
     case 0xd3c: /* Aux Fault Status.  */
@@ -1626,6 +1650,11 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
     case 0xf00: /* Software Triggered Interrupt Register */
     {
         int excnum = (value & 0x1ff) + NVIC_FIRST_IRQ;
+
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
+
         if (excnum < s->num_irq) {
             armv7m_nvic_set_pending(s, excnum, false);
         }
@@ -1775,7 +1804,13 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
             }
         }
         break;
-    case 0xd18 ... 0xd23: /* System Handler Priority (SHPR1, SHPR2, SHPR3) */
+    case 0xd18: /* System Handler Priority (SHPR1) */
+        if (!arm_feature(&s->cpu->env, ARM_FEATURE_M_MAIN)) {
+            val = 0;
+            break;
+        }
+        /* fall through */
+    case 0xd1c ... 0xd23: /* System Handler Priority (SHPR2, SHPR3) */
         val = 0;
         for (i = 0; i < size; i++) {
             unsigned hdlidx = (offset - 0xd14) + i;
@@ -1788,6 +1823,10 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
         }
         break;
     case 0xd28 ... 0xd2b: /* Configurable Fault Status (CFSR) */
+        if (!arm_feature(&s->cpu->env, ARM_FEATURE_M_MAIN)) {
+            val = 0;
+            break;
+        };
         /* The BFSR bits [15:8] are shared between security states
          * and we store them in the NS copy
          */
@@ -1882,7 +1921,12 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
         }
         nvic_irq_update(s);
         return MEMTX_OK;
-    case 0xd18 ... 0xd23: /* System Handler Priority (SHPR1, SHPR2, SHPR3) */
+    case 0xd18: /* System Handler Priority (SHPR1) */
+        if (!arm_feature(&s->cpu->env, ARM_FEATURE_M_MAIN)) {
+            return MEMTX_OK;
+        }
+        /* fall through */
+    case 0xd1c ... 0xd23: /* System Handler Priority (SHPR2, SHPR3) */
         for (i = 0; i < size; i++) {
             unsigned hdlidx = (offset - 0xd14) + i;
             int newprio = extract32(value, i * 8, 8);
@@ -1896,6 +1940,9 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
         nvic_irq_update(s);
         return MEMTX_OK;
     case 0xd28 ... 0xd2b: /* Configurable Fault Status (CFSR) */
+        if (!arm_feature(&s->cpu->env, ARM_FEATURE_M_MAIN)) {
+            return MEMTX_OK;
+        }
         /* All bits are W1C, so construct 32 bit value with 0s in
          * the parts not written by the access size
          */
-- 
2.17.1
