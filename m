Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BF7C4332D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4970720757
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOmMhKGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4970720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFfUg-0004tt-GR
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 10:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jFcEb-0003qq-HF
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenhuacai@gmail.com>) id 1jFcEa-0004YM-5m
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:24:09 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:42293)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chenhuacai@gmail.com>)
 id 1jFcEZ-0004YE-Vj
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:24:08 -0400
Received: by mail-io1-xd44.google.com with SMTP id q128so8956948iof.9
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 04:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jsA8oWlz1kDaWXTqh7SXMjVmDqnfEOCpGP3ek5sr+Vg=;
 b=JOmMhKGMwLYkP/0HrThYhZRjNMSXzcKLoZdlIMPBWG5LAVZsPc6hGhHVm1aEaM+1b/
 MMMN8yiMEtLs6bF+qjfDGCYPYzAMQmSjvmK9C8jKWDH5EMfj6HygwJGDy2refkZVXUG+
 13TYJVCtNVvmnCZ5yRT1QuOAR4/3B/gdnA/CmfSS+TNtPKRAnYsQ4UNH3FwGVTOrlyNA
 +nX5XBKAUIv27JjoYimyE+PHwbJtDlw82XjgZnfpRRGEHZSUneqL5vxP96yM8MvSbMyC
 vTTo92pqSXT3VmmK8oJJJ4U3wzwwpzd+WvO7/a1b6habdVyOg2XSwLTZrD1KAJOwc+69
 ZhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jsA8oWlz1kDaWXTqh7SXMjVmDqnfEOCpGP3ek5sr+Vg=;
 b=b37qnM++tV3+18apq9Jt59PthpWkIF23e34h18Mn+iKVgTX58oA9mhkxO0oj9uAM3W
 J4iA/cGGKOJp3Dv5yL77HBepxkvu6iMvS6LTEmxiZjgwA57wCUGuKSujNA9Yu+kl0Kqh
 S7SL3VUHEqezjRVVQMUjYnNaLWx5KkOcCmIU+hUMAW+XpYJyjwj0V1iOHapbRagT/zEG
 rmK57BukaMsz1X/8c3cjLqrqbN6dxLQHKPZtZOGe4X1KDvY39Z82+288byKS33B5nUtU
 AbzEhTENFQnLV/C1Yte+5sK51AnT68cKY3wX4rRlI0lGgO6TMcNE90IomIFvJUSpCyKd
 UpzA==
X-Gm-Message-State: ANhLgQ1CjDct1CziRLpb4U/BSBN5hWfBOt8mJprbuy/Ix7y1p6bBztcT
 7yISA6BBH57T8irdxe97DxMJrxRdWK6HjXCRe+I=
X-Google-Smtp-Source: ADFU+vvry7bYGT8v1AVH9OkDh3ncc5I5dPP/sneCMh8pNR8eYa3vu8qPaMqwQvr9lq+EmiPnS+l3KPPRPnHKgbMAPxE=
X-Received: by 2002:a05:6638:19a:: with SMTP id
 a26mr12439734jaq.137.1584789846796; 
 Sat, 21 Mar 2020 04:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200321045621.2139953-1-jiaxun.yang@flygoat.com>
 <3a52de21-180b-9f85-e33d-563752151017@redhat.com>
 <A9E2018B-82A0-4889-B311-DD5D5D59D90F@flygoat.com>
 <CF83865C-3904-4144-A68C-89804599EA38@flygoat.com>
In-Reply-To: <CF83865C-3904-4144-A68C-89804599EA38@flygoat.com>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Sat, 21 Mar 2020 19:30:46 +0800
Message-ID: <CAAhV-H4o87s8zMP=7VYpzH7HgkhcTnWGfZ3H=FbMzZoE2_OpYQ@mail.gmail.com>
Subject: Re: [PATCH] target/mips: Fix loongson multimedia condition
 instructions
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
X-Mailman-Approved-At: Sat, 21 Mar 2020 10:43:53 -0400
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
Cc: aleksandar.qemu.devel@gmail.com, aleksandar.rikalo@rt-rk.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 21, 2020 at 7:17 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote=
:
>
>
>
> =E4=BA=8E 2020=E5=B9=B43=E6=9C=8821=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
6:57:54, Jiaxun Yang <jiaxun.yang@flygoat.com> =E5=86=99=E5=88=B0:
> >
> >
> >=E4=BA=8E 2020=E5=B9=B43=E6=9C=8821=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=886:39:21, "Philippe Mathieu-Daud=C3=A9"
> ><philmd@redhat.com> =E5=86=99=E5=88=B0:
> >>On 3/21/20 5:56 AM, Jiaxun Yang wrote:
> >>> Loongson multimedia condition instructions were previously
> >>implemented as
> >>> write 0 to rd due to lack of documentation. So I just confirmed with
> >>Loongson
> >>> about their encoding and implemented them correctly.
> >>
> >>Can you refer to the datasheet in the commit message, or have someone
> >>from Loongson Technology, Lemote Tech or with access to the specs ack
> >>your patch?
> >
> >I just confirmed with Loongson guys on IM.
> >
> >+ Huacai
>
> +Huacai's Gmail as his Lemote mail rejected my bounce.
>
> >
> >Hi Huacai,
> >
> >Could you please acknowledge this change,
> >Thanks.
> >
> >--
> >Jiaxun Yang
Acked-by: Huacai Chen <chenhc@lemote.com>

