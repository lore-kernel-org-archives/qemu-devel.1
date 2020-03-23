Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2062CC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF27F20409
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XneQwzy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF27F20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGP5n-0002j2-04
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 11:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGP4j-0001jS-SR
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:33:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGP4h-0000Hp-SB
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:33:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58803)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGP4g-0000FY-70
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584977589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zxq2uDXOchcB2EyfBH+hK//n+GwLZI7tvnMEbLIc14=;
 b=XneQwzy8693ZSR20wHotYjq400+RvzdnM0yqLMTwW5POu5MT+4SpjYkJRbtCqkWvSjB/RR
 O3xxl3y5mjgTCApX6MyoHCsVzBUp2TmREPepLPSOwjGQyDgxnxLkQQdg76lUwN0UuID/S0
 nVVY3LHFGyKuOw5zjbRkKvTtJ79v1QQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-IbJk5qb6PKWXODgoLbETOw-1; Mon, 23 Mar 2020 11:33:07 -0400
X-MC-Unique: IbJk5qb6PKWXODgoLbETOw-1
Received: by mail-wr1-f71.google.com with SMTP id p2so7528555wrw.8
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 08:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Sm9MnJe0GlJLEWT6P5emqU1WVVMIOH+0ks2LO/DY2eE=;
 b=Mf6yDJIRfDoViA52y+KFSM+yKk+gms0ODgRKpBPwZRrgAxoCkVUrYIz8gPaFxk3HQt
 nQh+6//X6cUyjP7h2m5DkUKj0snmebv02nCvDUTo3y2Au4wNX5JLNYY/Ypm4s41d4zZW
 GL/SlLZVcQ4H2abqVbBWkMigiq8bkfaWLHPARtTBHp0+V8/J+auHHf0++WJF2cWYPQef
 iDXbiMFYICFWlpp7KsMK5yaVhOE+rbiC/9MX09tfmmVFJN+AovhL74ucyg6H8bXsmgPn
 GgEaB8IIM7bq7dogjw3vdnMWQhuT+eBYY7SiHH9LqBBGqFuCAo42FfexTEDYYd+egd+8
 dMUg==
X-Gm-Message-State: ANhLgQ17papBM62H9/uJxNQGz2y2GMGIgDi/e59x6kniEXaEze9rasmg
 VV7XfGWj7b0+REMkVpFrQ+R/EEPOC/1AVOVTE+scF2pwu985CUInY97IA7mj8N7e5p8jm5NhEew
 MG/TBd++CFvPxCCs=
X-Received: by 2002:a1c:3b89:: with SMTP id i131mr27900503wma.35.1584977586145; 
 Mon, 23 Mar 2020 08:33:06 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuLwNQ3KKvzIoP9Xoa8XheZxORyoyNJ5gtU2qPbD9kwqnb/uTgMxk/9wdzi9e72o6NTrOeEqQ==
X-Received: by 2002:a1c:3b89:: with SMTP id i131mr27900484wma.35.1584977585900; 
 Mon, 23 Mar 2020 08:33:05 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id n1sm24047059wrj.77.2020.03.23.08.33.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 08:33:05 -0700 (PDT)
Subject: Re: [PATCH] hw/ide/sii3112: Use qdev gpio rather than
 qemu_allocate_irqs()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200323151715.29454-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <aa15d4e2-2d69-540f-ff60-5e538bd10232@redhat.com>
Date: Mon, 23 Mar 2020 16:33:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323151715.29454-1-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 4:17 PM, Peter Maydell wrote:
> Coverity points out (CID 1421984) that we are leaking the
> memory returned by qemu_allocate_irqs(). We can avoid this
> leak by switching to using qdev_init_gpio_in(); the base
> class finalize will free the irqs that this allocates under
> the hood.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is how the 'use qdev gpio' approach to fixing the leak looks.
> Disclaimer: I have only tested this with "make check", nothing more.
>=20
>   hw/ide/sii3112.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
> index 06605d7af2b..2ae6f5d9df6 100644
> --- a/hw/ide/sii3112.c
> +++ b/hw/ide/sii3112.c
> @@ -251,8 +251,8 @@ static void sii3112_pci_realize(PCIDevice *dev, Error=
 **errp)
>   {
>       SiI3112PCIState *d =3D SII3112_PCI(dev);
>       PCIIDEState *s =3D PCI_IDE(dev);
> +    DeviceState *ds =3D DEVICE(dev);
>       MemoryRegion *mr;
> -    qemu_irq *irq;
>       int i;
>  =20
>       pci_config_set_interrupt_pin(dev->config, 1);
> @@ -280,10 +280,10 @@ static void sii3112_pci_realize(PCIDevice *dev, Err=
or **errp)
>       memory_region_init_alias(mr, OBJECT(d), "sii3112.bar4", &d->mmio, 0=
, 16);
>       pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, mr);
>  =20
> -    irq =3D qemu_allocate_irqs(sii3112_set_irq, d, 2);
> +    qdev_init_gpio_in(ds, sii3112_set_irq, 2);
>       for (i =3D 0; i < 2; i++) {
>           ide_bus_new(&s->bus[i], sizeof(s->bus[i]), DEVICE(dev), i, 1);
> -        ide_init2(&s->bus[i], irq[i]);
> +        ide_init2(&s->bus[i], qdev_get_gpio_in(ds, i));
>  =20
>           bmdma_init(&s->bus[i], &s->bmdma[i], s);
>           s->bmdma[i].bus =3D &s->bus[i];
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


