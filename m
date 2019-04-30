Received: from eggs.gnu.org ([209.51.188.92]:44595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSau-00012m-OF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSat-0002Du-Mg
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:48 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLSat-0002DG-GG
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:47 -0400
Received: by mail-wr1-x442.google.com with SMTP id s15so20931621wra.12
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 06:14:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 14:14:39 +0100
Message-Id: <20190430131439.25251-5-peter.maydell@linaro.org>
In-Reply-To: <20190430131439.25251-1-peter.maydell@linaro.org>
References: <20190430131439.25251-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/4] target/arm: Implement XPSR GE bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org

In the M-profile architecture, if the CPU implements the DSP extension
then the XPSR has GE bits, in the same way as the A-profile CPSR. When
we added DSP extension support we forgot to add support for reading
and writing the GE bits, which are stored in env->GE. We did put in
the code to add XPSR_GE to the mask of bits to update in the v7m_msr
helper, but forgot it in v7m_mrs. We also must not allow the XPSR we
pull off the stack on exception return to set the nonexistent GE bits.
Correct these errors:
 * read and write env->GE in xpsr_read() and xpsr_write()
 * only set GE bits on exception return if DSP present
 * read GE bits for MRS if DSP present

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    |  4 ++++
 target/arm/helper.c | 12 ++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 22bc6e00ab9..2ae1b36eaee 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1285,6 +1285,7 @@ static inline uint32_t xpsr_read(CPUARMState *env)
         | (env->CF << 29) | ((env->VF & 0x80000000) >> 3) | (env->QF << 27)
         | (env->thumb << 24) | ((env->condexec_bits & 3) << 25)
         | ((env->condexec_bits & 0xfc) << 8)
+        | (env->GE << 16)
         | env->v7m.exception;
 }
 
@@ -1300,6 +1301,9 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
     if (mask & XPSR_Q) {
         env->QF = ((val & XPSR_Q) != 0);
     }
+    if (mask & XPSR_GE) {
+        env->GE = (val & XPSR_GE) >> 16;
+    }
     if (mask & XPSR_T) {
         env->thumb = ((val & XPSR_T) != 0);
     }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 81a92ab4911..59ee5ee7c4a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8704,7 +8704,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
     uint32_t excret;
-    uint32_t xpsr;
+    uint32_t xpsr, xpsr_mask;
     bool ufault = false;
     bool sfault = false;
     bool return_to_sp_process;
@@ -9156,8 +9156,13 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         }
         *frame_sp_p = frameptr;
     }
+
+    xpsr_mask = ~(XPSR_SPREALIGN | XPSR_SFPA);
+    if (!arm_feature(env, ARM_FEATURE_THUMB_DSP)) {
+        xpsr_mask &= ~XPSR_GE;
+    }
     /* This xpsr_write() will invalidate frame_sp_p as it may switch stack */
-    xpsr_write(env, xpsr, ~(XPSR_SPREALIGN | XPSR_SFPA));
+    xpsr_write(env, xpsr, xpsr_mask);
 
     if (env->v7m.secure) {
         bool sfpa = xpsr & XPSR_SFPA;
@@ -12642,6 +12647,9 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
         }
         if (!(reg & 4)) {
             mask |= XPSR_NZCV | XPSR_Q; /* APSR */
+            if (arm_feature(env, ARM_FEATURE_THUMB_DSP)) {
+                mask |= XPSR_GE;
+            }
         }
         /* EPSR reads as zero */
         return xpsr_read(env) & mask;
-- 
2.20.1
