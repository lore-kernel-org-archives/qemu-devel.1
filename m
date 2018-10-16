Received: from eggs.gnu.org ([2001:4830:134:3::10]:59959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTTZ-0004EW-4X
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTTV-0001Gt-T8
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:49 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:38879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCTTV-0001FR-Ho
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:45 -0400
Received: by mail-pf1-x431.google.com with SMTP id f29-v6so11828620pff.5
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 10:49:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 10:49:10 -0700
Message-Id: <20181016174911.9052-21-richard.henderson@linaro.org>
In-Reply-To: <20181016174911.9052-1-richard.henderson@linaro.org>
References: <20181016174911.9052-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 20/21] target/s390x: Check HAVE_ATOMIC128 and
 HAVE_CMPXCHG128 at translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mem_helper.c | 40 +++++++++++++++++++--------------------
 target/s390x/translate.c  | 25 +++++++++++++++++-------
 2 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index b5858d2fa2..490c43e6e6 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1420,9 +1420,7 @@ void HELPER(cdsg_parallel)(CPUS390XState *env, uint64_t addr,
     Int128 oldv;
     bool fail;
 
-    if (!HAVE_CMPXCHG128) {
-        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
-    }
+    assert(HAVE_CMPXCHG128);
 
     mem_idx = cpu_mmu_index(env, false);
     oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
@@ -2115,16 +2113,17 @@ uint64_t HELPER(lpq_parallel)(CPUS390XState *env, uint64_t addr)
 {
     uintptr_t ra = GETPC();
     uint64_t hi, lo;
+    int mem_idx;
+    TCGMemOpIdx oi;
+    Int128 v;
 
-    if (HAVE_ATOMIC128) {
-        int mem_idx = cpu_mmu_index(env, false);
-        TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
-        Int128 v = helper_atomic_ldo_be_mmu(env, addr, oi, ra);
-        hi = int128_gethi(v);
-        lo = int128_getlo(v);
-    } else {
-        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
-    }
+    assert(HAVE_ATOMIC128);
+
+    mem_idx = cpu_mmu_index(env, false);
+    oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
+    v = helper_atomic_ldo_be_mmu(env, addr, oi, ra);
+    hi = int128_gethi(v);
+    lo = int128_getlo(v);
 
     env->retxl = lo;
     return hi;
@@ -2145,15 +2144,16 @@ void HELPER(stpq_parallel)(CPUS390XState *env, uint64_t addr,
                            uint64_t low, uint64_t high)
 {
     uintptr_t ra = GETPC();
+    int mem_idx;
+    TCGMemOpIdx oi;
+    Int128 v;
 
-    if (HAVE_ATOMIC128) {
-        int mem_idx = cpu_mmu_index(env, false);
-        TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
-        Int128 v = int128_make128(low, high);
-        helper_atomic_sto_be_mmu(env, addr, v, oi, ra);
-    } else {
-        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
-    }
+    assert(HAVE_ATOMIC128);
+
+    mem_idx = cpu_mmu_index(env, false);
+    oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
+    v = int128_make128(low, high);
+    helper_atomic_sto_be_mmu(env, addr, v, oi, ra);
 }
 
 /* Execute instruction.  This instruction executes an insn modified with
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index a7bd689337..b5bd56b7ee 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -44,6 +44,7 @@
 #include "trace-tcg.h"
 #include "exec/translator.h"
 #include "exec/log.h"
+#include "qemu/atomic128.h"
 
 
 /* Information that (most) every instruction needs to manipulate.  */
@@ -2040,6 +2041,7 @@ static DisasJumpType op_cdsg(DisasContext *s, DisasOps *o)
     int r3 = get_field(s->fields, r3);
     int d2 = get_field(s->fields, d2);
     int b2 = get_field(s->fields, b2);
+    DisasJumpType ret = DISAS_NEXT;
     TCGv_i64 addr;
     TCGv_i32 t_r1, t_r3;
 
@@ -2047,17 +2049,20 @@ static DisasJumpType op_cdsg(DisasContext *s, DisasOps *o)
     addr = get_address(s, 0, b2, d2);
     t_r1 = tcg_const_i32(r1);
     t_r3 = tcg_const_i32(r3);
-    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
+        gen_helper_cdsg(cpu_env, addr, t_r1, t_r3);
+    } else if (HAVE_CMPXCHG128) {
         gen_helper_cdsg_parallel(cpu_env, addr, t_r1, t_r3);
     } else {
-        gen_helper_cdsg(cpu_env, addr, t_r1, t_r3);
+        gen_helper_exit_atomic(cpu_env);
+        ret = DISAS_NORETURN;
     }
     tcg_temp_free_i64(addr);
     tcg_temp_free_i32(t_r1);
     tcg_temp_free_i32(t_r3);
 
     set_cc_static(s);
-    return DISAS_NEXT;
+    return ret;
 }
 
 static DisasJumpType op_csst(DisasContext *s, DisasOps *o)
@@ -3034,10 +3039,13 @@ static DisasJumpType op_lpd(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_lpq(DisasContext *s, DisasOps *o)
 {
-    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
+        gen_helper_lpq(o->out, cpu_env, o->in2);
+    } else if (HAVE_ATOMIC128) {
         gen_helper_lpq_parallel(o->out, cpu_env, o->in2);
     } else {
-        gen_helper_lpq(o->out, cpu_env, o->in2);
+        gen_helper_exit_atomic(cpu_env);
+        return DISAS_NORETURN;
     }
     return_low128(o->out2);
     return DISAS_NEXT;
@@ -4414,10 +4422,13 @@ static DisasJumpType op_stmh(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_stpq(DisasContext *s, DisasOps *o)
 {
-    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
+        gen_helper_stpq(cpu_env, o->in2, o->out2, o->out);
+    } else if (HAVE_ATOMIC128) {
         gen_helper_stpq_parallel(cpu_env, o->in2, o->out2, o->out);
     } else {
-        gen_helper_stpq(cpu_env, o->in2, o->out2, o->out);
+        gen_helper_exit_atomic(cpu_env);
+        return DISAS_NORETURN;
     }
     return DISAS_NEXT;
 }
-- 
2.17.2
