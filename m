Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592C6C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 01:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5D02068F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 01:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VI+xQ0QS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5D02068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZPMk-0006QU-UB
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 20:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZPLi-0005ym-Qn
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 20:09:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZPLf-0000Te-MQ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 20:09:02 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZPLf-0000Rz-B8
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 20:08:59 -0500
Received: by mail-ot1-x341.google.com with SMTP id d5so14447321otp.4
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 17:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=kcaN5jpgmRJJtsOTb08L9bKnDEJmS1vRT73jLFbNdGY=;
 b=VI+xQ0QSew4rQaOAugkjc4VyuPiG0dArlaIGt5h4PljbJrQdDb2i3hbugZtJ2ytTNf
 SeLSVBvErOVUSdNPpdlZwcVBW/3io55jeTKO6sxaW6B01hVCaRZ02kZA33JqN32lPTu4
 n8tUbbo78+FyRc9vZRSeB+DnpRqveCagnQCMtWcMqBauzaaBhLm9qc5oSFmh+QT1mS3T
 sHVWzaNTSxTBGyfvntbvPuvhXpPeGr3HGWqrRgz5Rn/Gx8QNwgIQTVwiwlE3doA3HIN+
 RLpdPjxR7+Gsn/I04kPntZewsFmqNlbyLPhrYT2pNuSap4UqqAcFLdKOTsO4IyDRT8w9
 i1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=kcaN5jpgmRJJtsOTb08L9bKnDEJmS1vRT73jLFbNdGY=;
 b=M8TVakOM20VcSkXU45yvsQsepF/cdxrKWwWXuWKJkzPXlXYSSbheWqSlvmjOQOiLBM
 PKdGuz8KcPKK5iBlX+VFQ3j/b+0pddPOPFzZ1GGy3uc7SFTcKgjhbxhXNN3DPq/eUsVg
 OGCuWyL5P5BG98JUTu2gHj7qqZAdU9hxzotBOXKKfGMA4hmbOzRXu707fHoR0Iyvd0R8
 mDQjmOCwEuwxW2FEZmoRczpU+8hZtcMAi/cXxXf22oYU+jCBdNPvrAU3JhCsMS/6cbGH
 sHMupVm7g0msu5sbYzlP+RKvlvzzzuaPSP3ltJuIsU5O8zYCKQkiOBxAHbPQILhWxomn
 /yZg==
X-Gm-Message-State: APjAAAWpYFKcVm3s5F/aDQDZsvDG/aQQcira2aFL0czPjMS4SEM+0LS0
 MZG1S6Bi49pYPhU/J2JSRsW96MokKQ7QvAU+S0U=
X-Google-Smtp-Source: APXvYqzMclX8PckBink+HywTuIe1sUUxuWJyr1hNDABzIwRQaV+f49wkT5SY42N6nsnfybMJ3nTHU9LbiKWHpFnEqBc=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr475497otc.295.1574730537717;
 Mon, 25 Nov 2019 17:08:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Mon, 25 Nov 2019 17:08:57
 -0800 (PST)
In-Reply-To: <20191124050225.30351-13-mrolnik@gmail.com>
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-13-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 26 Nov 2019 02:08:57 +0100
Message-ID: <CAL1e-=gOwA8L-vtTrcNPzY0RkL-fSW_JT9E2eRv8QRmzFYaEjA@mail.gmail.com>
Subject: Re: [PATCH v36 12/17] target/avr: Add example board configuration
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000515422059835860a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000515422059835860a
Content-Type: text/plain; charset="UTF-8"

On Sunday, November 24, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> A simple board setup that configures an AVR CPU to run a given firmware
> image.
> This is all that's useful to implement without peripheral emulation as AVR
> CPUs include a lot of on-board peripherals.
>
> NOTE: this is not a real board !!!!
> NOTE: it's used for CPU testing!!!!
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---


Given the complexities of peripherals of AVR CPUs, in my opinion it would
be overly demanding to the submitters to require a real machine emulation
at this point of time. So:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Hopefully this will superceeded with a real board emulation in not so
distsnt future.

Philippe, do you have something to add?


