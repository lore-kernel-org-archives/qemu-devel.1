Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8AAC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87C752064A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gijwGd+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C752064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aOH-0005oy-Ox
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6ZIv-00065b-O9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:27:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6ZIt-0007Hn-Tb
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:27:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58567
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6ZIt-0007HP-9W
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582633630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZcTbypC42dQ6dlK/Lg2CQXYk/It2bCFrPSb5/e07vM8=;
 b=gijwGd+JUAf2vI2yfl25RERusyTt++TPpkNXALY/FSqJg5tUziufu43GbFwmECsut6WREh
 EMgRPOV9uDzQnYucoVIQBS6jzBiBPymrK4uwPYZdHIVIY1KGW19t2bh4f7SB4BGVnekfcw
 6tueqSzt4MfqMpQd2CrJyAHwDodfWf8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-6QgYLmWYNNuJtUdrsnd3CQ-1; Tue, 25 Feb 2020 07:27:09 -0500
X-MC-Unique: 6QgYLmWYNNuJtUdrsnd3CQ-1
Received: by mail-qk1-f198.google.com with SMTP id a10so9727736qkg.11
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:27:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=RwtvVoDDgmHjM+kCA/LjhUipmzBC2JpRU7IUD/wuCyY=;
 b=cVMdSVs4uvg8RkN1jKjagRYJn1t5BM+mbICwgD2u0/mdAJyFe1BamQ0zTkL2IMR5dQ
 Ga08pALoqkctvy/dqlUJwGYTCnTmPfJQrF70j20e1lw1oUEe7XPzl0WVpbvoNHaY6i2l
 Frc51YieF0JcqgtYRjq+VLRxJyKwgSXMkw+APAAI7WPWEztmUZTQY5tat3XpiO58wwCv
 Z0CfTFO/lq1vHjC10+aBKl6KxqT83Js/HJ+mHpjzqPgQuKY7dC6VvHjeVXRIydqoD+Lu
 wvTtf3I5fEmNTNyCHfAgq+6rJ6N2OUC77UodXehFkhJkU0omFSBzjZTdXphZvC0HYJw1
 UzXg==
X-Gm-Message-State: APjAAAWTTedJzOK/F+XjewiNn6YCnJuXmOlNDFJZ/Z3fSKFKf9c1Eezy
 bPjsuhweYi8nPYF7+lX0Xx17s+2MUIxaEYKiIlCA/Z37NdQb2y85ipXocEBU6J65q+D3R39Zk0F
 szbwSvpnp/0X2coU=
X-Received: by 2002:a05:620a:12a5:: with SMTP id
 x5mr56194392qki.478.1582633627060; 
 Tue, 25 Feb 2020 04:27:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqw8Cmk7QiY5t1qEin3kff6670s5kqA82XnUIddNzGx3F8TjFvSKqtwWb3Yo1wfXQ43MCht96A==
X-Received: by 2002:a05:620a:12a5:: with SMTP id
 x5mr56194371qki.478.1582633626813; 
 Tue, 25 Feb 2020 04:27:06 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 p126sm7321512qkd.108.2020.02.25.04.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 04:27:06 -0800 (PST)
Date: Tue, 25 Feb 2020 07:27:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: miaoyubo <miaoyubo@huawei.com>
Subject: Re: [PATCH v4 2/3] acpi:pci-expender-bus: Add pxb support for arm
Message-ID: <20200225072522-mutt-send-email-mst@kernel.org>
References: <20200225015026.940-1-miaoyubo@huawei.com>
 <20200225015026.940-3-miaoyubo@huawei.com>
 <3086f4a2-fb0a-d276-7c76-f06474befa35@redhat.com>
 <c4aa08df40a74dbd876b9acfbbb09809@huawei.com>
MIME-Version: 1.0
In-Reply-To: <c4aa08df40a74dbd876b9acfbbb09809@huawei.com>
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

