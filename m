Received: from eggs.gnu.org ([2001:4830:134:3::10]:56182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ceP2Y-0008FG-Hr
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ceP2X-0007cQ-IG
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:36:18 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 16:36:02 +0000
Message-Id: <1487262963-11519-13-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
References: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 12/13] armv7m: Raise correct kind of
 UsageFault for attempts to execute ARM code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

M profile doesn't implement ARM, and the architecturally required
behaviour for attempts to execute with the Thumb bit clear is to
generate a UsageFault with the CFSR INVSTATE bit set.  We were
incorrectly implementing this as generating an UNDEFINSTR UsageFault;
fix this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       | 1 +
 linux-user/main.c      | 1 +
 target/arm/helper.c    | 4 ++++
 target/arm/translate.c | 8 ++++++--
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 017e301..228747f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -54,6 +54,7 @@
 #define EXCP_VFIQ           15
 #define EXCP_SEMIHOST       16   /* semihosting call */
 #define EXCP_NOCP           17   /* v7M NOCP UsageFault */
+#define EXCP_INVSTATE       18   /* v7M INVSTATE UsageFault */
 
 #define ARMV7M_EXCP_RESET   1
 #define ARMV7M_EXCP_NMI     2
diff --git a/linux-user/main.c b/linux-user/main.c
index 4fd49ce..b6043d8 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -574,6 +574,7 @@ void cpu_loop(CPUARMState *env)
         switch(trapnr) {
         case EXCP_UDEF:
         case EXCP_NOCP:
+        case EXCP_INVSTATE:
             {
                 TaskState *ts = cs->opaque;
                 uint32_t opcode;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6a476b4..948aba2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6244,6 +6244,10 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
         env->v7m.cfsr |= R_V7M_CFSR_NOCP_MASK;
         break;
+    case EXCP_INVSTATE:
+        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
+        env->v7m.cfsr |= R_V7M_CFSR_INVSTATE_MASK;
+        break;
     case EXCP_SWI:
         /* The PC already points to the next instruction.  */
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SVC);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4436d8f..9fded03 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7978,9 +7978,13 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
     TCGv_i32 addr;
     TCGv_i64 tmp64;
 
-    /* M variants do not implement ARM mode.  */
+    /* M variants do not implement ARM mode; this must raise the INVSTATE
+     * UsageFault exception.
+     */
     if (arm_dc_feature(s, ARM_FEATURE_M)) {
-        goto illegal_op;
+        gen_exception_insn(s, 4, EXCP_INVSTATE, syn_uncategorized(),
+                           default_exception_el(s));
+        return;
     }
     cond = insn >> 28;
     if (cond == 0xf){
-- 
2.7.4
