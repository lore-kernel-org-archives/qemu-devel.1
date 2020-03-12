Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006E5C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 21:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DD83205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 21:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vT68LnEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD83205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCVRf-0006VS-7o
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 17:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jCVQJ-0004Ps-En
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 17:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jCVQH-0001Z7-82
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 17:31:23 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:38587)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jCVQH-0001Yb-1x; Thu, 12 Mar 2020 17:31:21 -0400
Received: by mail-vs1-xe42.google.com with SMTP id k26so4754410vso.5;
 Thu, 12 Mar 2020 14:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GjyiUQj+NC9VJYpr/6jESMXRolQIM10W8pNegLphvdo=;
 b=vT68LnEGIj9Y9+3avLsCO1KVEO233yoq2hFZP8CTzo3a4i2Gj2rBHHK1py7Bj+3oEc
 u3CpOCUnkc1AQlAU7wEp7i6Uh7f5B4CZtqk4DPhT/3SIEkq6JWSOkVQ1gwRw8xvd9L2w
 nm2TA9TXdfGvVJJSQk0/EPt1aLCcZ9i9La1b9f1hVjQFM2iBp93woQR7t6wDMSaE6FWQ
 +Tdp9/bVdrsInOQ5Qp2BRSC+DtRQlyCWk8jXVcnXs4lqitWXhDIXc45V/1Uja/qxYK//
 fX5gvaiKlr8Ol3dol+1vYOszEPc8pkWbHUBna71Z77r6iAkdWBbQ0bkrw4/vokfrt1xn
 yAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GjyiUQj+NC9VJYpr/6jESMXRolQIM10W8pNegLphvdo=;
 b=TvUKLWEPruTHqlSpV0EEmH1xY9lfLIkXJgPOixFUrbDkQ7N2/bCmVzeGBzdutWNeIu
 QU9XFjTlcDUrnVnUnoTkDuF+rPr1WnfAbFieGtKVSS0C8IJV19wKtSpjZtrLDq0XslYV
 aEE3HXnJfMjMxbM/UYO/pC+knTK7Ffnize+yPBKY7DLiNcBoDiez8S+2FvnS/iQf/ASR
 7X4uDYpof70r5oSvqV/2aV6/H3yaknEaGlMpc3/gYHqBO8FuMEgsOVTJGg8pLR4IVxKU
 IWL4KiCd7QI8eFG9hcal5c5q+/PqJcNVkOWoE3IlBguqn0Fp7P6WgFBN3L+sJNtZjBU5
 Ojyw==
X-Gm-Message-State: ANhLgQ2eiY9IumcuLo2dYUmjiqcDi+nTdBnfX3IrsgVUVAxO8OdxFQD3
 I0VnuaK7Vguv57EgHiswWrQThTEX4uXpI2Hc0SU=
X-Google-Smtp-Source: ADFU+vtLAbQlmXHRMRKe+4Yq8COAsPmS0G7j10MVVupVn2qKluCq1muaIM0jNULKCBm5/oiShHyG38XuD6lDu+1EYFg=
X-Received: by 2002:a67:643:: with SMTP id 64mr7223137vsg.180.1584048680094;
 Thu, 12 Mar 2020 14:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-5-zhiwei_liu@c-sky.com>
