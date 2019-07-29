Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425D9C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:03:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F653206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eNNtL/kr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F653206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs5Jg-00064L-DM
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 09:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39314)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs5JC-0005a3-7u
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs5JB-0002YN-7c
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:03:22 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38474)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs5JB-0002Wx-1F
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:03:21 -0400
Received: by mail-ot1-x344.google.com with SMTP id d17so62470540oth.5
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 06:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0nmGx14sqB9+L0dLj4XTAPxsMuhGjWxWPCBTknT9k8k=;
 b=eNNtL/kr32vxeow49yoLZ4wX++qkTYfLQVwLqxxQWCr3blmct+u220G6Rdon3naR1f
 Q6U6b8ZyEEK0PtwXR9fSvlm77qErM+WY2syi3wVl2kiBaJfRRlLy7vwMwvW0vP3dXPTy
 709nqfrp2GWhkcTE6S7sgR4Kgs068fFJXBP2BACEKQYSjYwO3GbvHi3bDD076J1mdzXD
 ciJcTJ0eOvTrazKimaTsZv6Yd2d/s5UQ2C0x+On0OqnkV9ecn8O2XP2Z0mjCIKZ9G1Y2
 XVPZoC1uDDCphh7CBvGcbMiNxkDqgqrLAEk2aG79e55cowl/+/cLZNTKrtQLcG1Dd7aw
 QORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0nmGx14sqB9+L0dLj4XTAPxsMuhGjWxWPCBTknT9k8k=;
 b=cH/7pUl+ZIv/ac0rCUhoIWHGYzkRsmE0MCBbKMAoPGhfx1bUHqQrChxDAPr6s2mrWi
 U+ZK8M9aa4bZ0HB5dX8GfZ2p9c5ZR+3wVN0p/FojKMlRs1qJKkA5GkjpuRf1joat1gc+
 5wUoM6JQ4IKZRX6UF4TslnlrCxjuHhR37KmPDTV57fw/5jhgVkuw/qy+nYOorv5o37Dv
 QG2gENj35fMaboUAUubBDW+sDoWz35WOOPYWq4KCJ1kLzbQK9T0i/VPv1wiCiHDvcpYM
 d3W1pXXjDvIUYoQpaA6hPNne2g2qqu7I53+2w9rFrGeNbErsEDf0urQOEckmYBz15S/V
 7U9A==
X-Gm-Message-State: APjAAAUv+eP/8VP7/oEcve1bb+Zrh7708u1h0EVoowCBR2mYvyCQ6OpK
 dmZMQoET6SUWN0wLQRQHvAzPdnwTbmxshX7ElsTcHQ==
X-Google-Smtp-Source: APXvYqwbHpEJTn/JYpkXLcok3r1dhF741MfVxNyMvlHIkvYsoQCAvxUyXi96SkrXzKKQRy3OJCiBXYx/C8NQgRKNTx8=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr52045292otn.135.1564405400036; 
 Mon, 29 Jul 2019 06:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190701123108.12493-1-philmd@redhat.com>
 <20190701123108.12493-4-philmd@redhat.com>
In-Reply-To: <20190701123108.12493-4-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 14:03:09 +0100
Message-ID: <CAFEAcA_m3LiLQqL8y6rT=HGeoa7B5XAQH9Wuo=Hg-94PaV3Zsg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 3/6] hw/arm: Use sysbus_init_child_obj for
 correct reference counting
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
> As explained in commit aff39be0ed97:
>
>   Both functions, object_initialize() and object_property_add_child()
>   increase the reference counter of the new object, so one of the
>   references has to be dropped afterwards to get the reference
>   counting right. Otherwise the child object will not be properly
>   cleaned up when the parent gets destroyed.
>   Thus let's use now object_initialize_child() instead to get the
>   reference counting here right.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/arm/exynos4_boards.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
> index ac0b0dc2a9..5dd53d2a23 100644
> --- a/hw/arm/exynos4_boards.c
> +++ b/hw/arm/exynos4_boards.c
> @@ -129,8 +129,8 @@ exynos4_boards_init_common(MachineState *machine,
>      exynos4_boards_init_ram(s, get_system_memory(),
>                              exynos4_board_ram_size[board_type]);
>
> -    object_initialize(&s->soc, sizeof(s->soc), TYPE_EXYNOS4210_SOC);
> -    qdev_set_parent_bus(DEVICE(&s->soc), sysbus_get_default());
> +    sysbus_init_child_obj(OBJECT(machine), "soc",
> +                          &s->soc, sizeof(s->soc), TYPE_EXYNOS4210_SOC);
>      object_property_set_bool(OBJECT(&s->soc), true, "realized",
>                               &error_fatal);

I suspect the code change here is correct but it doesn't seem
to match the commit message -- the old code is not calling
object_property_add_child() at all, and the new code does not
call object_initialize_child()...

thanks
-- PMM

