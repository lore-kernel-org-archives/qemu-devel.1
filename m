Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619CBC4332E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3427420781
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrHxWduk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3427420781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFMl5-0006zS-AN
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 14:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jFMkJ-0006YJ-Ax
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jFMkH-0004At-TZ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:51:51 -0400
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43]:43226)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jFMkH-0004Ae-N4; Fri, 20 Mar 2020 14:51:49 -0400
Received: by mail-vk1-xa43.google.com with SMTP id t3so2025640vkm.10;
 Fri, 20 Mar 2020 11:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6xJP+kSsXtFzVS4Re3XHnZdAIdkIR4f7k/pFnNFvlUE=;
 b=KrHxWduk7QkpPq7K1tmCOacevLTgVhheT8LlAHxbUxewIm1adh8EVtl6LtgchcPAt4
 rFp3Z6BEhrc/4dAJe6LlPtQggBcrWVN+cLZWBkpgk65LIsYJuLUNKFatEd+twlqL+nFm
 dm39zgya7DemT0t2z1ADrSAcbqrbU+DtIgRyEzpTs8ETSu+RPEstjl8LWQYvhWec64qJ
 iP++n58to9WEtuf9JrGWO2dD98eWaDtE09haV9YUYh/74bB2ARb7rPsnIUSPeXdG2RJL
 Lx8rA0ODz5cpiX8IuZQOiYj+n1qrPgP7s0v3MdlhhhZHK1pDoiI2FCANKnv8zfIAwTI0
 1beQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6xJP+kSsXtFzVS4Re3XHnZdAIdkIR4f7k/pFnNFvlUE=;
 b=rCSw7qaIkl4oD7cPq+4CVAUEj1/bZ1wHmznaNgfUidV/LWwqeuyUUrprN6gDWmLb+K
 26X7EgiSgxbaNztByHkpTresF52nrr6hK6HCuN00eb8XA082RqN66m9RtPLLIU4UoEAW
 U6sCTj26Ub1ROELbhpr8GiIArMUogbYVi9d40oMOsxw0OjKjDJwB0KTVkEgKlHtRu1DJ
 lsY7amByVzZ2Aq8RkEzxS81TVvps2p8JaaYItjFlQwmA+LoMz8yYonp2nzo7ow+QhPIL
 6qvXYtyiKOI5TXfJJwV7kctHLMTsysULDThPK8Px9LaUsM7H8fRlz5Ce+RqI+uOpV9iD
 DBvw==
X-Gm-Message-State: ANhLgQ0M0fmf+u5F05OccyOxMZVxnGqv7GjQiJC9lGvBvzjh5pujgdhc
 1ccW/wmA7xFn/FB4vEw3ljkb/D1Am5s5LmqcNk8=
X-Google-Smtp-Source: ADFU+vuL34JCpq8CQZ/aIO75C/Tq8Qs3m0QHm89N2sx5sEpYgt06Whh7shnSuHXms90tzLIRYBJQNGkAiw7O6Vtp+bc=
X-Received: by 2002:a1f:4c86:: with SMTP id z128mr6592123vka.70.1584730308953; 
 Fri, 20 Mar 2020 11:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-16-zhiwei_liu@c-sky.com>
In-Reply-To: <20200317150653.9008-16-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 20 Mar 2020 11:43:51 -0700
Message-ID: <CAKmqyKMLPCaHnNQXmpA9+smYrbB3khS9C4YzX7sBT1F46EPqyQ@mail.gmail.com>
Subject: Re: [PATCH v6 15/61] target/riscv: vector narrowing integer right
 shift instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a43
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

