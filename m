Received: from eggs.gnu.org ([209.51.188.92]:44544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSas-00010o-4t
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSar-0002Bt-2J
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:46 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLSaq-0002BR-Ry
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:45 -0400
Received: by mail-wm1-x343.google.com with SMTP id b10so3765812wmj.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 06:14:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 14:14:37 +0100
Message-Id: <20190430131439.25251-3-peter.maydell@linaro.org>
In-Reply-To: <20190430131439.25251-1-peter.maydell@linaro.org>
References: <20190430131439.25251-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/4] hw/intc/armv7m_nvic: NS BFAR and BFSR are
 RAZ/WI if BFHFNMINS == 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org

The non-secure versions of the BFAR and BFSR registers are
supposed to be RAZ/WI if AICR.BFHFNMINS == 0; we were
incorrectly allowing NS code to access the real values.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 131b5938b9a..15cba63c964 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1167,6 +1167,10 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
+        if (!attrs.secure &&
+            !(s->cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK)) {
+            return 0;
+        }
         return cpu->env.v7m.bfar;
     case 0xd3c: /* Aux Fault Status.  */
         /* TODO: Implement fault status registers.  */
@@ -1646,6 +1650,10 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
+        if (!attrs.secure &&
+            !(s->cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK)) {
+            return;
+        }
         cpu->env.v7m.bfar = value;
         return;
     case 0xd3c: /* Aux Fault Status.  */
@@ -2130,11 +2138,18 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
             val = 0;
             break;
         };
-        /* The BFSR bits [15:8] are shared between security states
-         * and we store them in the NS copy
+        /*
+         * The BFSR bits [15:8] are shared between security states
+         * and we store them in the NS copy. They are RAZ/WI for
+         * NS code if AIRCR.BFHFNMINS is 0.
          */
         val = s->cpu->env.v7m.cfsr[attrs.secure];
-        val |= s->cpu->env.v7m.cfsr[M_REG_NS] & R_V7M_CFSR_BFSR_MASK;
+        if (!attrs.secure &&
+            !(s->cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK)) {
+            val &= ~R_V7M_CFSR_BFSR_MASK;
+        } else {
+            val |= s->cpu->env.v7m.cfsr[M_REG_NS] & R_V7M_CFSR_BFSR_MASK;
+        }
         val = extract32(val, (offset - 0xd28) * 8, size * 8);
         break;
     case 0xfe0 ... 0xfff: /* ID.  */
@@ -2249,6 +2264,12 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
          */
         value <<= ((offset - 0xd28) * 8);
 
+        if (!attrs.secure &&
+            !(s->cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK)) {
+            /* BFSR bits are RAZ/WI for NS if BFHFNMINS is set */
+            value &= ~R_V7M_CFSR_BFSR_MASK;
+        }
+
         s->cpu->env.v7m.cfsr[attrs.secure] &= ~value;
         if (attrs.secure) {
             /* The BFSR bits [15:8] are shared between security states
-- 
2.20.1
