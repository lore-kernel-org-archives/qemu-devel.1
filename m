Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FC5C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F4E20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxDqBMB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F4E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9gv-0007Ik-0X
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jE9fj-0005q1-GB
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jE9fi-0007Wr-2y
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:42:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37305)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jE9fh-0007Tq-RN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584441724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J3VfCw2nMU177NdLL3DlJokqsLMH32QW/fa+/o1jVBY=;
 b=SxDqBMB96741A+MCkoTc5+b8QqsqXWS/tM48jZEA2AGbCTfsr29Vfq6hl6dA5uKAyTSSPC
 zblzK6vT32H/eRCIRlY2Zf0D7wplWN46kUeQB0EkqsiMfTFeQ9bHuJk2QTaXQppqoOg5JO
 YDDUJEb2M9aENss9H/Y9LZQkLlgIh+I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-emg7NdjQPqG90_JvvqHDHQ-1; Tue, 17 Mar 2020 06:42:02 -0400
X-MC-Unique: emg7NdjQPqG90_JvvqHDHQ-1
Received: by mail-wr1-f71.google.com with SMTP id t4so6186256wrr.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 03:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q0+9Hv7NpyRm3x1g5iWC/bW/ly1Dlp8k+Uoe29FmYVk=;
 b=q51FP9wwr3xDkwJkiFvVpbqOriRrc8goANrz4T6DP2nWd0U02To6jteoeCFyV4Pg0/
 q76A/8BuaFvkHl0gWA9b3WXMHoYs/zG9j3yYmzCD2/vNUzPkKNqgYdYcn9t8HfC1YWXW
 mrsWJGMUY1aNTjbe3xX5sxbgfHaGovH5yEZRf8cY7O6b2+8/L5XgvwCkgRCLHI+4MfKh
 xGr6y9843zaS6n/FKpWX9sUJIlIvOMJ2vmHZpSFXsponyQR+6fmto69mrxqXI9kivlt1
 nXlrnF17dcog06g9kSudHsjanhZzLBTjbA/Er9J/kPZz5CFeciPlIla3idURwXjXeL0y
 Eqgg==
X-Gm-Message-State: ANhLgQ1D+gUElb7lWvA6qk0KhaBu7YvMS6jOppe51EN5MSt85cmGZd+Z
 zUpU6RJDImLU+JoXyG4uqfynpdfWWjSsitae2xNlhb1Og5X6E5FoOeG9d9hHqcsu5kuayAAkzgN
 pBpyJeHXZJwxMIQE=
X-Received: by 2002:adf:bbd3:: with SMTP id z19mr5413091wrg.228.1584441721618; 
 Tue, 17 Mar 2020 03:42:01 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsczd1pu0enKZB313Ghsc1MAw86JxsGRwBQIBb5HW+rTRwQKXhoPF+KRGJ1ZdbNs6qtrY3d8w==
X-Received: by 2002:adf:bbd3:: with SMTP id z19mr5413059wrg.228.1584441721282; 
 Tue, 17 Mar 2020 03:42:01 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id 133sm3522134wmd.5.2020.03.17.03.42.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 03:42:00 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] hw/ide: Get rid of piix4_init function
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <cover.1584437957.git.balaton@eik.bme.hu>
 <3240656814c804513de08bdbbf318f2f590df241.1584437958.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c43e2f9b-3002-32f0-08fa-7164a98f3b9f@redhat.com>
Date: Tue, 17 Mar 2020 11:41:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3240656814c804513de08bdbbf318f2f590df241.1584437958.git.balaton@eik.bme.hu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, hpoussin@reactos.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 10:39 AM, BALATON Zoltan wrote:
> This removes pci_piix4_ide_init() function similar to clean up done to
> other ide devices.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/ide/piix.c    | 12 +-----------
>   hw/isa/piix4.c   |  5 ++++-
>   include/hw/ide.h |  1 -
>   3 files changed, 5 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
> index 8bcd6b72c2..3b2de4c312 100644
> --- a/hw/ide/piix.c
> +++ b/hw/ide/piix.c
> @@ -208,17 +208,6 @@ static void pci_piix_ide_exitfn(PCIDevice *dev)
>       }
>   }
>  =20
> -/* hd_table must contain 4 block drivers */
> -/* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
> -PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int dev=
fn)
> -{
> -    PCIDevice *dev;
> -
> -    dev =3D pci_create_simple(bus, devfn, "piix4-ide");
> -    pci_ide_create_devs(dev, hd_table);
> -    return dev;
> -}
> -
>   /* NOTE: for the PIIX3, the IRQs and IOports are hardcoded */
>   static void piix3_ide_class_init(ObjectClass *klass, void *data)
>   {
> @@ -247,6 +236,7 @@ static const TypeInfo piix3_ide_xen_info =3D {
>       .class_init    =3D piix3_ide_class_init,
>   };
>  =20
> +/* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
>   static void piix4_ide_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
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
> @@ -255,10 +256,12 @@ DeviceState *piix4_create(PCIBus *pci_bus, ISABus *=
*isa_bus,
>           *isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
>       }
>  =20
> +    pci =3D pci_create_simple(pci_bus, pci->devfn + 1, "piix4-ide");
>       hd =3D g_new(DriveInfo *, ide_drives);
>       ide_drive_get(hd, ide_drives);
> -    pci_piix4_ide_init(pci_bus, hd, pci->devfn + 1);
> +    pci_ide_create_devs(pci, hd);
>       g_free(hd);
> +
>       pci_create_simple(pci_bus, pci->devfn + 2, "piix4-usb-uhci");
>       if (smbus) {
>           *smbus =3D piix4_pm_init(pci_bus, pci->devfn + 3, 0x1100,
> diff --git a/include/hw/ide.h b/include/hw/ide.h
> index 883bbaeb9b..21bd8f23f1 100644
> --- a/include/hw/ide.h
> +++ b/include/hw/ide.h
> @@ -12,7 +12,6 @@ ISADevice *isa_ide_init(ISABus *bus, int iobase, int io=
base2, int isairq,
>                           DriveInfo *hd0, DriveInfo *hd1);
>  =20
>   /* ide-pci.c */
> -PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int dev=
fn);
>   int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux);
>  =20
>   /* ide-mmio.c */
>=20


