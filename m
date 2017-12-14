Received: from eggs.gnu.org ([2001:4830:134:3::10]:56730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX4T-0001pX-9i
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:13:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX4Q-0000SJ-Kq
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:13:21 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:10:01 +0100
Message-Id: <20171214171004.25058-44-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 43/46] s390x/tcg: implement extract-CPU-time
 facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

It only provides the EXTRACT CPU TIME instruction. We can reuse the stpt
helper, which calculates the CPU timer value.

As the instruction is not privileged, but we don't have a CPU timer
value in case of linux user, we simply reuse cpu_get_host_ticks() to
produce some descending value.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171208160207.26494-13-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_models.c  |  1 +
 target/s390x/helper.h      |  2 +-
 target/s390x/insn-data.def |  2 ++
 target/s390x/misc_helper.c | 21 +++++++++++++++------
 target/s390x/translate.c   | 31 +++++++++++++++++++++++++++++++
 5 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 94d24e423d..0be037eac1 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -834,6 +834,7 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
         S390_FEAT_STORE_CLOCK_FAST,
         S390_FEAT_MOVE_WITH_OPTIONAL_SPEC,
         S390_FEAT_ETF3_ENH,
+        S390_FEAT_EXTRACT_CPU_TIME,
         S390_FEAT_COMPARE_AND_SWAP_AND_STORE,
         S390_FEAT_COMPARE_AND_SWAP_AND_STORE_2,
         S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 102fbdd7b9..2f17b62d3d 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -119,6 +119,7 @@ DEF_HELPER_4(cu24, i32, env, i32, i32, i32)
 DEF_HELPER_4(cu41, i32, env, i32, i32, i32)
 DEF_HELPER_4(cu42, i32, env, i32, i32, i32)
 DEF_HELPER_5(msa, i32, env, i32, i32, i32, i32)
+DEF_HELPER_FLAGS_1(stpt, TCG_CALL_NO_RWG, i64, env)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
@@ -130,7 +131,6 @@ DEF_HELPER_FLAGS_2(sckc, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_2(sckpf, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_1(stckc, TCG_CALL_NO_RWG, i64, env)
 DEF_HELPER_FLAGS_2(spt, TCG_CALL_NO_RWG, void, env, i64)
-DEF_HELPER_FLAGS_1(stpt, TCG_CALL_NO_RWG, i64, env)
 DEF_HELPER_4(stsi, i32, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(lctl, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_FLAGS_4(lctlg, TCG_CALL_NO_WG, void, env, i32, i64, i32)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 250741330d..11ee43dcbc 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -369,6 +369,8 @@
     C(0xb24f, EAR,     RRE,   Z,   0, 0, new, r1_32, ear, 0)
 /* EXTRACT CPU ATTRIBUTE */
     C(0xeb4c, ECAG,    RSY_a, GIE, 0, a2, r1, 0, ecag, 0)
+/* EXTRACT CPU TIME */
+    C(0xc801, ECTG,    SSF,   ECT, 0, 0, 0, 0, ectg, 0)
 /* EXTRACT FPC */
     C(0xb38c, EFPC,    RRE,   Z,   0, 0, new, r1_32, efpc, 0)
 /* EXTRACT PSW */
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 7ddade2f0e..86da6aab7e 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -55,6 +55,21 @@ void HELPER(exception)(CPUS390XState *env, uint32_t excp)
     cpu_loop_exit(cs);
 }
 
+/* Store CPU Timer (also used for EXTRACT CPU TIME) */
+uint64_t HELPER(stpt)(CPUS390XState *env)
+{
+#if defined(CONFIG_USER_ONLY)
+    /*
+     * Fake a descending CPU timer. We could get negative values here,
+     * but we don't care as it is up to the OS when to process that
+     * interrupt and reset to > 0.
+     */
+    return UINT64_MAX - (uint64_t)cpu_get_host_ticks();
+#else
+    return time2tod(env->cputm - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+#endif
+}
+
 #ifndef CONFIG_USER_ONLY
 
 /* SCLP service call */
@@ -178,12 +193,6 @@ void HELPER(spt)(CPUS390XState *env, uint64_t time)
     timer_mod(env->cpu_timer, env->cputm);
 }
 
-/* Store CPU Timer */
-uint64_t HELPER(stpt)(CPUS390XState *env)
-{
-    return time2tod(env->cputm - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
-}
-
 /* Store System Information */
 uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
                       uint64_t r0, uint64_t r1)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 83e1df0f48..eede2ed157 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3917,6 +3917,36 @@ static ExitStatus op_spm(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_ectg(DisasContext *s, DisasOps *o)
+{
+    int b1 = get_field(s->fields, b1);
+    int d1 = get_field(s->fields, d1);
+    int b2 = get_field(s->fields, b2);
+    int d2 = get_field(s->fields, d2);
+    int r3 = get_field(s->fields, r3);
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    /* fetch all operands first */
+    o->in1 = tcg_temp_new_i64();
+    tcg_gen_addi_i64(o->in1, regs[b1], d1);
+    o->in2 = tcg_temp_new_i64();
+    tcg_gen_addi_i64(o->in2, regs[b2], d2);
+    o->addr1 = get_address(s, 0, r3, 0);
+
+    /* load the third operand into r3 before modifying anything */
+    tcg_gen_qemu_ld64(regs[r3], o->addr1, get_mem_index(s));
+
+    /* subtract CPU timer from first operand and store in GR0 */
+    gen_helper_stpt(tmp, cpu_env);
+    tcg_gen_sub_i64(regs[0], o->in1, tmp);
+
+    /* store second operand in GR1 */
+    tcg_gen_mov_i64(regs[1], o->in2);
+
+    tcg_temp_free_i64(tmp);
+    return NO_EXIT;
+}
+
 #ifndef CONFIG_USER_ONLY
 static ExitStatus op_spka(DisasContext *s, DisasOps *o)
 {
@@ -5679,6 +5709,7 @@ enum DisasInsnEnum {
 #define FAC_MSA3        S390_FEAT_MSA_EXT_3 /* msa-extension-3 facility */
 #define FAC_MSA4        S390_FEAT_MSA_EXT_4 /* msa-extension-4 facility */
 #define FAC_MSA5        S390_FEAT_MSA_EXT_5 /* msa-extension-5 facility */
+#define FAC_ECT         S390_FEAT_EXTRACT_CPU_TIME
 
 static const DisasInsn insn_info[] = {
 #include "insn-data.def"
-- 
2.13.6
