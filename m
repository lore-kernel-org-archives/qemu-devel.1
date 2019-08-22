Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7A0C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 04:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 572BC2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 04:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPnnRMdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572BC2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0eJj-0005rb-Ht
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 00:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0eJ0-0005T4-Vq
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 00:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0eIz-0006mT-AR
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 00:02:34 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42625)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i0eIz-0006kh-2u
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 00:02:33 -0400
Received: by mail-oi1-x244.google.com with SMTP id o6so3327194oic.9
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 21:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=7D8XnVPM9Jh7aNznD+i/wzfYPRSvGcmXEPYnSlx22cM=;
 b=NPnnRMdAC765ANKmlivc5m87qzlVwKeg6fwBhj/zqMlxRw/kivsR2UYI6M+XwW95yC
 nzZZLExWxY2/nP7dcsquV7AA1Ep5tKgWghBVCgYvCOtnLAED4X2jioLHo7bw1Gkn26en
 68AjTDu+rhavWBFvM6XQtdHmO+wQlUsbXCNACV8+w4gt7mb0F6ei0ELy+bSbmTAyXAgR
 R6VeK1Qp8HWjxXFgtLSOOyFUcFpwY4WmDFxPmCaW02QfCrRAkJmbCK2NDMfLd4PMhBdc
 /lSIyqXobbtR+VZQ2bOpDevnDxbm8dBWERj5H0ymrmAuMsFtNcWtVZhttxTRt63eZfBV
 C+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=7D8XnVPM9Jh7aNznD+i/wzfYPRSvGcmXEPYnSlx22cM=;
 b=YdM5ChaRvR5FfuMUZREA2bntcV4CFgB5WuaW02KCfiXQf8jcha4hTZaw5JcByIB8Vh
 eTFJii4D6ZtScLr7uV4LzttwKCM5qZoMW0THkFHNRbM1rh0E3ljiVCbfzy78FvwZUt45
 OK1cSq/Y+SU8Ps4TtHYgmmGnOfzQTQd5kE1ZukEPHlhm2H0IXU7cnXfmBzvyKrI3HCDi
 dXLkiz4ddJBFV1qOC4qTpwnrwBRJtA6S7iZtLSS4Tr5lbSOV5TYvDz4/oy0ByRVoQ9ch
 YBISM+7Dx4eSwTki0DrUhZk1DM6ZuOesTtx++5CKt7B1HR8iygihGGiSUplf556jvXxx
 8qqA==
X-Gm-Message-State: APjAAAUjgnuFOpgRzpYuC52BtcVzp804Le3euHFGykcNVBiGJmBZoibT
 d4HOsQZFB6uP6xSoccC5+dz4wYe6bWr+jxi35nU=
X-Google-Smtp-Source: APXvYqwc2069DZCED2gL0TdxPNPhDvzchQu3M1hoIaxEQWBAAN8OxIr1fhVrT0h+ZA7PcVBpQ4gGH378Yw/JWqYVI8U=
X-Received: by 2002:aca:bac4:: with SMTP id k187mr178987oif.62.1566446552148; 
 Wed, 21 Aug 2019 21:02:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Wed, 21 Aug 2019 21:02:31
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Wed, 21 Aug 2019 21:02:31
 -0700 (PDT)
In-Reply-To: <20190821172951.15333-59-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
 <20190821172951.15333-59-jan.bobek@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 22 Aug 2019 06:02:31 +0200
Message-ID: <CAL1e-=jdAZPfUnMCyiRpJQr_jEKL5EpeVo_GGQcq=r77hZEaMA@mail.gmail.com>
To: Jan Bobek <jan.bobek@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [RFC PATCH v4 58/75] target/i386: introduce AES
 and PCLMULQDQ vector instructions to sse-opcode.inc.h
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.08.2019. 20.37, "Jan Bobek" <jan.bobek@gmail.com> =D1=98=D0=B5 =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Add all the AES and PCLMULQDQ vector instruction entries to
sse-opcode.inc.h.
>

Why only pclmulqdq, and not entire CLMUL instruction set?

> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  target/i386/sse-opcode.inc.h | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/target/i386/sse-opcode.inc.h b/target/i386/sse-opcode.inc.h
> index f43436213e..1359508424 100644
> --- a/target/i386/sse-opcode.inc.h
> +++ b/target/i386/sse-opcode.inc.h
> @@ -449,6 +449,26 @@
>   * 66 0F 3A 61 /r imm8     PCMPESTRI xmm1, xmm2/m128, imm8
>   * 66 0F 3A 62 /r imm8     PCMPISTRM xmm1, xmm2/m128, imm8
>   * 66 0F 3A 63 /r imm8     PCMPISTRI xmm1, xmm2/m128, imm8
> + *
> + * AES Instructions
> + * -----------------
> + * 66 0F 38 DE /r                  AESDEC xmm1, xmm2/m128
> + * VEX.128.66.0F38.WIG DE /r       VAESDEC xmm1, xmm2, xmm3/m128
> + * 66 0F 38 DF /r                  AESDECLAST xmm1, xmm2/m128
> + * VEX.128.66.0F38.WIG DF /r       VAESDECLAST xmm1, xmm2, xmm3/m128
> + * 66 0F 38 DC /r                  AESENC xmm1, xmm2/m128
> + * VEX.128.66.0F38.WIG DC /r       VAESENC xmm1, xmm2, xmm3/m128
> + * 66 0F 38 DD /r                  AESENCLAST xmm1, xmm2/m128
> + * VEX.128.66.0F38.WIG DD /r       VAESENCLAST xmm1, xmm2, xmm3/m128
> + * 66 0F 38 DB /r                  AESIMC xmm1, xmm2/m128
> + * VEX.128.66.0F38.WIG DB /r       VAESIMC xmm1, xmm2/m128
> + * 66 0F 3A DF /r ib               AESKEYGENASSIST xmm1, xmm2/m128, imm8
> + * VEX.128.66.0F3A.WIG DF /r ib    VAESKEYGENASSIST xmm1, xmm2/m128, imm=
8
> + *
> + * PCLMULQDQ Instructions
> + * -----------------------
> + * 66 0F 3A 44 /r ib               PCLMULQDQ xmm1, xmm2/m128, imm8
> + * VEX.128.66.0F3A.WIG 44 /r ib    VPCLMULQDQ xmm1, xmm2, xmm3/m128, imm=
8
>   */
>
>  OPCODE(movd, LEG(NP, 0F, 0, 0x6e), MMX, WR, Pq, Ed)
> @@ -641,6 +661,20 @@ OPCODE(roundps, LEG(66, 0F3A, 0, 0x08), SSE4_1, WRR,
Vdq, Wdq, Ib)
>  OPCODE(roundpd, LEG(66, 0F3A, 0, 0x09), SSE4_1, WRR, Vdq, Wdq, Ib)
>  OPCODE(roundss, LEG(66, 0F3A, 0, 0x0a), SSE4_1, WRR, Vd, Wd, Ib)
>  OPCODE(roundsd, LEG(66, 0F3A, 0, 0x0b), SSE4_1, WRR, Vq, Wq, Ib)
> +OPCODE(aesdec, LEG(66, 0F38, 0, 0xde), AES, WRR, Vdq, Vdq, Wdq)
> +OPCODE(vaesdec, VEX(128, 66, 0F38, IG, 0xde), AES_AVX, WRR, Vdq, Hdq,
Wdq)
> +OPCODE(aesdeclast, LEG(66, 0F38, 0, 0xdf), AES, WRR, Vdq, Vdq, Wdq)
> +OPCODE(vaesdeclast, VEX(128, 66, 0F38, IG, 0xdf), AES_AVX, WRR, Vdq,
Hdq, Wdq)
> +OPCODE(aesenc, LEG(66, 0F38, 0, 0xdc), AES, WRR, Vdq, Vdq, Wdq)
> +OPCODE(vaesenc, VEX(128, 66, 0F38, IG, 0xdc), AES_AVX, WRR, Vdq, Hdq,
Wdq)
> +OPCODE(aesenclast, LEG(66, 0F38, 0, 0xdd), AES, WRR, Vdq, Vdq, Wdq)
> +OPCODE(vaesenclast, VEX(128, 66, 0F38, IG, 0xdd), AES_AVX, WRR, Vdq,
Hdq, Wdq)
> +OPCODE(aesimc, LEG(66, 0F38, 0, 0xdb), AES, WR, Vdq, Wdq)
> +OPCODE(vaesimc, VEX(128, 66, 0F38, IG, 0xdb), AES_AVX, WR, Vdq, Wdq)
> +OPCODE(aeskeygenassist, LEG(66, 0F3A, 0, 0xdf), AES, WRR, Vdq, Wdq, Ib)
> +OPCODE(vaeskeygenassist, VEX(128, 66, 0F3A, IG, 0xdf), AES_AVX, WRR,
Vdq, Wdq, Ib)
> +OPCODE(pclmulqdq, LEG(66, 0F3A, 0, 0x44), PCLMULQDQ, WRRR, Vdq, Vdq,
Wdq, Ib)
> +OPCODE(vpclmulqdq, VEX(128, 66, 0F3A, IG, 0x44), PCLMULQDQ_AVX, WRRR,
Vdq, Hdq, Wdq, Ib)
>  OPCODE(pcmpeqb, LEG(NP, 0F, 0, 0x74), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(pcmpeqb, LEG(66, 0F, 0, 0x74), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(pcmpeqw, LEG(NP, 0F, 0, 0x75), MMX, WRR, Pq, Pq, Qq)
> --
> 2.20.1
>
>
