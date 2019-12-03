Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B5FC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2BF20661
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcu1flX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2BF20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic9Jv-0006pS-AC
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 09:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <roscaeugeniu@gmail.com>) id 1ic5mO-0001VI-EG
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <roscaeugeniu@gmail.com>) id 1ic5mI-0004Yg-95
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:51:36 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45521)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <roscaeugeniu@gmail.com>)
 id 1ic5mH-0004GY-WD
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:51:34 -0500
Received: by mail-wr1-x442.google.com with SMTP id j42so3002662wrj.12
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 02:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=aVH1wKqnS/0tpLzx3r/GAf1NKCehOyA/BPLaY/A9mZw=;
 b=bcu1flX4c17aWB0jdh6P6lZDIp/SLk/qdtJsKK+v1cgpyZysw5D8BZTfLyywHxESb/
 VbPx8AvNhzB4UezAY9fDA6YZEIwwIbWLpRUT7ffXDaeqnOU+vtIbypDjkrn9knnOeTKC
 lTKLKrvjcaTIsswNVoEAvjFcdX+t6BmlifXBAfwXCH9u4CLrNKNuFISMAOfA/L5bdHWy
 /9jY3s23Uwo3yZJSAuqrE1qGmH7CgWfGkf+C1i0/V4a9wAiblr4Msd4W2DkxhHoWYHcM
 7wdRPGB4fmqEulF7xyADd4vTG0DwEFv/aLwoThA10b2vKiINmT+yKPM/SJ6cmpjyUKkC
 X1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=aVH1wKqnS/0tpLzx3r/GAf1NKCehOyA/BPLaY/A9mZw=;
 b=YKnWMGgQRp4XNGtvX8paUf9ORRoIEDhFMfOFpoLetRG64+D+tzg8KXQcAF+8CZPjM0
 LuLyeKkXcJAvpiRzlf2s/tTnVdWVLkMRXkySAD/sEw3rZyBdrhpILqHVJ2uJ8X18jCb8
 c9uw19FcXEh2bxdZXz/i7Vo440giKY0esgBBXxqKnPmKdUJM3zIwnNisx6cpp3ii2Ifd
 7s8AVJEAuSbeqqmlvurS1vcUCKGQiIheiPQCvDMusp8XkDKIAB5hqJCH6k2exoIbGBiE
 4cgYPYxXGlhfQ9GGGfN0SU2vMXPQ7Xbndh27iHUecjJxoiZ0QohXGVRZmDAYFT4qBT1A
 TM3Q==
X-Gm-Message-State: APjAAAUEO6KH2KyAHBb+b2dW1pv6EtXub85eH7ovOk4AwBkItqQvjIYF
 RMdz9pYACoLVj2xU9O62NTg=
X-Google-Smtp-Source: APXvYqwmQ0zWTmSyqUGQ+uwoCR4ldO/zmwY8wc11jDimSnmv1YmHJBk/u09q6d+wdYGUiW8KtCogYA==
X-Received: by 2002:adf:ef10:: with SMTP id e16mr4196456wro.336.1575370278677; 
 Tue, 03 Dec 2019 02:51:18 -0800 (PST)
Received: from x230 (ipb218f57a.dynamic.kabel-deutschland.de. [178.24.245.122])
 by smtp.gmail.com with ESMTPSA id m8sm2618228wmf.8.2019.12.03.02.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 02:51:17 -0800 (PST)
From: Eugeniu Rosca <roscaeugeniu@gmail.com>
X-Google-Original-From: Eugeniu Rosca <erosca@de.adit-jv.com>
Date: Tue, 3 Dec 2019 11:51:03 +0100
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v3 5/7] gpio: Add GPIO Aggregator/Repeater driver
Message-ID: <20191203105103.GA20470@x230>
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-6-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127084253.16356-6-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
X-Mailman-Approved-At: Tue, 03 Dec 2019 09:05:26 -0500
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Phil Reid <preid@electromag.com.au>, Eugeniu Rosca <roscaeugeniu@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-doc@vger.kernel.org,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Harish Jenny K N <harish_kandiga@mentor.com>,
 linux-gpio@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <graf@amazon.com>, Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Geert,

On Wed, Nov 27, 2019 at 09:42:51AM +0100, Geert Uytterhoeven wrote:
> +static int gpio_aggregator_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct gpio_desc **descs;
> +	struct gpiochip_fwd *fwd;
> +	int i, n;

FWIW/FTR, doing some blind creation and deletion of gpio aggregator
chips [1] on R-Car H3ULCB overnight, kmemleak reported once [2]. Not
sure this is something 100% reproducible.

[1] while true; do \
   echo e6055400.gpio 12,13 > /sys/bus/platform/drivers/gpio-aggregator/new_device; \
   echo gpio-aggregator.0 > /sys/bus/platform/drivers/gpio-aggregator/delete_device; \
   done 

[2] unreferenced object 0xffff0006d2c2e000 (size 128):
  comm "kworker/3:1", pid 55, jiffies 4294676978 (age 38546.676s)
  hex dump (first 32 bytes):
    00 d9 d2 d3 06 00 ff ff 0c 00 e0 0f ff ff ff ff  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000a8e18c13>] slab_post_alloc_hook+0x8c/0x94
    [<000000006f419a4f>] __kmalloc+0x170/0x218
    [<0000000060d185ea>] kobj_map+0x78/0x1c0
    [<00000000c96645f3>] cdev_add+0x68/0x94
    [<00000000a7a5a8ac>] cdev_device_add+0x74/0x90
    [<00000000497871d3>] gpiochip_setup_dev+0x84/0x1f0
    [<00000000b993f95f>] gpiochip_add_data_with_key+0xbcc/0x11f0
    [<00000000fd728c0e>] devm_gpiochip_add_data+0x60/0xa8
    [<00000000442e34c1>] gpio_aggregator_probe+0x210/0x3c8
    [<00000000076e13fb>] platform_drv_probe+0x70/0xe4
    [<00000000de84b58b>] really_probe+0x2d8/0x434
    [<00000000c95c9784>] driver_probe_device+0x15c/0x16c
    [<00000000afb7dd4f>] __device_attach_driver+0xdc/0x120
    [<00000000efa40cae>] bus_for_each_drv+0x12c/0x154
    [<00000000c149acef>] __device_attach+0x148/0x1e0
    [<00000000a74fd158>] device_initial_probe+0x24/0x30

-- 
Best Regards,
Eugeniu

