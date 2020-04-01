Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D8CC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC01020719
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k38CtPCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC01020719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJeWA-0006W8-RT
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 10:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jJeU3-0003HY-OF
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jJeU2-0003zV-33
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:36:47 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50338)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jJeU1-0003xf-Rw
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:36:46 -0400
Received: by mail-wm1-x342.google.com with SMTP id t128so6903443wma.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TQUMZ9HlhcpvqeC1U2gNdJ/+gyNagNngjlFwThL+fZc=;
 b=k38CtPCeIkvL4xxQc7jelV4Bj4xxLNCd8C37KcZNKyl1ivwhd9yNHSsIQvkt2rAC7P
 amE+zlUgJLmpwLlryRJSL1G9aeapeltKiTFIv4ag8Ypnihuqq3I6v82j3JgrENzEYkxY
 /MVAfFE8iv/sR0wJayeh7tVmju64ZVXVOT7LSkhWjIjN51iBSCtqqhxo3Q2YnAt1XKxS
 Z3Vv/wZmAYTeRIGhfpCyS2/9yu8rPi4O9xIM1tXHG82G0WCHPiB02pvtFxhp2e+mM1cC
 HMUoUo3y/e4Aqd6YAKfNakrLF7R3DFlQcrGLjLlYUFOi2FTo7e8bejb/QRJlCXqV85J8
 1EYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TQUMZ9HlhcpvqeC1U2gNdJ/+gyNagNngjlFwThL+fZc=;
 b=eYtXlcF5T1NBc3Z2njdlDFeU7Gf8FYI32DhjCG5vcTU4ZHxeJUb3NvY1y+xDDTLoKl
 y4HGUpVvwshThhpErU4aJT+YbQO9IkB1tL+klDHbdWmMaM69OhqFZqK7qfxZioxApUoU
 BK4GGwMuC1I//Y52ygYsTWarqP9wpOxcV2ueft8URILNrjC55dV4V/4qgp+uj+72xob+
 iaBlcHF5sXnoLCO3OTYQ16OH3DUShcOGIolZlsk+y8SGlAgfitEd1cyhypBQbm7uR6dX
 diYHQ4A/rx7oJHVWzRKntk+y+Lh2SL65C0gZymaQjbVs9hTiU329HbLSgmoGqK4l5xkr
 LudQ==
X-Gm-Message-State: AGi0PubOdKddFvFJWIGt3FJ4VBx1PoJExiamr942ean/tmwha+prKX/e
 5szK9bFeexsBtyJRKgn6xpA5jW9JWMcE+s5dXmc=
X-Google-Smtp-Source: APiQypJITDgW4A6J/LNjdyVzsfLvZ4sxVBsmo0sU3u2rHLmVPU7EaVsTCt6cOZZYhvkqYF2/eZtL4j4AhdNsFOVFRRg=
X-Received: by 2002:a7b:c051:: with SMTP id u17mr4364606wmc.129.1585751802366; 
 Wed, 01 Apr 2020 07:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200324122212.11156-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20200324122212.11156-1-jiaxun.yang@flygoat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 1 Apr 2020 16:36:22 +0200
Message-ID: <CAHiYmc6xouy6_ZbrFEQksb1iGq1CFZkYOvG0ZGiFaFhPOf5mGg@mail.gmail.com>
Subject: Re: [PATCH for-5.0,
 v1] target/mips: Fix loongson multimedia condition instructions
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: multipart/alternative; boundary="000000000000e1d03205a23b9cf2"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e1d03205a23b9cf2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

13:23 Uto, 24.03.2020. Jiaxun Yang <jiaxun.yang@flygoat.com> =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Loongson multimedia condition instructions were previously implemented as
> write 0 to rd due to lack of documentation. So I just confirmed with
Loongson
> about their encoding and implemented them correctly.
>

Hi, Jiaxun,

Richard Henderson selected your patch to be in his pull request, and the
main maintainer, Peter Maydell, accepted it and integrated it into main
tree:

https://github.com/qemu/qemu/commit/84878f4c00a7beca1d1460e2f77a6c833b8d039=
3#diff-b06d6b84c7a82caf0f5e4645f4b80540

I gather this is your first patch merged in QEMU upstream.

