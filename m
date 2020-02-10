Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDF2C3F68F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 07:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71AC2214DB
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 07:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AC2214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j13lt-0007vD-Jj
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 02:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j13iw-0002qu-CR
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j13iu-00056E-3u
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:43:18 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39724)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j13is-0004Xq-Ur; Mon, 10 Feb 2020 02:43:16 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.521027-0.0251501-0.453823;
 DS=CONTINUE|ham_system_inform|0.00537779-0.000314533-0.994308;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03294; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.GmNZEYU_1581320582; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GmNZEYU_1581320582)
 by smtp.aliyun-inc.com(10.147.41.158);
 Mon, 10 Feb 2020 15:43:04 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v3 2/5] target/riscv: add vector stride load and store
 instructions
Date: Mon, 10 Feb 2020 15:42:53 +0800
Message-Id: <20200210074256.11412-3-zhiwei_liu@c-sky.com>
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

Vector strided operations access the first memory element at the base address,
and then access subsequent elements at address increments given by the byte
offset contained in the x register specified by rs2.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/helper.h                   |  35 +++++
 target/riscv/insn32.decode              |  14 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 138 +++++++++++++++++++
 target/riscv/vector_helper.c            | 169 ++++++++++++++++++++++++
 4 files changed, 356 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 74c483ef9e..19c1bfc317 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -148,3 +148,38 @@ DEF_HELPER_5(vse_v_w, void, ptr, tl, ptr, env, i32)
 DEF_HELPER_5(vse_v_w_mask, void, ptr, tl, ptr, env, i32)
 DEF_HELPER_5(vse_v_d, void, ptr, tl, ptr, env, i32)
 DEF_HELPER_5(vse_v_d_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlsb_v_b_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlsb_v_h_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlsb_v_w_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlsb_v_d_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlsh_v_h_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlsh_v_w_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlsh_v_d_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlsw_v_w_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlsw_v_d_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlse_v_b_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlse_v_h_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlse_v_w_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlse_v_d_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlsbu_v_b_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlsbu_v_h_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlsbu_v_w_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlsbu_v_d_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlshu_v_h_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlshu_v_w_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlshu_v_d_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlswu_v_w_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vlswu_v_d_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vssb_v_b_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vssb_v_h_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vssb_v_w_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vssb_v_d_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vssh_v_h_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vssh_v_w_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vssh_v_d_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vssw_v_w_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vssw_v_d_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vsse_v_b_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vsse_v_h_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vsse_v_w_mask, void, ptr, tl, tl, ptr, env, i32)
