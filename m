Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E71C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E22206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikLy4OSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E22206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3g9u-0002zG-UG
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 08:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j3g9A-0002YH-Q0
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j3g97-0007Mf-Vp
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:09:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27780
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j3g97-0007GO-Nb
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581944948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UdLbLKe0wn7wCMPnpg65stI5v6Nz4se/eh6pLqul+EQ=;
 b=ikLy4OSalKLX+6D6pmRYiZJLmnSkw4bjj/sET4l+v9Me2CC2UOzyCkuVc81IMVJlZn60FQ
 V8KWCpCQ68qb6hVhALJghudyeV3AKcRc1BhOhqBQErvavHMWP/2y/6pvb0RT8NvtIsA9iH
 WuNUqeIQG/4MhN0tKzLfMQRDiRV1zqo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-aI74K1mYOX6CUVpVu5UR_w-1; Mon, 17 Feb 2020 08:09:04 -0500
Received: by mail-qt1-f199.google.com with SMTP id l25so10928963qtu.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 05:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JehAu49z3Hu64Ypp7CuFNoTFSbty1kX8Ky5uATkrqxA=;
 b=I47Zl3ddWOFvBczJwaOAdTJG1XK2KkxklCCGr5mqYsn8sCuFk4Nw4Cwyr5LxlDJWQR
 rukgk1pD+bMp/EslBovRzabmCjJEErOYZDlcx52HlfBG8maNr9+9plLZm/EP9CkyCL4V
 85qxTaQevUn+qnrgYjRk9+6JaPKbq+qwD+g4FWVG6EOD1AA01f+h6FxMrEW4HtuCLFx/
 5F2f2EnMVs/FtjN/0gPw3WLFF/Wi/xYkdUDwgCfhpUILNNsAsSBYbBZVQLDNbPgl7STt
 S2pIWNwmystQY0/dc2/XdL9RRE9xi/ewaPBjO/CSaKQgZCD6hHVs5bdOoTz6RzxMn4Pp
 OoGw==
X-Gm-Message-State: APjAAAX5ZmALjeXTjZFX+VbH+fUVFHJxfpcTCgQkyKvk03fDL9V2W3eQ
 3HKbf2OIOElVC1IyIAF5eCMZhjv2XkL+n/rZw6oMhaMzEYRluUkhOPSaHE3+cFp2qwOUJ1kw//8
 sbVEPaJl0zxYs060=
X-Received: by 2002:a37:ef13:: with SMTP id j19mr14106542qkk.188.1581944943302; 
 Mon, 17 Feb 2020 05:09:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzijrslH74UG86VQbHia7CswE8jrVj2l7A0jFqyORz8rzVEvYFdurm6Ih4uNjSCu6VtD7QGVQ==
X-Received: by 2002:a37:ef13:: with SMTP id j19mr14106505qkk.188.1581944942911; 
 Mon, 17 Feb 2020 05:09:02 -0800 (PST)
Received: from redhat.com (bzq-79-176-28-95.red.bezeqint.net. [79.176.28.95])
 by smtp.gmail.com with ESMTPSA id
 q5sm193427qkf.14.2020.02.17.05.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 05:09:01 -0800 (PST)
Date: Mon, 17 Feb 2020 08:08:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yubo Miao <miaoyubo@huawei.com>
Subject: Re: [RFC v2 1/1] arm: acpi: pci-expender-bus: Make arm to support
 PXB-PCIE
Message-ID: <20200217080640-mutt-send-email-mst@kernel.org>
References: <20200217111818.766-1-miaoyubo@huawei.com>
 <20200217111818.766-2-miaoyubo@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200217111818.766-2-miaoyubo@huawei.com>
X-MC-Unique: aI74K1mYOX6CUVpVu5UR_w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, imammedo@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, shannon.zhaosl@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 17, 2020 at 07:18:18PM +0800, Yubo Miao wrote:
> From: miaoyubo <miaoyubo@huawei.com>
>=20
> Currently virt machine is not supported by pxb-pcie,
> and only one main host bridge described in ACPI tables.
> Under this circumstance, different io numas for differnt devices
> is not possible, in order to present io numas to the guest,
> especially for host pssthrough devices. PXB-PCIE is supproted
> by arm and certain resource is allocated for each pxb-pcie
> in acpi table.
>=20
> Signed-off-by: miaoyubo <miaoyubo@huawei.com>