In-Reply-To: <20200312145900.2054-5-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Mar 2020 14:23:29 -0700
Message-ID: <CAKmqyKOA2xH+wCZ2L1TGDoL+3kfdEVGFKcqARua_e7GdN_iTuQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/60] target/riscv: add vector configure instruction
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e42
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
Cc: guoren@linux.alibaba.com, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Chih-Min Chao <chihmin.chao@sifive.com>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 8:07 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> vsetvl and vsetvli are two configure instructions for vl, vtype. TB flags
> should update after configure instructions. The (ill, lmul, sew ) of vtype
> and the bit of (VSTART == 0 && VL == VLMAX) will be placed within tb_flags.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/Makefile.objs              |  2 +-
>  target/riscv/cpu.h                      | 63 ++++++++++++++++++----
>  target/riscv/helper.h                   |  2 +
>  target/riscv/insn32.decode              |  5 ++
>  target/riscv/insn_trans/trans_rvv.inc.c | 69 +++++++++++++++++++++++++
>  target/riscv/translate.c                | 17 +++++-
>  target/riscv/vector_helper.c            | 53 +++++++++++++++++++
>  7 files changed, 199 insertions(+), 12 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
>  create mode 100644 target/riscv/vector_helper.c
>
> diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
> index ff651f69f6..ff38df6219 100644
> --- a/target/riscv/Makefile.objs
> +++ b/target/riscv/Makefile.objs
> @@ -1,4 +1,4 @@
> -obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o gdbstub.o
> +obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o vector_helper.o gdbstub.o
>  obj-$(CONFIG_SOFTMMU) += pmp.o
>
>  ifeq ($(CONFIG_SOFTMMU),y)
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 603715f849..505d1a8515 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -21,6 +21,7 @@
>  #define RISCV_CPU_H
>
>  #include "hw/core/cpu.h"
> +#include "hw/registerfields.h"
>  #include "exec/cpu-defs.h"
>  #include "fpu/softfloat-types.h"
>
> @@ -99,6 +100,12 @@ typedef struct CPURISCVState CPURISCVState;
>
>  #define RV_VLEN_MAX 512
>
> +FIELD(VTYPE, VLMUL, 0, 2)
> +FIELD(VTYPE, VSEW, 2, 3)
> +FIELD(VTYPE, VEDIV, 5, 2)
> +FIELD(VTYPE, RESERVED, 7, sizeof(target_ulong) * 8 - 9)
> +FIELD(VTYPE, VILL, sizeof(target_ulong) * 8 - 2, 1)
> +
>  struct CPURISCVState {
>      target_ulong gpr[32];
>      uint64_t fpr[32]; /* assume both F and D extensions */
> @@ -358,19 +365,62 @@ void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
>  #define TB_FLAGS_MMU_MASK   3
>  #define TB_FLAGS_MSTATUS_FS MSTATUS_FS
>
> +typedef CPURISCVState CPUArchState;
> +typedef RISCVCPU ArchCPU;
> +#include "exec/cpu-all.h"
> +
> +FIELD(TB_FLAGS, VL_EQ_VLMAX, 2, 1)
> +FIELD(TB_FLAGS, LMUL, 3, 2)
> +FIELD(TB_FLAGS, SEW, 5, 3)
> +FIELD(TB_FLAGS, VILL, 8, 1)
> +
> +/*
> + * A simplification for VLMAX
> + * = (1 << LMUL) * VLEN / (8 * (1 << SEW))
> + * = (VLEN << LMUL) / (8 << SEW)
> + * = (VLEN << LMUL) >> (SEW + 3)
> + * = VLEN >> (SEW + 3 - LMUL)
> + */
> +static inline uint32_t vext_get_vlmax(RISCVCPU *cpu, target_ulong vtype)
> +{
> +    uint8_t sew, lmul;
> +
> +    sew = FIELD_EX64(vtype, VTYPE, VSEW);
> +    lmul = FIELD_EX64(vtype, VTYPE, VLMUL);
> +    return cpu->cfg.vlen >> (sew + 3 - lmul);
> +}
> +
>  static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
> -                                        target_ulong *cs_base, uint32_t *flags)
> +                                        target_ulong *cs_base, uint32_t *pflags)
>  {
> +    uint32_t flags = 0;
> +
>      *pc = env->pc;
>      *cs_base = 0;
> +
> +    if (env->misa & RVV) {

Can you use: riscv_has_ext(env, RVV) instead?

> +        uint32_t vlmax = vext_get_vlmax(env_archcpu(env), env->vtype);
> +        bool vl_eq_vlmax = (env->vstart == 0) && (vlmax == env->vl);
> +        flags = FIELD_DP32(flags, TB_FLAGS, VILL,
> +                    FIELD_EX64(env->vtype, VTYPE, VILL));
> +        flags = FIELD_DP32(flags, TB_FLAGS, SEW,
> +                    FIELD_EX64(env->vtype, VTYPE, VSEW));
> +        flags = FIELD_DP32(flags, TB_FLAGS, LMUL,
> +                    FIELD_EX64(env->vtype, VTYPE, VLMUL));
> +        flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
> +    } else {
> +        flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
> +    }
> +
>  #ifdef CONFIG_USER_ONLY
> -    *flags = TB_FLAGS_MSTATUS_FS;
> +    flags |= TB_FLAGS_MSTATUS_FS;
>  #else
> -    *flags = cpu_mmu_index(env, 0);
> +    flags |= cpu_mmu_index(env, 0);
>      if (riscv_cpu_fp_enabled(env)) {
> -        *flags |= env->mstatus & MSTATUS_FS;
> +        flags |= env->mstatus & MSTATUS_FS;
>      }
>  #endif
> +    *pflags = flags;
>  }
>
>  int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
> @@ -411,9 +461,4 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
>
>  void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
>
> -typedef CPURISCVState CPUArchState;
> -typedef RISCVCPU ArchCPU;
> -
> -#include "exec/cpu-all.h"
> -
>  #endif /* RISCV_CPU_H */
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index debb22a480..3c28c7e407 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -76,3 +76,5 @@ DEF_HELPER_2(mret, tl, env, tl)
>  DEF_HELPER_1(wfi, void, env)
>  DEF_HELPER_1(tlb_flush, void, env)
>  #endif
> +/* Vector functions */
> +DEF_HELPER_3(vsetvl, tl, env, tl, tl)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index b883672e63..53340bdbc4 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -62,6 +62,7 @@
>  @r_rm    .......   ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
>  @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
>  @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
> +@r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
>
>  @hfence_gvma ....... ..... .....   ... ..... ....... %rs2 %rs1
>  @hfence_bvma ....... ..... .....   ... ..... ....... %rs2 %rs1
> @@ -207,3 +208,7 @@ fcvt_w_d   1100001  00000 ..... ... ..... 1010011 @r2_rm
>  fcvt_wu_d  1100001  00001 ..... ... ..... 1010011 @r2_rm
>  fcvt_d_w   1101001  00000 ..... ... ..... 1010011 @r2_rm
>  fcvt_d_wu  1101001  00001 ..... ... ..... 1010011 @r2_rm
> +
> +# *** RV32V Extension ***
> +vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
> +vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> new file mode 100644
> index 0000000000..da82c72bbf
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -0,0 +1,69 @@
> +/*
> + * RISC-V translation routines for the RVV Standard Extension.
> + *
> + * Copyright (c) 2020 C-SKY Limited. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl * a)
> +{
> +    TCGv s1, s2, dst;
> +    s2 = tcg_temp_new();
> +    dst = tcg_temp_new();
> +
> +    /* Using x0 as the rs1 register specifier, encodes an infinite AVL */
> +    if (a->rs1 == 0) {
> +        /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
> +        s1 = tcg_const_tl(RV_VLEN_MAX);
> +    } else {
> +        s1 = tcg_temp_new();
> +        gen_get_gpr(s1, a->rs1);
> +    }
> +    gen_get_gpr(s2, a->rs2);
> +    gen_helper_vsetvl(dst, cpu_env, s1, s2);
> +    gen_set_gpr(a->rd, dst);
> +    tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
> +    exit_tb(ctx);

