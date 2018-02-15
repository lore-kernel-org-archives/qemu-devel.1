Received: from eggs.gnu.org ([2001:4830:134:3::10]:52609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emK2E-00082W-46
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emK2D-0004yP-8o
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:14 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1emK2D-0004xW-0k
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:13 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1emK2B-0001mr-Sg
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:57:11 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 13:56:52 +0000
Message-Id: <20180215135702.1340-12-peter.maydell@linaro.org>
In-Reply-To: <20180215135702.1340-1-peter.maydell@linaro.org>
References: <20180215135702.1340-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/21] hw/intc/armv7m_nvic: Don't hardcode M
 profile ID registers in NVIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Instead of hardcoding the values of M profile ID registers in the
NVIC, use the fields in the CPU struct. This will allow us to
give different M profile CPU types different ID register values.

This commit includes the addition of the missing ID_ISAR5,
which exists as RES0 in both v7M and v8M.

(The values of the ID registers might be wrong for the M4 --
this commit leaves the behaviour there unchanged.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180209165810.6668-2-peter.maydell@linaro.org
---
 hw/intc/armv7m_nvic.c | 30 ++++++++++++++++--------------
 target/arm/cpu.c      | 28 ++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 360889d30b..63da0fee34 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -990,31 +990,33 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
                       "Aux Fault status registers unimplemented\n");
         return 0;
     case 0xd40: /* PFR0.  */
-        return 0x00000030;
-    case 0xd44: /* PRF1.  */
-        return 0x00000200;
+        return cpu->id_pfr0;
+    case 0xd44: /* PFR1.  */
+        return cpu->id_pfr1;
     case 0xd48: /* DFR0.  */
-        return 0x00100000;
+        return cpu->id_dfr0;
     case 0xd4c: /* AFR0.  */
-        return 0x00000000;
+        return cpu->id_afr0;
     case 0xd50: /* MMFR0.  */
-        return 0x00000030;
+        return cpu->id_mmfr0;
     case 0xd54: /* MMFR1.  */
-        return 0x00000000;
+        return cpu->id_mmfr1;
     case 0xd58: /* MMFR2.  */
-        return 0x00000000;
+        return cpu->id_mmfr2;
     case 0xd5c: /* MMFR3.  */
-        return 0x00000000;
+        return cpu->id_mmfr3;
     case 0xd60: /* ISAR0.  */
-        return 0x01141110;
+        return cpu->id_isar0;
     case 0xd64: /* ISAR1.  */
-        return 0x02111000;
+        return cpu->id_isar1;
     case 0xd68: /* ISAR2.  */
-        return 0x21112231;
+        return cpu->id_isar2;
     case 0xd6c: /* ISAR3.  */
-        return 0x01111110;
+        return cpu->id_isar3;
     case 0xd70: /* ISAR4.  */
-        return 0x01310102;
+        return cpu->id_isar4;
+    case 0xd74: /* ISAR5.  */
+        return cpu->id_isar5;
     /* TODO: Implement debug registers.  */
     case 0xd90: /* MPU_TYPE */
         /* Unified MPU; if the MPU is not present this value is zero */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 89ccdeae12..d796085be9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1146,6 +1146,20 @@ static void cortex_m3_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M);
     cpu->midr = 0x410fc231;
     cpu->pmsav7_dregion = 8;
+    cpu->id_pfr0 = 0x00000030;
+    cpu->id_pfr1 = 0x00000200;
+    cpu->id_dfr0 = 0x00100000;
+    cpu->id_afr0 = 0x00000000;
+    cpu->id_mmfr0 = 0x00000030;
+    cpu->id_mmfr1 = 0x00000000;
+    cpu->id_mmfr2 = 0x00000000;
+    cpu->id_mmfr3 = 0x00000000;
+    cpu->id_isar0 = 0x01141110;
+    cpu->id_isar1 = 0x02111000;
+    cpu->id_isar2 = 0x21112231;
+    cpu->id_isar3 = 0x01111110;
+    cpu->id_isar4 = 0x01310102;
+    cpu->id_isar5 = 0x00000000;
 }
 
 static void cortex_m4_initfn(Object *obj)
@@ -1157,6 +1171,20 @@ static void cortex_m4_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
     cpu->midr = 0x410fc240; /* r0p0 */
     cpu->pmsav7_dregion = 8;
+    cpu->id_pfr0 = 0x00000030;
+    cpu->id_pfr1 = 0x00000200;
+    cpu->id_dfr0 = 0x00100000;
+    cpu->id_afr0 = 0x00000000;
+    cpu->id_mmfr0 = 0x00000030;
+    cpu->id_mmfr1 = 0x00000000;
+    cpu->id_mmfr2 = 0x00000000;
+    cpu->id_mmfr3 = 0x00000000;
+    cpu->id_isar0 = 0x01141110;
+    cpu->id_isar1 = 0x02111000;
+    cpu->id_isar2 = 0x21112231;
+    cpu->id_isar3 = 0x01111110;
+    cpu->id_isar4 = 0x01310102;
+    cpu->id_isar5 = 0x00000000;
 }
 
 static void arm_v7m_class_init(ObjectClass *oc, void *data)
-- 
2.16.1
