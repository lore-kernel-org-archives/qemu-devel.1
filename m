Received: from eggs.gnu.org ([2001:4830:134:3::10]:35130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Uo-000694-GA
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Un-0003AW-J1
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:38 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:35029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8Un-0003AC-Db
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:37 -0500
Received: by mail-pf0-x244.google.com with SMTP id f144so12524759pfa.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:37 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:32 -0800
Message-Id: <20170111021820.24416-18-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 17/65] target-ppc: Use the new deposit and
 extract ops
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

Use the new primitives for RDWINM and RLDICL.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/ppc/translate.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 59e9552..435c6f0 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1975,16 +1975,16 @@ static void gen_rlwinm(DisasContext *ctx)
 {
     TCGv t_ra = cpu_gpr[rA(ctx->opcode)];
     TCGv t_rs = cpu_gpr[rS(ctx->opcode)];
-    uint32_t sh = SH(ctx->opcode);
-    uint32_t mb = MB(ctx->opcode);
-    uint32_t me = ME(ctx->opcode);
-
-    if (mb == 0 && me == (31 - sh)) {
-        tcg_gen_shli_tl(t_ra, t_rs, sh);
-        tcg_gen_ext32u_tl(t_ra, t_ra);
-    } else if (sh != 0 && me == 31 && sh == (32 - mb)) {
-        tcg_gen_ext32u_tl(t_ra, t_rs);
-        tcg_gen_shri_tl(t_ra, t_ra, mb);
+    int sh = SH(ctx->opcode);
+    int mb = MB(ctx->opcode);
+    int me = ME(ctx->opcode);
+    int len = me - mb + 1;
+    int rsh = (32 - sh) & 31;
+
+    if (sh != 0 && len > 0 && me == (31 - sh)) {
+        tcg_gen_deposit_z_tl(t_ra, t_rs, sh, len);
+    } else if (me == 31 && rsh + len <= 32) {
+        tcg_gen_extract_tl(t_ra, t_rs, rsh, len);
     } else {
         target_ulong mask;
 #if defined(TARGET_PPC64)
@@ -1992,8 +1992,9 @@ static void gen_rlwinm(DisasContext *ctx)
         me += 32;
 #endif
         mask = MASK(mb, me);
-
-        if (mask <= 0xffffffffu) {
+        if (sh == 0) {
+            tcg_gen_andi_tl(t_ra, t_rs, mask);
+        } else if (mask <= 0xffffffffu) {
             TCGv_i32 t0 = tcg_temp_new_i32();
             tcg_gen_trunc_tl_i32(t0, t_rs);
             tcg_gen_rotli_i32(t0, t0, sh);
@@ -2096,11 +2097,13 @@ static void gen_rldinm(DisasContext *ctx, int mb, int me, int sh)
 {
     TCGv t_ra = cpu_gpr[rA(ctx->opcode)];
     TCGv t_rs = cpu_gpr[rS(ctx->opcode)];
+    int len = me - mb + 1;
+    int rsh = (64 - sh) & 63;
 
-    if (sh != 0 && mb == 0 && me == (63 - sh)) {
-        tcg_gen_shli_tl(t_ra, t_rs, sh);
-    } else if (sh != 0 && me == 63 && sh == (64 - mb)) {
-        tcg_gen_shri_tl(t_ra, t_rs, mb);
+    if (sh != 0 && len > 0 && me == (63 - sh)) {
+        tcg_gen_deposit_z_tl(t_ra, t_rs, sh, len);
+    } else if (me == 63 && rsh + len <= 64) {
+        tcg_gen_extract_tl(t_ra, t_rs, rsh, len);
     } else {
         tcg_gen_rotli_tl(t_ra, t_rs, sh);
         tcg_gen_andi_tl(t_ra, t_ra, MASK(mb, me));
-- 
2.9.3
