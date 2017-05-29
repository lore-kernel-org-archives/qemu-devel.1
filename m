Received: from eggs.gnu.org ([2001:4830:134:3::10]:38874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHd-0006U6-Ga
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHa-00075c-Hr
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:53 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:42886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFQHa-00072Y-4o
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:50 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 29 May 2017 21:24:22 +0200
Message-Id: <20170529192440.5990-12-aurelien@aurel32.net>
In-Reply-To: <20170529192440.5990-1-aurelien@aurel32.net>
References: <20170529192440.5990-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v2 11/29] target/s390x: implement MOVE NUMERICS
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

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 13 +++++++++++++
 target/s390x/translate.c   |  8 ++++++++
 4 files changed, 24 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 26a7abe4b4..a377997df5 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -13,6 +13,7 @@ DEF_HELPER_FLAGS_3(divs64, TCG_CALL_NO_WG, s64, env, s64, s64)
 DEF_HELPER_FLAGS_4(divu64, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
 DEF_HELPER_4(srst, i64, env, i64, i64, i64)
 DEF_HELPER_4(clst, i64, env, i64, i64, i64)
+DEF_HELPER_FLAGS_4(mvn, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(mvpg, TCG_CALL_NO_WG, i32, env, i64, i64, i64)
 DEF_HELPER_4(mvst, i64, env, i64, i64, i64)
 DEF_HELPER_4(ex, void, env, i32, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index c8f77611ab..6af717648c 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -578,6 +578,8 @@
     C(0x0e00, MVCL,    RR_a,  Z,   0, 0, 0, 0, mvcl, 0)
 /* MOVE LONG EXTENDED */
     C(0xa800, MVCLE,   RS_a,  Z,   0, a2, 0, 0, mvcle, 0)
+/* MOVE NUMERICS */
+    C(0xd100, MVN,     SS_a,  Z,   la1, a2, 0, 0, mvn, 0)
 /* MOVE PAGE */
     C(0xb254, MVPG,    RRE,   Z,   r1_o, r2_o, 0, 0, mvpg, 0)
 /* MOVE STRING */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index eacd2bc794..4fb6ff29c3 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -243,6 +243,19 @@ void HELPER(mvcin)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
     }
 }
 
+/* move numerics  */
+void HELPER(mvn)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
+{
+    uintptr_t ra = GETPC();
+    int i;
+
+    for (i = 0; i <= l; i++) {
+        uint8_t v = cpu_ldub_data_ra(env, dest + i, ra) & 0xf0;
+        v |= cpu_ldub_data_ra(env, src + i, ra) & 0x0f;
+        cpu_stb_data_ra(env, dest + i, v, ra);
+    }
+}
+
 /* compare unsigned byte arrays */
 static uint32_t do_helper_clc(CPUS390XState *env, uint32_t l, uint64_t s1,
                               uint64_t s2, uintptr_t ra)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 61373df29e..4e7211203a 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2990,6 +2990,14 @@ static ExitStatus op_mvcs(DisasContext *s, DisasOps *o)
 }
 #endif
 
+static ExitStatus op_mvn(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
+    gen_helper_mvn(cpu_env, l, o->addr1, o->in2);
+    tcg_temp_free_i32(l);
+    return NO_EXIT;
+}
+
 static ExitStatus op_mvpg(DisasContext *s, DisasOps *o)
 {
     gen_helper_mvpg(cc_op, cpu_env, regs[0], o->in1, o->in2);
-- 
2.11.0
