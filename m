Received: from eggs.gnu.org ([2001:4830:134:3::10]:36033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOU-0004RX-5p
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOR-0007aF-FE
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:16 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSOQ-000747-I0
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:14 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOF-0007Mg-31
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:55:03 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:40 +0000
Message-Id: <20181213145445.17935-33-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 32/37] target/arm: Tidy scr_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Because EL3 has a fixed execution mode, we can properly decide
which of the bits are RES{0,1}.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181203203839.757-8-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    |  2 --
 target/arm/helper.c | 14 +++++++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 20d97b66def..b8dbdb5e014 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1312,8 +1312,6 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_FIEN              (1U << 21)
 #define SCR_ENSCXT            (1U << 25)
 #define SCR_ATA               (1U << 26)
-#define SCR_AARCH32_MASK      (0x3fff & ~(SCR_RW | SCR_ST))
-#define SCR_AARCH64_MASK      (0x3fff & ~SCR_NET)
 
 /* Return the current FPSCR value.  */
 uint32_t vfp_get_fpscr(CPUARMState *env);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bf020364e1d..1dad277804f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1279,11 +1279,15 @@ static void vbar_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
 static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
-    /* We only mask off bits that are RES0 both for AArch64 and AArch32.
-     * For bits that vary between AArch32/64, code needs to check the
-     * current execution mode before directly using the feature bit.
-     */
-    uint32_t valid_mask = SCR_AARCH64_MASK | SCR_AARCH32_MASK;
+    /* Begin with base v8.0 state.  */
+    uint32_t valid_mask = 0x3fff;
+
+    if (arm_el_is_aa64(env, 3)) {
+        value |= SCR_FW | SCR_AW;   /* these two bits are RES1.  */
+        valid_mask &= ~SCR_NET;
+    } else {
+        valid_mask &= ~(SCR_RW | SCR_ST);
+    }
 
     if (!arm_feature(env, ARM_FEATURE_EL2)) {
         valid_mask &= ~SCR_HCE;
-- 
2.19.2
