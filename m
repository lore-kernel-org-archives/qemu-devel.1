Received: from eggs.gnu.org ([2001:4830:134:3::10]:45655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KAZ-0001Gh-Ei
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KAX-00044y-TH
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:23 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d9KAX-00044K-Ns
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:21 -0400
Received: by mail-qk0-x241.google.com with SMTP id y128so9824588qka.3
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:40:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 12 May 2017 16:40:05 -0700
Message-Id: <20170512234009.32557-6-rth@twiddle.net>
In-Reply-To: <20170512234009.32557-1-rth@twiddle.net>
References: <20170512234009.32557-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 5/9] target/s390x: Use atomic operations for
 COMPARE SWAP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def | 10 +++---
 target/s390x/mem_helper.c  | 40 ++++++++++++++++++++++
 target/s390x/translate.c   | 83 ++++++++--------------------------------------
 4 files changed, 60 insertions(+), 74 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 01adb50..0b70770 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -25,6 +25,7 @@ DEF_HELPER_3(cxgb, i64, env, s64, i32)
 DEF_HELPER_3(celgb, i64, env, i64, i32)
 DEF_HELPER_3(cdlgb, i64, env, i64, i32)
 DEF_HELPER_3(cxlgb, i64, env, i64, i32)
+DEF_HELPER_4(cdsg, void, env, i64, i32, i32)
 DEF_HELPER_FLAGS_3(aeb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(adb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_5(axb, TCG_CALL_NO_WG, i64, env, i64, i64, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 0909060..5e5fcc5 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -239,12 +239,12 @@
     D(0xec7d, CLGIJ,   RIE_c, GIE, r1_o, i2_8u, 0, 0, cj, 0, 1)
 
 /* COMPARE AND SWAP */
-    D(0xba00, CS,      RS_a,  Z,   r3_32u, r1_32u, new, r1_32, cs, 0, 0)
-    D(0xeb14, CSY,     RSY_a, LD,  r3_32u, r1_32u, new, r1_32, cs, 0, 0)
-    D(0xeb30, CSG,     RSY_a, Z,   r3_o, r1_o, new, r1, cs, 0, 1)
+    D(0xba00, CS,      RS_a,  Z,   r3_32u, r1_32u, new, r1_32, cs, 0, MO_TEUL)
+    D(0xeb14, CSY,     RSY_a, LD,  r3_32u, r1_32u, new, r1_32, cs, 0, MO_TEUL)
+    D(0xeb30, CSG,     RSY_a, Z,   r3_o, r1_o, new, r1, cs, 0, MO_TEQ)
 /* COMPARE DOUBLE AND SWAP */
-    D(0xbb00, CDS,     RS_a,  Z,   r3_D32, r1_D32, new, r1_D32, cs, 0, 1)
-    D(0xeb31, CDSY,    RSY_a, LD,  r3_D32, r1_D32, new, r1_D32, cs, 0, 1)
+    D(0xbb00, CDS,     RS_a,  Z,   r3_D32, r1_D32, new, r1_D32, cs, 0, MO_TEQ)
+    D(0xeb31, CDSY,    RSY_a, LD,  r3_D32, r1_D32, new, r1_D32, cs, 0, MO_TEQ)
     C(0xeb3e, CDSG,    RSY_a, Z,   0, 0, 0, 0, cdsg, 0)
 
 /* COMPARE AND TRAP */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 675aba2..f6e5bce 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -23,6 +23,7 @@
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
+#include "qemu/int128.h"
 
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/s390x/storage-keys.h"
@@ -844,6 +845,45 @@ uint32_t HELPER(trt)(CPUS390XState *env, uint32_t len, uint64_t array,
     return cc;
 }
 
+void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
+                  uint32_t r1, uint32_t r3)
+{
+    uintptr_t ra = GETPC();
+    Int128 cmpv = int128_make128(env->regs[r1 + 1], env->regs[r1]);
+    Int128 newv = int128_make128(env->regs[r3 + 1], env->regs[r3]);
+    Int128 oldv;
+    bool fail;
+
+    if (parallel_cpus) {
+#ifndef CONFIG_ATOMIC128
+        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
+#else
+        int mem_idx = cpu_mmu_index(env, false);
+        TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
+        oldv = helper_atomic_cmpxchgo_be_mmu(env, addr, cmpv, newv, oi, ra);
+        fail = !int128_eq(oldv, cmpv);
+#endif
+    } else {
+        uint64_t oldh, oldl;
+
+        oldh = cpu_ldq_data_ra(env, addr + 0, ra);
+        oldl = cpu_ldq_data_ra(env, addr + 8, ra);
+
+        oldv = int128_make128(oldl, oldh);
+        fail = !int128_eq(oldv, cmpv);
+        if (fail) {
+            newv = oldv;
+        }
+
+        cpu_stq_data_ra(env, addr + 0, int128_gethi(newv), ra);
+        cpu_stq_data_ra(env, addr + 8, int128_getlo(newv), ra);
+    }
+
+    env->cc_op = fail;
+    env->regs[r1] = int128_gethi(oldv);
+    env->regs[r1 + 1] = int128_getlo(oldv);
+}
+
 #if !defined(CONFIG_USER_ONLY)
 void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 522a5e3..f23b705 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1943,102 +1943,47 @@ static ExitStatus op_cps(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_cs(DisasContext *s, DisasOps *o)
 {
-    /* FIXME: needs an atomic solution for CONFIG_USER_ONLY.  */
     int d2 = get_field(s->fields, d2);
     int b2 = get_field(s->fields, b2);
-    int is_64 = s->insn->data;
-    TCGv_i64 addr, mem, cc, z;
+    TCGv_i64 addr, cc;
 
     /* Note that in1 = R3 (new value) and
        in2 = (zero-extended) R1 (expected value).  */
 
-    /* Load the memory into the (temporary) output.  While the PoO only talks
-       about moving the memory to R1 on inequality, if we include equality it
-       means that R1 is equal to the memory in all conditions.  */
     addr = get_address(s, 0, b2, d2);
-    if (is_64) {
-        tcg_gen_qemu_ld64(o->out, addr, get_mem_index(s));
-    } else {
-        tcg_gen_qemu_ld32u(o->out, addr, get_mem_index(s));
-    }
+    tcg_gen_atomic_cmpxchg_i64(o->out, addr, o->in2, o->in1,
+                               get_mem_index(s), s->insn->data | MO_ALIGN);
+    tcg_temp_free_i64(addr);
 
     /* Are the memory and expected values (un)equal?  Note that this setcond
        produces the output CC value, thus the NE sense of the test.  */
     cc = tcg_temp_new_i64();
     tcg_gen_setcond_i64(TCG_COND_NE, cc, o->in2, o->out);
-
-    /* If the memory and expected values are equal (CC==0), copy R3 to MEM.
-       Recall that we are allowed to unconditionally issue the store (and
-       thus any possible write trap), so (re-)store the original contents
-       of MEM in case of inequality.  */
-    z = tcg_const_i64(0);
-    mem = tcg_temp_new_i64();
-    tcg_gen_movcond_i64(TCG_COND_EQ, mem, cc, z, o->in1, o->out);
-    if (is_64) {
-        tcg_gen_qemu_st64(mem, addr, get_mem_index(s));
-    } else {
-        tcg_gen_qemu_st32(mem, addr, get_mem_index(s));
-    }
-    tcg_temp_free_i64(z);
-    tcg_temp_free_i64(mem);
-    tcg_temp_free_i64(addr);
-
-    /* Store CC back to cc_op.  Wait until after the store so that any
-       exception gets the old cc_op value.  */
     tcg_gen_extrl_i64_i32(cc_op, cc);
     tcg_temp_free_i64(cc);
     set_cc_static(s);
+
     return NO_EXIT;
 }
 
 static ExitStatus op_cdsg(DisasContext *s, DisasOps *o)
 {
-    /* FIXME: needs an atomic solution for CONFIG_USER_ONLY.  */
     int r1 = get_field(s->fields, r1);
     int r3 = get_field(s->fields, r3);
     int d2 = get_field(s->fields, d2);
     int b2 = get_field(s->fields, b2);
-    TCGv_i64 addrh, addrl, memh, meml, outh, outl, cc, z;
+    TCGv_i64 addr;
+    TCGv_i32 t_r1, t_r3;
 
     /* Note that R1:R1+1 = expected value and R3:R3+1 = new value.  */
+    addr = get_address(s, 0, b2, d2);
+    t_r1 = tcg_const_i32(r1);
+    t_r3 = tcg_const_i32(r3);
+    gen_helper_cdsg(cpu_env, addr, t_r1, t_r3);
+    tcg_temp_free_i64(addr);
+    tcg_temp_free_i32(t_r1);
+    tcg_temp_free_i32(t_r3);
 
-    addrh = get_address(s, 0, b2, d2);
-    addrl = get_address(s, 0, b2, d2 + 8);
-    outh = tcg_temp_new_i64();
-    outl = tcg_temp_new_i64();
-
-    tcg_gen_qemu_ld64(outh, addrh, get_mem_index(s));
-    tcg_gen_qemu_ld64(outl, addrl, get_mem_index(s));
-
-    /* Fold the double-word compare with arithmetic.  */
-    cc = tcg_temp_new_i64();
-    z = tcg_temp_new_i64();
-    tcg_gen_xor_i64(cc, outh, regs[r1]);
-    tcg_gen_xor_i64(z, outl, regs[r1 + 1]);
-    tcg_gen_or_i64(cc, cc, z);
-    tcg_gen_movi_i64(z, 0);
-    tcg_gen_setcond_i64(TCG_COND_NE, cc, cc, z);
-
-    memh = tcg_temp_new_i64();
-    meml = tcg_temp_new_i64();
-    tcg_gen_movcond_i64(TCG_COND_EQ, memh, cc, z, regs[r3], outh);
-    tcg_gen_movcond_i64(TCG_COND_EQ, meml, cc, z, regs[r3 + 1], outl);
-    tcg_temp_free_i64(z);
-
-    tcg_gen_qemu_st64(memh, addrh, get_mem_index(s));
-    tcg_gen_qemu_st64(meml, addrl, get_mem_index(s));
-    tcg_temp_free_i64(memh);
-    tcg_temp_free_i64(meml);
-    tcg_temp_free_i64(addrh);
-    tcg_temp_free_i64(addrl);
-
-    /* Save back state now that we've passed all exceptions.  */
-    tcg_gen_mov_i64(regs[r1], outh);
-    tcg_gen_mov_i64(regs[r1 + 1], outl);
-    tcg_gen_extrl_i64_i32(cc_op, cc);
-    tcg_temp_free_i64(outh);
-    tcg_temp_free_i64(outl);
-    tcg_temp_free_i64(cc);
     set_cc_static(s);
     return NO_EXIT;
 }
-- 
2.9.3
