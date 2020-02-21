Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C28C35657
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65983206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U2b/wbq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65983206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5CJK-0002VJ-Ke
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 12:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5CDp-0004bY-Km
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5CDn-0000qa-9D
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:36:16 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39006)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5CDn-0000pl-31
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:36:15 -0500
Received: by mail-oi1-x241.google.com with SMTP id z2so2352788oih.6
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 09:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0hZPLrTx+QxGezTlJEFQJMlOxfvv4M75Fk3m8GySp+k=;
 b=U2b/wbq02FNihsBqsviMPt31jwOChWp25VW+C94NWjLSj9BQTP3TiXjrdP7o/Hr2W3
 uSLOF7xKUTGbjB5nr3MM9e/H9wvkgIGWp0h1tGFNwz2egdNqx38JTNfjp2aRd3znaye5
 HIcIkq5hk83QRvDLr/LNxW6ZWRn7CYwhUpkFmry71tGpSiSFwg9vhD2OSj7jjTIwHuiS
 pvzDRvoHxMOgWXHtt3DBEsx4DFkLAE2AJlWcTRo8+VUoXRH/n2H1eBcCDvcrY8dGDC7I
 pYvhqhP6cv06WiMO8XLBLXdfRPb0dRJLOm/Ps6FBEedGpN16TVdb4sbqcsfT+SkFpoMe
 aQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0hZPLrTx+QxGezTlJEFQJMlOxfvv4M75Fk3m8GySp+k=;
 b=e0n/QKVzN56gqvMRr/KKOQrQ9GDoJq5PqGnHHeytP7igit6/zgks9Za+XoJiIeGR80
 pUz1vBlb8dn5D6imaXW/7xuJsQAO++czaVzGQPG1r1V/kFChgBfVyvy4U+G+GdvZE9iY
 doA/+lXoKnj5N8vwndw94tEjfXs/onQK7W3sODTkkObYKu1JAQAEZagLNfHoi2dKoqew
 JSfPEEb4/6LweNy8+dK4miTm9fGRkbGC8S+HXVowOyQgwTDEnmgwa4zLsMMmunrYbrbO
 zW0lsPs9BRCQDEwTiPxvAmdraKBrCHSRSf2s739m/lTPNgJmQeJxiabMIE8+apCCszTa
 RBzQ==
X-Gm-Message-State: APjAAAVyEaL0UiguufS57rAIs7iPvUFF+Ti1Ru2JQstjZI+X7EB7eXDh
 iXpbuRjOl3eBUJVbEFeBgLAsoFNMsVgwoI3JiLxcvA==
X-Google-Smtp-Source: APXvYqxBxfiMzNYJBdQd5tbj09NPw89aj7x9fXxH8sgTJ2tSl6KBacWukJH47LxuJTcXu05BUZzIAD44OmjsLSadG9U=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr2834616oie.146.1582306574231; 
 Fri, 21 Feb 2020 09:36:14 -0800 (PST)
MIME-Version: 1.0
References: <20200221173049.18134-1-philmd@redhat.com>
 <20200221173049.18134-3-philmd@redhat.com>
In-Reply-To: <20200221173049.18134-3-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 17:36:03 +0000
Message-ID: <CAFEAcA8+LWYhNjaXUu-Y2oat1hsKGbt6Hcir_yeNpmY+c6+8KA@mail.gmail.com>
Subject: Re: [PATCH 2/7] hw/arm: Let devices own the MemoryRegion they create
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Laurent Vivier <laurent@vivier.eu>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Peter Chubb <peter.chubb@nicta.com.au>, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Feb 2020 at 17:31, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> To avoid orphean memory regions being added in the /unattached

("orphan")

> QOM container, use the memory_region_owner_nonnull.cocci script
> to set the correct ownership.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/arm/exynos4210.c    | 14 +++++++-------
>  hw/arm/fsl-imx25.c     | 14 +++++++-------
>  hw/arm/fsl-imx31.c     | 10 +++++-----
>  hw/arm/fsl-imx6.c      | 10 +++++-----
>  hw/arm/fsl-imx6ul.c    | 14 +++++++-------
>  hw/arm/msf2-soc.c      |  8 ++++----
>  hw/arm/nrf51_soc.c     |  2 +-
>  hw/arm/stm32f205_soc.c | 10 +++++-----
>  hw/arm/stm32f405_soc.c | 13 +++++++------
>  hw/arm/xlnx-zynqmp.c   | 13 ++++++-------
>  10 files changed, 54 insertions(+), 54 deletions(-)
>
> diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
> index 59a27bdd68..d4b05336ee 100644
> --- a/hw/arm/exynos4210.c
> +++ b/hw/arm/exynos4210.c
> @@ -305,28 +305,28 @@ static void exynos4210_realize(DeviceState *socdev,=
 Error **errp)
>      /*** Memory ***/
>
>      /* Chip-ID and OMR */
> -    memory_region_init_io(&s->chipid_mem, NULL, &exynos4210_chipid_and_o=
mr_ops,
> -        NULL, "exynos4210.chipid", sizeof(chipid_and_omr));
> +    memory_region_init_io(&s->chipid_mem, OBJECT(socdev),
> +                          &exynos4210_chipid_and_omr_ops, NULL,
> +                          "exynos4210.chipid", sizeof(chipid_and_omr));
>      memory_region_add_subregion(system_mem, EXYNOS4210_CHIPID_ADDR,
>                                  &s->chipid_mem);
>
>      /* Internal ROM */
> -    memory_region_init_ram(&s->irom_mem, NULL, "exynos4210.irom",
> +    memory_region_init_ram(&s->irom_mem, OBJECT(socdev), "exynos4210.iro=
m",
>                             EXYNOS4210_IROM_SIZE, &error_fatal);

I have a feeling that the owner of a RAM memory region affects
the name we use for the underlying ramblock, which in turn
is used in the on-the-wire data stream in migration, which means
that changing ownership breaks migration compatibility.
That's probably OK in most cases as we don't care too much
about migration-compat on most boards, but I think it does
mean that you want to keep those changes separated out from
the ones for IO and alias regions, which I think shouldn't
have visible effects.

thanks
-- PMM

