Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F560C4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291A92089F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he53EnAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291A92089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7NCX-0006ZT-Po
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 13:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i7NBZ-0005rT-F7
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i7NBX-0006kZ-B0
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:10:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42807)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i7NBS-0006i9-OT; Mon, 09 Sep 2019 13:10:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id q14so14744312wrm.9;
 Mon, 09 Sep 2019 10:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RbFEs5liS3xpA/I/5vYGx/4wqIIpl4WOUSrBeO8pQRY=;
 b=he53EnAoCZTqNloRK3Ogwu9xdT8agaWhD6c9vMSVhJdcCb0DWO41ATZWpyAnGfLQ9j
 CQpUCkujLA6/8wEc0TZuPDug0+UBnJmY0Mb8KnHTUzA1LLL947zsg8SjQBdB7msCoV6E
 H1qVI3xyxEgeTQpy+YEcmlNGR3WXwuvUjk5Q84e9vFzojToYzemRbcpBudA31G4YIgDv
 gmHCkk/6/Ec8XXduxM9o2U8T/iUvDoYCSX+S8SE1Q2WhBC+M6sW5zq5iaLm9myzrLYYF
 0AJZmcySxZdg++acrglS/5cAQlL1u5gBKQUkh7XENbsJbEsY6y3guT0waPAfrvs0yN59
 WipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=RbFEs5liS3xpA/I/5vYGx/4wqIIpl4WOUSrBeO8pQRY=;
 b=GoypOH9VHiS0QU2inicMjYRfL3TbTeRWDfvfnK1dpQMfRLWOod6ZFNS0UQZ6c3NM9V
 KaCfzt0VDeP+OYgR4QTsjXwnnd0poGZqhT1MlosE2xJmov2Hd4ZphxhxgEHV7l02JV7R
 wS3YCj+7XjBzwoXt08NuFboo5eT0bCNDsjNR28ppXGIhPCDW8YaauTFHUTc/u1a0500y
 g7ECb4WGEVQNm+KjsuKcFXWIIn4MhPt5pFJ1zIR2yPCgziaypTCyLtI5ypltxPBhV24+
 GHe46xRR5X5qNN52b65tutIm98ABOoolb23tz37hUHrseakcFRD6ozZhvxeW+K7xnTS4
 kswA==
X-Gm-Message-State: APjAAAUWdDYnUJEh+j4yB12pmiST7PWRodZn5qLg/bFD5MwjZ9xRL9C5
 dk1C2PjjScrmre1/I0Rp+N8=
X-Google-Smtp-Source: APXvYqz46LRWVSAa9xArrW9doabhByEqUOyLQU3sq2cdY2v8RFaJGB4Cva3vV3vu2T/+WVM2B37Lug==
X-Received: by 2002:a05:6000:1632:: with SMTP id
 v18mr21548287wrb.61.1568049032395; 
 Mon, 09 Sep 2019 10:10:32 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id z25sm224746wmk.0.2019.09.09.10.10.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2019 10:10:31 -0700 (PDT)
To: Luc Michel <luc.michel@greensocs.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-devel@nongnu.org,
 Pekka Enberg <penberg@iki.fi>, =?UTF-8?Q?Zolt=c3=a1n_Baldaszti?=
 <bztemail@gmail.com>
References: <20190904171315.8354-1-f4bug@amsat.org>
 <20190904171315.8354-13-f4bug@amsat.org>
 <67b8cffa-23ae-35d3-1a74-78bfccfdcb8c@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <f15499e7-f950-c6b4-3718-6aa99d632b1a@amsat.org>
Date: Mon, 9 Sep 2019 19:10:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <67b8cffa-23ae-35d3-1a74-78bfccfdcb8c@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [Qemu-arm] [RFC PATCH 12/14] hw/arm/bcm2836: Add
 the BCM2838 which uses a GICv2
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
 Laurent Bonnans <laurent.bonnans@here.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Luc,

