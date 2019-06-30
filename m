Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888C7C5B57E
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 09:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3915220645
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 09:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DGG6RmA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3915220645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhW77-0000A0-Do
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 05:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38660)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hongbo.zhang@linaro.org>) id 1hhW6H-00082H-PQ
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 05:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hongbo.zhang@linaro.org>) id 1hhW6F-0008QU-56
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 05:26:21 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:38712)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
 id 1hhW6E-0008P1-Sw
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 05:26:19 -0400
Received: by mail-io1-xd44.google.com with SMTP id j6so21972871ioa.5
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 02:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lsGajST4+T4CMV6duYmYlyNdzia/he5gJUUz78aVHn4=;
 b=DGG6RmA7uY0U7v3E3TuC7rLrINbh7MytHk3iqbc7Pu8V+OcvyMa1oLvq/n+aQWu00+
 98Ef7JglSo7aEPzFvc2Y6RbqRjihUm/PdtF9r3uAXSzvWjYAvdps/p5JjjF2CorUCZz5
 wNw9EADpd5iAyuwAJ9XKubeMPASar2vk/FipkDV70H48C7fctwoFryOiBE5GNKf9oBbK
 fyGJshKOTcqE+K2WiE9l9nI+6XmUb32zPbEYJMiQJwBV7/oBYTtWFCbmdXrrAtiov3tG
 La5zmVFBzXIW278izh1yL7BFH6LFgqDSlw1C/LxcqnwyMjmGDmFobXHOAfFBU7tEJukw
 DlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lsGajST4+T4CMV6duYmYlyNdzia/he5gJUUz78aVHn4=;
 b=eXjx7uahlW2ee1+kHyNbmQxCXniVEvj05ys3M7bKF+lJ6Ldx0RcXX6ZssgSyIhvJOJ
 2C5Q0yBBljvUpYe1bNlT5vHW5c4d+BdvmSU9rG5rPhZlyMje+93LvCUaF2ZPfz8U1i7h
 VaL2pRbB+7iWqVZkfuoOq6abJJRNy0ATCCqBg9XWPOhk+2M0A5AnwWmtJi1Z68LEceWj
 IpfD5xOyU6ixKBM74rDyDLqNF5FlG/K6eKMDvmTJ0cUDjfAc48M2c3gffMNCNT8r97Uc
 dkiQYZcw+DNn3JSHfJqKv6mbHyt0hYGDki0qng1vZtdL21yKVdA5Z0f3IG356JaV+rNe
 zBMQ==
X-Gm-Message-State: APjAAAVmIJqlkGaWLKkwr4iY885FpwY++WYKX0pH1svMhezCWxcMgGmK
 HFLuxeYNHGJg8SKlXUPIRPH9Brz9+3LoQs8bCVRlJQ==
X-Google-Smtp-Source: APXvYqxnv0x4mJeaBhp8dkIKcNy4jL3aIIj2EyF7N6cWjP0LTSfRM1YYYOWKxVkb6XRoWnh4NCauyOuMNnK9uq0Pzmw=
X-Received: by 2002:a02:662f:: with SMTP id k47mr21973314jac.4.1561886777467; 
 Sun, 30 Jun 2019 02:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <1561257655-25907-1-git-send-email-hongbo.zhang@linaro.org>
 <1561257655-25907-3-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1561257655-25907-3-git-send-email-hongbo.zhang@linaro.org>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Sun, 30 Jun 2019 17:26:08 +0800
