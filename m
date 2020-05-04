Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A66C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:01:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED84820705
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxJXz003"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED84820705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbfE-0005sN-1x
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVbeG-0005GK-T0
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:00:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56495
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVbeF-0004wJ-Du
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588600842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h2HOJt54iPNGB+w03xx6vxnNwUv2fgYi5kYmWLYJeyw=;
 b=XxJXz003JVkqp1mD1Kc84PT4lQ5z4EbzbHvY2W+QgH0ZTPUPJVvdSd2f8rb0JepJ+PxPfO
 pZ+1O9DrLKZvIaijfK3ggw0RwNZq919qmdekoH9r0CpsVniTYIk8BNq0hxW7Lu8aq2ORvl
 QjnpSr+nyMj20d30iaUAmcDOsYWUj7A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-3GsmK9ieNYmN4FjvKlLvuQ-1; Mon, 04 May 2020 10:00:40 -0400
X-MC-Unique: 3GsmK9ieNYmN4FjvKlLvuQ-1
Received: by mail-wm1-f70.google.com with SMTP id b203so3531323wmd.6
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zXehveZQGe2dyrEpJ7D99mPheniP2+gnAGD1WW+pxZc=;
 b=Bk0s50C3STQd+txv25Frsm+sGqcBk8Z7Z9DxB1Yr0C1tT3hrdPSaiAHX4b6D327jwL
 xitPLwgPzGF0RzO4Avbh9LsCs+PSHZDyorMLSV4Sv4tre51xxrO7y6vLxbrSObF3qtSu
 hUlpgpV7DvHLSvH4lOZgDQfFqNDgVivWM+SXA0gakxsfGWoRSo2ez6HrXES4FiMrPgh0
 zJ/N51e3bjW0cBwqwCj8XAfy+4+g5Vsxr29Y/uK+/+K9mNewxAUuAX9nt3Bb9NQInkoT
 lKtf0sMp/veUuZI08BzczGhuCR1taGehUFwbXpeN6zj4AwF/3rxyfx3hy6WMQKPGQ6sg
 5Dhg==
X-Gm-Message-State: AGi0PuacooU2dNfvWYru1uxx+8IFMK1UBI2xI/mc0KJ59zAcZtNGlWBD
 hWRHr5U/MSSzRKHdOzp+qPQCyz3hMIsBM6jtMf4kMEy+1tS3XyYCKQtXTXnfzjEm4Hr3YwgsNmV
 3kSoNaKXVPcZv+DE=
X-Received: by 2002:adf:df01:: with SMTP id y1mr19094762wrl.401.1588600839184; 
 Mon, 04 May 2020 07:00:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypLQZr7edlAI1OQSDexWj/6SS1vftcS7SYoue8D6bWdYZBE8C4lI9vzl/MMLD+0AgDTtCQUgVg==
X-Received: by 2002:adf:df01:: with SMTP id y1mr19094726wrl.401.1588600838707; 
 Mon, 04 May 2020 07:00:38 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 u127sm14342390wme.8.2020.05.04.07.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:00:38 -0700 (PDT)
Date: Mon, 4 May 2020 10:00:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yubo Miao <miaoyubo@huawei.com>
Subject: Re: [PATCH v6 4/8] acpi: Refactor the source of host bridge and
 build tables for pxb
Message-ID: <20200504095329-mutt-send-email-mst@kernel.org>
References: <20200408125816.955-1-miaoyubo@huawei.com>
 <20200408125816.955-5-miaoyubo@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200408125816.955-5-miaoyubo@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 xiexiangyou@huawei.com, shannon.zhaosl@gmail.com, imammedo@redhat.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 08, 2020 at 08:58:12PM +0800, Yubo Miao wrote:
> From: miaoyubo <miaoyubo@huawei.com>
>=20
> The resources of pxbs and obtained by crs_build and the resources
> used by pxbs would be moved form the resources defined for host-bridge.
>=20
> The resources for pxb are composed of the bar space of the
> pci-bridge/pcie-root-port behined it and the config space of devices
> behind it.
>=20
> Signed-off-by: miaoyubo <miaoyubo@huawei.com>

A bunch of spelling/syntax mistakes in the log, pls spellcheck.

Pls use the format
 Yubo Miao <miaoyubo@huawei.com>



> ---
>  hw/arm/virt-acpi-build.c | 131 +++++++++++++++++++++++++++++++++------
>  1 file changed, 111 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index e8ba09855c..7bcd04dfb7 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -49,6 +49,9 @@
>  #include "kvm_arm.h"
>  #include "migration/vmstate.h"
> =20
> +#include "hw/arm/virt.h"
> +#include "hw/pci/pci_bus.h"
> +#include "hw/pci/pci_bridge.h"
>  #define ARM_SPI_BASE 32
> =20
>  static void acpi_dsdt_add_cpus(Aml *scope, int smp_cpus)
> @@ -266,19 +269,81 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, Aml *sc=
ope)
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
> +    int i;
> +    Aml *method, *crs, *dev;
>      hwaddr base_mmio =3D memmap[VIRT_PCIE_MMIO].base;
>      hwaddr size_mmio =3D memmap[VIRT_PCIE_MMIO].size;
>      hwaddr base_pio =3D memmap[VIRT_PCIE_PIO].base;
>      hwaddr size_pio =3D memmap[VIRT_PCIE_PIO].size;
>      hwaddr base_ecam =3D memmap[ecam_id].base;
>      hwaddr size_ecam =3D memmap[ecam_id].size;
> +    CrsRangeEntry *entry;
> +    CrsRangeSet crs_range_set;
> +
> +    crs_range_set_init(&crs_range_set);
>      int nr_pcie_buses =3D size_ecam / PCIE_MMCFG_SIZE_MIN;
> +    PCIHostState *s =3D OBJECT_CHECK(PCIHostState,
> +                                   object_resolve_path_type("",
> +                                   "pcie-host-bridge", NULL),
> +                                   TYPE_PCI_HOST_BRIDGE);

