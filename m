Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9179C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826E12054F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EzkS6K1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826E12054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs5NX-00086R-M3
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 09:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39892)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs5Mj-0007LB-GA
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs5Mh-000732-Ba
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:07:01 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs5Mg-00070z-Ui
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:06:59 -0400
Received: by mail-oi1-x242.google.com with SMTP id m206so45192338oib.12
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 06:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mdyxWRKxpIDaxM7CwYgZVBjscz0FA01kMqXEDGLg+G8=;
 b=EzkS6K1rn9nYMybFLNpP/xLSs9ID7Nj7Nr3B2APxnDBeGuNz6mJEaeldvgKS3LfLlt
 CHj7qR9v1hVeP9NGIvM6EpxLIeYSJfIQ3WGxm6VKvLe6ZgH+8bVVYEy8zM1iQHRYhHUp
 r1HDe2eDFr27CnAHyiH4Ay1hpeIYDn6pFwOUOVq4MxD7irQ3hdkJKdS8uZzbMk0yNE7g
 s1XXuQUK6mlGlqyIQyryMZnsQaOuE5tyd/tPcsxivzo5TEBC7eJT4SFKvsjXdEqionnI
 xMIRywOuQmFo7anPWfZsuxLhbjg6InNFXHvmq75sAmotETOIwOLiHCfyBKWJABoGji4u
 Jh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mdyxWRKxpIDaxM7CwYgZVBjscz0FA01kMqXEDGLg+G8=;
 b=jGzxvUhCy1kMojFFRM59J0EaQPVPScHck7gv95GGrohPYmsOo/iA/1uJ4LfLqhKPn7
 tBn94c5rIUq+W2Oi9OS3volR80QR3wMN/RoD1To4mcnyM6nIIjRXAGJCnAvnuibp1Hsp
 dvDVJJwFfXLdvMYByXk2VNrV5+COw/7PIB0IY2AaFa8iOohqsacT14Dbf74y0Wxn3MPi
 36+46C8jCHBZFrKl6JbKK1aQVXhnWJdBupvq3XfDoXemlFF0BM7wHwLbPy80hTVDDpbn
 zNg6SsPSR8jaj4EqzSEcVP5/LrkFRruEOOQyfNUqBdCfuv3AWZeNeWspnmYCGveescMl
 n4Ug==
X-Gm-Message-State: APjAAAUiblJzoeSz8gW6SYx76/1nkZLxRZWvKCIb+fRzMCReqJ/Orla3
 e8NUY2opvXzamgXZOTpK1dItdnSluylgM+yDfhK+TQ==
X-Google-Smtp-Source: APXvYqy4gJkegflmgtIqpAghc3US889ecRiplhnO1qSlqciTMXJTlGOwBQq/MsQ/OKsV8mppFeJhAJTRxTMWSn1MQoo=
X-Received: by 2002:aca:5cd7:: with SMTP id
 q206mr48926201oib.146.1564405617976; 
 Mon, 29 Jul 2019 06:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190701123108.12493-1-philmd@redhat.com>
 <20190701123108.12493-2-philmd@redhat.com>
In-Reply-To: <20190701123108.12493-2-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 14:06:47 +0100
Message-ID: <CAFEAcA8wiOuwDxDg2GaF+833kCmA3KiVhANy8VRstVbUm_cetw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 1/6] hw/arm: Use ARM_CPU_TYPE_NAME() macro
 when appropriate
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jul 2019 at 13:31, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Commit ba1ba5cca introduce the ARM_CPU_TYPE_NAME() macro.
> Unify the code base by use it in all places.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---


> diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
> index 05505bac56..1cbd8674bf 100644
> --- a/hw/arm/fsl-imx6ul.c
> +++ b/hw/arm/fsl-imx6ul.c
> @@ -35,7 +35,8 @@ static void fsl_imx6ul_init(Object *obj)
>      for (i =3D 0; i < MIN(smp_cpus, FSL_IMX6UL_NUM_CPUS); i++) {
>          snprintf(name, NAME_SIZE, "cpu%d", i);
>          object_initialize_child(obj, name, &s->cpu[i], sizeof(s->cpu[i])=
,
> -                                "cortex-a7-" TYPE_ARM_CPU, &error_abort,=
 NULL);
> +                                ARM_CPU_TYPE_NAME("cortex-a7"),
> +                                &error_abort, NULL);
>      }
>
>      /*

You'll find this part needs a minor fix to apply to master
now we've got rid of this loop-over-CPUs in fsl-imx6ul.c.

thanks
-- PMM