+DEF_HELPER_6(vsse_v_d_mask, void, ptr, tl, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index dad3ed91c7..2f2d3d13b3 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -44,6 +44,7 @@
 &shift     shamt rs1 rd
 &atomic    aq rl rs2 rs1 rd
 &r2nfvm    vm rd rs1 nf
+&rnfvm     vm rd rs1 rs2 nf
 
 # Formats 32:
 @r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
@@ -64,6 +65,7 @@
 @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
 @r2_nfvm nf:3 ... vm:1 ..... ..... ... ..... ....... &r2nfvm %rs1 %rd
+@r_nfvm  nf:3 ... vm:1 ..... ..... ... ..... ....... &rnfvm %rs2 %rs1 %rd
 @r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
 
 @sfence_vma ....... ..... .....   ... ..... ....... %rs2 %rs1
@@ -222,6 +224,18 @@ vsh_v      ... 000 . 00000 ..... 101 ..... 0100111 @r2_nfvm
 vsw_v      ... 000 . 00000 ..... 110 ..... 0100111 @r2_nfvm
 vse_v      ... 000 . 00000 ..... 111 ..... 0100111 @r2_nfvm
 
+vlsb_v     ... 110 . ..... ..... 000 ..... 0000111 @r_nfvm
+vlsh_v     ... 110 . ..... ..... 101 ..... 0000111 @r_nfvm
+vlsw_v     ... 110 . ..... ..... 110 ..... 0000111 @r_nfvm
+vlse_v     ... 010 . ..... ..... 111 ..... 0000111 @r_nfvm
+vlsbu_v    ... 010 . ..... ..... 000 ..... 0000111 @r_nfvm
+vlshu_v    ... 010 . ..... ..... 101 ..... 0000111 @r_nfvm
+vlswu_v    ... 010 . ..... ..... 110 ..... 0000111 @r_nfvm
+vssb_v     ... 010 . ..... ..... 000 ..... 0100111 @r_nfvm
+vssh_v     ... 010 . ..... ..... 101 ..... 0100111 @r_nfvm
+vssw_v     ... 010 . ..... ..... 110 ..... 0100111 @r_nfvm
+vsse_v     ... 010 . ..... ..... 111 ..... 0100111 @r_nfvm
+
 # *** new major opcode OP-V ***
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index d93eb00651..5a7ea94c2d 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -361,3 +361,141 @@ GEN_VEXT_ST_US_TRANS(vsb_v, vext_st_us_trans, 0)
 GEN_VEXT_ST_US_TRANS(vsh_v, vext_st_us_trans, 1)
 GEN_VEXT_ST_US_TRANS(vsw_v, vext_st_us_trans, 2)
 GEN_VEXT_ST_US_TRANS(vse_v, vext_st_us_trans, 3)
+
+/* stride load and store */
+typedef void gen_helper_vext_ldst_stride(TCGv_ptr, TCGv, TCGv,
+        TCGv_ptr, TCGv_env, TCGv_i32);
+
+static bool do_vext_ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
+        uint32_t data, gen_helper_vext_ldst_stride *fn, DisasContext *s)
+{
+    TCGv_ptr dest, mask;
+    TCGv base, stride;
+    TCGv_i32 desc;
+
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    base = tcg_temp_new();
+    stride = tcg_temp_new();
+    desc = tcg_const_i32(simd_desc(0, maxsz_part1(s->maxsz), data));
+
+    gen_get_gpr(base, rs1);
+    gen_get_gpr(stride, rs2);
+    tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
+
+    fn(dest, base, stride, mask, cpu_env, desc);
+
+    tcg_temp_free_ptr(dest);
+    tcg_temp_free_ptr(mask);
+    tcg_temp_free(base);
+    tcg_temp_free(stride);
+    tcg_temp_free_i32(desc);
+    return true;
+}
+
+static bool vext_ld_stride_trans(DisasContext *s, arg_rnfvm *a, uint8_t seq)
+{
+    uint8_t nf = a->nf + 1;
+    uint32_t data = s->mlen | (a->vm << 8) | (maxsz_part2(s->maxsz) << 9)
+        | (nf << 12);
+    gen_helper_vext_ldst_stride *fn;
+    static gen_helper_vext_ldst_stride * const fns[7][4] = {
+        /* masked stride load */
+        { gen_helper_vlsb_v_b_mask,  gen_helper_vlsb_v_h_mask,
+          gen_helper_vlsb_v_w_mask,  gen_helper_vlsb_v_d_mask },
+        { NULL,                      gen_helper_vlsh_v_h_mask,
+          gen_helper_vlsh_v_w_mask,  gen_helper_vlsh_v_d_mask },
+        { NULL,                      NULL,
+          gen_helper_vlsw_v_w_mask,  gen_helper_vlsw_v_d_mask },
+        { gen_helper_vlse_v_b_mask,  gen_helper_vlse_v_h_mask,
+          gen_helper_vlse_v_w_mask,  gen_helper_vlse_v_d_mask },
+        { gen_helper_vlsbu_v_b_mask, gen_helper_vlsbu_v_h_mask,
+          gen_helper_vlsbu_v_w_mask, gen_helper_vlsbu_v_d_mask },
+        { NULL,                      gen_helper_vlshu_v_h_mask,
+          gen_helper_vlshu_v_w_mask, gen_helper_vlshu_v_d_mask },
+        { NULL,                      NULL,
+          gen_helper_vlswu_v_w_mask, gen_helper_vlswu_v_d_mask },
+    };
+
+    fn =  fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    return do_vext_ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+}
+
+#define GEN_VEXT_LD_STRIDE_TRANS(NAME, DO_OP, SEQ)           \
+static bool trans_##NAME(DisasContext *s, arg_rnfvm* a)      \
+{                                                            \
+    vchkctx.check_misa = RVV;                                \
+    vchkctx.check_overlap_mask.need_check = true;            \
+    vchkctx.check_overlap_mask.reg = a->rd;                  \
+    vchkctx.check_overlap_mask.vm = a->vm;                   \
+    vchkctx.check_reg[0].need_check = true;                  \
+    vchkctx.check_reg[0].reg = a->rd;                        \
+    vchkctx.check_reg[0].widen = false;                      \
+    vchkctx.check_nf.need_check = true;                      \
+    vchkctx.check_nf.nf = a->nf;                             \
+                                                             \
+    if (!vext_check(s)) {                                    \
+        return false;                                        \
+    }                                                        \
+    return DO_OP(s, a, SEQ);                                 \
+}
+
+GEN_VEXT_LD_STRIDE_TRANS(vlsb_v, vext_ld_stride_trans, 0)
+GEN_VEXT_LD_STRIDE_TRANS(vlsh_v, vext_ld_stride_trans, 1)
+GEN_VEXT_LD_STRIDE_TRANS(vlsw_v, vext_ld_stride_trans, 2)
+GEN_VEXT_LD_STRIDE_TRANS(vlse_v, vext_ld_stride_trans, 3)
+GEN_VEXT_LD_STRIDE_TRANS(vlsbu_v, vext_ld_stride_trans, 4)
+GEN_VEXT_LD_STRIDE_TRANS(vlshu_v, vext_ld_stride_trans, 5)
+GEN_VEXT_LD_STRIDE_TRANS(vlswu_v, vext_ld_stride_trans, 6)
+
+static bool vext_st_stride_trans(DisasContext *s, arg_rnfvm *a, uint8_t seq)
+{
+    uint8_t nf = a->nf + 1;
+    uint32_t data = s->mlen | (a->vm << 8) | (maxsz_part2(s->maxsz) << 9)
+        | (nf << 12);
+    gen_helper_vext_ldst_stride *fn;
+    static gen_helper_vext_ldst_stride * const fns[4][4] = {
+        /* masked stride store */
+        { gen_helper_vssb_v_b_mask,  gen_helper_vssb_v_h_mask,
+          gen_helper_vssb_v_w_mask,  gen_helper_vssb_v_d_mask },
+        { NULL,                      gen_helper_vssh_v_h_mask,
+          gen_helper_vssh_v_w_mask,  gen_helper_vssh_v_d_mask },
+        { NULL,                      NULL,
+          gen_helper_vssw_v_w_mask,  gen_helper_vssw_v_d_mask },
+        { gen_helper_vsse_v_b_mask,  gen_helper_vsse_v_h_mask,
+          gen_helper_vsse_v_w_mask,  gen_helper_vsse_v_d_mask }
+    };
+
+    fn =  fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    return do_vext_ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+}
+
+#define GEN_VEXT_ST_STRIDE_TRANS(NAME, DO_OP, SEQ)           \
+static bool trans_##NAME(DisasContext *s, arg_rnfvm* a)      \
+{                                                            \
+    vchkctx.check_misa = RVV;                                \
+    vchkctx.check_reg[0].need_check = true;                  \
+    vchkctx.check_reg[0].reg = a->rd;                        \
+    vchkctx.check_reg[0].widen = false;                      \
+    vchkctx.check_nf.need_check = true;                      \
+    vchkctx.check_nf.nf = a->nf;                             \
+                                                             \
+    if (!vext_check(s)) {                                    \
+        return false;                                        \
+    }                                                        \
+    return DO_OP(s, a, SEQ);                                 \
+}
+
+GEN_VEXT_ST_STRIDE_TRANS(vssb_v, vext_st_stride_trans, 0)
+GEN_VEXT_ST_STRIDE_TRANS(vssh_v, vext_st_stride_trans, 1)
+GEN_VEXT_ST_STRIDE_TRANS(vssw_v, vext_st_stride_trans, 2)
+GEN_VEXT_ST_STRIDE_TRANS(vsse_v, vext_st_stride_trans, 3)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 406fcd1dfe..345945d19c 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -257,6 +257,28 @@ GEN_VEXT_LD_ELEM(vlhu_v_w, uint16_t, uint32_t, H4, lduw)
 GEN_VEXT_LD_ELEM(vlhu_v_d, uint16_t, uint64_t, H8, lduw)
 GEN_VEXT_LD_ELEM(vlwu_v_w, uint32_t, uint32_t, H4, ldl)
 GEN_VEXT_LD_ELEM(vlwu_v_d, uint32_t, uint64_t, H8, ldl)
