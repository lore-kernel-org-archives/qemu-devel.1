Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B654DC35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7162820714
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMGvZisv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7162820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Wpo-0003xp-KJ
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 04:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6Woq-0003Cm-Gp
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:48:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6Wok-0003lu-SJ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:47:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51394
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6Wok-0003lf-Nb
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:47:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582624074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vr3ouk+3V25TZeA/LhnvUEjUtixD7I3Zb9eLSNWmeeA=;
 b=QMGvZisv9nR2MwhDscOwenTU/Eg+9U4Mu+xdoDIuvtf5yZ9kge6yGpfYR3R/jwhMDsw5U3
 quDY9D9z1caXGxbBzrbCnD6rFdemICWvKhfs+grHzXlxL+pzhe3KszJCVnYl0084poCEH6
 yivn5LlqPNi35ikhrCuO5hgMlYocyKk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-262ChSHfOJKgjdt83xBAEg-1; Tue, 25 Feb 2020 04:47:52 -0500
X-MC-Unique: 262ChSHfOJKgjdt83xBAEg-1
Received: by mail-ed1-f71.google.com with SMTP id k6so8679935edq.8
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 01:47:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vr3ouk+3V25TZeA/LhnvUEjUtixD7I3Zb9eLSNWmeeA=;
 b=CAr8pviGavtnwa7sBZ4LS2Q/xkPIXcYUH9Csj0YWQWKW2hXqUm1FY++0d3Ri5MvK84
 cWgqLLw1ovO/z3MCdNJKjKuevIIOBKWftao9SUlFFGjv1ua9WqAAMKb5TXh8PyOfMlD6
 VJYwtNyQf1SazR+dqAI3yx5RU7XdGjQEfaNojVVlxAtngJockr2e9o5zMzdQxEBOkZrz
 WpdfLaWKbrKTTEKwdHDPrrmTv4MQfDR+0siu7iCWrbWwzkaIjSNBfbNDTnM6WInXWZYg
 Pig+gv2TMxmlGeplN/wUjk++geRqFXXFYuD1xodQgz5cymNLEi/GPpvThzLPboCFpkyL
 uTcw==
X-Gm-Message-State: APjAAAWHC5ZhHxyMEHFx2KmqO2FJFL1pQRYw4Y4w5gB+7wqJlnH6a1MF
 37s6+qLWlLfJN1Evgb88cp1uj93g0MAgPwpyFrVqzpduMLcIah4CsbBqdmWHwoaKlCikcVuy/MZ
 80Gynsx/qlLOyhN4=
X-Received: by 2002:a05:6402:709:: with SMTP id
 w9mr30387201edx.74.1582624070216; 
 Tue, 25 Feb 2020 01:47:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqyU7Q0LiRNgycV08D6HX9+GGVADGGaQPzHv6+vNKy2LBZdaCzxE7CDuZxIWVUeDUjYiwCevUA==
X-Received: by 2002:a05:6402:709:: with SMTP id
 w9mr30387172edx.74.1582624069906; 
 Tue, 25 Feb 2020 01:47:49 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id d13sm1136371edk.0.2020.02.25.01.47.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 01:47:49 -0800 (PST)
Subject: Re: [PATCH v4 2/3] acpi:pci-expender-bus: Add pxb support for arm
To: Yubo Miao <miaoyubo@huawei.com>, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com
References: <20200225015026.940-1-miaoyubo@huawei.com>
 <20200225015026.940-3-miaoyubo@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3086f4a2-fb0a-d276-7c76-f06474befa35@redhat.com>
Date: Tue, 25 Feb 2020 10:47:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225015026.940-3-miaoyubo@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: imammedo@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 2:50 AM, Yubo Miao wrote:
> From: miaoyubo <miaoyubo@huawei.com>
> 
> Currently virt machine is not supported by pxb-pcie,
> and only one main host bridge described in ACPI tables.
> In this patch,PXB-PCIE is supproted by arm and certain

Typos: "expander" in subject and "supported" here.

