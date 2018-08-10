Received: from eggs.gnu.org ([2001:4830:134:3::10]:59035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foD8K-0002Q6-9R
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foD8I-0005Ym-Eq
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:36 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:40657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1foD8I-0005Xm-9N
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:34 -0400
Received: by mail-pl0-x242.google.com with SMTP id s17-v6so4429158plp.7
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 12:31:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 10 Aug 2018 12:31:24 -0700
Message-Id: <20180810193129.1556-2-richard.henderson@linaro.org>
In-Reply-To: <20180810193129.1556-1-richard.henderson@linaro.org>
References: <20180810193129.1556-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/6] target/arm: Adjust FPCR_MASK for FZ16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-stable@nongnu.org

When support for FZ16 was added, we failed to include the bit
within FPCR_MASK, which means that it could never be set.
Continue to zero FZ16 when ARMv8.2-FP16 is not enabled.

Fixes: d81ce0ef2c4
Cc: qemu-stable@nongnu.org (3.0.1)
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 2 +-
 target/arm/helper.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 33d06f2340..0176716a70 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1279,7 +1279,7 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
  * we store the underlying state in fpscr and just mask on read/write.
  */
 #define FPSR_MASK 0xf800009f
-#define FPCR_MASK 0x07f79f00
+#define FPCR_MASK 0x07ff9f00
 
 #define FPCR_FZ16   (1 << 19)   /* ARMv8.2+, FP16 flush-to-zero */
 #define FPCR_FZ     (1 << 24)   /* Flush-to-zero enable bit */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 64ff71b722..452d5e182a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11351,6 +11351,11 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
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
2.17.1
