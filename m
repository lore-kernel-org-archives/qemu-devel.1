Received: from eggs.gnu.org ([209.51.188.92]:58430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griGN-0007eT-Jr
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griGI-0001Ye-Na
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:39 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1griGI-0001VH-85
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:34 -0500
Received: by mail-wm1-x343.google.com with SMTP id d15so5804719wmb.3
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 03:54:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Feb 2019 11:53:59 +0000
Message-Id: <20190207115400.647-19-richard.henderson@linaro.org>
In-Reply-To: <20190207115400.647-1-richard.henderson@linaro.org>
References: <20190207115400.647-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 18/19] target/hppa: Convert fp operate insns
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
 target/hppa/translate.c  | 791 ++++++++++++++++-----------------------
 target/hppa/insns.decode | 175 +++++++++
 2 files changed, 507 insertions(+), 459 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 3889851109..ecec5c42d1 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -348,21 +348,6 @@ static int expand_shl11(int val)
    to recognize unmasked interrupts.  */
 #define DISAS_IAQ_N_STALE_EXIT      DISAS_TARGET_2
 
-typedef struct DisasInsn {
-    uint32_t insn, mask;
-    bool (*trans)(DisasContext *ctx, uint32_t insn,
-                  const struct DisasInsn *f);
-    union {
-        void (*ttt)(TCGv_reg, TCGv_reg, TCGv_reg);
-        void (*weww)(TCGv_i32, TCGv_env, TCGv_i32, TCGv_i32);
-        void (*dedd)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64);
-        void (*wew)(TCGv_i32, TCGv_env, TCGv_i32);
-        void (*ded)(TCGv_i64, TCGv_env, TCGv_i64);
-        void (*wed)(TCGv_i32, TCGv_env, TCGv_i64);
-        void (*dew)(TCGv_i64, TCGv_env, TCGv_i32);
-    } f;
-} DisasInsn;
-
 /* global register indexes */
 static TCGv_reg cpu_gr[32];
 static TCGv_i64 cpu_sr[4];
@@ -855,34 +840,6 @@ static void gen_goto_tb(DisasContext *ctx, int which,
     }
 }
 
-static unsigned assemble_rt64(uint32_t insn)
-{
-    unsigned r1 = extract32(insn, 6, 1);
-    unsigned r0 = extract32(insn, 0, 5);
-    return r1 * 32 + r0;
-}
-
-static unsigned assemble_ra64(uint32_t insn)
-{
-    unsigned r1 = extract32(insn, 7, 1);
-    unsigned r0 = extract32(insn, 21, 5);
-    return r1 * 32 + r0;
-}
-
-static unsigned assemble_rb64(uint32_t insn)
-{
-    unsigned r1 = extract32(insn, 12, 1);
-    unsigned r0 = extract32(insn, 16, 5);
-    return r1 * 32 + r0;
-}
-
-static inline unsigned assemble_sr3(uint32_t insn)
-{
-    unsigned s2 = extract32(insn, 13, 1);
-    unsigned s0 = extract32(insn, 14, 2);
-    return s2 * 4 + s0;
-}
-
 /* The parisc documentation describes only the general interpretation of
    the conditions, without describing their exact implementation.  The
    interpretations do not stand up well when considering ADD,C and SUB,B.
@@ -1679,7 +1636,7 @@ static bool trans_fstd(DisasContext *ctx, arg_ldst *a)
                       a->disp, a->sp, a->m);
 }
 
-static void do_fop_wew(DisasContext *ctx, unsigned rt, unsigned ra,
+static bool do_fop_wew(DisasContext *ctx, unsigned rt, unsigned ra,
                        void (*func)(TCGv_i32, TCGv_env, TCGv_i32))
 {
     TCGv_i32 tmp;
@@ -1691,10 +1648,10 @@ static void do_fop_wew(DisasContext *ctx, unsigned rt, unsigned ra,
 
     save_frw_i32(rt, tmp);
     tcg_temp_free_i32(tmp);
-    nullify_end(ctx);
+    return nullify_end(ctx);
 }
 
-static void do_fop_wed(DisasContext *ctx, unsigned rt, unsigned ra,
+static bool do_fop_wed(DisasContext *ctx, unsigned rt, unsigned ra,
                        void (*func)(TCGv_i32, TCGv_env, TCGv_i64))
 {
     TCGv_i32 dst;
@@ -1709,10 +1666,10 @@ static void do_fop_wed(DisasContext *ctx, unsigned rt, unsigned ra,
     tcg_temp_free_i64(src);
     save_frw_i32(rt, dst);
     tcg_temp_free_i32(dst);
-    nullify_end(ctx);
+    return nullify_end(ctx);
 }
 
-static void do_fop_ded(DisasContext *ctx, unsigned rt, unsigned ra,
+static bool do_fop_ded(DisasContext *ctx, unsigned rt, unsigned ra,
                        void (*func)(TCGv_i64, TCGv_env, TCGv_i64))
 {
     TCGv_i64 tmp;
@@ -1724,10 +1681,10 @@ static void do_fop_ded(DisasContext *ctx, unsigned rt, unsigned ra,
 
     save_frd(rt, tmp);
     tcg_temp_free_i64(tmp);
-    nullify_end(ctx);
+    return nullify_end(ctx);
 }
 
-static void do_fop_dew(DisasContext *ctx, unsigned rt, unsigned ra,
+static bool do_fop_dew(DisasContext *ctx, unsigned rt, unsigned ra,
                        void (*func)(TCGv_i64, TCGv_env, TCGv_i32))
 {
     TCGv_i32 src;
@@ -1742,10 +1699,10 @@ static void do_fop_dew(DisasContext *ctx, unsigned rt, unsigned ra,
     tcg_temp_free_i32(src);
     save_frd(rt, dst);
     tcg_temp_free_i64(dst);
-    nullify_end(ctx);
+    return nullify_end(ctx);
 }
 
-static void do_fop_weww(DisasContext *ctx, unsigned rt,
+static bool do_fop_weww(DisasContext *ctx, unsigned rt,
                         unsigned ra, unsigned rb,
                         void (*func)(TCGv_i32, TCGv_env, TCGv_i32, TCGv_i32))
 {
@@ -1760,10 +1717,10 @@ static void do_fop_weww(DisasContext *ctx, unsigned rt,
     tcg_temp_free_i32(b);
     save_frw_i32(rt, a);
     tcg_temp_free_i32(a);
-    nullify_end(ctx);
+    return nullify_end(ctx);
 }
 
-static void do_fop_dedd(DisasContext *ctx, unsigned rt,
+static bool do_fop_dedd(DisasContext *ctx, unsigned rt,
                         unsigned ra, unsigned rb,
                         void (*func)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64))
 {
@@ -1778,7 +1735,7 @@ static void do_fop_dedd(DisasContext *ctx, unsigned rt,
     tcg_temp_free_i64(b);
     save_frd(rt, a);
     tcg_temp_free_i64(a);
-    nullify_end(ctx);
+    return nullify_end(ctx);
 }
 
 /* Emit an unconditional branch to a direct target, which may or may not
@@ -3519,150 +3476,258 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
 #endif
 }
 
-static bool trans_fop_wew_0c(DisasContext *ctx, uint32_t insn,
-                             const DisasInsn *di)
-{
-    unsigned rt = extract32(insn, 0, 5);
-    unsigned ra = extract32(insn, 21, 5);
-    do_fop_wew(ctx, rt, ra, di->f.wew);
-    return true;
-}
+/*
+ * Float class 0
+ */
 
