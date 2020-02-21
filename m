Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD843C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6814C207FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqHFepAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6814C207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j56Kg-0001s6-Ju
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 06:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j56Jj-0000a0-J1
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:18:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j56Jh-0005hE-P4
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:17:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21691
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j56Jh-0005gk-Hw
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582283877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eWTcU9my9T8Qp8UUGTVMN2TVgmXHqpQMikgRs5Esyd0=;
 b=eqHFepATFGClrp5NJVppFN2+zg7cqtt2KZcLflOK1KFX4qZKYFKsSafW4nZagKgNm6veEu
 aj7MGq5maxn8pkIkKTXKagI6OcO+qEAdH/9NtrUVRzJHUSTuIdYVAvbUg/cWfMU7khtwaU
 zIci80ksfGnT2RVmJzuGjnIZySh8CWw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-onnKSt5zPSew5dww4iYp-A-1; Fri, 21 Feb 2020 06:17:54 -0500
X-MC-Unique: onnKSt5zPSew5dww4iYp-A-1
Received: by mail-qv1-f72.google.com with SMTP id g6so1138206qvp.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 03:17:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RnC5kaWawzUEZkUMZ+5Q2vdBvcX0cKOqLC0jlpRuF7s=;
 b=Hac5dkynvJpGN3zw19EngYM56Tm2rsj2CWu3M/cQKqiZgk9vjpLP0OOCog2c66ETN8
 SfVzqGxGA3BLNY7XSnWDbAj+u+6ZYNZlYFd2iJSsVIgcJuAlmWPQMe0Fw6PRtbM0deWH
 9C+ByylVc0RU7vBY3XFgwM0m3fQkGkIpyJH8AgWOKAdz1ypcRgUe7q/M2tkMWD6veoVw
 kx7Kp8nbIY5JH7BZL3c0nZ9h73GJHcl0qKNlgs0nnGUb/er8cmnCq443jo70umqp7yx5
 lVQFY0Z8eD6H17F9l3Fcy8vvfYnjgBuXUN17pLq0h3FPG6MV0L/9ppElBZaTkTchtAws
 +wCg==
X-Gm-Message-State: APjAAAVCQNu8QXkWR+D24Ve5JOI0MItS8AbE2sL9Oy0BJJS3mOxQbdg5
 UJ4buEB8YWlkXqogr7f/cypvsbL5U7BZzjA/si5/uZVfc5V0GopMydhCJjdYsg2IeehIfjtzi9c
 qI6nz857uYjZpDzo=
X-Received: by 2002:ac8:9b:: with SMTP id c27mr31848468qtg.348.1582283874326; 
 Fri, 21 Feb 2020 03:17:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqy4cu9hb3UlciN+e0rZlQHuXZKHy4Ure0LehuLRVFM6Dr/dHlXzPbsrNn/y3X75XEGJ/UmwtQ==
X-Received: by 2002:ac8:9b:: with SMTP id c27mr31848436qtg.348.1582283873976; 
 Fri, 21 Feb 2020 03:17:53 -0800 (PST)
Received: from redhat.com (bzq-109-67-14-209.red.bezeqint.net. [109.67.14.209])
 by smtp.gmail.com with ESMTPSA id g26sm1324552qkk.68.2020.02.21.03.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 03:17:53 -0800 (PST)
Date: Fri, 21 Feb 2020 06:17:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yubo Miao <miaoyubo@huawei.com>
Subject: Re: [RFC v3 2/3] acpi:pci-expender-bus: Add pxb support for arm
Message-ID: <20200221061402-mutt-send-email-mst@kernel.org>
References: <20200221063512.1104-1-miaoyubo@huawei.com>
 <20200221063512.1104-3-miaoyubo@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200221063512.1104-3-miaoyubo@huawei.com>
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
Cc: peter.maydell@linaro.org, imammedo@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, shannon.zhaosl@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 21, 2020 at 02:35:11PM +0800, Yubo Miao wrote:
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
>  hw/arm/virt-acpi-build.c | 125 +++++++++++++++++++++++++++++++++++----
>  hw/pci-host/gpex.c       |   4 ++
>  include/hw/arm/virt.h    |   7 +++
>  3 files changed, 125 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 0540234b8a..2c1e0d2aaa 100644
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
> @@ -271,19 +273,117 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, Aml *s=
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
> +    Aml *method, *dev, *crs;
> +    int count =3D 0;
>      hwaddr base_mmio =3D memmap[VIRT_PCIE_MMIO].base;
>      hwaddr size_mmio =3D memmap[VIRT_PCIE_MMIO].size;
>      hwaddr base_pio =3D memmap[VIRT_PCIE_PIO].base;
>      hwaddr size_pio =3D memmap[VIRT_PCIE_PIO].size;
>      hwaddr base_ecam =3D memmap[ecam_id].base;
>      hwaddr size_ecam =3D memmap[ecam_id].size;
> +    /*
> +     * 0x600000 would be enough for pxb device
> +     * if it is too small, there is no enough space
> +     * for a pcie device plugged in a pcie-root port
> +     */
> +    hwaddr size_addr =3D 0x600000;
> +    hwaddr size_io =3D 0x4000;
>      int nr_pcie_buses =3D size_ecam / PCIE_MMCFG_SIZE_MIN;
> +    int root_bus_limit =3D 0xFF;

what's this?

> +    PCIBus *bus =3D NULL;
> +    bus =3D VIRT_MACHINE(vms)->bus;

So just move assignment as part of declaration.

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

what is this doing? manually coded up MIN?

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
> +            Aml *dev_rp0 =3D aml_device("%s", "RP0");
> +            aml_append(dev_rp0, aml_name_decl("_ADR", aml_int(0)));
> +            aml_append(dev, dev_rp0);
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
> @@ -303,16 +403,18 @@ static void acpi_dsdt_add_pci(Aml *scope, const Mem=
MapEntry *memmap,
>      Aml *rbuf =3D aml_resource_template();
>      aml_append(rbuf,
>          aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE=
,
> -                            0x0000, 0x0000, nr_pcie_buses - 1, 0x0000,
> -                            nr_pcie_buses));
> +                            0x0000, 0x0000, root_bus_limit, 0x0000,
> +                            root_bus_limit + 1));
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
> @@ -322,8 +424,9 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMa=
pEntry *memmap,
>              aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXE=
D,
>                               AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
>                               base_mmio_high,
> -                             base_mmio_high + size_mmio_high - 1, 0x0000=
,
> -                             size_mmio_high));
> +                             base_mmio_high + size_mmio_high - 1 -
> +                             size_addr * count,
> +                             0x0000, size_mmio_high - size_addr * count)=
);
>      }
> =20
>      aml_append(method, aml_name_decl("RBUF", rbuf));
> @@ -759,7 +862,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, Vi=
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

I'm repeating myself but - what does this have to do with
building on __aarch64__?

>      qdev_set_parent_bus(DEVICE(&s->gpex_root), BUS(pci->bus));
>      pci_bus_set_route_irq_fn(pci->bus, gpex_route_intx_pin_to_irq);
>      qdev_init_nofail(DEVICE(&s->gpex_root));
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 71508bf40c..9accaf2b1b 100644
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
> +     * */
> +    PCIBus *bus;

That comment doesn't really tell me what this is.
Is this the root bus?
With an extender, don't we have lots of roots?


>  } VirtMachineState;
> =20
>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
> --=20
> 2.19.1
>=20


