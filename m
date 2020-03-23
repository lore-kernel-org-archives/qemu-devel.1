Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56285C54EEB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 14:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2593120786
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 14:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dR2A0ky4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2593120786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGOQa-0004GK-97
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 10:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGOPe-00030e-Oj
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGOPd-0002dX-0R
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:50:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40186)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGOPc-0002dJ-TE
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584975044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xn4zrrLC0Aq9194Vkg3Ovqh1sYUadqtoQJs+dsnQp58=;
 b=dR2A0ky4T7d9/ZEteAThyOLZUdJw74j3EvljyWRUYm0QbTJUCIku/JwWDkriMsVmE7rSMu
 OOKSsYhUwL3FSXFMuAsmRLqKFkLBwvnhUaLgU7zUCtDyiT1NVbwHg/J7OSoeThQzq0DtHw
 U31GjOTsvqpshqMKAaHauNzIGPgkYkQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-q9Z5ZZTHP3qL4r1XJG76BQ-1; Mon, 23 Mar 2020 10:50:40 -0400
X-MC-Unique: q9Z5ZZTHP3qL4r1XJG76BQ-1
Received: by mail-wm1-f70.google.com with SMTP id s15so4098217wmc.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 07:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xn4zrrLC0Aq9194Vkg3Ovqh1sYUadqtoQJs+dsnQp58=;
 b=LSnZzEpfopQqq6L5T1J2Mr+Ujm6eVMBPtjlbdMFQ71VHSqwGZay485yQD5lgLDErHB
 ainXFtYZP16tytaaxaBDSYQAlyUoY7zkASdx5GVWzTyDGh1IHTh1dyHQyXKJXwXjtcoG
 SiY5HF3VwalFPHvsfnVR7Y581fnnAx6GSHnv0JZADd9wOTqIeis33mvWMODUgj/QzFHK
 1CWp+9qIh4VpniA5WEsSsSONDpBk6qy+U70TIUUi3UucwqRPkyxTdYOgI3ViK8t5DfwM
 4V6XNvFoS0cYzPIJkVl4apyX11kxEkmSVPfQj4fopp6rBJdrBlotIVuwI/6B0y4pJhcc
 hTLg==
X-Gm-Message-State: ANhLgQ1NkWI9WIHhweJjXlwnkm17+qXUkPaPwhAvhd9m1J9JrwvYfo5n
 HAcxVTI6BcSRrRBzvFiCZAxAyN8YkXMJO2mfaV92qmOfmLEPOJyEBPwpjc7vDjZJhOHPE3t6UoK
 wdqEMVS8DJqmMPyE=
X-Received: by 2002:adf:ce8a:: with SMTP id r10mr9191674wrn.211.1584975039606; 
 Mon, 23 Mar 2020 07:50:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuhLWjUig3K7TOLx/TLXxPyrMkRe8U85ebG5z+mRyixQcDkPWfiiZur/2VWJPUJ94gONOVCKw==
X-Received: by 2002:adf:ce8a:: with SMTP id r10mr9191650wrn.211.1584975039328; 
 Mon, 23 Mar 2020 07:50:39 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id q8sm15625734wmj.22.2020.03.23.07.50.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 07:50:38 -0700 (PDT)
Subject: Re: [PATCH] ide/sii3112: Avoid leaking irqs array
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20200323143514.DB3B4747E04@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9dd18e5b-d1f1-7c3b-428f-0e549616a9d6@redhat.com>
Date: Mon, 23 Mar 2020 15:50:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323143514.DB3B4747E04@zero.eik.bme.hu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 3:32 PM, BALATON Zoltan wrote:
> Coverity CID 1421984 reports a leak in allocated irqs, this patch
> attempts to plug that.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ide/sii3112.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
> index 06605d7af2..c886916873 100644
> --- a/hw/ide/sii3112.c
> +++ b/hw/ide/sii3112.c
> @@ -31,6 +31,7 @@ typedef struct SiI3112Regs {
>   typedef struct SiI3112PCIState {
>       PCIIDEState i;
>       MemoryRegion mmio;
> +    qemu_irq *irqs;
>       SiI3112Regs regs[2];
>   } SiI3112PCIState;
>   
> @@ -252,7 +253,6 @@ static void sii3112_pci_realize(PCIDevice *dev, Error **errp)
>       SiI3112PCIState *d = SII3112_PCI(dev);
>       PCIIDEState *s = PCI_IDE(dev);
>       MemoryRegion *mr;
> -    qemu_irq *irq;
>       int i;
>   
>       pci_config_set_interrupt_pin(dev->config, 1);
> @@ -280,10 +280,10 @@ static void sii3112_pci_realize(PCIDevice *dev, Error **errp)
>       memory_region_init_alias(mr, OBJECT(d), "sii3112.bar4", &d->mmio, 0, 16);
>       pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, mr);
>   
> -    irq = qemu_allocate_irqs(sii3112_set_irq, d, 2);
> +    d->irqs = qemu_allocate_irqs(sii3112_set_irq, d, 2);
>       for (i = 0; i < 2; i++) {
>           ide_bus_new(&s->bus[i], sizeof(s->bus[i]), DEVICE(dev), i, 1);
> -        ide_init2(&s->bus[i], irq[i]);
> +        ide_init2(&s->bus[i], d->irqs[i]);
>   
>           bmdma_init(&s->bus[i], &s->bmdma[i], s);
>           s->bmdma[i].bus = &s->bus[i];
> @@ -291,6 +291,13 @@ static void sii3112_pci_realize(PCIDevice *dev, Error **errp)
>       }
>   }
>   
> +static void sii3112_unrealize(DeviceState *dev, Error **errp)
> +{
> +    SiI3112PCIState *d = SII3112_PCI(dev);
> +
> +    qemu_free_irqs(d->irqs, 2);

You can't do that without calling unrealize() on all the devices in each 
IDEBus. Apparently there is no code available to do that. Maybe easier 
to not add any sii3112_unrealize(). Keeping a reference in the state 
should be enough to silent Coverity.

> +}
> +
>   static void sii3112_pci_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -301,6 +308,7 @@ static void sii3112_pci_class_init(ObjectClass *klass, void *data)
>       pd->class_id = PCI_CLASS_STORAGE_RAID;
>       pd->revision = 1;
>       pd->realize = sii3112_pci_realize;
> +    dc->unrealize = sii3112_unrealize;
>       dc->reset = sii3112_reset;
>       dc->desc = "SiI3112A SATA controller";
>       set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> 


