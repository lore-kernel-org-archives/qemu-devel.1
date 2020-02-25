Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8840C35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E43A21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E43A21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Xaq-0005jg-OE
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 05:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j6XYi-0001B2-0K
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j6XYe-0001Py-7I
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:35:23 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:50323)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j6XYd-0001Na-A0; Tue, 25 Feb 2020 05:35:20 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.539249-0.0317305-0.429021;
 DS=CONTINUE|ham_system_inform|0.193201-0.0010354-0.805764;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03303; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.GsFPuQz_1582626910; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GsFPuQz_1582626910)
 by smtp.aliyun-inc.com(10.147.40.44); Tue, 25 Feb 2020 18:35:11 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v4 1/5] target/riscv: add vector unit stride load and store
 instructions
Date: Tue, 25 Feb 2020 18:35:04 +0800
Message-Id: <20200225103508.7651-2-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, linux-csky@vger.kernel.org,
 wenmeng_zhang@c-sky.com, wxy194768@alibaba-inc.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vector unit-stride operations access elements stored contiguously in memory
starting from the base effective address.

The Zvlsseg expands some vector load/store segment instructions, which move
multiple contiguous fields in memory to and from consecutively numbered
vector register

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/helper.h                   |  70 ++++
 target/riscv/insn32.decode              |  17 +
 target/riscv/insn_trans/trans_rvv.inc.c | 188 +++++++++++
 target/riscv/translate.c                |   2 +
 target/riscv/vector_helper.c            | 404 ++++++++++++++++++++++++
 5 files changed, 681 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 3c28c7e407..996639c0fa 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -78,3 +78,73 @@ DEF_HELPER_1(tlb_flush, void, env)
 #endif
 /* Vector functions */
 DEF_HELPER_3(vsetvl, tl, env, tl, tl)
+DEF_HELPER_5(vlb_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_b_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlh_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlh_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlh_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlh_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlh_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlh_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlw_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlw_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlw_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlw_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_b_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_b_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhu_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhu_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhu_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhu_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhu_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhu_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlwu_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlwu_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlwu_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlwu_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_b_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsh_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsh_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsh_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsh_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsh_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsh_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsw_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsw_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsw_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsw_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_b_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_d_mask, void, ptr, ptr, tl, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 5dc009c3cd..dad3ed91c7 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -43,6 +43,7 @@
 &u    imm rd
 &shift     shamt rs1 rd
 &atomic    aq rl rs2 rs1 rd
+&r2nfvm    vm rd rs1 nf
 
 # Formats 32:
 @r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
@@ -62,6 +63,7 @@
 @r_rm    .......   ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
 @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
+@r2_nfvm nf:3 ... vm:1 ..... ..... ... ..... ....... &r2nfvm %rs1 %rd
 @r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
 
 @sfence_vma ....... ..... .....   ... ..... ....... %rs2 %rs1
@@ -206,5 +208,20 @@ fcvt_d_w   1101001  00000 ..... ... ..... 1010011 @r2_rm
 fcvt_d_wu  1101001  00001 ..... ... ..... 1010011 @r2_rm
 
 # *** RV32V Extension ***
+
+# *** Vector loads and stores are encoded within LOADFP/STORE-FP ***
+vlb_v      ... 100 . 00000 ..... 000 ..... 0000111 @r2_nfvm
+vlh_v      ... 100 . 00000 ..... 101 ..... 0000111 @r2_nfvm
+vlw_v      ... 100 . 00000 ..... 110 ..... 0000111 @r2_nfvm
+vle_v      ... 000 . 00000 ..... 111 ..... 0000111 @r2_nfvm
+vlbu_v     ... 000 . 00000 ..... 000 ..... 0000111 @r2_nfvm
+vlhu_v     ... 000 . 00000 ..... 101 ..... 0000111 @r2_nfvm
+vlwu_v     ... 000 . 00000 ..... 110 ..... 0000111 @r2_nfvm
+vsb_v      ... 000 . 00000 ..... 000 ..... 0100111 @r2_nfvm
+vsh_v      ... 000 . 00000 ..... 101 ..... 0100111 @r2_nfvm
+vsw_v      ... 000 . 00000 ..... 110 ..... 0100111 @r2_nfvm
+vse_v      ... 000 . 00000 ..... 111 ..... 0100111 @r2_nfvm
+
+# *** new major opcode OP-V ***
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index da82c72bbf..b0e97e7e06 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -15,6 +15,8 @@
  * You should have received a copy of the GNU General Public License along with
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg-gvec-desc.h"
 
 static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl * a)
 {
@@ -67,3 +69,189 @@ static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli * a)
     tcg_temp_free(dst);
     return true;
 }
