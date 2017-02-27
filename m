Received: from eggs.gnu.org ([2001:4830:134:3::10]:51988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfe-0002Lf-NJ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfd-0001sX-1K
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:14 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ciPfc-0001rj-Q5
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:12 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfb-0002Qf-UM
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:05:11 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 18:04:52 +0000
Message-Id: <1488218699-31035-24-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
References: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/30] armv7m: Raise correct kind of UsageFault
 for attempts to execute ARM code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

M profile doesn't implement ARM, and the architecturally required
behaviour for attempts to execute with the Thumb bit clear is to
generate a UsageFault with the CFSR INVSTATE bit set.  We were
incorrectly implementing this as generating an UNDEFINSTR UsageFault;
fix this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu.h       | 1 +
 linux-user/main.c      | 1 +
 target/arm/helper.c    | 4 ++++
 target/arm/translate.c | 8 ++++++--
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 045830a..9e7b2df 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -57,6 +57,7 @@
 #define EXCP_VFIQ           15
 #define EXCP_SEMIHOST       16   /* semihosting call */
 #define EXCP_NOCP           17   /* v7M NOCP UsageFault */
+#define EXCP_INVSTATE       18   /* v7M INVSTATE UsageFault */
 
 #define ARMV7M_EXCP_RESET   1
 #define ARMV7M_EXCP_NMI     2
diff --git a/linux-user/main.c b/linux-user/main.c
index 9645122..10a3bb3 100644
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
index 9081771..3f4211b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6245,6 +6245,10 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
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
index abc1f77..b859f10 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7990,9 +7990,13 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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
