Received: from eggs.gnu.org ([209.51.188.92]:38713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gt8UG-0003U0-1e
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 05:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gt8UF-0005r0-BQ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 05:06:52 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:47082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gt8UD-0005ox-DH
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 05:06:49 -0500
Received: by mail-lf1-x142.google.com with SMTP id f5so7216415lfc.13
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 02:06:48 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 11 Feb 2019 02:06:31 -0800
Message-Id: <20190211100631.5263-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: get rid of gen_callw[i]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Merge gen_callwi and gen_callw into their only users, translate_callw
and translate_callxw. Extract jump slot adjustment logic into a separate
function and use it in gen_jumpi and translate_callw.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 6e4f0ad44c80..62283cd1ccc8 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -387,13 +387,19 @@ static void gen_jump(DisasContext *dc, TCGv dest)
     gen_jump_slot(dc, dest, -1);
 }
 
-static void gen_jumpi(DisasContext *dc, uint32_t dest, int slot)
+static int adjust_jump_slot(DisasContext *dc, uint32_t dest, int slot)
 {
-    TCGv_i32 tmp = tcg_const_i32(dest);
     if (((dc->base.pc_first ^ dest) & TARGET_PAGE_MASK) != 0) {
-        slot = -1;
+        return -1;
+    } else {
+        return slot;
     }
-    gen_jump_slot(dc, tmp, slot);
+}
+
+static void gen_jumpi(DisasContext *dc, uint32_t dest, int slot)
+{
+    TCGv_i32 tmp = tcg_const_i32(dest);
+    gen_jump_slot(dc, tmp, adjust_jump_slot(dc, dest, slot));
     tcg_temp_free(tmp);
 }
 
@@ -410,21 +416,6 @@ static void gen_callw_slot(DisasContext *dc, int callinc, TCGv_i32 dest,
     gen_jump_slot(dc, dest, slot);
 }
 
-static void gen_callw(DisasContext *dc, int callinc, TCGv_i32 dest)
-{
-    gen_callw_slot(dc, callinc, dest, -1);
-}
-
-static void gen_callwi(DisasContext *dc, int callinc, uint32_t dest, int slot)
-{
-    TCGv_i32 tmp = tcg_const_i32(dest);
-    if (((dc->base.pc_first ^ dest) & TARGET_PAGE_MASK) != 0) {
-        slot = -1;
-    }
-    gen_callw_slot(dc, callinc, tmp, slot);
-    tcg_temp_free(tmp);
-}
-
 static bool gen_check_loop_end(DisasContext *dc, int slot)
 {
     if (dc->base.pc_next == dc->lend) {
@@ -1477,7 +1468,9 @@ static void translate_call0(DisasContext *dc, const uint32_t arg[],
 static void translate_callw(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    gen_callwi(dc, par[0], arg[0], 0);
+    TCGv_i32 tmp = tcg_const_i32(arg[0]);
+    gen_callw_slot(dc, par[0], tmp, adjust_jump_slot(dc, arg[0], 0));
+    tcg_temp_free(tmp);
 }
 
 static void translate_callx0(DisasContext *dc, const uint32_t arg[],
@@ -1496,7 +1489,7 @@ static void translate_callxw(DisasContext *dc, const uint32_t arg[],
     TCGv_i32 tmp = tcg_temp_new_i32();
 
     tcg_gen_mov_i32(tmp, cpu_R[arg[0]]);
-    gen_callw(dc, par[0], tmp);
+    gen_callw_slot(dc, par[0], tmp, -1);
     tcg_temp_free(tmp);
 }
 
-- 
2.11.0
