Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AEAC352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 07:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB8D20733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 07:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB8D20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j13lt-0007vI-BM
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 02:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j13ix-0002r7-TH
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j13iu-00056J-4P
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:43:19 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:36515)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j13is-0004XI-UI; Mon, 10 Feb 2020 02:43:16 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.312127-0.0112549-0.676618;
 DS=CONTINUE|ham_system_inform|0.00587578-0.000252201-0.993872;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03296; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.GmNZEYU_1581320582; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GmNZEYU_1581320582)
 by smtp.aliyun-inc.com(10.147.41.158);
 Mon, 10 Feb 2020 15:43:03 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v3 1/5] target/riscv: add vector unit stride load and store
 instructions
Date: Mon, 10 Feb 2020 15:42:52 +0800
Message-Id: <20200210074256.11412-2-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200210074256.11412-1-zhiwei_liu@c-sky.com>
References: <20200210074256.11412-1-zhiwei_liu@c-sky.com>
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com, LIU Zhiwei <zhiwei_liu@c-sky.com>
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
 target/riscv/insn_trans/trans_rvv.inc.c | 294 ++++++++++++++++
 target/riscv/translate.c                |   2 +
 target/riscv/vector_helper.c            | 438 ++++++++++++++++++++++++
 5 files changed, 821 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 3c28c7e407..74c483ef9e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -78,3 +78,73 @@ DEF_HELPER_1(tlb_flush, void, env)
 #endif
 /* Vector functions */
 DEF_HELPER_3(vsetvl, tl, env, tl, tl)
+DEF_HELPER_5(vlb_v_b, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlb_v_b_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlb_v_h, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlb_v_h_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlb_v_w, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlb_v_w_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlb_v_d, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlb_v_d_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlh_v_h, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlh_v_h_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlh_v_w, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlh_v_w_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlh_v_d, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlh_v_d_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlw_v_w, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlw_v_w_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlw_v_d, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlw_v_d_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vle_v_b, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vle_v_b_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vle_v_h, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vle_v_h_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vle_v_w, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vle_v_w_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vle_v_d, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vle_v_d_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlbu_v_b, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlbu_v_b_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlbu_v_h, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlbu_v_h_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlbu_v_w, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlbu_v_w_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlbu_v_d, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlbu_v_d_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlhu_v_h, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlhu_v_h_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlhu_v_w, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlhu_v_w_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlhu_v_d, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlhu_v_d_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlwu_v_w, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlwu_v_w_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlwu_v_d, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlwu_v_d_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsb_v_b, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsb_v_b_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsb_v_h, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsb_v_h_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsb_v_w, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsb_v_w_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsb_v_d, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsb_v_d_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsh_v_h, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsh_v_h_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsh_v_w, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsh_v_w_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsh_v_d, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsh_v_d_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsw_v_w, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsw_v_w_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsw_v_d, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vsw_v_d_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vse_v_b, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vse_v_b_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vse_v_h, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vse_v_h_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vse_v_w, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vse_v_w_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vse_v_d, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vse_v_d_mask, void, ptr, tl, ptr, env, i32)
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
index da82c72bbf..d93eb00651 100644
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
@@ -67,3 +69,295 @@ static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli * a)
     tcg_temp_free(dst);
     return true;
 }
