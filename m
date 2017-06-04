Received: from eggs.gnu.org ([2001:4830:134:3::10]:50890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZSH-0008QD-Do
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZSD-00049D-EU
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:45 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZSD-00048q-8Q
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:41 -0400
Received: by mail-pg0-x241.google.com with SMTP id f127so7257439pgc.2
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:36:41 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:35:04 -0700
Message-Id: <20170604173509.29684-65-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 64/69] target/s390x: implement UNPACK ASCII
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
Message-Id: <20170531220129.27724-26-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/translate.c   | 17 ++++++++++++++++
 4 files changed, 71 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 5b61a0d..42c3de6 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -86,6 +86,7 @@ DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(pka, TCG_CALL_NO_WG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_4(pku, TCG_CALL_NO_WG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_4(unpk, TCG_CALL_NO_WG, void, env, i32, i64, i64)
+DEF_HELPER_FLAGS_4(unpka, TCG_CALL_NO_WG, i32, env, i64, i32, i64)
 DEF_HELPER_FLAGS_4(tr, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_4(tre, i64, env, i64, i64, i64)
 DEF_HELPER_4(trt, i32, env, i32, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 16f788c..33434a3 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -875,6 +875,8 @@
     /* Really format SS_b, but we pack both lengths into one argument
        for the helper call, so we might as well leave one 8-bit field.  */
     C(0xf300, UNPK,    SS_a,  Z,   la1, a2, 0, 0, unpk, 0)
+/* UNPACK ASCII */
+    C(0xea00, UNPKA,   SS_a,  E2,  la1, a2, 0, 0, unpka, 0)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index d827a12..1c5f29c 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1008,6 +1008,57 @@ void HELPER(unpk)(CPUS390XState *env, uint32_t len, uint64_t dest,
     }
 }
 
+uint32_t HELPER(unpka)(CPUS390XState *env, uint64_t dest, uint32_t destlen,
+                       uint64_t src)
+{
+    uintptr_t ra = GETPC();
+    int i;
+    uint32_t cc;
+    uint8_t b;
+    /* The source operand is always 16 bytes long.  */
+    const int srclen = 16;
+
+    /* The operands are processed from right to left.  */
+    src += srclen - 1;
+    dest += destlen - 1;
+
+    /* Check for the sign.  */
+    b = cpu_ldub_data_ra(env, src, ra);
+    src--;
+    switch (b & 0xf) {
+    case 0xa:
+    case 0xc:
+    case 0xe ... 0xf:
+        cc = 0;  /* plus */
+        break;
+    case 0xb:
+    case 0xd:
+        cc = 1;  /* minus */
+        break;
+    default:
+    case 0x0 ... 0x9:
+        cc = 3;  /* invalid */
+        break;
+    }
+
+    /* Now pad every nibble with 0x30, advancing one nibble at a time. */
+    for (i = 0; i < destlen; i++) {
+        if (i == 31) {
+            /* If length is 32 bytes, the leftmost byte is 0. */
+            b = 0;
+        } else if (i % 2) {
+            b = cpu_ldub_data_ra(env, src, ra);
+            src--;
+        } else {
+            b >>= 4;
+        }
+        cpu_stb_data_ra(env, dest, 0x30 + (b & 0xf), ra);
+        dest--;
+    }
+
+    return cc;
+}
+
 static uint32_t do_helper_tr(CPUS390XState *env, uint32_t len, uint64_t array,
                              uint64_t trans, uintptr_t ra)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index d8b0515..2ff6665 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4357,6 +4357,23 @@ static ExitStatus op_unpk(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_unpka(DisasContext *s, DisasOps *o)
+{
+    int l1 = get_field(s->fields, l1) + 1;
+    TCGv_i32 l;
+
+    /* The length must not exceed 32 bytes.  */
+    if (l1 > 32) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return EXIT_NORETURN;
+    }
+    l = tcg_const_i32(l1);
+    gen_helper_unpka(cc_op, cpu_env, o->addr1, l, o->in2);
+    tcg_temp_free_i32(l);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 static ExitStatus op_xc(DisasContext *s, DisasOps *o)
 {
     int d1 = get_field(s->fields, d1);
-- 
2.9.4