A unit test would be nic.

> ---
>  hw/arm/virt-acpi-build.c | 240 +++++++++++++++++++++++++++++----------
>  hw/pci-host/gpex.c       |   4 +
>  include/hw/arm/virt.h    |   1 +
>  3 files changed, 184 insertions(+), 61 deletions(-)
>=20
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index bd5f771e9b..fc11525042 100644
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
> @@ -151,30 +153,12 @@ static void acpi_dsdt_add_virtio(Aml *scope,
>      }
>  }
> =20
> -static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
> -                              uint32_t irq, bool use_highmem, bool highm=
em_ecam)
> +static void acpi_dsdt_add_pci_route_table(Aml *dev, Aml *scope,
> +                                          int nr_pcie_buses,
> +                                          uint32_t irq)
>  {
> -    int ecam_id =3D VIRT_ECAM_ID(highmem_ecam);
> -    Aml *method, *crs, *ifctx, *UUID, *ifctx1, *elsectx, *buf;
>      int i, bus_no;
> -    hwaddr base_mmio =3D memmap[VIRT_PCIE_MMIO].base;
> -    hwaddr size_mmio =3D memmap[VIRT_PCIE_MMIO].size;
> -    hwaddr base_pio =3D memmap[VIRT_PCIE_PIO].base;
> -    hwaddr size_pio =3D memmap[VIRT_PCIE_PIO].size;
> -    hwaddr base_ecam =3D memmap[ecam_id].base;
> -    hwaddr size_ecam =3D memmap[ecam_id].size;
> -    int nr_pcie_buses =3D size_ecam / PCIE_MMCFG_SIZE_MIN;
> -
> -    Aml *dev =3D aml_device("%s", "PCI0");
> -    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
> -    aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
> -    aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
> -    aml_append(dev, aml_name_decl("_BBN", aml_int(0)));
> -    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> -    aml_append(dev, aml_name_decl("_UID", aml_string("PCI0")));
> -    aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Device")))=
;
> -    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> -
> +    Aml *method, *crs;
>      /* Declare the PCI Routing Table. */
>      Aml *rt_pkg =3D aml_varpackage(nr_pcie_buses * PCI_NUM_PINS);
>      for (bus_no =3D 0; bus_no < nr_pcie_buses; bus_no++) {
> @@ -190,7 +174,6 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMa=
pEntry *memmap,
>      }
>      aml_append(dev, aml_name_decl("_PRT", rt_pkg));
> =20
> -    /* Create GSI link device */
>      for (i =3D 0; i < PCI_NUM_PINS; i++) {
>          uint32_t irqs =3D  irq + i;
>          Aml *dev_gsi =3D aml_device("GSI%d", i);
> @@ -210,42 +193,11 @@ static void acpi_dsdt_add_pci(Aml *scope, const Mem=
MapEntry *memmap,
>          aml_append(dev_gsi, method);
>          aml_append(dev, dev_gsi);
>      }
> +}
> =20
> -    method =3D aml_method("_CBA", 0, AML_NOTSERIALIZED);
> -    aml_append(method, aml_return(aml_int(base_ecam)));
> -    aml_append(dev, method);
> -
> -    method =3D aml_method("_CRS", 0, AML_NOTSERIALIZED);
> -    Aml *rbuf =3D aml_resource_template();
> -    aml_append(rbuf,
> -        aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE=
,
> -                            0x0000, 0x0000, nr_pcie_buses - 1, 0x0000,
> -                            nr_pcie_buses));
> -    aml_append(rbuf,
> -        aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
> -                         AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000, base=
_mmio,
> -                         base_mmio + size_mmio - 1, 0x0000, size_mmio));
> -    aml_append(rbuf,
> -        aml_dword_io(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
> -                     AML_ENTIRE_RANGE, 0x0000, 0x0000, size_pio - 1, bas=
e_pio,
> -                     size_pio));
> -
> -    if (use_highmem) {
> -        hwaddr base_mmio_high =3D memmap[VIRT_HIGH_PCIE_MMIO].base;
> -        hwaddr size_mmio_high =3D memmap[VIRT_HIGH_PCIE_MMIO].size;
> -
> -        aml_append(rbuf,
> -            aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXE=
D,
> -                             AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
> -                             base_mmio_high,
> -                             base_mmio_high + size_mmio_high - 1, 0x0000=
,
> -                             size_mmio_high));
> -    }
> -
> -    aml_append(method, aml_name_decl("RBUF", rbuf));
> -    aml_append(method, aml_return(rbuf));
> -    aml_append(dev, method);
> -
> +static void acpi_dsdt_add_pci_osc(Aml *dev, Aml *scope)
> +{
> +    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
>      /* Declare an _OSC (OS Control Handoff) method */
>      aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
>      aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
> @@ -253,7 +205,8 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMa=
pEntry *memmap,
>      aml_append(method,
>          aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> =20
> -    /* PCI Firmware Specification 3.0
> +    /*
> +     * PCI Firmware Specification 3.0
>       * 4.5.1. _OSC Interface for PCI Host Bridge Devices
>       * The _OSC interface for a PCI/PCI-X/PCI Express hierarchy is
>       * identified by the Universal Unique IDentifier (UUID)
> @@ -298,7 +251,8 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMa=
pEntry *memmap,
> =20
>      method =3D aml_method("_DSM", 4, AML_NOTSERIALIZED);
> =20
> -    /* PCI Firmware Specification 3.0
> +    /*
> +     * PCI Firmware Specification 3.0
>       * 4.6.1. _DSM for PCI Express Slot Information
>       * The UUID in _DSM in this context is
>       * {E5C937D0-3553-4D7A-9117-EA4D19C3434D}
> @@ -316,6 +270,170 @@ static void acpi_dsdt_add_pci(Aml *scope, const Mem=
MapEntry *memmap,
>      buf =3D aml_buffer(1, byte_list);
>      aml_append(method, aml_return(buf));
>      aml_append(dev, method);
> +}
> +
> +static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
> +                              uint32_t irq, bool use_highmem, bool highm=
em_ecam,
> +                              VirtMachineState *vms)
> +{
> +    int ecam_id =3D VIRT_ECAM_ID(highmem_ecam);
> +    Aml *method, *dev, *crs;
> +    int count =3D 0;
> +    hwaddr base_mmio =3D memmap[VIRT_PCIE_MMIO].base;
> +    hwaddr size_mmio =3D memmap[VIRT_PCIE_MMIO].size;
> +    hwaddr base_pio =3D memmap[VIRT_PCIE_PIO].base;
> +    hwaddr size_pio =3D memmap[VIRT_PCIE_PIO].size;
> +    hwaddr base_ecam =3D memmap[ecam_id].base;
> +    hwaddr size_ecam =3D memmap[ecam_id].size;
> +    /*
> +     * 0x600000 would be enough for pxb device
> +     * if it is too small, there is no enough space
> +     * for a pcie device plugged in a pcie-root port
> +     */
> +    hwaddr size_addr =3D 0x600000;
> +    hwaddr size_io =3D 0x4000;
> +    int nr_pcie_buses =3D size_ecam / PCIE_MMCFG_SIZE_MIN;
> +    int root_bus_limit =3D 0xFF;
> +    PCIBus *bus =3D NULL;
> +    bus =3D VIRT_MACHINE(vms)->bus;
> +
> +    if (bus) {
> +        QLIST_FOREACH(bus, &bus->child, sibling) {
> +            uint8_t bus_num =3D pci_bus_num(bus);
> +            uint8_t numa_node =3D pci_bus_numa_node(bus);
> +
> +            if (!pci_bus_is_root(bus)) {
> +                continue;
> +            }
> +            if (bus_num < root_bus_limit) {
> +                root_bus_limit =3D bus_num - 1;
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
> +            if (numa_node !=3D NUMA_NODE_UNASSIGNED) {
> +                method =3D aml_method("_PXM", 0, AML_NOTSERIALIZED);
> +                aml_append(method, aml_return(aml_int(numa_node)));
> +                aml_append(dev, method);
> +            }
> +
> +            acpi_dsdt_add_pci_route_table(dev, scope, nr_pcie_buses, irq=
);
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
> +                       0x0000, (size_pio) / 2 - size_io * count,
> +                       (size_pio / 2) - 1 - size_io * (count - 1),
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
> +            Aml *dev_rp0 =3D aml_device("%s", "RP0");
> +            aml_append(dev_rp0, aml_name_decl("_ADR", aml_int(0)));
> +            aml_append(dev, dev_rp0);
> +
> +            aml_append(scope, dev);
> +
> +        }
> +    }
> +
> +    dev =3D aml_device("%s", "PCI0");
> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
> +    aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
> +    aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
> +    aml_append(dev, aml_name_decl("_BBN", aml_int(0)));
> +    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> +    aml_append(dev, aml_name_decl("_UID", aml_string("PCI0")));
> +    aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Device")))=
;
> +    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> +
> +    acpi_dsdt_add_pci_route_table(dev, scope, nr_pcie_buses, irq);
> +
> +    method =3D aml_method("_CBA", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_return(aml_int(base_ecam)));
> +    aml_append(dev, method);
> +
> +    method =3D aml_method("_CRS", 0, AML_NOTSERIALIZED);
> +    Aml *rbuf =3D aml_resource_template();
> +    aml_append(rbuf,
> +        aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE=
,
> +                            0x0000, 0x0000, root_bus_limit, 0x0000,
> +                            root_bus_limit + 1));
> +    aml_append(rbuf,
> +        aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
> +                         AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000, base=
_mmio,
> +                         base_mmio + size_mmio - 1 - size_addr * count,
> +                         0x0000, size_mmio - size_addr * count));
> +    aml_append(rbuf,
> +        aml_dword_io(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
> +                     AML_ENTIRE_RANGE, 0x0000, 0x0000,
> +                     size_pio / 2 - 1 - size_io * count, base_pio,
> +                     size_pio / 2 - size_io * count));
> +
> +    if (use_highmem) {
> +        hwaddr base_mmio_high =3D memmap[VIRT_HIGH_PCIE_MMIO].base;
> +        hwaddr size_mmio_high =3D memmap[VIRT_HIGH_PCIE_MMIO].size;
> +
> +        aml_append(rbuf,
> +            aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXE=
D,
> +                             AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
> +                             base_mmio_high,
> +                             base_mmio_high + size_mmio_high - 1 -
> +                             size_addr * count,
> +                             0x0000, size_mmio_high - size_addr * count)=
);
> +    }
> +
> +    aml_append(method, aml_name_decl("RBUF", rbuf));
> +    aml_append(method, aml_return(rbuf));
> +    aml_append(dev, method);
> +
> +    acpi_dsdt_add_pci_osc(dev, scope);
> =20
>      Aml *dev_rp0 =3D aml_device("%s", "RP0");
>      aml_append(dev_rp0, aml_name_decl("_ADR", aml_int(0)));