Congratulations!!

There is a place for you in QEMU community.

Hope we hear from you soon, with more fixes, improvements, and new features=
.

Yours,
Aleksandar

> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Acked-by: Huacai Chen <chenhc@lemote.com>
> ---
> v1: Use deposit opreations according to Richard's suggestion.
> ---
>  target/mips/translate.c | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index d745bd2803..25b595a17d 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -5529,6 +5529,7 @@ static void gen_loongson_multimedia(DisasContext
*ctx, int rd, int rs, int rt)
>  {
>      uint32_t opc, shift_max;
>      TCGv_i64 t0, t1;
> +    TCGCond cond;
>
>      opc =3D MASK_LMI(ctx->opcode);
>      switch (opc) {
> @@ -5862,14 +5863,39 @@ static void gen_loongson_multimedia(DisasContext
*ctx, int rd, int rs, int rt)
>
>      case OPC_SEQU_CP2:
>      case OPC_SEQ_CP2:
> +        cond =3D TCG_COND_EQ;
> +        goto do_cc_cond;
> +        break;
>      case OPC_SLTU_CP2:
> +        cond =3D TCG_COND_LTU;
> +        goto do_cc_cond;
> +        break;
>      case OPC_SLT_CP2:
> +        cond =3D TCG_COND_LT;
> +        goto do_cc_cond;
> +        break;
>      case OPC_SLEU_CP2:
> +        cond =3D TCG_COND_LEU;
> +        goto do_cc_cond;
> +        break;
>      case OPC_SLE_CP2:
> -        /*
> -         * ??? Document is unclear: Set FCC[CC].  Does that mean the
> -         * FD field is the CC field?
> -         */
> +        cond =3D TCG_COND_LE;
> +    do_cc_cond:
> +        {
> +            int cc =3D (ctx->opcode >> 8) & 0x7;
> +            TCGv_i64 t64 =3D tcg_temp_new_i64();
> +            TCGv_i32 t32 =3D tcg_temp_new_i32();
> +
> +            tcg_gen_setcond_i64(cond, t64, t0, t1);
> +            tcg_gen_extrl_i64_i32(t32, t64);
> +            tcg_gen_deposit_i32(fpu_fcr31, fpu_fcr31, t32,
> +                                get_fp_bit(cc), 1);
> +
> +            tcg_temp_free_i32(t32);
> +            tcg_temp_free_i64(t64);
> +        }
> +        goto no_rd;
> +        break;
>      default:
>          MIPS_INVAL("loongson_cp2");
>          generate_exception_end(ctx, EXCP_RI);
> @@ -5878,6 +5904,7 @@ static void gen_loongson_multimedia(DisasContext
*ctx, int rd, int rs, int rt)
>
>      gen_store_fpr64(ctx, t0, rd);
>
> +no_rd:
>      tcg_temp_free_i64(t0);
>      tcg_temp_free_i64(t1);
>  }
> --
> 2.26.0.rc2
>
>

--000000000000e1d03205a23b9cf2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">13:23 Uto, 24.03.2020. Jiaxun Yang &lt;<a href=3D"mailto:jia=
xun.yang@flygoat.com">jiaxun.yang@flygoat.com</a>&gt; =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; Loongson multimedia condition instructions were previously implemented=
 as<br>
&gt; write 0 to rd due to lack of documentation. So I just confirmed with L=
oongson<br>
&gt; about their encoding and implemented them correctly.<br>
&gt;</p>
<p dir=3D"ltr">Hi, Jiaxun,</p>
<p dir=3D"ltr">Richard Henderson selected your patch to be in his pull requ=
est, and the main maintainer, Peter Maydell, accepted it and integrated it =
into main tree:</p>
<p dir=3D"ltr"><a href=3D"https://github.com/qemu/qemu/commit/84878f4c00a7b=
eca1d1460e2f77a6c833b8d0393#diff-b06d6b84c7a82caf0f5e4645f4b80540">https://=
github.com/qemu/qemu/commit/84878f4c00a7beca1d1460e2f77a6c833b8d0393#diff-b=
06d6b84c7a82caf0f5e4645f4b80540</a></p>
<p dir=3D"ltr">I gather this is your first patch merged in QEMU upstream.</=
p>
<p dir=3D"ltr">Congratulations!!</p>
<p dir=3D"ltr">There is a place for you in QEMU community.</p>
<p dir=3D"ltr">Hope we hear from you soon, with more fixes, improvements, a=
nd new features.</p>
<p dir=3D"ltr">Yours,<br>
Aleksandar<br></p>
<p dir=3D"ltr">&gt; Signed-off-by: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun=
.yang@flygoat.com">jiaxun.yang@flygoat.com</a>&gt;<br>
&gt; Acked-by: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@=
lemote.com</a>&gt;<br>
&gt; ---<br>
&gt; v1: Use deposit opreations according to Richard&#39;s suggestion.<br>
&gt; ---<br>
&gt; =C2=A0target/mips/translate.c | 35 +++++++++++++++++++++++++++++++----=
<br>
&gt; =C2=A01 file changed, 31 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/target/mips/translate.c b/target/mips/translate.c<br>
&gt; index d745bd2803..25b595a17d 100644<br>
&gt; --- a/target/mips/translate.c<br>
&gt; +++ b/target/mips/translate.c<br>
&gt; @@ -5529,6 +5529,7 @@ static void gen_loongson_multimedia(DisasContext=
 *ctx, int rd, int rs, int rt)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0uint32_t opc, shift_max;<br>
&gt; =C2=A0 =C2=A0 =C2=A0TCGv_i64 t0, t1;<br>
&gt; +=C2=A0 =C2=A0 TCGCond cond;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0opc =3D MASK_LMI(ctx-&gt;opcode);<br>
&gt; =C2=A0 =C2=A0 =C2=A0switch (opc) {<br>
&gt; @@ -5862,14 +5863,39 @@ static void gen_loongson_multimedia(DisasConte=
xt *ctx, int rd, int rs, int rt)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0case OPC_SEQU_CP2:<br>
&gt; =C2=A0 =C2=A0 =C2=A0case OPC_SEQ_CP2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D TCG_COND_EQ;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto do_cc_cond;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; =C2=A0 =C2=A0 =C2=A0case OPC_SLTU_CP2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D TCG_COND_LTU;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto do_cc_cond;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; =C2=A0 =C2=A0 =C2=A0case OPC_SLT_CP2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D TCG_COND_LT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto do_cc_cond;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; =C2=A0 =C2=A0 =C2=A0case OPC_SLEU_CP2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D TCG_COND_LEU;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto do_cc_cond;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; =C2=A0 =C2=A0 =C2=A0case OPC_SLE_CP2:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ??? Document is unclear: Set FCC[=
CC].=C2=A0 Does that mean the<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* FD field is the CC field?<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D TCG_COND_LE;<br>
&gt; +=C2=A0 =C2=A0 do_cc_cond:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int cc =3D (ctx-&gt;opcode =
&gt;&gt; 8) &amp; 0x7;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv_i64 t64 =3D tcg_temp_n=
ew_i64();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv_i32 t32 =3D tcg_temp_n=
ew_i32();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_setcond_i64(cond, t=
64, t0, t1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_extrl_i64_i32(t32, =
t64);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_deposit_i32(fpu_fcr=
31, fpu_fcr31, t32,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_fp_bit(cc), 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_temp_free_i32(t32);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_temp_free_i64(t64);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto no_rd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; =C2=A0 =C2=A0 =C2=A0default:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MIPS_INVAL(&quot;loongson_cp2&quot;)=
;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0generate_exception_end(ctx, EXCP_RI)=
;<br>
&gt; @@ -5878,6 +5904,7 @@ static void gen_loongson_multimedia(DisasContext=
 *ctx, int rd, int rs, int rt)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0gen_store_fpr64(ctx, t0, rd);<br>
&gt;<br>
&gt; +no_rd:<br>
&gt; =C2=A0 =C2=A0 =C2=A0tcg_temp_free_i64(t0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0tcg_temp_free_i64(t1);<br>
&gt; =C2=A0}<br>
&gt; -- <br>
&gt; 2.26.0.rc2<br>
&gt;<br>
&gt;<br>
</p>

--000000000000e1d03205a23b9cf2--

