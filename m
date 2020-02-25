Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52BAC35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A70F20726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A70F20726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6XZg-00032h-Hl
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 05:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j6XYh-0001Ap-OF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j6XYd-0001Pj-V8
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:35:23 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:44720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j6XYd-0001Ns-A9; Tue, 25 Feb 2020 05:35:19 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.521027-0.0251501-0.453823;
 DS=CONTINUE|ham_system_inform|0.00396993-0.000209295-0.995821;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03311; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.GsFPuQz_1582626910; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GsFPuQz_1582626910)
 by smtp.aliyun-inc.com(10.147.40.44); Tue, 25 Feb 2020 18:35:12 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v4 2/5] target/riscv: add vector stride load and store
 instructions
Date: Tue, 25 Feb 2020 18:35:05 +0800
Message-Id: <20200225103508.7651-3-zhiwei_liu@c-sky.com>
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

Vector strided operations access the first memory element at the base address,
and then access subsequent elements at address increments given by the byte
offset contained in the x register specified by rs2.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/helper.h                   |  35 +++++
 target/riscv/insn32.decode              |  14 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 117 +++++++++++++++++
 target/riscv/vector_helper.c            | 166 ++++++++++++++++++++++++
 4 files changed, 332 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 996639c0fa..87dfa90609 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -148,3 +148,38 @@ DEF_HELPER_5(vse_v_w, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vse_v_w_mask, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vse_v_d, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vse_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_6(vlsb_v_b, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsb_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsb_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsb_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsh_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsh_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsh_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsw_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsw_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlse_v_b, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlse_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlse_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlse_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsbu_v_b, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsbu_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsbu_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsbu_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlshu_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlshu_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlshu_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlswu_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlswu_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssb_v_b, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssb_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssb_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssb_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssh_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssh_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssh_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssw_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssw_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vsse_v_b, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vsse_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vsse_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vsse_v_d, void, ptr, ptr, tl, tl, env, i32)
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
index b0e97e7e06..1b627dc880 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -255,3 +255,120 @@ GEN_VEXT_TRANS(vsb_v, 0, r2nfvm, st_us_op, st_us_check)
 GEN_VEXT_TRANS(vsh_v, 1, r2nfvm, st_us_op, st_us_check)
 GEN_VEXT_TRANS(vsw_v, 2, r2nfvm, st_us_op, st_us_check)
 GEN_VEXT_TRANS(vse_v, 3, r2nfvm, st_us_op, st_us_check)
+
+/*
+ *** stride load and store
+ */
+typedef void gen_helper_ldst_stride(TCGv_ptr, TCGv_ptr, TCGv,
+        TCGv, TCGv_env, TCGv_i32);
+
+static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
+        uint32_t data, gen_helper_ldst_stride *fn, DisasContext *s)
+{
+    TCGv_ptr dest, mask;
+    TCGv base, stride;
+    TCGv_i32 desc;
+
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    base = tcg_temp_new();
+    stride = tcg_temp_new();
+    desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+
+    gen_get_gpr(base, rs1);
+    gen_get_gpr(stride, rs2);
+    tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
+
+    fn(dest, mask, base, stride, cpu_env, desc);
+
+    tcg_temp_free_ptr(dest);
+    tcg_temp_free_ptr(mask);
+    tcg_temp_free(base);
+    tcg_temp_free(stride);
+    tcg_temp_free_i32(desc);
+    return true;
+}
+
+static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
+{
+    uint8_t nf = a->nf + 1;
+    uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9) | (nf << 11);
+    gen_helper_ldst_stride *fn;
+    static gen_helper_ldst_stride * const fns[7][4] = {
+        { gen_helper_vlsb_v_b,  gen_helper_vlsb_v_h,
+          gen_helper_vlsb_v_w,  gen_helper_vlsb_v_d },
+        { NULL,                 gen_helper_vlsh_v_h,
+          gen_helper_vlsh_v_w,  gen_helper_vlsh_v_d },
+        { NULL,                 NULL,
+          gen_helper_vlsw_v_w,  gen_helper_vlsw_v_d },
+        { gen_helper_vlse_v_b,  gen_helper_vlse_v_h,
+          gen_helper_vlse_v_w,  gen_helper_vlse_v_d },
+        { gen_helper_vlsbu_v_b, gen_helper_vlsbu_v_h,
+          gen_helper_vlsbu_v_w, gen_helper_vlsbu_v_d },
+        { NULL,                 gen_helper_vlshu_v_h,
+          gen_helper_vlshu_v_w, gen_helper_vlshu_v_d },
+        { NULL,                 NULL,
+          gen_helper_vlswu_v_w, gen_helper_vlswu_v_d },
+    };
+
+    fn =  fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+}
+
+static bool ld_stride_check(DisasContext *s, arg_rnfvm* a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_nf(s, a->nf));
+}
+
+GEN_VEXT_TRANS(vlsb_v, 0, rnfvm, ld_stride_op, ld_stride_check)
+GEN_VEXT_TRANS(vlsh_v, 1, rnfvm, ld_stride_op, ld_stride_check)
+GEN_VEXT_TRANS(vlsw_v, 2, rnfvm, ld_stride_op, ld_stride_check)
+GEN_VEXT_TRANS(vlse_v, 3, rnfvm, ld_stride_op, ld_stride_check)
+GEN_VEXT_TRANS(vlsbu_v, 4, rnfvm, ld_stride_op, ld_stride_check)
+GEN_VEXT_TRANS(vlshu_v, 5, rnfvm, ld_stride_op, ld_stride_check)
+GEN_VEXT_TRANS(vlswu_v, 6, rnfvm, ld_stride_op, ld_stride_check)
+
+static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
+{
+    uint8_t nf = a->nf + 1;
+    uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9) | (nf << 11);
+    gen_helper_ldst_stride *fn;
+    static gen_helper_ldst_stride * const fns[4][4] = {
+        /* masked stride store */
+        { gen_helper_vssb_v_b,  gen_helper_vssb_v_h,
+          gen_helper_vssb_v_w,  gen_helper_vssb_v_d },
+        { NULL,                 gen_helper_vssh_v_h,
+          gen_helper_vssh_v_w,  gen_helper_vssh_v_d },
+        { NULL,                 NULL,
+          gen_helper_vssw_v_w,  gen_helper_vssw_v_d },
+        { gen_helper_vsse_v_b,  gen_helper_vsse_v_h,
+          gen_helper_vsse_v_w,  gen_helper_vsse_v_d }
+    };
+
+    fn =  fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+}
+
+static bool st_stride_check(DisasContext *s, arg_rnfvm* a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_nf(s, a->nf));
+}
+
+GEN_VEXT_TRANS(vssb_v, 0, rnfvm, st_stride_op, st_stride_check)
+GEN_VEXT_TRANS(vssh_v, 1, rnfvm, st_stride_op, st_stride_check)
+GEN_VEXT_TRANS(vssw_v, 2, rnfvm, st_stride_op, st_stride_check)
+GEN_VEXT_TRANS(vsse_v, 3, rnfvm, st_stride_op, st_stride_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 39984cebd2..8a8c062ad5 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -233,6 +233,28 @@ GEN_VEXT_LD_ELEM(vlhu_v_w, uint16_t, uint32_t, H4, lduw)
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
@@ -256,6 +278,19 @@ GEN_VEXT_ST_ELEM(vse_v_b, int8_t,  H1, stb)
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
 
 /*
  *** unit-stride: load vector element from continuous guest memory
@@ -455,3 +490,134 @@ GEN_VEXT_ST_US(vse_v_b, int8_t,  int8_t)
 GEN_VEXT_ST_US(vse_v_h, int16_t, int16_t)
 GEN_VEXT_ST_US(vse_v_w, int32_t, int32_t)
 GEN_VEXT_ST_US(vse_v_d, int64_t, int64_t)
+
+/*
+ *** stride: load strided vector element from guest memory
+ */
+static void vext_ld_stride(void *vd, void *v0, target_ulong base,
+        target_ulong stride, CPURISCVState *env, uint32_t desc,
+        vext_ld_elem_fn ld_elem, vext_ld_clear_elem clear_elem,
+        uint32_t esz, uint32_t msz, uintptr_t ra)
+{
+    uint32_t i, k;
+    uint32_t nf = vext_nf(desc);
+    uint32_t vm = vext_vm(desc);
+    uint32_t mlen = vext_mlen(desc);
+    uint32_t vlmax = vext_maxsz(desc) / esz;
+
+    if (env->vl == 0) {
+        return;
+    }
+    /* probe every access*/
+    for (i = 0; i < env->vl; i++) {
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        probe_read_access(env, base + stride * i, nf * msz, ra);
+    }
+    /* load bytes from guest memory */
+    for (i = 0; i < env->vl; i++) {
+        k = 0;
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        while (k < nf) {
+            target_ulong addr = base + stride * i + k * msz;
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
+#define GEN_VEXT_LD_STRIDE(NAME, MTYPE, ETYPE)                      \
+void HELPER(NAME)(void *vd, void * v0, target_ulong base,           \
+        target_ulong stride, CPURISCVState *env, uint32_t desc)     \
+{                                                                   \
+    vext_ld_stride(vd, v0, base, stride, env, desc,                 \
+        vext_##NAME##_ld_elem, vext_##NAME##_clear_elem,            \
+        sizeof(ETYPE), sizeof(MTYPE), GETPC());                     \
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
+/*
+ *** stride: store strided vector element to guest memory
+ */
+static void vext_st_stride(void *vd, void *v0, target_ulong base,
+        target_ulong stride, CPURISCVState *env, uint32_t desc,
+        vext_st_elem_fn st_elem, uint32_t esz, uint32_t msz, uintptr_t ra)
+{
+    uint32_t i, k;
+    uint32_t nf = vext_nf(desc);
+    uint32_t vm = vext_vm(desc);
+    uint32_t mlen = vext_mlen(desc);
+    uint32_t vlmax = vext_maxsz(desc) / esz;
+
+    /* probe every access*/
+    for (i = 0; i < env->vl; i++) {
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        probe_write_access(env, base + stride * i, nf * msz, ra);
+    }
+    /* store bytes to guest memory */
+    for (i = 0; i < env->vl; i++) {
+        k = 0;
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        while (k < nf) {
+            target_ulong addr = base + stride * i + k * msz;
+            st_elem(env, addr, i + k * vlmax, vd, ra);
+            k++;
+        }
+    }
+}
+
+#define GEN_VEXT_ST_STRIDE(NAME, MTYPE, ETYPE)                   \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,         \
+        target_ulong stride, CPURISCVState *env, uint32_t desc)  \
+{                                                                \
+    vext_st_stride(vd, v0, base, stride, env, desc,              \
+        vext_##NAME##_st_elem,                                   \
+        sizeof(ETYPE), sizeof(MTYPE), GETPC());                  \
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


