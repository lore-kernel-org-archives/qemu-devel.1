Received: from eggs.gnu.org ([2001:4830:134:3::10]:34444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtw-0003eL-Mg
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtv-0002JP-Kt
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:44 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:32791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOtv-0002JF-Hg
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:43 -0400
Received: by mail-qk0-x242.google.com with SMTP id c206so15446376qkb.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:32:43 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:31:09 -0700
Message-Id: <20170607003119.14778-61-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 60/70] target/s390x: implement PACK ASCII
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

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170531220129.27724-24-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 35 +++++++++++++++++++++++++++++++++++
 target/s390x/translate.c   | 16 ++++++++++++++++
 4 files changed, 54 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 8ce5e3f..61f3ead 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -86,6 +86,7 @@ DEF_HELPER_FLAGS_2(sqdb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_3(sqxb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_1(cvd, TCG_CALL_NO_RWG_SE, i64, s32)
 DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_WG, void, env, i32, i64, i64)
+DEF_HELPER_FLAGS_4(pka, TCG_CALL_NO_WG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_4(unpk, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(tr, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_4(tre, i64, env, i64, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index d16857a..a5063a4 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -665,6 +665,8 @@
     /* Really format SS_b, but we pack both lengths into one argument
        for the helper call, so we might as well leave one 8-bit field.  */
     C(0xf200, PACK,    SS_a,  Z,   la1, a2, 0, 0, pack, 0)
+/* PACK ASCII */
+    C(0xe900, PKA,     SS_f,  E2,  la1, a2, 0, 0, pka, 0)
 
 /* PREFETCH */
     /* Implemented as nops of course.  */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 581f107..4cf96c8 100644
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
index 4f1a50e..4939311 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3299,6 +3299,22 @@ static ExitStatus op_pack(DisasContext *s, DisasOps *o)
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
2.9.4
