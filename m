Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FAEC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:30:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E10420658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/DMPWjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E10420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aIU-0001dy-Bs
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:30:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6a09-0003aG-IY
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:11:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6a07-0000PW-7j
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:11:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32636
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6a07-0000P8-1k
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582636310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x/nwgvUO+wGnQNdFsFcJ/ce1940qPjy01t/4x0V+MsI=;
 b=a/DMPWjrAnWLChsCHUuil0xgvTnlNXwMsCFrKmmGnSk+K/wbhs+IDh9Z8AW6+CN0C3T0tA
 MKZpg5z6Gt7lQerXjUb/gNkryckFanOK9oWzui82k3UTQIFoqji/onkusOVnIxYDuMwvRy
 7G1GWmOGKESKpeo1GunZf9l5XJJfBmo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-euO2X9J2P4u-0w9v3sxIjg-1; Tue, 25 Feb 2020 08:11:48 -0500
X-MC-Unique: euO2X9J2P4u-0w9v3sxIjg-1
Received: by mail-qt1-f197.google.com with SMTP id l1so14728483qtp.21
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 05:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=+/8iF/yj6smDE9vbQKFIsLKgLxMbT3hm9Hqka45vFaY=;
 b=EndV2rIEKLZSlBWIUuUjorYiwnnMw8EBl/qeGpwAMMbPQxAsR/HyZbI4AUkPM/x4fe
 Bi+xQZnNpdX63buS5l+P3jBld5DlQNgWLZBvdPt6jvLwxsoOFLgUzc3Hw7Jn87PwXQKC
 SKNe7IDIDbExBzP4P0oAQbSkJgdQC1iXYjH6Y8ZiNBqMRR/ztDVTKhbwMmVIbjXaSeYM
 IcaFMcbBKBhdh8cdX8yR0Eh6ybo3s3sSGZb1FeP/RElDPMp1uYKmKu27oqNb97DLex2L
 75CGzRJA9mu7h/qHa0cjghFGjfjEYEq3B4yhuOoNspWt1lF+wQDg6lOi19fL5mCaWrjy
 ShWA==
X-Gm-Message-State: APjAAAX5oTsAP6XkCnRJ+J7g2UDmBfn0LXTqlxcFfTh3nJfByHLZjIgj
 BoG9AG1LL0E3D9KghwnEudRS3ZUSIwVpx/K7dcUn2Qzin8qHgg+/WzmrG2WQHg/4YlmQL2m6NnP
 6FVoE9lRPPZXmBDw=
X-Received: by 2002:a0c:c542:: with SMTP id y2mr48978372qvi.225.1582636306587; 
 Tue, 25 Feb 2020 05:11:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqzgWI6CKDtS28EUa+j0qT4TlCNA55vyNmzDs478UOmhvyo0PVIYZ1ibBF89Z+Q8vVdA+943rQ==
X-Received: by 2002:a0c:c542:: with SMTP id y2mr48978344qvi.225.1582636306303; 
 Tue, 25 Feb 2020 05:11:46 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 v9sm5063989qkv.79.2020.02.25.05.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 05:11:45 -0800 (PST)
Date: Tue, 25 Feb 2020 08:11:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: miaoyubo <miaoyubo@huawei.com>
Subject: Re: [PATCH v4 2/3] acpi:pci-expender-bus: Add pxb support for arm
Message-ID: <20200225080529-mutt-send-email-mst@kernel.org>
References: <20200225015026.940-1-miaoyubo@huawei.com>
 <20200225015026.940-3-miaoyubo@huawei.com>
 <3086f4a2-fb0a-d276-7c76-f06474befa35@redhat.com>
 <c4aa08df40a74dbd876b9acfbbb09809@huawei.com>
 <20200225072522-mutt-send-email-mst@kernel.org>
 <766375327e6f422bbf751174269f7570@huawei.com>