-static bool trans_fop_wew_0e(DisasContext *ctx, uint32_t insn,
-                             const DisasInsn *di)
-{
-    unsigned rt = assemble_rt64(insn);
-    unsigned ra = assemble_ra64(insn);
-    do_fop_wew(ctx, rt, ra, di->f.wew);
-    return true;
-}
-
-static bool trans_fop_ded(DisasContext *ctx, uint32_t insn,
-                          const DisasInsn *di)
-{
-    unsigned rt = extract32(insn, 0, 5);
-    unsigned ra = extract32(insn, 21, 5);
-    do_fop_ded(ctx, rt, ra, di->f.ded);
-    return true;
-}
-
-static bool trans_fop_wed_0c(DisasContext *ctx, uint32_t insn,
-                             const DisasInsn *di)
-{
-    unsigned rt = extract32(insn, 0, 5);
-    unsigned ra = extract32(insn, 21, 5);
-    do_fop_wed(ctx, rt, ra, di->f.wed);
-    return true;
-}
-
-static bool trans_fop_wed_0e(DisasContext *ctx, uint32_t insn,
-                             const DisasInsn *di)
-{
-    unsigned rt = assemble_rt64(insn);
-    unsigned ra = extract32(insn, 21, 5);
-    do_fop_wed(ctx, rt, ra, di->f.wed);
-    return true;
-}
-
-static bool trans_fop_dew_0c(DisasContext *ctx, uint32_t insn,
-                             const DisasInsn *di)
-{
-    unsigned rt = extract32(insn, 0, 5);
-    unsigned ra = extract32(insn, 21, 5);
-    do_fop_dew(ctx, rt, ra, di->f.dew);
-    return true;
-}
-
-static bool trans_fop_dew_0e(DisasContext *ctx, uint32_t insn,
-                             const DisasInsn *di)
-{
-    unsigned rt = extract32(insn, 0, 5);
-    unsigned ra = assemble_ra64(insn);
-    do_fop_dew(ctx, rt, ra, di->f.dew);
-    return true;
-}
-
-static bool trans_fop_weww_0c(DisasContext *ctx, uint32_t insn,
-                              const DisasInsn *di)
-{
-    unsigned rt = extract32(insn, 0, 5);
-    unsigned rb = extract32(insn, 16, 5);
-    unsigned ra = extract32(insn, 21, 5);
-    do_fop_weww(ctx, rt, ra, rb, di->f.weww);
-    return true;
-}
-
-static bool trans_fop_weww_0e(DisasContext *ctx, uint32_t insn,
-                              const DisasInsn *di)
-{
-    unsigned rt = assemble_rt64(insn);
-    unsigned rb = assemble_rb64(insn);
-    unsigned ra = assemble_ra64(insn);
-    do_fop_weww(ctx, rt, ra, rb, di->f.weww);
-    return true;
-}
-
-static bool trans_fop_dedd(DisasContext *ctx, uint32_t insn,
-                           const DisasInsn *di)
-{
-    unsigned rt = extract32(insn, 0, 5);
-    unsigned rb = extract32(insn, 16, 5);
-    unsigned ra = extract32(insn, 21, 5);
-    do_fop_dedd(ctx, rt, ra, rb, di->f.dedd);
-    return true;
-}
-
-static void gen_fcpy_s(TCGv_i32 dst, TCGv_env unused, TCGv_i32 src)
+static void gen_fcpy_f(TCGv_i32 dst, TCGv_env unused, TCGv_i32 src)
 {
     tcg_gen_mov_i32(dst, src);
 }
 
+static bool trans_fcpy_f(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_wew(ctx, a->t, a->r, gen_fcpy_f);
+}
+
 static void gen_fcpy_d(TCGv_i64 dst, TCGv_env unused, TCGv_i64 src)
 {
     tcg_gen_mov_i64(dst, src);
 }
 
-static void gen_fabs_s(TCGv_i32 dst, TCGv_env unused, TCGv_i32 src)
+static bool trans_fcpy_d(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_ded(ctx, a->t, a->r, gen_fcpy_d);
+}
+
+static void gen_fabs_f(TCGv_i32 dst, TCGv_env unused, TCGv_i32 src)
 {
     tcg_gen_andi_i32(dst, src, INT32_MAX);
 }
 
+static bool trans_fabs_f(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_wew(ctx, a->t, a->r, gen_fabs_f);
+}
+
 static void gen_fabs_d(TCGv_i64 dst, TCGv_env unused, TCGv_i64 src)
 {
     tcg_gen_andi_i64(dst, src, INT64_MAX);
 }
 
-static void gen_fneg_s(TCGv_i32 dst, TCGv_env unused, TCGv_i32 src)
+static bool trans_fabs_d(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_ded(ctx, a->t, a->r, gen_fabs_d);
+}
+
+static bool trans_fsqrt_f(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_wew(ctx, a->t, a->r, gen_helper_fsqrt_s);
+}
+
+static bool trans_fsqrt_d(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_ded(ctx, a->t, a->r, gen_helper_fsqrt_d);
+}
+
+static bool trans_frnd_f(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_wew(ctx, a->t, a->r, gen_helper_frnd_s);
+}
+
+static bool trans_frnd_d(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_ded(ctx, a->t, a->r, gen_helper_frnd_d);
+}
+
+static void gen_fneg_f(TCGv_i32 dst, TCGv_env unused, TCGv_i32 src)
 {
     tcg_gen_xori_i32(dst, src, INT32_MIN);
 }
 
+static bool trans_fneg_f(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_wew(ctx, a->t, a->r, gen_fneg_f);
+}
+
 static void gen_fneg_d(TCGv_i64 dst, TCGv_env unused, TCGv_i64 src)
 {
     tcg_gen_xori_i64(dst, src, INT64_MIN);
 }
 
