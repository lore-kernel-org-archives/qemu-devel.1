Received: from eggs.gnu.org ([2001:4830:134:3::10]:35068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Ul-00065s-IC
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Uk-00038d-Fg
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:35 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8Uk-00038B-9q
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:34 -0500
Received: by mail-pf0-x244.google.com with SMTP id y143so10360549pfb.1
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:34 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:28 -0800
Message-Id: <20170111021820.24416-14-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 13/65] target-alpha: Use deposit and extract ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/alpha/translate.c | 67 ++++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 25 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 114927b..5ac2277 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -949,7 +949,13 @@ static void gen_ext_h(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
                       uint8_t lit, uint8_t byte_mask)
 {
     if (islit) {
-        tcg_gen_shli_i64(vc, va, (64 - lit * 8) & 0x3f);
+        int pos = (64 - lit * 8) & 0x3f;
+        int len = cto32(byte_mask) * 8;
+        if (pos < len) {
+            tcg_gen_deposit_z_i64(vc, va, pos, len - pos);
+        } else {
+            tcg_gen_movi_i64(vc, 0);
+        }
     } else {
         TCGv tmp = tcg_temp_new();
         tcg_gen_shli_i64(tmp, load_gpr(ctx, rb), 3);
@@ -966,38 +972,44 @@ static void gen_ext_l(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
                       uint8_t lit, uint8_t byte_mask)
 {
     if (islit) {
-        tcg_gen_shri_i64(vc, va, (lit & 7) * 8);
+        int pos = (lit & 7) * 8;
+        int len = cto32(byte_mask) * 8;
+        if (pos + len >= 64) {
+            len = 64 - pos;
+        }
+        tcg_gen_extract_i64(vc, va, pos, len);
     } else {
         TCGv tmp = tcg_temp_new();
         tcg_gen_andi_i64(tmp, load_gpr(ctx, rb), 7);
         tcg_gen_shli_i64(tmp, tmp, 3);
         tcg_gen_shr_i64(vc, va, tmp);
         tcg_temp_free(tmp);
+        gen_zapnoti(vc, vc, byte_mask);
     }
-    gen_zapnoti(vc, vc, byte_mask);
 }
 
 /* INSWH, INSLH, INSQH */
 static void gen_ins_h(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
                       uint8_t lit, uint8_t byte_mask)
 {
-    TCGv tmp = tcg_temp_new();
-
-    /* The instruction description has us left-shift the byte mask and extract
-       bits <15:8> and apply that zap at the end.  This is equivalent to simply
-       performing the zap first and shifting afterward.  */
-    gen_zapnoti(tmp, va, byte_mask);
-
     if (islit) {
-        lit &= 7;
-        if (unlikely(lit == 0)) {
-            tcg_gen_movi_i64(vc, 0);
+        int pos = 64 - (lit & 7) * 8;
+        int len = cto32(byte_mask) * 8;
+        if (pos < len) {
+            tcg_gen_extract_i64(vc, va, pos, len - pos);
         } else {
-            tcg_gen_shri_i64(vc, tmp, 64 - lit * 8);
+            tcg_gen_movi_i64(vc, 0);
         }
     } else {
+        TCGv tmp = tcg_temp_new();
         TCGv shift = tcg_temp_new();
 
+        /* The instruction description has us left-shift the byte mask
+           and extract bits <15:8> and apply that zap at the end.  This
+           is equivalent to simply performing the zap first and shifting
+           afterward.  */
+        gen_zapnoti(tmp, va, byte_mask);
+
         /* If (B & 7) == 0, we need to shift by 64 and leave a zero.  Do this
            portably by splitting the shift into two parts: shift_count-1 and 1.
            Arrange for the -1 by using ones-complement instead of
@@ -1010,32 +1022,37 @@ static void gen_ins_h(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
         tcg_gen_shr_i64(vc, tmp, shift);
         tcg_gen_shri_i64(vc, vc, 1);
         tcg_temp_free(shift);
+        tcg_temp_free(tmp);
     }
-    tcg_temp_free(tmp);
 }
 
 /* INSBL, INSWL, INSLL, INSQL */
 static void gen_ins_l(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
                       uint8_t lit, uint8_t byte_mask)
 {
-    TCGv tmp = tcg_temp_new();
-
-    /* The instruction description has us left-shift the byte mask
-       the same number of byte slots as the data and apply the zap
-       at the end.  This is equivalent to simply performing the zap
-       first and shifting afterward.  */
-    gen_zapnoti(tmp, va, byte_mask);
-
     if (islit) {
-        tcg_gen_shli_i64(vc, tmp, (lit & 7) * 8);
+        int pos = (lit & 7) * 8;
+        int len = cto32(byte_mask) * 8;
+        if (pos + len > 64) {
+            len = 64 - pos;
+        }
+        tcg_gen_deposit_z_i64(vc, va, pos, len);
     } else {
+        TCGv tmp = tcg_temp_new();
         TCGv shift = tcg_temp_new();
+
+        /* The instruction description has us left-shift the byte mask
+           and extract bits <15:8> and apply that zap at the end.  This
+           is equivalent to simply performing the zap first and shifting
+           afterward.  */
+        gen_zapnoti(tmp, va, byte_mask);
+
         tcg_gen_andi_i64(shift, load_gpr(ctx, rb), 7);
         tcg_gen_shli_i64(shift, shift, 3);
         tcg_gen_shl_i64(vc, tmp, shift);
         tcg_temp_free(shift);
+        tcg_temp_free(tmp);
     }
-    tcg_temp_free(tmp);
 }
 
 /* MSKWH, MSKLH, MSKQH */
-- 
2.9.3
