Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB42C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4BE206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NqvHSayB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4BE206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isRj4-0001NE-Qu
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isRhp-0000TR-2a
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isRhn-0006Ce-LM
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:30:32 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isRhn-0006Bm-Ft
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:30:31 -0500
Received: by mail-ot1-x341.google.com with SMTP id m2so17677984otq.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 05:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U6lmHJAPfQiQkYws4wu1JYbjB0vbSu9F1bgBg8wmbmI=;
 b=NqvHSayBE0KS5YhWV/99vNmeJgAx/KVQh6/N3QWALQl9hXLpFm13rx7cdlmXsmG4o6
 oLPPFkL7Z0Wtlflxr5GFuqsgZyuPSbGIVx131qDxZahZ7wRB4+WDGyUlgeoMVIprabYe
 N1kUDfpyyrI56saZ47D0gnpX7pANmiHqQBhlQ3V6wrkThUDTagFssy3OiHyeZKr5llny
 rCEgXmgzzyULmrWDhySdJniKS/S5eaNfsULQG2sgx6a/Q/v0k/cE8S0KclAab85VUo6Q
 V6PXviGP/OFDiDmcCo8Q12puAkS1+Rhdigwvpx8iUmtv9u1M/O/8aNS6avX4PLpObg2d
 N8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U6lmHJAPfQiQkYws4wu1JYbjB0vbSu9F1bgBg8wmbmI=;
 b=dOwDgIh+ErF/A333Ec7qL9zlPv25Graptyl/AJKfkVGZGBKluTmaI55fhikx70F0of
 mFEbScKO6PDzAEQrRnD4EUo5y8v5FnLdNqJiuj/8y39dCFx01AH4LhsCU25fWDnJX22S
 fPY+VKiW7S2+4lUPKxEvPA1y2xW0/MUgzV5BytDJvJRoQKMOlcdtdxDhHJSrAFfnMxIz
 eePoSAkKmjtMyQ64ddtzDV+ZOjAp/fIAapC/0YtpVGIxoaqO7n6+OsW5XV/4tFbd3NyK
 4pkbhYxqENgpC9P/ex9wc3OwcfYqgG5BIN2yBCRRzN5+i1C0yGJIj+MG57uWYb7NPcgu
 SfGA==
X-Gm-Message-State: APjAAAWVlcbPDXPMW1NwwydhCG8JOY3MQFC5HJ2cUNl33DPb35VIGxVq
 IdPSsXkza8Va/2c3l+XHIT5SZrHoemm8Va28ohn/oQ==
X-Google-Smtp-Source: APXvYqzd6Ic1dcrUpvygYFM14TonXO+Zb26lZJrEjgb9pamcjBAjMK80z/aULBoeiZ/DprTQLkTSZVKAsvtSBb2VRyI=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr6128143ota.232.1579267830256; 
 Fri, 17 Jan 2020 05:30:30 -0800 (PST)
MIME-Version: 1.0
References: <20200110203942.5745-1-linux@roeck-us.net>
 <20200110203942.5745-3-linux@roeck-us.net>
In-Reply-To: <20200110203942.5745-3-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jan 2020 13:30:19 +0000
Message-ID: <CAFEAcA_CeenDy9cNpQi6YpnT5rV+V10+EwYh=-zJEtjaT_gdDA@mail.gmail.com>
Subject: Re: [PATCH 2/6] hw/arm/exynos4210: Fix DMA initialization
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jan 2020 at 20:39, Guenter Roeck <linux@roeck-us.net> wrote:
>
> First parameter to exynos4210_get_irq() is not the SPI port number,
> but the interrupt group number. Interrupt groups are 20 for mdma
> and 21 for pdma. Interrupts are not inverted. Controllers support 32
> events (pdma) or 31 events (mdma). Events must all be routed to a single
> interrupt line. Set other parameters as documented in Exynos4210 datasheet,
> section 8 (DMA controller).
>
> Fixes: 59520dc65e ("hw/arm/exynos4210: Add DMA support for the Exynos4210")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/arm/exynos4210.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
> index 77fbe1baab..c7b5c587b1 100644
> --- a/hw/arm/exynos4210.c
> +++ b/hw/arm/exynos4210.c
> @@ -166,17 +166,31 @@ static uint64_t exynos4210_calc_affinity(int cpu)
>      return (0x9 << ARM_AFF1_SHIFT) | cpu;
>  }
>
> -static void pl330_create(uint32_t base, qemu_irq irq, int nreq)
> +static void pl330_create(uint32_t base, qemu_irq irq, int nreq, int nevents,
> +                         int width)
>  {
>      SysBusDevice *busdev;
>      DeviceState *dev;
> +    int i;
>
>      dev = qdev_create(NULL, "pl330");
> +    qdev_prop_set_uint8(dev, "num_events", nevents);
> +    qdev_prop_set_uint8(dev, "num_chnls",  8);
>      qdev_prop_set_uint8(dev, "num_periph_req",  nreq);
> +
> +    qdev_prop_set_uint8(dev, "wr_cap", 4);
> +    qdev_prop_set_uint8(dev, "wr_q_dep", 8);
> +    qdev_prop_set_uint8(dev, "rd_cap", 4);
> +    qdev_prop_set_uint8(dev, "rd_q_dep", 8);
> +    qdev_prop_set_uint8(dev, "data_width", width);
> +    qdev_prop_set_uint16(dev, "data_buffer_dep", width);
>      qdev_init_nofail(dev);
>      busdev = SYS_BUS_DEVICE(dev);
>      sysbus_mmio_map(busdev, 0, base);
> -    sysbus_connect_irq(busdev, 0, irq);
> +    sysbus_connect_irq(busdev, 0, irq);         /* abort irq line */
> +    for (i = 0; i < nevents; i++) {
> +        sysbus_connect_irq(busdev, i + 1, irq); /* event irq lines */
> +    }

It isn't valid to connect multiple qemu_irq outputs to a single
input like this. If the hardware logically ORs the irq lines
together then you need to instantiate and wire up a TYPE_OR_IRQ
device (include/hw/or-irq.h) to do that. Unfortunately QEMU
doesn't catch accidental wiring of a qemu_irq to multiple
inputs, and it will even sort-of seem to work: the bug is that
if two inputs go high, and then one goes low, the destination
will get a "signal went low" call even though the first input
should still be holding the line high.

(Conversely, to connect one qemu_irq to multiple outputs you
need a TYPE_SPLIT_IRQ, include/hw/core/split-irq.h).

thanks
-- PMM

