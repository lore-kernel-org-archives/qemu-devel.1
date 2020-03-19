Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7381DC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 16:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD0B2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 16:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1d88KlF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD0B2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEyAA-0000Ty-D5
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 12:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jEy9X-0008Pd-Ed
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jEy9U-0004Ch-3Z
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:36:15 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:45765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jEy9T-0004BP-UQ; Thu, 19 Mar 2020 12:36:12 -0400
Received: by mail-vs1-xe43.google.com with SMTP id x82so2022789vsc.12;
 Thu, 19 Mar 2020 09:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZZS94slV67J1dYmXmt8iKQlv16Ntn00WElDK7E41sjM=;
 b=G1d88KlFfzfHiiGn2Bp+HBlk6ncKlVAZnxzDhL0OnaR/uVdj7S1wUnyPgpLoHcQ2Wz
 qJOU9nEot8z2ESLICE+QUGYwU4MIXUTkv75d5KcUhEnT2ohdK5kyd7LMexraCzKcJDqP
 DznS84Br/hE89dI+u4eaRo/5zIk4PdkEc3M1JW55HFtnHATfO6bTCaDtGgbtTHu5iFd+
 Iah2VebEY/e8bACIRsayFf/xQPy9v4GdaJbada4rn082iPqHh+EgZ9s+IameJMNro2QP
 NL/s+5R8VXIoSdPW3AcipSdju+rV3vHjg5tG3IQ2PG+AR7W1KZPjzvdTkhQtFuVVLjIJ
 KVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZZS94slV67J1dYmXmt8iKQlv16Ntn00WElDK7E41sjM=;
 b=SRTNUaIZj5ahA1lQTdw5WmqjUVVFiSq+yRWAnGkal+KmwOQ1RApwPsbsQB76EJTxBB
 HVB/vaVPX8A/XwcWkDssUl4oxYlKaGAjp5nk1bOle8S6CxZMZ858tmjTZQE09Og9ae2y
 B4l4nSNndyH+aQVUZ4zSWuWrVKv8UJGHXKs0sUxE6ryaZauv2o2wLnedADZXcAR3DUF+
 uF/WlydTtB+LQyam/Ro7oV8LkZECfyTXYqZ+TTO1lkYwD77pOJ150FGexkTsdBuLbbsp
 kGkPl03qvZVQfEaxaO07wT4F7kISUcB8P/2rdD6U6RVIs/Y5BalEPtJAQu+8otf8Zb0G
 //aQ==
X-Gm-Message-State: ANhLgQ3t8Lw8oTRUY4kkEmN/98Xv/YiBAOXzVbRTyzgmJFa/fHy6Y5Oq
 V/DjI/NML9QCRB6+XItMxbuCu15MtaCQBC6GTpA=
X-Google-Smtp-Source: ADFU+vsXo7VE0imgxKunrE32lFQwAMCgWMUpqLwEgYl3qkATCRy/U3BZDTdpw7c9n74nhhAEaVls54aq8kGRqSuB/rM=
X-Received: by 2002:a67:902:: with SMTP id 2mr3024177vsj.133.1584635770914;
 Thu, 19 Mar 2020 09:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-12-zhiwei_liu@c-sky.com>
In-Reply-To: <20200317150653.9008-12-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 19 Mar 2020 09:28:15 -0700
Message-ID: <CAKmqyKOR=3f97bqu9BjeK3UHb=+d5VmBhJWZ--H5zgQ4w_k=4g@mail.gmail.com>
Subject: Re: [PATCH v6 11/61] target/riscv: vector widening integer add and
 subtract
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e43
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