>
> hw/avr/sample.c      | 282 +++++++++++++++++++++++++++++++++++++++++++
>  hw/Kconfig           |   1 +
>  hw/avr/Kconfig       |   6 +
>  hw/avr/Makefile.objs |   1 +
>  4 files changed, 290 insertions(+)
>  create mode 100644 hw/avr/sample.c
>  create mode 100644 hw/avr/Kconfig
>  create mode 100644 hw/avr/Makefile.objs
>
> diff --git a/hw/avr/sample.c b/hw/avr/sample.c
> new file mode 100644
> index 0000000000..2295ec1b79
> --- /dev/null
> +++ b/hw/avr/sample.c
> @@ -0,0 +1,282 @@
> +/*
> + * QEMU AVR CPU
> + *
> + * Copyright (c) 2019 Michael Rolnik
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see
> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> + */
> +
> +/*
> + *  NOTE:
> + *      This is not a real AVR board, this is an example!
> + *      The CPU is an approximation of an ATmega2560, but is missing
> various
> + *      built-in peripherals.
> + *
> + *      This example board loads provided binary file into flash memory
> and
> + *      executes it from 0x00000000 address in the code memory space.
> + *
> + *      Currently used for AVR CPU validation
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "hw/hw.h"
> +#include "sysemu/sysemu.h"
> +#include "sysemu/qtest.h"
> +#include "ui/console.h"
> +#include "hw/boards.h"
> +#include "hw/loader.h"
> +#include "qemu/error-report.h"
> +#include "exec/address-spaces.h"
> +#include "include/hw/sysbus.h"
> +#include "include/hw/char/avr_usart.h"
> +#include "include/hw/timer/avr_timer16.h"
> +#include "include/hw/misc/avr_mask.h"
> +#include "elf.h"
> +#include "hw/misc/unimp.h"
> +
> +#define SIZE_FLASH 0x00040000
> +#define SIZE_SRAM 0x00002000
> +/*
> + * Size of additional "external" memory, as if the AVR were configured to
> use
> + * an external RAM chip.
> + * Note that the configuration registers that normally enable this
> feature are
> + * unimplemented.
> + */
> +#define SIZE_EXMEM 0x00000000
> +
> +/* Offsets of peripherals in emulated memory space (i.e. not host
> addresses)  */
> +#define PRR0_BASE 0x64
> +#define PRR1_BASE 0x65
> +#define USART_BASE 0xc0
> +#define TIMER1_BASE 0x80
> +#define TIMER1_IMSK_BASE 0x6f
> +#define TIMER1_IFR_BASE 0x36
> +
> +/* Interrupt numbers used by peripherals */
> +#define USART_RXC_IRQ 24
> +#define USART_DRE_IRQ 25
> +#define USART_TXC_IRQ 26
> +
> +#define TIMER1_CAPT_IRQ 15
> +#define TIMER1_COMPA_IRQ 16
> +#define TIMER1_COMPB_IRQ 17
> +#define TIMER1_COMPC_IRQ 18
> +#define TIMER1_OVF_IRQ 19
> +
> +/*  Power reduction     */
> +#define PRR1_BIT_PRTIM5     0x05    /*  Timer/Counter5  */
> +#define PRR1_BIT_PRTIM4     0x04    /*  Timer/Counter4  */
> +#define PRR1_BIT_PRTIM3     0x03    /*  Timer/Counter3  */
> +#define PRR1_BIT_PRUSART3   0x02    /*  USART3  */
> +#define PRR1_BIT_PRUSART2   0x01    /*  USART2  */
> +#define PRR1_BIT_PRUSART1   0x00    /*  USART1  */
> +
> +#define PRR0_BIT_PRTWI      0x06    /*  TWI */
> +#define PRR0_BIT_PRTIM2     0x05    /*  Timer/Counter2  */
> +#define PRR0_BIT_PRTIM0     0x04    /*  Timer/Counter0  */
> +#define PRR0_BIT_PRTIM1     0x03    /*  Timer/Counter1  */
> +#define PRR0_BIT_PRSPI      0x02    /*  Serial Peripheral Interface */
> +#define PRR0_BIT_PRUSART0   0x01    /*  USART0  */
> +#define PRR0_BIT_PRADC      0x00    /*  ADC */
> +
> +typedef struct {
> +    MachineClass parent;
> +} SampleMachineClass;
> +
> +typedef struct {
> +    MachineState parent;
> +    MemoryRegion *ram;
> +    MemoryRegion *flash;
> +    AVRUsartState *usart0;
> +    AVRTimer16State *timer1;
> +    AVRMaskState *prr[2];
> +} SampleMachineState;
> +
> +#define TYPE_SAMPLE_MACHINE MACHINE_TYPE_NAME("sample")
> +
> +#define SAMPLE_MACHINE(obj) \
> +    OBJECT_CHECK(SampleMachineState, obj, TYPE_SAMPLE_MACHINE)
> +#define SAMPLE_MACHINE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(SampleMachineClass, obj, TYPE_SAMPLE_MACHINE)
> +#define SAMPLE_MACHINE_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(SampleMachineClass, klass, TYPE_SAMPLE_MACHINE)
> +
> +static void sample_init(MachineState *machine)
> +{
> +    SampleMachineState *sms = SAMPLE_MACHINE(machine);
> +    MemoryRegion *system_memory = get_system_memory();
> +    AVRCPU *cpu;
> +    const char *firmware = NULL;
> +    const char *filename;
> +    int bytes_loaded;
> +    SysBusDevice *busdev;
> +    DeviceState *cpudev;
> +
> +    system_memory = get_system_memory();
> +    sms->ram = g_new(MemoryRegion, 1);
> +    sms->flash = g_new(MemoryRegion, 1);
> +
> +    cpu = AVR_CPU(cpu_create(machine->cpu_type));
> +    cpudev = DEVICE(cpu);
> +
> +
> +    memory_region_init_rom(sms->flash, NULL, "avr.flash", SIZE_FLASH,
> +            &error_fatal);
> +    memory_region_add_subregion(system_memory, OFFSET_CODE, sms->flash);
> +
> +    /* following are atmel2560 device */
> +    create_unimplemented_device("usart 3", OFFSET_DATA + 0x0130, 0x0007);
> +    create_unimplemented_device("timer-counter-16bit 5",
> +            OFFSET_DATA + 0x0120, 0x000e);
> +    create_unimplemented_device("gpio L", OFFSET_DATA + 0x0109, 0x0003);
> +    create_unimplemented_device("gpio K", OFFSET_DATA + 0x0106, 0x0003);
> +    create_unimplemented_device("gpio J", OFFSET_DATA + 0x0103, 0x0003);
> +    create_unimplemented_device("gpio H", OFFSET_DATA + 0x0100, 0x0003);
> +    create_unimplemented_device("usart 2", OFFSET_DATA + 0x00d0, 0x0007);
> +    create_unimplemented_device("usart 1", OFFSET_DATA + 0x00c8, 0x0007);
> +    create_unimplemented_device("usart 0", OFFSET_DATA + 0x00c0, 0x0007);
> +    create_unimplemented_device("twi", OFFSET_DATA + 0x00b8, 0x0006);
> +    create_unimplemented_device("timer-counter-async-8bit 2",
> +            OFFSET_DATA + 0x00b0, 0x0007);
> +    create_unimplemented_device("timer-counter-16bit 4",
> +            OFFSET_DATA + 0x00a0, 0x000e);
> +    create_unimplemented_device("timer-counter-16bit 3",
> +            OFFSET_DATA + 0x0090, 0x000e);
> +    create_unimplemented_device("timer-counter-16bit 1",
> +            OFFSET_DATA + 0x0080, 0x000e);
> +    create_unimplemented_device("ac / adc",
> +            OFFSET_DATA + 0x0078, 0x0008);
> +    create_unimplemented_device("ext-mem-iface",
> +            OFFSET_DATA + 0x0074, 0x0002);
> +    create_unimplemented_device("int-controller",
> +            OFFSET_DATA + 0x0068, 0x000c);
> +    create_unimplemented_device("sys",
> +            OFFSET_DATA + 0x0060, 0x0007);
> +    create_unimplemented_device("spi",
> +            OFFSET_DATA + 0x004c, 0x0003);
> +    create_unimplemented_device("ext-mem-iface",
> +            OFFSET_DATA + 0x004a, 0x0002);
> +    create_unimplemented_device("timer-counter-pwm-8bit 0",
> +            OFFSET_DATA + 0x0043, 0x0006);
> +    create_unimplemented_device("ext-mem-iface",
> +            OFFSET_DATA + 0x003e, 0x0005);
> +    create_unimplemented_device("int-controller",
> +            OFFSET_DATA + 0x0035, 0x0009);
> +    create_unimplemented_device("gpio G", OFFSET_DATA + 0x0032, 0x0003);
> +    create_unimplemented_device("gpio F", OFFSET_DATA + 0x002f, 0x0003);
> +    create_unimplemented_device("gpio E", OFFSET_DATA + 0x002c, 0x0003);
> +    create_unimplemented_device("gpio D", OFFSET_DATA + 0x0029, 0x0003);
> +    create_unimplemented_device("gpio C", OFFSET_DATA + 0x0026, 0x0003);
> +    create_unimplemented_device("gpio B", OFFSET_DATA + 0x0023, 0x0003);
> +    create_unimplemented_device("gpio A", OFFSET_DATA + 0x0020, 0x0003);
> +
> +    memory_region_allocate_system_memory(
> +        sms->ram, NULL, "avr.ram", SIZE_SRAM + SIZE_EXMEM);
> +    memory_region_add_subregion(system_memory, OFFSET_DATA + 0x200,
> sms->ram);
> +
> +    /* Power Reduction built-in peripheral */
> +    sms->prr[0] = AVR_MASK(sysbus_create_simple(TYPE_AVR_MASK,
> +                    OFFSET_DATA + PRR0_BASE, NULL));
> +    sms->prr[1] = AVR_MASK(sysbus_create_simple(TYPE_AVR_MASK,
> +                    OFFSET_DATA + PRR1_BASE, NULL));
> +
> +    /* USART 0 built-in peripheral */
> +    sms->usart0 = AVR_USART(object_new(TYPE_AVR_USART));
> +    busdev = SYS_BUS_DEVICE(sms->usart0);
> +    qdev_prop_set_chr(DEVICE(sms->usart0), "chardev", serial_hd(0));
> +    object_property_set_bool(OBJECT(sms->usart0), true, "realized",
> +            &error_fatal);
> +    sysbus_mmio_map(busdev, 0, OFFSET_DATA + USART_BASE);
> +    /*
> +     * These IRQ numbers don't match the datasheet because we're counting
> from
> +     * zero and not including reset.
> +     */
> +    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev,
> USART_RXC_IRQ));
> +    sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev,
> USART_DRE_IRQ));
> +    sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev,
> USART_TXC_IRQ));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(sms->prr[1]), PRR1_BIT_PRUSART1,
> +            qdev_get_gpio_in(DEVICE(sms->usart0), 0));
> +
> +    /* Timer 1 built-in periphal */
> +    sms->timer1 = AVR_TIMER16(object_new(TYPE_AVR_TIMER16));
> +    object_property_set_bool(OBJECT(sms->timer1), true, "realized",
> +            &error_fatal);
> +    busdev = SYS_BUS_DEVICE(sms->timer1);
> +    sysbus_mmio_map(busdev, 0, OFFSET_DATA + TIMER1_BASE);
> +    sysbus_mmio_map(busdev, 1, OFFSET_DATA + TIMER1_IMSK_BASE);
> +    sysbus_mmio_map(busdev, 2, OFFSET_DATA + TIMER1_IFR_BASE);
> +    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev,
> TIMER1_CAPT_IRQ));
> +    sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev,
> TIMER1_COMPA_IRQ));
> +    sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev,
> TIMER1_COMPB_IRQ));
> +    sysbus_connect_irq(busdev, 3, qdev_get_gpio_in(cpudev,
> TIMER1_COMPC_IRQ));
> +    sysbus_connect_irq(busdev, 4, qdev_get_gpio_in(cpudev,
> TIMER1_OVF_IRQ));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(sms->prr[0]), PRR0_BIT_PRTIM1,
> +            qdev_get_gpio_in(DEVICE(sms->timer1), 0));
> +
> +    /* Load firmware (contents of flash) trying to auto-detect format */
> +    firmware = machine->firmware;
> +    if (firmware != NULL) {
> +        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
> +        if (filename == NULL) {
> +            error_report("Unable to find %s", firmware);
> +            exit(1);
> +        }
> +
> +        bytes_loaded = load_elf(
> +            filename, NULL, NULL, NULL, NULL, NULL, NULL, 0, EM_NONE, 0,
> 0);
> +        if (bytes_loaded < 0) {
> +            bytes_loaded = load_image_targphys(
> +                filename, OFFSET_CODE, SIZE_FLASH);
> +        }
> +        if (bytes_loaded < 0) {
> +            error_report(
> +                "Unable to load firmware image %s as ELF or raw binary",
> +                firmware);
> +            exit(1);
> +        }
> +    }
> +}
> +
> +static void sample_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->desc = "AVR sample/example board (ATmega2560)";
> +    mc->init = sample_init;
> +    mc->default_cpus = 1;
> +    mc->min_cpus = mc->default_cpus;
> +    mc->max_cpus = mc->default_cpus;
> +    mc->default_cpu_type = "avr6-avr-cpu"; /* ATmega2560. */
> +    mc->is_default = 1;
> +}
> +
> +static const TypeInfo sample_info = {
> +    .name = TYPE_SAMPLE_MACHINE,
> +    .parent = TYPE_MACHINE,
> +    .instance_size = sizeof(SampleMachineState),
> +    .class_size = sizeof(SampleMachineClass),
> +    .class_init = sample_class_init,
> +};
> +
> +static void sample_machine_init(void)
> +{
> +    type_register_static(&sample_info);
> +}
> +
> +type_init(sample_machine_init);
> diff --git a/hw/Kconfig b/hw/Kconfig
> index b9685b3944..07b8abb342 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -44,6 +44,7 @@ source watchdog/Kconfig
>  # arch Kconfig
>  source arm/Kconfig
>  source alpha/Kconfig
> +source avr/Kconfig
>  source cris/Kconfig
>  source hppa/Kconfig
>  source i386/Kconfig
> diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
> new file mode 100644
> index 0000000000..92aa1e6afb
> --- /dev/null
> +++ b/hw/avr/Kconfig
> @@ -0,0 +1,6 @@
> +config AVR_SAMPLE
> +    bool
> +    select AVR_TIMER16
> +    select AVR_USART
> +    select AVR_MASK
> +    select UNIMP
> diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
> new file mode 100644
> index 0000000000..626b7064b3
> --- /dev/null
> +++ b/hw/avr/Makefile.objs
> @@ -0,0 +1 @@
> +obj-y += sample.o
> --
> 2.17.2 (Apple Git-113)
>
>

