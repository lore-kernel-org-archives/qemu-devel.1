Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34663C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1EF82084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5ZuIO+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1EF82084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6arp-0002Tv-1O
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 09:07:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6a2z-0008SO-Se
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:14:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6a2w-0002CP-7W
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:14:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20793
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6a2w-0002CH-1K
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582636485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nWOgPUNM9ydOC7jW+BxD/QLDodYpiHiWwfzfnOjNX9U=;
 b=c5ZuIO+lVXlw2XpCnyROu2oHQBsfXsyqM6X0QUyGf8HK37yYwEMmopXM0mfCyg0iZ7BVDD
 F25OhCH/CK6a+teKCKkkJbHsMVMJndpIAiONMVzWdsYzQgLsFI8ekZGGN3IIyoyUW2162I
 oyEwHf/zJGSguA9fdkj/I13mFb8cdtw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-Popxpqu6NPq6MZdwZmQDuw-1; Tue, 25 Feb 2020 08:14:43 -0500
X-MC-Unique: Popxpqu6NPq6MZdwZmQDuw-1
Received: by mail-qv1-f72.google.com with SMTP id k2so12806597qvu.22
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 05:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=edHHNehR64MnjZYjYoL7hkoPUd5pXkiBWEMDkddZqw0=;
 b=Zavblwzu88Wj6E9NMQuXurnOvaJLsB9b7YEe5PXg+biVVZzB8IZxK7oNr2cukUedFq
 ifk2DWzeuGPmTRnvcMgfrKPWeSTOiLSBc73+dtWXpbsqsGqc3p9ErLnCGoKSit8aS+w2
 dXamXCpL/sP++FKb8pldYqq2aMq+HhRlgPsi9qdTbO1ALD148rlUq+/KsrqrpsfH5e7Q
 BAAWNhYacrABpfFVEK3kCFasv4XNS+NqV6IPHR9yIo8zM3KKtcsaAljX6jlU3T8BtLm+
 dfvg3ETsvPK+0ihgQxVd0OtwqTAhjKErSxbwB+9d0jKbTwijgf5FgfYtlcNDjP8FoJ2y
 7prQ==
X-Gm-Message-State: APjAAAWyp5vplKWGs/8x5ihtehVsAjbxaFqNdj0/DcApaLH3wctfmnBx
 tNRIDC8d5epqy0fi3Yvy6tXIkRQDd8kkZu566y2vdhWzonXtrZXfIqdNIU8O8y5UKOtJqrhv9cK
 VHQglLJ5zflXaZX4=
X-Received: by 2002:a05:620a:14b8:: with SMTP id
 x24mr31393145qkj.210.1582636481694; 
 Tue, 25 Feb 2020 05:14:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqz1W5hNNFlpzw6iMohI1xlrr0poWX5FoB4FRoSTEN6gOGymuuGzeP2UORH6Eok+GAb6GvkGOA==
X-Received: by 2002:a05:620a:14b8:: with SMTP id
 x24mr31393100qkj.210.1582636481335; 
 Tue, 25 Feb 2020 05:14:41 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 u5sm2997895qkf.32.2020.02.25.05.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 05:14:40 -0800 (PST)
Date: Tue, 25 Feb 2020 08:14:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yubo Miao <miaoyubo@huawei.com>
Subject: Re: [PATCH v4 2/3] acpi:pci-expender-bus: Add pxb support for arm
Message-ID: <20200225081151-mutt-send-email-mst@kernel.org>
References: <20200225015026.940-1-miaoyubo@huawei.com>
 <20200225015026.940-3-miaoyubo@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200225015026.940-3-miaoyubo@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, shannon.zhaosl@gmail.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 09:50:25AM +0800, Yubo Miao wrote:
> From: miaoyubo <miaoyubo@huawei.com>
>=20
> Currently virt machine is not supported by pxb-pcie,
> and only one main host bridge described in ACPI tables.
> In this patch,PXB-PCIE is supproted by arm and certain
> resource is allocated for each pxb-pcie in acpi table.
> The resource for the main host bridge is also reallocated.
>=20
> Signed-off-by: miaoyubo <miaoyubo@huawei.com>
> ---
>  hw/arm/virt-acpi-build.c | 115 ++++++++++++++++++++++++++++++++++++---
>  hw/arm/virt.c            |   3 +
>  include/hw/arm/virt.h    |   7 +++
>  3 files changed, 118 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 37c34748a6..be1986c60d 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -49,6 +49,8 @@
>  #include "kvm_arm.h"
>  #include "migration/vmstate.h"
> =20
> +#include "hw/arm/virt.h"
> +#include "hw/pci/pci_bus.h"
>  #define ARM_SPI_BASE 32
> =20
>  static void acpi_dsdt_add_cpus(Aml *scope, int smp_cpus)
> @@ -266,19 +268,116 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, Aml *s=
cope)
>  }
> =20
>  static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
> -                              uint32_t irq, bool use_highmem, bool highm=
em_ecam)
> +                              uint32_t irq, bool use_highmem, bool highm=
em_ecam,
> +                              VirtMachineState *vms)
>  {
>      int ecam_id =3D VIRT_ECAM_ID(highmem_ecam);
> -    Aml *method, *crs;
> +    Aml *method, *crs, *dev;
> +    int count =3D 0;
>      hwaddr base_mmio =3D memmap[VIRT_PCIE_MMIO].base;
>      hwaddr size_mmio =3D memmap[VIRT_PCIE_MMIO].size;
>      hwaddr base_pio =3D memmap[VIRT_PCIE_PIO].base;
>      hwaddr size_pio =3D memmap[VIRT_PCIE_PIO].size;
>      hwaddr base_ecam =3D memmap[ecam_id].base;
>      hwaddr size_ecam =3D memmap[ecam_id].size;
> +    /*
> +     * 0x600000 would be enough for pxb device

It's not clear where does pxb come in here.

> +     * if it is too small, there is no enough space
> +     * for a pcie device plugged in a pcie-root port
> +     */
> +    hwaddr size_addr =3D 0x600000;
> +    hwaddr size_io =3D 0x4000;

Please explain how are memory and io partitioned.
Looks like you are forcing a very specific layout here,
but it's not documented anywhere, which
can cause issues like running out of memory where
we previously were ok.


>      int nr_pcie_buses =3D size_ecam / PCIE_MMCFG_SIZE_MIN;
> +    PCIBus *bus =3D VIRT_MACHINE(vms)->bus;
> +
> +    if (bus) {
> +        QLIST_FOREACH(bus, &bus->child, sibling) {
> +            uint8_t bus_num =3D pci_bus_num(bus);
> +            uint8_t numa_node =3D pci_bus_numa_node(bus);
> +
> +            if (!pci_bus_is_root(bus)) {
> +                continue;
> +            }
> +            /*
> +             * Coded up the MIN of the busNr defined for pxb-pcie,
> +             * the MIN - 1 would be the MAX bus number for the main
> +             * host bridge.
> +             */
> +            if (bus_num < nr_pcie_buses) {
> +                nr_pcie_buses =3D bus_num;
> +            }
> +            count++;
> +            dev =3D aml_device("PC%.02X", bus_num);
> +            aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08"))=
);
> +            aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03"))=
);
> +            aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> +            aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> +            aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
> +            aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
> +            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
> +            aml_append(dev, aml_name_decl("_STR", aml_unicode("pxb Devic=
e")));

how do you know it's a pxb device?

> +            if (numa_node !=3D NUMA_NODE_UNASSIGNED) {
> +                method =3D aml_method("_PXM", 0, AML_NOTSERIALIZED);
> +                aml_append(method, aml_return(aml_int(numa_node)));
> +                aml_append(dev, method);
> +            }
> +
> +            acpi_dsdt_add_pci_route_table(dev, scope, irq);
> +
> +            method =3D aml_method("_CBA", 0, AML_NOTSERIALIZED);
> +            aml_append(method, aml_return(aml_int(base_ecam)));
> +            aml_append(dev, method);
> +
> +            method =3D aml_method("_CRS", 0, AML_NOTSERIALIZED);
> +            Aml *rbuf =3D aml_resource_template();
> +            aml_append(rbuf,
> +                       aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED,
> +                                           AML_POS_DECODE, 0x0000,
> +                                           bus_num, bus_num + 1, 0x0000,
> +                                           2));
> +            aml_append(rbuf,
> +                       aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED,
> +                                        AML_MAX_FIXED, AML_NON_CACHEABLE=
,
> +                                        AML_READ_WRITE, 0x0000,
> +                                        base_mmio + size_mmio -
> +                                        size_addr * count,
> +                                        base_mmio + size_mmio - 1 -
> +                                        size_addr * (count - 1),
> +                                        0x0000, size_addr));
> +            aml_append(rbuf,
> +                       aml_dword_io(AML_MIN_FIXED, AML_MAX_FIXED,
> +                       AML_POS_DECODE, AML_ENTIRE_RANGE,
> +                       0x0000, size_pio - size_io * count,
> +                       size_pio - 1 - size_io * (count - 1),
> +                       base_pio, size_io));
> +
> +            if (use_highmem) {
> +                hwaddr base_mmio_high =3D memmap[VIRT_HIGH_PCIE_MMIO].ba=
se;
> +                hwaddr size_mmio_high =3D memmap[VIRT_HIGH_PCIE_MMIO].si=
ze;
> +
> +                aml_append(rbuf,
> +                       aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED,
> +                                        AML_MAX_FIXED, AML_NON_CACHEABLE=
,
> +                                        AML_READ_WRITE, 0x0000,
> +                                        base_mmio_high + size_mmio_high =
-
> +                                        size_addr * count,
> +                                        base_mmio_high + size_mmio_high =
-
> +                                        1 - size_addr * (count - 1),
> +                                        0x0000, size_addr));
> +            }
> +
> +            aml_append(method, aml_name_decl("RBUF", rbuf));
> +            aml_append(method, aml_return(rbuf));
> +            aml_append(dev, method);
> +
> +            acpi_dsdt_add_pci_osc(dev, scope);
> +
> +            aml_append(scope, dev);
> +
> +        }
> +    }
> =20
> -    Aml *dev =3D aml_device("%s", "PCI0");
> +    dev =3D aml_device("%s", "PCI0");
>      aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
>      aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
>      aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
> @@ -302,11 +401,13 @@ static void acpi_dsdt_add_pci(Aml *scope, const Mem=
MapEntry *memmap,
>      aml_append(rbuf,
>          aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
>                           AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000, base=
_mmio,
> -                         base_mmio + size_mmio - 1, 0x0000, size_mmio));
> +                         base_mmio + size_mmio - 1 - size_addr * count,
> +                         0x0000, size_mmio - size_addr * count));
>      aml_append(rbuf,
>          aml_dword_io(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
> -                     AML_ENTIRE_RANGE, 0x0000, 0x0000, size_pio - 1, bas=
e_pio,
> -                     size_pio));
> +                     AML_ENTIRE_RANGE, 0x0000, 0x0000,
> +                     size_pio - 1 - size_io * count, base_pio,
> +                     size_pio - size_io * count));
> =20
>      if (use_highmem) {
>          hwaddr base_mmio_high =3D memmap[VIRT_HIGH_PCIE_MMIO].base;
> @@ -746,7 +847,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
>      acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
>                      (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANS=
PORTS);
>      acpi_dsdt_add_pci(scope, memmap, (irqmap[VIRT_PCIE] + ARM_SPI_BASE),
> -                      vms->highmem, vms->highmem_ecam);
> +                      vms->highmem, vms->highmem_ecam, vms);
>      if (vms->acpi_dev) {
>          build_ged_aml(scope, "\\_SB."GED_DEVICE,
>                        HOTPLUG_HANDLER(vms->acpi_dev),
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index f788fe27d6..6314928671 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1246,6 +1246,9 @@ static void create_pcie(VirtMachineState *vms)
>      }
> =20
>      pci =3D PCI_HOST_BRIDGE(dev);
> +
> +    VIRT_MACHINE(qdev_get_machine())->bus =3D pci->bus;
> +
>      if (pci->bus) {
>          for (i =3D 0; i < nb_nics; i++) {
>              NICInfo *nd =3D &nd_table[i];
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 71508bf40c..90f10a1e46 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -140,6 +140,13 @@ typedef struct {
>      DeviceState *gic;
>      DeviceState *acpi_dev;
>      Notifier powerdown_notifier;
> +    /*
> +     * pointer to devices and objects
> +     * Via going through the bus, all
> +     * pci devices and related objectes
> +     * could be gained.
> +     */
> +    PCIBus *bus;
>  } VirtMachineState;
> =20
>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
> --=20
> 2.19.1
>=20