Not TYPE_PCIE_HOST_BRIDGE? And what if it's ambiguous?


> +
> +    PCIBus *bus =3D s->bus;
> +    /* start to construct the tables for pxb*/


coding style violation. weird that ehckpatch didn't notice it.

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


Couldn't figure out this comment. Pls rephrase in some way so it's
understandable.

> +             */
> +            if (bus_num < nr_pcie_buses) {
> +                nr_pcie_buses =3D bus_num;
> +            }
> +
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
> +            acpi_dsdt_add_pci_route_table(dev, scope, irq);
> +
> +            /*
> +             * Resources deined for PXBs are composed by the folling par=
ts:
> +             * 1. The resources the pci-brige/pcie-root-port need.
> +             * 2. The resources the devices behind pxb need.
> +             */


syntax/grammar errors here too.

> +            crs =3D build_crs(PCI_HOST_BRIDGE(BUS(bus)->parent), &crs_ra=
nge_set);
> +            aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +            acpi_dsdt_add_pci_osc(dev, scope);
> +
> +            aml_append(scope, dev);
> +
> +        }
> +    }
> =20
> -    Aml *dev =3D aml_device("%s", "PCI0");
> +    /* start to construct the tables for main host bridge */

tables for the main.



> +    dev =3D aml_device("%s", "PCI0");


Make dev above local in scope, then this can stay unchanged.

>      aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
>      aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
>      aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
> @@ -299,25 +364,51 @@ static void acpi_dsdt_add_pci(Aml *scope, const Mem=
MapEntry *memmap,
>          aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE=
,
>                              0x0000, 0x0000, nr_pcie_buses - 1, 0x0000,
>                              nr_pcie_buses));
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
> +
> +    /*
> +     * Remove the resources used by PXBs.
> +     */
> +    crs_replace_with_free_ranges(crs_range_set.mem_ranges,
> +                                 base_mmio,
> +                                 base_mmio + size_mmio - 1);
> +    for (i =3D 0; i < crs_range_set.mem_ranges->len; i++) {
> +        entry =3D g_ptr_array_index(crs_range_set.mem_ranges, i);
> +        aml_append(rbuf,
> +            aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXE=
D,
> +                             AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
> +                             entry->base, entry->limit,
> +                             0x0000, entry->limit - entry->base + 1));
> +    }
> +
> +    crs_replace_with_free_ranges(crs_range_set.io_ranges,
> +                                 0x0000,
> +                                 size_pio - 1);
> +    for (i =3D 0; i < crs_range_set.io_ranges->len; i++) {
> +        entry =3D g_ptr_array_index(crs_range_set.io_ranges, i);
> +        aml_append(rbuf,
> +            aml_dword_io(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
> +                         AML_ENTIRE_RANGE, 0x0000, entry->base,
> +                         entry->limit, base_pio,
> +                         entry->limit - entry->base + 1));
> +    }
> +
> =20
>      if (use_highmem) {
>          hwaddr base_mmio_high =3D memmap[VIRT_HIGH_PCIE_MMIO].base;
>          hwaddr size_mmio_high =3D memmap[VIRT_HIGH_PCIE_MMIO].size;
> =20
> -        aml_append(rbuf,
> -            aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXE=
D,
> -                             AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
> -                             base_mmio_high,
> -                             base_mmio_high + size_mmio_high - 1, 0x0000=
,
> -                             size_mmio_high));
> +        crs_replace_with_free_ranges(crs_range_set.mem_64bit_ranges,
> +                                     base_mmio_high,
> +                                     base_mmio_high + size_mmio_high - 1=
);
> +        for (i =3D 0; i < crs_range_set.mem_64bit_ranges->len; i++) {
> +            entry =3D g_ptr_array_index(crs_range_set.mem_64bit_ranges, =
i);
> +            aml_append(rbuf,
> +                aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_=
FIXED,
> +                                 AML_NON_CACHEABLE, AML_READ_WRITE, 0x00=
00,
> +                                 entry->base,
> +                                 entry->limit, 0x0000,
> +                                 entry->limit - entry->base + 1));
> +        }
>      }
> =20
>      aml_append(method, aml_return(rbuf));
> @@ -335,6 +426,8 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMa=
pEntry *memmap,
>      aml_append(dev_res0, aml_name_decl("_CRS", crs));
>      aml_append(dev, dev_res0);
>      aml_append(scope, dev);
> +
> +    crs_range_set_free(&crs_range_set);
>  }
> =20
>  static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memma=
p,
> @@ -746,7 +839,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, Vi=
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
> @@ -798,7 +891,6 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuild=
Tables *tables)
>      unsigned dsdt, xsdt;
>      GArray *tables_blob =3D tables->table_data;
>      MachineState *ms =3D MACHINE(vms);
> -
>      table_offsets =3D g_array_new(false, true /* clear */,
>                                          sizeof(uint32_t));
>

this empty line didn't hurt
 =20
> @@ -952,7 +1044,6 @@ void virt_acpi_setup(VirtMachineState *vms)
>      build_state->rsdp_mr =3D acpi_add_rom_blob(virt_acpi_build_update,
>                                               build_state, tables.rsdp,
>                                               ACPI_BUILD_RSDP_FILE, 0);
> -
>      qemu_register_reset(virt_acpi_build_reset, build_state);
>      virt_acpi_build_reset(build_state);
>      vmstate_register(NULL, 0, &vmstate_virt_acpi_build, build_state);


this line didn't hurt either.

> --=20
> 2.19.1
>=20