Why does this

> +    ctx->base.is_jmp = DISAS_NORETURN;
> +
> +    tcg_temp_free(s1);
> +    tcg_temp_free(s2);
> +    tcg_temp_free(dst);
> +    return true;
> +}
> +
> +static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli * a)
> +{
> +    TCGv s1, s2, dst;
> +    s2 = tcg_const_tl(a->zimm);
> +    dst = tcg_temp_new();
> +
> +    /* Using x0 as the rs1 register specifier, encodes an infinite AVL */
> +    if (a->rs1 == 0) {
> +        /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
> +        s1 = tcg_const_tl(RV_VLEN_MAX);
> +    } else {
> +        s1 = tcg_temp_new();
> +        gen_get_gpr(s1, a->rs1);
> +    }
> +    gen_helper_vsetvl(dst, cpu_env, s1, s2);
> +    gen_set_gpr(a->rd, dst);
> +    gen_goto_tb(ctx, 0, ctx->pc_succ_insn);

Need to be different to this?

Alistair

> +    ctx->base.is_jmp = DISAS_NORETURN;
> +
> +    tcg_temp_free(s1);
> +    tcg_temp_free(s2);
> +    tcg_temp_free(dst);
> +    return true;
> +}
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 43bf7e39a6..af07ac4160 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -56,6 +56,12 @@ typedef struct DisasContext {
>         to reset this known value.  */
>      int frm;
>      bool ext_ifencei;
> +    /* vector extension */
> +    bool vill;
> +    uint8_t lmul;
> +    uint8_t sew;
> +    uint16_t vlen;
> +    bool vl_eq_vlmax;
>  } DisasContext;
>
>  #ifdef TARGET_RISCV64
> @@ -711,6 +717,7 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
>  #include "insn_trans/trans_rva.inc.c"
>  #include "insn_trans/trans_rvf.inc.c"
>  #include "insn_trans/trans_rvd.inc.c"
> +#include "insn_trans/trans_rvv.inc.c"
>  #include "insn_trans/trans_privileged.inc.c"
>
>  /* Include the auto-generated decoder for 16 bit insn */
> @@ -745,10 +752,11 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>      DisasContext *ctx = container_of(dcbase, DisasContext, base);
>      CPURISCVState *env = cs->env_ptr;
>      RISCVCPU *cpu = RISCV_CPU(cs);
> +    uint32_t tb_flags = ctx->base.tb->flags;
>
>      ctx->pc_succ_insn = ctx->base.pc_first;
> -    ctx->mem_idx = ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
> -    ctx->mstatus_fs = ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
> +    ctx->mem_idx = tb_flags & TB_FLAGS_MMU_MASK;
> +    ctx->mstatus_fs = tb_flags & TB_FLAGS_MSTATUS_FS;
>      ctx->priv_ver = env->priv_ver;
>  #if !defined(CONFIG_USER_ONLY)
>      if (riscv_has_ext(env, RVH)) {
> @@ -772,6 +780,11 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>      ctx->misa = env->misa;
>      ctx->frm = -1;  /* unknown rounding mode */
>      ctx->ext_ifencei = cpu->cfg.ext_ifencei;
> +    ctx->vlen = cpu->cfg.vlen;
> +    ctx->vill = FIELD_EX32(tb_flags, TB_FLAGS, VILL);
> +    ctx->sew = FIELD_EX32(tb_flags, TB_FLAGS, SEW);
> +    ctx->lmul = FIELD_EX32(tb_flags, TB_FLAGS, LMUL);
> +    ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
>  }
>
>  static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> new file mode 100644
> index 0000000000..2afe716f2a
> --- /dev/null
> +++ b/target/riscv/vector_helper.c
> @@ -0,0 +1,53 @@
> +/*
> + * RISC-V Vector Extension Helpers for QEMU.
> + *
> + * Copyright (c) 2020 C-SKY Limited. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "exec/exec-all.h"
> +#include "exec/helper-proto.h"
> +#include <math.h>
> +
> +target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
> +    target_ulong s2)
> +{
> +    int vlmax, vl;
> +    RISCVCPU *cpu = env_archcpu(env);
> +    uint16_t sew = 8 << FIELD_EX64(s2, VTYPE, VSEW);
> +    uint8_t ediv = FIELD_EX64(s2, VTYPE, VEDIV);
> +    bool vill = FIELD_EX64(s2, VTYPE, VILL);
> +    target_ulong reserved = FIELD_EX64(s2, VTYPE, RESERVED);
> +
> +    if ((sew > cpu->cfg.elen) || vill || (ediv != 0) || (reserved != 0)) {
> +        /* only set vill bit. */
> +        env->vtype = FIELD_DP64(0, VTYPE, VILL, 1);
> +        env->vl = 0;
> +        env->vstart = 0;
> +        return 0;
> +    }
> +
> +    vlmax = vext_get_vlmax(cpu, s2);
> +    if (s1 <= vlmax) {
> +        vl = s1;
> +    } else {
> +        vl = vlmax;
> +    }
> +    env->vl = vl;
> +    env->vtype = s2;
> +    env->vstart = 0;
> +    return vl;
> +}
> --
> 2.23.0
>

