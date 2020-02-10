Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5DAC352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 07:44:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29AD520733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 07:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AD520733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j13k3-0004UN-A6
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 02:44:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j13iv-0002qt-TB
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:43:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j13it-00054t-Nq
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:43:17 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:55417)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j13is-0004bm-U5; Mon, 10 Feb 2020 02:43:15 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.65445-0.0401631-0.305387;
 DS=CONTINUE|ham_system_inform|0.760458-0.000229679-0.239313;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01l07426; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.GmNZEYU_1581320582; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GmNZEYU_1581320582)
 by smtp.aliyun-inc.com(10.147.41.158);
 Mon, 10 Feb 2020 15:43:05 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v3 4/5] target/riscv: add fault-only-first unit stride load
Date: Mon, 10 Feb 2020 15:42:55 +0800
Message-Id: <20200210074256.11412-5-zhiwei_liu@c-sky.com>
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

The unit-stride fault-only-fault load instructions are used to
vectorize loops with data-dependent exit conditions(while loops).
These instructions execute as a regular load except that they
will only take a trap on element 0.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/helper.h                   |  22 ++++
 target/riscv/insn32.decode              |   7 ++
 target/riscv/insn_trans/trans_rvv.inc.c |  88 +++++++++++++++
 target/riscv/vector_helper.c            | 138 ++++++++++++++++++++++++
 4 files changed, 255 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 5ebd3d6ccd..893dfc0fb8 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -218,3 +218,25 @@ DEF_HELPER_6(vsxe_v_b_mask, void, ptr, tl, ptr, ptr, env, i32)
 DEF_HELPER_6(vsxe_v_h_mask, void, ptr, tl, ptr, ptr, env, i32)
 DEF_HELPER_6(vsxe_v_w_mask, void, ptr, tl, ptr, ptr, env, i32)
 DEF_HELPER_6(vsxe_v_d_mask, void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_5(vlbff_v_b_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlbff_v_h_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlbff_v_w_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlbff_v_d_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlhff_v_h_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlhff_v_w_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlhff_v_d_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlwff_v_w_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlwff_v_d_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vleff_v_b_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vleff_v_h_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vleff_v_w_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vleff_v_d_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlbuff_v_b_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlbuff_v_h_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlbuff_v_w_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlbuff_v_d_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlhuff_v_h_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlhuff_v_w_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlhuff_v_d_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlwuff_v_w_mask, void, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlwuff_v_d_mask, void, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6a363a6b7e..973ac63fda 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -219,6 +219,13 @@ vle_v      ... 000 . 00000 ..... 111 ..... 0000111 @r2_nfvm
 vlbu_v     ... 000 . 00000 ..... 000 ..... 0000111 @r2_nfvm
 vlhu_v     ... 000 . 00000 ..... 101 ..... 0000111 @r2_nfvm
 vlwu_v     ... 000 . 00000 ..... 110 ..... 0000111 @r2_nfvm
+vlbff_v    ... 100 . 10000 ..... 000 ..... 0000111 @r2_nfvm
+vlhff_v    ... 100 . 10000 ..... 101 ..... 0000111 @r2_nfvm
+vlwff_v    ... 100 . 10000 ..... 110 ..... 0000111 @r2_nfvm
+vleff_v    ... 000 . 10000 ..... 111 ..... 0000111 @r2_nfvm
+vlbuff_v   ... 000 . 10000 ..... 000 ..... 0000111 @r2_nfvm
+vlhuff_v   ... 000 . 10000 ..... 101 ..... 0000111 @r2_nfvm
+vlwuff_v   ... 000 . 10000 ..... 110 ..... 0000111 @r2_nfvm
 vsb_v      ... 000 . 00000 ..... 000 ..... 0100111 @r2_nfvm
 vsh_v      ... 000 . 00000 ..... 101 ..... 0100111 @r2_nfvm
 vsw_v      ... 000 . 00000 ..... 110 ..... 0100111 @r2_nfvm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 13033b3906..66caa16d18 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -663,3 +663,91 @@ static bool trans_vsuxe_v(DisasContext *s, arg_rnfvm* a)
 {
     return trans_vsxe_v(s, a);
 }
+
+/* unit stride fault-only-first load */
+typedef void gen_helper_vext_ldff(TCGv_ptr, TCGv, TCGv_ptr,
+        TCGv_env, TCGv_i32);
+
+static bool do_vext_ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
+        gen_helper_vext_ldff *fn, DisasContext *s)
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
+static bool vext_ldff_trans(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
+{
+    uint8_t nf = a->nf + 1;
+    uint32_t data = s->mlen | (a->vm << 8) | (maxsz_part2(s->maxsz) << 9)
+        | (nf << 12);
+    gen_helper_vext_ldff *fn;
+    static gen_helper_vext_ldff * const fns[7][4] = {
+        /* masked unit stride fault-only-first load */
+        { gen_helper_vlbff_v_b_mask,  gen_helper_vlbff_v_h_mask,
+          gen_helper_vlbff_v_w_mask,  gen_helper_vlbff_v_d_mask },
+        { NULL,                       gen_helper_vlhff_v_h_mask,
+          gen_helper_vlhff_v_w_mask,  gen_helper_vlhff_v_d_mask },
+        { NULL,                       NULL,
+          gen_helper_vlwff_v_w_mask,  gen_helper_vlwff_v_d_mask },
+        { gen_helper_vleff_v_b_mask,  gen_helper_vleff_v_h_mask,
+          gen_helper_vleff_v_w_mask,  gen_helper_vleff_v_d_mask },
+        { gen_helper_vlbuff_v_b_mask, gen_helper_vlbuff_v_h_mask,
+          gen_helper_vlbuff_v_w_mask, gen_helper_vlbuff_v_d_mask },
+        { NULL,                       gen_helper_vlhuff_v_h_mask,
+          gen_helper_vlhuff_v_w_mask, gen_helper_vlhuff_v_d_mask },
+        { NULL,                       NULL,
+          gen_helper_vlwuff_v_w_mask, gen_helper_vlwuff_v_d_mask }
+    };
+
+    fn =  fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    return do_vext_ldff_trans(a->rd, a->rs1, data, fn, s);
+}
+
+#define GEN_VEXT_LDFF_TRANS(NAME, DO_OP, SEQ)                   \
+static bool trans_##NAME(DisasContext *s, arg_r2nfvm* a)        \
+{                                                               \
+    vchkctx.check_misa = RVV;                                   \
+    vchkctx.check_overlap_mask.need_check = true;               \
+    vchkctx.check_overlap_mask.reg = a->rd;                     \
+    vchkctx.check_overlap_mask.vm = a->vm;                      \
+    vchkctx.check_reg[0].need_check = true;                     \
+    vchkctx.check_reg[0].reg = a->rd;                           \
+    vchkctx.check_reg[0].widen = false;                         \
+    vchkctx.check_nf.need_check = true;                         \
+    vchkctx.check_nf.nf = a->nf;                                \
+                                                                \
+    if (!vext_check(s)) {                                       \
+        return false;                                           \
+    }                                                           \
+    return DO_OP(s, a, SEQ);                                    \
+}
+
+GEN_VEXT_LDFF_TRANS(vlbff_v, vext_ldff_trans, 0)
+GEN_VEXT_LDFF_TRANS(vlhff_v, vext_ldff_trans, 1)
+GEN_VEXT_LDFF_TRANS(vlwff_v, vext_ldff_trans, 2)
+GEN_VEXT_LDFF_TRANS(vleff_v, vext_ldff_trans, 3)
+GEN_VEXT_LDFF_TRANS(vlbuff_v, vext_ldff_trans, 4)
+GEN_VEXT_LDFF_TRANS(vlhuff_v, vext_ldff_trans, 5)
+GEN_VEXT_LDFF_TRANS(vlwuff_v, vext_ldff_trans, 6)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 0404394588..941851ab28 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -301,6 +301,28 @@ GEN_VEXT_LD_ELEM(vlxhu_v_w, uint16_t, uint32_t, H4, lduw)
 GEN_VEXT_LD_ELEM(vlxhu_v_d, uint16_t, uint64_t, H8, lduw)
 GEN_VEXT_LD_ELEM(vlxwu_v_w, uint32_t, uint32_t, H4, ldl)
 GEN_VEXT_LD_ELEM(vlxwu_v_d, uint32_t, uint64_t, H8, ldl)
+GEN_VEXT_LD_ELEM(vlbff_v_b, int8_t,  int8_t,  H1, ldsb)
+GEN_VEXT_LD_ELEM(vlbff_v_h, int8_t,  int16_t, H2, ldsb)
+GEN_VEXT_LD_ELEM(vlbff_v_w, int8_t,  int32_t, H4, ldsb)
+GEN_VEXT_LD_ELEM(vlbff_v_d, int8_t,  int64_t, H8, ldsb)
+GEN_VEXT_LD_ELEM(vlhff_v_h, int16_t, int16_t, H2, ldsw)
+GEN_VEXT_LD_ELEM(vlhff_v_w, int16_t, int32_t, H4, ldsw)
+GEN_VEXT_LD_ELEM(vlhff_v_d, int16_t, int64_t, H8, ldsw)
+GEN_VEXT_LD_ELEM(vlwff_v_w, int32_t, int32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(vlwff_v_d, int32_t, int64_t, H8, ldl)
+GEN_VEXT_LD_ELEM(vleff_v_b, int8_t,  int8_t,  H1, ldsb)
+GEN_VEXT_LD_ELEM(vleff_v_h, int16_t, int16_t, H2, ldsw)
+GEN_VEXT_LD_ELEM(vleff_v_w, int32_t, int32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(vleff_v_d, int64_t, int64_t, H8, ldq)
+GEN_VEXT_LD_ELEM(vlbuff_v_b, uint8_t,  uint8_t,  H1, ldub)
+GEN_VEXT_LD_ELEM(vlbuff_v_h, uint8_t,  uint16_t, H2, ldub)
+GEN_VEXT_LD_ELEM(vlbuff_v_w, uint8_t,  uint32_t, H4, ldub)
+GEN_VEXT_LD_ELEM(vlbuff_v_d, uint8_t,  uint64_t, H8, ldub)
+GEN_VEXT_LD_ELEM(vlhuff_v_h, uint16_t, uint16_t, H2, lduw)
+GEN_VEXT_LD_ELEM(vlhuff_v_w, uint16_t, uint32_t, H4, lduw)
+GEN_VEXT_LD_ELEM(vlhuff_v_d, uint16_t, uint64_t, H8, lduw)
+GEN_VEXT_LD_ELEM(vlwuff_v_w, uint32_t, uint32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(vlwuff_v_d, uint32_t, uint64_t, H8, ldl)
 
 #define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)                       \
 static void vext_##NAME##_st_elem(CPURISCVState *env, abi_ptr addr,   \
@@ -868,3 +890,119 @@ GEN_VEXT_ST_INDEX(vsxe_v_b, int8_t,  int8_t)
 GEN_VEXT_ST_INDEX(vsxe_v_h, int16_t, int16_t)
 GEN_VEXT_ST_INDEX(vsxe_v_w, int32_t, int32_t)
 GEN_VEXT_ST_INDEX(vsxe_v_d, int64_t, int64_t)
+
+/* unit-stride fault-only-fisrt load instructions */
+static void vext_ldff_mask(void *vd, void *v0, CPURISCVState *env,
+        struct vext_ldst_ctx *ctx, uintptr_t ra)
+{
+    void *host;
+    uint32_t i, k, vl = 0;
+    target_ulong addr, offset, remain;
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
+        addr = ctx->base + ctx->nf * i * s->msz;
+        if (i == 0) {
+            probe_read_access(env, addr, ctx->nf * s->msz, ra);
+        } else {
+            /* if it triggles an exception, no need to check watchpoint */
+            offset = -(addr | TARGET_PAGE_MASK);
+            remain = ctx->nf * s->msz;
+            while (remain > 0) {
+                host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD,
+                        ctx->mmuidx);
+                if (host) {
+#ifdef CONFIG_USER_ONLY
+                    if (page_check_range(addr, ctx->nf * s->msz,
+                                PAGE_READ) < 0) {
+                        vl = i;
+                        goto ProbeSuccess;
+                    }
+#else
+                    probe_read_access(env, addr, ctx->nf * s->msz, ra);
+#endif
+                } else {
+                    vl = i;
+                    goto ProbeSuccess;
+                }
+                if (remain <=  offset) {
+                    break;
+                }
+                remain -= offset;
+                addr += offset;
+                offset = -(addr | TARGET_PAGE_MASK);
+            }
+        }
+    }
+ProbeSuccess:
+    /* load bytes from guest memory */
+    if (vl != 0) {
+        s->vl = vl;
+    }
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
+    if (vl != 0) {
+        env->vext.vl = vl;
+        return;
+    }
+    for (k = 0; k < ctx->nf; k++) {
+        ctx->clear_elem(vd, s->vl + k * s->vlmax, s->vl * s->esz,
+                s->vlmax * s->esz);
+    }
+}
+
+#define GEN_VEXT_LDFF(NAME, MTYPE, ETYPE, MMUIDX)                      \
+void HELPER(NAME##_mask)(void *vd, target_ulong base, void *v0,        \
+        CPURISCVState *env, uint32_t desc)                             \
+{                                                                      \
+    static struct vext_ldst_ctx ctx;                                   \
+    vext_common_ctx_init(&ctx.vcc, sizeof(ETYPE),                      \
+        sizeof(MTYPE), env->vext.vl, desc);                            \
+    ctx.nf = vext_nf(desc);                                            \
+    ctx.base = base;                                                   \
+    ctx.mmuidx = MMUIDX;                                               \
+    ctx.ld_elem = vext_##NAME##_ld_elem;                               \
+    ctx.clear_elem = vext_##NAME##_clear_elem;                         \
+                                                                       \
+    vext_ldff_mask(vd, v0, env, &ctx, GETPC());                        \
+}
+
+GEN_VEXT_LDFF(vlbff_v_b, int8_t,  int8_t, MO_SB)
+GEN_VEXT_LDFF(vlbff_v_h, int8_t,  int16_t, MO_SB)
+GEN_VEXT_LDFF(vlbff_v_w, int8_t,  int32_t, MO_SB)
+GEN_VEXT_LDFF(vlbff_v_d, int8_t,  int64_t, MO_SB)
+GEN_VEXT_LDFF(vlhff_v_h, int16_t, int16_t, MO_LESW)
+GEN_VEXT_LDFF(vlhff_v_w, int16_t, int32_t, MO_LESW)
+GEN_VEXT_LDFF(vlhff_v_d, int16_t, int64_t, MO_LESW)
+GEN_VEXT_LDFF(vlwff_v_w, int32_t, int32_t, MO_LESL)
+GEN_VEXT_LDFF(vlwff_v_d, int32_t, int64_t, MO_LESL)
+GEN_VEXT_LDFF(vleff_v_b, int8_t,  int8_t, MO_SB)
+GEN_VEXT_LDFF(vleff_v_h, int16_t, int16_t, MO_LESW)
+GEN_VEXT_LDFF(vleff_v_w, int32_t, int32_t, MO_LESL)
+GEN_VEXT_LDFF(vleff_v_d, int64_t, int64_t, MO_LEQ)
+GEN_VEXT_LDFF(vlbuff_v_b, uint8_t,  uint8_t, MO_UB)
+GEN_VEXT_LDFF(vlbuff_v_h, uint8_t,  uint16_t, MO_UB)
+GEN_VEXT_LDFF(vlbuff_v_w, uint8_t,  uint32_t, MO_UB)
+GEN_VEXT_LDFF(vlbuff_v_d, uint8_t,  uint64_t, MO_UB)
+GEN_VEXT_LDFF(vlhuff_v_h, uint16_t, uint16_t, MO_LEUW)
+GEN_VEXT_LDFF(vlhuff_v_w, uint16_t, uint32_t, MO_LEUW)
+GEN_VEXT_LDFF(vlhuff_v_d, uint16_t, uint64_t, MO_LEUW)
+GEN_VEXT_LDFF(vlwuff_v_w, uint32_t, uint32_t, MO_LEUL)
+GEN_VEXT_LDFF(vlwuff_v_d, uint32_t, uint64_t, MO_LEUL)
-- 
2.23.0