On 9/5/19 10:41 AM, Luc Michel wrote:
> On 9/4/19 7:13 PM, Philippe Mathieu-Daudé wrote:
>> The BCM2838 is improvement of the BCM2837:
>> - Cortex-A72 instead of the A53
>> - peripheral block and local soc controller are mapped differently,
>> - GICv2
>> - PCIe block
>> - exhanced MMU to address over 4GiB of SDRAM
>>
>> See https://www.raspberrypi.org/forums/viewtopic.php?t=244479&start=25
>> and https://patchwork.kernel.org/patch/11053097/
>>
>> This patch starts mapping the GICv2 but interrupt lines are NOT
>> wired (yet).
>>
>> This is enough to start running the Ubuntu kernel8.img from [1].
>>
>> Extract the kernel with:
>>
>>    $ mkdir bootpart
>>    $ guestfish \
>>        --ro \
>>        -a ubuntu-18.04.3-preinstalled-server-arm64+raspi4.img \
>>        -m /dev/sda1
>>    Welcome to guestfish, the guest filesystem shell for
>>    editing virtual machine filesystems and disk images.
>>
>>    ><fs> ls /
>>    COPYING.linux
>>    LICENCE.broadcom
>>    System.map
>>    armstub8-gic.bin
>>    bcm2710-rpi-3-b-plus.dtb
>>    bcm2710-rpi-3-b.dtb
>>    bcm2710-rpi-cm3.dtb
>>    bcm2711-rpi-4-b.dtb
>>    bcm2837-rpi-3-b-plus.dtb
>>    bcm2837-rpi-3-b.dtb
>>    cmdline.txt
>>    config.txt
>>    fixup4.dat
>>    fixup4cd.dat
>>    fixup4db.dat
>>    fixup4x.dat
>>    kernel8.img
>>    overlays
>>    start4.elf
>>    start4cd.elf
>>    start4db.elf
>>    start4x.elf
>>    ><fs> copy-out / bootpart/
>>    ><fs> q
>>
>> Then some progress can be noticed running:
>>
>>    $ qemu-system-aarch64 -d unimp,guest_errors,int,in_asm \
>>        -M raspi4 \
>>        -kernel bootpart/kernel8.img \
>>        -dtb bootpart/bcm2711-rpi-4-b.dtb \
>>        -initrd bootpart/boot/initrd.img \
>>        -append \
>>           "earlycon=pl011,0xfe201000 console=ttyAMA0 console=tty1 loglevel=8"
>>
>> Not very interesting, but it runs until configuring the GIC.
>> (remove 'in_asm' if too verbose).
>>
>> TODO:
>>
>> - wire IRQs to the GIC :)
>>
>> - map the SPI bootrom from [3] (boot sequence: [4])
>>
>> - per [2] we could try booting without using the GIC, adding "enable_gic=0"
>>    in config.txt. this variable is parsed by the firmware:
>>
>>    $ fgrep -r enable_gic bootpart
>>    Binary file bootpart/start4x.elf matches
>>    Binary file bootpart/start4.elf matches
>>    Binary file bootpart/start4db.elf matches
>>    Binary file bootpart/start4cd.elf matches
>>    bootpart/config.txt:enable_gic=1
>>
>>    the stub [5] doesn't seem to check a register for it.
>>    maybe it falls back to kernel7l?
>>
>> - decompile start4.elf to check how 'enable_gic' is used
>>    using vc4 toolchain from [6]
>>
>> [1] https://github.com/TheRemote/Ubuntu-Server-raspi4-unofficial/releases
>> [2] https://jamesachambers.com/raspberry-pi-ubuntu-server-18-04-2-installation-guide/
>> [3] https://www.raspberrypi.org/documentation/hardware/raspberrypi/booteeprom.md
>> [4] https://raspberrypi.stackexchange.com/questions/10442/what-is-the-boot-sequence
>> [5] https://github.com/raspberrypi/tools/commit/7f4a937e1bacbc111a22552169bc890b4bb26a94#diff-8c41083e9fa0c98f1c3015e11b897444
>> [6] https://github.com/christinaa/rpi-open-firmware
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/arm/bcm2836.c         | 75 ++++++++++++++++++++++++++++++++++++++++
>>   include/hw/arm/bcm2836.h |  3 ++
>>   2 files changed, 78 insertions(+)
>>
>> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
>> index 019e67b906..d89d7cd71d 100644
>> --- a/hw/arm/bcm2836.c
>> +++ b/hw/arm/bcm2836.c
>> @@ -21,6 +21,7 @@ struct BCM283XInfo {
>>       const char *cpu_type;
>>       hwaddr peri_base; /* Peripheral base address seen by the CPU */
>>       hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
>> +    hwaddr gic_base;
>>       int clusterid;
>>   };
>>   
>> @@ -40,9 +41,25 @@ static const BCM283XInfo bcm283x_socs[] = {
>>           .ctrl_base = 0x40000000,
>>           .clusterid = 0x0,
>>       },
>> +    {
>> +        .name = TYPE_BCM2838,
>> +        .cpu_type = ARM_CPU_TYPE_NAME("cortex-a72"),
>> +        .peri_base = 0xfe000000,
>> +        .ctrl_base = 0xff800000,
>> +        .gic_base = 0x40000,
>> +    },
>>   #endif
>>   };
>>   
>> +#define GIC_NUM_IRQS                256
>> +
>> +#define GIC_BASE_OFS                0x0000
>> +#define GIC_DIST_OFS                0x1000
>> +#define GIC_CPU_OFS                 0x2000
>> +#define GIC_VIFACE_THIS_OFS         0x4000
>> +#define GIC_VIFACE_OTHER_OFS(cpu)  (0x5000 + (cpu) * 0x200)
>> +#define GIC_VCPU_OFS                0x6000
>> +
>>   static void bcm2836_init(Object *obj)
>>   {
>>       BCM283XState *s = BCM283X(obj);
>> @@ -55,6 +72,11 @@ static void bcm2836_init(Object *obj)
>>                                   info->cpu_type, &error_abort, NULL);
>>       }
>>   
>> +    if (info->gic_base) {
>> +        sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
>> +                              TYPE_ARM_GIC);
>> +    }
>> +
>>       sysbus_init_child_obj(obj, "control", &s->control, sizeof(s->control),
>>                             TYPE_BCM2836_CONTROL);
>>   
>> @@ -115,6 +137,59 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
>>   
>>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, info->ctrl_base);
>>   
>> +    /* bcm2838 GICv2 */
>> +    if (info->gic_base) {
>> +        object_property_set_uint(OBJECT(&s->gic), 2, "revision", &err);
>> +        if (err) {
>> +            error_propagate(errp, err);
>> +            return;
>> +        }
>> +
>> +        object_property_set_uint(OBJECT(&s->gic),
>> +                                 BCM283X_NCPUS, "num-cpu", &err);
>> +        if (err) {
>> +            error_propagate(errp, err);
>> +            return;
>> +        }
>> +
>> +        object_property_set_uint(OBJECT(&s->gic),
>> +                                 32 + GIC_NUM_IRQS, "num-irq", &err);
>> +        if (err) {
>> +            error_propagate(errp, err);
>> +            return;
>> +        }
>> +
>> +        object_property_set_bool(OBJECT(&s->gic),
>> +                                 true, "has-virtualization-extensions", &err);
>> +        if (err) {
>> +            error_propagate(errp, err);
>> +            return;
>> +        }
>> +
>> +        object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
>> +        if (err) {
>> +            error_propagate(errp, err);
>> +            return;
>> +        }
>> +
>> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 0,
>> +                        info->ctrl_base + info->gic_base + GIC_DIST_OFS);
>> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 1,
>> +                        info->ctrl_base + info->gic_base + GIC_CPU_OFS);
>> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 2,
>> +                        info->ctrl_base + info->gic_base + GIC_VIFACE_THIS_OFS);
>> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 3,
>> +                        info->ctrl_base + info->gic_base + GIC_VCPU_OFS);
>> +
>> +        for (n = 0; n < BCM283X_NCPUS; n++) {
>> +            sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 4 + n,
>> +                            info->ctrl_base + info->gic_base
>> +                            + GIC_VIFACE_OTHER_OFS(n));> +        }
>> +
>> +        /* TODO wire IRQs!!! */
> 
> I think as a bare minimum, you must wire:
>   - the ARM generic timer IRQs going out of all the CPUs, into their
> respective PPI. Looking at [1], they seem to be connected to the usual
> PPIs (at least we have the same mapping in the vexpress, the xynqmp and
> the virt board).

