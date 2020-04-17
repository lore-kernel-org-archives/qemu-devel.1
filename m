Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBB9C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E551C20656
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyuu3Np9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E551C20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPZIq-0007aV-54
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 18:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jPZHY-0006Rk-4j
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jPZHO-0000Bd-8X
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:16:19 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:36565)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jPZHL-0008OV-Fm; Fri, 17 Apr 2020 18:16:07 -0400
Received: by mail-il1-x144.google.com with SMTP id t8so3743961ilj.3;
 Fri, 17 Apr 2020 15:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hMoC+JTxD698uNPPuBODxk3Q8GozT5P7VVx2XeNDbdA=;
 b=cyuu3Np9YFOh1dU/Wti84lVcKzDt2EE291lRBjdFUPKkjShl3pIApXYgv8Oep1I4KN
 4kYBvj9MTfKEGsTO274jfxzRxSUmtaZzbZKDNsb++QaTXmytSAG/feuDu6fRs2Vzx+U0
 LMqOLZshY6lkXpK6j0I8RSMxSRcbiJIFKPjOMTUq2hSCIJIDGtGAo3LLzIwucKrJv7mG
 paUbUVFUuV7eHDqIqFjE41Rt+NKL3reYRvyXuUG/BfNFHZVfG1rxNBoCHqm0U1TM9wuh
 uaXiQvpuImhLmyhAGmZ9wbqvI7+/ezefiws01TrqxpItliw7+J2t4XpRG+x7jESG2/vK
 e9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hMoC+JTxD698uNPPuBODxk3Q8GozT5P7VVx2XeNDbdA=;
 b=LbaFECWKIksuufET6347neqdkrT31FhPEdD5NATQsKCNHPjdqJFtjCYYxx5TJNYfWU
 wm37E/K4NHHnLRcBZMT0Yj2XJOFfmpK6aTVXzhlW+lzyi/+pXDgTragu7H5akhPPV2/O
 Dxr56fEb21SAE6QtiklYkSXu0A7Zw4S3lJ6O0+/jOvvuydc2xY1+dhdLkHi7E9WhxgbQ
 XIFHm729+YovkMmP46on+uQDFT5NJyUU/C/91057w22rwgWmU0BgTe0AIlc4eE47RyNh
 m9IghnXZkJlGuqd8KNHvLhdgjevHpW+6nzf00e+sWu6ZhP2Ln4zy+xgA6/CKQqba1WYW
 W3bA==
X-Gm-Message-State: AGi0PuZHm5Tpv3yZHLRqkSDxOrIz+gEcmcN5R4m3nNUKOXa6MGBm8n9q
 ZvAt0NbIc+oXKdrA9M9N4vn23OLC7jIuQS1nKlI=
X-Google-Smtp-Source: APiQypJMOg9uQ7xViGqErhqvwBtaXdIVge1EIRBtN4hKJVOiIkuLAiFNPoL9CEmZwUuevlF/PbqbAlU+IppJCueChrE=
X-Received: by 2002:a92:d182:: with SMTP id z2mr5557052ilz.177.1587161752592; 
 Fri, 17 Apr 2020 15:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200330153633.15298-1-zhiwei_liu@c-sky.com>
 <20200330153633.15298-31-zhiwei_liu@c-sky.com>
In-Reply-To: <20200330153633.15298-31-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2020 15:07:30 -0700
Message-ID: <CAKmqyKNg9oGynDHAMcmOZ_RtNpRNnxJa1tOSRDWVA0zqkcxnoA@mail.gmail.com>
Subject: Re: [PATCH v7 30/61] target/riscv: vector single-width floating-point
 add/subtract instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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

