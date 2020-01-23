Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892CEC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 04:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5239F2465A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 04:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHWS9ll5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5239F2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuTlX-0003Tr-F3
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 23:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iuTkr-00035L-ER
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 23:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iuTkq-0003lH-97
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 23:06:05 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:37173)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ianjiang.ict@gmail.com>)
 id 1iuTkq-0003kY-2u
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 23:06:04 -0500
Received: by mail-io1-xd42.google.com with SMTP id k24so1629988ioc.4
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 20:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bM9mBj87C6VcjXm0szx0IFnpZbAnYr84isGi80jBzgM=;
 b=oHWS9ll5uwF1lfRPj73vuzFK5EVORWdXTOK/uTvWYM35lyDMk+INGOJ7J3OB8pZBIE
 10Q+A+BX6sX32QaBhhhUkHaqYRcK0EgWjH89v9byUW9vPZuFBbjRYivwLgsvol+kN6ov
 AaqrbFYyapvnInnBHxgk5SVm1F4qxn+WGFNcqhBElna/+SqgRQALV1uAUeZc9hiq4/3b
 urvKrBhbXBYSo1r+O8MsnnQmgGX2MF8R33EoAwN4FHPfcpcGhDaawrT0ddpwps+dOpmp
 IHKuR2R7lZcPonAs09PzNNoK2g4QdSWw9tPFiMmG95PEvne4dabe/we5WkpMnVpBYX/V
 9jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bM9mBj87C6VcjXm0szx0IFnpZbAnYr84isGi80jBzgM=;
 b=oCiMwJgP+GabjFUjueLtkD9s8sSqmkH2udXzWgzIuBZBIsGSj6zZAD3X60Xx3q3xRy
 lQjDdVSr7wMU5d9dO7Jd0wOAgED3qJypr3VQYVSa5KmG7e9ss4k6Du+6wi95OPqlb0bY
 JwnnHY5H1bpcln4lvPudgoQAYMW+O63LgvZdYf/QC53e7X6+qpkdFSBIy17cpf41Gffm
 rhRHZGOXZ2pHIBodaNqUdwu37UeoAO/CxwKSE/tE7lSxWPVMCHygUakQKEMM5gVk9J7R
 YC15WeQDQRbVdLS/X2BzXJieMH4J9NJZBArhnhHQgtS91ybqh8318j8YG8w1G+bg/o5o
 Ttjg==
X-Gm-Message-State: APjAAAV2f2CNjjEgQwdXJm+zUEN2IL+r4lhZ51AAc90T1V2fE+YI2Rgd
 avqvlRTBMK+B8rWSOd6qTmbZZGI3LTFntdtuWqM=
X-Google-Smtp-Source: APXvYqzRSNnZ34XbJaIknEn9iGWr4+UxZrV551H3G35SlaVIyt+91ue3xfWi7uEqzUbc9ac7GxLvx4C6wbJf0VVTer4=
X-Received: by 2002:a6b:92d4:: with SMTP id u203mr9777333iod.288.1579752362926; 
 Wed, 22 Jan 2020 20:06:02 -0800 (PST)
MIME-Version: 1.0
References: <20200122072448.18510-1-ianjiang.ict@gmail.com>
 <b9084f13-0836-7f74-a870-608bf3f8f6a9@linaro.org>
 <CAMAD20=RS=tt04db3NfiPfXJo2Cr5PfCF-39E8qeuehnVGMdKg@mail.gmail.com>
 <25fb635f-6d92-70d0-9bcd-7f5a5de1a97b@linaro.org>
 <CAMAD20mgs=wBbsXAa6KsPP7SjNu1xfcM3wnqsAVExps3oufrtw@mail.gmail.com>
 <a7b4ec6a-1f41-45c3-d7a6-0b69fef1f379@linaro.org>
