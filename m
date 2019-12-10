Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E75FC2D0CB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 09:15:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E4D2073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 09:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rf+lVwMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E4D2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iebc3-00057L-Ej
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 04:15:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1iebbL-0004hp-SC
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 04:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent.desnogues@gmail.com>) id 1iebbK-0008JU-G2
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 04:14:39 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:32920)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
 id 1iebbK-0008ID-BK
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 04:14:38 -0500
Received: by mail-io1-xd41.google.com with SMTP id s25so3316240iob.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 01:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4YGWiQYlzj8DlpvgbyfAyMasu3Ce5XpNh/eMVwQ71r8=;
 b=rf+lVwMATLqzjds6z8Tuz58jRA3+yS0pD8fjTp230+M3U1Nk5i5oDhS9Gk8E2BlQI0
 TwQ9qB1N1eVlaJ0UlXPdfCtwqyr/N5ukLzCNctVNINHKkV+0WYnfvFDMH2JRkGLadvq4
 crwAPNdyw8FHxh7v3meN7ZH4oBrbgnCS57kLzvrVPyvcr1h5WpyFeNNsbq+X1xh5tMSZ
 GsEcF+BCTwBaDAOeeH10wHnOVbJX/NrFM8asZKhJfDK33iWpiVf/fDtkUBBLWZPS12zi
 Jju/WTjLgJWkF1AGbIqIWhn9H9OggGyXH7iVG+zADhF5e+y6qubjGj+/bH0nyd02LslW
 pgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4YGWiQYlzj8DlpvgbyfAyMasu3Ce5XpNh/eMVwQ71r8=;
 b=P82hRUjHHrDkdMzBQ2PqOd7pRbWw2meh4FwKspp9UAP5/lBsGwgQw2Nazo+ekezYgE
 3jaDl76RORxLEMA0718mPftCnFSsdX68QUiYQRgVZYCMfsVE/Saq1BQ2NmGyHn9eWWmk
 7HhmUiBFju9rjs4PW/mVx6cfA7IJf081ONS0lbfWqlA8QtePGPwv/vlTnIhPe1nQ5nB+
 TfBkMQmKDD/88nP1yn7euEi0zkL1+TCzmazbN4IBX17FDg56uQ55uUoPRU7en39ym8Po
 Wzn85PkDO+izp3b33GbE1yWBatR2mtuVi8ZDeP8eDNVdbUWYnfZgbxVmCaUMqjS5lQ2N
 ILyQ==
X-Gm-Message-State: APjAAAWwZhexk/Bhdjy+KsrbIvqizQL4AIl77KCWXrM2VP2WVAlfCamd
 iV7XuZpRQJaReXQTariUjatSndXzcL9kjjy6XxQ=
X-Google-Smtp-Source: APXvYqxOWTehnTxgIoZTNQSQ/GJuuKqqUAXfL2EKok31Az7B9etoD+umU3SHTO47Of8xWrSkykk5KsNLlAiGkqTejvI=
X-Received: by 2002:a5e:df06:: with SMTP id f6mr24080351ioq.84.1575969276909; 
 Tue, 10 Dec 2019 01:14:36 -0800 (PST)
MIME-Version: 1.0
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-5-richard.henderson@linaro.org>
In-Reply-To: <20191203022937.1474-5-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Tue, 10 Dec 2019 10:14:26 +0100
Message-ID: <CABoDooNO--7ABzKexAy7__2ED4sfyeA08ai5jxXBjy_DT+bzgw@mail.gmail.com>
Subject: Re: [PATCH v4 04/40] target/arm: Add TTBR1_EL2
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

On Tue, Dec 3, 2019 at 3:35 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> At the same time, add writefn to TTBR0_EL2 and TCR_EL2.
> A later patch will update any ASID therein.
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index b4d774632d..06ec4641f3 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3484,6 +3484,12 @@ static void vmsa_ttbr_write(CPUARMState *env, cons=
t ARMCPRegInfo *ri,
>      raw_write(env, ri, value);
>  }
>
> +static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo=
 *ri,
> +                                    uint64_t value)
> +{
> +    raw_write(env, ri, value);
> +}
> +
>  static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                          uint64_t value)
>  {
> @@ -4893,10 +4899,8 @@ static const ARMCPRegInfo el2_cp_reginfo[] =3D {
>        .resetvalue =3D 0 },
>      { .name =3D "TCR_EL2", .state =3D ARM_CP_STATE_BOTH,
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 2, .crm =3D 0, .opc2 =3D 2,
> -      .access =3D PL2_RW,
> -      /* no .writefn needed as this can't cause an ASID change;
> -       * no .raw_writefn or .resetfn needed as we never use mask/base_ma=
sk
> -       */
> +      .access =3D PL2_RW, .writefn =3D vmsa_tcr_ttbr_el2_write,

Are you sure you should call vmsa_tcr_ttbr_el2_write for a tcr_el2
write?  As far as I can see, tcr_el2 has no ASID field in bits
[63:48]. On the other hand there are various other bits in TCR_EL2
that might require a TLB flush; for instance the A1 bit [22] that
defines where to pick ASID from.

Thanks,

Laurent

> +      /* no .raw_writefn or .resetfn needed as we never use mask/base_ma=
sk */
>        .fieldoffset =3D offsetof(CPUARMState, cp15.tcr_el[2]) },
>      { .name =3D "VTCR", .state =3D ARM_CP_STATE_AA32,
>        .cp =3D 15, .opc1 =3D 4, .crn =3D 2, .crm =3D 1, .opc2 =3D 2,
> @@ -4930,7 +4934,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] =3D {
>        .fieldoffset =3D offsetof(CPUARMState, cp15.tpidr_el[2]) },
>      { .name =3D "TTBR0_EL2", .state =3D ARM_CP_STATE_AA64,
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 2, .crm =3D 0, .opc2 =3D 0,
> -      .access =3D PL2_RW, .resetvalue =3D 0,
> +      .access =3D PL2_RW, .resetvalue =3D 0, .writefn =3D vmsa_tcr_ttbr_=
el2_write,
>        .fieldoffset =3D offsetof(CPUARMState, cp15.ttbr0_el[2]) },
>      { .name =3D "HTTBR", .cp =3D 15, .opc1 =3D 4, .crm =3D 2,
>        .access =3D PL2_RW, .type =3D ARM_CP_64BIT | ARM_CP_ALIAS,
> @@ -6959,6 +6963,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .opc0 =3D 3, .opc1 =3D 4, .crn =3D 13, .crm =3D 0, .opc2 =
=3D 1,
>                .access =3D PL2_RW,
>                .fieldoffset =3D offsetof(CPUARMState, cp15.contextidr_el[=
2]) },
> +            { .name =3D "TTBR1_EL2", .state =3D ARM_CP_STATE_AA64,
> +              .opc0 =3D 3, .opc1 =3D 4, .crn =3D 2, .crm =3D 0, .opc2 =
=3D 1,
> +              .access =3D PL2_RW, .writefn =3D vmsa_tcr_ttbr_el2_write,
> +              .fieldoffset =3D offsetof(CPUARMState, cp15.ttbr1_el[2]) }=
,
>              REGINFO_SENTINEL
>          };
>          define_arm_cp_regs(cpu, vhe_reginfo);
> --
> 2.17.1
>
>