+GEN_VEXT_LD_ELEM(vlsb_v_b, int8_t,  int8_t,  H1, ldsb)
+GEN_VEXT_LD_ELEM(vlsb_v_h, int8_t,  int16_t, H2, ldsb)
+GEN_VEXT_LD_ELEM(vlsb_v_w, int8_t,  int32_t, H4, ldsb)
+GEN_VEXT_LD_ELEM(vlsb_v_d, int8_t,  int64_t, H8, ldsb)
+GEN_VEXT_LD_ELEM(vlsh_v_h, int16_t, int16_t, H2, ldsw)
+GEN_VEXT_LD_ELEM(vlsh_v_w, int16_t, int32_t, H4, ldsw)
+GEN_VEXT_LD_ELEM(vlsh_v_d, int16_t, int64_t, H8, ldsw)
+GEN_VEXT_LD_ELEM(vlsw_v_w, int32_t, int32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(vlsw_v_d, int32_t, int64_t, H8, ldl)
+GEN_VEXT_LD_ELEM(vlse_v_b, int8_t,  int8_t,  H1, ldsb)
+GEN_VEXT_LD_ELEM(vlse_v_h, int16_t, int16_t, H2, ldsw)
+GEN_VEXT_LD_ELEM(vlse_v_w, int32_t, int32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(vlse_v_d, int64_t, int64_t, H8, ldq)
+GEN_VEXT_LD_ELEM(vlsbu_v_b, uint8_t,  uint8_t,  H1, ldub)
+GEN_VEXT_LD_ELEM(vlsbu_v_h, uint8_t,  uint16_t, H2, ldub)
+GEN_VEXT_LD_ELEM(vlsbu_v_w, uint8_t,  uint32_t, H4, ldub)
+GEN_VEXT_LD_ELEM(vlsbu_v_d, uint8_t,  uint64_t, H8, ldub)
+GEN_VEXT_LD_ELEM(vlshu_v_h, uint16_t, uint16_t, H2, lduw)
+GEN_VEXT_LD_ELEM(vlshu_v_w, uint16_t, uint32_t, H4, lduw)
+GEN_VEXT_LD_ELEM(vlshu_v_d, uint16_t, uint64_t, H8, lduw)
+GEN_VEXT_LD_ELEM(vlswu_v_w, uint32_t, uint32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(vlswu_v_d, uint32_t, uint64_t, H8, ldl)
 
 #define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)                       \
 static void vext_##NAME##_st_elem(CPURISCVState *env, abi_ptr addr,   \
@@ -280,6 +302,19 @@ GEN_VEXT_ST_ELEM(vse_v_b, int8_t,  H1, stb)
 GEN_VEXT_ST_ELEM(vse_v_h, int16_t, H2, stw)
 GEN_VEXT_ST_ELEM(vse_v_w, int32_t, H4, stl)
 GEN_VEXT_ST_ELEM(vse_v_d, int64_t, H8, stq)
+GEN_VEXT_ST_ELEM(vssb_v_b, int8_t,  H1, stb)
+GEN_VEXT_ST_ELEM(vssb_v_h, int16_t, H2, stb)
+GEN_VEXT_ST_ELEM(vssb_v_w, int32_t, H4, stb)
+GEN_VEXT_ST_ELEM(vssb_v_d, int64_t, H8, stb)
+GEN_VEXT_ST_ELEM(vssh_v_h, int16_t, H2, stw)
+GEN_VEXT_ST_ELEM(vssh_v_w, int32_t, H4, stw)
+GEN_VEXT_ST_ELEM(vssh_v_d, int64_t, H8, stw)
+GEN_VEXT_ST_ELEM(vssw_v_w, int32_t, H4, stl)
+GEN_VEXT_ST_ELEM(vssw_v_d, int64_t, H8, stl)
+GEN_VEXT_ST_ELEM(vsse_v_b, int8_t,  H1, stb)
+GEN_VEXT_ST_ELEM(vsse_v_h, int16_t, H2, stw)
+GEN_VEXT_ST_ELEM(vsse_v_w, int32_t, H4, stl)
+GEN_VEXT_ST_ELEM(vsse_v_d, int64_t, H8, stq)
 
 /* unit-stride: load vector element from continuous guest memory */
 static void vext_ld_unit_stride_mask(void *vd, void *v0, CPURISCVState *env,
@@ -485,3 +520,137 @@ GEN_VEXT_ST_UNIT_STRIDE(vse_v_b, int8_t,  int8_t)
 GEN_VEXT_ST_UNIT_STRIDE(vse_v_h, int16_t, int16_t)
 GEN_VEXT_ST_UNIT_STRIDE(vse_v_w, int32_t, int32_t)
 GEN_VEXT_ST_UNIT_STRIDE(vse_v_d, int64_t, int64_t)
+
+/* stride: load strided vector element from guest memory */
+static void vext_ld_stride_mask(void *vd, void *v0, CPURISCVState *env,
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
+        probe_read_access(env, ctx->base + ctx->stride * i,
+                ctx->nf * s->msz, ra);
+    }
+    /* load bytes from guest memory */
+    for (i = 0; i < s->vl; i++) {
+        k = 0;
+        if (!s->vm && !vext_elem_mask(v0, s->mlen, i)) {
+            continue;
+        }
+        while (k < ctx->nf) {
+            target_ulong addr = ctx->base + ctx->stride * i + k * s->msz;
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
+#define GEN_VEXT_LD_STRIDE(NAME, MTYPE, ETYPE)                                 \
+void HELPER(NAME##_mask)(void *vd, target_ulong base, target_ulong stride,     \
+        void *v0, CPURISCVState *env, uint32_t desc)                           \
+{                                                                              \
+    static struct vext_ldst_ctx ctx;                                           \
+    vext_common_ctx_init(&ctx.vcc, sizeof(ETYPE),                              \
+        sizeof(MTYPE), env->vext.vl, desc);                                    \
+    ctx.nf = vext_nf(desc);                                                    \
+    ctx.base = base;                                                           \
+    ctx.stride = stride;                                                       \
+    ctx.ld_elem = vext_##NAME##_ld_elem;                                       \
+    ctx.clear_elem = vext_##NAME##_clear_elem;                                 \
+                                                                               \
+    vext_ld_stride_mask(vd, v0, env, &ctx, GETPC());                           \
+}
+
+GEN_VEXT_LD_STRIDE(vlsb_v_b, int8_t,  int8_t)
+GEN_VEXT_LD_STRIDE(vlsb_v_h, int8_t,  int16_t)
+GEN_VEXT_LD_STRIDE(vlsb_v_w, int8_t,  int32_t)
+GEN_VEXT_LD_STRIDE(vlsb_v_d, int8_t,  int64_t)
+GEN_VEXT_LD_STRIDE(vlsh_v_h, int16_t, int16_t)
+GEN_VEXT_LD_STRIDE(vlsh_v_w, int16_t, int32_t)
+GEN_VEXT_LD_STRIDE(vlsh_v_d, int16_t, int64_t)
+GEN_VEXT_LD_STRIDE(vlsw_v_w, int32_t, int32_t)
+GEN_VEXT_LD_STRIDE(vlsw_v_d, int32_t, int64_t)
+GEN_VEXT_LD_STRIDE(vlse_v_b, int8_t,  int8_t)
+GEN_VEXT_LD_STRIDE(vlse_v_h, int16_t, int16_t)
+GEN_VEXT_LD_STRIDE(vlse_v_w, int32_t, int32_t)
+GEN_VEXT_LD_STRIDE(vlse_v_d, int64_t, int64_t)
+GEN_VEXT_LD_STRIDE(vlsbu_v_b, uint8_t,  uint8_t)
+GEN_VEXT_LD_STRIDE(vlsbu_v_h, uint8_t,  uint16_t)
+GEN_VEXT_LD_STRIDE(vlsbu_v_w, uint8_t,  uint32_t)
+GEN_VEXT_LD_STRIDE(vlsbu_v_d, uint8_t,  uint64_t)
+GEN_VEXT_LD_STRIDE(vlshu_v_h, uint16_t, uint16_t)
+GEN_VEXT_LD_STRIDE(vlshu_v_w, uint16_t, uint32_t)
+GEN_VEXT_LD_STRIDE(vlshu_v_d, uint16_t, uint64_t)
+GEN_VEXT_LD_STRIDE(vlswu_v_w, uint32_t, uint32_t)
+GEN_VEXT_LD_STRIDE(vlswu_v_d, uint32_t, uint64_t)
+
+/* stride: store strided vector element to guest memory */
+static void vext_st_stride_mask(void *vd, void *v0, CPURISCVState *env,
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
+        probe_write_access(env, ctx->base + ctx->stride * i,
+                ctx->nf * s->msz, ra);
+    }
+    /* store bytes to guest memory */
+    for (i = 0; i < s->vl; i++) {
+        k = 0;
+        if (!s->vm && !vext_elem_mask(v0, s->mlen, i)) {
+            continue;
+        }
+        while (k < ctx->nf) {
+            target_ulong addr = ctx->base + ctx->stride * i + k * s->msz;
+            ctx->st_elem(env, addr, i + k * s->vlmax, vd, ra);
+            k++;
+        }
+    }
+}
+
+#define GEN_VEXT_ST_STRIDE(NAME, MTYPE, ETYPE)                                 \
+void HELPER(NAME##_mask)(void *vd, target_ulong base, target_ulong stride,     \
+        void *v0, CPURISCVState *env, uint32_t desc)                           \
+{                                                                              \
+    static struct vext_ldst_ctx ctx;                                           \
+    vext_common_ctx_init(&ctx.vcc, sizeof(ETYPE),                              \
+        sizeof(MTYPE), env->vext.vl, desc);                                    \
+    ctx.nf = vext_nf(desc);                                                    \
+    ctx.base = base;                                                           \
+    ctx.stride = stride;                                                       \
+    ctx.st_elem = vext_##NAME##_st_elem;                                       \
+                                                                               \
+    vext_st_stride_mask(vd, v0, env, &ctx, GETPC());                           \
+}
+
+GEN_VEXT_ST_STRIDE(vssb_v_b, int8_t,  int8_t)
+GEN_VEXT_ST_STRIDE(vssb_v_h, int8_t,  int16_t)
+GEN_VEXT_ST_STRIDE(vssb_v_w, int8_t,  int32_t)
+GEN_VEXT_ST_STRIDE(vssb_v_d, int8_t,  int64_t)
+GEN_VEXT_ST_STRIDE(vssh_v_h, int16_t, int16_t)
+GEN_VEXT_ST_STRIDE(vssh_v_w, int16_t, int32_t)
+GEN_VEXT_ST_STRIDE(vssh_v_d, int16_t, int64_t)
+GEN_VEXT_ST_STRIDE(vssw_v_w, int32_t, int32_t)
+GEN_VEXT_ST_STRIDE(vssw_v_d, int32_t, int64_t)
+GEN_VEXT_ST_STRIDE(vsse_v_b, int8_t,  int8_t)
+GEN_VEXT_ST_STRIDE(vsse_v_h, int16_t, int16_t)
+GEN_VEXT_ST_STRIDE(vsse_v_w, int32_t, int32_t)
+GEN_VEXT_ST_STRIDE(vsse_v_d, int64_t, int64_t)
-- 
2.23.0


