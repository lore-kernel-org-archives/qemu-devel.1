Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1FBC2D0E6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:40:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66CEE20870
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCdNckaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CEE20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHA1R-0003fk-LT
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 13:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jHA0j-00034q-6J
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jHA0h-00009g-57
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:40:13 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:44410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jHA0g-00008K-Um; Wed, 25 Mar 2020 13:40:11 -0400
Received: by mail-vs1-xe44.google.com with SMTP id e138so2031474vsc.11;
 Wed, 25 Mar 2020 10:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=r3EKzac6qfncIVY+nX+OVoByEXFvUZNenf0FAKJ+ghI=;
 b=gCdNckaCQ/K+tNTKKAZtWSAkhMwduy47EEtce2txAZ1zhf7N/zKfqAVUJmGkJMJgHr
 wR56Opa9nznFmpkMmLCzTcH8zQAumCQIU6xwggbo7muJ/rjBNR1bXRtA8/ivfBeNkHpr
 Wre50x4INf+WkTQ8AZSdnxN/gsG+zc+jvhXJui4TQIu7HAD0VvlnQbzoOzN3HvtH4Bd1
 D+VNqwSXCloQcosekRkBgTO1gu5/QtXWXqePsYDO/aKeCGq1PssYdUAJotbwVGA/kngx
 XrWPiusMcFGc1Obn8IuVzyCvsrJcotqgSxtut9RUHzgA8+/qBZBW4XXsvzSe26HvZF3u
 lNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r3EKzac6qfncIVY+nX+OVoByEXFvUZNenf0FAKJ+ghI=;
 b=iTwREcJHl2uNhsFfWYOGZUtyMCracL3P4ds9mBBC59ZqR8Kf9PRE4FBkL+e/7bZHOM
 w4MytpdqCaREk0k4mgA25y+Bv7Whi715kww3UdYgdUtzkT8/0W2CbHBzjV2gqIClkcL6
 MIAkdYauH4vVI9a4qNcyF5d7B4T6wcquSBAQnd2R7JUkQNjqYvn7p6YKC9W+VCd9JC9U
 ch+VK8skF+sxfhS3zpR4s4GykwXqScLildOqPywmJ29S5nKxlHMJK9UrvqpXADGSfAYz
 vLh3w7RrMH9DwbHXyqX/AxROJaFe7HQyz8V+F19kU3VZ6qwldrEiYhqpe76cRoJdtnmF
 EVkQ==
X-Gm-Message-State: ANhLgQ3tSwg9YrP2+l8SkTgi2xWfXbJ1rUlehtWALUb3JHyQtBRu/WXl
 HBoiIsrgn99XAkUORth96twHhQjv7Ij/TVhjANM=
X-Google-Smtp-Source: ADFU+vunWcGRRYdD2bn/P0Ik+3k3juPg8GJGo4mck8Bnb0RXoRaG/rU4PMY5otsJT77Op3tLDp8nEdukE87n2reIJwo=
X-Received: by 2002:a67:8a88:: with SMTP id m130mr3602658vsd.70.1585158010149; 
 Wed, 25 Mar 2020 10:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-17-zhiwei_liu@c-sky.com>
In-Reply-To: <20200317150653.9008-17-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2020 10:32:10 -0700
Message-ID: <CAKmqyKNdZyTiBhW+uNbyaVxmpO4GsUFCXu7titVzAkx8OvAzOQ@mail.gmail.com>
Subject: Re: [PATCH v6 16/61] target/riscv: vector integer comparison
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e44
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

