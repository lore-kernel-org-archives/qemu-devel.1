Received: from eggs.gnu.org ([2001:4830:134:3::10]:57794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fsUJl-0005VH-8K
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fsUJh-0000Bk-Jl
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:41:03 -0400
From: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Date: Wed, 22 Aug 2018 10:40:38 -0400
Message-Id: <20180822144039.5796-3-pavel.zbitskiy@gmail.com>
In-Reply-To: <20180822144039.5796-1-pavel.zbitskiy@gmail.com>
References: <20180822144039.5796-1-pavel.zbitskiy@gmail.com>
Subject: [Qemu-devel] [PATCH v4 2/3] target/s390x: exception on non-aligned
 LPSW(E)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com, richard.henderson@linaro.org, Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

Both LPSW and LPSWE should raise a specification exception when their
operand is not doubleword aligned.

This could've been done without a helper, but this would introduce a
new basic block, which would require making o->in2 local. This
could've also been done in load_psw helper, but this is too late -
specification exception should be recognized before memory accesses
take place.

Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
---
 target/s390x/helper.h     |  1 +
 target/s390x/mem_helper.c | 19 ++++++++++++-------
 target/s390x/translate.c  |  8 ++++++++
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 97c60ca7bc..b0df3267e5 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -120,6 +120,7 @@ DEF_HELPER_4(cu41, i32, env, i32, i32, i32)
 DEF_HELPER_4(cu42, i32, env, i32, i32, i32)
 DEF_HELPER_5(msa, i32, env, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_1(stpt, TCG_CALL_NO_RWG, i64, env)
+DEF_HELPER_FLAGS_3(check_alignment, TCG_CALL_NO_RWG, void, env, i64, i32)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index bacae4f503..75ca1997ad 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -81,13 +81,18 @@ static inline uint32_t adj_len_to_page(uint32_t len, uint64_t addr)
 /* Trigger a SPECIFICATION exception if an address or a length is not
    naturally aligned.  */
 static inline void check_alignment(CPUS390XState *env, uint64_t v,
-                                   int wordsize, uintptr_t ra)
+                                   uint32_t wordsize, int ilen, uintptr_t ra)
 {
     if (v % wordsize) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 6, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ilen, ra);
     }
 }
 
+void HELPER(check_alignment)(CPUS390XState *env, uint64_t v, uint32_t wordsize)
+{
+    check_alignment(env, v, wordsize, ILEN_AUTO, GETPC());
+}
+
 /* Load a value from memory according to its size.  */
 static inline uint64_t cpu_ldusize_data_ra(CPUS390XState *env, uint64_t addr,
                                            int wordsize, uintptr_t ra)
@@ -847,7 +852,7 @@ static inline uint32_t do_clcl(CPUS390XState *env,
     uint64_t len = MAX(*src1len, *src3len);
     uint32_t cc = 0;
 
-    check_alignment(env, *src1len | *src3len, wordsize, ra);
+    check_alignment(env, *src1len | *src3len, wordsize, 6, ra);
 
     if (!len) {
         return cc;
@@ -1348,7 +1353,7 @@ uint32_t HELPER(trXX)(CPUS390XState *env, uint32_t r1, uint32_t r2,
         tbl &= -8;
     }
 
-    check_alignment(env, len, ssize, ra);
+    check_alignment(env, len, ssize, 6, ra);
 
     /* Lest we fail to service interrupts in a timely manner, */
     /* limit the amount of work we're willing to do.   */
@@ -1400,7 +1405,7 @@ static void do_cdsg(CPUS390XState *env, uint64_t addr,
     } else {
         uint64_t oldh, oldl;
 
-        check_alignment(env, addr, 16, ra);
+        check_alignment(env, addr, 16, 6, ra);
 
         oldh = cpu_ldq_data_ra(env, addr + 0, ra);
         oldl = cpu_ldq_data_ra(env, addr + 8, ra);
@@ -2116,7 +2121,7 @@ static uint64_t do_lpq(CPUS390XState *env, uint64_t addr, bool parallel)
         lo = int128_getlo(v);
 #endif
     } else {
-        check_alignment(env, addr, 16, ra);
+        check_alignment(env, addr, 16, 6, ra);
 
         hi = cpu_ldq_data_ra(env, addr + 0, ra);
         lo = cpu_ldq_data_ra(env, addr + 8, ra);
@@ -2153,7 +2158,7 @@ static void do_stpq(CPUS390XState *env, uint64_t addr,
         helper_atomic_sto_be_mmu(env, addr, v, oi, ra);
 #endif
     } else {
-        check_alignment(env, addr, 16, ra);
+        check_alignment(env, addr, 16, 6, ra);
 
         cpu_stq_data_ra(env, addr + 0, high, ra);
         cpu_stq_data_ra(env, addr + 8, low, ra);
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 7363aabf3a..4161bd0b1f 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2828,9 +2828,13 @@ static DisasJumpType op_lpp(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_lpsw(DisasContext *s, DisasOps *o)
 {
+    TCGv_i32 t0;
     TCGv_i64 t1, t2;
 
     check_privileged(s);
+    t0 = tcg_const_i32(8);
+    gen_helper_check_alignment(cpu_env, o->in2, t0);
+    tcg_temp_free_i32(t0);
     per_breaking_event(s);
 
     t1 = tcg_temp_new_i64();
@@ -2848,9 +2852,13 @@ static DisasJumpType op_lpsw(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_lpswe(DisasContext *s, DisasOps *o)
 {
+    TCGv_i32 t0;
     TCGv_i64 t1, t2;
 
     check_privileged(s);
+    t0 = tcg_const_i32(8);
+    gen_helper_check_alignment(cpu_env, o->in2, t0);
+    tcg_temp_free_i32(t0);
     per_breaking_event(s);
 
     t1 = tcg_temp_new_i64();
-- 
2.18.0
