Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E32C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 16:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D715206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 16:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMhCKgKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D715206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGmsI-0007U1-5Q
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 12:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jGmrN-0006fG-Al
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jGmrK-0004CP-5p
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:57:01 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jGmrJ-0004Bu-VI
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:56:58 -0400
Received: by mail-wr1-x442.google.com with SMTP id h9so22399382wrc.8
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 09:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=juE1iX6pm63a8Xwsl0yYhG6KRK/o7uYwSBa2P/Ngj24=;
 b=hMhCKgKaj0n0mKn6OfTNd2+wywpH9CUsNZjPcdbAjDEl8rRNZ7IB8PMoAvyX36m3oM
 FJteGuQj0a+jkvxHQQ6xDoTwG1eaEtg1K7De/MxHetIce19fGh/hHzaqt4mVr4TGRMi7
 7/X12+tduaTV+CJSD8if+z8+kR47s0kVlm9xku8gI/+78rEa4MIFZaL1QqTY+oV/pIqI
 yOWUpATBNpqAjqQyQLjrw1z4ASwpb5yEpDsg/ZFea87iiUTHzzMrGOVnQBaSi1/6nooE
 /kfVuAk9By1oDkL2jVEFkZwzQ2NHAG8AyNchtRFJZo4mzKG8W3oQHu43E0+DQs+CVQYu
 FWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=juE1iX6pm63a8Xwsl0yYhG6KRK/o7uYwSBa2P/Ngj24=;
 b=rnbO7O1+uTP7x6zgjgCkIUtMyGLKO/I0DK4MN6Y0IwKS5t0SzlE8WiL9lTnZKIgFJ4
 WiDnjdSXW4vwmQ4pXDL/uxABLF1P9FeRL8curd710uKN+B2AFbkF9mcQomkQN38ZQTwz
 Tr/BCTSvNf5DqZUpLOLu3hbti6SUg3FbbZm7bqs/xLSKOsis9AjGMwQ/eplewoX86FM0
 Ndmlh713MCPY1SlwjTq0sQrQlDIQUaGo64SovOyQNDj5jYJb+3OelGPDrRddlyoTxACh
 6DJja7SwC5RmHzLRdKzns3KtgHutlPw7pRz5UIN0VeahtH/uN9ojoImpkKcc+YSJUtyc
 v+tQ==
X-Gm-Message-State: ANhLgQ2xnx4gO3BL2cPT6qlFXopd8QyFEXC0Fu1PttPHcDWgfE7HBk+p
 hbQ/oHUaJgYVmrmiQAPzCnKzydJdzKUruIN0Ar0=
X-Google-Smtp-Source: ADFU+vv26nnrWUx9FgTl1ILdAKCIaObBDbR88fn/QB2VY4I1R6sRHWI46wpI+n7wcYKNSVaHgajvkY1VkNHCMC81WuU=
X-Received: by 2002:adf:f24c:: with SMTP id b12mr25244745wrp.162.1585069016045; 
 Tue, 24 Mar 2020 09:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200324122212.11156-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20200324122212.11156-1-jiaxun.yang@flygoat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 24 Mar 2020 18:56:41 +0200
Message-ID: <CAHiYmc7MN8pUg7FJ=wcn1h0pr2A05nv4SQaOZmL47NCnNzUJRA@mail.gmail.com>
Subject: Re: [PATCH for-5.0,
 v1] target/mips: Fix loongson multimedia condition instructions
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: multipart/alternative; boundary="000000000000a55cc005a19ca323"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Huacai Chen <chenhc@lemote.com>, aleksandar.rikalo@rt-rk.com,
 richard.henderson@linaro.org, QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a55cc005a19ca323
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

14:23 Uto, 24.03.2020. Jiaxun Yang <jiaxun.yang@flygoat.com> =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Loongson multimedia condition instructions were previously implemented as
> write 0 to rd due to lack of documentation. So I just confirmed with
Loongson
> about their encoding and implemented them correctly.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Acked-by: Huacai Chen <chenhc@lemote.com>
> ---
> v1: Use deposit opreations according to Richard's suggestion.
> ---

Thanks, Jiaxun!

But, your numeration of patches is wrong. The first version of the patch
should be sent with prefix [PATCH]
and the second (this) version of the patch with prefix [PATCH v2]. This is
the second time you make the same mistake. Please make sure that you have
the correct numeration in future. But, anyhow, thanks for this version.

Yours,
Aleksandar

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

--000000000000a55cc005a19ca323
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">14:23 Uto, 24.03.2020. Jiaxun Yang &lt;<a href=3D"mailto:jia=
xun.yang@flygoat.com">jiaxun.yang@flygoat.com</a>&gt; =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; Loongson multimedia condition instructions were previously implemented=
 as<br>
&gt; write 0 to rd due to lack of documentation. So I just confirmed with L=
oongson<br>
&gt; about their encoding and implemented them correctly.<br>
&gt;<br>
&gt; Signed-off-by: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.c=
om">jiaxun.yang@flygoat.com</a>&gt;<br>
&gt; Acked-by: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@=
lemote.com</a>&gt;<br>
&gt; ---<br>
&gt; v1: Use deposit opreations according to Richard&#39;s suggestion.<br>
&gt; ---</p>
<p dir=3D"ltr">Thanks, Jiaxun!</p>
<p dir=3D"ltr">But, your numeration of patches is wrong. The first version =
of the patch should be sent with prefix [PATCH]<br>
and the second (this) version of the patch with prefix [PATCH v2]. This is =
the second time you make the same mistake. Please make sure that you have t=
he correct numeration in future. But, anyhow, thanks for this version.</p>
<p dir=3D"ltr">Yours,<br>
Aleksandar<br></p>
<p dir=3D"ltr">&gt; =C2=A0target/mips/translate.c | 35 ++++++++++++++++++++=
+++++++++++----<br>
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

--000000000000a55cc005a19ca323--

