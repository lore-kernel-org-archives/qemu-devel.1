Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB02C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 22:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 014C12051A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 22:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZJMOEJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014C12051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDEsa-00048P-6R
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 18:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDErm-0003VN-H5
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 18:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDErl-0001tT-DB
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 18:02:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33493
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDErl-0001rP-8N
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 18:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584223364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=imtLouJ9FGnZ/7zqVNpBbrSX4fN4GaBgSl0Ii0AXNqE=;
 b=aZJMOEJ5Z9FrkIZnTgvF9UffpW1kYUHFDmD30S2E9nztA7b5vLNKOH4IQ1zGCHuIza9VAU
 es9B1QxO7SvPI37ZzAwzENgsdwg/9vVg1iK9cyhYERTqip5teZEL+CzwcGZaBTxXAqdRQq
 0xz6YyQqe65WiTO3c/RgKYmSIP5pcNU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-Mxj85ICEOgqdEWlroDGstw-1; Sat, 14 Mar 2020 18:02:41 -0400
X-MC-Unique: Mxj85ICEOgqdEWlroDGstw-1
Received: by mail-wr1-f71.google.com with SMTP id u12so4049202wrw.10
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 15:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=imtLouJ9FGnZ/7zqVNpBbrSX4fN4GaBgSl0Ii0AXNqE=;
 b=LzKHF2aZAuwJIUpTRDLdn2HFEz24jUX3vtnktTxBVo5gGCEaR4K2lYZiVABN/4N+GS
 LZ2vhJNZxnJLn7cickupVhsY9FUb7Q02Q1Y7Kvg0oZtOwkOOcTgZOMLcUG5ichAHFemW
 v8/wlVZJA7XdjdrLVbcoT3GCECAM5+82wGRBlRcIG+zzlegEeF3+HA4ztSDv+X2/Asfe
 AbxtVZNp63kveAxUhrxN2nEjPvD8BT9REg0K1xq7TNFPTaWhx64fIDVFiXNNcoJNmEgY
 IQ+hUUF87jecZOoY81riJp9cGZF85UgLSptiPHIAlhNCEMYE5/FJPJj/oJcB417YoLMW
 HrVg==
X-Gm-Message-State: ANhLgQ2ew3wE+Q5hUM1I0J3XVmElyrSJH9jUpQ3FTISwjMwgADKd0aAg
 Mgrn6VCC4u7xdfslcE8xpmxYR1nlKgoBVpLqfsi3pqWRJr9AD6PGoRrtEOSipcNMhLSz7xRESha
 7BBLby61/uHhEsmA=
X-Received: by 2002:a1c:7d88:: with SMTP id y130mr18907358wmc.5.1584223360211; 
 Sat, 14 Mar 2020 15:02:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt9bnBY3WLV7jtdT4UxxFwwX9R0xl0gfG1sl/kX5dC1DxIGn8eqPxtvh+tLDtKPeFun5s23cQ==
X-Received: by 2002:a1c:7d88:: with SMTP id y130mr18907328wmc.5.1584223359896; 
 Sat, 14 Mar 2020 15:02:39 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id u1sm67348504wrt.78.2020.03.14.15.02.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 15:02:39 -0700 (PDT)
Subject: Re: [PATCH 2/8] hw/ide: Get rid of piix4_init function
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <cover.1584134074.git.balaton@eik.bme.hu>
 <3240656814c804513de08bdbbf318f2f590df241.1584134074.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <15adeb31-4bbc-0c98-4707-4f6b6c13498a@redhat.com>
Date: Sat, 14 Mar 2020 23:02:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3240656814c804513de08bdbbf318f2f590df241.1584134074.git.balaton@eik.bme.hu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, hpoussin@reactos.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 10:14 PM, BALATON Zoltan wrote:
> This removes pci_piix4_ide_init() function similar to clean up done to
> other ide devices.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ide/piix.c    | 12 +-----------
>   hw/isa/piix4.c   |  5 ++++-
>   include/hw/ide.h |  1 -
>   3 files changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
> index 8bcd6b72c2..3b2de4c312 100644
> --- a/hw/ide/piix.c
> +++ b/hw/ide/piix.c
> @@ -208,17 +208,6 @@ static void pci_piix_ide_exitfn(PCIDevice *dev)
>       }
>   }
>   
> -/* hd_table must contain 4 block drivers */
> -/* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
> -PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn)
> -{
> -    PCIDevice *dev;
> -
> -    dev = pci_create_simple(bus, devfn, "piix4-ide");
> -    pci_ide_create_devs(dev, hd_table);
> -    return dev;
> -}
> -
>   /* NOTE: for the PIIX3, the IRQs and IOports are hardcoded */
>   static void piix3_ide_class_init(ObjectClass *klass, void *data)
>   {
> @@ -247,6 +236,7 @@ static const TypeInfo piix3_ide_xen_info = {
>       .class_init    = piix3_ide_class_init,
>   };
>   
> +/* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
>   static void piix4_ide_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index 7edec5e149..0ab4787658 100644
> --- a/hw/isa/piix4.c
> +++ b/hw/isa/piix4.c
> @@ -35,6 +35,7 @@
>   #include "hw/timer/i8254.h"
>   #include "hw/rtc/mc146818rtc.h"
>   #include "hw/ide.h"
> +#include "hw/ide/pci.h"
>   #include "migration/vmstate.h"
>   #include "sysemu/reset.h"
>   #include "sysemu/runstate.h"
> @@ -255,10 +256,12 @@ DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,
>           *isa_bus = ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
>       }
>   
> +    pci = pci_create_simple(pci_bus, pci->devfn + 1, "piix4-ide");

Why are you re-assigning 'pci'?

>       hd = g_new(DriveInfo *, ide_drives);
>       ide_drive_get(hd, ide_drives);
> -    pci_piix4_ide_init(pci_bus, hd, pci->devfn + 1);
> +    pci_ide_create_devs(pci, hd);
>       g_free(hd);
> +
>       pci_create_simple(pci_bus, pci->devfn + 2, "piix4-usb-uhci");
>       if (smbus) {
>           *smbus = piix4_pm_init(pci_bus, pci->devfn + 3, 0x1100,
> diff --git a/include/hw/ide.h b/include/hw/ide.h
> index 883bbaeb9b..21bd8f23f1 100644
> --- a/include/hw/ide.h
> +++ b/include/hw/ide.h
> @@ -12,7 +12,6 @@ ISADevice *isa_ide_init(ISABus *bus, int iobase, int iobase2, int isairq,
>                           DriveInfo *hd0, DriveInfo *hd1);
>   
>   /* ide-pci.c */
> -PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
>   int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux);
>   
>   /* ide-mmio.c */
> 


