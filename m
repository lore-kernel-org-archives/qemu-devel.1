Received: from eggs.gnu.org ([2001:4830:134:3::10]:58810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cjq4f-0002cI-5H
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cjq4c-0001lC-0c
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:28:57 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cjq4b-0001kV-OP
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:28:53 -0500
Received: by mail-wm0-x243.google.com with SMTP id n11so3945886wma.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 08:28:53 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  3 Mar 2017 17:28:48 +0100
Message-Id: <1488558530-21016-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] hppa: avoid anonymous unions in designated
 initializers.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>

These cause compilation failures on CentOS 6 or other operating
systems with older GCCs.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	Peter, please consider applying this as a build fix, because
	the centos6 docker target is broken.

 target/hppa/translate.c | 66 ++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 5d571f0..9e8c233 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -84,14 +84,14 @@ typedef struct DisasInsn {
     ExitStatus (*trans)(DisasContext *ctx, uint32_t insn,
                         const struct DisasInsn *f);
     union {
-        void (*f_ttt)(TCGv, TCGv, TCGv);
-        void (*f_weww)(TCGv_i32, TCGv_env, TCGv_i32, TCGv_i32);
-        void (*f_dedd)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64);
-        void (*f_wew)(TCGv_i32, TCGv_env, TCGv_i32);
-        void (*f_ded)(TCGv_i64, TCGv_env, TCGv_i64);
-        void (*f_wed)(TCGv_i32, TCGv_env, TCGv_i64);
-        void (*f_dew)(TCGv_i64, TCGv_env, TCGv_i32);
-    };
+        void (*ttt)(TCGv, TCGv, TCGv);
+        void (*weww)(TCGv_i32, TCGv_env, TCGv_i32, TCGv_i32);
+        void (*dedd)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64);
+        void (*wew)(TCGv_i32, TCGv_env, TCGv_i32);
+        void (*ded)(TCGv_i64, TCGv_env, TCGv_i64);
+        void (*wed)(TCGv_i32, TCGv_env, TCGv_i64);
+        void (*dew)(TCGv_i64, TCGv_env, TCGv_i32);
+    } f;
 } DisasInsn;
 
 /* global register indexes */
@@ -1934,7 +1934,7 @@ static ExitStatus trans_log(DisasContext *ctx, uint32_t insn,
     }
     tcg_r1 = load_gpr(ctx, r1);
     tcg_r2 = load_gpr(ctx, r2);
-    ret = do_log(ctx, rt, tcg_r1, tcg_r2, cf, di->f_ttt);
+    ret = do_log(ctx, rt, tcg_r1, tcg_r2, cf, di->f.ttt);
     return nullify_end(ctx, ret);
 }
 
