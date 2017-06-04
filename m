Received: from eggs.gnu.org ([2001:4830:134:3::10]:52649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dHc0x-00033Y-To
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 16:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dHc0w-0004QP-Td
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 16:20:43 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:42628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dHc0w-0004N5-OC
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 16:20:42 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sun,  4 Jun 2017 22:20:33 +0200
Message-Id: <20170604202034.16615-3-aurelien@aurel32.net>
In-Reply-To: <20170604202034.16615-1-aurelien@aurel32.net>
References: <20170604202034.16615-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v4 2/3] target/s390x: implement STORE PAIR TO
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
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 24 ++++++++++++++++++++++++
 target/s390x/translate.c   |  6 ++++++
 4 files changed, 33 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 61d4ef899e..12d7f8fe95 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -104,6 +104,7 @@ DEF_HELPER_FLAGS_3(keb, TCG_CALL_NO_WG, i32, env, i64, i64)
 DEF_HELPER_FLAGS_3(kdb, TCG_CALL_NO_WG, i32, env, i64, i64)
 DEF_HELPER_FLAGS_5(kxb, TCG_CALL_NO_WG, i32, env, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_2(lpq, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_4(stpq, TCG_CALL_NO_WG, void, env, i64, i64, i64)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 32dee40269..73dd05daf0 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -796,6 +796,8 @@
 /* STORE ACCESS MULTIPLE */
     C(0x9b00, STAM,    RS_a,  Z,   0, a2, 0, 0, stam, 0)
     C(0xeb9b, STAMY,   RSY_a, LD,  0, a2, 0, 0, stam, 0)
+/* STORE PAIR TO QUADWORD */
+    C(0xe38e, STPQ,    RXY_a, Z,   0, a2, r1_P, 0, stpq, 0)
 
 /* SUBTRACT */
     C(0x1b00, SR,      RR_a,  Z,   r1, r2, new, r1_32, sub, subs32)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index f48908cecb..a8988e0293 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1692,6 +1692,30 @@ uint64_t HELPER(lpq)(CPUS390XState *env, uint64_t addr)
     return hi;
 }
 
+/* store pair to quadword */
+void HELPER(stpq)(CPUS390XState *env, uint64_t addr,
+                  uint64_t low, uint64_t high)
+{
+    uintptr_t ra = GETPC();
+
+    if (parallel_cpus) {
+#ifndef CONFIG_ATOMIC128
+        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
+#else
+        int mem_idx = cpu_mmu_index(env, false);
+        TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
+
+        Int128 v = int128_make128(low, high);
+        helper_atomic_sto_be_mmu(env, addr, v, oi, ra);
+#endif
+    } else {
+        check_alignment(env, addr, 16, ra);
+
+        cpu_stq_data_ra(env, addr + 0, high, ra);
+        cpu_stq_data_ra(env, addr + 8, low, ra);
+    }
+}
+
 /* Execute instruction.  This instruction executes an insn modified with
    the contents of r1.  It does not change the executed instruction in memory;
    it does not change the program counter.
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 3b621993cf..8702cc8cc7 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4198,6 +4198,12 @@ static ExitStatus op_stmh(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_stpq(DisasContext *s, DisasOps *o)
+{
+    gen_helper_stpq(cpu_env, o->in2, o->out2, o->out);
+    return NO_EXIT;
+}
+
 static ExitStatus op_srst(DisasContext *s, DisasOps *o)
 {
     gen_helper_srst(o->in1, cpu_env, regs[0], o->in1, o->in2);
-- 
2.11.0
