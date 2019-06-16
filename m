Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75617C31E49
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 11:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2461520652
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 11:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NHnpZLE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2461520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38978 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcTZ5-0001WB-3U
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 07:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33339)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hongbo.zhang@linaro.org>) id 1hcTXz-00013t-Cz
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 07:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hongbo.zhang@linaro.org>) id 1hcTXq-00013Y-Lg
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 07:42:03 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:44887)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
 id 1hcTXn-0000vY-Sm
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 07:41:57 -0400
Received: by mail-io1-xd44.google.com with SMTP id s7so15223794iob.11
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 04:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xzRoN3Hc4nbHvzh+ancbtXmvGerYtHMpr1hrImua3sU=;
 b=NHnpZLE/hhX0uULLxUgLGdzV/ese6dnYwenJwudqzu5T9LR3yIrIoBE0edt5c3+o6S
 Sokza6ogfwaG6KkXSnffkyW685TZ/rV1ZjBkhFZPsk8SYqFvoHPQtN/9aZTOHdjdyEx2
 esnttYjHVmulDDCbRjvMANNuYO9tKD7CO8AQh/+7h05aLoRsoKRPlr6t4tN5csCpkGkY
 ZcKGR85JbQnSds2bKHyyDNH2LumDJ5sSEvzwGrlo3HsviwUhTBYFT7iclBJpNHZkBMtB
 uNi+fmZ9B5ctn2JEQ9ewL8JmlTEb+MFixSmNbh3TEZ2jeAhS+GPBtbK9qxErStpUcOil
 DsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xzRoN3Hc4nbHvzh+ancbtXmvGerYtHMpr1hrImua3sU=;
 b=oz3CiXz4HXzBPtPNCO2tCpOYYJXqIeE1KDg+tzLd10TRk6xRcXZbDTtjrSLsAW3A8+
 IXw+k+vRJIsd54Mux55i5MncV+MEAQyZvZuyOYRXflgLgGjIHs87r1nF5Mc+sdxDad53
 w77/KvMsByYRigDZRrozeRto6EsfeLHxicJIYEgxXUbcte41twixXEeTJvihJOFWZgMC
 7uxxcYK0sEkIh5afJ2LqgCVpAp18uMla0gIUkU/cWcX+snY4u6anS7bdiudsduY7WCRN
 ANOQ1SDwSI7xOq0c3FM+BrBqLdmNkWUXmgGKRu/o3b+Fx4yjMTZGKKgIry/o/lQlD5wv
 kemQ==
X-Gm-Message-State: APjAAAUSDSG8B78vjk/+CCoT6E+/wqj2wvKmxoXjuLJCfUHnYHoleR2B
 ZaG+Jx3Pc99DBEcnkUOrtbnuFrys0uuEW0MbbPXXsw==
X-Google-Smtp-Source: APXvYqzSaL77NCwlNEGmdJPbLXpAdu6vYa+YJXPUeGq0/ouHE+PvoUsoS52HT50k14WHEtt4EGJ3St8WxzCTzKT8d0Y=
X-Received: by 2002:a02:7715:: with SMTP id g21mr30503750jac.24.1560685311112; 
 Sun, 16 Jun 2019 04:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <1555560291-3415-1-git-send-email-hongbo.zhang@linaro.org>
 <1555560291-3415-3-git-send-email-hongbo.zhang@linaro.org>
 <ed731639-5ed1-5473-f078-e62f8fa98678@redhat.com>
