Received: from eggs.gnu.org ([2001:4830:134:3::10]:39339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dGBgd-00016u-A3
	for qemu-devel@nongnu.org; Wed, 31 May 2017 18:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dGBgb-0005TU-Kg
	for qemu-devel@nongnu.org; Wed, 31 May 2017 18:01:51 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:34976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dGBgb-0005Lr-8T
	for qemu-devel@nongnu.org; Wed, 31 May 2017 18:01:49 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu,  1 Jun 2017 00:01:12 +0200
Message-Id: <20170531220129.27724-14-aurelien@aurel32.net>
In-Reply-To: <20170531220129.27724-1-aurelien@aurel32.net>
References: <20170531220129.27724-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v3 13/30] target/s390x: implement MOVE ZONES
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
index a197b8bc39..ba21e4d870 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -16,6 +16,7 @@ DEF_HELPER_4(clst, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(mvn, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(mvo, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(mvpg, TCG_CALL_NO_WG, i32, env, i64, i64, i64)
+DEF_HELPER_FLAGS_4(mvz, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_4(mvst, i64, env, i64, i64, i64)
 DEF_HELPER_4(ex, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(stam, TCG_CALL_NO_WG, void, env, i32, i64, i32)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 47542eeaf3..b40611b75f 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -588,6 +588,8 @@
     /* Really format SS_b, but we pack both lengths into one argument
        for the helper call, so we might as well leave one 8-bit field.  */
     C(0xf100, MVO,     SS_a,  Z,   la1, a2, 0, 0, mvo, 0)
+/* MOVE ZONES */
+    C(0xd300, MVZ,     SS_a,  Z,   la1, a2, 0, 0, mvz, 0)
 
 /* MULTIPLY */
     C(0x1c00, MR,      RR_a,  Z,   r1p1_32s, r2_32s, new, r1_D32, mul, 0)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 3601bb9cdd..95f701dae2 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -287,6 +287,19 @@ void HELPER(mvo)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
     }
 }
 
+/* move zones  */
+void HELPER(mvz)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
+{
+    uintptr_t ra = GETPC();
+    int i;
+
+    for (i = 0; i <= l; i++) {
+        uint8_t b = cpu_ldub_data_ra(env, dest + i, ra) & 0x0f;
+        b |= cpu_ldub_data_ra(env, src + i, ra) & 0xf0;
+        cpu_stb_data_ra(env, dest + i, b, ra);
+    }
+}
+
 /* compare unsigned byte arrays */
 static uint32_t do_helper_clc(CPUS390XState *env, uint32_t l, uint64_t s1,
                               uint64_t s2, uintptr_t ra)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index b1877cf27b..95ca53c1ef 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3021,6 +3021,14 @@ static ExitStatus op_mvst(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_mvz(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
+    gen_helper_mvz(cpu_env, l, o->addr1, o->in2);
+    tcg_temp_free_i32(l);
+    return NO_EXIT;
+}
+
 static ExitStatus op_mul(DisasContext *s, DisasOps *o)
 {
     tcg_gen_mul_i64(o->out, o->in1, o->in2);
-- 
2.11.0