On Tue, Mar 17, 2020 at 8:29 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   |  49 +++++++
>  target/riscv/insn32.decode              |  16 +++
>  target/riscv/insn_trans/trans_rvv.inc.c | 178 ++++++++++++++++++++++++
>  target/riscv/vector_helper.c            | 111 +++++++++++++++
>  4 files changed, 354 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index e73701d4bb..1256defb6c 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -290,3 +290,52 @@ DEF_HELPER_6(vrsub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vrsub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vrsub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vrsub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +
> +DEF_HELPER_6(vwaddu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwaddu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwaddu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsubu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsubu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsubu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwadd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsub_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwaddu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwaddu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwaddu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsubu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsubu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsubu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwadd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwadd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwadd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwaddu_wv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwaddu_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwaddu_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsubu_wv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsubu_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsubu_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwadd_wv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwadd_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwadd_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsub_wv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsub_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsub_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwaddu_wx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwaddu_wx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwaddu_wx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsubu_wx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsubu_wx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsubu_wx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwadd_wx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwadd_wx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwadd_wx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsub_wx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsub_wx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsub_wx_w, void, ptr, ptr, tl, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index d1034a0e61..4bdbfd16fa 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -284,6 +284,22 @@ vsub_vv         000010 . ..... ..... 000 ..... 1010111 @r_vm
>  vsub_vx         000010 . ..... ..... 100 ..... 1010111 @r_vm
>  vrsub_vx        000011 . ..... ..... 100 ..... 1010111 @r_vm
>  vrsub_vi        000011 . ..... ..... 011 ..... 1010111 @r_vm
> +vwaddu_vv       110000 . ..... ..... 010 ..... 1010111 @r_vm
> +vwaddu_vx       110000 . ..... ..... 110 ..... 1010111 @r_vm
> +vwadd_vv        110001 . ..... ..... 010 ..... 1010111 @r_vm
> +vwadd_vx        110001 . ..... ..... 110 ..... 1010111 @r_vm
> +vwsubu_vv       110010 . ..... ..... 010 ..... 1010111 @r_vm
> +vwsubu_vx       110010 . ..... ..... 110 ..... 1010111 @r_vm
> +vwsub_vv        110011 . ..... ..... 010 ..... 1010111 @r_vm
> +vwsub_vx        110011 . ..... ..... 110 ..... 1010111 @r_vm
> +vwaddu_wv       110100 . ..... ..... 010 ..... 1010111 @r_vm
> +vwaddu_wx       110100 . ..... ..... 110 ..... 1010111 @r_vm
> +vwadd_wv        110101 . ..... ..... 010 ..... 1010111 @r_vm
> +vwadd_wx        110101 . ..... ..... 110 ..... 1010111 @r_vm
> +vwsubu_wv       110110 . ..... ..... 010 ..... 1010111 @r_vm
> +vwsubu_wx       110110 . ..... ..... 110 ..... 1010111 @r_vm
> +vwsub_wv        110111 . ..... ..... 010 ..... 1010111 @r_vm
> +vwsub_wx        110111 . ..... ..... 110 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index c68f6ffe3b..8f17faa3f3 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -128,6 +128,14 @@ static bool vext_check_nf(DisasContext *s, uint32_t nf)
>      return (1 << s->lmul) * nf <= 8;
>  }
>
> +/*
> + * The destination vector register group cannot overlap a source vector register
> + * group of a different element width. (Section 11.2)
> + */
> +static inline bool vext_check_overlap_group(int rd, int dlen, int rs, int slen)
> +{
> +    return ((rd >= rs + slen) || (rs >= rd + dlen));
> +}
>  /* common translation macro */
>  #define GEN_VEXT_TRANS(NAME, SEQ, ARGTYPE, OP, CHECK)      \
>  static bool trans_##NAME(DisasContext *s, arg_##ARGTYPE *a)\
> @@ -991,3 +999,173 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
>  }
>
>  GEN_OPIVI_TRANS(vrsub_vi, 0, vrsub_vx, opivx_check)
> +
> +/* Vector Widening Integer Add/Subtract */
> +
> +/* OPIVV with WIDEN */
> +static bool opivv_widen_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return (vext_check_isa_ill(s) &&
> +            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
> +            vext_check_reg(s, a->rd, true) &&
> +            vext_check_reg(s, a->rs2, false) &&
> +            vext_check_reg(s, a->rs1, false) &&
> +            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
> +                                     1 << s->lmul) &&
> +            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs1,
> +                                     1 << s->lmul) &&
> +            (s->lmul < 0x3) && (s->sew < 0x3));
> +}
> +
> +static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
> +                           gen_helper_gvec_4_ptr *fn,
> +                           bool (*checkfn)(DisasContext *, arg_rmrr *))
> +{
> +    if (checkfn(s, a)) {
> +        uint32_t data = 0;
> +        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);
> +        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
> +        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
> +                           vreg_ofs(s, a->rs1),
> +                           vreg_ofs(s, a->rs2),
> +                           cpu_env, 0, s->vlen / 8,
> +                           data, fn);
> +        return true;
> +    }
> +    return false;
> +}
> +
> +#define GEN_OPIVV_WIDEN_TRANS(NAME, CHECK) \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)       \
> +{                                                            \
> +    static gen_helper_gvec_4_ptr * const fns[3] = {          \
> +        gen_helper_##NAME##_b,                               \
> +        gen_helper_##NAME##_h,                               \
> +        gen_helper_##NAME##_w                                \
> +    };                                                       \
> +    return do_opivv_widen(s, a, fns[s->sew], CHECK);         \
> +}
> +
> +GEN_OPIVV_WIDEN_TRANS(vwaddu_vv, opivv_widen_check)
> +GEN_OPIVV_WIDEN_TRANS(vwadd_vv, opivv_widen_check)
> +GEN_OPIVV_WIDEN_TRANS(vwsubu_vv, opivv_widen_check)
> +GEN_OPIVV_WIDEN_TRANS(vwsub_vv, opivv_widen_check)
> +
> +/* OPIVX with WIDEN */
> +static bool opivx_widen_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return (vext_check_isa_ill(s) &&
> +            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
> +            vext_check_reg(s, a->rd, true) &&
> +            vext_check_reg(s, a->rs2, false) &&
> +            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
> +                                     1 << s->lmul) &&
> +            (s->lmul < 0x3) && (s->sew < 0x3));
> +}
> +
> +static bool do_opivx_widen(DisasContext *s, arg_rmrr *a,
> +                           gen_helper_opivx *fn)
> +{
> +    if (opivx_widen_check(s, a)) {
> +        return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
> +    }
> +    return true;
> +}
> +
> +#define GEN_OPIVX_WIDEN_TRANS(NAME) \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)       \
> +{                                                            \
> +    static gen_helper_opivx * const fns[3] = {               \
> +        gen_helper_##NAME##_b,                               \
> +        gen_helper_##NAME##_h,                               \
> +        gen_helper_##NAME##_w                                \
> +    };                                                       \
> +    return do_opivx_widen(s, a, fns[s->sew]);                \
> +}
> +
> +GEN_OPIVX_WIDEN_TRANS(vwaddu_vx)
> +GEN_OPIVX_WIDEN_TRANS(vwadd_vx)
> +GEN_OPIVX_WIDEN_TRANS(vwsubu_vx)
> +GEN_OPIVX_WIDEN_TRANS(vwsub_vx)
> +
> +/* WIDEN OPIVV with WIDEN */
> +static bool opiwv_widen_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return (vext_check_isa_ill(s) &&
> +            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
> +            vext_check_reg(s, a->rd, true) &&
> +            vext_check_reg(s, a->rs2, true) &&
> +            vext_check_reg(s, a->rs1, false) &&
> +            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs1,
> +                                     1 << s->lmul) &&
> +            (s->lmul < 0x3) && (s->sew < 0x3));
> +}
> +
> +static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
> +                           gen_helper_gvec_4_ptr *fn)
> +{
> +    if (opiwv_widen_check(s, a)) {
> +        uint32_t data = 0;
> +        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);
> +        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
> +        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
> +                           vreg_ofs(s, a->rs1),
> +                           vreg_ofs(s, a->rs2),
> +                           cpu_env, 0, s->vlen / 8, data, fn);
> +        return true;
> +    }
> +    return false;
> +}
> +
> +#define GEN_OPIWV_WIDEN_TRANS(NAME) \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)       \
> +{                                                            \
> +    static gen_helper_gvec_4_ptr * const fns[3] = {          \
> +        gen_helper_##NAME##_b,                               \
> +        gen_helper_##NAME##_h,                               \
> +        gen_helper_##NAME##_w                                \
> +    };                                                       \
> +    return do_opiwv_widen(s, a, fns[s->sew]);                \
> +}
> +
> +GEN_OPIWV_WIDEN_TRANS(vwaddu_wv)
> +GEN_OPIWV_WIDEN_TRANS(vwadd_wv)
> +GEN_OPIWV_WIDEN_TRANS(vwsubu_wv)
> +GEN_OPIWV_WIDEN_TRANS(vwsub_wv)
> +
> +/* WIDEN OPIVX with WIDEN */
> +static bool opiwx_widen_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return (vext_check_isa_ill(s) &&
> +            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
> +            vext_check_reg(s, a->rd, true) &&
> +            vext_check_reg(s, a->rs2, true) &&
> +            (s->lmul < 0x3) && (s->sew < 0x3));
> +}
> +
> +static bool do_opiwx_widen(DisasContext *s, arg_rmrr *a,
> +                           gen_helper_opivx *fn)
> +{
> +    if (opiwx_widen_check(s, a)) {
> +        return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
> +    }
> +    return false;
> +}
> +
> +#define GEN_OPIWX_WIDEN_TRANS(NAME) \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)       \
> +{                                                            \
> +    static gen_helper_opivx * const fns[3] = {               \
> +        gen_helper_##NAME##_b,                               \
> +        gen_helper_##NAME##_h,                               \
> +        gen_helper_##NAME##_w                                \
> +    };                                                       \
> +    return do_opiwx_widen(s, a, fns[s->sew]);                \
> +}
> +
> +GEN_OPIWX_WIDEN_TRANS(vwaddu_wx)
> +GEN_OPIWX_WIDEN_TRANS(vwadd_wx)
> +GEN_OPIWX_WIDEN_TRANS(vwsubu_wx)
> +GEN_OPIWX_WIDEN_TRANS(vwsub_wx)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 27934e291b..d0e6f12f43 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -976,3 +976,114 @@ GEN_VEXT_VX(vrsub_vx_b, 1, 1, clearb)
>  GEN_VEXT_VX(vrsub_vx_h, 2, 2, clearh)
>  GEN_VEXT_VX(vrsub_vx_w, 4, 4, clearl)
>  GEN_VEXT_VX(vrsub_vx_d, 8, 8, clearq)
> +
> +/* Vector Widening Integer Add/Subtract */
> +#define WOP_UUU_B uint16_t, uint8_t, uint8_t, uint16_t, uint16_t
> +#define WOP_UUU_H uint32_t, uint16_t, uint16_t, uint32_t, uint32_t
> +#define WOP_UUU_W uint64_t, uint32_t, uint32_t, uint64_t, uint64_t
> +#define WOP_SSS_B int16_t, int8_t, int8_t, int16_t, int16_t
> +#define WOP_SSS_H int32_t, int16_t, int16_t, int32_t, int32_t
> +#define WOP_SSS_W int64_t, int32_t, int32_t, int64_t, int64_t
> +#define WOP_WUUU_B  uint16_t, uint8_t, uint16_t, uint16_t, uint16_t
> +#define WOP_WUUU_H  uint32_t, uint16_t, uint32_t, uint32_t, uint32_t
> +#define WOP_WUUU_W  uint64_t, uint32_t, uint64_t, uint64_t, uint64_t
> +#define WOP_WSSS_B  int16_t, int8_t, int16_t, int16_t, int16_t
> +#define WOP_WSSS_H  int32_t, int16_t, int32_t, int32_t, int32_t
> +#define WOP_WSSS_W  int64_t, int32_t, int64_t, int64_t, int64_t
> +RVVCALL(OPIVV2, vwaddu_vv_b, WOP_UUU_B, H2, H1, H1, DO_ADD)
> +RVVCALL(OPIVV2, vwaddu_vv_h, WOP_UUU_H, H4, H2, H2, DO_ADD)
> +RVVCALL(OPIVV2, vwaddu_vv_w, WOP_UUU_W, H8, H4, H4, DO_ADD)
> +RVVCALL(OPIVV2, vwsubu_vv_b, WOP_UUU_B, H2, H1, H1, DO_SUB)
> +RVVCALL(OPIVV2, vwsubu_vv_h, WOP_UUU_H, H4, H2, H2, DO_SUB)
> +RVVCALL(OPIVV2, vwsubu_vv_w, WOP_UUU_W, H8, H4, H4, DO_SUB)
> +RVVCALL(OPIVV2, vwadd_vv_b, WOP_SSS_B, H2, H1, H1, DO_ADD)
> +RVVCALL(OPIVV2, vwadd_vv_h, WOP_SSS_H, H4, H2, H2, DO_ADD)
> +RVVCALL(OPIVV2, vwadd_vv_w, WOP_SSS_W, H8, H4, H4, DO_ADD)
> +RVVCALL(OPIVV2, vwsub_vv_b, WOP_SSS_B, H2, H1, H1, DO_SUB)
> +RVVCALL(OPIVV2, vwsub_vv_h, WOP_SSS_H, H4, H2, H2, DO_SUB)
> +RVVCALL(OPIVV2, vwsub_vv_w, WOP_SSS_W, H8, H4, H4, DO_SUB)
> +RVVCALL(OPIVV2, vwaddu_wv_b, WOP_WUUU_B, H2, H1, H1, DO_ADD)
> +RVVCALL(OPIVV2, vwaddu_wv_h, WOP_WUUU_H, H4, H2, H2, DO_ADD)
> +RVVCALL(OPIVV2, vwaddu_wv_w, WOP_WUUU_W, H8, H4, H4, DO_ADD)
> +RVVCALL(OPIVV2, vwsubu_wv_b, WOP_WUUU_B, H2, H1, H1, DO_SUB)
> +RVVCALL(OPIVV2, vwsubu_wv_h, WOP_WUUU_H, H4, H2, H2, DO_SUB)
> +RVVCALL(OPIVV2, vwsubu_wv_w, WOP_WUUU_W, H8, H4, H4, DO_SUB)
> +RVVCALL(OPIVV2, vwadd_wv_b, WOP_WSSS_B, H2, H1, H1, DO_ADD)
> +RVVCALL(OPIVV2, vwadd_wv_h, WOP_WSSS_H, H4, H2, H2, DO_ADD)
> +RVVCALL(OPIVV2, vwadd_wv_w, WOP_WSSS_W, H8, H4, H4, DO_ADD)
> +RVVCALL(OPIVV2, vwsub_wv_b, WOP_WSSS_B, H2, H1, H1, DO_SUB)
> +RVVCALL(OPIVV2, vwsub_wv_h, WOP_WSSS_H, H4, H2, H2, DO_SUB)
> +RVVCALL(OPIVV2, vwsub_wv_w, WOP_WSSS_W, H8, H4, H4, DO_SUB)
> +GEN_VEXT_VV(vwaddu_vv_b, 1, 2, clearh)
> +GEN_VEXT_VV(vwaddu_vv_h, 2, 4, clearl)
> +GEN_VEXT_VV(vwaddu_vv_w, 4, 8, clearq)
> +GEN_VEXT_VV(vwsubu_vv_b, 1, 2, clearh)
> +GEN_VEXT_VV(vwsubu_vv_h, 2, 4, clearl)
> +GEN_VEXT_VV(vwsubu_vv_w, 4, 8, clearq)
> +GEN_VEXT_VV(vwadd_vv_b, 1, 2, clearh)
> +GEN_VEXT_VV(vwadd_vv_h, 2, 4, clearl)
> +GEN_VEXT_VV(vwadd_vv_w, 4, 8, clearq)
> +GEN_VEXT_VV(vwsub_vv_b, 1, 2, clearh)
> +GEN_VEXT_VV(vwsub_vv_h, 2, 4, clearl)
> +GEN_VEXT_VV(vwsub_vv_w, 4, 8, clearq)
> +GEN_VEXT_VV(vwaddu_wv_b, 1, 2, clearh)
> +GEN_VEXT_VV(vwaddu_wv_h, 2, 4, clearl)
> +GEN_VEXT_VV(vwaddu_wv_w, 4, 8, clearq)
> +GEN_VEXT_VV(vwsubu_wv_b, 1, 2, clearh)
> +GEN_VEXT_VV(vwsubu_wv_h, 2, 4, clearl)
> +GEN_VEXT_VV(vwsubu_wv_w, 4, 8, clearq)
> +GEN_VEXT_VV(vwadd_wv_b, 1, 2, clearh)
> +GEN_VEXT_VV(vwadd_wv_h, 2, 4, clearl)
> +GEN_VEXT_VV(vwadd_wv_w, 4, 8, clearq)
> +GEN_VEXT_VV(vwsub_wv_b, 1, 2, clearh)
> +GEN_VEXT_VV(vwsub_wv_h, 2, 4, clearl)
> +GEN_VEXT_VV(vwsub_wv_w, 4, 8, clearq)
> +
> +RVVCALL(OPIVX2, vwaddu_vx_b, WOP_UUU_B, H2, H1, DO_ADD)
> +RVVCALL(OPIVX2, vwaddu_vx_h, WOP_UUU_H, H4, H2, DO_ADD)
> +RVVCALL(OPIVX2, vwaddu_vx_w, WOP_UUU_W, H8, H4, DO_ADD)
> +RVVCALL(OPIVX2, vwsubu_vx_b, WOP_UUU_B, H2, H1, DO_SUB)
> +RVVCALL(OPIVX2, vwsubu_vx_h, WOP_UUU_H, H4, H2, DO_SUB)
> +RVVCALL(OPIVX2, vwsubu_vx_w, WOP_UUU_W, H8, H4, DO_SUB)
> +RVVCALL(OPIVX2, vwadd_vx_b, WOP_SSS_B, H2, H1, DO_ADD)
> +RVVCALL(OPIVX2, vwadd_vx_h, WOP_SSS_H, H4, H2, DO_ADD)
> +RVVCALL(OPIVX2, vwadd_vx_w, WOP_SSS_W, H8, H4, DO_ADD)
> +RVVCALL(OPIVX2, vwsub_vx_b, WOP_SSS_B, H2, H1, DO_SUB)
> +RVVCALL(OPIVX2, vwsub_vx_h, WOP_SSS_H, H4, H2, DO_SUB)
> +RVVCALL(OPIVX2, vwsub_vx_w, WOP_SSS_W, H8, H4, DO_SUB)
> +RVVCALL(OPIVX2, vwaddu_wx_b, WOP_WUUU_B, H2, H1, DO_ADD)
> +RVVCALL(OPIVX2, vwaddu_wx_h, WOP_WUUU_H, H4, H2, DO_ADD)
> +RVVCALL(OPIVX2, vwaddu_wx_w, WOP_WUUU_W, H8, H4, DO_ADD)
> +RVVCALL(OPIVX2, vwsubu_wx_b, WOP_WUUU_B, H2, H1, DO_SUB)
> +RVVCALL(OPIVX2, vwsubu_wx_h, WOP_WUUU_H, H4, H2, DO_SUB)
> +RVVCALL(OPIVX2, vwsubu_wx_w, WOP_WUUU_W, H8, H4, DO_SUB)
> +RVVCALL(OPIVX2, vwadd_wx_b, WOP_WSSS_B, H2, H1, DO_ADD)
> +RVVCALL(OPIVX2, vwadd_wx_h, WOP_WSSS_H, H4, H2, DO_ADD)
> +RVVCALL(OPIVX2, vwadd_wx_w, WOP_WSSS_W, H8, H4, DO_ADD)
> +RVVCALL(OPIVX2, vwsub_wx_b, WOP_WSSS_B, H2, H1, DO_SUB)
> +RVVCALL(OPIVX2, vwsub_wx_h, WOP_WSSS_H, H4, H2, DO_SUB)
> +RVVCALL(OPIVX2, vwsub_wx_w, WOP_WSSS_W, H8, H4, DO_SUB)
> +GEN_VEXT_VX(vwaddu_vx_b, 1, 2, clearh)
> +GEN_VEXT_VX(vwaddu_vx_h, 2, 4, clearl)
> +GEN_VEXT_VX(vwaddu_vx_w, 4, 8, clearq)
> +GEN_VEXT_VX(vwsubu_vx_b, 1, 2, clearh)
> +GEN_VEXT_VX(vwsubu_vx_h, 2, 4, clearl)
> +GEN_VEXT_VX(vwsubu_vx_w, 4, 8, clearq)
> +GEN_VEXT_VX(vwadd_vx_b, 1, 2, clearh)
> +GEN_VEXT_VX(vwadd_vx_h, 2, 4, clearl)
> +GEN_VEXT_VX(vwadd_vx_w, 4, 8, clearq)
> +GEN_VEXT_VX(vwsub_vx_b, 1, 2, clearh)
> +GEN_VEXT_VX(vwsub_vx_h, 2, 4, clearl)
> +GEN_VEXT_VX(vwsub_vx_w, 4, 8, clearq)
> +GEN_VEXT_VX(vwaddu_wx_b, 1, 2, clearh)
> +GEN_VEXT_VX(vwaddu_wx_h, 2, 4, clearl)
> +GEN_VEXT_VX(vwaddu_wx_w, 4, 8, clearq)
> +GEN_VEXT_VX(vwsubu_wx_b, 1, 2, clearh)
> +GEN_VEXT_VX(vwsubu_wx_h, 2, 4, clearl)
> +GEN_VEXT_VX(vwsubu_wx_w, 4, 8, clearq)
> +GEN_VEXT_VX(vwadd_wx_b, 1, 2, clearh)
> +GEN_VEXT_VX(vwadd_wx_h, 2, 4, clearl)
> +GEN_VEXT_VX(vwadd_wx_w, 4, 8, clearq)
> +GEN_VEXT_VX(vwsub_wx_b, 1, 2, clearh)
> +GEN_VEXT_VX(vwsub_wx_h, 2, 4, clearl)
> +GEN_VEXT_VX(vwsub_wx_w, 4, 8, clearq)
> --
> 2.23.0
>