+
+/* vector register offset from env */
+static uint32_t vreg_ofs(DisasContext *s, int reg)
+{
+    return offsetof(CPURISCVState, vreg) + reg * s->vlen / 8;
+}
+
+/* check functions */
+static bool vext_check_isa_ill(DisasContext *s, target_ulong isa)
+{
+    return !s->vill && ((s->misa & isa) == isa);
+}
+
+static bool vext_check_reg(DisasContext *s, uint32_t reg, bool widen)
+{
+    int legal = widen ? 2 << s->lmul : 1 << s->lmul;
+
+    return !((s->lmul == 0x3 && widen) || (reg % legal));
+}
+
+static bool vext_check_overlap_mask(DisasContext *s, uint32_t vd, bool vm)
+{
+    return !(s->lmul > 1 && vm == 0 && vd == 0);
+}
+
+static bool vext_check_nf(DisasContext *s, uint32_t nf)
+{
+    return s->lmul * (nf + 1) <= 8;
+}
+
+/* common translation macro */
+#define GEN_VEXT_TRANS(NAME, SEQ, ARGTYPE, OP, CHECK)      \
+static bool trans_##NAME(DisasContext *s, arg_##ARGTYPE *a)\
+{                                                          \
+    if (CHECK(s, a)) {                                     \
+        return OP(s, a, SEQ);                              \
+    }                                                      \
+    return false;                                          \
+}
+
+/*
+ *** unit stride load and store
+ */
+typedef void gen_helper_ldst_us(TCGv_ptr, TCGv_ptr, TCGv,
+        TCGv_env, TCGv_i32);
+
+static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
+        gen_helper_ldst_us *fn, DisasContext *s)
+{
+    TCGv_ptr dest, mask;
+    TCGv base;
+    TCGv_i32 desc;
+
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    base = tcg_temp_new();
+
+    /*
+     * As simd_desc supports at most 256 bytes, and in this implementation,
+     * the max vector group length is 2048 bytes. So split it into two parts.
+     *
+     * The first part is vlen in bytes, encoded in maxsz of simd_desc.
+     * The second part is lmul, encoded in data of simd_desc.
+     */
+    desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+
+    gen_get_gpr(base, rs1);
+    tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
+
+    fn(dest, mask, base, cpu_env, desc);
+
+    tcg_temp_free_ptr(dest);
+    tcg_temp_free_ptr(mask);
+    tcg_temp_free(base);
+    tcg_temp_free_i32(desc);
+    return true;
+}
+
+static bool ld_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
+{
+    uint8_t nf = a->nf + 1;
+    uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9) | (nf << 11);
+    gen_helper_ldst_us *fn;
+    static gen_helper_ldst_us * const fns[2][7][4] = {
+        /* masked unit stride load */
+        { { gen_helper_vlb_v_b_mask,  gen_helper_vlb_v_h_mask,
+            gen_helper_vlb_v_w_mask,  gen_helper_vlb_v_d_mask },
+          { NULL,                     gen_helper_vlh_v_h_mask,
+            gen_helper_vlh_v_w_mask,  gen_helper_vlh_v_d_mask },
+          { NULL,                     NULL,
+            gen_helper_vlw_v_w_mask,  gen_helper_vlw_v_d_mask },
+          { gen_helper_vle_v_b_mask,  gen_helper_vle_v_h_mask,
+            gen_helper_vle_v_w_mask,  gen_helper_vle_v_d_mask },
+          { gen_helper_vlbu_v_b_mask, gen_helper_vlbu_v_h_mask,
+            gen_helper_vlbu_v_w_mask, gen_helper_vlbu_v_d_mask },
+          { NULL,                     gen_helper_vlhu_v_h_mask,
+            gen_helper_vlhu_v_w_mask, gen_helper_vlhu_v_d_mask },
+          { NULL,                     NULL,
+            gen_helper_vlwu_v_w_mask, gen_helper_vlwu_v_d_mask } },
+        /* unmasked unit stride load */
+        { { gen_helper_vlb_v_b,  gen_helper_vlb_v_h,
+            gen_helper_vlb_v_w,  gen_helper_vlb_v_d },
+          { NULL,                gen_helper_vlh_v_h,
+            gen_helper_vlh_v_w,  gen_helper_vlh_v_d },
+          { NULL,                NULL,
+            gen_helper_vlw_v_w,  gen_helper_vlw_v_d },
+          { gen_helper_vle_v_b,  gen_helper_vle_v_h,
+            gen_helper_vle_v_w,  gen_helper_vle_v_d },
+          { gen_helper_vlbu_v_b, gen_helper_vlbu_v_h,
+            gen_helper_vlbu_v_w, gen_helper_vlbu_v_d },
+          { NULL,                gen_helper_vlhu_v_h,
+            gen_helper_vlhu_v_w, gen_helper_vlhu_v_d },
+          { NULL,                NULL,
+            gen_helper_vlwu_v_w, gen_helper_vlwu_v_d } }
+    };
+
+    fn =  fns[a->vm][seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    return ldst_us_trans(a->rd, a->rs1, data, fn, s);
+}
+
+static bool ld_us_check(DisasContext *s, arg_r2nfvm* a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_nf(s, a->nf));
+}
+
+GEN_VEXT_TRANS(vlb_v, 0, r2nfvm, ld_us_op, ld_us_check)
+GEN_VEXT_TRANS(vlh_v, 1, r2nfvm, ld_us_op, ld_us_check)
+GEN_VEXT_TRANS(vlw_v, 2, r2nfvm, ld_us_op, ld_us_check)
+GEN_VEXT_TRANS(vle_v, 3, r2nfvm, ld_us_op, ld_us_check)
+GEN_VEXT_TRANS(vlbu_v, 4, r2nfvm, ld_us_op, ld_us_check)
+GEN_VEXT_TRANS(vlhu_v, 5, r2nfvm, ld_us_op, ld_us_check)
+GEN_VEXT_TRANS(vlwu_v, 6, r2nfvm, ld_us_op, ld_us_check)
+
+static bool st_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
+{
+    uint8_t nf = a->nf + 1;
+    uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9) | (nf << 11);
+    gen_helper_ldst_us *fn;
+    static gen_helper_ldst_us * const fns[2][4][4] = {
+        /* masked unit stride load and store */
+        { { gen_helper_vsb_v_b_mask,  gen_helper_vsb_v_h_mask,
+            gen_helper_vsb_v_w_mask,  gen_helper_vsb_v_d_mask },
+          { NULL,                     gen_helper_vsh_v_h_mask,
+            gen_helper_vsh_v_w_mask,  gen_helper_vsh_v_d_mask },
+          { NULL,                     NULL,
+            gen_helper_vsw_v_w_mask,  gen_helper_vsw_v_d_mask },
+          { gen_helper_vse_v_b_mask,  gen_helper_vse_v_h_mask,
+            gen_helper_vse_v_w_mask,  gen_helper_vse_v_d_mask } },
+        /* unmasked unit stride store */
+        { { gen_helper_vsb_v_b,  gen_helper_vsb_v_h,
+            gen_helper_vsb_v_w,  gen_helper_vsb_v_d },
+          { NULL,                gen_helper_vsh_v_h,
+            gen_helper_vsh_v_w,  gen_helper_vsh_v_d },
+          { NULL,                NULL,
+            gen_helper_vsw_v_w,  gen_helper_vsw_v_d },
+          { gen_helper_vse_v_b,  gen_helper_vse_v_h,
+            gen_helper_vse_v_w,  gen_helper_vse_v_d } }
+    };
+
+    fn =  fns[a->vm][seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    return ldst_us_trans(a->rd, a->rs1, data, fn, s);
+}
+
+static bool st_us_check(DisasContext *s, arg_r2nfvm* a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_nf(s, a->nf));
+}
+
+GEN_VEXT_TRANS(vsb_v, 0, r2nfvm, st_us_op, st_us_check)
+GEN_VEXT_TRANS(vsh_v, 1, r2nfvm, st_us_op, st_us_check)
+GEN_VEXT_TRANS(vsw_v, 2, r2nfvm, st_us_op, st_us_check)
+GEN_VEXT_TRANS(vse_v, 3, r2nfvm, st_us_op, st_us_check)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index cc356aabd8..faec71e239 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -60,6 +60,7 @@ typedef struct DisasContext {
     uint8_t lmul;
     uint8_t sew;
     uint16_t vlen;
+    uint16_t mlen;
     bool vl_eq_vlmax;
 } DisasContext;
 