On Tue, Mar 17, 2020 at 8:39 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   |  57 +++++++++++
>  target/riscv/insn32.decode              |  20 ++++
>  target/riscv/insn_trans/trans_rvv.inc.c |  45 +++++++++
>  target/riscv/vector_helper.c            | 129 ++++++++++++++++++++++++
>  4 files changed, 251 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 0f36a8ce43..4e6c47c2d2 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -435,3 +435,60 @@ DEF_HELPER_6(vnsrl_vx_w, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vnsra_vx_b, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vnsra_vx_h, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vnsra_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +
> +DEF_HELPER_6(vmseq_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmseq_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmseq_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmseq_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmsne_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmsne_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmsne_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmsne_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmsltu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmsltu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmsltu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmsltu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmslt_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmslt_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmslt_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmslt_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmsleu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmsleu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmsleu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmsleu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmsle_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmsle_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmsle_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmsle_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmseq_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmseq_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmseq_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmseq_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsne_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsne_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsne_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsne_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsltu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsltu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsltu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsltu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmslt_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmslt_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmslt_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmslt_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsleu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsleu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsleu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsleu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsle_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsle_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsle_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsle_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsgtu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsgtu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsgtu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsgtu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsgt_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsgt_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsgt_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmsgt_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 89fd2aa4e2..df6181980d 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -335,6 +335,26 @@ vnsrl_vi        101100 . ..... ..... 011 ..... 1010111 @r_vm
>  vnsra_vv        101101 . ..... ..... 000 ..... 1010111 @r_vm
>  vnsra_vx        101101 . ..... ..... 100 ..... 1010111 @r_vm
>  vnsra_vi        101101 . ..... ..... 011 ..... 1010111 @r_vm
> +vmseq_vv        011000 . ..... ..... 000 ..... 1010111 @r_vm
> +vmseq_vx        011000 . ..... ..... 100 ..... 1010111 @r_vm
> +vmseq_vi        011000 . ..... ..... 011 ..... 1010111 @r_vm
> +vmsne_vv        011001 . ..... ..... 000 ..... 1010111 @r_vm
> +vmsne_vx        011001 . ..... ..... 100 ..... 1010111 @r_vm
> +vmsne_vi        011001 . ..... ..... 011 ..... 1010111 @r_vm
> +vmsltu_vv       011010 . ..... ..... 000 ..... 1010111 @r_vm
> +vmsltu_vx       011010 . ..... ..... 100 ..... 1010111 @r_vm
> +vmslt_vv        011011 . ..... ..... 000 ..... 1010111 @r_vm
> +vmslt_vx        011011 . ..... ..... 100 ..... 1010111 @r_vm
> +vmsleu_vv       011100 . ..... ..... 000 ..... 1010111 @r_vm
> +vmsleu_vx       011100 . ..... ..... 100 ..... 1010111 @r_vm
> +vmsleu_vi       011100 . ..... ..... 011 ..... 1010111 @r_vm
> +vmsle_vv        011101 . ..... ..... 000 ..... 1010111 @r_vm
> +vmsle_vx        011101 . ..... ..... 100 ..... 1010111 @r_vm
> +vmsle_vi        011101 . ..... ..... 011 ..... 1010111 @r_vm
> +vmsgtu_vx       011110 . ..... ..... 100 ..... 1010111 @r_vm
> +vmsgtu_vi       011110 . ..... ..... 011 ..... 1010111 @r_vm
> +vmsgt_vx        011111 . ..... ..... 100 ..... 1010111 @r_vm
> +vmsgt_vi        011111 . ..... ..... 011 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index a537b507a0..53c00d914f 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -1397,3 +1397,48 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
>
>  GEN_OPIVI_NARROW_TRANS(vnsra_vi, 1, vnsra_vx)
>  GEN_OPIVI_NARROW_TRANS(vnsrl_vi, 1, vnsrl_vx)
> +
> +/* Vector Integer Comparison Instructions */
> +/*
> + * For all comparison instructions, an illegal instruction exception is raised
> + * if the destination vector register overlaps a source vector register group
> + * and LMUL > 1.
> + */
> +static bool opivv_cmp_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return (vext_check_isa_ill(s) &&
> +            vext_check_reg(s, a->rs2, false) &&
> +            vext_check_reg(s, a->rs1, false) &&
> +            ((vext_check_overlap_group(a->rd, 1, a->rs1, 1 << s->lmul) &&
> +            vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul)) ||
> +            (s->lmul == 0)));
> +}
> +GEN_OPIVV_TRANS(vmseq_vv, opivv_cmp_check)
> +GEN_OPIVV_TRANS(vmsne_vv, opivv_cmp_check)
> +GEN_OPIVV_TRANS(vmsltu_vv, opivv_cmp_check)
> +GEN_OPIVV_TRANS(vmslt_vv, opivv_cmp_check)
> +GEN_OPIVV_TRANS(vmsleu_vv, opivv_cmp_check)
> +GEN_OPIVV_TRANS(vmsle_vv, opivv_cmp_check)
> +
> +static bool opivx_cmp_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return (vext_check_isa_ill(s) &&
> +            vext_check_reg(s, a->rs2, false) &&
> +            (vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul) ||
> +            (s->lmul == 0)));
> +}
> +GEN_OPIVX_TRANS(vmseq_vx, opivx_cmp_check)
> +GEN_OPIVX_TRANS(vmsne_vx, opivx_cmp_check)
> +GEN_OPIVX_TRANS(vmsltu_vx, opivx_cmp_check)
> +GEN_OPIVX_TRANS(vmslt_vx, opivx_cmp_check)
> +GEN_OPIVX_TRANS(vmsleu_vx, opivx_cmp_check)
> +GEN_OPIVX_TRANS(vmsle_vx, opivx_cmp_check)
> +GEN_OPIVX_TRANS(vmsgtu_vx, opivx_cmp_check)
> +GEN_OPIVX_TRANS(vmsgt_vx, opivx_cmp_check)
> +
> +GEN_OPIVI_TRANS(vmseq_vi, 0, vmseq_vx, opivx_cmp_check)
> +GEN_OPIVI_TRANS(vmsne_vi, 0, vmsne_vx, opivx_cmp_check)
> +GEN_OPIVI_TRANS(vmsleu_vi, 1, vmsleu_vx, opivx_cmp_check)
> +GEN_OPIVI_TRANS(vmsle_vi, 0, vmsle_vx, opivx_cmp_check)
> +GEN_OPIVI_TRANS(vmsgtu_vi, 1, vmsgtu_vx, opivx_cmp_check)
> +GEN_OPIVI_TRANS(vmsgt_vi, 0, vmsgt_vx, opivx_cmp_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 8d1f32a7ff..d1fc543e98 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -1385,3 +1385,132 @@ GEN_VEXT_SHIFT_VX(vnsrl_vx_w, uint32_t, uint64_t, H4, H8, DO_SRL, 0x3f, clearl)
>  GEN_VEXT_SHIFT_VX(vnsra_vx_b, int8_t, int16_t, H1, H2, DO_SRL, 0xf, clearb)
>  GEN_VEXT_SHIFT_VX(vnsra_vx_h, int16_t, int32_t, H2, H4, DO_SRL, 0x1f, clearh)
>  GEN_VEXT_SHIFT_VX(vnsra_vx_w, int32_t, int64_t, H4, H8, DO_SRL, 0x3f, clearl)
> +
> +/* Vector Integer Comparison Instructions */
> +#define DO_MSEQ(N, M) (N == M)
> +#define DO_MSNE(N, M) (N != M)
> +#define DO_MSLT(N, M) (N < M)
> +#define DO_MSLE(N, M) (N <= M)
> +#define DO_MSGT(N, M) (N > M)
> +
> +#define GEN_VEXT_CMP_VV(NAME, ETYPE, H, DO_OP)                \
> +void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
> +        CPURISCVState *env, uint32_t desc)                    \
> +{                                                             \
> +    uint32_t mlen = vext_mlen(desc);                          \
> +    uint32_t vm = vext_vm(desc);                              \
> +    uint32_t vl = env->vl;                                    \
> +    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);        \
> +    uint32_t i;                                               \
> +                                                              \
> +    if (vl == 0) {                                            \
> +        return;                                               \
> +    }                                                         \
> +    for (i = 0; i < vl; i++) {                                \
> +        ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
> +        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {            \
> +            continue;                                         \
> +        }                                                     \
> +        vext_set_elem_mask(vd, mlen, i, DO_OP(s2, s1));       \
> +    }                                                         \
> +    for (; i < vlmax; i++) {                                  \
> +        vext_set_elem_mask(vd, mlen, i, 0);                   \
> +    }                                                         \
> +}
> +
> +GEN_VEXT_CMP_VV(vmseq_vv_b, uint8_t,  H1, DO_MSEQ)
> +GEN_VEXT_CMP_VV(vmseq_vv_h, uint16_t, H2, DO_MSEQ)
> +GEN_VEXT_CMP_VV(vmseq_vv_w, uint32_t, H4, DO_MSEQ)
> +GEN_VEXT_CMP_VV(vmseq_vv_d, uint64_t, H8, DO_MSEQ)
> +
> +GEN_VEXT_CMP_VV(vmsne_vv_b, uint8_t,  H1, DO_MSNE)
> +GEN_VEXT_CMP_VV(vmsne_vv_h, uint16_t, H2, DO_MSNE)
> +GEN_VEXT_CMP_VV(vmsne_vv_w, uint32_t, H4, DO_MSNE)
> +GEN_VEXT_CMP_VV(vmsne_vv_d, uint64_t, H8, DO_MSNE)
> +
> +GEN_VEXT_CMP_VV(vmsltu_vv_b, uint8_t,  H1, DO_MSLT)
> +GEN_VEXT_CMP_VV(vmsltu_vv_h, uint16_t, H2, DO_MSLT)
> +GEN_VEXT_CMP_VV(vmsltu_vv_w, uint32_t, H4, DO_MSLT)
> +GEN_VEXT_CMP_VV(vmsltu_vv_d, uint64_t, H8, DO_MSLT)
> +
> +GEN_VEXT_CMP_VV(vmslt_vv_b, int8_t,  H1, DO_MSLT)
> +GEN_VEXT_CMP_VV(vmslt_vv_h, int16_t, H2, DO_MSLT)
> +GEN_VEXT_CMP_VV(vmslt_vv_w, int32_t, H4, DO_MSLT)
> +GEN_VEXT_CMP_VV(vmslt_vv_d, int64_t, H8, DO_MSLT)
> +
> +GEN_VEXT_CMP_VV(vmsleu_vv_b, uint8_t,  H1, DO_MSLE)
> +GEN_VEXT_CMP_VV(vmsleu_vv_h, uint16_t, H2, DO_MSLE)
> +GEN_VEXT_CMP_VV(vmsleu_vv_w, uint32_t, H4, DO_MSLE)
> +GEN_VEXT_CMP_VV(vmsleu_vv_d, uint64_t, H8, DO_MSLE)
> +
> +GEN_VEXT_CMP_VV(vmsle_vv_b, int8_t,  H1, DO_MSLE)
> +GEN_VEXT_CMP_VV(vmsle_vv_h, int16_t, H2, DO_MSLE)
> +GEN_VEXT_CMP_VV(vmsle_vv_w, int32_t, H4, DO_MSLE)
> +GEN_VEXT_CMP_VV(vmsle_vv_d, int64_t, H8, DO_MSLE)
> +
> +#define GEN_VEXT_CMP_VX(NAME, ETYPE, H, DO_OP)                      \
> +void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
> +        CPURISCVState *env, uint32_t desc)                          \
> +{                                                                   \
> +    uint32_t mlen = vext_mlen(desc);                                \
> +    uint32_t vm = vext_vm(desc);                                    \
> +    uint32_t vl = env->vl;                                          \
> +    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);              \
> +    uint32_t i;                                                     \
> +                                                                    \
> +    if (vl == 0) {                                                  \
> +        return;                                                     \
> +    }                                                               \
> +    for (i = 0; i < vl; i++) {                                      \
> +        ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {                  \
> +            continue;                                               \
> +        }                                                           \
> +        vext_set_elem_mask(vd, mlen, i,                             \
> +                DO_OP(s2, (ETYPE)(target_long)s1));                 \
> +    }                                                               \
> +    for (; i < vlmax; i++) {                                        \
> +        vext_set_elem_mask(vd, mlen, i, 0);                         \
> +    }                                                               \
> +}
> +
> +GEN_VEXT_CMP_VX(vmseq_vx_b, uint8_t,  H1, DO_MSEQ)
> +GEN_VEXT_CMP_VX(vmseq_vx_h, uint16_t, H2, DO_MSEQ)
> +GEN_VEXT_CMP_VX(vmseq_vx_w, uint32_t, H4, DO_MSEQ)
> +GEN_VEXT_CMP_VX(vmseq_vx_d, uint64_t, H8, DO_MSEQ)
> +
> +GEN_VEXT_CMP_VX(vmsne_vx_b, uint8_t,  H1, DO_MSNE)
> +GEN_VEXT_CMP_VX(vmsne_vx_h, uint16_t, H2, DO_MSNE)
> +GEN_VEXT_CMP_VX(vmsne_vx_w, uint32_t, H4, DO_MSNE)
> +GEN_VEXT_CMP_VX(vmsne_vx_d, uint64_t, H8, DO_MSNE)
> +
> +GEN_VEXT_CMP_VX(vmsltu_vx_b, uint8_t,  H1, DO_MSLT)
> +GEN_VEXT_CMP_VX(vmsltu_vx_h, uint16_t, H2, DO_MSLT)
> +GEN_VEXT_CMP_VX(vmsltu_vx_w, uint32_t, H4, DO_MSLT)
> +GEN_VEXT_CMP_VX(vmsltu_vx_d, uint64_t, H8, DO_MSLT)
> +
> +GEN_VEXT_CMP_VX(vmslt_vx_b, int8_t,  H1, DO_MSLT)
> +GEN_VEXT_CMP_VX(vmslt_vx_h, int16_t, H2, DO_MSLT)
> +GEN_VEXT_CMP_VX(vmslt_vx_w, int32_t, H4, DO_MSLT)
> +GEN_VEXT_CMP_VX(vmslt_vx_d, int64_t, H8, DO_MSLT)
> +
> +GEN_VEXT_CMP_VX(vmsleu_vx_b, uint8_t,  H1, DO_MSLE)
> +GEN_VEXT_CMP_VX(vmsleu_vx_h, uint16_t, H2, DO_MSLE)
> +GEN_VEXT_CMP_VX(vmsleu_vx_w, uint32_t, H4, DO_MSLE)
> +GEN_VEXT_CMP_VX(vmsleu_vx_d, uint64_t, H8, DO_MSLE)
> +
> +GEN_VEXT_CMP_VX(vmsle_vx_b, int8_t,  H1, DO_MSLE)
> +GEN_VEXT_CMP_VX(vmsle_vx_h, int16_t, H2, DO_MSLE)
> +GEN_VEXT_CMP_VX(vmsle_vx_w, int32_t, H4, DO_MSLE)
> +GEN_VEXT_CMP_VX(vmsle_vx_d, int64_t, H8, DO_MSLE)
> +
> +GEN_VEXT_CMP_VX(vmsgtu_vx_b, uint8_t,  H1, DO_MSGT)
> +GEN_VEXT_CMP_VX(vmsgtu_vx_h, uint16_t, H2, DO_MSGT)
> +GEN_VEXT_CMP_VX(vmsgtu_vx_w, uint32_t, H4, DO_MSGT)
> +GEN_VEXT_CMP_VX(vmsgtu_vx_d, uint64_t, H8, DO_MSGT)
> +
> +GEN_VEXT_CMP_VX(vmsgt_vx_b, int8_t,  H1, DO_MSGT)
> +GEN_VEXT_CMP_VX(vmsgt_vx_h, int16_t, H2, DO_MSGT)
> +GEN_VEXT_CMP_VX(vmsgt_vx_w, int32_t, H4, DO_MSGT)
> +GEN_VEXT_CMP_VX(vmsgt_vx_d, int64_t, H8, DO_MSGT)
> --
> 2.23.0
>