> >
> >>
> >>>
> >>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >>> ---
> >>>   target/mips/translate.c | 40
> >>++++++++++++++++++++++++++++++++++------
> >>>   1 file changed, 34 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/target/mips/translate.c b/target/mips/translate.c
> >>> index d745bd2803..43be8d27b5 100644
> >>> --- a/target/mips/translate.c
> >>> +++ b/target/mips/translate.c
> >>> @@ -5529,6 +5529,8 @@ static void
> >>gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
> >>>   {
> >>>       uint32_t opc, shift_max;
> >>>       TCGv_i64 t0, t1;
> >>> +    TCGCond cond;
> >>> +    TCGLabel *lab;
> >>>
> >>>       opc =3D MASK_LMI(ctx->opcode);
> >>>       switch (opc) {
> >>> @@ -5816,7 +5818,7 @@ static void
> >>gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
> >>>       case OPC_DADD_CP2:
> >>>           {
> >>>               TCGv_i64 t2 =3D tcg_temp_new_i64();
> >>> -            TCGLabel *lab =3D gen_new_label();
> >>> +            lab =3D gen_new_label();
> >>>
> >>>               tcg_gen_mov_i64(t2, t0);
> >>>               tcg_gen_add_i64(t0, t1, t2);
> >>> @@ -5837,7 +5839,7 @@ static void
> >>gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
> >>>       case OPC_DSUB_CP2:
> >>>           {
> >>>               TCGv_i64 t2 =3D tcg_temp_new_i64();
> >>> -            TCGLabel *lab =3D gen_new_label();
> >>> +            lab =3D gen_new_label();
> >>>
> >>>               tcg_gen_mov_i64(t2, t0);
> >>>               tcg_gen_sub_i64(t0, t1, t2);
> >>> @@ -5862,14 +5864,39 @@ static void
> >>gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
> >>>
> >>>       case OPC_SEQU_CP2:
> >>>       case OPC_SEQ_CP2:
> >>> +        cond =3D TCG_COND_EQ;
> >>> +        goto do_cc_cond;
> >>> +        break;
> >>> +
> >>>       case OPC_SLTU_CP2:
> >>> +        cond =3D TCG_COND_LTU;
> >>> +        goto do_cc_cond;
> >>> +        break;
> >>> +
> >>>       case OPC_SLT_CP2:
> >>> +        cond =3D TCG_COND_LT;
> >>> +        goto do_cc_cond;
> >>> +        break;
> >>> +
> >>>       case OPC_SLEU_CP2:
> >>> +        cond =3D TCG_COND_LEU;
> >>> +        goto do_cc_cond;
> >>> +        break;
> >>> +
> >>>       case OPC_SLE_CP2:
> >>> -        /*
> >>> -         * ??? Document is unclear: Set FCC[CC].  Does that mean
> >the
> >>> -         * FD field is the CC field?
> >>> -         */
> >>> +        cond =3D TCG_COND_LE;
> >>> +    do_cc_cond:
> >>> +        {
> >>> +            int cc =3D (ctx->opcode >> 8) & 0x7;
> >>> +            lab =3D gen_new_label();
> >>> +            tcg_gen_ori_i32(fpu_fcr31, fpu_fcr31, 1 <<
> >>get_fp_bit(cc));
> >>> +            tcg_gen_brcond_i64(cond, t0, t1, lab);
> >>> +            tcg_gen_xori_i32(fpu_fcr31, fpu_fcr31, 1 <<
> >>get_fp_bit(cc));
> >>> +            gen_set_label(lab);
> >>> +        }
> >>> +        goto no_rd;
> >>> +        break;
> >>> +
> >>>       default:
> >>>           MIPS_INVAL("loongson_cp2");
> >>>           generate_exception_end(ctx, EXCP_RI);
> >>> @@ -5878,6 +5905,7 @@ static void
> >>gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
> >>>
> >>>       gen_store_fpr64(ctx, t0, rd);
> >>>
> >>> +no_rd:
> >>>       tcg_temp_free_i64(t0);
> >>>       tcg_temp_free_i64(t1);
> >>>   }
> >>>
>
> --
> Jiaxun Yang

