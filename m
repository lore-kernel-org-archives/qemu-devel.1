Received: from eggs.gnu.org ([2001:4830:134:3::10]:36430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOP6-00069Q-60
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOP4-0004EI-UK
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:08 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1emOP4-0004DZ-Lf
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:06 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1emOP3-00025F-M4
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:37:05 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 18:36:46 +0000
Message-Id: <20180215183700.26101-7-peter.maydell@linaro.org>
In-Reply-To: <20180215183700.26101-1-peter.maydell@linaro.org>
References: <20180215183700.26101-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 06/20] target/arm: Enforce access to ZCR_EL at
 translation
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

This also makes sure that we get the correct ordering of
SVE vs FP exceptions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180211205848.4568-5-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |  3 ++-
 target/arm/internals.h     |  6 ++++++
 target/arm/helper.c        | 22 ++++------------------
 target/arm/translate-a64.c | 16 ++++++++++++++++
 4 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e966a57f8a..51a3e16275 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1750,10 +1750,11 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
 #define ARM_CP_DC_ZVA            (ARM_CP_SPECIAL | 0x0500)
 #define ARM_LAST_SPECIAL         ARM_CP_DC_ZVA
 #define ARM_CP_FPU               0x1000
+#define ARM_CP_SVE               0x2000
 /* Used only as a terminator for ARMCPRegInfo lists */
 #define ARM_CP_SENTINEL          0xffff
 /* Mask of only the flag bits in a type field */
-#define ARM_CP_FLAG_MASK         0x10ff
+#define ARM_CP_FLAG_MASK         0x30ff
 
 /* Valid values for ARMCPRegInfo state field, indicating which of
  * the AArch32 and AArch64 execution states this register is visible in.
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 89f5d2fe12..47cc224a46 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -243,6 +243,7 @@ enum arm_exception_class {
     EC_AA64_HVC               = 0x16,
     EC_AA64_SMC               = 0x17,
     EC_SYSTEMREGISTERTRAP     = 0x18,
+    EC_SVEACCESSTRAP          = 0x19,
     EC_INSNABORT              = 0x20,
     EC_INSNABORT_SAME_EL      = 0x21,
     EC_PCALIGNMENT            = 0x22,
@@ -381,6 +382,11 @@ static inline uint32_t syn_fp_access_trap(int cv, int cond, bool is_16bit)
         | (cv << 24) | (cond << 20);
 }
 
+static inline uint32_t syn_sve_access_trap(void)
+{
+    return EC_SVEACCESSTRAP << ARM_EL_EC_SHIFT;
+}
+
 static inline uint32_t syn_insn_abort(int same_el, int ea, int s1ptw, int fsc)
 {
     return (EC_INSNABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e0184c7162..550dc3d290 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4335,20 +4335,6 @@ static int sve_exception_el(CPUARMState *env)
     return 0;
 }
 
-static CPAccessResult zcr_access(CPUARMState *env, const ARMCPRegInfo *ri,
-                                 bool isread)
-{
-    switch (sve_exception_el(env)) {
-    case 3:
-        return CP_ACCESS_TRAP_EL3;
-    case 2:
-        return CP_ACCESS_TRAP_EL2;
-    case 1:
-        return CP_ACCESS_TRAP;
-    }
-    return CP_ACCESS_OK;
-}
-
 static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                       uint64_t value)
 {
@@ -4359,7 +4345,7 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static const ARMCPRegInfo zcr_el1_reginfo = {
     .name = "ZCR_EL1", .state = ARM_CP_STATE_AA64,
     .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 2, .opc2 = 0,
-    .access = PL1_RW, .accessfn = zcr_access,
+    .access = PL1_RW, .type = ARM_CP_SVE | ARM_CP_FPU,
     .fieldoffset = offsetof(CPUARMState, vfp.zcr_el[1]),
     .writefn = zcr_write, .raw_writefn = raw_write
 };
@@ -4367,7 +4353,7 @@ static const ARMCPRegInfo zcr_el1_reginfo = {
 static const ARMCPRegInfo zcr_el2_reginfo = {
     .name = "ZCR_EL2", .state = ARM_CP_STATE_AA64,
     .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 2, .opc2 = 0,
-    .access = PL2_RW, .accessfn = zcr_access,
+    .access = PL2_RW, .type = ARM_CP_SVE | ARM_CP_FPU,
     .fieldoffset = offsetof(CPUARMState, vfp.zcr_el[2]),
     .writefn = zcr_write, .raw_writefn = raw_write
 };
@@ -4375,14 +4361,14 @@ static const ARMCPRegInfo zcr_el2_reginfo = {
 static const ARMCPRegInfo zcr_no_el2_reginfo = {
     .name = "ZCR_EL2", .state = ARM_CP_STATE_AA64,
     .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 2, .opc2 = 0,
-    .access = PL2_RW,
+    .access = PL2_RW, .type = ARM_CP_SVE | ARM_CP_FPU,
     .readfn = arm_cp_read_zero, .writefn = arm_cp_write_ignore
 };
 
 static const ARMCPRegInfo zcr_el3_reginfo = {
     .name = "ZCR_EL3", .state = ARM_CP_STATE_AA64,
     .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 2, .opc2 = 0,
-    .access = PL3_RW, .accessfn = zcr_access,
+    .access = PL3_RW, .type = ARM_CP_SVE | ARM_CP_FPU,
     .fieldoffset = offsetof(CPUARMState, vfp.zcr_el[3]),
     .writefn = zcr_write, .raw_writefn = raw_write
 };
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 89f50558a7..e3881d4999 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1182,6 +1182,19 @@ static inline bool fp_access_check(DisasContext *s)
     return false;
 }
 
+/* Check that SVE access is enabled.  If it is, return true.
+ * If not, emit code to generate an appropriate exception and return false.
+ */
+static inline bool sve_access_check(DisasContext *s)
+{
+    if (s->sve_excp_el) {
+        gen_exception_insn(s, 4, EXCP_UDEF, syn_sve_access_trap(),
+                           s->sve_excp_el);
+        return false;
+    }
+    return true;
+}
+
 /*
  * This utility function is for doing register extension with an
  * optional shift. You will likely want to pass a temporary for the
@@ -1631,6 +1644,9 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
     default:
         break;
     }
+    if ((ri->type & ARM_CP_SVE) && !sve_access_check(s)) {
+        return;
+    }
     if ((ri->type & ARM_CP_FPU) && !fp_access_check(s)) {
         return;
     }
-- 
2.16.1