this will be easier to review if you first refactor existing code,
then add pxb support on top.

> @@ -744,7 +862,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, Vi=
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
> diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
> index 0ca604dc62..2c18cdfec4 100644
> --- a/hw/pci-host/gpex.c
> +++ b/hw/pci-host/gpex.c
> @@ -36,6 +36,7 @@
>  #include "hw/qdev-properties.h"
>  #include "migration/vmstate.h"
>  #include "qemu/module.h"
> +#include "hw/arm/virt.h"
> =20
>  /***********************************************************************=
*****
>   * GPEX host
> @@ -98,6 +99,9 @@ static void gpex_host_realize(DeviceState *dev, Error *=
*errp)
>                                       pci_swizzle_map_irq_fn, s, &s->io_m=
mio,
>                                       &s->io_ioport, 0, 4, TYPE_PCIE_BUS)=
;
> =20
> +#ifdef __aarch64__
> +    VIRT_MACHINE(qdev_get_machine())->bus =3D pci->bus;
> +#endif
>      qdev_set_parent_bus(DEVICE(&s->gpex_root), BUS(pci->bus));
>      pci_bus_set_route_irq_fn(pci->bus, gpex_route_intx_pin_to_irq);
>      qdev_init_nofail(DEVICE(&s->gpex_root));


What does all this have to do with building on aarch64?


> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 71508bf40c..cfc65dd19b 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -140,6 +140,7 @@ typedef struct {
>      DeviceState *gic;
>      DeviceState *acpi_dev;
>      Notifier powerdown_notifier;
> +    PCIBus *bus;
>  } VirtMachineState;

Again one bus per machine? Pls give this field a better name
and add some comments.

> =20
>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
> --=20
> 2.19.1
>=20


