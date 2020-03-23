Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66FEC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728B220771
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qp8dqMIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728B220771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGQcZ-0007Ht-Ky
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 13:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGQbq-0006OI-WE
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGQbp-0004Ry-KX
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:11:30 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGQbp-0004RT-BQ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:11:29 -0400
Received: by mail-ot1-x343.google.com with SMTP id 22so8680729otf.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 10:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1o0FnbphKQPcbBGAsH8BBA2d8/sqeUHK85A+sdpkfN8=;
 b=Qp8dqMIpX1IUOc3FqAA1R6nYdfbierWppLtaIK+mwym+nRPCozBOJZwVbEsLSlavrQ
 gzR/u8YkDJdeg+aN+y9qYsgwk/20fTaep4w06dhLvWN1+xSIzmsrdaSdexifLAkvpzXo
 Rt0OfDKx0fm2oVM0KKBwnLAbvqZEcw1PXGu9sDDyokfnm6Iq4OODij3HFvJMmafbQ86n
 ++N3Uxc51PkaZknog942bnJi0OCYW/iRvVExsacwCDWWHuEdMqf2fErZOJcUXbBmwVx5
 Cl7KwVU+2yN6ZoMD4iuSJkX38zBJ4LNayRDH1WpaOYaXTK5tVl+N4tLYPT+OfruXlpjN
 c4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1o0FnbphKQPcbBGAsH8BBA2d8/sqeUHK85A+sdpkfN8=;
 b=PnSFz5Yu9JzeCO2e3GaJbJwza+QenWgWOyOjvcP/x8CJvKKG+lsHu2maS0CsALTHFf
 TbBgLXi4OJ+HpowV0SJ2p6DBZOsS1uRdwHq2Itgq/DSp9pPLVuo9K8OXZq5QLtUJrzaq
 KO2AmmtOK69oBBFzYXuAPc/CJUupTN01MVzOHsugh9mX3LKt9NHTW2GvOXRBy1+0nBUO
 +OYHWK9MgtEsl+O1F63CYdauyje/l3VcDDfSeAKKQ9WlSL67IsAOM7YARETlrJHuBIAG
 CO3REdywMIls/njZIH2U3VwBjMyVCPXMwrsXQbPdA++7MMHX+A1AMqXP3AHMKnPsHGnR
 EUlg==
X-Gm-Message-State: ANhLgQ0kJR35zR5OPQ18Sa9jO78ltP6u2UYQt+eYYqQoI8P1aHZ+z2DT
 r89tF/yZat0c226CrTkgMBean39jFmRkZlydTRd60A==
X-Google-Smtp-Source: ADFU+vsS1eYLiC9CzWB2xC9PFSOBfLxmj9z06Q1GWNurdOO3QjMhvAMk5HorugiurdiIvQRCxzKPSFrf3WuumU39VqQ=
X-Received: by 2002:a05:6830:1f39:: with SMTP id
 e25mr3758212oth.135.1584983488099; 
 Mon, 23 Mar 2020 10:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200323151715.29454-1-peter.maydell@linaro.org>
 <alpine.BSF.2.22.395.2003231801370.76703@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2003231801370.76703@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2020 17:11:16 +0000
Message-ID: <CAFEAcA9tywrbanjf5bF2LpR3cqbw21F8THy_9-tgDTCL0BRTjA@mail.gmail.com>
Subject: Re: [PATCH] hw/ide/sii3112: Use qdev gpio rather than
 qemu_allocate_irqs()
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Mar 2020 at 17:04, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Mon, 23 Mar 2020, Peter Maydell wrote:
> > Coverity points out (CID 1421984) that we are leaking the
> > memory returned by qemu_allocate_irqs(). We can avoid this
> > leak by switching to using qdev_init_gpio_in(); the base
> > class finalize will free the irqs that this allocates under
> > the hood.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > This is how the 'use qdev gpio' approach to fixing the leak looks.
> > Disclaimer: I have only tested this with "make check", nothing more.
> >
> > hw/ide/sii3112.c | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
> > index 06605d7af2b..2ae6f5d9df6 100644
> > --- a/hw/ide/sii3112.c
> > +++ b/hw/ide/sii3112.c
> > @@ -251,8 +251,8 @@ static void sii3112_pci_realize(PCIDevice *dev, Error **errp)
> > {
> >     SiI3112PCIState *d = SII3112_PCI(dev);
> >     PCIIDEState *s = PCI_IDE(dev);
> > +    DeviceState *ds = DEVICE(dev);
> >     MemoryRegion *mr;
> > -    qemu_irq *irq;
> >     int i;
> >
> >     pci_config_set_interrupt_pin(dev->config, 1);
> > @@ -280,10 +280,10 @@ static void sii3112_pci_realize(PCIDevice *dev, Error **errp)
> >     memory_region_init_alias(mr, OBJECT(d), "sii3112.bar4", &d->mmio, 0, 16);
> >     pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, mr);
> >
> > -    irq = qemu_allocate_irqs(sii3112_set_irq, d, 2);
> > +    qdev_init_gpio_in(ds, sii3112_set_irq, 2);
> >     for (i = 0; i < 2; i++) {
> >         ide_bus_new(&s->bus[i], sizeof(s->bus[i]), DEVICE(dev), i, 1);
> > -        ide_init2(&s->bus[i], irq[i]);
> > +        ide_init2(&s->bus[i], qdev_get_gpio_in(ds, i));
>
> Maybe we could just use DEVICE(dev) here and above as well just like in
> ide_bus_new above just to keep it consistent and avoid the confusion
> caused by having dev, d, s and now also ds. DEVICE(dev) is short and clear
> enough I think.

Usual style in these methods is to have local variables if
it's going to be used more than once or twice -- QOM casts
aren't free the way C casts are. We already do that here for
the SII3112_PCI() and the PCI_IDE().

In this case things are a bit confused by the function having
used "dev" for the PCIDevice* and 's' for the PCIIDEState.
QEMU is far from consistent in this matter, but usually 's'
is the pointer to the device's own state (ie SiI3112PCIState*
in this case) and the DeviceState* is 'dev'. The PCIDevice *
is often 'pci_dev'. I would call the PCIIDEState* 'pci_ide'.

I hadn't noticed the use of DEVICE() in ide_bus_new(); you're
right that we should be consistent about whether we use the cast
macro or the local variable.

thanks
-- PMM