On Mon, Mar 30, 2020 at 9:37 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   |  16 ++++
>  target/riscv/insn32.decode              |   5 +
>  target/riscv/insn_trans/trans_rvv.inc.c | 116 ++++++++++++++++++++++++
>  target/riscv/vector_helper.c            | 111 +++++++++++++++++++++++
>  4 files changed, 248 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 7f7fdcb451..3031a941c2 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -797,3 +797,19 @@ DEF_HELPER_6(vnclipu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vnclip_vx_b, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vnclip_vx_h, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vnclip_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +
> +DEF_HELPER_6(vfadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfadd_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfadd_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfadd_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfrsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfrsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfrsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 8b898f9bad..c8e3f10162 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -443,6 +443,11 @@ vnclipu_vi      101110 . ..... ..... 011 ..... 1010111 @r_vm
>  vnclip_vv       101111 . ..... ..... 000 ..... 1010111 @r_vm
>  vnclip_vx       101111 . ..... ..... 100 ..... 1010111 @r_vm
>  vnclip_vi       101111 . ..... ..... 011 ..... 1010111 @r_vm
> +vfadd_vv        000000 . ..... ..... 001 ..... 1010111 @r_vm
> +vfadd_vf        000000 . ..... ..... 101 ..... 1010111 @r_vm
> +vfsub_vv        000010 . ..... ..... 001 ..... 1010111 @r_vm
> +vfsub_vf        000010 . ..... ..... 101 ..... 1010111 @r_vm
> +vfrsub_vf       100111 . ..... ..... 101 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index d03ec2688f..9a8fb18adc 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -1807,3 +1807,119 @@ GEN_OPIVX_NARROW_TRANS(vnclipu_vx)
>  GEN_OPIVX_NARROW_TRANS(vnclip_vx)
>  GEN_OPIVI_NARROW_TRANS(vnclipu_vi, 1, vnclipu_vx)
>  GEN_OPIVI_NARROW_TRANS(vnclip_vi, 1, vnclip_vx)
> +
> +/*
> + *** Vector Float Point Arithmetic Instructions
> + */
> +/* Vector Single-Width Floating-Point Add/Subtract Instructions */
> +
> +/*
> + * If the current SEW does not correspond to a supported IEEE floating-point
> + * type, an illegal instruction exception is raised.
> + */
> +static bool opfvv_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return (vext_check_isa_ill(s) &&
> +            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
> +            vext_check_reg(s, a->rd, false) &&
> +            vext_check_reg(s, a->rs2, false) &&
> +            vext_check_reg(s, a->rs1, false) &&
> +            (s->sew != 0));
> +}
> +
> +/* OPFVV without GVEC IR */
> +#define GEN_OPFVV_TRANS(NAME, CHECK)                               \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
> +{                                                                  \
> +    if (CHECK(s, a)) {                                             \
> +        uint32_t data = 0;                                         \
> +        static gen_helper_gvec_4_ptr * const fns[3] = {            \
> +            gen_helper_##NAME##_h,                                 \
> +            gen_helper_##NAME##_w,                                 \
> +            gen_helper_##NAME##_d,                                 \
> +        };                                                         \
> +        TCGLabel *over = gen_new_label();                          \
> +        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
> +                                                                   \
> +        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
> +        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> +        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
> +                           vreg_ofs(s, a->rs1),                    \
> +                           vreg_ofs(s, a->rs2), cpu_env, 0,        \
> +                           s->vlen / 8, data, fns[s->sew - 1]);    \
> +        gen_set_label(over);                                       \
> +        return true;                                               \
> +    }                                                              \
> +    return false;                                                  \
> +}
> +GEN_OPFVV_TRANS(vfadd_vv, opfvv_check)
> +GEN_OPFVV_TRANS(vfsub_vv, opfvv_check)
> +
> +typedef void gen_helper_opfvf(TCGv_ptr, TCGv_ptr, TCGv_i64, TCGv_ptr,
> +                              TCGv_env, TCGv_i32);
> +
> +static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
> +                        uint32_t data, gen_helper_opfvf *fn, DisasContext *s)
> +{
> +    TCGv_ptr dest, src2, mask;
> +    TCGv_i32 desc;
> +
> +    TCGLabel *over = gen_new_label();
> +    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
> +
> +    dest = tcg_temp_new_ptr();
> +    mask = tcg_temp_new_ptr();
> +    src2 = tcg_temp_new_ptr();
> +    desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
> +
> +    tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
> +    tcg_gen_addi_ptr(src2, cpu_env, vreg_ofs(s, vs2));
> +    tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
> +
> +    fn(dest, mask, cpu_fpr[rs1], src2, cpu_env, desc);
> +
> +    tcg_temp_free_ptr(dest);
> +    tcg_temp_free_ptr(mask);
> +    tcg_temp_free_ptr(src2);
> +    tcg_temp_free_i32(desc);
> +    gen_set_label(over);
> +    return true;
> +}
> +
> +static bool opfvf_check(DisasContext *s, arg_rmrr *a)
> +{
> +/*
> + * If the current SEW does not correspond to a supported IEEE floating-point
> + * type, an illegal instruction exception is raised
> + */
> +    return (vext_check_isa_ill(s) &&
> +            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
> +            vext_check_reg(s, a->rd, false) &&
> +            vext_check_reg(s, a->rs2, false) &&
> +            (s->sew != 0));
> +}
> +
> +/* OPFVF without GVEC IR */
> +#define GEN_OPFVF_TRANS(NAME, CHECK)                              \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)            \
> +{                                                                 \
> +    if (CHECK(s, a)) {                                            \
> +        uint32_t data = 0;                                        \
> +        static gen_helper_opfvf *const fns[3] = {                 \
> +            gen_helper_##NAME##_h,                                \
> +            gen_helper_##NAME##_w,                                \
> +            gen_helper_##NAME##_d,                                \
> +        };                                                        \
> +        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);            \
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);                \
> +        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);            \
> +        return opfvf_trans(a->rd, a->rs1, a->rs2, data,           \
> +                           fns[s->sew - 1], s);                   \
> +    }                                                             \
> +    return false;                                                 \
> +}
> +
> +GEN_OPFVF_TRANS(vfadd_vf,  opfvf_check)
> +GEN_OPFVF_TRANS(vfsub_vf,  opfvf_check)
> +GEN_OPFVF_TRANS(vfrsub_vf,  opfvf_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 502656d005..af343e9bf9 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -21,6 +21,7 @@
>  #include "exec/memop.h"
>  #include "exec/exec-all.h"
>  #include "exec/helper-proto.h"
> +#include "fpu/softfloat.h"
>  #include "tcg/tcg-gvec-desc.h"
>  #include "internals.h"
>  #include <math.h>
> @@ -3166,3 +3167,113 @@ RVVCALL(OPIVX2_RM, vnclipu_vx_w, NOP_UUU_W, H4, H8, vnclipu32)
>  GEN_VEXT_VX_RM(vnclipu_vx_b, 1, 1, clearb)
>  GEN_VEXT_VX_RM(vnclipu_vx_h, 2, 2, clearh)
>  GEN_VEXT_VX_RM(vnclipu_vx_w, 4, 4, clearl)
> +
> +/*
> + *** Vector Float Point Arithmetic Instructions
> + */
> +/* Vector Single-Width Floating-Point Add/Subtract Instructions */
> +#define OPFVV2(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)   \
> +static void do_##NAME(void *vd, void *vs1, void *vs2, int i,   \
> +                      CPURISCVState *env)                      \
> +{                                                              \
> +    TX1 s1 = *((T1 *)vs1 + HS1(i));                            \
> +    TX2 s2 = *((T2 *)vs2 + HS2(i));                            \
> +    *((TD *)vd + HD(i)) = OP(s2, s1, &env->fp_status);         \
> +}
> +
> +#define GEN_VEXT_VV_ENV(NAME, ESZ, DSZ, CLEAR_FN)         \
> +void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
> +                  void *vs2, CPURISCVState *env,          \
> +                  uint32_t desc)                          \
> +{                                                         \
> +    uint32_t vlmax = vext_maxsz(desc) / ESZ;              \
> +    uint32_t mlen = vext_mlen(desc);                      \
> +    uint32_t vm = vext_vm(desc);                          \
> +    uint32_t vl = env->vl;                                \
> +    uint32_t i;                                           \
> +                                                          \
> +    for (i = 0; i < vl; i++) {                            \
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {        \
> +            continue;                                     \
> +        }                                                 \
> +        do_##NAME(vd, vs1, vs2, i, env);                  \
> +    }                                                     \
> +    CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);             \
> +}
> +
> +RVVCALL(OPFVV2, vfadd_vv_h, OP_UUU_H, H2, H2, H2, float16_add)
> +RVVCALL(OPFVV2, vfadd_vv_w, OP_UUU_W, H4, H4, H4, float32_add)
> +RVVCALL(OPFVV2, vfadd_vv_d, OP_UUU_D, H8, H8, H8, float64_add)
> +GEN_VEXT_VV_ENV(vfadd_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_ENV(vfadd_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_ENV(vfadd_vv_d, 8, 8, clearq)
> +
> +#define OPFVF2(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)        \
> +static void do_##NAME(void *vd, uint64_t s1, void *vs2, int i, \
> +                      CPURISCVState *env)                      \
> +{                                                              \
> +    TX2 s2 = *((T2 *)vs2 + HS2(i));                            \
> +    *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)s1, &env->fp_status);\
> +}
> +
> +#define GEN_VEXT_VF(NAME, ESZ, DSZ, CLEAR_FN)             \
> +void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
> +                  void *vs2, CPURISCVState *env,          \
> +                  uint32_t desc)                          \
> +{                                                         \
> +    uint32_t vlmax = vext_maxsz(desc) / ESZ;              \
> +    uint32_t mlen = vext_mlen(desc);                      \
> +    uint32_t vm = vext_vm(desc);                          \
> +    uint32_t vl = env->vl;                                \
> +    uint32_t i;                                           \
> +                                                          \
> +    for (i = 0; i < vl; i++) {                            \
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {        \
> +            continue;                                     \
> +        }                                                 \
> +        do_##NAME(vd, s1, vs2, i, env);                   \
> +    }                                                     \
> +    CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);             \
> +}
> +
> +RVVCALL(OPFVF2, vfadd_vf_h, OP_UUU_H, H2, H2, float16_add)
> +RVVCALL(OPFVF2, vfadd_vf_w, OP_UUU_W, H4, H4, float32_add)
> +RVVCALL(OPFVF2, vfadd_vf_d, OP_UUU_D, H8, H8, float64_add)
> +GEN_VEXT_VF(vfadd_vf_h, 2, 2, clearh)
> +GEN_VEXT_VF(vfadd_vf_w, 4, 4, clearl)
> +GEN_VEXT_VF(vfadd_vf_d, 8, 8, clearq)
> +
> +RVVCALL(OPFVV2, vfsub_vv_h, OP_UUU_H, H2, H2, H2, float16_sub)
> +RVVCALL(OPFVV2, vfsub_vv_w, OP_UUU_W, H4, H4, H4, float32_sub)
> +RVVCALL(OPFVV2, vfsub_vv_d, OP_UUU_D, H8, H8, H8, float64_sub)
> +GEN_VEXT_VV_ENV(vfsub_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_ENV(vfsub_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_ENV(vfsub_vv_d, 8, 8, clearq)
> +RVVCALL(OPFVF2, vfsub_vf_h, OP_UUU_H, H2, H2, float16_sub)
> +RVVCALL(OPFVF2, vfsub_vf_w, OP_UUU_W, H4, H4, float32_sub)
> +RVVCALL(OPFVF2, vfsub_vf_d, OP_UUU_D, H8, H8, float64_sub)
> +GEN_VEXT_VF(vfsub_vf_h, 2, 2, clearh)
> +GEN_VEXT_VF(vfsub_vf_w, 4, 4, clearl)
> +GEN_VEXT_VF(vfsub_vf_d, 8, 8, clearq)
> +
> +static uint16_t float16_rsub(uint16_t a, uint16_t b, float_status *s)
> +{
> +    return float16_sub(b, a, s);
> +}
> +
> +static uint32_t float32_rsub(uint32_t a, uint32_t b, float_status *s)
> +{
> +    return float32_sub(b, a, s);
> +}
> +
> +static uint64_t float64_rsub(uint64_t a, uint64_t b, float_status *s)
> +{
> +    return float64_sub(b, a, s);
> +}
> +
> +RVVCALL(OPFVF2, vfrsub_vf_h, OP_UUU_H, H2, H2, float16_rsub)
> +RVVCALL(OPFVF2, vfrsub_vf_w, OP_UUU_W, H4, H4, float32_rsub)
> +RVVCALL(OPFVF2, vfrsub_vf_d, OP_UUU_D, H8, H8, float64_rsub)
> +GEN_VEXT_VF(vfrsub_vf_h, 2, 2, clearh)
> +GEN_VEXT_VF(vfrsub_vf_w, 4, 4, clearl)
> +GEN_VEXT_VF(vfrsub_vf_d, 8, 8, clearq)
> --
> 2.23.0
>