In-Reply-To: <a7b4ec6a-1f41-45c3-d7a6-0b69fef1f379@linaro.org>
From: Ian Jiang <ianjiang.ict@gmail.com>
Date: Thu, 23 Jan 2020 12:05:52 +0800
Message-ID: <CAMAD20nWyApK7-uFNvMpXmzfiTohLOhPgD+TTNr+ZWVn+QA7Tg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Format Rd of FMV.W.X with NoN-boxing
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Richard Henderson <richard.henderson@linaro.org> =E4=BA=8E2020=E5=B9=B41=E6=
=9C=8823=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8811:07=E5=86=99=E9=81=
=93=EF=BC=9A
>
> On 1/22/20 2:48 PM, Ian Jiang wrote:
> > Richard Henderson <richard.henderson@linaro.org> =E4=BA=8E2020=E5=B9=B4=
1=E6=9C=8823=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=881:11=E5=86=99=E9=
=81=93=EF=BC=9A
> >>
> >> On 1/21/20 11:53 PM, Ian Jiang wrote:
> >>> --
> >>> Ian Jiang
> >>>
> >>> Richard Henderson <richard.henderson@linaro.org> =E4=BA=8E2020=E5=B9=
=B41=E6=9C=8822=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:53=E5=86=99=
=E9=81=93=EF=BC=9A
> >>>>
> >>>> On 1/21/20 9:24 PM, Ian Jiang wrote:
> >>>>> For FMV.W.X that moves the lower 32 bits of an integer register to =
a
> >>>>> floating-point register, Rd should encoded with NoN-boxing scheme.
> >>>>> Note: This applies to RV64 only.
> >>>>>
> >>>>> Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>
> >>>>> ---
> >>>>>  target/riscv/insn_trans/trans_rvf.inc.c | 1 +
> >>>>>  1 file changed, 1 insertion(+)
> >>>>>
> >>>>> diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv=
/insn_trans/trans_rvf.inc.c
> >>>>> index 172dbfa919..62b7a36567 100644
> >>>>> --- a/target/riscv/insn_trans/trans_rvf.inc.c
> >>>>> +++ b/target/riscv/insn_trans/trans_rvf.inc.c
> >>>>> @@ -368,6 +368,7 @@ static bool trans_fmv_w_x(DisasContext *ctx, ar=
g_fmv_w_x *a)
> >>>>>
> >>>>>  #if defined(TARGET_RISCV64)
> >>>>>      tcg_gen_mov_i64(cpu_fpr[a->rd], t0);
> >>>>> +    tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd], 0xffffffff0000=
0000ULL);
> >>>>>  #else
> >>>>>      tcg_gen_extu_i32_i64(cpu_fpr[a->rd], t0);
> >>>>>  #endif
> >>>>>
> >>>>
> >>>> This doesn't look right.  There's nothing in the spec that says the =
nan-boxing
> >>>> is restricted to rv64.  NaN-boxing is all about FLEN, not XLEN.
> >>>>
> >>>
> >>> Why the translation of FLW has a NaN-boxing?
> >>>
> >>> file ./target/riscv/insn_trans/trans_rvf.inc.c
> >>>  26 static bool trans_flw(DisasContext *ctx, arg_flw *a)
> >>>  27 {
> >>> ...
> >>>  34     tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEUL=
);
> >>>  35     /* RISC-V requires NaN-boxing of narrower width floating poin=
t values */
> >>>  36     tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd], 0xffffffff000=
00000ULL);
> >>> ...
> >>>  41 }
> >>
> >> Eh?  Obviously because we're loading a 32-bit value into a FLEN=3D64 b=
it register.
> > FMV.W.X is the same with FLW at this point that filling a 64 bits
> > float register based on 32 bits value.
> > Besides, the RISCV simulator Spike makes NaN-boxing for FLW, FMV.W.W,
> > FADD.S, FSUB.S, and others.
> > It might be better that they have a coincident behavior? I am not sure
> > about this and just want a discussion.
>
> So, I wonder if we're talking past one another.
>
> In reply to the patch at the beginning of this thread, I was suggesting t=
hat
> the correct solution is
>
>  #if defined(TARGET_RISCV64)
>      tcg_gen_mov_i64(cpu_fpr[a->rd], t0);
>  #else
>      tcg_gen_extu_i32_i64(cpu_fpr[a->rd], t0);
>  #endif
> +    tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
> +                    0xffffffff00000000ULL);
>
> However, after the previous follow-up I wonder if it might be better to s=
plit
> out the nan-boxing to a helper:
>
> /*
>  * RISC-V requires NaN-boxing of narrower width floating
>  * point values.  This applies when a 32-bit value is
>  * assigned to a 64-bit FP register.  Thus this does not
>  * apply when the RVD extension is not present.
>  */
> static void gen_nanbox_fpr(DisasContext *ctx, int regno)
> {
>     if (has_ext(ctx, RVD)) {
>         tcg_gen_ori_i64(cpu_fpr[regno], cpu_fpr[regno],
>                         MAKE_64BIT_MASK(32, 32));
>     }
> }
>
> which could elide this when only RVF is enabled, and thus
> the upper 32-bits of the register are inaccessible.
>
> This helper would then be propagated to the existing uses within translat=
e.c
> and insn_trans/trans_rvf.inc.c.
>
> As another cleanup, the ifdef above may be replaced with
>
>     tcg_gen_extu_tl_i64(cpu_fpr[a->rd], t0);
>
> which will handle both RISCV64 and RISCV32.

Good point.
But I am not clear where to call this new helper gen_nanbox_fpr(). Is
there a position that could affect all floating-point instructions? So
that we don't have to modify so many translating functions. Please
give more details.

