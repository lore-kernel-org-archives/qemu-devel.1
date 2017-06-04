Received: from eggs.gnu.org ([2001:4830:134:3::10]:50630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRr-0007y1-Bm
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRq-0003kj-DG
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:19 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZRq-0003kX-7B
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:18 -0400
Received: by mail-pf0-x242.google.com with SMTP id n23so18101374pfb.3
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:36:18 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:47 -0700
Message-Id: <20170604173509.29684-48-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 47/69] target/s390x: implement STORE PAIR TO
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
Message-Id: <20170531220129.27724-9-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 12 ++++++++++++
 target/s390x/translate.c   |  6 ++++++
 4 files changed, 21 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index ca78d1b..596fec2 100644
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
index 53c86d5..5314162 100644
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
index 4f34f87..15b5f45 100644
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
+    TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
+
+    Int128 v = int128_make128(low, high);
+    helper_atomic_sto_be_mmu(env, addr, v, oi, ra);
+}
+
 /* Execute instruction.  This instruction executes an insn modified with
    the contents of r1.  It does not change the executed instruction in memory;
    it does not change the program counter.
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index ec61590..6635877 100644
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
2.9.4
