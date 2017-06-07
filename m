Received: from eggs.gnu.org ([2001:4830:134:3::10]:34512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOu5-0003w9-9U
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOu4-0002S6-7i
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:53 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOu4-0002Rd-43
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:52 -0400
Received: by mail-qt0-x241.google.com with SMTP id s33so19305660qtg.3
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:32:52 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:31:15 -0700
Message-Id: <20170607003119.14778-67-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 66/70] target/s390x: implement LOAD PAIR FROM
 QUADWORD
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

From: Aurelien Jarno <aurelien@aurel32.net>

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170604202034.16615-2-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 27 +++++++++++++++++++++++++++
 target/s390x/translate.c   |  7 +++++++
 4 files changed, 37 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 11a545e..054ccd6 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -103,6 +103,7 @@ DEF_HELPER_FLAGS_2(sfas, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_1(popcnt, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_2(stfle, i32, env, i64)
+DEF_HELPER_FLAGS_2(lpq, TCG_CALL_NO_WG, i64, env, i64)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 9976d29..32dee40 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -517,6 +517,8 @@
 /* LOAD PAIR DISJOINT */
     D(0xc804, LPD,     SSF,   ILA, 0, 0, new_P, r3_P32, lpd, 0, MO_TEUL)
     D(0xc805, LPDG,    SSF,   ILA, 0, 0, new_P, r3_P64, lpd, 0, MO_TEQ)
+/* LOAD PAIR FROM QUADWORD */
+    C(0xe38f, LPQ,     RXY_a, Z,   0, a2, r1_P, 0, lpq, 0)
 /* LOAD POSITIVE */
     C(0x1000, LPR,     RR_a,  Z,   0, r2_32s, new, r1_32, abs, abs32)
     C(0xb900, LPGR,    RRE,   Z,   0, r2, r1, 0, abs, abs64)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index be89cc4..f48908c 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1665,6 +1665,33 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
 }
 #endif
 
+/* load pair from quadword */
+uint64_t HELPER(lpq)(CPUS390XState *env, uint64_t addr)
+{
+    uintptr_t ra = GETPC();
+    uint64_t hi, lo;
+
+    if (parallel_cpus) {
+#ifndef CONFIG_ATOMIC128
+        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
+#else
+        int mem_idx = cpu_mmu_index(env, false);
+        TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
+        Int128 v = helper_atomic_ldo_be_mmu(env, addr, oi, ra);
+        hi = int128_gethi(v);
+        lo = int128_getlo(v);
+#endif
+    } else {
+        check_alignment(env, addr, 16, ra);
+
+        hi = cpu_ldq_data_ra(env, addr + 0, ra);
+        lo = cpu_ldq_data_ra(env, addr + 8, ra);
+    }
+
+    env->retxl = lo;
+    return hi;
+}
+
 /* Execute instruction.  This instruction executes an insn modified with
    the contents of r1.  It does not change the executed instruction in memory;
    it does not change the program counter.
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 9f3443e..10019ed 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2909,6 +2909,13 @@ static ExitStatus op_lpd(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_lpq(DisasContext *s, DisasOps *o)
+{
+    gen_helper_lpq(o->out, cpu_env, o->in2);
+    return_low128(o->out2);
+    return NO_EXIT;
+}
+
 #ifndef CONFIG_USER_ONLY
 static ExitStatus op_lura(DisasContext *s, DisasOps *o)
 {
-- 
2.9.4
