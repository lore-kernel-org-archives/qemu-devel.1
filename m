Received: from eggs.gnu.org ([209.51.188.92]:48156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gtGCM-0004uW-9g
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gtGCI-0004XJ-SW
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:20:54 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:54998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1gtGCI-00047G-Kt
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:20:50 -0500
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 11 Feb 2019 19:19:04 +0100
Message-Id: <20190211181907.2219-3-svens@stackframe.org>
In-Reply-To: <20190211181907.2219-2-svens@stackframe.org>
References: <20190211181907.2219-2-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/5] target/hppa: fix '</<=' conditions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>

These condition include the signed overflow bit. See Page 5-3 of
the Parisc 1.1 Architecture Reference manual for details.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/translate.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 51bfd9849d..0e8cc8117a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -404,6 +404,11 @@ static DisasCond cond_make_n(void)
     };
 }
 
+static bool cond_need_sv(int c)
+{
+        return c == 2 || c == 3 || c == 6;
+}
+
 static DisasCond cond_make_0(TCGCond c, TCGv_reg a0)
 {
     DisasCond r = { .c = c, .a1 = NULL, .a1_is_0 = true };
@@ -910,11 +915,17 @@ static DisasCond do_cond(unsigned cf, TCGv_reg res,
     case 1: /* = / <>        (Z / !Z) */
         cond = cond_make_0(TCG_COND_EQ, res);
         break;
-    case 2: /* < / >=        (N / !N) */
-        cond = cond_make_0(TCG_COND_LT, res);
+    case 2: /* < / >=        (N ^ V / !(N ^ V)) */
+        tmp = tcg_temp_new();
+        tcg_gen_xor_reg(tmp, res, sv);
+        cond = cond_make_0(TCG_COND_LT, tmp);
+        tcg_temp_free(tmp);
         break;
     case 3: /* <= / >        (N | Z / !N & !Z) */
-        cond = cond_make_0(TCG_COND_LE, res);
+        tmp = tcg_temp_new();
+        tcg_gen_xor_reg(tmp, res, sv);
+        cond = cond_make_0(TCG_COND_LE, tmp);
+        tcg_temp_free(tmp);
         break;
     case 4: /* NUV / UV      (!C / C) */
         cond = cond_make_0(TCG_COND_EQ, cb_msb);
@@ -1159,7 +1170,7 @@ static DisasJumpType do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 
     /* Compute signed overflow if required.  */
     sv = NULL;
-    if (is_tsv || c == 6) {
+    if (is_tsv || cond_need_sv(c)) {
         sv = do_add_sv(ctx, dest, in1, in2);
         if (is_tsv) {
             /* ??? Need to include overflow from shift.  */
@@ -1223,7 +1234,7 @@ static DisasJumpType do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 
     /* Compute signed overflow if required.  */
     sv = NULL;
-    if (is_tsv || c == 6) {
+    if (is_tsv || cond_need_sv(c)) {
         sv = do_sub_sv(ctx, dest, in1, in2);
         if (is_tsv) {
             gen_helper_tsv(cpu_env, sv);
@@ -1263,13 +1274,14 @@ static DisasJumpType do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 {
     TCGv_reg dest, sv;
     DisasCond cond;
+    int c = cf >> 1;
 
     dest = tcg_temp_new();
     tcg_gen_sub_reg(dest, in1, in2);
 
     /* Compute signed overflow if required.  */
     sv = NULL;
-    if ((cf >> 1) == 6) {
+    if (cond_need_sv(c)) {
         sv = do_sub_sv(ctx, dest, in1, in2);
     }
 
@@ -2808,7 +2820,7 @@ static DisasJumpType trans_ds(DisasContext *ctx, uint32_t insn,
     /* Install the new nullification.  */
     if (cf) {
         TCGv_reg sv = NULL;
-        if (cf >> 1 == 6) {
+        if (cond_need_sv(cf >> 1)) {
             /* ??? The lshift is supposed to contribute to overflow.  */
             sv = do_add_sv(ctx, dest, add1, add2);
         }
@@ -3369,7 +3381,7 @@ static DisasJumpType trans_cmpb(DisasContext *ctx, uint32_t insn,
     tcg_gen_sub_reg(dest, in1, in2);
 
     sv = NULL;
-    if (c == 6) {
+    if (cond_need_sv(c)) {
         sv = do_sub_sv(ctx, dest, in1, in2);
     }
 
@@ -3409,6 +3421,8 @@ static DisasJumpType trans_addb(DisasContext *ctx, uint32_t insn,
         tcg_gen_movi_reg(cb_msb, 0);
         tcg_gen_add2_reg(dest, cb_msb, in1, cb_msb, in2, cb_msb);
         break;
+    case 2:
+    case 3:
     case 6:
         tcg_gen_add_reg(dest, in1, in2);
         sv = do_add_sv(ctx, dest, in1, in2);
-- 
2.20.1