--000000000000515422059835860a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, November 24, 2019, Michael Rolnik &lt;<a href=3D"mailto:=
mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">A simple board setup that configures an AVR CPU to run a given f=
irmware image.<br>
This is all that&#39;s useful to implement without peripheral emulation as =
AVR CPUs include a lot of on-board peripherals.<br>
<br>
NOTE: this is not a real board !!!!<br>
NOTE: it&#39;s used for CPU testing!!!!<br>
<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrol=
nik@gmail.com</a>&gt;<br>
---</blockquote><div><br></div><div>Given the complexities of peripherals o=
f AVR CPUs, in my opinion it would be overly demanding to the submitters to=
 require a real machine emulation at this point of time. So:</div><div><br>=
</div><div><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22=
.1200008392334px">Reviewed-by: Aleksandar Markovic &lt;</span><a href=3D"ma=
ilto:amarkovic@wavecomp.com" target=3D"_blank" style=3D"font-size:14px;line=
-height:22.1200008392334px">amarkovic@wavecomp.com</a><span style=3D"color:=
rgb(34,34,34);font-size:14px;line-height:22.1200008392334px">&gt;</span></d=
iv><div><br></div><div>Hopefully this will superceeded with a real board em=
ulation in not so distsnt future.</div><div><br></div><div>Philippe, do you=
 have something to add?</div><div><br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><br></blockquote><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">hw/avr/sample.c=C2=A0 =C2=A0 =C2=A0 | 282 ++++++++++++=