MIME-Version: 1.0
In-Reply-To: <766375327e6f422bbf751174269f7570@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Xiexiangyou <xiexiangyou@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 12:44:15PM +0000, miaoyubo wrote:
>=20
>=20
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Tuesday, February 25, 2020 8:27 PM
> > To: miaoyubo <miaoyubo@huawei.com>
> > Cc: Philippe Mathieu-Daud=E9 <philmd@redhat.com>;
> > peter.maydell@linaro.org; shannon.zhaosl@gmail.com;
> > berrange@redhat.com; qemu-devel@nongnu.org; Xiexiangyou
> > <xiexiangyou@huawei.com>; imammedo@redhat.com
> > Subject: Re: [PATCH v4 2/3] acpi:pci-expender-bus: Add pxb support for =
arm
> >=20
> > On Tue, Feb 25, 2020 at 12:12:12PM +0000, miaoyubo wrote:
> > >
> > > > -----Original Message-----
> > > > From: Philippe Mathieu-Daud=E9 [mailto:philmd@redhat.com]
> > > > Sent: Tuesday, February 25, 2020 5:48 PM
> > > > To: miaoyubo <miaoyubo@huawei.com>; peter.maydell@linaro.org;
> > > > shannon.zhaosl@gmail.com
> > > > Cc: berrange@redhat.com; mst@redhat.com; qemu-devel@nongnu.org;
> > > > Xiexiangyou <xiexiangyou@huawei.com>; imammedo@redhat.com
> > > > Subject: Re: [PATCH v4 2/3] acpi:pci-expender-bus: Add pxb support
> > > > for arm
> > > >
> > > > On 2/25/20 2:50 AM, Yubo Miao wrote:
> > > > > From: miaoyubo <miaoyubo@huawei.com>
> > > > >
> > > > > Currently virt machine is not supported by pxb-pcie, and only one
> > > > > main host bridge described in ACPI tables.
> > > > > In this patch,PXB-PCIE is supproted by arm and certain
> > > >
> > > > Typos: "expander" in subject and "supported" here.
> > > >
> > >
> > > Thanks for your reply and sorry for the mistakes.
> > > I will check all the subjects and comments.
> > >
> > > > > resource is allocated for each pxb-pcie in acpi table.
> > > > > The resource for the main host bridge is also reallocated.
> > > > >
> > > > > Signed-off-by: miaoyubo <miaoyubo@huawei.com>
> > > > > ---
> > > > >   hw/arm/virt-acpi-build.c | 115
> > > > ++++++++++++++++++++++++++++++++++++---
> > > > >   hw/arm/virt.c            |   3 +
> > > > >   include/hw/arm/virt.h    |   7 +++
> > > > >   3 files changed, 118 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > > > index 37c34748a6..be1986c60d 100644
> > > > > --- a/hw/arm/virt-acpi-build.c
> > > > > +++ b/hw/arm/virt-acpi-build.c
> > > > > @@ -49,6 +49,8 @@
> > > > >   #include "kvm_arm.h"
> > > > >   #include "migration/vmstate.h"
> > > > >
> > > > > +#include "hw/arm/virt.h"
> > > > > +#include "hw/pci/pci_bus.h"
> > > > >   #define ARM_SPI_BASE 32
> > > > >
> > > > >       if (use_highmem) {
> > > > >           hwaddr base_mmio_high =3D
> > > > > memmap[VIRT_HIGH_PCIE_MMIO].base;
> > > > @@
> > > > > -746,7 +847,7 @@ build_dsdt(GArray *table_data, BIOSLinker
> > > > > *linker,
> > > > VirtMachineState *vms)
> > > > >       acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
> > > > >                       (irqmap[VIRT_MMIO] + ARM_SPI_BASE),
> > > > NUM_VIRTIO_TRANSPORTS);
> > > > >       acpi_dsdt_add_pci(scope, memmap, (irqmap[VIRT_PCIE] +
> > > > ARM_SPI_BASE),
> > > > > -                      vms->highmem, vms->highmem_ecam);
> > > > > +                      vms->highmem, vms->highmem_ecam, vms);
> > > > >       if (vms->acpi_dev) {
> > > > >           build_ged_aml(scope, "\\_SB."GED_DEVICE,
> > > > >                         HOTPLUG_HANDLER(vms->acpi_dev), diff --gi=
t
> > > > > a/hw/arm/virt.c b/hw/arm/virt.c index f788fe27d6..6314928671
> > > > > 100644
> > > > > --- a/hw/arm/virt.c
> > > > > +++ b/hw/arm/virt.c
> > > > > @@ -1246,6 +1246,9 @@ static void create_pcie(VirtMachineState
> > *vms)
> > > > >       }
> > > > >
> > > > >       pci =3D PCI_HOST_BRIDGE(dev);
> > > > > +
> > > > > +    VIRT_MACHINE(qdev_get_machine())->bus =3D pci->bus;
> > > > > +
> > > > >       if (pci->bus) {
> > > > >           for (i =3D 0; i < nb_nics; i++) {
> > > > >               NICInfo *nd =3D &nd_table[i]; diff --git
> > > > > a/include/hw/arm/virt.h b/include/hw/arm/virt.h index
> > > > > 71508bf40c..90f10a1e46 100644
> > > > > --- a/include/hw/arm/virt.h
> > > > > +++ b/include/hw/arm/virt.h
> > > > > @@ -140,6 +140,13 @@ typedef struct {
> > > > >       DeviceState *gic;
> > > > >       DeviceState *acpi_dev;
> > > > >       Notifier powerdown_notifier;
> > > > > +    /*
> > > > > +     * pointer to devices and objects
> > > > > +     * Via going through the bus, all
> > > > > +     * pci devices and related objectes
> > > >
> > > > Typo "objects", but I don't understand the comment well.
> > > >
> > >
> > > Sorry for any confusion caused ,I will rewrite the comment
> > > /* point to the root bus, which is pcie.0 */ Does this comment make
> > > sense?
> >=20
> > Not really. E.g. it doesn't say what happens if there's more than one r=
oot.
> >=20
>=20
> If there's more than one root, like pcie.0 and pcie.1, it still point to =
pcie.0.
> In docs/pci_expander_bridge.txt, it points out pxb could be placed only
> on bus 0 (pci.0). Therfore, the structure still could help us to find all=
 pxb devices.
> /* point to the bus 0, which is pcie.0
>   * pxb devices could only be placed on bus 0.
>   */
> Is this ok?

All this needs more comments in the code constructing the tables.

Also, instead of trying to store bus and spreading logic
around like this, how about just using object_resolve_path_type?


> > > > > +     * could be gained.
> > > > > +     */
> > > > > +    PCIBus *bus;
> > > > >   } VirtMachineState;
> > > > >
> > > > >   #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM :
> > > > > VIRT_PCIE_ECAM)
> > > > >
> > >
> > > Regards,
> > > Miao
>=20
> Regards,
> Miao


