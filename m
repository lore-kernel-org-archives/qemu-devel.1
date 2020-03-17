Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FBEC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30E220663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2xbD2lB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30E220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEENg-0007Mw-03
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEE42-0004kG-NN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEE41-0000fA-G7
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:23:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27217)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEE41-0000bq-9Y
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584458605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VAd7TGQuwmnGh0gRhtsgfxgXkdeiRCQDX/ppoRr5I3k=;
 b=S2xbD2lBqLsA2loGgV7i2qQwFmvZFEX8nYYs4jwIdXM++fpSlNKf94scEUnpB4NJJfOASf
 b0m+6WlerHPcilZLl/D1QBJf/wRJ7d+fePpM8BNndYlKGkDTTXkv4RqMbmigIwa5hoH+Ty
 u6GOQTUvFiopPNQi/jHoXBAqXbuMBV0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-svYzEs0hNoKhTPkpDy1zQA-1; Tue, 17 Mar 2020 11:23:22 -0400
X-MC-Unique: svYzEs0hNoKhTPkpDy1zQA-1
Received: by mail-wm1-f69.google.com with SMTP id r23so7301559wmn.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 08:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9V0MuUsVFzNiBW4fwUsGHbWAkRWSoWXMiHtd49rqK5U=;
 b=XiAl9pq9OAv7s8jelnPdHKrKPhbP21FOJRoaBenQJtjWl4cbqMHxqZtrfrQ2b4byp2
 zR8I7Lv5C77Zbt9f2NKYs1/1VzvGolKAU80F3ssFizZ79Ir0oWkXtDJ1DKDMfkLp/+ot
 424+JCMftXLn81MH/q+5DFg9S/oG9y2Giywm7RdS4Wz4Kq1g3USItAxIEr32kdfJeLdR
 TSzO3/EX3EpvzlJBQy7Cv+VIakefaQHV+gOcnhc0rHGGsQxQGhvBIIJ5vu8UaW4vrqpb
 w1+PNDcUvoMUDSP/GSmXznsYZyCO8Qk4S2QIFXKJ31eTeQypEgV4+2Pei0wMgvyEmtRm
 /1Eg==
X-Gm-Message-State: ANhLgQ0MrsnRusmbTLfNAGt+AdMuhwsyrDIlsb/F7DtOLr8brCi6sQ/O
 jjlhc9qBsbDsI1wpApZowRhEMACvF8ltNlflg7qFPOx/akQxvHZCsBq2ESIg9mrGuITkOkPakbG
 VabQU9PelWpSQq+k=
X-Received: by 2002:a5d:6344:: with SMTP id b4mr6534071wrw.354.1584458599813; 
 Tue, 17 Mar 2020 08:23:19 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu47ytdIQpk6V0d8FcAZBREsB3SgTZQ8o2LoD4LAvHhSTEzI23NmTO9nKDDfRPSU5d53J6clQ==
X-Received: by 2002:a5d:6344:: with SMTP id b4mr6534055wrw.354.1584458599599; 
 Tue, 17 Mar 2020 08:23:19 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id b203sm4397022wmc.45.2020.03.17.08.23.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 08:23:18 -0700 (PDT)
Subject: Re: [PATCH v3 2/8] hw/isa/piix4.c: Introduce variable to store devfn
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <cover.1584457537.git.balaton@eik.bme.hu>
 <1020e0bfcfc6e364f967ccb2a9a3778ac174ccbe.1584457537.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ad5acdc7-25e6-9a65-3b1d-681edf3aa2f2@redhat.com>
Date: Tue, 17 Mar 2020 16:23:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1020e0bfcfc6e364f967ccb2a9a3778ac174ccbe.1584457537.git.balaton@eik.bme.hu>
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

On 3/17/20 4:05 PM, BALATON Zoltan wrote:
> To avoid any problem with reassigning pci variable store devfn in a
> variable instead of acessing it from the PCIDevice.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/isa/piix4.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index 7edec5e149..2cbdcd7700 100644
> --- a/hw/isa/piix4.c
> +++ b/hw/isa/piix4.c
> @@ -247,9 +247,10 @@ DeviceState *piix4_create(PCIBus *pci_bus, ISABus **=
isa_bus,
>       DriveInfo **hd;
>       PCIDevice *pci;
>       DeviceState *dev;
> +    int devfn =3D PCI_DEVFN(10, 0);
>  =20
> -    pci =3D pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0),
> -                                          true, TYPE_PIIX4_PCI_DEVICE);
> +    pci =3D pci_create_simple_multifunction(pci_bus, devfn,  true,
> +                                          TYPE_PIIX4_PCI_DEVICE);
>       dev =3D DEVICE(pci);
>       if (isa_bus) {
>           *isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
> @@ -257,11 +258,12 @@ DeviceState *piix4_create(PCIBus *pci_bus, ISABus *=
*isa_bus,
>  =20
>       hd =3D g_new(DriveInfo *, ide_drives);
>       ide_drive_get(hd, ide_drives);
> -    pci_piix4_ide_init(pci_bus, hd, pci->devfn + 1);
> +    pci_piix4_ide_init(pci_bus, hd, devfn + 1);
>       g_free(hd);
> -    pci_create_simple(pci_bus, pci->devfn + 2, "piix4-usb-uhci");
> +
> +    pci_create_simple(pci_bus, devfn + 2, "piix4-usb-uhci");
>       if (smbus) {
> -        *smbus =3D piix4_pm_init(pci_bus, pci->devfn + 3, 0x1100,
> +        *smbus =3D piix4_pm_init(pci_bus, devfn + 3, 0x1100,
>                                  isa_get_irq(NULL, 9), NULL, 0, NULL);
>      }
>  =20
>=20

This looks better, thanks (and sorry for not being more verbose earlier)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Now this looks