On Tue, Feb 25, 2020 at 12:12:12PM +0000, miaoyubo wrote:
>=20
> > -----Original Message-----
> > From: Philippe Mathieu-Daud=E9 [mailto:philmd@redhat.com]
> > Sent: Tuesday, February 25, 2020 5:48 PM
> > To: miaoyubo <miaoyubo@huawei.com>; peter.maydell@linaro.org;
> > shannon.zhaosl@gmail.com
> > Cc: berrange@redhat.com; mst@redhat.com; qemu-devel@nongnu.org;
> > Xiexiangyou <xiexiangyou@huawei.com>; imammedo@redhat.com
> > Subject: Re: [PATCH v4 2/3] acpi:pci-expender-bus: Add pxb support for =
arm
> >=20
> > On 2/25/20 2:50 AM, Yubo Miao wrote:
> > > From: miaoyubo <miaoyubo@huawei.com>
> > >
> > > Currently virt machine is not supported by pxb-pcie, and only one mai=
n
> > > host bridge described in ACPI tables.
> > > In this patch,PXB-PCIE is supproted by arm and certain
> >=20
> > Typos: "expander" in subject and "supported" here.
> >=20
>=20
> Thanks for your reply and sorry for the mistakes.
> I will check all the subjects and comments.
>=20
> > > resource is allocated for each pxb-pcie in acpi table.
> > > The resource for the main host bridge is also reallocated.
> > >
> > > Signed-off-by: miaoyubo <miaoyubo@huawei.com>
> > > ---
> > >   hw/arm/virt-acpi-build.c | 115
> > ++++++++++++++++++++++++++++++++++++---
> > >   hw/arm/virt.c            |   3 +
> > >   include/hw/arm/virt.h    |   7 +++
> > >   3 files changed, 118 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c inde=
x
> > > 37c34748a6..be1986c60d 100644
> > > --- a/hw/arm/virt-acpi-build.c
> > > +++ b/hw/arm/virt-acpi-build.c
> > > @@ -49,6 +49,8 @@
> > >   #include "kvm_arm.h"
> > >   #include "migration/vmstate.h"
> > >
> > > +#include "hw/arm/virt.h"
> > > +#include "hw/pci/pci_bus.h"
> > >   #define ARM_SPI_BASE 32
> > >
> > >       if (use_highmem) {
> > >           hwaddr base_mmio_high =3D memmap[VIRT_HIGH_PCIE_MMIO].base;
> > @@
> > > -746,7 +847,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> > VirtMachineState *vms)
> > >       acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
> > >                       (irqmap[VIRT_MMIO] + ARM_SPI_BASE),
> > NUM_VIRTIO_TRANSPORTS);
> > >       acpi_dsdt_add_pci(scope, memmap, (irqmap[VIRT_PCIE] +
> > ARM_SPI_BASE),
> > > -                      vms->highmem, vms->highmem_ecam);
> > > +                      vms->highmem, vms->highmem_ecam, vms);
> > >       if (vms->acpi_dev) {
> > >           build_ged_aml(scope, "\\_SB."GED_DEVICE,
> > >                         HOTPLUG_HANDLER(vms->acpi_dev), diff --git
> > > a/hw/arm/virt.c b/hw/arm/virt.c index f788fe27d6..6314928671 100644
> > > --- a/hw/arm/virt.c
> > > +++ b/hw/arm/virt.c
> > > @@ -1246,6 +1246,9 @@ static void create_pcie(VirtMachineState *vms)
> > >       }
> > >
> > >       pci =3D PCI_HOST_BRIDGE(dev);
> > > +
> > > +    VIRT_MACHINE(qdev_get_machine())->bus =3D pci->bus;
> > > +
> > >       if (pci->bus) {
> > >           for (i =3D 0; i < nb_nics; i++) {
> > >               NICInfo *nd =3D &nd_table[i]; diff --git
> > > a/include/hw/arm/virt.h b/include/hw/arm/virt.h index
> > > 71508bf40c..90f10a1e46 100644
> > > --- a/include/hw/arm/virt.h
> > > +++ b/include/hw/arm/virt.h
> > > @@ -140,6 +140,13 @@ typedef struct {
> > >       DeviceState *gic;
> > >       DeviceState *acpi_dev;
> > >       Notifier powerdown_notifier;
> > > +    /*
> > > +     * pointer to devices and objects
> > > +     * Via going through the bus, all
> > > +     * pci devices and related objectes
> >=20
> > Typo "objects", but I don't understand the comment well.
> >=20
>=20
> Sorry for any confusion caused ,I will rewrite the comment=20
> /* point to the root bus, which is pcie.0 */
> Does this comment make sense?

Not really. E.g. it doesn't say what happens if there's more than one root.

> > > +     * could be gained.
> > > +     */
> > > +    PCIBus *bus;
> > >   } VirtMachineState;
> > >
> > >   #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM :
> > > VIRT_PCIE_ECAM)
> > >
>=20
> Regards,
> Miao


