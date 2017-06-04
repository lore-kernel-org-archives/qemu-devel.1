Received: from eggs.gnu.org ([2001:4830:134:3::10]:50619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRp-0007xz-Uj
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRp-0003k3-17
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:17 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZRo-0003jK-RY
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:16 -0400
Received: by mail-pg0-x241.google.com with SMTP id v18so3986786pgb.3
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:36:16 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:46 -0700
Message-Id: <20170604173509.29684-47-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 46/69] target/s390x: implement LOAD PAIR FROM
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
Message-Id: <20170531220129.27724-8-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 13 +++++++++++++
 target/s390x/translate.c   |  7 +++++++
 4 files changed, 23 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index c6fbc3b..ca78d1b 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -87,6 +87,7 @@ DEF_HELPER_FLAGS_2(sfas, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_1(popcnt, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_2(stfle, i32, env, i64)
+DEF_HELPER_FLAGS_2(lpq, TCG_CALL_NO_WG, i64, env, i64)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index f92bfde..53c86d5 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -507,6 +507,8 @@
 /* LOAD PAIR DISJOINT */
     D(0xc804, LPD,     SSF,   ILA, 0, 0, new_P, r3_P32, lpd, 0, MO_TEUL)
     D(0xc805, LPDG,    SSF,   ILA, 0, 0, new_P, r3_P64, lpd, 0, MO_TEQ)
+/* LOAD PAIR FROM QUADWORD */
+    C(0xe38f, LPQ,     RXY_a, Z,   0, a2, r1_P, 0, lpq, 0)
 /* LOAD POSITIVE */
     C(0x1000, LPR,     RR_a,  Z,   0, r2_32s, new, r1_32, abs, abs32)
     C(0xb900, LPGR,    RRE,   Z,   0, r2, r1, 0, abs, abs64)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 850472e..4f34f87 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1237,6 +1237,19 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
 }
 #endif
 
+/* load pair from quadword */
+uint64_t HELPER(lpq)(CPUS390XState *env, uint64_t addr)
+{
+    uintptr_t ra = GETPC();
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
+
+    Int128 v = helper_atomic_ldo_be_mmu(env, addr, oi, ra);
+
+    env->retxl = int128_getlo(v);
+    return int128_gethi(v);
+}
+
 /* Execute instruction.  This instruction executes an insn modified with
    the contents of r1.  It does not change the executed instruction in memory;
    it does not change the program counter.
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 00b91c4..ec61590 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2830,6 +2830,13 @@ static ExitStatus op_lpd(DisasContext *s, DisasOps *o)
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