> resource is allocated for each pxb-pcie in acpi table.
> The resource for the main host bridge is also reallocated.
> 
> Signed-off-by: miaoyubo <miaoyubo@huawei.com>
> ---
>   hw/arm/virt-acpi-build.c | 115 ++++++++++++++++++++++++++++++++++++---
>   hw/arm/virt.c            |   3 +
>   include/hw/arm/virt.h    |   7 +++
>   3 files changed, 118 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 37c34748a6..be1986c60d 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -49,6 +49,8 @@
>   #include "kvm_arm.h"
>   #include "migration/vmstate.h"
>   
> +#include "hw/arm/virt.h"
> +#include "hw/pci/pci_bus.h"
>   #define ARM_SPI_BASE 32
>   
>   static void acpi_dsdt_add_cpus(Aml *scope, int smp_cpus)
> @@ -266,19 +268,116 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, Aml *scope)
>   }
>   
>   static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
> -                              uint32_t irq, bool use_highmem, bool highmem_ecam)
> +                              uint32_t irq, bool use_highmem, bool highmem_ecam,
> +                              VirtMachineState *vms)
>   {
>       int ecam_id = VIRT_ECAM_ID(highmem_ecam);
> -    Aml *method, *crs;
> +    Aml *method, *crs, *dev;
> +    int count = 0;
>       hwaddr base_mmio = memmap[VIRT_PCIE_MMIO].base;
>       hwaddr size_mmio = memmap[VIRT_PCIE_MMIO].size;
>       hwaddr base_pio = memmap[VIRT_PCIE_PIO].base;
>       hwaddr size_pio = memmap[VIRT_PCIE_PIO].size;
>       hwaddr base_ecam = memmap[ecam_id].base;
>       hwaddr size_ecam = memmap[ecam_id].size;
> +    /*
> +     * 0x600000 would be enough for pxb device
> +     * if it is too small, there is no enough space
> +     * for a pcie device plugged in a pcie-root port
> +     */
> +    hwaddr size_addr = 0x600000;
> +    hwaddr size_io = 0x4000;
>       int nr_pcie_buses = size_ecam / PCIE_MMCFG_SIZE_MIN;
> +    PCIBus *bus = VIRT_MACHINE(vms)->bus;
> +
> +    if (bus) {
> +        QLIST_FOREACH(bus, &bus->child, sibling) {
> +            uint8_t bus_num = pci_bus_num(bus);
> +            uint8_t numa_node = pci_bus_numa_node(bus);
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
> +                nr_pcie_buses = bus_num;
> +            }
> +            count++;
> +            dev = aml_device("PC%.02X", bus_num);
> +            aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
> +            aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
> +            aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> +            aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> +            aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
> +            aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
> +            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
> +            aml_append(dev, aml_name_decl("_STR", aml_unicode("pxb Device")));
> +            if (numa_node != NUMA_NODE_UNASSIGNED) {
> +                method = aml_method("_PXM", 0, AML_NOTSERIALIZED);
> +                aml_append(method, aml_return(aml_int(numa_node)));
> +                aml_append(dev, method);
> +            }
> +
> +            acpi_dsdt_add_pci_route_table(dev, scope, irq);
> +
> +            method = aml_method("_CBA", 0, AML_NOTSERIALIZED);
> +            aml_append(method, aml_return(aml_int(base_ecam)));
> +            aml_append(dev, method);
> +
> +            method = aml_method("_CRS", 0, AML_NOTSERIALIZED);
> +            Aml *rbuf = aml_resource_template();
> +            aml_append(rbuf,
> +                       aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED,
> +                                           AML_POS_DECODE, 0x0000,
> +                                           bus_num, bus_num + 1, 0x0000,
> +                                           2));
> +            aml_append(rbuf,
> +                       aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED,
> +                                        AML_MAX_FIXED, AML_NON_CACHEABLE,
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
> +                hwaddr base_mmio_high = memmap[VIRT_HIGH_PCIE_MMIO].base;
> +                hwaddr size_mmio_high = memmap[VIRT_HIGH_PCIE_MMIO].size;
> +
> +                aml_append(rbuf,
> +                       aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED,
> +                                        AML_MAX_FIXED, AML_NON_CACHEABLE,
> +                                        AML_READ_WRITE, 0x0000,
> +                                        base_mmio_high + size_mmio_high -
> +                                        size_addr * count,
> +                                        base_mmio_high + size_mmio_high -
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
>   
> -    Aml *dev = aml_device("%s", "PCI0");
> +    dev = aml_device("%s", "PCI0");
>       aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
>       aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
>       aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
> @@ -302,11 +401,13 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>       aml_append(rbuf,
>           aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
>                            AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000, base_mmio,
> -                         base_mmio + size_mmio - 1, 0x0000, size_mmio));
> +                         base_mmio + size_mmio - 1 - size_addr * count,
> +                         0x0000, size_mmio - size_addr * count));
>       aml_append(rbuf,
>           aml_dword_io(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
> -                     AML_ENTIRE_RANGE, 0x0000, 0x0000, size_pio - 1, base_pio,
> -                     size_pio));
> +                     AML_ENTIRE_RANGE, 0x0000, 0x0000,
> +                     size_pio - 1 - size_io * count, base_pio,
> +                     size_pio - size_io * count));
>   
>       if (use_highmem) {
>           hwaddr base_mmio_high = memmap[VIRT_HIGH_PCIE_MMIO].base;
> @@ -746,7 +847,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>       acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
>                       (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
>       acpi_dsdt_add_pci(scope, memmap, (irqmap[VIRT_PCIE] + ARM_SPI_BASE),
> -                      vms->highmem, vms->highmem_ecam);
> +                      vms->highmem, vms->highmem_ecam, vms);
>       if (vms->acpi_dev) {
>           build_ged_aml(scope, "\\_SB."GED_DEVICE,
>                         HOTPLUG_HANDLER(vms->acpi_dev),
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index f788fe27d6..6314928671 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1246,6 +1246,9 @@ static void create_pcie(VirtMachineState *vms)
>       }
>   
>       pci = PCI_HOST_BRIDGE(dev);
> +
> +    VIRT_MACHINE(qdev_get_machine())->bus = pci->bus;
> +
>       if (pci->bus) {
>           for (i = 0; i < nb_nics; i++) {
>               NICInfo *nd = &nd_table[i];
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 71508bf40c..90f10a1e46 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -140,6 +140,13 @@ typedef struct {
>       DeviceState *gic;
>       DeviceState *acpi_dev;
>       Notifier powerdown_notifier;
> +    /*
> +     * pointer to devices and objects
> +     * Via going through the bus, all
> +     * pci devices and related objectes

Typo "objects", but I don't understand the comment well.

> +     * could be gained.
> +     */
> +    PCIBus *bus;
>   } VirtMachineState;
>   
>   #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
> 


