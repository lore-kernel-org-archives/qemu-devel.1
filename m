Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801AAC54EEB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57FF420722
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57FF420722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGQWn-0002TX-Fy
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 13:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jGQVZ-0001SU-JO
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jGQVY-00022y-BB
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:05:01 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:11604)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jGQVR-0001w8-JS; Mon, 23 Mar 2020 13:04:53 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DE5C3747DFB;
 Mon, 23 Mar 2020 18:04:48 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BE4427476D5; Mon, 23 Mar 2020 18:04:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BC47E746381;
 Mon, 23 Mar 2020 18:04:48 +0100 (CET)
Date: Mon, 23 Mar 2020 18:04:48 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw/ide/sii3112: Use qdev gpio rather than
 qemu_allocate_irqs()
In-Reply-To: <20200323151715.29454-1-peter.maydell@linaro.org>
Message-ID: <alpine.BSF.2.22.395.2003231801370.76703@zero.eik.bme.hu>
References: <20200323151715.29454-1-peter.maydell@linaro.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: qemu-ppc@nongnu.org,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Mar 2020, Peter Maydell wrote:
> Coverity points out (CID 1421984) that we are leaking the
> memory returned by qemu_allocate_irqs(). We can avoid this
> leak by switching to using qdev_init_gpio_in(); the base
> class finalize will free the irqs that this allocates under
> the hood.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is how the 'use qdev gpio' approach to fixing the leak looks.
> Disclaimer: I have only tested this with "make check", nothing more.
>
> hw/ide/sii3112.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
> index 06605d7af2b..2ae6f5d9df6 100644
> --- a/hw/ide/sii3112.c
> +++ b/hw/ide/sii3112.c
> @@ -251,8 +251,8 @@ static void sii3112_pci_realize(PCIDevice *dev, Error **errp)
> {
>     SiI3112PCIState *d = SII3112_PCI(dev);
>     PCIIDEState *s = PCI_IDE(dev);
> +    DeviceState *ds = DEVICE(dev);
>     MemoryRegion *mr;
> -    qemu_irq *irq;
>     int i;
>
>     pci_config_set_interrupt_pin(dev->config, 1);
> @@ -280,10 +280,10 @@ static void sii3112_pci_realize(PCIDevice *dev, Error **errp)
>     memory_region_init_alias(mr, OBJECT(d), "sii3112.bar4", &d->mmio, 0, 16);
>     pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, mr);
>
> -    irq = qemu_allocate_irqs(sii3112_set_irq, d, 2);
> +    qdev_init_gpio_in(ds, sii3112_set_irq, 2);
>     for (i = 0; i < 2; i++) {
>         ide_bus_new(&s->bus[i], sizeof(s->bus[i]), DEVICE(dev), i, 1);
> -        ide_init2(&s->bus[i], irq[i]);
> +        ide_init2(&s->bus[i], qdev_get_gpio_in(ds, i));

Maybe we could just use DEVICE(dev) here and above as well just like in 
ide_bus_new above just to keep it consistent and avoid the confusion 
caused by having dev, d, s and now also ds. DEVICE(dev) is short and clear 
enough I think.

Regards,
BALATON Zoltan

>
>         bmdma_init(&s->bus[i], &s->bmdma[i], s);
>         s->bmdma[i].bus = &s->bus[i];
>