@@ -2111,10 +2111,10 @@ static ExitStatus trans_ds(DisasContext *ctx, uint32_t insn,
 static const DisasInsn table_arith_log[] = {
     { 0x08000240u, 0xfc00ffffu, trans_nop },  /* or x,y,0 */
     { 0x08000240u, 0xffe0ffe0u, trans_copy }, /* or x,0,t */
-    { 0x08000000u, 0xfc000fe0u, trans_log, .f_ttt = tcg_gen_andc_tl },
-    { 0x08000200u, 0xfc000fe0u, trans_log, .f_ttt = tcg_gen_and_tl },
-    { 0x08000240u, 0xfc000fe0u, trans_log, .f_ttt = tcg_gen_or_tl },
-    { 0x08000280u, 0xfc000fe0u, trans_log, .f_ttt = tcg_gen_xor_tl },
+    { 0x08000000u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_andc_tl },
+    { 0x08000200u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_and_tl },
+    { 0x08000240u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_or_tl },
+    { 0x08000280u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_xor_tl },
     { 0x08000880u, 0xfc000fe0u, trans_cmpclr },
     { 0x08000380u, 0xfc000fe0u, trans_uxor },
     { 0x08000980u, 0xfc000fa0u, trans_uaddcm },
@@ -3061,7 +3061,7 @@ static ExitStatus trans_fop_wew_0c(DisasContext *ctx, uint32_t insn,
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned ra = extract32(insn, 21, 5);
-    return do_fop_wew(ctx, rt, ra, di->f_wew);
+    return do_fop_wew(ctx, rt, ra, di->f.wew);
 }
 
 static ExitStatus trans_fop_wew_0e(DisasContext *ctx, uint32_t insn,
@@ -3069,7 +3069,7 @@ static ExitStatus trans_fop_wew_0e(DisasContext *ctx, uint32_t insn,
 {
     unsigned rt = assemble_rt64(insn);
     unsigned ra = assemble_ra64(insn);
-    return do_fop_wew(ctx, rt, ra, di->f_wew);
+    return do_fop_wew(ctx, rt, ra, di->f.wew);
 }
 
 static ExitStatus trans_fop_ded(DisasContext *ctx, uint32_t insn,
@@ -3077,7 +3077,7 @@ static ExitStatus trans_fop_ded(DisasContext *ctx, uint32_t insn,
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned ra = extract32(insn, 21, 5);
-    return do_fop_ded(ctx, rt, ra, di->f_ded);
+    return do_fop_ded(ctx, rt, ra, di->f.ded);
 }
 
 static ExitStatus trans_fop_wed_0c(DisasContext *ctx, uint32_t insn,
@@ -3085,7 +3085,7 @@ static ExitStatus trans_fop_wed_0c(DisasContext *ctx, uint32_t insn,
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned ra = extract32(insn, 21, 5);
-    return do_fop_wed(ctx, rt, ra, di->f_wed);
+    return do_fop_wed(ctx, rt, ra, di->f.wed);
 }
 
 static ExitStatus trans_fop_wed_0e(DisasContext *ctx, uint32_t insn,
@@ -3093,7 +3093,7 @@ static ExitStatus trans_fop_wed_0e(DisasContext *ctx, uint32_t insn,
 {
     unsigned rt = assemble_rt64(insn);
     unsigned ra = extract32(insn, 21, 5);
-    return do_fop_wed(ctx, rt, ra, di->f_wed);
+    return do_fop_wed(ctx, rt, ra, di->f.wed);
 }
 
 static ExitStatus trans_fop_dew_0c(DisasContext *ctx, uint32_t insn,
@@ -3101,7 +3101,7 @@ static ExitStatus trans_fop_dew_0c(DisasContext *ctx, uint32_t insn,
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned ra = extract32(insn, 21, 5);
-    return do_fop_dew(ctx, rt, ra, di->f_dew);
+    return do_fop_dew(ctx, rt, ra, di->f.dew);
 }
 
 static ExitStatus trans_fop_dew_0e(DisasContext *ctx, uint32_t insn,
@@ -3109,7 +3109,7 @@ static ExitStatus trans_fop_dew_0e(DisasContext *ctx, uint32_t insn,
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned ra = assemble_ra64(insn);
-    return do_fop_dew(ctx, rt, ra, di->f_dew);
+    return do_fop_dew(ctx, rt, ra, di->f.dew);
 }
 
 static ExitStatus trans_fop_weww_0c(DisasContext *ctx, uint32_t insn,
@@ -3118,7 +3118,7 @@ static ExitStatus trans_fop_weww_0c(DisasContext *ctx, uint32_t insn,
     unsigned rt = extract32(insn, 0, 5);
     unsigned rb = extract32(insn, 16, 5);
     unsigned ra = extract32(insn, 21, 5);
-    return do_fop_weww(ctx, rt, ra, rb, di->f_weww);
+    return do_fop_weww(ctx, rt, ra, rb, di->f.weww);
 }
 
 static ExitStatus trans_fop_weww_0e(DisasContext *ctx, uint32_t insn,
@@ -3127,7 +3127,7 @@ static ExitStatus trans_fop_weww_0e(DisasContext *ctx, uint32_t insn,
     unsigned rt = assemble_rt64(insn);
     unsigned rb = assemble_rb64(insn);
     unsigned ra = assemble_ra64(insn);
-    return do_fop_weww(ctx, rt, ra, rb, di->f_weww);
+    return do_fop_weww(ctx, rt, ra, rb, di->f.weww);
 }
 
 static ExitStatus trans_fop_dedd(DisasContext *ctx, uint32_t insn,
@@ -3136,7 +3136,7 @@ static ExitStatus trans_fop_dedd(DisasContext *ctx, uint32_t insn,
     unsigned rt = extract32(insn, 0, 5);
     unsigned rb = extract32(insn, 16, 5);
     unsigned ra = extract32(insn, 21, 5);
-    return do_fop_dedd(ctx, rt, ra, rb, di->f_dedd);
+    return do_fop_dedd(ctx, rt, ra, rb, di->f.dedd);
 }
 
 static void gen_fcpy_s(TCGv_i32 dst, TCGv_env unused, TCGv_i32 src)
@@ -3340,13 +3340,13 @@ static ExitStatus trans_xmpyu(DisasContext *ctx, uint32_t insn,
     return nullify_end(ctx, NO_EXIT);
 }
 
-#define FOP_DED  trans_fop_ded, .f_ded
-#define FOP_DEDD trans_fop_dedd, .f_dedd
+#define FOP_DED  trans_fop_ded, .f.ded
+#define FOP_DEDD trans_fop_dedd, .f.dedd
 
-#define FOP_WEW  trans_fop_wew_0c, .f_wew
-#define FOP_DEW  trans_fop_dew_0c, .f_dew
-#define FOP_WED  trans_fop_wed_0c, .f_wed
-#define FOP_WEWW trans_fop_weww_0c, .f_weww
+#define FOP_WEW  trans_fop_wew_0c, .f.wew
+#define FOP_DEW  trans_fop_dew_0c, .f.dew
+#define FOP_WED  trans_fop_wed_0c, .f.wed
+#define FOP_WEWW trans_fop_weww_0c, .f.weww
 
 static const DisasInsn table_float_0c[] = {
     /* floating point class zero */
@@ -3425,10 +3425,10 @@ static const DisasInsn table_float_0c[] = {
 #undef FOP_DEW
 #undef FOP_WED
 #undef FOP_WEWW
-#define FOP_WEW  trans_fop_wew_0e, .f_wew
-#define FOP_DEW  trans_fop_dew_0e, .f_dew
-#define FOP_WED  trans_fop_wed_0e, .f_wed
-#define FOP_WEWW trans_fop_weww_0e, .f_weww
+#define FOP_WEW  trans_fop_wew_0e, .f.wew
+#define FOP_DEW  trans_fop_dew_0e, .f.dew
+#define FOP_WED  trans_fop_wed_0e, .f.wed
+#define FOP_WEWW trans_fop_weww_0e, .f.weww
 
 static const DisasInsn table_float_0e[] = {
     /* floating point class zero */
-- 
1.8.3.1
