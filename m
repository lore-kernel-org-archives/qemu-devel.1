Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20111C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 21:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF6B214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 21:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUjxtzGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF6B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9yw5-0006Y3-0a
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 17:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i9ysd-0003Kv-Gi
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 17:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i9ysc-0003bq-Gq
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 17:49:55 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:33123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i9ysc-0003bR-9Y; Mon, 16 Sep 2019 17:49:54 -0400
Received: by mail-lj1-x243.google.com with SMTP id a22so1442408ljd.0;
 Mon, 16 Sep 2019 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=O/O6J70Fxkkg7FnfFORE7Ns6SSnnp6Oy9OJhYcbHNQ8=;
 b=tUjxtzGochLJLIPykm8VoLdbVZP/nQWxLXi5b6NzN7ketw4LmgLnKTU/W/gvDZJzde
 qqsG2MkIul/6dqDsy4iU8zLxfzZ/xRW4YHab/NEtNich/YJO/rXvfB9He+ZGolr46wRN
 5NwBV+KzoQkotBPF84+G6I3Jc3Sf0SzUhRkLdxb4bMuX7bWhE2hmgHIqJgVQM3R2mRzy
 MZKUgYJwZipJI5KO1KwgL+RTSV2nBW4ZeEe2KHhFRyXfswY5NrvedF1zMGAIjpShSyLp
 /BubR/BesW76NN9msSwADe3a1TuNaZbX/pd0NXMJV8F3rRLaZcy+EDBDQRbYFB9FjicD
 ZA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=O/O6J70Fxkkg7FnfFORE7Ns6SSnnp6Oy9OJhYcbHNQ8=;
 b=nU3xGL/vIhN8nyEulNTLjO1plNV/QVTF1szIZn0C3IRgyB5rd9ZHkp5BUPG9LP6eD5
 sFc/yU7fWCFeRxdzC26sYrZqfQ427f+8NcIg405vk5I9M4ix+/O4qD6D5I+pJ9mY98V1
 KrNQqJBcpI/uKK9upGd7H7Hg9W0kL7NDWTz7G0v3Yoi6erFbq3ldml5SSlgYtMxciXKN
 pmjKthbmwjlkp9zNrEyi3VgbAKA3X7dfddRVXaOA2VjL8bmb0fEhi1W5C3DryezezD0x
 zZQB0XifAG0suxaE6+vaK4ifzCg+J51w39IggbKeHgBpR+cDQs8e2zStp89LeZ1En6yB
 wRZA==
X-Gm-Message-State: APjAAAUIQ4HxiOJNJ9AYAdkNXXUi4AXZpn5d+ZMDp2IEDBusYH68IiOQ
 qWBHv1f+AO5sD5C0tDRMq0KG4bUUqIF7ssuzlY4=
X-Google-Smtp-Source: APXvYqzuAxMa4F+17zWeTqonPNrFqz2mb2kdotDTAs7kfOfTPk9NcreOxMnM4U3TFOg3+c8Fbf8vTQxN51OYIfxmv/s=
X-Received: by 2002:a2e:990d:: with SMTP id v13mr43284lji.146.1568670592886;
 Mon, 16 Sep 2019 14:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190916154847.28936-1-philmd@redhat.com>
 <20190916154847.28936-11-philmd@redhat.com>
In-Reply-To: <20190916154847.28936-11-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Sep 2019 14:45:21 -0700
Message-ID: <CAKmqyKOs7qybjWJFLKq1n=A0sfY-3285JR-TkdetVFbHxr_Ypw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCH 10/13] hw: Move Exynos4210 RTC from
 hw/timer/ to hw/rtc/ subdirectory
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, "open list:New World" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 16, 2019 at 9:00 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Move RTC devices under the hw/rtc/ subdirectory.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/rtc/Makefile.objs               | 1 +
>  hw/{timer =3D> rtc}/exynos4210_rtc.c | 0
>  hw/timer/Makefile.objs             | 1 -
>  3 files changed, 1 insertion(+), 1 deletion(-)
>  rename hw/{timer =3D> rtc}/exynos4210_rtc.c (100%)
>
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index 543a550a0f..3d4763fc26 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -7,5 +7,6 @@ endif
>  common-obj-$(CONFIG_PL031) +=3D pl031.o
>  common-obj-$(CONFIG_TWL92230) +=3D twl92230.o
>  common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-rtc.o
> +common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_rtc.o
>  obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
>  common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
> diff --git a/hw/timer/exynos4210_rtc.c b/hw/rtc/exynos4210_rtc.c
> similarity index 100%
> rename from hw/timer/exynos4210_rtc.c
> rename to hw/rtc/exynos4210_rtc.c
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 294465ef47..33191d74cb 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -19,7 +19,6 @@ common-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_timer.o
>  common-obj-$(CONFIG_ALTERA_TIMER) +=3D altera_timer.o
>  common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_mct.o
>  common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_pwm.o
> -common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_rtc.o
>  common-obj-$(CONFIG_OMAP) +=3D omap_gptimer.o
>  common-obj-$(CONFIG_OMAP) +=3D omap_synctimer.o
>  common-obj-$(CONFIG_PXA2XX) +=3D pxa2xx_timer.o
> --
> 2.20.1
>
>

