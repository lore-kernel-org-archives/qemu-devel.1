Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59041C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 242832053B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdtYHvrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242832053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igqB3-0002qh-5t
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 08:12:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1igqAD-0001w1-Fs
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1igqAC-00072y-As
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:11:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24114
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1igqAC-00072A-7O
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576501911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ib4GLxFZXzsZYq5vhvW4dRSucJEdW9kOkRYUP32unpw=;
 b=FdtYHvrwhMu9JmqZF2vpRHUos74O/W8jlhlZOYmT3X7xMKD3/XW809VIGhiwXOfWv4mdrh
 1lWdCd3YOVJ0A7iWbS0DCnqy3jhxeBiL3U37X1G5py2Ym7mvCjVlW1J+UM7laZxONO54iR
 mUW3GZnoqJEETWeIlkowDCfaYaADeA0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-If9jdl9zPNGPeYUyjpqwCQ-1; Mon, 16 Dec 2019 08:11:48 -0500
Received: by mail-wm1-f71.google.com with SMTP id z2so1004981wmf.5
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 05:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=75YfmPUd8IxShkS7a0b2Ig4I+aTSu5nF6jxguOhk6cM=;
 b=SlMKBlCdL1WspkjUaZyvz5agXw7dU6xDhW8JDU8I/gSRG0HlVClOQHFzhMkmEiRbSH
 b9XkoNL7J1m3QruyyA8ozZaTe1/XcAx97pa3rMDDTTiXpJnBVzc0A0DiH3JFxIx/+g5G
 98Jyon25vkqqhZxIY7V0qmUVaV3DvVkqLoUMiZMhzQp7YYzZof8jLsvpg+c0uNZZ7ykL
 yZ2KLASobJDZGbArhOSSp/f6O8/TyH14z7uTR07EpY73mFLmj2in6AJba16C3pioXdj3
 7zi2jS14MOctmfOiFkdOf9zJn6NslYx849t/4mTdeDmwkZeATv7RTDnX8in/9G8leOsN
 F21A==
X-Gm-Message-State: APjAAAUuyLvvjYKy1rVp2ggWZJny9M6ceQMXUgRHK91Epk0Wx20Jx2CC
 ic2e/ShxxmCxdWIiuxUx40Zvun+n//vgcefdsld+xkDnrdxjciaLo9k5KfHsrLeueew6cNBj+1Y
 aoizZ55qMJjY2g9I=
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr29258090wrw.327.1576501907532; 
 Mon, 16 Dec 2019 05:11:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqwuIcoQzrLz1xC87UatN3jXBE3T8LoVif4M67IAzWtqOxR+SyLrgYTkIoP4IoF7SSSnGn/e5g==
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr29258050wrw.327.1576501907281; 
 Mon, 16 Dec 2019 05:11:47 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:cde8:2463:95a9:1d81?
 ([2001:b07:6468:f312:cde8:2463:95a9:1d81])
 by smtp.gmail.com with ESMTPSA id t190sm12609330wmt.44.2019.12.16.05.11.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 05:11:46 -0800 (PST)
Subject: Re: [PATCH 08/12] hw/ide/piix: Use ARRAY_SIZE() instead of magic
 numbers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191213161753.8051-1-philmd@redhat.com>
 <20191213161753.8051-9-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3e4ef8f0-4ccf-65c8-35ec-95bc6cf4e3d0@redhat.com>