-static void gen_fnegabs_s(TCGv_i32 dst, TCGv_env unused, TCGv_i32 src)
+static bool trans_fneg_d(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_ded(ctx, a->t, a->r, gen_fneg_d);
+}
+
+static void gen_fnegabs_f(TCGv_i32 dst, TCGv_env unused, TCGv_i32 src)
 {
     tcg_gen_ori_i32(dst, src, INT32_MIN);
 }
 
+static bool trans_fnegabs_f(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_wew(ctx, a->t, a->r, gen_fnegabs_f);
+}
+
 static void gen_fnegabs_d(TCGv_i64 dst, TCGv_env unused, TCGv_i64 src)
 {
     tcg_gen_ori_i64(dst, src, INT64_MIN);
 }
 
-static void do_fcmp_s(DisasContext *ctx, unsigned ra, unsigned rb,
-                      unsigned y, unsigned c)
+static bool trans_fnegabs_d(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_ded(ctx, a->t, a->r, gen_fnegabs_d);
+}
+
+/*
+ * Float class 1
+ */
+
+static bool trans_fcnv_d_f(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_wed(ctx, a->t, a->r, gen_helper_fcnv_d_s);
+}
+
+static bool trans_fcnv_f_d(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_dew(ctx, a->t, a->r, gen_helper_fcnv_s_d);
+}
+
+static bool trans_fcnv_w_f(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_wew(ctx, a->t, a->r, gen_helper_fcnv_w_s);
+}
+
+static bool trans_fcnv_q_f(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_wed(ctx, a->t, a->r, gen_helper_fcnv_dw_s);
+}
+
+static bool trans_fcnv_w_d(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_dew(ctx, a->t, a->r, gen_helper_fcnv_w_d);
+}
+
+static bool trans_fcnv_q_d(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_ded(ctx, a->t, a->r, gen_helper_fcnv_dw_d);
+}
+
+static bool trans_fcnv_f_w(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_wew(ctx, a->t, a->r, gen_helper_fcnv_s_w);
+}
+
+static bool trans_fcnv_d_w(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_wed(ctx, a->t, a->r, gen_helper_fcnv_d_w);
+}
+
+static bool trans_fcnv_f_q(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_dew(ctx, a->t, a->r, gen_helper_fcnv_s_dw);
+}
+
+static bool trans_fcnv_d_q(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_ded(ctx, a->t, a->r, gen_helper_fcnv_d_dw);
+}
+
+static bool trans_fcnv_t_f_w(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_wew(ctx, a->t, a->r, gen_helper_fcnv_t_s_w);
+}
+
+static bool trans_fcnv_t_d_w(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_wed(ctx, a->t, a->r, gen_helper_fcnv_t_d_w);
+}
+
+static bool trans_fcnv_t_f_q(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_dew(ctx, a->t, a->r, gen_helper_fcnv_t_s_dw);
+}
+
+static bool trans_fcnv_t_d_q(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_ded(ctx, a->t, a->r, gen_helper_fcnv_t_d_dw);
+}
+
+static bool trans_fcnv_uw_f(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_wew(ctx, a->t, a->r, gen_helper_fcnv_uw_s);
+}
+
+static bool trans_fcnv_uq_f(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_wed(ctx, a->t, a->r, gen_helper_fcnv_udw_s);
+}
+
+static bool trans_fcnv_uw_d(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_dew(ctx, a->t, a->r, gen_helper_fcnv_uw_d);
+}
+
+static bool trans_fcnv_uq_d(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_ded(ctx, a->t, a->r, gen_helper_fcnv_udw_d);
+}
+
+static bool trans_fcnv_f_uw(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_wew(ctx, a->t, a->r, gen_helper_fcnv_s_uw);
+}
+
+static bool trans_fcnv_d_uw(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_wed(ctx, a->t, a->r, gen_helper_fcnv_d_uw);
+}
+
+static bool trans_fcnv_f_uq(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_dew(ctx, a->t, a->r, gen_helper_fcnv_s_udw);
+}
+
+static bool trans_fcnv_d_uq(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_ded(ctx, a->t, a->r, gen_helper_fcnv_d_udw);
+}
+
+static bool trans_fcnv_t_f_uw(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_wew(ctx, a->t, a->r, gen_helper_fcnv_t_s_uw);
+}
+
+static bool trans_fcnv_t_d_uw(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_wed(ctx, a->t, a->r, gen_helper_fcnv_t_d_uw);
+}
+
+static bool trans_fcnv_t_f_uq(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_dew(ctx, a->t, a->r, gen_helper_fcnv_t_s_udw);
+}
+
+static bool trans_fcnv_t_d_uq(DisasContext *ctx, arg_fclass01 *a)
+{
+    return do_fop_ded(ctx, a->t, a->r, gen_helper_fcnv_t_d_udw);
+}
+
+/*
+ * Float class 2
+ */
+
+static bool trans_fcmp_f(DisasContext *ctx, arg_fclass2 *a)
 {
     TCGv_i32 ta, tb, tc, ty;
 
     nullify_over(ctx);
 
-    ta = load_frw0_i32(ra);
-    tb = load_frw0_i32(rb);
-    ty = tcg_const_i32(y);
-    tc = tcg_const_i32(c);
+    ta = load_frw0_i32(a->r1);
+    tb = load_frw0_i32(a->r2);
+    ty = tcg_const_i32(a->y);
+    tc = tcg_const_i32(a->c);
 
     gen_helper_fcmp_s(cpu_env, ta, tb, ty, tc);
 
@@ -3671,46 +3736,20 @@ static void do_fcmp_s(DisasContext *ctx, unsigned ra, unsigned rb,
     tcg_temp_free_i32(ty);
     tcg_temp_free_i32(tc);
 
-    nullify_end(ctx);
+    return nullify_end(ctx);
 }
 
-static bool trans_fcmp_s_0c(DisasContext *ctx, uint32_t insn,
-                            const DisasInsn *di)
+static bool trans_fcmp_d(DisasContext *ctx, arg_fclass2 *a)
 {
-    unsigned c = extract32(insn, 0, 5);
-    unsigned y = extract32(insn, 13, 3);
-    unsigned rb = extract32(insn, 16, 5);
-    unsigned ra = extract32(insn, 21, 5);
-    do_fcmp_s(ctx, ra, rb, y, c);
-    return true;
-}
-
-static bool trans_fcmp_s_0e(DisasContext *ctx, uint32_t insn,
-                            const DisasInsn *di)
-{
-    unsigned c = extract32(insn, 0, 5);
-    unsigned y = extract32(insn, 13, 3);
-    unsigned rb = assemble_rb64(insn);
-    unsigned ra = assemble_ra64(insn);
-    do_fcmp_s(ctx, ra, rb, y, c);
-    return true;
-}
-
-static bool trans_fcmp_d(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
-{
-    unsigned c = extract32(insn, 0, 5);
-    unsigned y = extract32(insn, 13, 3);
-    unsigned rb = extract32(insn, 16, 5);
-    unsigned ra = extract32(insn, 21, 5);
     TCGv_i64 ta, tb;
     TCGv_i32 tc, ty;
 
     nullify_over(ctx);
 
-    ta = load_frd0(ra);
-    tb = load_frd0(rb);
-    ty = tcg_const_i32(y);
-    tc = tcg_const_i32(c);
+    ta = load_frd0(a->r1);
+    tb = load_frd0(a->r2);
+    ty = tcg_const_i32(a->y);
+    tc = tcg_const_i32(a->c);
 
     gen_helper_fcmp_d(cpu_env, ta, tb, ty, tc);
 
@@ -3722,263 +3761,129 @@ static bool trans_fcmp_d(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     return nullify_end(ctx);
 }
 
-static bool trans_ftest_t(DisasContext *ctx, uint32_t insn,
-                          const DisasInsn *di)
+static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
 {
-    unsigned y = extract32(insn, 13, 3);
-    unsigned cbit = (y ^ 1) - 1;
     TCGv_reg t;
 
     nullify_over(ctx);
 
-    t = tcg_temp_new();
-    tcg_gen_ld32u_reg(t, cpu_env, offsetof(CPUHPPAState, fr0_shadow));
-    tcg_gen_extract_reg(t, t, 21 - cbit, 1);
-    ctx->null_cond = cond_make_0(TCG_COND_NE, t);
-    tcg_temp_free(t);
-
-    return nullify_end(ctx);
-}
-
-static bool trans_ftest_q(DisasContext *ctx, uint32_t insn,
-                          const DisasInsn *di)
-{
-    unsigned c = extract32(insn, 0, 5);
-    int mask;
-    bool inv = false;
-    TCGv_reg t;
-
-    nullify_over(ctx);
-
-    t = tcg_temp_new();
+    t = get_temp(ctx);
     tcg_gen_ld32u_reg(t, cpu_env, offsetof(CPUHPPAState, fr0_shadow));
 
-    switch (c) {
-    case 0: /* simple */
-        tcg_gen_andi_reg(t, t, 0x4000000);
-        ctx->null_cond = cond_make_0(TCG_COND_NE, t);
-        goto done;
-    case 2: /* rej */
-        inv = true;
-        /* fallthru */
-    case 1: /* acc */
-        mask = 0x43ff800;
-        break;
-    case 6: /* rej8 */
-        inv = true;
-        /* fallthru */
-    case 5: /* acc8 */
-        mask = 0x43f8000;
-        break;
-    case 9: /* acc6 */
-        mask = 0x43e0000;
-        break;
-    case 13: /* acc4 */
-        mask = 0x4380000;
-        break;
-    case 17: /* acc2 */
-        mask = 0x4200000;
-        break;
-    default:
-        return gen_illegal(ctx);
-    }
-    if (inv) {
-        TCGv_reg c = load_const(ctx, mask);
-        tcg_gen_or_reg(t, t, c);
-        ctx->null_cond = cond_make(TCG_COND_EQ, t, c);
+    if (a->y == 1) {
+        int mask;
+        bool inv = false;
+
+        switch (a->c) {
+        case 0: /* simple */
+            tcg_gen_andi_reg(t, t, 0x4000000);
+            ctx->null_cond = cond_make_0(TCG_COND_NE, t);
+            goto done;
+        case 2: /* rej */
+            inv = true;
+            /* fallthru */
+        case 1: /* acc */
+            mask = 0x43ff800;
+            break;
+        case 6: /* rej8 */
+            inv = true;
+            /* fallthru */
+        case 5: /* acc8 */
+            mask = 0x43f8000;
+            break;
+        case 9: /* acc6 */
+            mask = 0x43e0000;
+            break;
+        case 13: /* acc4 */
+            mask = 0x4380000;
+            break;
+        case 17: /* acc2 */
+            mask = 0x4200000;
+            break;
+        default:
+            gen_illegal(ctx);
+            return true;
+        }
+        if (inv) {
+            TCGv_reg c = load_const(ctx, mask);
+            tcg_gen_or_reg(t, t, c);
+            ctx->null_cond = cond_make(TCG_COND_EQ, t, c);
+        } else {
+            tcg_gen_andi_reg(t, t, mask);
+            ctx->null_cond = cond_make_0(TCG_COND_EQ, t);
+        }
     } else {
-        tcg_gen_andi_reg(t, t, mask);
-        ctx->null_cond = cond_make_0(TCG_COND_EQ, t);
+        unsigned cbit = (a->y ^ 1) - 1;
+
+        tcg_gen_extract_reg(t, t, 21 - cbit, 1);
+        ctx->null_cond = cond_make_0(TCG_COND_NE, t);
+        tcg_temp_free(t);
     }
+
  done:
     return nullify_end(ctx);
 }
 
-static bool trans_xmpyu(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+/*
+ * Float class 2
+ */
+
+static bool trans_fadd_f(DisasContext *ctx, arg_fclass3 *a)
 {
-    unsigned rt = extract32(insn, 0, 5);
-    unsigned rb = assemble_rb64(insn);
-    unsigned ra = assemble_ra64(insn);
-    TCGv_i64 a, b;
+    return do_fop_weww(ctx, a->t, a->r1, a->r2, gen_helper_fadd_s);
+}
+
+static bool trans_fadd_d(DisasContext *ctx, arg_fclass3 *a)
+{
+    return do_fop_dedd(ctx, a->t, a->r1, a->r2, gen_helper_fadd_d);
+}
+
+static bool trans_fsub_f(DisasContext *ctx, arg_fclass3 *a)
+{
+    return do_fop_weww(ctx, a->t, a->r1, a->r2, gen_helper_fsub_s);
+}
+
+static bool trans_fsub_d(DisasContext *ctx, arg_fclass3 *a)
+{
+    return do_fop_dedd(ctx, a->t, a->r1, a->r2, gen_helper_fsub_d);
+}
+
+static bool trans_fmpy_f(DisasContext *ctx, arg_fclass3 *a)
+{
+    return do_fop_weww(ctx, a->t, a->r1, a->r2, gen_helper_fmpy_s);
+}
+
+static bool trans_fmpy_d(DisasContext *ctx, arg_fclass3 *a)
+{
+    return do_fop_dedd(ctx, a->t, a->r1, a->r2, gen_helper_fmpy_d);
+}
+
+static bool trans_fdiv_f(DisasContext *ctx, arg_fclass3 *a)
+{
+    return do_fop_weww(ctx, a->t, a->r1, a->r2, gen_helper_fdiv_s);
+}
+
+static bool trans_fdiv_d(DisasContext *ctx, arg_fclass3 *a)
+{
+    return do_fop_dedd(ctx, a->t, a->r1, a->r2, gen_helper_fdiv_d);
+}
+
+static bool trans_xmpyu(DisasContext *ctx, arg_xmpyu *a)
+{
+    TCGv_i64 x, y;
 
     nullify_over(ctx);
 
-    a = load_frw0_i64(ra);
-    b = load_frw0_i64(rb);
-    tcg_gen_mul_i64(a, a, b);
-    save_frd(rt, a);
-    tcg_temp_free_i64(a);
-    tcg_temp_free_i64(b);
+    x = load_frw0_i64(a->r1);
+    y = load_frw0_i64(a->r2);
+    tcg_gen_mul_i64(x, x, y);
+    save_frd(a->t, x);
+    tcg_temp_free_i64(x);
+    tcg_temp_free_i64(y);
 
     return nullify_end(ctx);
 }
 
-#define FOP_DED  trans_fop_ded, .f.ded
-#define FOP_DEDD trans_fop_dedd, .f.dedd
-
-#define FOP_WEW  trans_fop_wew_0c, .f.wew
-#define FOP_DEW  trans_fop_dew_0c, .f.dew
-#define FOP_WED  trans_fop_wed_0c, .f.wed
-#define FOP_WEWW trans_fop_weww_0c, .f.weww
-
-static const DisasInsn table_float_0c[] = {
-    /* floating point class zero */
-    { 0x30004000, 0xfc1fffe0, FOP_WEW = gen_fcpy_s },
-    { 0x30006000, 0xfc1fffe0, FOP_WEW = gen_fabs_s },
-    { 0x30008000, 0xfc1fffe0, FOP_WEW = gen_helper_fsqrt_s },
-    { 0x3000a000, 0xfc1fffe0, FOP_WEW = gen_helper_frnd_s },
-    { 0x3000c000, 0xfc1fffe0, FOP_WEW = gen_fneg_s },
-    { 0x3000e000, 0xfc1fffe0, FOP_WEW = gen_fnegabs_s },
-
-    { 0x30004800, 0xfc1fffe0, FOP_DED = gen_fcpy_d },
-    { 0x30006800, 0xfc1fffe0, FOP_DED = gen_fabs_d },
-    { 0x30008800, 0xfc1fffe0, FOP_DED = gen_helper_fsqrt_d },
-    { 0x3000a800, 0xfc1fffe0, FOP_DED = gen_helper_frnd_d },
-    { 0x3000c800, 0xfc1fffe0, FOP_DED = gen_fneg_d },
-    { 0x3000e800, 0xfc1fffe0, FOP_DED = gen_fnegabs_d },
-
-    /* floating point class three */
-    { 0x30000600, 0xfc00ffe0, FOP_WEWW = gen_helper_fadd_s },
-    { 0x30002600, 0xfc00ffe0, FOP_WEWW = gen_helper_fsub_s },
-    { 0x30004600, 0xfc00ffe0, FOP_WEWW = gen_helper_fmpy_s },
-    { 0x30006600, 0xfc00ffe0, FOP_WEWW = gen_helper_fdiv_s },
-
-    { 0x30000e00, 0xfc00ffe0, FOP_DEDD = gen_helper_fadd_d },
-    { 0x30002e00, 0xfc00ffe0, FOP_DEDD = gen_helper_fsub_d },
-    { 0x30004e00, 0xfc00ffe0, FOP_DEDD = gen_helper_fmpy_d },
-    { 0x30006e00, 0xfc00ffe0, FOP_DEDD = gen_helper_fdiv_d },
-
-    /* floating point class one */
-    /* float/float */
-    { 0x30000a00, 0xfc1fffe0, FOP_WED = gen_helper_fcnv_d_s },
-    { 0x30002200, 0xfc1fffe0, FOP_DEW = gen_helper_fcnv_s_d },
-    /* int/float */
-    { 0x30008200, 0xfc1fffe0, FOP_WEW = gen_helper_fcnv_w_s },
-    { 0x30008a00, 0xfc1fffe0, FOP_WED = gen_helper_fcnv_dw_s },
-    { 0x3000a200, 0xfc1fffe0, FOP_DEW = gen_helper_fcnv_w_d },
-    { 0x3000aa00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_dw_d },
-    /* float/int */
-    { 0x30010200, 0xfc1fffe0, FOP_WEW = gen_helper_fcnv_s_w },
-    { 0x30010a00, 0xfc1fffe0, FOP_WED = gen_helper_fcnv_d_w },
-    { 0x30012200, 0xfc1fffe0, FOP_DEW = gen_helper_fcnv_s_dw },
-    { 0x30012a00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_d_dw },
-    /* float/int truncate */
-    { 0x30018200, 0xfc1fffe0, FOP_WEW = gen_helper_fcnv_t_s_w },
-    { 0x30018a00, 0xfc1fffe0, FOP_WED = gen_helper_fcnv_t_d_w },
-    { 0x3001a200, 0xfc1fffe0, FOP_DEW = gen_helper_fcnv_t_s_dw },
-    { 0x3001aa00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_t_d_dw },
-    /* uint/float */
-    { 0x30028200, 0xfc1fffe0, FOP_WEW = gen_helper_fcnv_uw_s },
-    { 0x30028a00, 0xfc1fffe0, FOP_WED = gen_helper_fcnv_udw_s },
-    { 0x3002a200, 0xfc1fffe0, FOP_DEW = gen_helper_fcnv_uw_d },
-    { 0x3002aa00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_udw_d },
-    /* float/uint */
-    { 0x30030200, 0xfc1fffe0, FOP_WEW = gen_helper_fcnv_s_uw },
-    { 0x30030a00, 0xfc1fffe0, FOP_WED = gen_helper_fcnv_d_uw },
-    { 0x30032200, 0xfc1fffe0, FOP_DEW = gen_helper_fcnv_s_udw },
-    { 0x30032a00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_d_udw },
-    /* float/uint truncate */
-    { 0x30038200, 0xfc1fffe0, FOP_WEW = gen_helper_fcnv_t_s_uw },
-    { 0x30038a00, 0xfc1fffe0, FOP_WED = gen_helper_fcnv_t_d_uw },
-    { 0x3003a200, 0xfc1fffe0, FOP_DEW = gen_helper_fcnv_t_s_udw },
-    { 0x3003aa00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_t_d_udw },
-
-    /* floating point class two */
-    { 0x30000400, 0xfc001fe0, trans_fcmp_s_0c },
-    { 0x30000c00, 0xfc001fe0, trans_fcmp_d },
-    { 0x30002420, 0xffffffe0, trans_ftest_q },
-    { 0x30000420, 0xffff1fff, trans_ftest_t },
-
-    /* FID.  Note that ra == rt == 0, which via fcpy puts 0 into fr0.
-       This is machine/revision == 0, which is reserved for simulator.  */
-    { 0x30000000, 0xffffffff, FOP_WEW = gen_fcpy_s },
-};
-
-#undef FOP_WEW
-#undef FOP_DEW
-#undef FOP_WED
-#undef FOP_WEWW
-#define FOP_WEW  trans_fop_wew_0e, .f.wew
-#define FOP_DEW  trans_fop_dew_0e, .f.dew
-#define FOP_WED  trans_fop_wed_0e, .f.wed
-#define FOP_WEWW trans_fop_weww_0e, .f.weww
-
-static const DisasInsn table_float_0e[] = {
-    /* floating point class zero */
-    { 0x38004000, 0xfc1fff20, FOP_WEW = gen_fcpy_s },
-    { 0x38006000, 0xfc1fff20, FOP_WEW = gen_fabs_s },
-    { 0x38008000, 0xfc1fff20, FOP_WEW = gen_helper_fsqrt_s },
-    { 0x3800a000, 0xfc1fff20, FOP_WEW = gen_helper_frnd_s },
-    { 0x3800c000, 0xfc1fff20, FOP_WEW = gen_fneg_s },
-    { 0x3800e000, 0xfc1fff20, FOP_WEW = gen_fnegabs_s },
-
-    { 0x38004800, 0xfc1fffe0, FOP_DED = gen_fcpy_d },
-    { 0x38006800, 0xfc1fffe0, FOP_DED = gen_fabs_d },
-    { 0x38008800, 0xfc1fffe0, FOP_DED = gen_helper_fsqrt_d },
-    { 0x3800a800, 0xfc1fffe0, FOP_DED = gen_helper_frnd_d },
-    { 0x3800c800, 0xfc1fffe0, FOP_DED = gen_fneg_d },
-    { 0x3800e800, 0xfc1fffe0, FOP_DED = gen_fnegabs_d },
-
-    /* floating point class three */
-    { 0x38000600, 0xfc00ef20, FOP_WEWW = gen_helper_fadd_s },
-    { 0x38002600, 0xfc00ef20, FOP_WEWW = gen_helper_fsub_s },
-    { 0x38004600, 0xfc00ef20, FOP_WEWW = gen_helper_fmpy_s },
-    { 0x38006600, 0xfc00ef20, FOP_WEWW = gen_helper_fdiv_s },
-
-    { 0x38000e00, 0xfc00ffe0, FOP_DEDD = gen_helper_fadd_d },
-    { 0x38002e00, 0xfc00ffe0, FOP_DEDD = gen_helper_fsub_d },
-    { 0x38004e00, 0xfc00ffe0, FOP_DEDD = gen_helper_fmpy_d },
-    { 0x38006e00, 0xfc00ffe0, FOP_DEDD = gen_helper_fdiv_d },
-
-    { 0x38004700, 0xfc00ef60, trans_xmpyu },
-
-    /* floating point class one */
-    /* float/float */
-    { 0x38000a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_d_s },
-    { 0x38002200, 0xfc1fff60, FOP_DEW = gen_helper_fcnv_s_d },
-    /* int/float */
-    { 0x38008200, 0xfc1ffe20, FOP_WEW = gen_helper_fcnv_w_s },
-    { 0x38008a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_dw_s },
-    { 0x3800a200, 0xfc1fff60, FOP_DEW = gen_helper_fcnv_w_d },
-    { 0x3800aa00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_dw_d },
-    /* float/int */
-    { 0x38010200, 0xfc1ffe20, FOP_WEW = gen_helper_fcnv_s_w },
-    { 0x38010a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_d_w },
-    { 0x38012200, 0xfc1fff60, FOP_DEW = gen_helper_fcnv_s_dw },
-    { 0x38012a00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_d_dw },
-    /* float/int truncate */
-    { 0x38018200, 0xfc1ffe20, FOP_WEW = gen_helper_fcnv_t_s_w },
-    { 0x38018a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_t_d_w },
-    { 0x3801a200, 0xfc1fff60, FOP_DEW = gen_helper_fcnv_t_s_dw },
-    { 0x3801aa00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_t_d_dw },
-    /* uint/float */
-    { 0x38028200, 0xfc1ffe20, FOP_WEW = gen_helper_fcnv_uw_s },
-    { 0x38028a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_udw_s },
-    { 0x3802a200, 0xfc1fff60, FOP_DEW = gen_helper_fcnv_uw_d },
-    { 0x3802aa00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_udw_d },
-    /* float/uint */
-    { 0x38030200, 0xfc1ffe20, FOP_WEW = gen_helper_fcnv_s_uw },
-    { 0x38030a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_d_uw },
-    { 0x38032200, 0xfc1fff60, FOP_DEW = gen_helper_fcnv_s_udw },
-    { 0x38032a00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_d_udw },
-    /* float/uint truncate */
-    { 0x38038200, 0xfc1ffe20, FOP_WEW = gen_helper_fcnv_t_s_uw },
-    { 0x38038a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_t_d_uw },
-    { 0x3803a200, 0xfc1fff60, FOP_DEW = gen_helper_fcnv_t_s_udw },
-    { 0x3803aa00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_t_d_udw },
-
-    /* floating point class two */
-    { 0x38000400, 0xfc000f60, trans_fcmp_s_0e },
-    { 0x38000c00, 0xfc001fe0, trans_fcmp_d },
-};
-
-#undef FOP_WEW
-#undef FOP_DEW
-#undef FOP_WED
-#undef FOP_WEWW
-#undef FOP_DED
-#undef FOP_DEDD
-
 /* Convert the fmpyadd single-precision register encodings to standard.  */
 static inline int fmpyadd_s_reg(unsigned r)
 {
@@ -4077,43 +3982,11 @@ static bool trans_fmpyfadd_d(DisasContext *ctx, arg_fmpyfadd_d *a)
     return nullify_end(ctx);
 }
 
-static void translate_table_int(DisasContext *ctx, uint32_t insn,
-                                const DisasInsn table[], size_t n)
-{
-    size_t i;
-    for (i = 0; i < n; ++i) {
-        if ((insn & table[i].mask) == table[i].insn) {
-            table[i].trans(ctx, insn, &table[i]);
-            return;
-        }
-    }
-    qemu_log_mask(LOG_UNIMP, "UNIMP insn %08x @ " TARGET_FMT_lx "\n",
-                  insn, ctx->base.pc_next);
-    gen_illegal(ctx);
-}
-
-#define translate_table(ctx, insn, table) \
-    translate_table_int(ctx, insn, table, ARRAY_SIZE(table))
-
 static void translate_one(DisasContext *ctx, uint32_t insn)
 {
-    uint32_t opc;
-
-    /* Transition to the auto-generated decoder.  */
-    if (decode(ctx, insn)) {
-        return;
+    if (!decode(ctx, insn)) {
+        gen_illegal(ctx);
     }
-
-    opc = extract32(insn, 26, 6);
-    switch (opc) {
-    case 0x0C:
-        translate_table(ctx, insn, table_float_0c);
-        return;
-    case 0x0E:
-        translate_table(ctx, insn, table_float_0e);
-        return;
-    }
-    gen_illegal(ctx);
 }
 
 static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 1c8102f76e..e1d02d9280 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -350,3 +350,178 @@ bve             111010 b:5   00000 111 10000000000 n:1 -        l=2
 fmpyfadd_f      101110 ..... ..... ... . 0 ... . . neg:1 ..... \
                 rm1=%ra64 rm2=%rb64 ra3=%rc64 t=%rt64
 fmpyfadd_d      101110 rm1:5 rm2:5 ... 0 1 ..0 0 0 neg:1 t:5    ra3=%rc32
+
+####
+# FP operations
+####
+
+&fclass01       r t
+&fclass2        r1 r2 c y
+&fclass3        r1 r2 t
+
+@f0c_0          ...... r:5  00000 ..... 00 000 0 t:5    &fclass01
+@f0c_1          ...... r:5  000.. ..... 01 000 0 t:5    &fclass01
+@f0c_2          ...... r1:5 r2:5 y:3 .. 10 000 . c:5    &fclass2
+@f0c_3          ...... r1:5 r2:5  ..... 11 000 0 t:5    &fclass3
+
+@f0e_f_0        ...... ..... 00000 ... 0 0 000 .. 0 .....  \
+                &fclass01 r=%ra64 t=%rt64
+@f0e_d_0        ...... r:5   00000 ... 0 1 000 00 0 t:5    &fclass01
+
+@f0e_ff_1       ...... ..... 000  ... 0000 010 .. 0 .....  \
+                &fclass01 r=%ra64 t=%rt64
+@f0e_fd_1       ...... ..... 000  ... 0100 010 .0 0 t:5    &fclass01 r=%ra64
+@f0e_df_1       ...... r:5   000  ... 0001 010 0. 0 .....  &fclass01 t=%rt64
+@f0e_dd_1       ...... r:5   000  ... 0101 010 00 0 t:5    &fclass01
+
+@f0e_f_2        ...... ..... ..... y:3 .0 100 .00 c:5      \
+                &fclass2 r1=%ra64 r2=%rb64
+@f0e_d_2        ...... r1:5  r2:5  y:3 01 100 000 c:5      &fclass2
+
+@f0e_f_3        ...... ..... ..... ... .0 110 ..0 .....    \
+                &fclass3 r1=%ra64 r2=%rb64 t=%rt64
+@f0e_d_3        ...... r1:5  r2:5  ... 01 110 000 t:5
+
+# Floating point class 0
+
+# FID.  With r = t = 0, which via fcpy puts 0 into fr0.
+# This is machine/revision = 0, which is reserved for simulator.
+fcpy_f          001100 00000 00000 00000 000000 00000   \
+                &fclass01 r=0 t=0
+
+fcpy_f          001100 ..... ..... 010 00 ...... .....  @f0c_0
+fabs_f          001100 ..... ..... 011 00 ...... .....  @f0c_0
+fsqrt_f         001100 ..... ..... 100 00 ...... .....  @f0c_0
+frnd_f          001100 ..... ..... 101 00 ...... .....  @f0c_0
+fneg_f          001100 ..... ..... 110 00 ...... .....  @f0c_0
+fnegabs_f       001100 ..... ..... 111 00 ...... .....  @f0c_0
+
+fcpy_d          001100 ..... ..... 010 01 ...... .....  @f0c_0
+fabs_d          001100 ..... ..... 011 01 ...... .....  @f0c_0
+fsqrt_d         001100 ..... ..... 100 01 ...... .....  @f0c_0
+frnd_d          001100 ..... ..... 101 01 ...... .....  @f0c_0
+fneg_d          001100 ..... ..... 110 01 ...... .....  @f0c_0
+fnegabs_d       001100 ..... ..... 111 01 ...... .....  @f0c_0
+
+fcpy_f          001110 ..... ..... 010 ........ .....   @f0e_f_0
+fabs_f          001110 ..... ..... 011 ........ .....   @f0e_f_0
+fsqrt_f         001110 ..... ..... 100 ........ .....   @f0e_f_0
+frnd_f          001110 ..... ..... 101 ........ .....   @f0e_f_0
+fneg_f          001110 ..... ..... 110 ........ .....   @f0e_f_0
+fnegabs_f       001110 ..... ..... 111 ........ .....   @f0e_f_0
+
+fcpy_d          001110 ..... ..... 010 ........ .....   @f0e_d_0
+fabs_d          001110 ..... ..... 011 ........ .....   @f0e_d_0
+fsqrt_d         001110 ..... ..... 100 ........ .....   @f0e_d_0
+frnd_d          001110 ..... ..... 101 ........ .....   @f0e_d_0
+fneg_d          001110 ..... ..... 110 ........ .....   @f0e_d_0
+fnegabs_d       001110 ..... ..... 111 ........ .....   @f0e_d_0
+
+# Floating point class 1
+
+# float/float
+fcnv_d_f        001100 ..... ... 000 00 01 ...... ..... @f0c_1
+fcnv_f_d        001100 ..... ... 000 01 00 ...... ..... @f0c_1
+
+fcnv_d_f        001110 ..... ... 000 .......... .....   @f0e_df_1
+fcnv_f_d        001110 ..... ... 000 .......... .....   @f0e_fd_1
+
+# int/float
+fcnv_w_f        001100 ..... ... 001 00 00 ...... ..... @f0c_1
+fcnv_q_f        001100 ..... ... 001 00 01 ...... ..... @f0c_1
+fcnv_w_d        001100 ..... ... 001 01 00 ...... ..... @f0c_1
+fcnv_q_d        001100 ..... ... 001 01 01 ...... ..... @f0c_1
+
+fcnv_w_f        001110 ..... ... 001 .......... .....   @f0e_ff_1
+fcnv_q_f        001110 ..... ... 001 .......... .....   @f0e_df_1
+fcnv_w_d        001110 ..... ... 001 .......... .....   @f0e_fd_1
+fcnv_q_d        001110 ..... ... 001 .......... .....   @f0e_dd_1
+
+# float/int
+fcnv_f_w        001100 ..... ... 010 00 00 ...... ..... @f0c_1
+fcnv_d_w        001100 ..... ... 010 00 01 ...... ..... @f0c_1
+fcnv_f_q        001100 ..... ... 010 01 00 ...... ..... @f0c_1
+fcnv_d_q        001100 ..... ... 010 01 01 ...... ..... @f0c_1
+
+fcnv_f_w        001110 ..... ... 010 .......... .....   @f0e_ff_1
+fcnv_d_w        001110 ..... ... 010 .......... .....   @f0e_df_1
+fcnv_f_q        001110 ..... ... 010 .......... .....   @f0e_fd_1
+fcnv_d_q        001110 ..... ... 010 .......... .....   @f0e_dd_1
+
+# float/int truncate
+fcnv_t_f_w      001100 ..... ... 011 00 00 ...... ..... @f0c_1
+fcnv_t_d_w      001100 ..... ... 011 00 01 ...... ..... @f0c_1
+fcnv_t_f_q      001100 ..... ... 011 01 00 ...... ..... @f0c_1
+fcnv_t_d_q      001100 ..... ... 011 01 01 ...... ..... @f0c_1
+
+fcnv_t_f_w      001110 ..... ... 011 .......... .....   @f0e_ff_1
+fcnv_t_d_w      001110 ..... ... 011 .......... .....   @f0e_df_1
+fcnv_t_f_q      001110 ..... ... 011 .......... .....   @f0e_fd_1
+fcnv_t_d_q      001110 ..... ... 011 .......... .....   @f0e_dd_1
+
+# uint/float
+fcnv_uw_f       001100 ..... ... 101 00 00 ...... ..... @f0c_1
+fcnv_uq_f       001100 ..... ... 101 00 01 ...... ..... @f0c_1
+fcnv_uw_d       001100 ..... ... 101 01 00 ...... ..... @f0c_1
+fcnv_uq_d       001100 ..... ... 101 01 01 ...... ..... @f0c_1
+
+fcnv_uw_f       001110 ..... ... 101 .......... .....   @f0e_ff_1
+fcnv_uq_f       001110 ..... ... 101 .......... .....   @f0e_df_1
+fcnv_uw_d       001110 ..... ... 101 .......... .....   @f0e_fd_1
+fcnv_uq_d       001110 ..... ... 101 .......... .....   @f0e_dd_1
+
+# float/int
+fcnv_f_uw       001100 ..... ... 110 00 00 ...... ..... @f0c_1
+fcnv_d_uw       001100 ..... ... 110 00 01 ...... ..... @f0c_1
+fcnv_f_uq       001100 ..... ... 110 01 00 ...... ..... @f0c_1
+fcnv_d_uq       001100 ..... ... 110 01 01 ...... ..... @f0c_1
+
+fcnv_f_uw       001110 ..... ... 110 .......... .....   @f0e_ff_1
+fcnv_d_uw       001110 ..... ... 110 .......... .....   @f0e_df_1
+fcnv_f_uq       001110 ..... ... 110 .......... .....   @f0e_fd_1
+fcnv_d_uq       001110 ..... ... 110 .......... .....   @f0e_dd_1
+
+# float/int truncate
+fcnv_t_f_uw     001100 ..... ... 111 00 00 ...... ..... @f0c_1
+fcnv_t_d_uw     001100 ..... ... 111 00 01 ...... ..... @f0c_1
+fcnv_t_f_uq     001100 ..... ... 111 01 00 ...... ..... @f0c_1
+fcnv_t_d_uq     001100 ..... ... 111 01 01 ...... ..... @f0c_1
+
+fcnv_t_f_uw     001110 ..... ... 111 .......... .....   @f0e_ff_1
+fcnv_t_d_uw     001110 ..... ... 111 .......... .....   @f0e_df_1
+fcnv_t_f_uq     001110 ..... ... 111 .......... .....   @f0e_fd_1
+fcnv_t_d_uq     001110 ..... ... 111 .......... .....   @f0e_dd_1
+
+# Floating point class 2
+
+ftest           001100 00000 00000 y:3 00 10000 1 c:5
+
+fcmp_f          001100 ..... ..... ... 00 ..... 0 ..... @f0c_2
+fcmp_d          001100 ..... ..... ... 01 ..... 0 ..... @f0c_2
+
+fcmp_f          001110 ..... ..... ... ..... ... .....  @f0e_f_2
+fcmp_d          001110 ..... ..... ... ..... ... .....  @f0e_d_2
+
+# Floating point class 3
+
+fadd_f          001100 ..... ..... 000 00 ...... .....  @f0c_3
+fsub_f          001100 ..... ..... 001 00 ...... .....  @f0c_3
+fmpy_f          001100 ..... ..... 010 00 ...... .....  @f0c_3
+fdiv_f          001100 ..... ..... 011 00 ...... .....  @f0c_3
+
+fadd_d          001100 ..... ..... 000 01 ...... .....  @f0c_3
+fsub_d          001100 ..... ..... 001 01 ...... .....  @f0c_3
+fmpy_d          001100 ..... ..... 010 01 ...... .....  @f0c_3
+fdiv_d          001100 ..... ..... 011 01 ...... .....  @f0c_3
+
+fadd_f          001110 ..... ..... 000 ..... ... .....  @f0e_f_3
+fsub_f          001110 ..... ..... 001 ..... ... .....  @f0e_f_3
+fmpy_f          001110 ..... ..... 010 ..... ... .....  @f0e_f_3
+fdiv_f          001110 ..... ..... 011 ..... ... .....  @f0e_f_3
+
+fadd_d          001110 ..... ..... 000 ..... ... .....  @f0e_d_3
+fsub_d          001110 ..... ..... 001 ..... ... .....  @f0e_d_3
+fmpy_d          001110 ..... ..... 010 ..... ... .....  @f0e_d_3
+fdiv_d          001110 ..... ..... 011 ..... ... .....  @f0e_d_3
+
+xmpyu           001110 ..... ..... 010 .0111 .00 t:5    r1=%ra64 r2=%rb64
-- 
2.17.2