Message-ID: <CAHmQWvAK-jYguTmnh=+L=kLL8hdXsuGGkkQKXa=dNgHyiZ1KVA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Subject: Re: [Qemu-devel] [PATCH v8 2/2] hw/arm: Add arm SBSA reference
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
Cc: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 23 Jun 2019 at 10:42, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>
> Following the previous patch, this patch adds peripheral devices to the
> newly introduced SBSA-ref machine.
>
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> ---
>  hw/arm/sbsa-ref.c | 523 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 517 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index e68751e..3b2b9cb 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -18,21 +18,41 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu-common.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu/units.h"
> +#include "sysemu/device_tree.h"
>  #include "sysemu/numa.h"
>  #include "sysemu/sysemu.h"
>  #include "exec/address-spaces.h"
>  #include "exec/hwaddr.h"
>  #include "kvm_arm.h"
>  #include "hw/arm/boot.h"
> +#include "hw/block/flash.h"
>  #include "hw/boards.h"
> +#include "hw/ide/internal.h"
> +#include "hw/ide/ahci_internal.h"
>  #include "hw/intc/arm_gicv3_common.h"
> +#include "hw/loader.h"
> +#include "hw/pci-host/gpex.h"
> +#include "hw/usb.h"
> +#include "net/net.h"
>
>  #define RAMLIMIT_GB 8192
>  #define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
>
> +#define NUM_IRQS        256
> +#define NUM_SMMU_IRQS   4
> +#define NUM_SATA_PORTS  6
> +
> +#define VIRTUAL_PMU_IRQ        7
> +#define ARCH_GIC_MAINT_IRQ     9
> +#define ARCH_TIMER_VIRT_IRQ    11
> +#define ARCH_TIMER_S_EL1_IRQ   13
> +#define ARCH_TIMER_NS_EL1_IRQ  14
> +#define ARCH_TIMER_NS_EL2_IRQ  10
> +
>  enum {
>      SBSA_FLASH,
>      SBSA_MEM,
> @@ -67,6 +87,7 @@ typedef struct {
>      void *fdt;
>      int fdt_size;
>      int psci_conduit;
> +    PFlashCFI01 *flash[2];
>  } SBSAMachineState;
>
>  #define TYPE_SBSA_MACHINE   MACHINE_TYPE_NAME("sbsa-ref")
> @@ -113,6 +134,455 @@ static const int sbsa_ref_irqmap[] = {
>      [SBSA_EHCI] = 11,
>  };
>
> +/*
> + * Firmware on this machine only uses ACPI table to load OS, these limited
> + * device tree nodes are just to let firmware know the info which varies from
> + * command line parameters, so it is not necessary to be fully compatible
> + * with the kernel CPU and NUMA binding rules.
> + */
> +static void create_fdt(SBSAMachineState *sms)
> +{
> +    void *fdt = create_device_tree(&sms->fdt_size);
> +    const MachineState *ms = MACHINE(sms);
> +    int cpu;
> +
> +    if (!fdt) {
> +        error_report("create_device_tree() failed");
> +        exit(1);
> +    }
> +
> +    sms->fdt = fdt;
> +
> +    qemu_fdt_setprop_string(fdt, "/", "compatible", "linux,sbsa-ref");
> +    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
> +    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
> +
> +    if (have_numa_distance) {
> +        int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
> +        uint32_t *matrix = g_malloc0(size);
> +        int idx, i, j;
> +
> +        for (i = 0; i < nb_numa_nodes; i++) {
> +            for (j = 0; j < nb_numa_nodes; j++) {
> +                idx = (i * nb_numa_nodes + j) * 3;
> +                matrix[idx + 0] = cpu_to_be32(i);
> +                matrix[idx + 1] = cpu_to_be32(j);
> +                matrix[idx + 2] = cpu_to_be32(numa_info[i].distance[j]);
> +            }
> +        }
> +
> +        qemu_fdt_add_subnode(fdt, "/distance-map");
> +        qemu_fdt_setprop(fdt, "/distance-map", "distance-matrix",
> +                         matrix, size);
> +        g_free(matrix);
> +    }
> +
> +    qemu_fdt_add_subnode(sms->fdt, "/cpus");
> +
> +    for (cpu = sms->smp_cpus - 1; cpu >= 0; cpu--) {
> +        char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
> +        ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
> +        CPUState *cs = CPU(armcpu);
> +
> +        qemu_fdt_add_subnode(sms->fdt, nodename);
> +
> +        if (ms->possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
> +            qemu_fdt_setprop_cell(sms->fdt, nodename, "numa-node-id",
> +                ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
> +        }
> +
> +        g_free(nodename);
> +    }
> +}
> +
> +#define SBSA_FLASH_SECTOR_SIZE (256 * KiB)
> +
> +static PFlashCFI01 *sbsa_flash_create1(SBSAMachineState *sms,
> +                                        const char *name,
> +                                        const char *alias_prop_name)
> +{
> +    /*
> +     * Create a single flash device.  We use the same parameters as
> +     * the flash devices on the Versatile Express board.
> +     */
> +    DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI01);
> +
> +    qdev_prop_set_uint64(dev, "sector-length", SBSA_FLASH_SECTOR_SIZE);
> +    qdev_prop_set_uint8(dev, "width", 4);
> +    qdev_prop_set_uint8(dev, "device-width", 2);
> +    qdev_prop_set_bit(dev, "big-endian", false);
> +    qdev_prop_set_uint16(dev, "id0", 0x89);
> +    qdev_prop_set_uint16(dev, "id1", 0x18);
> +    qdev_prop_set_uint16(dev, "id2", 0x00);
> +    qdev_prop_set_uint16(dev, "id3", 0x00);
> +    qdev_prop_set_string(dev, "name", name);
> +    object_property_add_child(OBJECT(sms), name, OBJECT(dev),
> +                              &error_abort);
> +    object_property_add_alias(OBJECT(sms), alias_prop_name,
> +                              OBJECT(dev), "drive", &error_abort);
> +    return PFLASH_CFI01(dev);
> +}
> +
> +static void sbsa_flash_create(SBSAMachineState *sms)
> +{
> +    sms->flash[0] = sbsa_flash_create1(sms, "sbsa.flash0", "pflash0");
> +    sms->flash[1] = sbsa_flash_create1(sms, "sbsa.flash1", "pflash1");
> +}
> +
> +static void sbsa_flash_map1(PFlashCFI01 *flash,
> +                            hwaddr base, hwaddr size,
> +                            MemoryRegion *sysmem)
> +{
> +    DeviceState *dev = DEVICE(flash);
> +
> +    assert(size % SBSA_FLASH_SECTOR_SIZE == 0);
> +    assert(size / SBSA_FLASH_SECTOR_SIZE <= UINT32_MAX);
> +    qdev_prop_set_uint32(dev, "num-blocks", size / SBSA_FLASH_SECTOR_SIZE);
> +    qdev_init_nofail(dev);
> +
> +    memory_region_add_subregion(sysmem, base,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
> +                                                       0));
> +}
> +
> +static void sbsa_flash_map(SBSAMachineState *sms,
> +                           MemoryRegion *sysmem,
> +                           MemoryRegion *secure_sysmem)
> +{
> +    /*
> +     * Map two flash devices to fill the SBSA_FLASH space in the memmap.
> +     * sysmem is the system memory space. secure_sysmem is the secure view
> +     * of the system, and the first flash device should be made visible only
> +     * there. The second flash device is visible to both secure and nonsecure.
> +     * If sysmem == secure_sysmem this means there is no separate Secure
> +     * address space and both flash devices are generally visible.
> +     */
> +    hwaddr flashsize = sbsa_ref_memmap[SBSA_FLASH].size / 2;
> +    hwaddr flashbase = sbsa_ref_memmap[SBSA_FLASH].base;
> +
> +    sbsa_flash_map1(sms->flash[0], flashbase, flashsize,
> +                    secure_sysmem);
> +    sbsa_flash_map1(sms->flash[1], flashbase + flashsize, flashsize,
> +                    sysmem);
> +}
> +
> +static bool sbsa_firmware_init(SBSAMachineState *sms,
> +                               MemoryRegion *sysmem,
> +                               MemoryRegion *secure_sysmem)
> +{
> +    int i;
> +    BlockBackend *pflash_blk0;
> +
> +    /* Map legacy -drive if=pflash to machine properties */
> +    for (i = 0; i < ARRAY_SIZE(sms->flash); i++) {
> +        pflash_cfi01_legacy_drive(sms->flash[i],
> +                                  drive_get(IF_PFLASH, 0, i));
> +    }
> +
> +    sbsa_flash_map(sms, sysmem, secure_sysmem);
> +
> +    pflash_blk0 = pflash_cfi01_get_blk(sms->flash[0]);
> +
> +    if (bios_name) {
> +        char *fname;
> +        MemoryRegion *mr;
> +        int image_size;
> +
> +        if (pflash_blk0) {
> +            error_report("The contents of the first flash device may be "
> +                         "specified with -bios or with -drive if=pflash... "
> +                         "but you cannot use both options at once");
> +            exit(1);
> +        }
> +
> +        /* Fall back to -bios */
> +
> +        fname = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +        if (!fname) {
> +            error_report("Could not find ROM image '%s'", bios_name);
> +            exit(1);
> +        }
> +        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(sms->flash[0]), 0);
> +        image_size = load_image_mr(fname, mr);
> +        g_free(fname);
> +        if (image_size < 0) {
> +            error_report("Could not load ROM image '%s'", bios_name);
> +            exit(1);
> +        }
> +    }
> +
> +    return pflash_blk0 || bios_name;
> +}
> +
> +static void create_secure_ram(SBSAMachineState *sms,
> +                              MemoryRegion *secure_sysmem)
> +{
> +    MemoryRegion *secram = g_new(MemoryRegion, 1);
> +    hwaddr base = sbsa_ref_memmap[SBSA_SECURE_MEM].base;
> +    hwaddr size = sbsa_ref_memmap[SBSA_SECURE_MEM].size;
> +
> +    memory_region_init_ram(secram, NULL, "sbsa-ref.secure-ram", size,
> +                           &error_fatal);
> +    memory_region_add_subregion(secure_sysmem, base, secram);
> +}
> +
> +static void create_gic(SBSAMachineState *sms, qemu_irq *pic)
> +{
> +    DeviceState *gicdev;
> +    SysBusDevice *gicbusdev;
> +    const char *gictype;
> +    uint32_t redist0_capacity, redist0_count;
> +    int i;
> +
> +    gictype = gicv3_class_name();
> +
> +    gicdev = qdev_create(NULL, gictype);
> +    qdev_prop_set_uint32(gicdev, "revision", 3);
> +    qdev_prop_set_uint32(gicdev, "num-cpu", smp_cpus);
> +    /*
> +     * Note that the num-irq property counts both internal and external
> +     * interrupts; there are always 32 of the former (mandated by GIC spec).
> +     */
> +    qdev_prop_set_uint32(gicdev, "num-irq", NUM_IRQS + 32);
> +    qdev_prop_set_bit(gicdev, "has-security-extensions", true);
> +
> +    redist0_capacity =
> +                sbsa_ref_memmap[SBSA_GIC_REDIST].size / GICV3_REDIST_SIZE;
> +    redist0_count = MIN(smp_cpus, redist0_capacity);
> +
> +    qdev_prop_set_uint32(gicdev, "len-redist-region-count", 1);
> +    qdev_prop_set_uint32(gicdev, "redist-region-count[0]", redist0_count);
> +
> +    qdev_init_nofail(gicdev);
> +    gicbusdev = SYS_BUS_DEVICE(gicdev);
> +    sysbus_mmio_map(gicbusdev, 0, sbsa_ref_memmap[SBSA_GIC_DIST].base);
> +    sysbus_mmio_map(gicbusdev, 1, sbsa_ref_memmap[SBSA_GIC_REDIST].base);
> +
> +    /*
> +     * Wire the outputs from each CPU's generic timer and the GICv3
> +     * maintenance interrupt signal to the appropriate GIC PPI inputs,
> +     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
> +     */
> +    for (i = 0; i < smp_cpus; i++) {
> +        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
> +        int ppibase = NUM_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
> +        int irq;
> +        /*
> +         * Mapping from the output timer irq lines from the CPU to the
> +         * GIC PPI inputs used for this board.
> +         */
> +        const int timer_irq[] = {
> +            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
> +            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
> +            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
> +            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
> +        };
> +
> +        for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
> +            qdev_connect_gpio_out(cpudev, irq,
> +                                  qdev_get_gpio_in(gicdev,
> +                                                   ppibase + timer_irq[irq]));
> +        }
> +
> +        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt", 0,
> +                                    qdev_get_gpio_in(gicdev, ppibase
> +                                                     + ARCH_GIC_MAINT_IRQ));
> +        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
> +                                    qdev_get_gpio_in(gicdev, ppibase
> +                                                     + VIRTUAL_PMU_IRQ));
> +
> +        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> +        sysbus_connect_irq(gicbusdev, i + smp_cpus,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> +        sysbus_connect_irq(gicbusdev, i + 2 * smp_cpus,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
> +        sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
> +    }
> +
> +    for (i = 0; i < NUM_IRQS; i++) {
> +        pic[i] = qdev_get_gpio_in(gicdev, i);
> +    }
> +}
> +
> +static void create_uart(const SBSAMachineState *sms, qemu_irq *pic, int uart,
> +                        MemoryRegion *mem, Chardev *chr)
> +{
> +    hwaddr base = sbsa_ref_memmap[uart].base;
> +    int irq = sbsa_ref_irqmap[uart];
> +    DeviceState *dev = qdev_create(NULL, "pl011");
> +    SysBusDevice *s = SYS_BUS_DEVICE(dev);
> +
> +    qdev_prop_set_chr(dev, "chardev", chr);
> +    qdev_init_nofail(dev);
> +    memory_region_add_subregion(mem, base,
> +                                sysbus_mmio_get_region(s, 0));
> +    sysbus_connect_irq(s, 0, pic[irq]);
> +}
> +
> +static void create_rtc(const SBSAMachineState *sms, qemu_irq *pic)
> +{
> +    hwaddr base = sbsa_ref_memmap[SBSA_RTC].base;
> +    int irq = sbsa_ref_irqmap[SBSA_RTC];
> +
> +    sysbus_create_simple("pl031", base, pic[irq]);
> +}
> +
> +static DeviceState *gpio_key_dev;
> +static void sbsa_ref_powerdown_req(Notifier *n, void *opaque)
> +{
> +    /* use gpio Pin 3 for power button event */
> +    qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
> +}
> +
> +static Notifier sbsa_ref_powerdown_notifier = {
> +    .notify = sbsa_ref_powerdown_req
> +};
> +
> +static void create_gpio(const SBSAMachineState *sms, qemu_irq *pic)
> +{
> +    DeviceState *pl061_dev;
> +    hwaddr base = sbsa_ref_memmap[SBSA_GPIO].base;
> +    int irq = sbsa_ref_irqmap[SBSA_GPIO];
> +
> +    pl061_dev = sysbus_create_simple("pl061", base, pic[irq]);
> +
> +    gpio_key_dev = sysbus_create_simple("gpio-key", -1,
> +                                        qdev_get_gpio_in(pl061_dev, 3));
> +
> +    /* connect powerdown request */
> +    qemu_register_powerdown_notifier(&sbsa_ref_powerdown_notifier);
> +}
> +
> +static void create_ahci(const SBSAMachineState *sms, qemu_irq *pic)
> +{
> +    hwaddr base = sbsa_ref_memmap[SBSA_AHCI].base;
> +    int irq = sbsa_ref_irqmap[SBSA_AHCI];
> +    DeviceState *dev;
> +    DriveInfo *hd[NUM_SATA_PORTS];
> +    SysbusAHCIState *sysahci;
> +    AHCIState *ahci;
> +    int i;
> +
> +    dev = qdev_create(NULL, "sysbus-ahci");
> +    qdev_prop_set_uint32(dev, "num-ports", NUM_SATA_PORTS);
> +    qdev_init_nofail(dev);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irq]);
> +
> +    sysahci = SYSBUS_AHCI(dev);
> +    ahci = &sysahci->ahci;
> +    ide_drive_get(hd, ARRAY_SIZE(hd));
> +    for (i = 0; i < ahci->ports; i++) {
> +        if (hd[i] == NULL) {
> +            continue;
> +        }
> +        ide_create_drive(&ahci->dev[i].port, 0, hd[i]);
> +    }
> +}
> +
> +static void create_ehci(const SBSAMachineState *sms, qemu_irq *pic)
> +{
> +    hwaddr base = sbsa_ref_memmap[SBSA_EHCI].base;
> +    int irq = sbsa_ref_irqmap[SBSA_EHCI];
> +
> +    sysbus_create_simple("platform-ehci-usb", base, pic[irq]);
> +}
> +
> +static void create_smmu(const SBSAMachineState *sms, qemu_irq *pic,
> +                        PCIBus *bus)
> +{
> +    hwaddr base = sbsa_ref_memmap[SBSA_SMMU].base;
> +    int irq =  sbsa_ref_irqmap[SBSA_SMMU];
> +    DeviceState *dev;
> +    int i;
> +
> +    dev = qdev_create(NULL, "arm-smmuv3");
> +
> +    object_property_set_link(OBJECT(dev), OBJECT(bus), "primary-bus",
> +                             &error_abort);
> +    qdev_init_nofail(dev);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> +    for (i = 0; i < NUM_SMMU_IRQS; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pic[irq + i]);
> +    }
> +}
> +
> +static void create_pcie(SBSAMachineState *sms, qemu_irq *pic)
> +{
> +    hwaddr base_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
> +    hwaddr size_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].size;
> +    hwaddr base_mmio = sbsa_ref_memmap[SBSA_PCIE_MMIO].base;
> +    hwaddr size_mmio = sbsa_ref_memmap[SBSA_PCIE_MMIO].size;
> +    hwaddr base_mmio_high = sbsa_ref_memmap[SBSA_PCIE_MMIO_HIGH].base;
> +    hwaddr size_mmio_high = sbsa_ref_memmap[SBSA_PCIE_MMIO_HIGH].size;
> +    hwaddr base_pio = sbsa_ref_memmap[SBSA_PCIE_PIO].base;
> +    int irq = sbsa_ref_irqmap[SBSA_PCIE];
> +    MemoryRegion *mmio_alias, *mmio_alias_high, *mmio_reg;
> +    MemoryRegion *ecam_alias, *ecam_reg;
> +    DeviceState *dev;
> +    PCIHostState *pci;
> +    int i;
> +
> +    dev = qdev_create(NULL, TYPE_GPEX_HOST);
> +    qdev_init_nofail(dev);
> +
> +    /* Map ECAM space */
> +    ecam_alias = g_new0(MemoryRegion, 1);
> +    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
> +                             ecam_reg, 0, size_ecam);
> +    memory_region_add_subregion(get_system_memory(), base_ecam, ecam_alias);
> +
> +    /* Map the MMIO space */
> +    mmio_alias = g_new0(MemoryRegion, 1);
> +    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
> +                             mmio_reg, base_mmio, size_mmio);
> +    memory_region_add_subregion(get_system_memory(), base_mmio, mmio_alias);
> +
> +    /* Map the MMIO_HIGH space */
> +    mmio_alias_high = g_new0(MemoryRegion, 1);
> +    memory_region_init_alias(mmio_alias_high, OBJECT(dev), "pcie-mmio-high",
> +                             mmio_reg, base_mmio_high, size_mmio_high);
> +    memory_region_add_subregion(get_system_memory(), base_mmio_high,
> +                                mmio_alias_high);
> +
> +    /* Map IO port space */
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, base_pio);
> +
> +    for (i = 0; i < GPEX_NUM_IRQS; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pic[irq + i]);
> +        gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
> +    }
> +
> +    pci = PCI_HOST_BRIDGE(dev);
> +    if (pci->bus) {
> +        for (i = 0; i < nb_nics; i++) {
> +            NICInfo *nd = &nd_table[i];
> +
> +            if (!nd->model) {
> +                nd->model = g_strdup("e1000e");
> +            }
> +
> +            pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
> +        }
> +    }
> +
> +    pci_create_simple(pci->bus, -1, "VGA");
> +
> +    create_smmu(sms, pic, pci->bus);
> +}
> +
> +static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
> +{
> +    const SBSAMachineState *board = container_of(binfo, SBSAMachineState,
> +                                                 bootinfo);
> +
> +    *fdt_size = board->fdt_size;
> +    return board->fdt;
> +}
> +
>  static void sbsa_ref_init(MachineState *machine)
>  {
>      SBSAMachineState *sms = SBSA_MACHINE(machine);
> @@ -120,9 +590,10 @@ static void sbsa_ref_init(MachineState *machine)
>      MemoryRegion *sysmem = get_system_memory();
>      MemoryRegion *secure_sysmem = NULL;
>      MemoryRegion *ram = g_new(MemoryRegion, 1);
> -    bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
> +    bool firmware_loaded;
>      const CPUArchIdList *possible_cpus;
>      int n, sbsa_max_cpus;
> +    qemu_irq pic[NUM_IRQS];
>
>      if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a57"))) {
>          error_report("sbsa-ref: CPU type other than the built-in "
> @@ -135,6 +606,20 @@ static void sbsa_ref_init(MachineState *machine)
>          exit(1);
>      }
>
> +    /*
> +     * The Secure view of the world is the same as the NonSecure,
> +     * but with a few extra devices. Create it as a container region
> +     * containing the system memory at low priority; any secure-only
> +     * devices go in at higher priority and take precedence.
> +     */
> +    secure_sysmem = g_new(MemoryRegion, 1);
> +    memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
> +                       UINT64_MAX);
> +    memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
> +
> +    firmware_loaded = sbsa_firmware_init(sms, sysmem,
> +                                         secure_sysmem ?: sysmem);
> +
>      if (machine->kernel_filename && firmware_loaded) {
>          error_report("sbsa-ref: No fw_cfg device on this machine, "
>                       "so -kernel option is not supported when firmware loaded, "
> @@ -164,11 +649,6 @@ static void sbsa_ref_init(MachineState *machine)
>          exit(1);
>      }
>
> -    secure_sysmem = g_new(MemoryRegion, 1);
> -    memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
> -                       UINT64_MAX);
> -    memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
> -
Sorry about the carelessness, these above lines of removing codes
should not be exist, eg these lines should be not in patch 1.
(this is caused by I changed to the new flash creating codes and
didn't check thoughly at last)
I have to send another iteration to clean this up :(


>      possible_cpus = mc->possible_cpu_arch_ids(machine);
>      for (n = 0; n < possible_cpus->len; n++) {
>          Object *cpuobj;
> @@ -208,11 +688,33 @@ static void sbsa_ref_init(MachineState *machine)
>                                           machine->ram_size);
>      memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_MEM].base, ram);
>
> +    create_fdt(sms);
> +
> +    create_secure_ram(sms, secure_sysmem);
> +
> +    create_gic(sms, pic);
> +
> +    create_uart(sms, pic, SBSA_UART, sysmem, serial_hd(0));
> +    create_uart(sms, pic, SBSA_SECURE_UART, secure_sysmem, serial_hd(1));
> +    /* Second secure UART for RAS and MM from EL0 */
> +    create_uart(sms, pic, SBSA_SECURE_UART_MM, secure_sysmem, serial_hd(2));
> +
> +    create_rtc(sms, pic);
> +
> +    create_gpio(sms, pic);
> +
> +    create_ahci(sms, pic);
> +
> +    create_ehci(sms, pic);
> +
> +    create_pcie(sms, pic);
> +
>      sms->bootinfo.ram_size = machine->ram_size;
>      sms->bootinfo.kernel_filename = machine->kernel_filename;
>      sms->bootinfo.nb_cpus = smp_cpus;
>      sms->bootinfo.board_id = -1;
>      sms->bootinfo.loader_start = sbsa_ref_memmap[SBSA_MEM].base;
> +    sms->bootinfo.get_dtb = sbsa_ref_dtb;
>      sms->bootinfo.firmware_loaded = firmware_loaded;
>      arm_load_kernel(ARM_CPU(first_cpu), &sms->bootinfo);
>  }
> @@ -262,6 +764,13 @@ sbsa_ref_get_default_cpu_node_id(const MachineState *ms, int idx)
>      return idx % nb_numa_nodes;
>  }
>
> +static void sbsa_ref_instance_init(Object *obj)
> +{
> +    SBSAMachineState *sms = SBSA_MACHINE(obj);
> +
> +    sbsa_flash_create(sms);
> +}
> +
>  static void sbsa_ref_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> @@ -284,6 +793,8 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
>  static const TypeInfo sbsa_ref_info = {
>      .name          = TYPE_SBSA_MACHINE,
>      .parent        = TYPE_MACHINE,
> +    .instance_size = sizeof(SBSAMachineState),
> +    .instance_init = sbsa_ref_instance_init,
>      .class_init    = sbsa_ref_class_init,
>  };
>
> --
> 2.7.4
>

