Received: from eggs.gnu.org ([2001:4830:134:3::10]:39361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dGBgd-00017J-O5
	for qemu-devel@nongnu.org; Wed, 31 May 2017 18:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dGBgb-0005UD-Mj
	for qemu-devel@nongnu.org; Wed, 31 May 2017 18:01:51 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:34966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dGBgb-0005Ld-9X
	for qemu-devel@nongnu.org; Wed, 31 May 2017 18:01:49 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu,  1 Jun 2017 00:01:09 +0200
Message-Id: <20170531220129.27724-11-aurelien@aurel32.net>
In-Reply-To: <20170531220129.27724-1-aurelien@aurel32.net>
References: <20170531220129.27724-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v3 10/30] target/s390x: implement MOVE INVERSE
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
 target/s390x/mem_helper.c  | 12 ++++++++++++
 target/s390x/translate.c   |  8 ++++++++
 4 files changed, 23 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 4ada89488b..a618fe5539 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -3,6 +3,7 @@ DEF_HELPER_FLAGS_4(nc, TCG_CALL_NO_WG, i32, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(oc, TCG_CALL_NO_WG, i32, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(xc, TCG_CALL_NO_WG, i32, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(mvc, TCG_CALL_NO_WG, void, env, i32, i64, i64)
+DEF_HELPER_FLAGS_4(mvcin, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(clc, TCG_CALL_NO_WG, i32, env, i32, i64, i64)
 DEF_HELPER_3(mvcl, i32, env, i32, i32)
 DEF_HELPER_FLAGS_4(clm, TCG_CALL_NO_WG, i32, env, i32, i32, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 01278949fc..c8f77611ab 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -572,6 +572,8 @@
     C(0xe548, MVGHI,   SIL,   GIE, la1, i2, 0, m1_64, mov2, 0)
     C(0x9200, MVI,     SI,    Z,   la1, i2, 0, m1_8, mov2, 0)
     C(0xeb52, MVIY,    SIY,   LD,  la1, i2, 0, m1_8, mov2, 0)
+/* MOVE INVERSE */
+    C(0xe800, MVCIN,   SS_a,  Z,   la1, a2, 0, 0, mvcin, 0)
 /* MOVE LONG */
     C(0x0e00, MVCL,    RR_a,  Z,   0, 0, 0, 0, mvcl, 0)
 /* MOVE LONG EXTENDED */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 15b5f45b77..eef754724d 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -231,6 +231,18 @@ void HELPER(mvc)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
     do_helper_mvc(env, l, dest, src, GETPC());
 }
 
+/* move inverse  */
+void HELPER(mvcin)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
+{
+    uintptr_t ra = GETPC();
+    int i;
+
+    for (i = 0; i <= l; i++) {
+        uint8_t v = cpu_ldub_data_ra(env, src - i, ra);
+        cpu_stb_data_ra(env, dest + i, v, ra);
+    }
+}
+
 /* compare unsigned byte arrays */
 static uint32_t do_helper_clc(CPUS390XState *env, uint32_t l, uint64_t s1,
                               uint64_t s2, uintptr_t ra)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 30d0575c03..61373df29e 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2940,6 +2940,14 @@ static ExitStatus op_mvc(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_mvcin(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
+    gen_helper_mvcin(cpu_env, l, o->addr1, o->in2);
+    tcg_temp_free_i32(l);
+    return NO_EXIT;
+}
+
 static ExitStatus op_mvcl(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
-- 
2.11.0
