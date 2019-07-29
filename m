Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B16C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2531206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpdSQ9V5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2531206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs5Mo-0007Gz-H4
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 09:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39757)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs5Lh-0006jt-Dn
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs5Lg-0006Eg-Fh
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:05:57 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33283)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs5Lg-0006E2-9N
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:05:56 -0400
Received: by mail-ot1-x342.google.com with SMTP id q20so62366820otl.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 06:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kHVhYfic0Bhc4iWY4yeO10UmswtGAufpQP2HzCG/LmI=;
 b=UpdSQ9V519tUHFE192qV05YHWK0pOFETq2Q0P41un3Hg+/TqRGu0Gu5SOKLjY63lr7
 Ep9XA6R+qUHExmgvdGNMmG0fIwi/mSSCxZmFPuQj7Mztc0rCXWFowfU3ftGxS5ejlLp/
 87fC23CiUgjc9LPyXFSAZIDPuRX/GdqWyun9muhIykAICa3CYdUfkCfsYzf5F0UI9Ze8
 4pp8txIpzmhfD/7qj/uXPvpLW9uMctKxJ6OaSB1rgcZDsioAXZNqzOcFIMaH1ToAkVkU
 fjG/RqlPrtcfvNh0nH8tjgokdOWcceNJ1YhC20QNX33yYY3gGxtUWLzfbQIfOGOUXQJS
 sd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kHVhYfic0Bhc4iWY4yeO10UmswtGAufpQP2HzCG/LmI=;
 b=WAZApx5zNAP5/oYyKaht/aGFOhJPz9HZ+ZigrYmL2PadD97UvuyP4+1hy0RoxPAJLb
 2vuqEdANNZTuKfcZr32/+W+LWEQzuCj3ZJozKV1syh24ewjG7Csx90HsyDlCMnrRJiJ/
 4GKxP3Rl70F5J+7sIwqTuGZ62jMwITYXTqpmWfhqecRskJTRYKwnvlRRTq3VRvM+C36s
 yFSlj00UDPwJRE9OtPACkjrmQubxmhEHjIqgcDObwCUu6nXb0zD69DZIANh/s6cLfAYy
 4IEGuRana6eZ5oxNHZOKkBUOXw444gxWNAXq7hVNtXR1QUrIi5EEj0cOPbmk5nm9LDwl
 Z+rA==
X-Gm-Message-State: APjAAAXsjTxHlKYwRhAPoPvvqk6+s74eZZvh2qz0MdrS0wOXPzW9uNCS
 HyKcBV8Aie2WoYqcghlSJ/iANT6l+1a54qAXkohuvg==
X-Google-Smtp-Source: APXvYqwzAk2PuvvY/SAKA3lb8xW4qjTr8avVX0Qepxw6RQy26rHHAhe2lT4PRE9clJO880yTgnhN9aZDyFX/tR3afSI=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr22951231oti.91.1564405554831; 
 Mon, 29 Jul 2019 06:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190701123108.12493-1-philmd@redhat.com>
 <20190701123108.12493-5-philmd@redhat.com>
In-Reply-To: <20190701123108.12493-5-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 14:05:44 +0100
Message-ID: <CAFEAcA8sBj23KTBVJRwQe7_jFgD9zmhbQx-SqJqWssUYALhYzw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 4/6] hw/arm/fsl-imx: Add the cpu as child
 of the SoC object
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
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/arm/fsl-imx25.c | 4 +++-
>  hw/arm/fsl-imx31.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
> index 869ee89b15..a237e967e4 100644
> --- a/hw/arm/fsl-imx25.c
> +++ b/hw/arm/fsl-imx25.c
> @@ -36,7 +36,9 @@ static void fsl_imx25_init(Object *obj)
>      FslIMX25State *s =3D FSL_IMX25(obj);
>      int i;
>
> -    object_initialize(&s->cpu, sizeof(s->cpu), "arm926-" TYPE_ARM_CPU);
> +    object_initialize_child(obj, "cpu", &s->cpu, sizeof(s->cpu),
> +                            ARM_CPU_TYPE_NAME("arm926"),
> +                            &error_abort, NULL);
>
>      sysbus_init_child_obj(obj, "avic", &s->avic, sizeof(s->avic),
>                            TYPE_IMX_AVIC);
> diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
> index 662fe78f1b..423d9ef076 100644
> --- a/hw/arm/fsl-imx31.c
> +++ b/hw/arm/fsl-imx31.c
> @@ -33,7 +33,9 @@ static void fsl_imx31_init(Object *obj)
>      FslIMX31State *s =3D FSL_IMX31(obj);
>      int i;
>
> -    object_initialize(&s->cpu, sizeof(s->cpu), "arm1136-" TYPE_ARM_CPU);
> +    object_initialize_child(obj, "cpu", &s->cpu, sizeof(s->cpu),
> +                            ARM_CPU_TYPE_NAME("arm1136"),
> +                            &error_abort, NULL);
>
>      sysbus_init_child_obj(obj, "avic", &s->avic, sizeof(s->avic),
>                            TYPE_IMX_AVIC);
> --
> 2.20.1

Really the ARM_CPU_TYPE_NAME part of this change should be
in patch 1 I think...

Could you expand the commit message a little to explain why
we want to make the CPU a child of the SoC object?

thanks
-- PMM