In-Reply-To: <ed731639-5ed1-5473-f078-e62f8fa98678@redhat.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Sun, 16 Jun 2019 19:41:41 +0800
Message-ID: <CAHmQWvAuQ9mwXA5uO3ShYyvP5ywOrck5kU4gPD_kGh5S39Va2w@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Subject: Re: [Qemu-devel] [PATCH v7 2/2] hw/arm: Add arm SBSA reference
 machine, devices part
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Jun 2019 at 18:54, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Hi Hongbo, Ard.
>
> On 4/18/19 6:04 AM, Hongbo Zhang wrote:
> > Following the previous patch, this patch adds peripheral devices to the
> > newly introduced SBSA-ref machine.
> >
> > Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> > ---
> >  hw/arm/sbsa-ref.c | 451 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 451 insertions(+)
> >
> > diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> > index 652ec13..3fb0027 100644
> > --- a/hw/arm/sbsa-ref.c
> > +++ b/hw/arm/sbsa-ref.c
> > @@ -21,6 +21,7 @@
> >  #include "qapi/error.h"
> >  #include "qemu/error-report.h"
> >  #include "qemu/units.h"
> > +#include "sysemu/device_tree.h"
> >  #include "sysemu/numa.h"
> >  #include "sysemu/sysemu.h"
> >  #include "exec/address-spaces.h"
> > @@ -28,11 +29,28 @@
> >  #include "kvm_arm.h"
> >  #include "hw/arm/arm.h"
> >  #include "hw/boards.h"
> > +#include "hw/ide/internal.h"
> > +#include "hw/ide/ahci_internal.h"
> >  #include "hw/intc/arm_gicv3_common.h"
> > +#include "hw/loader.h"
> > +#include "hw/pci-host/gpex.h"
> > +#include "hw/usb.h"
> > +#include "net/net.h"
> >
> >  #define RAMLIMIT_GB 8192
> >  #define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
> >
> > +#define NUM_IRQS        256
> > +#define NUM_SMMU_IRQS   4
> > +#define NUM_SATA_PORTS  6
> > +
> > +#define VIRTUAL_PMU_IRQ        7
> > +#define ARCH_GIC_MAINT_IRQ     9
> > +#define ARCH_TIMER_VIRT_IRQ    11
> > +#define ARCH_TIMER_S_EL1_IRQ   13
> > +#define ARCH_TIMER_NS_EL1_IRQ  14
> > +#define ARCH_TIMER_NS_EL2_IRQ  10
> > +
> >  enum {
> >      SBSA_FLASH,
> >      SBSA_MEM,
> > @@ -115,6 +133,415 @@ static const int sbsa_ref_irqmap[] =3D {
> >      [SBSA_EHCI] =3D 11,
> >  };
> >
> > +/*
> > + * Firmware on this machine only uses ACPI table to load OS, these lim=
ited
> > + * device tree nodes are just to let firmware know the info which vari=
es from
> > + * command line parameters, so it is not necessary to be fully compati=
ble
> > + * with the kernel CPU and NUMA binding rules.
> > + */
> > +static void create_fdt(SBSAMachineState *vms)
> > +{
> > +    void *fdt =3D create_device_tree(&vms->fdt_size);
> > +    const MachineState *ms =3D MACHINE(vms);
> > +    int cpu;
> > +
> > +    if (!fdt) {
> > +        error_report("create_device_tree() failed");
> > +        exit(1);
> > +    }
> > +
> > +    vms->fdt =3D fdt;
> > +
> > +    qemu_fdt_setprop_string(fdt, "/", "compatible", "linux,sbsa-ref");
> > +    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
> > +    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
> > +
> > +    if (have_numa_distance) {
> > +        int size =3D nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32=
_t);
> > +        uint32_t *matrix =3D g_malloc0(size);
> > +        int idx, i, j;
> > +
> > +        for (i =3D 0; i < nb_numa_nodes; i++) {
> > +            for (j =3D 0; j < nb_numa_nodes; j++) {
> > +                idx =3D (i * nb_numa_nodes + j) * 3;
> > +                matrix[idx + 0] =3D cpu_to_be32(i);
> > +                matrix[idx + 1] =3D cpu_to_be32(j);
> > +                matrix[idx + 2] =3D cpu_to_be32(numa_info[i].distance[=
j]);
> > +            }
> > +        }
> > +
> > +        qemu_fdt_add_subnode(fdt, "/distance-map");
> > +        qemu_fdt_setprop(fdt, "/distance-map", "distance-matrix",
> > +                         matrix, size);
> > +        g_free(matrix);
> > +    }
> > +
> > +    qemu_fdt_add_subnode(vms->fdt, "/cpus");
> > +
> > +    for (cpu =3D vms->smp_cpus - 1; cpu >=3D 0; cpu--) {
> > +        char *nodename =3D g_strdup_printf("/cpus/cpu@%d", cpu);
> > +        ARMCPU *armcpu =3D ARM_CPU(qemu_get_cpu(cpu));
> > +        CPUState *cs =3D CPU(armcpu);
> > +
> > +        qemu_fdt_add_subnode(vms->fdt, nodename);
> > +
> > +        if (ms->possible_cpus->cpus[cs->cpu_index].props.has_node_id) =
{
> > +            qemu_fdt_setprop_cell(vms->fdt, nodename, "numa-node-id",
> > +                ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
> > +        }
> > +
> > +        g_free(nodename);
> > +    }
> > +}
> > +
> > +static void create_one_flash(const char *name, hwaddr flashbase,
> > +                             hwaddr flashsize, const char *file,
> > +                             MemoryRegion *sysmem)
> > +{
> > +    /*
> > +     * Create and map a single flash device. We use the same
> > +     * parameters as the flash devices on the Versatile Express board.
> > +     */
> > +    DriveInfo *dinfo =3D drive_get_next(IF_PFLASH);
> > +    DeviceState *dev =3D qdev_create(NULL, "cfi.pflash01");
>
> Please use TYPE_PFLASH_CFI01 instead of "cfi.pflash01".
>
> I wanted to ask "does it has to be CFI01?" because this device model is
> in bad shape, but I guess I answered myself looking at the EDK2 platform
> code:
>
> - P30_CFI_ADDR_VENDOR_ID is not used
> - NorFlashDxe::NorFlashReadCfiData() is not implemented
> - All commands in NorFlashDxe uses:
>     SEND_NOR_COMMAND(..., P30_CMD_...)
>   which are specific to the Intel P30 Nor flash family (CFI01).
>
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> > +    const uint64_t sectorlength =3D 256 * 1024;
> > +
> > +    if (dinfo) {
> > +        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo),
> > +                            &error_abort);
> > +    }
> > +
> > +    qdev_prop_set_uint32(dev, "num-blocks", flashsize / sectorlength);
> > +    qdev_prop_set_uint64(dev, "sector-length", sectorlength);
> > +    qdev_prop_set_uint8(dev, "width", 4);
> > +    qdev_prop_set_uint8(dev, "device-width", 2);
> > +    qdev_prop_set_bit(dev, "big-endian", false);
> > +    qdev_prop_set_uint16(dev, "id0", 0x89);
> > +    qdev_prop_set_uint16(dev, "id1", 0x18);
> > +    qdev_prop_set_uint16(dev, "id2", 0x00);
> > +    qdev_prop_set_uint16(dev, "id3", 0x00);
> > +    qdev_prop_set_string(dev, "name", name);
> > +    qdev_init_nofail(dev);
> > +
> > +    memory_region_add_subregion(sysmem, flashbase,
> > +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(=
dev), 0));
> > +
> > +    if (file) {
> > +        char *fn;
> > +        int image_size;
> > +
> > +        if (drive_get(IF_PFLASH, 0, 0)) {
> > +            error_report("The contents of the first flash device may b=
e "
> > +                         "specified with -bios or with -drive if=3Dpfl=
ash... "
> > +                         "but you cannot use both options at once");
> > +            exit(1);
> > +        }
> > +        fn =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, file);
> > +        if (!fn) {
> > +            error_report("Could not find ROM image '%s'", file);
> > +            exit(1);
> > +        }
> > +        image_size =3D load_image_mr(fn, sysbus_mmio_get_region(sbd, 0=
));
> > +        g_free(fn);
> > +        if (image_size < 0) {
> > +            error_report("Could not load ROM image '%s'", file);
> > +            exit(1);
> > +        }
> > +    }
> > +}
> > +
> > +static void create_flash(const SBSAMachineState *vms,
> > +                         MemoryRegion *sysmem,
> > +                         MemoryRegion *secure_sysmem)
> > +{
> > +    /*
> > +     * Create one secure and nonsecure flash devices to fill SBSA_FLAS=
H
> > +     * space in the memmap, file passed via -bios goes in the first on=
e.
> > +     */
> > +    hwaddr flashsize =3D vms->memmap[SBSA_FLASH].size / 2;
> > +    hwaddr flashbase =3D vms->memmap[SBSA_FLASH].base;
> > +
> > +    create_one_flash("sbsa-ref.flash0", flashbase, flashsize,
> > +                     bios_name, secure_sysmem);
> > +    create_one_flash("sbsa-ref.flash1", flashbase + flashsize, flashsi=
ze,
> > +                     NULL, sysmem);
>
> static const MemMapEntry base_memmap[] =3D {
>     /* Space up to 0x8000000 is reserved for a boot ROM */
>     [VIRT_FLASH] =3D              {          0, 0x08000000 },
>
Hi Philippe,
Thank you for the long comments.
Some parts of this machine are based on the 'virt' machine, but I use
this flash memory map:
[SBSA_FLASH] =3D              {          0, 0x20000000 },
that are 256M *2 flashes.
Franky I didn't consider the product part number etc, just use the
original design in 'virt' and change the size large enough as I think.

Peter, Ard, do we need more considerations here?

> So you are creating 2 identical flashes of 128MiB/2 =3D 64 MiB each which
> are the biggest flash you can have:
>
> "The P30 family provides density upgrades from 64-Mbit through
> 512-Mbit." On Intel, the 512-Mib case is particular in that it is built
> of 2x 256-Mib on the same die, with a virtual chip enable. It is simpler
> to use a Micron or Numonyx model.
>
> I plan to use a whitelist of supported (and tested...) models, the one
> you use seems the Micron JS28F512P30EF ('E' for 'Symetrically Blocked',
> since the current model doesn't support bottom/top blocks layout), or in
> short: 28F512P30E.
> Ard, is that OK?
>
> Checking EDK2 git history, the driver is part of ArmPlatformPkg,
> imported in commit 1d5d0ae92d9541, based on 'Versatile Express'.
>
> On the Versatile Express and the RealView Emulation Baseboard user
> guides, I only find reference of "64MB of NOR flash" with no specific mod=
el.
>
> Peter, do you have physical access to tell me what flashes are used on
> real hardware? I googled for Linux console boot log but the kernel
> doesn't seem to care about detecting/mapping the flash.
>
> QEMU added the flash to the Versatile board in commit 964c695a54ceda3a,
> with the following description:
>
>     - add support for the 64MB NOR CFI01 flash available at
>     0x34000000 on the versatilepb board
>
> http://infocenter.arm.com/help/index.jsp?topic=3D/com.arm.doc.dui0225d/BB=
AJIHEC.html
>
> However on this link I only see "SSMC Chip Select 1, normally NOR flash
> (During boot remapping, this can be NOR flash, Disk-on-Chip, or static
> expansion memory)". Again, nothing specific (which makes sense, why
> restrict the users to a particuliar family, as long as the pinout matches=
).
>
> The Manufacturer/Device ID used in QEMU (0x0089, 0x0018) correspond to
> the Micron 28F128J3D (128-Mbit, 128 symmetrical blocks of 128-KiB).
> Neither the flash size (64 vs 16) nor the block size (256 vs 128) match.
>
> The safer fix here is to find a CFI01 flash of 256 sectors of 256-KiB
> and update the Manufacturer/Device IDs in QEMU. Luckily this matches the
> 28F512P30E cited previously :)
>
> Regards,
>
> Phil.
>
> > +}
> > +
> > +static void create_secure_ram(SBSAMachineState *vms,
> > +                              MemoryRegion *secure_sysmem)
> > +{
> > +    MemoryRegion *secram =3D g_new(MemoryRegion, 1);
> > +    hwaddr base =3D vms->memmap[SBSA_SECURE_MEM].base;
> > +    hwaddr size =3D vms->memmap[SBSA_SECURE_MEM].size;
> > +
> > +    memory_region_init_ram(secram, NULL, "sbsa-ref.secure-ram", size,
> > +                           &error_fatal);
> > +    memory_region_add_subregion(secure_sysmem, base, secram);
> > +}
> > +
> > +static void create_gic(SBSAMachineState *vms, qemu_irq *pic)
> > +{
> > +    DeviceState *gicdev;
> > +    SysBusDevice *gicbusdev;
> > +    const char *gictype;
> > +    uint32_t redist0_capacity, redist0_count;
> > +    int i;
> > +
> > +    gictype =3D gicv3_class_name();
> > +
> > +    gicdev =3D qdev_create(NULL, gictype);
> > +    qdev_prop_set_uint32(gicdev, "revision", 3);
> > +    qdev_prop_set_uint32(gicdev, "num-cpu", smp_cpus);
> > +    /*
> > +     * Note that the num-irq property counts both internal and externa=
l
> > +     * interrupts; there are always 32 of the former (mandated by GIC =
spec).
> > +     */
> > +    qdev_prop_set_uint32(gicdev, "num-irq", NUM_IRQS + 32);
> > +    qdev_prop_set_bit(gicdev, "has-security-extensions", true);
> > +
> > +    redist0_capacity =3D
> > +                vms->memmap[SBSA_GIC_REDIST].size / GICV3_REDIST_SIZE;
> > +    redist0_count =3D MIN(smp_cpus, redist0_capacity);
> > +
> > +    qdev_prop_set_uint32(gicdev, "len-redist-region-count", 1);
> > +    qdev_prop_set_uint32(gicdev, "redist-region-count[0]", redist0_cou=
nt);
> > +
> > +    qdev_init_nofail(gicdev);
> > +    gicbusdev =3D SYS_BUS_DEVICE(gicdev);
> > +    sysbus_mmio_map(gicbusdev, 0, vms->memmap[SBSA_GIC_DIST].base);
> > +    sysbus_mmio_map(gicbusdev, 1, vms->memmap[SBSA_GIC_REDIST].base);
> > +
> > +    /*
> > +     * Wire the outputs from each CPU's generic timer and the GICv3
> > +     * maintenance interrupt signal to the appropriate GIC PPI inputs,
> > +     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's =
inputs.
> > +     */
> > +    for (i =3D 0; i < smp_cpus; i++) {
> > +        DeviceState *cpudev =3D DEVICE(qemu_get_cpu(i));
> > +        int ppibase =3D NUM_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
> > +        int irq;
> > +        /*
> > +         * Mapping from the output timer irq lines from the CPU to the
> > +         * GIC PPI inputs used for this board.
> > +         */
> > +        const int timer_irq[] =3D {
> > +            [GTIMER_PHYS] =3D ARCH_TIMER_NS_EL1_IRQ,
> > +            [GTIMER_VIRT] =3D ARCH_TIMER_VIRT_IRQ,
> > +            [GTIMER_HYP]  =3D ARCH_TIMER_NS_EL2_IRQ,
> > +            [GTIMER_SEC]  =3D ARCH_TIMER_S_EL1_IRQ,
> > +        };
> > +
> > +        for (irq =3D 0; irq < ARRAY_SIZE(timer_irq); irq++) {
> > +            qdev_connect_gpio_out(cpudev, irq,
> > +                                  qdev_get_gpio_in(gicdev,
> > +                                                   ppibase + timer_irq=
[irq]));
> > +        }
> > +
> > +        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interru=
pt", 0,
> > +                                    qdev_get_gpio_in(gicdev, ppibase
> > +                                                     + ARCH_GIC_MAINT_=
IRQ));
> > +        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
> > +                                    qdev_get_gpio_in(gicdev, ppibase
> > +                                                     + VIRTUAL_PMU_IRQ=
));
> > +
> > +        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_=
CPU_IRQ));
> > +        sysbus_connect_irq(gicbusdev, i + smp_cpus,
> > +                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> > +        sysbus_connect_irq(gicbusdev, i + 2 * smp_cpus,
> > +                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
> > +        sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
> > +                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
> > +    }
> > +
> > +    for (i =3D 0; i < NUM_IRQS; i++) {
> > +        pic[i] =3D qdev_get_gpio_in(gicdev, i);
> > +    }
> > +}
> > +
> > +static void create_uart(const SBSAMachineState *vms, qemu_irq *pic, in=
t uart,
> > +                        MemoryRegion *mem, Chardev *chr)
> > +{
> > +    hwaddr base =3D vms->memmap[uart].base;
> > +    int irq =3D vms->irqmap[uart];
> > +    DeviceState *dev =3D qdev_create(NULL, "pl011");
> > +    SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
> > +
> > +    qdev_prop_set_chr(dev, "chardev", chr);
> > +    qdev_init_nofail(dev);
> > +    memory_region_add_subregion(mem, base,
> > +                                sysbus_mmio_get_region(s, 0));
> > +    sysbus_connect_irq(s, 0, pic[irq]);
> > +}
> > +
> > +static void create_rtc(const SBSAMachineState *vms, qemu_irq *pic)
> > +{
> > +    hwaddr base =3D vms->memmap[SBSA_RTC].base;
> > +    int irq =3D vms->irqmap[SBSA_RTC];
> > +
> > +    sysbus_create_simple("pl031", base, pic[irq]);
> > +}
> > +
> > +static DeviceState *gpio_key_dev;
> > +static void sbsa_ref_powerdown_req(Notifier *n, void *opaque)
> > +{
> > +    /* use gpio Pin 3 for power button event */
> > +    qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
> > +}
> > +
> > +static Notifier sbsa_ref_powerdown_notifier =3D {
> > +    .notify =3D sbsa_ref_powerdown_req
> > +};
> > +
> > +static void create_gpio(const SBSAMachineState *vms, qemu_irq *pic)
> > +{
> > +    DeviceState *pl061_dev;
> > +    hwaddr base =3D vms->memmap[SBSA_GPIO].base;
> > +    int irq =3D vms->irqmap[SBSA_GPIO];
> > +
> > +    pl061_dev =3D sysbus_create_simple("pl061", base, pic[irq]);
> > +
> > +    gpio_key_dev =3D sysbus_create_simple("gpio-key", -1,
> > +                                        qdev_get_gpio_in(pl061_dev, 3)=
);
> > +
> > +    /* connect powerdown request */
> > +    qemu_register_powerdown_notifier(&sbsa_ref_powerdown_notifier);
> > +}
> > +
> > +static void create_ahci(const SBSAMachineState *vms, qemu_irq *pic)
> > +{
> > +    hwaddr base =3D vms->memmap[SBSA_AHCI].base;
> > +    int irq =3D vms->irqmap[SBSA_AHCI];
> > +    DeviceState *dev;
> > +    DriveInfo *hd[NUM_SATA_PORTS];
> > +    SysbusAHCIState *sysahci;
> > +    AHCIState *ahci;
> > +    int i;
> > +
> > +    dev =3D qdev_create(NULL, "sysbus-ahci");
> > +    qdev_prop_set_uint32(dev, "num-ports", NUM_SATA_PORTS);
> > +    qdev_init_nofail(dev);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> > +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irq]);
> > +
> > +    sysahci =3D SYSBUS_AHCI(dev);
> > +    ahci =3D &sysahci->ahci;
> > +    ide_drive_get(hd, ARRAY_SIZE(hd));
> > +    for (i =3D 0; i < ahci->ports; i++) {
> > +        if (hd[i] =3D=3D NULL) {
> > +            continue;
> > +        }
> > +        ide_create_drive(&ahci->dev[i].port, 0, hd[i]);
> > +    }
> > +}
> > +
> > +static void create_ehci(const SBSAMachineState *vms, qemu_irq *pic)
> > +{
> > +    hwaddr base =3D vms->memmap[SBSA_EHCI].base;
> > +    int irq =3D vms->irqmap[SBSA_EHCI];
> > +    USBBus *usb_bus;
> > +
> > +    sysbus_create_simple("platform-ehci-usb", base, pic[irq]);
> > +
> > +    usb_bus =3D usb_bus_find(-1);
> > +    usb_create_simple(usb_bus, "usb-kbd");
> > +    usb_create_simple(usb_bus, "usb-mouse");
> > +}
> > +
> > +static void create_smmu(const SBSAMachineState *vms, qemu_irq *pic,
> > +                        PCIBus *bus)
> > +{
> > +    hwaddr base =3D vms->memmap[SBSA_SMMU].base;
> > +    int irq =3D  vms->irqmap[SBSA_SMMU];
> > +    DeviceState *dev;
> > +    int i;
> > +
> > +    dev =3D qdev_create(NULL, "arm-smmuv3");
> > +
> > +    object_property_set_link(OBJECT(dev), OBJECT(bus), "primary-bus",
> > +                             &error_abort);
> > +    qdev_init_nofail(dev);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> > +    for (i =3D 0; i < NUM_SMMU_IRQS; i++) {
> > +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pic[irq + i]);
> > +    }
> > +}
> > +
> > +static void create_pcie(SBSAMachineState *vms, qemu_irq *pic)
> > +{
> > +    hwaddr base_ecam =3D vms->memmap[SBSA_PCIE_ECAM].base;
> > +    hwaddr size_ecam =3D vms->memmap[SBSA_PCIE_ECAM].size;
> > +    hwaddr base_mmio =3D vms->memmap[SBSA_PCIE_MMIO].base;
> > +    hwaddr size_mmio =3D vms->memmap[SBSA_PCIE_MMIO].size;
> > +    hwaddr base_mmio_high =3D vms->memmap[SBSA_PCIE_MMIO_HIGH].base;
> > +    hwaddr size_mmio_high =3D vms->memmap[SBSA_PCIE_MMIO_HIGH].size;
> > +    hwaddr base_pio =3D vms->memmap[SBSA_PCIE_PIO].base;
> > +    int irq =3D vms->irqmap[SBSA_PCIE];
> > +    MemoryRegion *mmio_alias, *mmio_alias_high, *mmio_reg;
> > +    MemoryRegion *ecam_alias, *ecam_reg;
> > +    DeviceState *dev;
> > +    PCIHostState *pci;
> > +    int i;
> > +
> > +    dev =3D qdev_create(NULL, TYPE_GPEX_HOST);
> > +    qdev_init_nofail(dev);
> > +
> > +    /* Map ECAM space */
> > +    ecam_alias =3D g_new0(MemoryRegion, 1);
> > +    ecam_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> > +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
> > +                             ecam_reg, 0, size_ecam);
> > +    memory_region_add_subregion(get_system_memory(), base_ecam, ecam_a=
lias);
> > +
> > +    /* Map the MMIO space */
> > +    mmio_alias =3D g_new0(MemoryRegion, 1);
> > +    mmio_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> > +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
> > +                             mmio_reg, base_mmio, size_mmio);
> > +    memory_region_add_subregion(get_system_memory(), base_mmio, mmio_a=
lias);
> > +
> > +    /* Map the MMIO_HIGH space */
> > +    mmio_alias_high =3D g_new0(MemoryRegion, 1);
> > +    memory_region_init_alias(mmio_alias_high, OBJECT(dev), "pcie-mmio-=
high",
> > +                             mmio_reg, base_mmio_high, size_mmio_high)=
;
> > +    memory_region_add_subregion(get_system_memory(), base_mmio_high,
> > +                                mmio_alias_high);
> > +
> > +    /* Map IO port space */
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, base_pio);
> > +
> > +    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> > +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pic[irq + i]);
> > +        gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
> > +    }
> > +
> > +    pci =3D PCI_HOST_BRIDGE(dev);
> > +    if (pci->bus) {
> > +        for (i =3D 0; i < nb_nics; i++) {
> > +            NICInfo *nd =3D &nd_table[i];
> > +
> > +            if (!nd->model) {
> > +                nd->model =3D g_strdup("e1000e");
> > +            }
> > +
> > +            pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
> > +        }
> > +    }
> > +
> > +    pci_create_simple(pci->bus, -1, "VGA");
> > +
> > +    create_smmu(vms, pic, pci->bus);
> > +}
> > +
> > +static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_=
size)
> > +{
> > +    const SBSAMachineState *board =3D container_of(binfo, SBSAMachineS=
tate,
> > +                                                 bootinfo);
> > +
> > +    *fdt_size =3D board->fdt_size;
> > +    return board->fdt;
> > +}
> > +
> >  static void sbsa_ref_init(MachineState *machine)
> >  {
> >      SBSAMachineState *vms =3D SBSA_MACHINE(machine);
> > @@ -125,6 +552,7 @@ static void sbsa_ref_init(MachineState *machine)
> >      bool firmware_loaded =3D bios_name || drive_get(IF_PFLASH, 0, 0);
> >      const CPUArchIdList *possible_cpus;
> >      int n, sbsa_max_cpus;
> > +    qemu_irq pic[NUM_IRQS];
> >
> >      if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a57"))) {
> >          error_report("sbsa-ref: CPU type other than the built-in "
> > @@ -209,11 +637,34 @@ static void sbsa_ref_init(MachineState *machine)
> >                                           machine->ram_size);
> >      memory_region_add_subregion(sysmem, vms->memmap[SBSA_MEM].base, ra=
m);
> >
> > +    create_fdt(vms);
> > +
> > +    create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
> > +
> > +    create_secure_ram(vms, secure_sysmem);
> > +
> > +    create_gic(vms, pic);
> > +
> > +    create_uart(vms, pic, SBSA_UART, sysmem, serial_hd(0));
> > +    create_uart(vms, pic, SBSA_SECURE_UART, secure_sysmem, serial_hd(1=
));
> > +    create_uart(vms, pic, SBSA_SECURE_UART_MM, secure_sysmem, serial_h=
d(2));
> > +
> > +    create_rtc(vms, pic);
> > +
> > +    create_gpio(vms, pic);
> > +
> > +    create_ahci(vms, pic);
> > +
> > +    create_ehci(vms, pic);
> > +
> > +    create_pcie(vms, pic);
> > +
> >      vms->bootinfo.ram_size =3D machine->ram_size;
> >      vms->bootinfo.kernel_filename =3D machine->kernel_filename;
> >      vms->bootinfo.nb_cpus =3D smp_cpus;
> >      vms->bootinfo.board_id =3D -1;
> >      vms->bootinfo.loader_start =3D vms->memmap[SBSA_MEM].base;
> > +    vms->bootinfo.get_dtb =3D sbsa_ref_dtb;
> >      vms->bootinfo.firmware_loaded =3D firmware_loaded;
> >      arm_load_kernel(ARM_CPU(first_cpu), &vms->bootinfo);
> >  }
> >