Date: Mon, 16 Dec 2019 14:11:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191213161753.8051-9-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: If9jdl9zPNGPeYUyjpqwCQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/12/19 17:17, Philippe Mathieu-Daud=C3=A9 wrote:
> Using magic numbers is dangerous because the structures PCIIDEState
> might be modified and this source file consuming the "ide/pci.h"
> header would be out of sync, eventually accessing out of bound
> array members.
> Use the ARRAY_SIZE() to keep the source file sync.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/ide/piix.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
> index ffeff4e095..ab23613a44 100644
> --- a/hw/ide/piix.c
> +++ b/hw/ide/piix.c
> @@ -87,10 +87,9 @@ static const MemoryRegionOps piix_bmdma_ops =3D {
> =20
>  static void bmdma_setup_bar(PCIIDEState *d)
>  {
> -    int i;
> -
>      memory_region_init(&d->bmdma_bar, OBJECT(d), "piix-bmdma-container",=
 16);
> -    for(i =3D 0;i < 2; i++) {
> +
> +    for (size_t i =3D 0; i < ARRAY_SIZE(d->bmdma); i++) {
>          BMDMAState *bm =3D &d->bmdma[i];
> =20
>          memory_region_init_io(&bm->extra_io, OBJECT(d), &piix_bmdma_ops,=
 bm,
> @@ -107,9 +106,8 @@ static void piix_ide_reset(DeviceState *dev)
>      PCIIDEState *d =3D PCI_IDE(dev);
>      PCIDevice *pd =3D PCI_DEVICE(d);
>      uint8_t *pci_conf =3D pd->config;
> -    int i;
> =20
> -    for (i =3D 0; i < 2; i++) {
> +    for (size_t i =3D 0; i < ARRAY_SIZE(d->bus); i++) {
>          ide_bus_reset(&d->bus[i]);
>      }
> =20
> @@ -132,10 +130,10 @@ static void pci_piix_init_ports(PCIIDEState *d) {
>          {0x1f0, 0x3f6, 14},
>          {0x170, 0x376, 15},
>      };
> -    int i;
> =20
> -    for (i =3D 0; i < 2; i++) {
> -        ide_bus_new(&d->bus[i], sizeof(d->bus[i]), DEVICE(d), i, 2);
> +    for (size_t i =3D 0; i < ARRAY_SIZE(d->bus); i++) {
> +        ide_bus_new(&d->bus[i], sizeof(d->bus[i]), DEVICE(d), i,
> +                    ARRAY_SIZE(d->bus[0].ifs));
>          ide_init_ioport(&d->bus[i], NULL, port_info[i].iobase,
>                          port_info[i].iobase2);
>          ide_init2(&d->bus[i], isa_get_irq(NULL, port_info[i].isairq));
> @@ -163,14 +161,13 @@ static void pci_piix_ide_realize(PCIDevice *dev, Er=
ror **errp)
> =20
>  int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux)
>  {
> -    PCIIDEState *pci_ide;
> +    PCIIDEState *pci_ide =3D PCI_IDE(dev);
>      DriveInfo *di;
> -    int i;
>      IDEDevice *idedev;
> +    const size_t idedev_max =3D ARRAY_SIZE(pci_ide->bus)
> +                            * ARRAY_SIZE(pci_ide->bus[0].ifs);
> =20
> -    pci_ide =3D PCI_IDE(dev);
> -
> -    for (i =3D aux ? 1 : 0; i < 4; i++) {
> +    for (size_t i =3D aux ? 1 : 0; i < idedev_max; i++) {
>          di =3D drive_get_by_index(IF_IDE, i);
>          if (di !=3D NULL && !di->media_cd) {
>              BlockBackend *blk =3D blk_by_legacy_dinfo(di);
> @@ -210,9 +207,8 @@ PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveI=
nfo **hd_table, int devfn)
>  static void pci_piix_ide_exitfn(PCIDevice *dev)
>  {
>      PCIIDEState *d =3D PCI_IDE(dev);
> -    unsigned i;
> =20
> -    for (i =3D 0; i < 2; ++i) {
> +    for (size_t i =3D 0; i < ARRAY_SIZE(d->bmdma); ++i) {
>          memory_region_del_subregion(&d->bmdma_bar, &d->bmdma[i].extra_io=
);
>          memory_region_del_subregion(&d->bmdma_bar, &d->bmdma[i].addr_iop=
ort);
>      }
>=20

Queued, thanks.

Paolo