Done :)

>   - The PMU interrupts

Still TODO.

>   - Possibly the GICv2 maintenance interrupt, but I can't find the IRQ
> number in the DTS. This is related to the virtualization extension. It
> should not prevent Linux from booting if it's not connected (I think KVM
> does not even use the GICv2 maintenance interrupts anyway).

Done, this is a GIC-400 so it is fixed as PPI IRQ#9 :)

>   - Finally, Connect the four GICv2 output (irq, fiq, virq, vfiq) to
> their respective CPU inputs.

Done.

> [1]
> https://github.com/raspberrypi/linux/blob/rpi-5.3.y/arch/arm/boot/dts/bcm2838.dtsi
> 
> 
> Here is a snippet of the virt board, quickly adapted foc this SoC (I
> didn't test it):

Thanks! It helped :)

> #define BCM2838_ARCH_TIMER_VIRT_IRQ   11
> #define BCM2838_ARCH_TIMER_S_EL1_IRQ  13
> #define BCM2838_ARCH_TIMER_NS_EL1_IRQ 14
> #define BCM2838_ARCH_TIMER_NS_EL2_IRQ 10
> 
> #define BCM2838_PMU_SPI_BASE          16
> [...]
> 
>  for (i = 0; i < BCM283X_NCPUS; i++) {
>         DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
>         int ppibase = GIC_NUM_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
>         int irq;
> 
>         /* Mapping from the output timer irq lines from the CPU to the
>          * GIC PPI inputs.
>          */
>         const int timer_irq[] = {
>             [GTIMER_PHYS] = BCM2838_ARCH_TIMER_NS_EL1_IRQ,
>             [GTIMER_VIRT] = BCM2838_ARCH_TIMER_VIRT_IRQ,
>             [GTIMER_HYP]  = BCM2838_ARCH_TIMER_NS_EL2_IRQ,
>             [GTIMER_SEC]  = BCM2838_ARCH_TIMER_S_EL1_IRQ,
>         };
> 
>         for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
>             qdev_connect_gpio_out(cpudev, irq,
>                                   qdev_get_gpio_in(gicdev,
>                                                    ppibase +
> timer_irq[irq]));
>         }
> 
>         /* I don't know the maintenance IRQ number for the this SoC */
> #if 0
>         qemu_irq irq = qdev_get_gpio_in(gicdev,
>                                         ppibase + ARCH_GIC_MAINT_IRQ);
>         sysbus_connect_irq(SYS_BUS_DEVICE(gicbusdevs->gic), i + 4 *
> smp_cpus, irq);
> #endif
> 
>         /* PMU interrupt */
>         qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
>                                     qdev_get_gpio_in(gicdev,
> BCM2838_PMU_SPI_BASE + i));
> 
>         /* Connect the GICv2 outputs to the CPU */
>         sysbus_connect_irq(SYS_BUS_DEVICE(gicbusdevs->gic), i,
>                            qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
>         sysbus_connect_irq(SYS_BUS_DEVICE(gicbusdevs->gic), i + smp_cpus,
>                            qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
>         sysbus_connect_irq(SYS_BUS_DEVICE(gicbusdevs->gic), i + 2 *
> smp_cpus,
>                            qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
>         sysbus_connect_irq(SYS_BUS_DEVICE(gicbusdevs->gic), i + 3 *
> smp_cpus,
>                            qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
>     }

With this and few other changes I get some hopeful kernel output:

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
[    0.000000] Linux version 4.19.67-v8+ (james@james-ubuntu2) (gcc
version 9.1.0 (GCC)) #1 SMP PREEMPT Mon Aug 26 21:26:31 MDT 2019
[    0.000000] Machine model: Raspberry Pi 4 Model B
[    0.000000] earlycon: pl11 at MMIO 0x00000000fe201000 (options '')
[    0.000000] bootconsole [pl11] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Reserved 8 MiB at 0x000000003b800000
[    0.000000] On node 0 totalpages: 245760
[    0.000000]   DMA32 zone: 3840 pages used for memmap
[    0.000000]   DMA32 zone: 0 pages reserved
[    0.000000]   DMA32 zone: 245760 pages, LIFO batch:63
[    0.000000] random: get_random_bytes called from
start_kernel+0xa0/0x46c with crng_init=0
[    0.000000] percpu: Embedded 24 pages/cpu s57368 r8192 d32744 u98304
[    0.000000] pcpu-alloc: s57368 r8192 d32744 u98304 alloc=24*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for EL2 vector hardening
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 241920
[    0.000000] Kernel command line: rw earlycon=pl011,0xfe201000
console=ttyAMA0 loglevel=8 root=/dev/mmcblk0p2 fsck.repair=yes
net.ifnames=0 rootwait rdinit=/sbin/init
[    0.000000] Dentry cache hash table entries: 131072 (order: 8,
1048576 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288
bytes)
[    0.000000] Memory: 923932K/983040K available (8060K kernel code,
966K rwdata, 2560K rodata, 960K init, 916K bss, 50916K reserved, 8192K
cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] ftrace: allocating 28504 entries in 112 pages
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=64 to
nr_cpu_ids=4.
[    0.000000]  Tasks RCU enabled.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] arch_timer: cp15 timer(s) running at 54.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0xc743ce346, max_idle_ns: 440795203123 ns
[    0.001377] sched_clock: 56 bits at 54MHz, resolution 18ns, wraps
every 4398046511102ns
[    0.070247] Console: colour dummy device 80x25
[    0.085191] Calibrating delay loop (skipped), value calculated using
timer frequency.. 108.00 BogoMIPS (lpj=216000)
[    0.087407] pid_max: default: 32768 minimum: 301
[    0.118255] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
[    0.120037] Mountpoint-cache hash table entries: 2048 (order: 2,
16384 bytes)
[    0.462960] ASID allocator initialised with 32768 entries
[    0.475367] rcu: Hierarchical SRCU implementation.
[    0.540749] EFI services will not be available.
[    0.563715] smp: Bringing up secondary CPUs ...
[    0.624297] Detected PIPT I-cache on CPU1
[    0.628830] CPU1: Booted secondary processor 0x0000000001 [0x410fd083]
[    0.698386] Detected PIPT I-cache on CPU2
[    0.699334] CPU2: Booted secondary processor 0x0000000002 [0x410fd083]
[    0.752144] Detected PIPT I-cache on CPU3
[    0.753057] CPU3: Booted secondary processor 0x0000000003 [0x410fd083]
[    0.759037] smp: Brought up 1 node, 4 CPUs
[    0.762310] SMP: Total of 4 processors activated.
[    0.763888] CPU features: detected: 32-bit EL0 Support
[    0.819489] CPU: All CPU(s) started at EL2
[    0.826062] alternatives: patching kernel code
[    0.948345] devtmpfs: initialized
[    1.235286] Enabled cp15_barrier support
[    1.237025] Enabled setend support
[    1.253695] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.255510] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    1.275781] pinctrl core: initialized pinctrl subsystem
[    1.347547] DMI not present or invalid.
[    1.378896] NET: Registered protocol family 16
[    1.439424] cpuidle: using governor menu
[    1.450693] vdso: 2 pages (1 code @ (____ptrval____), 1 data @
(____ptrval____))
[    1.452529] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.

Regards.

Phil.

