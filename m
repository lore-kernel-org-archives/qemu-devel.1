Received: from eggs.gnu.org ([2001:4830:134:3::10]:59129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQj-0000oz-3H
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQh-00026t-BI
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQf-00021R-Aq
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:10 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQe-0000A9-Ev
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:35:08 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:32 +0100
Message-Id: <20180816133438.17061-25-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 24/30] target/arm: Adjust FPCR_MASK for FZ16
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

When support for FZ16 was added, we failed to include the bit
within FPCR_MASK, which means that it could never be set.
Continue to zero FZ16 when ARMv8.2-FP16 is not enabled.

Fixes: d81ce0ef2c4
Cc: qemu-stable@nongnu.org (3.0.1)
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20180810193129.1556-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 2 +-
 target/arm/helper.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a81f3d83cd2..62c36b41507 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1269,7 +1269,7 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
  * we store the underlying state in fpscr and just mask on read/write.
  */
 #define FPSR_MASK 0xf800009f
-#define FPCR_MASK 0x07f79f00
+#define FPCR_MASK 0x07ff9f00
 
 #define FPCR_FZ16   (1 << 19)   /* ARMv8.2+, FP16 flush-to-zero */
 #define FPCR_FZ     (1 << 24)   /* Flush-to-zero enable bit */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 873a0c215db..0fc6d2e2139 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11349,6 +11349,11 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
     int i;
     uint32_t changed;
 
+    /* When ARMv8.2-FP16 is not supported, FZ16 is RES0.  */
+    if (!arm_feature(env, ARM_FEATURE_V8_FP16)) {
+        val &= ~FPCR_FZ16;
+    }
+
     changed = env->vfp.xregs[ARM_VFP_FPSCR];
     env->vfp.xregs[ARM_VFP_FPSCR] = (val & 0xffc8ffff);
     env->vfp.vec_len = (val >> 16) & 7;
-- 
2.18.0