On Tue, Mar 17, 2020 at 8:37 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   | 13 ++++
>  target/riscv/insn32.decode              |  6 ++
>  target/riscv/insn_trans/trans_rvv.inc.c | 85 +++++++++++++++++++++++++
>  target/riscv/vector_helper.c            | 14 ++++
>  4 files changed, 118 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 47284c7476..0f36a8ce43 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -422,3 +422,16 @@ DEF_HELPER_6(vsra_vx_b, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vsra_vx_h, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vsra_vx_w, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vsra_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +
> +DEF_HELPER_6(vnsrl_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vnsrl_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vnsrl_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vnsra_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vnsra_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vnsra_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vnsrl_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vnsrl_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vnsrl_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vnsra_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vnsra_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vnsra_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index f6d0f5aec5..89fd2aa4e2 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -329,6 +329,12 @@ vsrl_vi         101000 . ..... ..... 011 ..... 1010111 @r_vm
>  vsra_vv         101001 . ..... ..... 000 ..... 1010111 @r_vm
>  vsra_vx         101001 . ..... ..... 100 ..... 1010111 @r_vm
>  vsra_vi         101001 . ..... ..... 011 ..... 1010111 @r_vm
> +vnsrl_vv        101100 . ..... ..... 000 ..... 1010111 @r_vm
> +vnsrl_vx        101100 . ..... ..... 100 ..... 1010111 @r_vm
> +vnsrl_vi        101100 . ..... ..... 011 ..... 1010111 @r_vm
> +vnsra_vv        101101 . ..... ..... 000 ..... 1010111 @r_vm
> +vnsra_vx        101101 . ..... ..... 100 ..... 1010111 @r_vm
> +vnsra_vi        101101 . ..... ..... 011 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 6ed2466e75..a537b507a0 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -1312,3 +1312,88 @@ GEN_OPIVX_GVEC_SHIFT_TRANS(vsra_vx,  sars)
>  GEN_OPIVI_GVEC_TRANS(vsll_vi, 1, vsll_vx,  shli)
>  GEN_OPIVI_GVEC_TRANS(vsrl_vi, 1, vsrl_vx,  shri)
>  GEN_OPIVI_GVEC_TRANS(vsra_vi, 1, vsra_vx,  sari)
> +
> +/* Vector Narrowing Integer Right Shift Instructions */
> +static bool opivv_narrow_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return (vext_check_isa_ill(s) &&
> +            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
> +            vext_check_reg(s, a->rd, false) &&
> +            vext_check_reg(s, a->rs2, true) &&
> +            vext_check_reg(s, a->rs1, false) &&
> +            vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs2,
> +                2 << s->lmul) &&
> +            (s->lmul < 0x3) && (s->sew < 0x3));
> +}
> +
> +/* OPIVV with NARROW */
> +#define GEN_OPIVV_NARROW_TRANS(NAME)                               \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
> +{                                                                  \
> +    if (opivv_narrow_check(s, a)) {                                \
> +        uint32_t data = 0;                                         \
> +        static gen_helper_gvec_4_ptr * const fns[3] = {            \
> +            gen_helper_##NAME##_b,                                 \
> +            gen_helper_##NAME##_h,                                 \
> +            gen_helper_##NAME##_w,                                 \
> +        };                                                         \
> +        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
> +        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> +        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
> +            vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),              \
> +            cpu_env, 0, s->vlen / 8, data, fns[s->sew]);           \
> +        return true;                                               \
> +    }                                                              \
> +    return false;                                                  \
> +}
> +GEN_OPIVV_NARROW_TRANS(vnsra_vv)
> +GEN_OPIVV_NARROW_TRANS(vnsrl_vv)
> +
> +static bool opivx_narrow_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return (vext_check_isa_ill(s) &&
> +            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
> +            vext_check_reg(s, a->rd, false) &&
> +            vext_check_reg(s, a->rs2, true) &&
> +            vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs2,
> +                2 << s->lmul) &&
> +            (s->lmul < 0x3) && (s->sew < 0x3));
> +}
> +
> +/* OPIVX with NARROW */
> +#define GEN_OPIVX_NARROW_TRANS(NAME)                                     \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
> +{                                                                        \
> +    if (opivx_narrow_check(s, a)) {                                      \
> +        static gen_helper_opivx * const fns[3] = {                         \
> +            gen_helper_##NAME##_b,                                       \
> +            gen_helper_##NAME##_h,                                       \
> +            gen_helper_##NAME##_w,                                       \
> +        };                                                               \
> +        return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fns[s->sew], s);\
> +    }                                                                    \
> +    return false;                                                        \
> +}
> +
> +GEN_OPIVX_NARROW_TRANS(vnsra_vx)
> +GEN_OPIVX_NARROW_TRANS(vnsrl_vx)
> +
> +/* OPIVI with NARROW */
> +#define GEN_OPIVI_NARROW_TRANS(NAME, ZX, OPIVX)                          \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
> +{                                                                        \
> +    if (opivx_narrow_check(s, a)) {                                      \
> +        static gen_helper_opivx * const fns[3] = {                         \
> +            gen_helper_##OPIVX##_b,                                      \
> +            gen_helper_##OPIVX##_h,                                      \
> +            gen_helper_##OPIVX##_w,                                      \
> +        };                                                               \
> +        return opivi_trans(a->rd, a->rs1, a->rs2, a->vm,                 \
> +                fns[s->sew], s, ZX);                                     \
> +    }                                                                    \
> +    return false;                                                        \
> +}
> +
> +GEN_OPIVI_NARROW_TRANS(vnsra_vi, 1, vnsra_vx)
> +GEN_OPIVI_NARROW_TRANS(vnsrl_vi, 1, vnsrl_vx)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index c3518516f0..8d1f32a7ff 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -1371,3 +1371,17 @@ GEN_VEXT_SHIFT_VX(vsra_vx_b, int8_t, int8_t, H1, H1, DO_SRL, 0x7, clearb)
>  GEN_VEXT_SHIFT_VX(vsra_vx_h, int16_t, int16_t, H2, H2, DO_SRL, 0xf, clearh)
>  GEN_VEXT_SHIFT_VX(vsra_vx_w, int32_t, int32_t, H4, H4, DO_SRL, 0x1f, clearl)
>  GEN_VEXT_SHIFT_VX(vsra_vx_d, int64_t, int64_t, H8, H8, DO_SRL, 0x3f, clearq)
> +
> +/* Vector Narrowing Integer Right Shift Instructions */
> +GEN_VEXT_SHIFT_VV(vnsrl_vv_b, uint8_t,  uint16_t, H1, H2, DO_SRL, 0xf, clearb)
> +GEN_VEXT_SHIFT_VV(vnsrl_vv_h, uint16_t, uint32_t, H2, H4, DO_SRL, 0x1f, clearh)
> +GEN_VEXT_SHIFT_VV(vnsrl_vv_w, uint32_t, uint64_t, H4, H8, DO_SRL, 0x3f, clearl)
> +GEN_VEXT_SHIFT_VV(vnsra_vv_b, uint8_t,  int16_t, H1, H2, DO_SRL, 0xf, clearb)
> +GEN_VEXT_SHIFT_VV(vnsra_vv_h, uint16_t, int32_t, H2, H4, DO_SRL, 0x1f, clearh)
> +GEN_VEXT_SHIFT_VV(vnsra_vv_w, uint32_t, int64_t, H4, H8, DO_SRL, 0x3f, clearl)
> +GEN_VEXT_SHIFT_VX(vnsrl_vx_b, uint8_t, uint16_t, H1, H2, DO_SRL, 0xf, clearb)
> +GEN_VEXT_SHIFT_VX(vnsrl_vx_h, uint16_t, uint32_t, H2, H4, DO_SRL, 0x1f, clearh)
> +GEN_VEXT_SHIFT_VX(vnsrl_vx_w, uint32_t, uint64_t, H4, H8, DO_SRL, 0x3f, clearl)
> +GEN_VEXT_SHIFT_VX(vnsra_vx_b, int8_t, int16_t, H1, H2, DO_SRL, 0xf, clearb)
> +GEN_VEXT_SHIFT_VX(vnsra_vx_h, int16_t, int32_t, H2, H4, DO_SRL, 0x1f, clearh)
> +GEN_VEXT_SHIFT_VX(vnsra_vx_w, int32_t, int64_t, H4, H8, DO_SRL, 0x3f, clearl)
> --
> 2.23.0
>

