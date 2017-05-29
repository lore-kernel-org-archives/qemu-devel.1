Received: from eggs.gnu.org ([2001:4830:134:3::10]:38822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHc-0006Tw-Ar
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHa-000749-8w
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:52 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:42894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFQHZ-00072c-VP
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:50 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 29 May 2017 21:24:19 +0200
Message-Id: <20170529192440.5990-9-aurelien@aurel32.net>
In-Reply-To: <20170529192440.5990-1-aurelien@aurel32.net>
References: <20170529192440.5990-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v2 08/29] target/s390x: implement STORE PAIR TO
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
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 12 ++++++++++++
 target/s390x/translate.c   |  6 ++++++
 4 files changed, 21 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index ca78d1b162..596fec28ca 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -88,6 +88,7 @@ DEF_HELPER_FLAGS_1(popcnt, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_2(stfle, i32, env, i64)
 DEF_HELPER_FLAGS_2(lpq, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_4(stpq, TCG_CALL_NO_WG, void, env, i64, i64, i64)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 53c86d5832..5314162b3d 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -770,6 +770,8 @@
 /* STORE ACCESS MULTIPLE */
     C(0x9b00, STAM,    RS_a,  Z,   0, a2, 0, 0, stam, 0)
     C(0xeb9b, STAMY,   RSY_a, LD,  0, a2, 0, 0, stam, 0)
+/* STORE PAIR TO QUADWORD */
+    C(0xe38e, STPQ,    RXY_a, Z,   0, a2, r1_P, 0, stpq, 0)
 
 /* SUBTRACT */
     C(0x1b00, SR,      RR_a,  Z,   r1, r2, new, r1_32, sub, subs32)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 4cbd273e4a..0c34c78b93 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1250,6 +1250,18 @@ uint64_t HELPER(lpq)(CPUS390XState *env, uint64_t addr)
     return int128_gethi(v);
 }
 
+/* store pair to quadword */
+void HELPER(stpq)(CPUS390XState *env, uint64_t addr,
+                  uint64_t low, uint64_t high)
+{
+    uintptr_t ra = GETPC();
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOpIdx oi = make_memop_idx(MO_TEQ, mem_idx);
+
+    Int128 v = int128_make128(low, high);
+    helper_atomic_sto_be_mmu(env, addr, v, oi, ra);
+}
+
 /* Execute instruction.  This instruction executes an insn modified with
    the contents of r1.  It does not change the executed instruction in memory;
    it does not change the program counter.
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index ec61590e50..6635877bbd 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4019,6 +4019,12 @@ static ExitStatus op_stmh(DisasContext *s, DisasOps *o)
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
