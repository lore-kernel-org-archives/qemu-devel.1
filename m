Received: from eggs.gnu.org ([2001:4830:134:3::10]:55320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdW0-0006bb-OH
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdVz-0005b7-Su
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:00 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdVz-0005al-OA
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:59 -0500
Received: by mail-pg0-x244.google.com with SMTP id b1so2475201pgc.1
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:00:59 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.00.57 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:00:58 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 19:59:54 -0800
Message-Id: <20161224040042.12654-18-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 17/65] target-ppc: Use the new deposit and
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