@@ -755,6 +756,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->vill = FIELD_EX32(tb_flags, TB_FLAGS, VILL);
     ctx->sew = FIELD_EX32(tb_flags, TB_FLAGS, SEW);
     ctx->lmul = FIELD_EX32(tb_flags, TB_FLAGS, LMUL);
+    ctx->mlen = 1 << (ctx->sew  + 3 - ctx->lmul);
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
 }
 
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 07db704656..39984cebd2 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -18,8 +18,10 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "exec/memop.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "tcg/tcg-gvec-desc.h"
 #include <math.h>
 
 target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
@@ -51,3 +53,405 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     env->vstart = 0;
     return vl;
 }
+
+/*
+ * Note that vector data is stored in host-endian 64-bit chunks,
+ * so addressing units smaller than that needs a host-endian fixup.
+ */
+#ifdef HOST_WORDS_BIGENDIAN
+#define H1(x)   ((x) ^ 7)
+#define H1_2(x) ((x) ^ 6)
+#define H1_4(x) ((x) ^ 4)
+#define H2(x)   ((x) ^ 3)
+#define H4(x)   ((x) ^ 1)
+#define H8(x)   ((x))
+#else
+#define H1(x)   (x)
+#define H1_2(x) (x)
+#define H1_4(x) (x)
+#define H2(x)   (x)
+#define H4(x)   (x)
+#define H8(x)   (x)
+#endif
+
+static inline uint32_t vext_nf(uint32_t desc)
+{
+    return (simd_data(desc) >> 11) & 0xf;
+}
+
+static inline uint32_t vext_mlen(uint32_t desc)
+{
+    return simd_data(desc) & 0xff;
+}
+
+static inline uint32_t vext_vm(uint32_t desc)
+{
+    return (simd_data(desc) >> 8) & 0x1;
+}
+
+static inline uint32_t vext_lmul(uint32_t desc)
+{
+    return (simd_data(desc) >> 9) & 0x3;
+}
+
+/*
+ * Get vector group length in bytes. Its range is [64, 2048].
+ *
+ * As simd_desc support at most 256, the max vlen is 512 bits.
+ * So vlen in bytes is encoded as maxsz.
+ */
+static inline uint32_t vext_maxsz(uint32_t desc)
+{
+    return simd_maxsz(desc) << vext_lmul(desc);
+}
+
+/*
+ * This function checks watchpoint before real load operation.
+ *
+ * In softmmu mode, the TLB API probe_access is enough for watchpoint check.
+ * In user mode, there is no watchpoint support now.
+ *
+ * It will triggle an exception if there is no mapping in TLB
+ * and page table walk can't fill the TLB entry. Then the guest
+ * software can return here after process the exception or never return.
+ */
+static void probe_read_access(CPURISCVState *env, target_ulong addr,
+        target_ulong len, uintptr_t ra)
+{
+    while (len) {
+        const target_ulong pagelen = -(addr | TARGET_PAGE_MASK);
+        const target_ulong curlen = MIN(pagelen, len);
+
+        probe_read(env, addr, curlen, cpu_mmu_index(env, false), ra);
+        addr += curlen;
+        len -= curlen;
+    }
+}
+
+static void probe_write_access(CPURISCVState *env, target_ulong addr,
+        target_ulong len, uintptr_t ra)
+{
+    while (len) {
+        const target_ulong pagelen = -(addr | TARGET_PAGE_MASK);
+        const target_ulong curlen = MIN(pagelen, len);
+
+        probe_write(env, addr, curlen, cpu_mmu_index(env, false), ra);
+        addr += curlen;
+        len -= curlen;
+    }
+}
+
+#ifdef HOST_WORDS_BIGENDIAN
+static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)
+{
+    /*
+     * Split the remaining range to two parts.
+     * The first part is in the last uint64_t unit.
+     * The second part start from the next uint64_t unit.
+     */
+    int part1 = 0, part2 = tot - cnt;
+    if (cnt % 64) {
+        part1 = 64 - (cnt % 64);
+        part2 = tot - cnt - part1;
+        memset(tail & ~(63ULL), 0, part1);
+        memset((tail + 64) & ~(63ULL), 0, part2);
+    } else {
+        memset(tail, 0, part2);
+    }
+}
+#else
+static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)
+{
+    memset(tail, 0, tot - cnt);
+}
+#endif
+
+static inline int vext_elem_mask(void *v0, int mlen, int index)
+{
+
+    int idx = (index * mlen) / 8;
+    int pos = (index * mlen) % 8;
+
+    switch (mlen) {
+    case 8:
+        return *((uint8_t *)v0 + H1(index)) & 0x1;
+    case 16:
+        return *((uint16_t *)v0 + H2(index)) & 0x1;
+    case 32:
+        return *((uint32_t *)v0 + H4(index)) & 0x1;
+    case 64:
+        return *((uint64_t *)v0 + index) & 0x1;
+    default:
+        return (*((uint8_t *)v0 + H1(idx)) >> pos) & 0x1;
+    }
+}
+
+/* elements operations for load and store */
+typedef void (*vext_ld_elem_fn)(CPURISCVState *env, target_ulong addr,
+        uint32_t idx, void *vd, uintptr_t retaddr);
+typedef void (*vext_st_elem_fn)(CPURISCVState *env, target_ulong addr,
+        uint32_t idx, void *vd, uintptr_t retaddr);
+typedef void (*vext_ld_clear_elem)(void *vd, uint32_t idx,
+        uint32_t cnt, uint32_t tot);
+
+#define GEN_VEXT_LD_ELEM(NAME, MTYPE, ETYPE, H, LDSUF)              \
+static void vext_##NAME##_ld_elem(CPURISCVState *env, abi_ptr addr, \
+        uint32_t idx, void *vd, uintptr_t retaddr)                  \
+{                                                                   \
+    int mmu_idx = cpu_mmu_index(env, false);                        \
+    MTYPE data;                                                     \
+    ETYPE *cur = ((ETYPE *)vd + H(idx));                            \
+    data = cpu_##LDSUF##_mmuidx_ra(env, addr, mmu_idx, retaddr);    \
+    *cur = data;                                                    \
+}                                                                   \
+static void vext_##NAME##_clear_elem(void *vd, uint32_t idx,        \
+        uint32_t cnt, uint32_t tot)                                 \
+{                                                                   \
+    ETYPE *cur = ((ETYPE *)vd + H(idx));                            \
+    vext_clear(cur, cnt, tot);                                      \
+}
+
+GEN_VEXT_LD_ELEM(vlb_v_b, int8_t,  int8_t,  H1, ldsb)
+GEN_VEXT_LD_ELEM(vlb_v_h, int8_t,  int16_t, H2, ldsb)
+GEN_VEXT_LD_ELEM(vlb_v_w, int8_t,  int32_t, H4, ldsb)
+GEN_VEXT_LD_ELEM(vlb_v_d, int8_t,  int64_t, H8, ldsb)
+GEN_VEXT_LD_ELEM(vlh_v_h, int16_t, int16_t, H2, ldsw)
+GEN_VEXT_LD_ELEM(vlh_v_w, int16_t, int32_t, H4, ldsw)
+GEN_VEXT_LD_ELEM(vlh_v_d, int16_t, int64_t, H8, ldsw)
+GEN_VEXT_LD_ELEM(vlw_v_w, int32_t, int32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(vlw_v_d, int32_t, int64_t, H8, ldl)
+GEN_VEXT_LD_ELEM(vle_v_b, int8_t,  int8_t,  H1, ldsb)
+GEN_VEXT_LD_ELEM(vle_v_h, int16_t, int16_t, H2, ldsw)
+GEN_VEXT_LD_ELEM(vle_v_w, int32_t, int32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(vle_v_d, int64_t, int64_t, H8, ldq)
+GEN_VEXT_LD_ELEM(vlbu_v_b, uint8_t,  uint8_t,  H1, ldub)
+GEN_VEXT_LD_ELEM(vlbu_v_h, uint8_t,  uint16_t, H2, ldub)
+GEN_VEXT_LD_ELEM(vlbu_v_w, uint8_t,  uint32_t, H4, ldub)
+GEN_VEXT_LD_ELEM(vlbu_v_d, uint8_t,  uint64_t, H8, ldub)
+GEN_VEXT_LD_ELEM(vlhu_v_h, uint16_t, uint16_t, H2, lduw)
+GEN_VEXT_LD_ELEM(vlhu_v_w, uint16_t, uint32_t, H4, lduw)
+GEN_VEXT_LD_ELEM(vlhu_v_d, uint16_t, uint64_t, H8, lduw)
+GEN_VEXT_LD_ELEM(vlwu_v_w, uint32_t, uint32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(vlwu_v_d, uint32_t, uint64_t, H8, ldl)
+
+#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)                       \
+static void vext_##NAME##_st_elem(CPURISCVState *env, abi_ptr addr,   \
+        uint32_t idx, void *vd, uintptr_t retaddr)                    \
+{                                                                     \
+    int mmu_idx = cpu_mmu_index(env, false);                          \
+    ETYPE data = *((ETYPE *)vd + H(idx));                             \
+    cpu_##STSUF##_mmuidx_ra(env, addr, data, mmu_idx, retaddr);       \
+}
+
+GEN_VEXT_ST_ELEM(vsb_v_b, int8_t,  H1, stb)
+GEN_VEXT_ST_ELEM(vsb_v_h, int16_t, H2, stb)
+GEN_VEXT_ST_ELEM(vsb_v_w, int32_t, H4, stb)
+GEN_VEXT_ST_ELEM(vsb_v_d, int64_t, H8, stb)
+GEN_VEXT_ST_ELEM(vsh_v_h, int16_t, H2, stw)
+GEN_VEXT_ST_ELEM(vsh_v_w, int32_t, H4, stw)
+GEN_VEXT_ST_ELEM(vsh_v_d, int64_t, H8, stw)
+GEN_VEXT_ST_ELEM(vsw_v_w, int32_t, H4, stl)
+GEN_VEXT_ST_ELEM(vsw_v_d, int64_t, H8, stl)
+GEN_VEXT_ST_ELEM(vse_v_b, int8_t,  H1, stb)
+GEN_VEXT_ST_ELEM(vse_v_h, int16_t, H2, stw)
+GEN_VEXT_ST_ELEM(vse_v_w, int32_t, H4, stl)
+GEN_VEXT_ST_ELEM(vse_v_d, int64_t, H8, stq)
+
+/*
+ *** unit-stride: load vector element from continuous guest memory
+ */
+static inline void vext_ld_us_mask(void *vd, void *v0, target_ulong base,
+        CPURISCVState *env, uint32_t desc,
+        vext_ld_elem_fn ld_elem,
+        vext_ld_clear_elem clear_elem,
+        uint32_t esz, uint32_t msz, uintptr_t ra)
+{
+    uint32_t i, k;
+    uint32_t mlen = vext_mlen(desc);
+    uint32_t nf = vext_nf(desc);
+    uint32_t vlmax = vext_maxsz(desc) / esz;
+
+    if (env->vl == 0) {
+        return;
+    }
+    /* probe every access*/
+    for (i = 0; i < env->vl; i++) {
+        if (!vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        probe_read_access(env, base + nf * i * msz, nf * msz, ra);
+    }
+    /* load bytes from guest memory */
+    for (i = 0; i < env->vl; i++) {
+        k = 0;
+        if (!vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        while (k < nf) {
+            target_ulong addr = base + (i * nf + k) * msz;
+            ld_elem(env, addr, i + k * vlmax, vd, ra);
+            k++;
+        }
+    }
+    /* clear tail elements */
+    for (k = 0; k < nf; k++) {
+        clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+    }
+}
+
+static inline void vext_ld_us(void *vd, target_ulong base,
+        CPURISCVState *env, uint32_t desc,
+        vext_ld_elem_fn ld_elem,
+        vext_ld_clear_elem clear_elem,
+        uint32_t esz, uint32_t msz, uintptr_t ra)
+{
+    uint32_t i, k;
+    uint32_t nf = vext_nf(desc);
+    uint32_t vlmax = vext_maxsz(desc) / esz;
+
+    if (env->vl == 0) {
+        return;
+    }
+    /* probe every access*/
+    probe_read_access(env, base, env->vl * nf * msz, ra);
+    /* load bytes from guest memory */
+    for (i = 0; i < env->vl; i++) {
+        k = 0;
+        while (k < nf) {
+            target_ulong addr = base + (i * nf + k) * msz;
+            ld_elem(env, addr, i + k * vlmax, vd, ra);
+            k++;
+        }
+    }
+    /* clear tail elements */
+    for (k = 0; k < nf; k++) {
+        clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+    }
+}
+
+#define GEN_VEXT_LD_US(NAME, MTYPE, ETYPE)                         \
+void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,    \
+        CPURISCVState *env, uint32_t desc)                         \
+{                                                                  \
+    vext_ld_us_mask(vd, v0, base, env, desc,                       \
+        vext_##NAME##_ld_elem,                                     \
+        vext_##NAME##_clear_elem,                                  \
+        sizeof(ETYPE), sizeof(MTYPE), GETPC());                    \
+}                                                                  \
+                                                                   \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,           \
+        CPURISCVState *env, uint32_t desc)                         \
+{                                                                  \
+    vext_ld_us(vd, base, env, desc,                                \
+        vext_##NAME##_ld_elem,                                     \
+        vext_##NAME##_clear_elem,                                  \
+        sizeof(ETYPE), sizeof(MTYPE), GETPC());                    \
+}
+
+GEN_VEXT_LD_US(vlb_v_b, int8_t,  int8_t)
+GEN_VEXT_LD_US(vlb_v_h, int8_t,  int16_t)
+GEN_VEXT_LD_US(vlb_v_w, int8_t,  int32_t)
+GEN_VEXT_LD_US(vlb_v_d, int8_t,  int64_t)
+GEN_VEXT_LD_US(vlh_v_h, int16_t, int16_t)
+GEN_VEXT_LD_US(vlh_v_w, int16_t, int32_t)
+GEN_VEXT_LD_US(vlh_v_d, int16_t, int64_t)
+GEN_VEXT_LD_US(vlw_v_w, int32_t, int32_t)
+GEN_VEXT_LD_US(vlw_v_d, int32_t, int64_t)
+GEN_VEXT_LD_US(vle_v_b, int8_t,  int8_t)
+GEN_VEXT_LD_US(vle_v_h, int16_t, int16_t)
+GEN_VEXT_LD_US(vle_v_w, int32_t, int32_t)
+GEN_VEXT_LD_US(vle_v_d, int64_t, int64_t)
+GEN_VEXT_LD_US(vlbu_v_b, uint8_t,  uint8_t)
+GEN_VEXT_LD_US(vlbu_v_h, uint8_t,  uint16_t)
+GEN_VEXT_LD_US(vlbu_v_w, uint8_t,  uint32_t)
+GEN_VEXT_LD_US(vlbu_v_d, uint8_t,  uint64_t)
+GEN_VEXT_LD_US(vlhu_v_h, uint16_t, uint16_t)
+GEN_VEXT_LD_US(vlhu_v_w, uint16_t, uint32_t)
+GEN_VEXT_LD_US(vlhu_v_d, uint16_t, uint64_t)
+GEN_VEXT_LD_US(vlwu_v_w, uint32_t, uint32_t)
+GEN_VEXT_LD_US(vlwu_v_d, uint32_t, uint64_t)
+
+/* unit-stride: store vector element to guest memory */
+static void vext_st_us_mask(void *vd, void *v0, target_ulong base,
+        CPURISCVState *env, uint32_t desc,
+        vext_st_elem_fn st_elem,
+        uint32_t esz, uint32_t msz, uintptr_t ra)
+{
+    uint32_t i, k;
+    uint32_t nf = vext_nf(desc);
+    uint32_t mlen = vext_mlen(desc);
+    uint32_t vlmax = vext_maxsz(desc) / esz;
+
+    /* probe every access*/
+    for (i = 0; i < env->vl; i++) {
+        if (!vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        probe_write_access(env, base + nf * i * msz, nf * msz, ra);
+    }
+    /* store bytes to guest memory */
+    for (i = 0; i < env->vl; i++) {
+        k = 0;
+        if (!vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        while (k < nf) {
+            target_ulong addr = base + (i * nf + k) * msz;
+            st_elem(env, addr, i + k * vlmax, vd, ra);
+            k++;
+        }
+    }
+}
+
+static void vext_st_us(void *vd, target_ulong base,
+        CPURISCVState *env, uint32_t desc,
+        vext_st_elem_fn st_elem,
+        uint32_t esz, uint32_t msz, uintptr_t ra)
+{
+    uint32_t i, k;
+    uint32_t nf = vext_nf(desc);
+    uint32_t vlmax = vext_maxsz(desc) / esz;
+
+    /* probe every access*/
+    probe_write_access(env, base, env->vl * nf * msz, ra);
+    /* load bytes from guest memory */
+    for (i = 0; i < env->vl; i++) {
+        k = 0;
+        while (k < nf) {
+            target_ulong addr = base + (i * nf + k) * msz;
+            st_elem(env, addr, i + k * vlmax, vd, ra);
+            k++;
+        }
+    }
+}
+
+#define GEN_VEXT_ST_US(NAME, MTYPE, ETYPE)                      \
+void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base, \
+        CPURISCVState *env, uint32_t desc)                      \
+{                                                               \
+    vext_st_us_mask(vd, v0, base, env, desc,                    \
+        vext_##NAME##_st_elem,                                  \
+        sizeof(ETYPE), sizeof(MTYPE), GETPC());                 \
+}                                                               \
+                                                                \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,        \
+        CPURISCVState *env, uint32_t desc)                      \
+{                                                               \
+    vext_st_us(vd, base, env, desc,                             \
+        vext_##NAME##_st_elem,                                  \
+        sizeof(ETYPE), sizeof(MTYPE), GETPC());                 \
+}
+
+GEN_VEXT_ST_US(vsb_v_b, int8_t,  int8_t)
+GEN_VEXT_ST_US(vsb_v_h, int8_t,  int16_t)
+GEN_VEXT_ST_US(vsb_v_w, int8_t,  int32_t)
+GEN_VEXT_ST_US(vsb_v_d, int8_t,  int64_t)
+GEN_VEXT_ST_US(vsh_v_h, int16_t, int16_t)
+GEN_VEXT_ST_US(vsh_v_w, int16_t, int32_t)
+GEN_VEXT_ST_US(vsh_v_d, int16_t, int64_t)
+GEN_VEXT_ST_US(vsw_v_w, int32_t, int32_t)
+GEN_VEXT_ST_US(vsw_v_d, int32_t, int64_t)
+GEN_VEXT_ST_US(vse_v_b, int8_t,  int8_t)
+GEN_VEXT_ST_US(vse_v_h, int16_t, int16_t)
+GEN_VEXT_ST_US(vse_v_w, int32_t, int32_t)
+GEN_VEXT_ST_US(vse_v_d, int64_t, int64_t)
-- 
2.23.0