+
+/* define aidding fucntions */
+/* vector register offset from env */
+static uint32_t vreg_ofs(DisasContext *s, int reg)
+{
+    return offsetof(CPURISCVState, vext.vreg) + reg * s->vlen / 8;
+}
+
+/*
+ * As simd_desc supports at most 256 bytes, and in this implementation,
+ * the max vector group length is 2048 bytes. So split it into two parts.
+ *
+ * The first part is floor(maxsz, 64), encoded in maxsz of simd_desc.
+ * The second part is (maxsz % 64) >> 3, encoded in data of simd_desc.
+ */
+static uint32_t maxsz_part1(uint32_t maxsz)
+{
+    return ((maxsz & ~(0x3f)) >> 3) + 0x8; /* add offset 8 to avoid return 0 */
+}
+
+static uint32_t maxsz_part2(uint32_t maxsz)
+{
+    return (maxsz & 0x3f) >> 3;
+}
+
+/* define concrete check functions */
+static bool vext_check_vill(bool vill)
+{
+    if (vill) {
+        return false;
+    }
+    return true;
+}
+
+static bool vext_check_reg(uint32_t lmul, uint32_t reg, bool widen)
+{
+    int legal = widen ? (lmul * 2) : lmul;
+
+    if ((lmul != 1 && lmul != 2 && lmul != 4 && lmul != 8) ||
+        (lmul == 8 && widen)) {
+        return false;
+    }
+
+    if (reg % legal != 0) {
+        return false;
+    }
+    return true;
+}
+
+static bool vext_check_overlap_mask(uint32_t lmul, uint32_t vd, bool vm)
+{
+    if (lmul > 1 && vm == 0 && vd == 0) {
+        return false;
+    }
+    return true;
+}
+
+static bool vext_check_nf(uint32_t lmul, uint32_t nf)
+{
+    if (lmul * (nf + 1) > 8) {
+        return false;
+    }
+    return true;
+}
+
+/* define check conditions data structure */
+struct vext_check_ctx {
+
+    struct vext_reg {
+        uint8_t reg;
+        bool widen;
+        bool need_check;
+    } check_reg[6];
+
+    struct vext_overlap_mask {
+        uint8_t reg;
+        uint8_t vm;
+        bool need_check;
+    } check_overlap_mask;
+
+    struct vext_nf {
+        uint8_t nf;
+        bool need_check;
+    } check_nf;
+    target_ulong check_misa;
+
+} vchkctx;
+
+/* define general function */
+static bool vext_check(DisasContext *s)
+{
+    int i;
+    bool ret;
+
+    /* check ISA extend */
+    ret = ((s->misa & vchkctx.check_misa) == vchkctx.check_misa);
+    if (!ret) {
+        return false;
+    }
+    /* check vill */
+    ret = vext_check_vill(s->vill);
+    if (!ret) {
+        return false;
+    }
+    /* check register number is legal */
+    for (i = 0; i < 6; i++) {
+        if (vchkctx.check_reg[i].need_check) {
+            ret = vext_check_reg((1 << s->lmul), vchkctx.check_reg[i].reg,
+                    vchkctx.check_reg[i].widen);
+            if (!ret) {
+                return false;
+            }
+        }
+    }
+    /* check if mask register will be overlapped */
+    if (vchkctx.check_overlap_mask.need_check) {
+        ret = vext_check_overlap_mask((1 << s->lmul),
+                vchkctx.check_overlap_mask.reg, vchkctx.check_overlap_mask.vm);
+        if (!ret) {
+            return false;
+        }
+
+    }
+    /* check nf for Zvlsseg */
+    if (vchkctx.check_nf.need_check) {
+        ret = vext_check_nf((1 << s->lmul), vchkctx.check_nf.nf);
+        if (!ret) {
+            return false;
+        }
+
+    }
+    return true;
+}
+
+/* unit stride load and store */
+typedef void gen_helper_vext_ldst_us(TCGv_ptr, TCGv, TCGv_ptr,
+        TCGv_env, TCGv_i32);
+
+static bool do_vext_ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
+        gen_helper_vext_ldst_us *fn, DisasContext *s)
+{
+    TCGv_ptr dest, mask;
+    TCGv base;
+    TCGv_i32 desc;
+
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    base = tcg_temp_new();
+    desc = tcg_const_i32(simd_desc(0, maxsz_part1(s->maxsz), data));
+
+    gen_get_gpr(base, rs1);
+    tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
+
+    fn(dest, base, mask, cpu_env, desc);
+
+    tcg_temp_free_ptr(dest);
+    tcg_temp_free_ptr(mask);
+    tcg_temp_free(base);
+    tcg_temp_free_i32(desc);
+    return true;
+}
+
+static bool vext_ld_us_trans(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
+{
+    uint8_t nf = a->nf + 1;
+    uint32_t data = s->mlen | (a->vm << 8) | (maxsz_part2(s->maxsz) << 9)
+        | (nf << 12);
+    gen_helper_vext_ldst_us *fn;
+    static gen_helper_vext_ldst_us * const fns[2][7][4] = {
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
+    return do_vext_ldst_us_trans(a->rd, a->rs1, data, fn, s);
+}
+
+#define GEN_VEXT_LD_US_TRANS(NAME, DO_OP, SEQ)                            \
+static bool trans_##NAME(DisasContext *s, arg_r2nfvm* a)                  \
+{                                                                         \
+    vchkctx.check_misa = RVV;                                             \
+    vchkctx.check_overlap_mask.need_check = true;                         \
+    vchkctx.check_overlap_mask.reg = a->rd;                               \
+    vchkctx.check_overlap_mask.vm = a->vm;                                \
+    vchkctx.check_reg[0].need_check = true;                               \
+    vchkctx.check_reg[0].reg = a->rd;                                     \
+    vchkctx.check_reg[0].widen = false;                                   \
+    vchkctx.check_nf.need_check = true;                                   \
+    vchkctx.check_nf.nf = a->nf;                                          \
+                                                                          \
+    if (!vext_check(s)) {                                                 \
+        return false;                                                     \
+    }                                                                     \
+    return DO_OP(s, a, SEQ);                                              \
+}
+
+GEN_VEXT_LD_US_TRANS(vlb_v, vext_ld_us_trans, 0)
+GEN_VEXT_LD_US_TRANS(vlh_v, vext_ld_us_trans, 1)
+GEN_VEXT_LD_US_TRANS(vlw_v, vext_ld_us_trans, 2)
+GEN_VEXT_LD_US_TRANS(vle_v, vext_ld_us_trans, 3)
+GEN_VEXT_LD_US_TRANS(vlbu_v, vext_ld_us_trans, 4)
+GEN_VEXT_LD_US_TRANS(vlhu_v, vext_ld_us_trans, 5)
+GEN_VEXT_LD_US_TRANS(vlwu_v, vext_ld_us_trans, 6)
+
+static bool vext_st_us_trans(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
+{
+    uint8_t nf = a->nf + 1;
+    uint32_t data = s->mlen | (a->vm << 8) | (maxsz_part2(s->maxsz) << 9)
+        | (nf << 12);
+    gen_helper_vext_ldst_us *fn;
+    static gen_helper_vext_ldst_us * const fns[2][4][4] = {
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
+    return do_vext_ldst_us_trans(a->rd, a->rs1, data, fn, s);
+}
+
+#define GEN_VEXT_ST_US_TRANS(NAME, DO_OP, SEQ)                            \
+static bool trans_##NAME(DisasContext *s, arg_r2nfvm* a)                  \
+{                                                                         \
+    vchkctx.check_misa = RVV;                                             \
+    vchkctx.check_reg[0].need_check = true;                               \
+    vchkctx.check_reg[0].reg = a->rd;                                     \
+    vchkctx.check_reg[0].widen = false;                                   \
+    vchkctx.check_nf.need_check = true;                                   \
+    vchkctx.check_nf.nf = a->nf;                                          \
+                                                                          \
+    if (!vext_check(s)) {                                                 \
+        return false;                                                     \
+    }                                                                     \
+    return DO_OP(s, a, SEQ);                                              \
+}
+
+GEN_VEXT_ST_US_TRANS(vsb_v, vext_st_us_trans, 0)
+GEN_VEXT_ST_US_TRANS(vsh_v, vext_st_us_trans, 1)
+GEN_VEXT_ST_US_TRANS(vsw_v, vext_st_us_trans, 2)
+GEN_VEXT_ST_US_TRANS(vse_v, vext_st_us_trans, 3)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index cc356aabd8..7eaaf172cf 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -60,6 +60,8 @@ typedef struct DisasContext {
     uint8_t lmul;
     uint8_t sew;
     uint16_t vlen;
+    uint32_t maxsz;
+    uint16_t mlen;
     bool vl_eq_vlmax;
 } DisasContext;
 
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index e0f2415345..406fcd1dfe 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -20,6 +20,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "tcg/tcg-gvec-desc.h"
 #include <math.h>
 
 target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
@@ -47,3 +48,440 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     env->vext.vstart = 0;
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
+#ifdef CONFIG_USER_ONLY
+#define MO_SB 0
+#define MO_LESW 0
+#define MO_LESL 0
+#define MO_LEQ 0
+#define MO_UB 0
+#define MO_LEUW 0
+#define MO_LEUL 0
+#endif
+
+static inline int vext_elem_mask(void *v0, int mlen, int index)
+{
+    int idx = (index * mlen) / 8;
+    int pos = (index * mlen) % 8;
+
+    return (*((uint8_t *)v0 + idx) >> pos) & 0x1;
+}
+
+static uint32_t vext_nf(uint32_t desc)
+{
+    return (simd_data(desc) >> 12) & 0xf;
+}
+
+static uint32_t vext_mlen(uint32_t desc)
+{
+    return simd_data(desc) & 0xff;
+}
+
+static uint32_t vext_vm(uint32_t desc)
+{
+    return (simd_data(desc) >> 8) & 0x1;
+}
+
+/*
+ * Get vector group length [64, 2048] in bytes. Its range is [64, 2048].
+ *
+ * As simd_desc support at most 256 bytes, split it into two parts.
+ * The first part is floor(maxsz, 64), encoded in maxsz of simd_desc.
+ * The second part is (maxsz % 64) >> 3, encoded in data of simd_desc.
+ */
+static uint32_t vext_maxsz(uint32_t desc)
+{
+    return (simd_maxsz(desc) - 0x8) * 8 + ((simd_data(desc) >> 9) & 0x7) * 8;
+}
+
+/*
+ * This function checks watchpoint before really load operation.
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
+/* common structure for all vector instructions */
+struct vext_common_ctx {
+    uint32_t vlmax;
+    uint32_t mlen;
+    uint32_t vl;
+    uint32_t msz;
+    uint32_t esz;
+    uint32_t vm;
+};
+
+static void vext_common_ctx_init(struct vext_common_ctx *ctx, uint32_t esz,
+        uint32_t msz, uint32_t vl, uint32_t desc)
+{
+    ctx->vlmax = vext_maxsz(desc) / esz;
+    ctx->mlen = vext_mlen(desc);
+    ctx->vm = vext_vm(desc);
+    ctx->vl = vl;
+    ctx->msz = msz;
+    ctx->esz = esz;
+}
+
+/* data structure and common functions for load and store */
+typedef void vext_ld_elem_fn(CPURISCVState *env, target_ulong addr,
+        uint32_t idx, void *vd, uintptr_t retaddr);
+typedef void vext_st_elem_fn(CPURISCVState *env, target_ulong addr,
+        uint32_t idx, void *vd, uintptr_t retaddr);
+typedef target_ulong vext_get_index_addr(target_ulong base,
+        uint32_t idx, void *vs2);
+typedef void vext_ld_clear_elem(void *vd, uint32_t idx,
+        uint32_t cnt, uint32_t tot);
+
+struct vext_ldst_ctx {
+    struct vext_common_ctx vcc;
+    uint32_t nf;
+    target_ulong base;
+    target_ulong stride;
+    int mmuidx;
+
+    vext_ld_elem_fn *ld_elem;
+    vext_st_elem_fn *st_elem;
+    vext_get_index_addr *get_index_addr;
+    vext_ld_clear_elem *clear_elem;
+};
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
+/* unit-stride: load vector element from continuous guest memory */
+static void vext_ld_unit_stride_mask(void *vd, void *v0, CPURISCVState *env,
+        struct vext_ldst_ctx *ctx, uintptr_t ra)
+{
+    uint32_t i, k;
+    struct vext_common_ctx *s = &ctx->vcc;
+
+    if (s->vl == 0) {
+        return;
+    }
+    /* probe every access*/
+    for (i = 0; i < s->vl; i++) {
+        if (!s->vm && !vext_elem_mask(v0, s->mlen, i)) {
+            continue;
+        }
+        probe_read_access(env, ctx->base + ctx->nf * i * s->msz,
+                ctx->nf * s->msz, ra);
+    }
+    /* load bytes from guest memory */
+    for (i = 0; i < s->vl; i++) {
+        k = 0;
+        if (!s->vm && !vext_elem_mask(v0, s->mlen, i)) {
+            continue;
+        }
+        while (k < ctx->nf) {
+            target_ulong addr = ctx->base + (i * ctx->nf + k) * s->msz;
+            ctx->ld_elem(env, addr, i + k * s->vlmax, vd, ra);
+            k++;
+        }
+    }
+    /* clear tail elements */
+    for (k = 0; k < ctx->nf; k++) {
+        ctx->clear_elem(vd, s->vl + k * s->vlmax, s->vl * s->esz,
+                s->vlmax * s->esz);
+    }
+}
+
+static void vext_ld_unit_stride(void *vd, void *v0, CPURISCVState *env,
+        struct vext_ldst_ctx *ctx, uintptr_t ra)
+{
+    uint32_t i, k;
+    struct vext_common_ctx *s = &ctx->vcc;
+
+    if (s->vl == 0) {
+        return;
+    }
+    /* probe every access*/
+    probe_read_access(env, ctx->base, s->vl * ctx->nf * s->msz, ra);
+    /* load bytes from guest memory */
+    for (i = 0; i < s->vl; i++) {
+        k = 0;
+        while (k < ctx->nf) {
+            target_ulong addr = ctx->base + (i * ctx->nf + k) * s->msz;
+            ctx->ld_elem(env, addr, i + k * s->vlmax, vd, ra);
+            k++;
+        }
+    }
+    /* clear tail elements */
+    for (k = 0; k < ctx->nf; k++) {
+        ctx->clear_elem(vd, s->vl + k * s->vlmax, s->vl * s->esz,
+                s->vlmax * s->esz);
+    }
+}
+
+#define GEN_VEXT_LD_UNIT_STRIDE(NAME, MTYPE, ETYPE)                \
+void HELPER(NAME##_mask)(void *vd, target_ulong base, void *v0,    \
+        CPURISCVState *env, uint32_t desc)                         \
+{                                                                  \
+    static struct vext_ldst_ctx ctx;                               \
+    vext_common_ctx_init(&ctx.vcc, sizeof(ETYPE),                  \
+        sizeof(MTYPE), env->vext.vl, desc);                        \
+    ctx.nf = vext_nf(desc);                                        \
+    ctx.base = base;                                               \
+    ctx.ld_elem = vext_##NAME##_ld_elem;                           \
+    ctx.clear_elem = vext_##NAME##_clear_elem;                     \
+                                                                   \
+    vext_ld_unit_stride_mask(vd, v0, env, &ctx, GETPC());          \
+}                                                                  \
+                                                                   \
+void HELPER(NAME)(void *vd, target_ulong base, void *v0,           \
+        CPURISCVState *env, uint32_t desc)                         \
+{                                                                  \
+    static struct vext_ldst_ctx ctx;                               \
+    vext_common_ctx_init(&ctx.vcc, sizeof(ETYPE),                  \
+        sizeof(MTYPE), env->vext.vl, desc);                        \
+    ctx.nf = vext_nf(desc);                                        \
+    ctx.base = base;                                               \
+    ctx.ld_elem = vext_##NAME##_ld_elem;                           \
+    ctx.clear_elem = vext_##NAME##_clear_elem;                     \
+                                                                   \
+    vext_ld_unit_stride(vd, v0, env, &ctx, GETPC());               \
+}
+
+GEN_VEXT_LD_UNIT_STRIDE(vlb_v_b, int8_t,  int8_t)
+GEN_VEXT_LD_UNIT_STRIDE(vlb_v_h, int8_t,  int16_t)
+GEN_VEXT_LD_UNIT_STRIDE(vlb_v_w, int8_t,  int32_t)
+GEN_VEXT_LD_UNIT_STRIDE(vlb_v_d, int8_t,  int64_t)
+GEN_VEXT_LD_UNIT_STRIDE(vlh_v_h, int16_t, int16_t)
+GEN_VEXT_LD_UNIT_STRIDE(vlh_v_w, int16_t, int32_t)
+GEN_VEXT_LD_UNIT_STRIDE(vlh_v_d, int16_t, int64_t)
+GEN_VEXT_LD_UNIT_STRIDE(vlw_v_w, int32_t, int32_t)
+GEN_VEXT_LD_UNIT_STRIDE(vlw_v_d, int32_t, int64_t)
+GEN_VEXT_LD_UNIT_STRIDE(vle_v_b, int8_t,  int8_t)
+GEN_VEXT_LD_UNIT_STRIDE(vle_v_h, int16_t, int16_t)
+GEN_VEXT_LD_UNIT_STRIDE(vle_v_w, int32_t, int32_t)
+GEN_VEXT_LD_UNIT_STRIDE(vle_v_d, int64_t, int64_t)
+GEN_VEXT_LD_UNIT_STRIDE(vlbu_v_b, uint8_t,  uint8_t)
+GEN_VEXT_LD_UNIT_STRIDE(vlbu_v_h, uint8_t,  uint16_t)
+GEN_VEXT_LD_UNIT_STRIDE(vlbu_v_w, uint8_t,  uint32_t)
+GEN_VEXT_LD_UNIT_STRIDE(vlbu_v_d, uint8_t,  uint64_t)
+GEN_VEXT_LD_UNIT_STRIDE(vlhu_v_h, uint16_t, uint16_t)
+GEN_VEXT_LD_UNIT_STRIDE(vlhu_v_w, uint16_t, uint32_t)
+GEN_VEXT_LD_UNIT_STRIDE(vlhu_v_d, uint16_t, uint64_t)
+GEN_VEXT_LD_UNIT_STRIDE(vlwu_v_w, uint32_t, uint32_t)
+GEN_VEXT_LD_UNIT_STRIDE(vlwu_v_d, uint32_t, uint64_t)
+
+/* unit-stride: store vector element to guest memory */
+static void vext_st_unit_stride_mask(void *vd, void *v0, CPURISCVState *env,
+        struct vext_ldst_ctx *ctx, uintptr_t ra)
+{
+    uint32_t i, k;
+    struct vext_common_ctx *s = &ctx->vcc;
+
+    /* probe every access*/
+    for (i = 0; i < s->vl; i++) {
+        if (!s->vm && !vext_elem_mask(v0, s->mlen, i)) {
+            continue;
+        }
+        probe_write_access(env, ctx->base + ctx->nf * i * s->msz,
+                ctx->nf * s->msz, ra);
+    }
+    /* store bytes to guest memory */
+    for (i = 0; i < s->vl; i++) {
+        k = 0;
+        if (!s->vm && !vext_elem_mask(v0, s->mlen, i)) {
+            continue;
+        }
+        while (k < ctx->nf) {
+            target_ulong addr = ctx->base + (i * ctx->nf + k) * s->msz;
+            ctx->st_elem(env, addr, i + k * s->vlmax, vd, ra);
+            k++;
+        }
+    }
+}
+
+static void vext_st_unit_stride(void *vd, void *v0, CPURISCVState *env,
+        struct vext_ldst_ctx *ctx, uintptr_t ra)
+{
+    uint32_t i, k;
+    struct vext_common_ctx *s = &ctx->vcc;
+
+    /* probe every access*/
+    probe_write_access(env, ctx->base, s->vl * ctx->nf * s->msz, ra);
+    /* load bytes from guest memory */
+    for (i = 0; i < s->vl; i++) {
+        k = 0;
+        while (k < ctx->nf) {
+            target_ulong addr = ctx->base + (i * ctx->nf + k) * s->msz;
+            ctx->st_elem(env, addr, i + k * s->vlmax, vd, ra);
+            k++;
+        }
+    }
+}
+
+#define GEN_VEXT_ST_UNIT_STRIDE(NAME, MTYPE, ETYPE)                \
+void HELPER(NAME##_mask)(void *vd, target_ulong base, void *v0,    \
+        CPURISCVState *env, uint32_t desc)                         \
+{                                                                  \
+    static struct vext_ldst_ctx ctx;                               \
+    vext_common_ctx_init(&ctx.vcc, sizeof(ETYPE),                  \
+        sizeof(MTYPE), env->vext.vl, desc);                        \
+    ctx.nf = vext_nf(desc);                                        \
+    ctx.base = base;                                               \
+    ctx.st_elem = vext_##NAME##_st_elem;                           \
+                                                                   \
+    vext_st_unit_stride_mask(vd, v0, env, &ctx, GETPC());          \
+}                                                                  \
+                                                                   \
+void HELPER(NAME)(void *vd, target_ulong base, void *v0,           \
+        CPURISCVState *env, uint32_t desc)                         \
+{                                                                  \
+    static struct vext_ldst_ctx ctx;                               \
+    vext_common_ctx_init(&ctx.vcc, sizeof(ETYPE),                  \
+        sizeof(MTYPE), env->vext.vl, desc);                        \
+    ctx.nf = vext_nf(desc);                                        \
+    ctx.base = base;                                               \
+    ctx.st_elem = vext_##NAME##_st_elem;                           \
+                                                                   \
+    vext_st_unit_stride(vd, v0, env, &ctx, GETPC());               \
+}
+
+GEN_VEXT_ST_UNIT_STRIDE(vsb_v_b, int8_t,  int8_t)
+GEN_VEXT_ST_UNIT_STRIDE(vsb_v_h, int8_t,  int16_t)
+GEN_VEXT_ST_UNIT_STRIDE(vsb_v_w, int8_t,  int32_t)
+GEN_VEXT_ST_UNIT_STRIDE(vsb_v_d, int8_t,  int64_t)
+GEN_VEXT_ST_UNIT_STRIDE(vsh_v_h, int16_t, int16_t)
+GEN_VEXT_ST_UNIT_STRIDE(vsh_v_w, int16_t, int32_t)
+GEN_VEXT_ST_UNIT_STRIDE(vsh_v_d, int16_t, int64_t)
+GEN_VEXT_ST_UNIT_STRIDE(vsw_v_w, int32_t, int32_t)
+GEN_VEXT_ST_UNIT_STRIDE(vsw_v_d, int32_t, int64_t)
+GEN_VEXT_ST_UNIT_STRIDE(vse_v_b, int8_t,  int8_t)
+GEN_VEXT_ST_UNIT_STRIDE(vse_v_h, int16_t, int16_t)
+GEN_VEXT_ST_UNIT_STRIDE(vse_v_w, int32_t, int32_t)
+GEN_VEXT_ST_UNIT_STRIDE(vse_v_d, int64_t, int64_t)
-- 
2.23.0


