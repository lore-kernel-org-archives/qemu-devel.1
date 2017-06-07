Received: from eggs.gnu.org ([2001:4830:134:3::10]:33937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtN-0002qT-Ed
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtM-00023p-A2
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:09 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOtM-00023h-5L
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:08 -0400
Received: by mail-qk0-x244.google.com with SMTP id u129so439279qka.2
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:32:08 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:30:42 -0700
Message-Id: <20170607003119.14778-34-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 33/70] target/s390x: Use atomic operations
 for COMPARE SWAP PURGE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

Also provide the cross-cpu tlb flushing required by the PoO.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.h      |  2 +-
 target/s390x/insn-data.def |  2 +-
 target/s390x/mem_helper.c  | 32 ++++++++------------------------
 target/s390x/translate.c   | 42 ++++++++++++++++++++++++++++++++++++++----
 4 files changed, 48 insertions(+), 30 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 3819409..cc451c7 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -107,13 +107,13 @@ DEF_HELPER_FLAGS_2(tprot, TCG_CALL_NO_RWG, i32, i64, i64)
 DEF_HELPER_FLAGS_2(iske, TCG_CALL_NO_RWG_SE, i64, env, i64)
 DEF_HELPER_FLAGS_3(sske, TCG_CALL_NO_RWG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(rrbe, TCG_CALL_NO_RWG, i32, env, i64)
-DEF_HELPER_3(csp, i32, env, i32, i64)
 DEF_HELPER_4(mvcs, i32, env, i64, i64, i64)
 DEF_HELPER_4(mvcp, i32, env, i64, i64, i64)
 DEF_HELPER_4(sigp, i32, env, i64, i32, i64)
 DEF_HELPER_FLAGS_2(sacf, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_3(ipte, TCG_CALL_NO_RWG, void, env, i64, i64)
 DEF_HELPER_FLAGS_1(ptlb, TCG_CALL_NO_RWG, void, env)
+DEF_HELPER_FLAGS_1(purge, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_2(lra, i64, env, i64)
 DEF_HELPER_FLAGS_2(lura, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(lurag, TCG_CALL_NO_WG, i64, env, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 3c3541c..4c91f30 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -837,7 +837,7 @@
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
-    C(0xb250, CSP,     RRE,   Z,   0, ra2, 0, 0, csp, 0)
+    D(0xb250, CSP,     RRE,   Z,   r1_32u, ra2, r1_P, 0, csp, 0, MO_TEUL)
 /* DIAGNOSE (KVM hypercall) */
     C(0x8300, DIAG,    RSI,   Z,   0, 0, 0, 0, diag, 0)
 /* INSERT STORAGE KEY EXTENDED */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index fa03129..4b96c27 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1056,30 +1056,6 @@ uint32_t HELPER(rrbe)(CPUS390XState *env, uint64_t r2)
     return re >> 1;
 }
 
-/* compare and swap and purge */
-uint32_t HELPER(csp)(CPUS390XState *env, uint32_t r1, uint64_t r2)
-{
-    S390CPU *cpu = s390_env_get_cpu(env);
-    uint32_t cc;
-    uint32_t o1 = env->regs[r1];
-    uint64_t a2 = r2 & ~3ULL;
-    uint32_t o2 = cpu_ldl_data(env, a2);
-
-    if (o1 == o2) {
-        cpu_stl_data(env, a2, env->regs[(r1 + 1) & 15]);
-        if (r2 & 0x3) {
-            /* flush TLB / ALB */
-            tlb_flush(CPU(cpu));
-        }
-        cc = 0;
-    } else {
-        env->regs[r1] = (env->regs[r1] & 0xffffffff00000000ULL) | o2;
-        cc = 1;
-    }
-
-    return cc;
-}
-
 uint32_t HELPER(mvcs)(CPUS390XState *env, uint64_t l, uint64_t a1, uint64_t a2)
 {
     uintptr_t ra = GETPC();
@@ -1161,6 +1137,14 @@ void HELPER(ptlb)(CPUS390XState *env)
     tlb_flush(CPU(cpu));
 }
 
+/* flush global tlb */
+void HELPER(purge)(CPUS390XState *env)
+{
+    S390CPU *cpu = s390_env_get_cpu(env);
+
+    tlb_flush_all_cpus_synced(CPU(cpu));
+}
+
 /* load using real address */
 uint64_t HELPER(lura)(CPUS390XState *env, uint64_t addr)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 78c14ef..711b9c9 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2006,11 +2006,45 @@ static ExitStatus op_cdsg(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static ExitStatus op_csp(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
+    TCGMemOp mop = s->insn->data;
+    TCGv_i64 addr, old, cc;
+    TCGLabel *lab = gen_new_label();
+
+    /* Note that in1 = R1 (zero-extended expected value),
+       out = R1 (original reg), out2 = R1+1 (new value).  */
+
     check_privileged(s);
-    gen_helper_csp(cc_op, cpu_env, r1, o->in2);
-    tcg_temp_free_i32(r1);
-    set_cc_static(s);
+    addr = tcg_temp_new_i64();
+    old = tcg_temp_new_i64();
+    tcg_gen_andi_i64(addr, o->in2, -1ULL << (mop & MO_SIZE));
+    tcg_gen_atomic_cmpxchg_i64(old, addr, o->in1, o->out2,
+                               get_mem_index(s), mop | MO_ALIGN);
+    tcg_temp_free_i64(addr);
+
+    /* Are the memory and expected values (un)equal?  */
+    cc = tcg_temp_new_i64();
+    tcg_gen_setcond_i64(TCG_COND_NE, cc, o->in1, old);
+    tcg_gen_extrl_i64_i32(cc_op, cc);
+
+    /* Write back the output now, so that it happens before the
+       following branch, so that we don't need local temps.  */
+    if ((mop & MO_SIZE) == MO_32) {
+        tcg_gen_deposit_i64(o->out, o->out, old, 0, 32);
+    } else {
+        tcg_gen_mov_i64(o->out, old);
+    }
+    tcg_temp_free_i64(old);
+
+    /* If the comparison was equal, and the LSB of R2 was set,
+       then we need to flush the TLB (for all cpus).  */
+    tcg_gen_xori_i64(cc, cc, 1);
+    tcg_gen_and_i64(cc, cc, o->in2);
+    tcg_gen_brcondi_i64(TCG_COND_EQ, cc, 0, lab);
+    tcg_temp_free_i64(cc);
+
+    gen_helper_purge(cpu_env);
+    gen_set_label(lab);
+
     return NO_EXIT;
 }
 #endif
-- 
2.9.4
