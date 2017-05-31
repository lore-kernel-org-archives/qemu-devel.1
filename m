Received: from eggs.gnu.org ([2001:4830:134:3::10]:39138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dGBgU-0000yk-Sz
	for qemu-devel@nongnu.org; Wed, 31 May 2017 18:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dGBgT-0005OI-OX
	for qemu-devel@nongnu.org; Wed, 31 May 2017 18:01:42 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:35024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dGBgT-0005MY-Et
	for qemu-devel@nongnu.org; Wed, 31 May 2017 18:01:41 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu,  1 Jun 2017 00:01:22 +0200
Message-Id: <20170531220129.27724-24-aurelien@aurel32.net>
In-Reply-To: <20170531220129.27724-1-aurelien@aurel32.net>
References: <20170531220129.27724-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v3 23/30] target/s390x: implement PACK ASCII
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
 target/s390x/mem_helper.c  | 35 +++++++++++++++++++++++++++++++++++
 target/s390x/translate.c   | 16 ++++++++++++++++
 4 files changed, 54 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 5811911c34..78980643d1 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -83,6 +83,7 @@ DEF_HELPER_FLAGS_2(sqdb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_3(sqxb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_1(cvd, TCG_CALL_NO_RWG_SE, i64, s32)
 DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_WG, void, env, i32, i64, i64)
+DEF_HELPER_FLAGS_4(pka, TCG_CALL_NO_WG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_4(unpk, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(tr, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_4(tre, i64, env, i64, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index e3b7b78834..41431affe6 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -667,6 +667,8 @@
     /* Really format SS_b, but we pack both lengths into one argument
        for the helper call, so we might as well leave one 8-bit field.  */
     C(0xf200, PACK,    SS_a,  Z,   la1, a2, 0, 0, pack, 0)
+/* PACK ASCII */
+    C(0xe900, PKA,     SS_f,  E2,  la1, a2, 0, 0, pka, 0)
 
 /* PREFETCH */
     /* Implemented as nops of course.  */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index a2d65cfbbb..425d4b67df 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -914,6 +914,41 @@ void HELPER(pack)(CPUS390XState *env, uint32_t len, uint64_t dest, uint64_t src)
     }
 }
 
+void HELPER(pka)(CPUS390XState *env, uint64_t dest, uint64_t src,
+                 uint32_t srclen)
+{
+    uintptr_t ra = GETPC();
+    int i;
+    /* The destination operand is always 16 bytes long.  */
+    const int destlen = 16;
+
+    /* The operands are processed from right to left.  */
+    src += srclen - 1;
+    dest += destlen - 1;
+
+    for (i = 0; i < destlen; i++) {
+        uint8_t b = 0;
+
+        /* Start with a positive sign */
+        if (i == 0) {
+            b = 0xc;
+        } else if (srclen > 1) {
+            b = cpu_ldub_data_ra(env, src, ra) & 0x0f;
+            src--;
+            srclen--;
+        }
+
+        if (srclen > 1) {
+            b |= cpu_ldub_data_ra(env, src, ra) << 4;
+            src--;
+            srclen--;
+        }
+
+        cpu_stb_data_ra(env, dest, b, ra);
+        dest--;
+    }
+}
+
 void HELPER(unpk)(CPUS390XState *env, uint32_t len, uint64_t dest,
                   uint64_t src)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index b160a0cad7..5093995f9a 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3301,6 +3301,22 @@ static ExitStatus op_pack(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_pka(DisasContext *s, DisasOps *o)
+{
+    int l2 = get_field(s->fields, l2) + 1;
+    TCGv_i32 l;
+
+    /* The length must not exceed 32 bytes.  */
+    if (l2 > 32) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return EXIT_NORETURN;
+    }
+    l = tcg_const_i32(l2);
+    gen_helper_pka(cpu_env, o->addr1, o->in2, l);
+    tcg_temp_free_i32(l);
+    return NO_EXIT;
+}
+
 static ExitStatus op_popcnt(DisasContext *s, DisasOps *o)
 {
     gen_helper_popcnt(o->out, o->in2);
-- 
2.11.0
