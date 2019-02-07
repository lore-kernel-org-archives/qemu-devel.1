Received: from eggs.gnu.org ([209.51.188.92]:58238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griG5-0007Kj-2B
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griG0-0001S7-1g
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:17 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:37474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1griFz-0001Rf-PT
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:15 -0500
Received: by mail-wr1-x42a.google.com with SMTP id c8so4413056wrs.4
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 03:54:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Feb 2019 11:53:50 +0000
Message-Id: <20190207115400.647-10-richard.henderson@linaro.org>
In-Reply-To: <20190207115400.647-1-richard.henderson@linaro.org>
References: <20190207115400.647-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 09/19] target/hppa: Convert fp multiply-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, svens@stackframe.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c  | 69 +++++++++++++++++++++++-----------------
 target/hppa/insns.decode | 12 +++++++
 2 files changed, 52 insertions(+), 29 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 822d93fb23..2f4a50e113 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4255,37 +4255,54 @@ static inline int fmpyadd_s_reg(unsigned r)
     return (r & 16) * 2 + 16 + (r & 15);
 }
 
-static bool trans_fmpyadd(DisasContext *ctx, uint32_t insn, bool is_sub)
+static bool do_fmpyadd_s(DisasContext *ctx, arg_mpyadd *a, bool is_sub)
 {
-    unsigned tm = extract32(insn, 0, 5);
-    unsigned f = extract32(insn, 5, 1);
-    unsigned ra = extract32(insn, 6, 5);
-    unsigned ta = extract32(insn, 11, 5);
-    unsigned rm2 = extract32(insn, 16, 5);
-    unsigned rm1 = extract32(insn, 21, 5);
+    int tm = fmpyadd_s_reg(a->tm);
+    int ra = fmpyadd_s_reg(a->ra);
+    int ta = fmpyadd_s_reg(a->ta);
+    int rm2 = fmpyadd_s_reg(a->rm2);
+    int rm1 = fmpyadd_s_reg(a->rm1);
 
     nullify_over(ctx);
 
-    /* Independent multiply & add/sub, with undefined behaviour
-       if outputs overlap inputs.  */
-    if (f == 0) {
-        tm = fmpyadd_s_reg(tm);
-        ra = fmpyadd_s_reg(ra);
-        ta = fmpyadd_s_reg(ta);
-        rm2 = fmpyadd_s_reg(rm2);
-        rm1 = fmpyadd_s_reg(rm1);
-        do_fop_weww(ctx, tm, rm1, rm2, gen_helper_fmpy_s);
-        do_fop_weww(ctx, ta, ta, ra,
-                    is_sub ? gen_helper_fsub_s : gen_helper_fadd_s);
-    } else {
-        do_fop_dedd(ctx, tm, rm1, rm2, gen_helper_fmpy_d);
-        do_fop_dedd(ctx, ta, ta, ra,
-                    is_sub ? gen_helper_fsub_d : gen_helper_fadd_d);
-    }
+    do_fop_weww(ctx, tm, rm1, rm2, gen_helper_fmpy_s);
+    do_fop_weww(ctx, ta, ta, ra,
+                is_sub ? gen_helper_fsub_s : gen_helper_fadd_s);
 
     return nullify_end(ctx);
 }
 
+static bool trans_fmpyadd_f(DisasContext *ctx, arg_mpyadd *a)
+{
+    return do_fmpyadd_s(ctx, a, false);
+}
+
+static bool trans_fmpysub_f(DisasContext *ctx, arg_mpyadd *a)
+{
+    return do_fmpyadd_s(ctx, a, true);
+}
+
+static bool do_fmpyadd_d(DisasContext *ctx, arg_mpyadd *a, bool is_sub)
+{
+    nullify_over(ctx);
+
+    do_fop_dedd(ctx, a->tm, a->rm1, a->rm2, gen_helper_fmpy_d);
+    do_fop_dedd(ctx, a->ta, a->ta, a->ra,
+                is_sub ? gen_helper_fsub_d : gen_helper_fadd_d);
+
+    return nullify_end(ctx);
+}
+
+static bool trans_fmpyadd_d(DisasContext *ctx, arg_mpyadd *a)
+{
+    return do_fmpyadd_d(ctx, a, false);
+}
+
+static bool trans_fmpysub_d(DisasContext *ctx, arg_mpyadd *a)
+{
+    return do_fmpyadd_d(ctx, a, true);
+}
+
 static bool trans_fmpyfadd_s(DisasContext *ctx, uint32_t insn,
                              const DisasInsn *di)
 {
@@ -4376,9 +4393,6 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
 
     opc = extract32(insn, 26, 6);
     switch (opc) {
-    case 0x06:
-        trans_fmpyadd(ctx, insn, false);
-        return;
     case 0x08:
         trans_ldil(ctx, insn);
         return;
@@ -4456,9 +4470,6 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
     case 0x25:
         trans_subi(ctx, insn);
         return;
-    case 0x26:
-        trans_fmpyadd(ctx, insn, true);
-        return;
     case 0x27:
         trans_cmpb(ctx, insn, true, false, true);
         return;
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 38f5fb6be2..16a999b05f 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -153,3 +153,15 @@ lda             000011 ..... ..... .. . 1 -- 0110      ......   @ldim5 size=2
 lda             000011 ..... ..... .. . 0 -- 0110      ......   @ldstx size=2
 sta             000011 ..... ..... .. . 1 -- 1110      ......   @stim5 size=2
 stby            000011 b:5 r:5 sp:2 a:1 1 -- 1100 m:1   .....   disp=%im5_0
+
+####
+# Floating-point Multiply Add
+####
+
+&mpyadd         rm1 rm2 ta ra tm
+@mpyadd         ...... rm1:5 rm2:5 ta:5 ra:5 . tm:5     &mpyadd
+
+fmpyadd_f       000110 ..... ..... ..... ..... 0 .....  @mpyadd
+fmpyadd_d       000110 ..... ..... ..... ..... 1 .....  @mpyadd
+fmpysub_f       100110 ..... ..... ..... ..... 0 .....  @mpyadd
+fmpysub_d       100110 ..... ..... ..... ..... 1 .....  @mpyadd
-- 
2.17.2