++++++++++++++++++<wbr>+++++++++++++<br>
=C2=A0hw/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<=
br>
=C2=A0hw/avr/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +<br>
=C2=A0hw/avr/Makefile.objs |=C2=A0 =C2=A01 +<br>
=C2=A04 files changed, 290 insertions(+)<br>
=C2=A0create mode 100644 hw/avr/sample.c<br>
=C2=A0create mode 100644 hw/avr/Kconfig<br>
=C2=A0create mode 100644 hw/avr/Makefile.objs<br>
<br>
diff --git a/hw/avr/sample.c b/hw/avr/sample.c<br>
new file mode 100644<br>
index 0000000000..2295ec1b79<br>
--- /dev/null<br>
+++ b/hw/avr/sample.c<br>
@@ -0,0 +1,282 @@<br>
+/*<br>
+ * QEMU AVR CPU<br>
+ *<br>
+ * Copyright (c) 2019 Michael Rolnik<br>
+ *<br>
+ * This library is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU Lesser General Public<br>
+ * License as published by the Free Software Foundation; either<br>
+ * version 2.1 of the License, or (at your option) any later version.<br>
+ *<br>
+ * This library is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU<=
br>
+ * Lesser General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU Lesser General Public<br>
+ * License along with this library; if not, see<br>
+ * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" target=3D"_bl=
ank">http://www.gnu.org/licenses/<wbr>lgpl-2.1.html</a>&gt;<br>
+ */<br>
+<br>
+/*<br>
+ *=C2=A0 NOTE:<br>
+ *=C2=A0 =C2=A0 =C2=A0 This is not a real AVR board, this is an example!<b=
r>
+ *=C2=A0 =C2=A0 =C2=A0 The CPU is an approximation of an ATmega2560, but i=
s missing various<br>
+ *=C2=A0 =C2=A0 =C2=A0 built-in peripherals.<br>
+ *<br>
+ *=C2=A0 =C2=A0 =C2=A0 This example board loads provided binary file into =
flash memory and<br>
+ *=C2=A0 =C2=A0 =C2=A0 executes it from 0x00000000 address in the code mem=
ory space.<br>
+ *<br>
+ *=C2=A0 =C2=A0 =C2=A0 Currently used for AVR CPU validation<br>
+ *<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;qemu-common.h&quot;<br>
+#include &quot;cpu.h&quot;<br>
+#include &quot;hw/hw.h&quot;<br>
+#include &quot;sysemu/sysemu.h&quot;<br>
+#include &quot;sysemu/qtest.h&quot;<br>
+#include &quot;ui/console.h&quot;<br>
+#include &quot;hw/boards.h&quot;<br>
+#include &quot;hw/loader.h&quot;<br>
+#include &quot;qemu/error-report.h&quot;<br>
+#include &quot;exec/address-spaces.h&quot;<br>
+#include &quot;include/hw/sysbus.h&quot;<br>
+#include &quot;include/hw/char/avr_usart.h&quot;<br>
+#include &quot;include/hw/timer/avr_timer16.<wbr>h&quot;<br>
+#include &quot;include/hw/misc/avr_mask.h&quot;<br>
+#include &quot;elf.h&quot;<br>
+#include &quot;hw/misc/unimp.h&quot;<br>
+<br>
+#define SIZE_FLASH 0x00040000<br>
+#define SIZE_SRAM 0x00002000<br>
+/*<br>
+ * Size of additional &quot;external&quot; memory, as if the AVR were conf=
igured to use<br>
+ * an external RAM chip.<br>
+ * Note that the configuration registers that normally enable this feature=
 are<br>
+ * unimplemented.<br>
+ */<br>
+#define SIZE_EXMEM 0x00000000<br>
+<br>
+/* Offsets of peripherals in emulated memory space (i.e. not host addresse=
s)=C2=A0 */<br>
+#define PRR0_BASE 0x64<br>
+#define PRR1_BASE 0x65<br>
+#define USART_BASE 0xc0<br>
+#define TIMER1_BASE 0x80<br>
+#define TIMER1_IMSK_BASE 0x6f<br>
+#define TIMER1_IFR_BASE 0x36<br>
+<br>
+/* Interrupt numbers used by peripherals */<br>
+#define USART_RXC_IRQ 24<br>
+#define USART_DRE_IRQ 25<br>
+#define USART_TXC_IRQ 26<br>
+<br>
+#define TIMER1_CAPT_IRQ 15<br>
+#define TIMER1_COMPA_IRQ 16<br>
+#define TIMER1_COMPB_IRQ 17<br>
+#define TIMER1_COMPC_IRQ 18<br>
+#define TIMER1_OVF_IRQ 19<br>
+<br>
+/*=C2=A0 Power reduction=C2=A0 =C2=A0 =C2=A0*/<br>
+#define PRR1_BIT_PRTIM5=C2=A0 =C2=A0 =C2=A00x05=C2=A0 =C2=A0 /*=C2=A0 Time=
r/Counter5=C2=A0 */<br>
+#define PRR1_BIT_PRTIM4=C2=A0 =C2=A0 =C2=A00x04=C2=A0 =C2=A0 /*=C2=A0 Time=
r/Counter4=C2=A0 */<br>
+#define PRR1_BIT_PRTIM3=C2=A0 =C2=A0 =C2=A00x03=C2=A0 =C2=A0 /*=C2=A0 Time=
r/Counter3=C2=A0 */<br>
+#define PRR1_BIT_PRUSART3=C2=A0 =C2=A00x02=C2=A0 =C2=A0 /*=C2=A0 USART3=C2=
=A0 */<br>
+#define PRR1_BIT_PRUSART2=C2=A0 =C2=A00x01=C2=A0 =C2=A0 /*=C2=A0 USART2=C2=
=A0 */<br>
+#define PRR1_BIT_PRUSART1=C2=A0 =C2=A00x00=C2=A0 =C2=A0 /*=C2=A0 USART1=C2=
=A0 */<br>
+<br>
+#define PRR0_BIT_PRTWI=C2=A0 =C2=A0 =C2=A0 0x06=C2=A0 =C2=A0 /*=C2=A0 TWI =
*/<br>
+#define PRR0_BIT_PRTIM2=C2=A0 =C2=A0 =C2=A00x05=C2=A0 =C2=A0 /*=C2=A0 Time=
r/Counter2=C2=A0 */<br>
+#define PRR0_BIT_PRTIM0=C2=A0 =C2=A0 =C2=A00x04=C2=A0 =C2=A0 /*=C2=A0 Time=
r/Counter0=C2=A0 */<br>
+#define PRR0_BIT_PRTIM1=C2=A0 =C2=A0 =C2=A00x03=C2=A0 =C2=A0 /*=C2=A0 Time=
r/Counter1=C2=A0 */<br>
+#define PRR0_BIT_PRSPI=C2=A0 =C2=A0 =C2=A0 0x02=C2=A0 =C2=A0 /*=C2=A0 Seri=
al Peripheral Interface */<br>
+#define PRR0_BIT_PRUSART0=C2=A0 =C2=A00x01=C2=A0 =C2=A0 /*=C2=A0 USART0=C2=
=A0 */<br>
+#define PRR0_BIT_PRADC=C2=A0 =C2=A0 =C2=A0 0x00=C2=A0 =C2=A0 /*=C2=A0 ADC =
*/<br>
+<br>
+typedef struct {<br>
+=C2=A0 =C2=A0 MachineClass parent;<br>
+} SampleMachineClass;<br>
+<br>
+typedef struct {<br>
+=C2=A0 =C2=A0 MachineState parent;<br>
+=C2=A0 =C2=A0 MemoryRegion *ram;<br>
+=C2=A0 =C2=A0 MemoryRegion *flash;<br>
+=C2=A0 =C2=A0 AVRUsartState *usart0;<br>
+=C2=A0 =C2=A0 AVRTimer16State *timer1;<br>
+=C2=A0 =C2=A0 AVRMaskState *prr[2];<br>
+} SampleMachineState;<br>
+<br>
+#define TYPE_SAMPLE_MACHINE MACHINE_TYPE_NAME(&quot;sample&quot;)<br>
+<br>
+#define SAMPLE_MACHINE(obj) \<br>
+=C2=A0 =C2=A0 OBJECT_CHECK(<wbr>SampleMachineState, obj, TYPE_SAMPLE_MACHI=
NE)<br>
+#define SAMPLE_MACHINE_GET_CLASS(obj) \<br>
+=C2=A0 =C2=A0 OBJECT_GET_CLASS(<wbr>SampleMachineClass, obj, TYPE_SAMPLE_M=
ACHINE)<br>
+#define SAMPLE_MACHINE_CLASS(klass) \<br>
+=C2=A0 =C2=A0 OBJECT_CLASS_CHECK(<wbr>SampleMachineClass, klass, TYPE_SAMP=
LE_MACHINE)<br>
+<br>
+static void sample_init(MachineState *machine)<br>
+{<br>
+=C2=A0 =C2=A0 SampleMachineState *sms =3D SAMPLE_MACHINE(machine);<br>
+=C2=A0 =C2=A0 MemoryRegion *system_memory =3D get_system_memory();<br>
+=C2=A0 =C2=A0 AVRCPU *cpu;<br>
+=C2=A0 =C2=A0 const char *firmware =3D NULL;<br>
+=C2=A0 =C2=A0 const char *filename;<br>
+=C2=A0 =C2=A0 int bytes_loaded;<br>
+=C2=A0 =C2=A0 SysBusDevice *busdev;<br>
+=C2=A0 =C2=A0 DeviceState *cpudev;<br>
+<br>
+=C2=A0 =C2=A0 system_memory =3D get_system_memory();<br>
+=C2=A0 =C2=A0 sms-&gt;ram =3D g_new(MemoryRegion, 1);<br>
+=C2=A0 =C2=A0 sms-&gt;flash =3D g_new(MemoryRegion, 1);<br>
+<br>
+=C2=A0 =C2=A0 cpu =3D AVR_CPU(cpu_create(machine-&gt;<wbr>cpu_type));<br>
+=C2=A0 =C2=A0 cpudev =3D DEVICE(cpu);<br>
+<br>
+<br>
+=C2=A0 =C2=A0 memory_region_init_rom(sms-&gt;<wbr>flash, NULL, &quot;avr.f=
lash&quot;, SIZE_FLASH,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(<wbr>system_memory, OFFSET_CODE,=
 sms-&gt;flash);<br>
+<br>
+=C2=A0 =C2=A0 /* following are atmel2560 device */<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>usart 3&quot;, OFFSET=
_DATA + 0x0130, 0x0007);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>timer-counter-16bit 5=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0120, 0x000e);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio L&quot;, OFFSET_=
DATA + 0x0109, 0x0003);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio K&quot;, OFFSET_=
DATA + 0x0106, 0x0003);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio J&quot;, OFFSET_=
DATA + 0x0103, 0x0003);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio H&quot;, OFFSET_=
DATA + 0x0100, 0x0003);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>usart 2&quot;, OFFSET=
_DATA + 0x00d0, 0x0007);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>usart 1&quot;, OFFSET=
_DATA + 0x00c8, 0x0007);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>usart 0&quot;, OFFSET=
_DATA + 0x00c0, 0x0007);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>twi&quot;, OFFSET_DAT=
A + 0x00b8, 0x0006);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>timer-counter-async-8=
bit 2&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x00b0, 0x0007);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>timer-counter-16bit 4=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x00a0, 0x000e);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>timer-counter-16bit 3=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0090, 0x000e);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>timer-counter-16bit 1=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0080, 0x000e);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>ac / adc&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0078, 0x0008);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>ext-mem-iface&quot;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0074, 0x0002);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>int-controller&quot;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0068, 0x000c);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>sys&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0060, 0x0007);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>spi&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x004c, 0x0003);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>ext-mem-iface&quot;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x004a, 0x0002);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>timer-counter-pwm-8bi=
t 0&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0043, 0x0006);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>ext-mem-iface&quot;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x003e, 0x0005);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>int-controller&quot;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0035, 0x0009);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio G&quot;, OFFSET_=
DATA + 0x0032, 0x0003);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio F&quot;, OFFSET_=
DATA + 0x002f, 0x0003);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio E&quot;, OFFSET_=
DATA + 0x002c, 0x0003);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio D&quot;, OFFSET_=
DATA + 0x0029, 0x0003);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio C&quot;, OFFSET_=
DATA + 0x0026, 0x0003);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio B&quot;, OFFSET_=
DATA + 0x0023, 0x0003);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio A&quot;, OFFSET_=
DATA + 0x0020, 0x0003);<br>
+<br>
+=C2=A0 =C2=A0 memory_region_allocate_system_<wbr>memory(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sms-&gt;ram, NULL, &quot;avr.ram&quot;, SIZE_S=
RAM + SIZE_EXMEM);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(<wbr>system_memory, OFFSET_DATA =
+ 0x200, sms-&gt;ram);<br>
+<br>
+=C2=A0 =C2=A0 /* Power Reduction built-in peripheral */<br>
+=C2=A0 =C2=A0 sms-&gt;prr[0] =3D AVR_MASK(sysbus_create_simple(<wbr>TYPE_A=
VR_MASK,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFS=
ET_DATA + PRR0_BASE, NULL));<br>
+=C2=A0 =C2=A0 sms-&gt;prr[1] =3D AVR_MASK(sysbus_create_simple(<wbr>TYPE_A=
VR_MASK,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFS=
ET_DATA + PRR1_BASE, NULL));<br>
+<br>
+=C2=A0 =C2=A0 /* USART 0 built-in peripheral */<br>
+=C2=A0 =C2=A0 sms-&gt;usart0 =3D AVR_USART(object_new(TYPE_AVR_<wbr>USART)=
);<br>
+=C2=A0 =C2=A0 busdev =3D SYS_BUS_DEVICE(sms-&gt;usart0);<br>
+=C2=A0 =C2=A0 qdev_prop_set_chr(DEVICE(sms-&gt;<wbr>usart0), &quot;chardev=
&quot;, serial_hd(0));<br>
+=C2=A0 =C2=A0 object_property_set_bool(<wbr>OBJECT(sms-&gt;usart0), true, =
&quot;realized&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(busdev, 0, OFFSET_DATA + USART_BASE);<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* These IRQ numbers don&#39;t match the datasheet beca=
use we&#39;re counting from<br>
+=C2=A0 =C2=A0 =C2=A0* zero and not including reset.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev, USART=
_RXC_IRQ));<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev, USART=
_DRE_IRQ));<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev, USART=
_TXC_IRQ));<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_<wbr>DEVICE(sms-&gt;prr[1]), PRR1=
_BIT_PRUSART1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(sms-&gt;=
<wbr>usart0), 0));<br>
+<br>
+=C2=A0 =C2=A0 /* Timer 1 built-in periphal */<br>
+=C2=A0 =C2=A0 sms-&gt;timer1 =3D AVR_TIMER16(object_new(TYPE_<wbr>AVR_TIME=
R16));<br>
+=C2=A0 =C2=A0 object_property_set_bool(<wbr>OBJECT(sms-&gt;timer1), true, =
&quot;realized&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
+=C2=A0 =C2=A0 busdev =3D SYS_BUS_DEVICE(sms-&gt;timer1);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(busdev, 0, OFFSET_DATA + TIMER1_BASE);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(busdev, 1, OFFSET_DATA + TIMER1_IMSK_BASE);<=
br>
+=C2=A0 =C2=A0 sysbus_mmio_map(busdev, 2, OFFSET_DATA + TIMER1_IFR_BASE);<b=
r>
+=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev, TIMER=
1_CAPT_IRQ));<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev, TIMER=
1_COMPA_IRQ));<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev, TIMER=
1_COMPB_IRQ));<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 3, qdev_get_gpio_in(cpudev, TIMER=
1_COMPC_IRQ));<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 4, qdev_get_gpio_in(cpudev, TIMER=
1_OVF_IRQ));<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_<wbr>DEVICE(sms-&gt;prr[0]), PRR0=
_BIT_PRTIM1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(sms-&gt;=
<wbr>timer1), 0));<br>
+<br>
+=C2=A0 =C2=A0 /* Load firmware (contents of flash) trying to auto-detect f=
ormat */<br>
+=C2=A0 =C2=A0 firmware =3D machine-&gt;firmware;<br>
+=C2=A0 =C2=A0 if (firmware !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 filename =3D qemu_find_file(QEMU_FILE_TYPE_<wb=
r>BIOS, firmware);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (filename =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Unable to fin=
d %s&quot;, firmware);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_loaded =3D load_elf(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename, NULL, NULL, NULL, NULL=
, NULL, NULL, 0, EM_NONE, 0, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bytes_loaded &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_loaded =3D load_image_targ=
phys(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename, OFFSET_C=
ODE, SIZE_FLASH);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bytes_loaded &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Unable to lo=
ad firmware image %s as ELF or raw binary&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 firmware);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void sample_class_init(ObjectClass *oc, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_CLASS(oc);<br>
+<br>
+=C2=A0 =C2=A0 mc-&gt;desc =3D &quot;AVR sample/example board (ATmega2560)&=
quot;;<br>
+=C2=A0 =C2=A0 mc-&gt;init =3D sample_init;<br>
+=C2=A0 =C2=A0 mc-&gt;default_cpus =3D 1;<br>
+=C2=A0 =C2=A0 mc-&gt;min_cpus =3D mc-&gt;default_cpus;<br>
+=C2=A0 =C2=A0 mc-&gt;max_cpus =3D mc-&gt;default_cpus;<br>
+=C2=A0 =C2=A0 mc-&gt;default_cpu_type =3D &quot;avr6-avr-cpu&quot;; /* ATm=
ega2560. */<br>
+=C2=A0 =C2=A0 mc-&gt;is_default =3D 1;<br>
+}<br>
+<br>
+static const TypeInfo sample_info =3D {<br>
+=C2=A0 =C2=A0 .name =3D TYPE_SAMPLE_MACHINE,<br>
+=C2=A0 =C2=A0 .parent =3D TYPE_MACHINE,<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(SampleMachineState),<br>
+=C2=A0 =C2=A0 .class_size =3D sizeof(SampleMachineClass),<br>
+=C2=A0 =C2=A0 .class_init =3D sample_class_init,<br>
+};<br>
+<br>
+static void sample_machine_init(void)<br>
+{<br>
+=C2=A0 =C2=A0 type_register_static(&amp;sample_<wbr>info);<br>
+}<br>
+<br>
+type_init(sample_machine_<wbr>init);<br>
diff --git a/hw/Kconfig b/hw/Kconfig<br>
index b9685b3944..07b8abb342 100644<br>
--- a/hw/Kconfig<br>
+++ b/hw/Kconfig<br>
@@ -44,6 +44,7 @@ source watchdog/Kconfig<br>
=C2=A0# arch Kconfig<br>
=C2=A0source arm/Kconfig<br>
=C2=A0source alpha/Kconfig<br>
+source avr/Kconfig<br>
=C2=A0source cris/Kconfig<br>
=C2=A0source hppa/Kconfig<br>
=C2=A0source i386/Kconfig<br>
diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig<br>
new file mode 100644<br>
index 0000000000..92aa1e6afb<br>
--- /dev/null<br>
+++ b/hw/avr/Kconfig<br>
@@ -0,0 +1,6 @@<br>
+config AVR_SAMPLE<br>
+=C2=A0 =C2=A0 bool<br>
+=C2=A0 =C2=A0 select AVR_TIMER16<br>
+=C2=A0 =C2=A0 select AVR_USART<br>
+=C2=A0 =C2=A0 select AVR_MASK<br>
+=C2=A0 =C2=A0 select UNIMP<br>
diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs<br>
new file mode 100644<br>
index 0000000000..626b7064b3<br>
--- /dev/null<br>
+++ b/hw/avr/Makefile.objs<br>
@@ -0,0 +1 @@<br>
+obj-y +=3D sample.o<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>

--000000000000515422059835860a--

