Received: from eggs.gnu.org ([2001:4830:134:3::10]:47648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY6J-0001of-FM
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY6H-0002Yf-FK
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:58:15 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY6F-00020Y-IJ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:58:12 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY62-0006jx-Al
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:57:58 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:57:10 +0100
Message-Id: <20181019165735.22511-21-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/45] target/arm: Report correct syndrome for
 FP/SIMD traps to Hyp mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For traps of FP/SIMD instructions to AArch32 Hyp mode, the syndrome
provided in HSR has more information than is reported to AArch64.
Specifically, there are extra fields TA and coproc which indicate
whether the trapped instruction was FP or SIMD. Add this extra
information to the syndromes we construct, and mask it out when
taking the exception to AArch64.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181012144235.19646-11-peter.maydell@linaro.org
---
 target/arm/internals.h | 14 +++++++++++++-
 target/arm/helper.c    |  9 +++++++++
 target/arm/translate.c |  8 ++++----
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6b9387ba97e..6c2bb2deebd 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -288,6 +288,9 @@ static inline uint32_t syn_get_ec(uint32_t syn)
  * few cases the value in HSR for exceptions taken to AArch32 Hyp
  * mode differs slightly, and we fix this up when populating HSR in
  * arm_cpu_do_interrupt_aarch32_hyp().
+ * The exception is FP/SIMD access traps -- these report extra information
+ * when taking an exception to AArch32. For those we include the extra coproc
+ * and TA fields, and mask them out when taking the exception to AArch64.
  */
 static inline uint32_t syn_uncategorized(void)
 {
@@ -387,9 +390,18 @@ static inline uint32_t syn_cp15_rrt_trap(int cv, int cond, int opc1, int crm,
 
 static inline uint32_t syn_fp_access_trap(int cv, int cond, bool is_16bit)
 {
+    /* AArch32 FP trap or any AArch64 FP/SIMD trap: TA == 0 coproc == 0xa */
     return (EC_ADVSIMDFPACCESSTRAP << ARM_EL_EC_SHIFT)
         | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20);
+        | (cv << 24) | (cond << 20) | 0xa;
+}
+
+static inline uint32_t syn_simd_access_trap(int cv, int cond, bool is_16bit)
+{
+    /* AArch32 SIMD trap: TA == 1 coproc == 0 */
+    return (EC_ADVSIMDFPACCESSTRAP << ARM_EL_EC_SHIFT)
+        | (is_16bit ? 0 : ARM_EL_IL)
+        | (cv << 24) | (cond << 20) | (1 << 5);
 }
 
 static inline uint32_t syn_sve_access_trap(void)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5db76df758b..bf4f50196de 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8546,6 +8546,15 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     case EXCP_HVC:
     case EXCP_HYP_TRAP:
     case EXCP_SMC:
+        if (syn_get_ec(env->exception.syndrome) == EC_ADVSIMDFPACCESSTRAP) {
+            /*
+             * QEMU internal FP/SIMD syndromes from AArch32 include the
+             * TA and coproc fields which are only exposed if the exception
+             * is taken to AArch32 Hyp mode. Mask them out to get a valid
+             * AArch64 format syndrome.
+             */
+            env->exception.syndrome &= ~MAKE_64BIT_MASK(0, 20);
+        }
         env->cp15.esr_el[new_el] = env->exception.syndrome;
         break;
     case EXCP_IRQ:
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 46c4b86bf52..1bf339a98b6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4948,7 +4948,7 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
      */
     if (s->fp_excp_el) {
         gen_exception_insn(s, 4, EXCP_UDEF,
-                           syn_fp_access_trap(1, 0xe, false), s->fp_excp_el);
+                           syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
         return 0;
     }
 
@@ -5727,7 +5727,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
      */
     if (s->fp_excp_el) {
         gen_exception_insn(s, 4, EXCP_UDEF,
-                           syn_fp_access_trap(1, 0xe, false), s->fp_excp_el);
+                           syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
         return 0;
     }
 
@@ -7838,7 +7838,7 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
 
     if (s->fp_excp_el) {
         gen_exception_insn(s, 4, EXCP_UDEF,
-                           syn_fp_access_trap(1, 0xe, false), s->fp_excp_el);
+                           syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
         return 0;
     }
     if (!s->vfp_enabled) {
@@ -7924,7 +7924,7 @@ static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
 
     if (s->fp_excp_el) {
         gen_exception_insn(s, 4, EXCP_UDEF,
-                           syn_fp_access_trap(1, 0xe, false), s->fp_excp_el);
+                           syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
         return 0;
     }
     if (!s->vfp_enabled) {
-- 
2.19.1
