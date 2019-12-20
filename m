Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B337C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 23:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E03720866
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 23:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/YikmRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E03720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiRSr-0006G0-3h
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 18:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iiRS1-0005rV-BL
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 18:12:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iiRRx-0000Dv-2w
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 18:12:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57855
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iiRRw-00005J-JY
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 18:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576883567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z24pHayQ7qU+lVvzk+vGRIWu0NTNV49d1vZ6oBv1Un0=;
 b=e/YikmRjW4mym52AVzr8RgC8mB97CaACcmeWhTTwoOJsplIAxGm2YPjtk+yXCgjy8gzFk7
 ZzqvoO9b1nzaibIFwDgQa2hBXLyqXlpUTLMeX0SnG5aloPW6nQ5j6LmsdP3/I5Goyr8hmD
 UGl/uGgix2su8C1qKNNuH4hgc/faTKs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-TryWWeKqOkaaVufMsbYMUw-1; Fri, 20 Dec 2019 18:12:43 -0500
Received: by mail-wr1-f71.google.com with SMTP id d8so4389072wrq.12
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 15:12:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TYpY5zUFiy49mHk4J5H8Ns+rr3FKBV6e6lAgrLqYaC8=;
 b=YLmJX3We52ClIf+FBgZuB+XAZmKyQORRIJBRUAfs7pVTyyf6vF1ht75rMpREOpb5KQ
 3Ef6lZA+sInJOV3LG4WFIyYGQhagY5RYIFgeAY9RKC2feeOlaoDx08QqufSBJfOuenjz
 F2EPVATfxkyM/igRwYNg9Di624SAoPwxBEk1KGpGaddRlzYar+bugq/OQh4TyzXGXgM5
 4IZhEeErSPHD5MnGEvQX4obSoTbIM2ex9QLxQCTsuGtDirO3BZCDwPWklatnolbdYLe3
 MLdVWigiV4lOzEWJRx31YfxlqPboSWb6K+84cpCSz8rQpGXM2KIGULoSySd+mkYjy9I+
 oRDQ==
X-Gm-Message-State: APjAAAW+Ym62DBInSEcrZNdaukD981QwysxJDGDoQbA3OZI1r7xbcsc4
 t3IbBpFT4LbaYljF3pbyRi+dCqqryUGD2LuHJrMlR8IzIBLcg70PzDjGofCfGuHUtAbD4DJDtpg
 jBTSq3a1LdDekNJg=
X-Received: by 2002:a7b:c936:: with SMTP id h22mr18068980wml.115.1576883562273; 
 Fri, 20 Dec 2019 15:12:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqzy0RemgAgGcdcioP5A0FD2w4SBsKFcAsRA8QKv07BOHoY+KMgeWEu5nHyUo/6rOYn4TC3Fig==
X-Received: by 2002:a7b:c936:: with SMTP id h22mr18068953wml.115.1576883561788; 
 Fri, 20 Dec 2019 15:12:41 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id n67sm11368651wmf.46.2019.12.20.15.12.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2019 15:12:41 -0800 (PST)
Subject: Re: [PATCH v39 15/22] target/avr: Add example board configuration
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20191218210329.1960-1-mrolnik@gmail.com>
 <20191218210329.1960-16-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3d4eaf54-4cca-efaf-609b-d1689311a8fe@redhat.com>
Date: Sat, 21 Dec 2019 00:12:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218210329.1960-16-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: TryWWeKqOkaaVufMsbYMUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: thuth@redhat.com, me@xcancerberox.com.ar, richard.henderson@linaro.org,
 dovgaluk@ispras.ru, imammedo@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

Few minor comments below.

On 12/18/19 10:03 PM, Michael Rolnik wrote:
> A simple board setup that configures an AVR CPU to run a given firmware i=
mage.
> This is all that's useful to implement without peripheral emulation as AV=
R CPUs include a lot of on-board peripherals.
>=20
> NOTE: this is not a real board !!!!
> NOTE: it's used for CPU testing!!!!
>=20
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Nacked-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   include/elf.h        |   2 +
>   include/hw/elf_ops.h |   6 +-
>   include/hw/loader.h  |   6 +-
>   hw/avr/sample.c      | 293 +++++++++++++++++++++++++++++++++++++++++++
>   hw/core/loader.c     |  15 +--
>   hw/riscv/boot.c      |   2 +-
>   hw/Kconfig           |   1 +
>   hw/avr/Kconfig       |   6 +
>   hw/avr/Makefile.objs |   1 +
>   9 files changed, 321 insertions(+), 11 deletions(-)
>   create mode 100644 hw/avr/sample.c
>   create mode 100644 hw/avr/Kconfig
>   create mode 100644 hw/avr/Makefile.objs
>=20
> diff --git a/include/elf.h b/include/elf.h
> index 3501e0c8d0..53cdfa23b7 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -202,6 +202,8 @@ typedef struct mips_elf_abiflags_v0 {
>   #define EM_MOXIE           223     /* Moxie processor family */
>   #define EM_MOXIE_OLD       0xFEED
>  =20
> +#define EM_AVR 83 /* AVR 8-bit microcontroller */
> +
>   /* This is the info that is needed to parse the dynamic section of the =
file */
>   #define DT_NULL=09=090
>   #define DT_NEEDED=091
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index e07d276df7..70de85fa72 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -316,7 +316,8 @@ static int glue(load_elf, SZ)(const char *name, int f=
d,
>                                 void *translate_opaque,
>                                 int must_swab, uint64_t *pentry,
>                                 uint64_t *lowaddr, uint64_t *highaddr,
> -                              int elf_machine, int clear_lsb, int data_s=
wab,
> +                              uint32_t *pe_flags, int elf_machine,
> +                              int clear_lsb, int data_swab,
>                                 AddressSpace *as, bool load_rom,
>                                 symbol_fn_t sym_cb)
>   {
> @@ -594,6 +595,9 @@ static int glue(load_elf, SZ)(const char *name, int f=
d,
>           }
>       }
>  =20
> +    if (pe_flags) {
> +        *pe_flags =3D (uint32_t)(elf_sword)ehdr.e_flags;
> +    }
>       if (lowaddr)
>           *lowaddr =3D (uint64_t)(elf_sword)low;
>       if (highaddr)
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index 48a96cd559..22b59e15ba 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -101,6 +101,7 @@ const char *load_elf_strerror(int error);
>    * @pentry: Populated with program entry point. Ignored if NULL.
>    * @lowaddr: Populated with lowest loaded address. Ignored if NULL.
>    * @highaddr: Populated with highest loaded address. Ignored if NULL.
> + * @pe_flags: Populated with e_flags. Ignore if NULL.
>    * @bigendian: Expected ELF endianness. 0 for LE otherwise BE
>    * @elf_machine: Expected ELF machine type
>    * @clear_lsb: Set to mask off LSB of addresses (Some architectures use
> @@ -131,8 +132,9 @@ int load_elf_ram_sym(const char *filename,
>                        uint64_t (*elf_note_fn)(void *, void *, bool),
>                        uint64_t (*translate_fn)(void *, uint64_t),
>                        void *translate_opaque, uint64_t *pentry,
> -                     uint64_t *lowaddr, uint64_t *highaddr, int big_endi=
an,
> -                     int elf_machine, int clear_lsb, int data_swab,
> +                     uint64_t *lowaddr, uint64_t *highaddr, uint32_t *pe=
_flags,
> +                     int big_endian, int elf_machine,
> +                     int clear_lsb, int data_swab,
>                        AddressSpace *as, bool load_rom, symbol_fn_t sym_c=
b);
>  =20
>   /** load_elf_ram:
> diff --git a/hw/avr/sample.c b/hw/avr/sample.c
> new file mode 100644
> index 0000000000..4fdbc17f1c
> --- /dev/null
> +++ b/hw/avr/sample.c
> @@ -0,0 +1,293 @@
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
> + *      The CPU is an approximation of an ATmega2560, but is missing var=
ious
> + *      built-in peripherals.
> + *
> + *      This example board loads provided binary file into flash memory =
and
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
> + * Size of additional "external" memory, as if the AVR were configured t=
o use
> + * an external RAM chip.
> + * Note that the configuration registers that normally enable this featu=
re are
> + * unimplemented.
> + */
> +#define SIZE_EXMEM 0x00000000
> +
> +/* Offsets of peripherals in emulated memory space (i.e. not host addres=
ses)  */
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
> +    SampleMachineState *sms =3D SAMPLE_MACHINE(machine);
> +    MemoryRegion *system_memory =3D get_system_memory();
> +    AVRCPU *cpu;
> +    const char *firmware =3D NULL;
> +    const char *filename =3D NULL;
> +    const char *cpu_type =3D NULL;
> +    uint32_t e_flags;
> +    int bytes_loaded;
> +    SysBusDevice *busdev;
> +    DeviceState *cpudev;
> +
> +    system_memory =3D get_system_memory();
> +    sms->ram =3D g_new(MemoryRegion, 1);
> +    sms->flash =3D g_new(MemoryRegion, 1);
> +
> +    /* if ELF file is provided, determine CPU type reading ELF e_flags *=
/
> +    cpu_type =3D machine->cpu_type;
> +    firmware =3D machine->firmware;
> +    if (firmware !=3D NULL) {
> +        filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
> +        if (filename =3D=3D NULL) {
> +            error_report("Unable to find %s", firmware);
> +            exit(1);
> +        }
> +
> +        bytes_loaded =3D load_elf_ram_sym(filename, NULL, NULL, NULL, NU=
LL, NULL,
> +                NULL, &e_flags, 0, EM_AVR, 0, 0, NULL, 0, 0);
> +        if (bytes_loaded > 0) {
> +            cpu_type =3D avr_flags_to_cpu_type(e_flags, cpu_type);
> +        }
> +    }
> +
> +    cpu =3D AVR_CPU(cpu_create(cpu_type));
> +    cpudev =3D DEVICE(cpu);
> +
> +    memory_region_init_rom(sms->flash, NULL, "avr.flash", SIZE_FLASH,
> +            &error_fatal);
> +    memory_region_add_subregion(system_memory, OFFSET_CODE, sms->flash);
> +
> +    /* following are atmel2560 device */
> +    create_unimplemented_device("usart 3", OFFSET_DATA + 0x0130, 0x0007)=
;
> +    create_unimplemented_device("timer-counter-16bit 5",
> +            OFFSET_DATA + 0x0120, 0x000e);
> +    create_unimplemented_device("gpio L", OFFSET_DATA + 0x0109, 0x0003);
> +    create_unimplemented_device("gpio K", OFFSET_DATA + 0x0106, 0x0003);
> +    create_unimplemented_device("gpio J", OFFSET_DATA + 0x0103, 0x0003);
> +    create_unimplemented_device("gpio H", OFFSET_DATA + 0x0100, 0x0003);
> +    create_unimplemented_device("usart 2", OFFSET_DATA + 0x00d0, 0x0007)=
;
> +    create_unimplemented_device("usart 1", OFFSET_DATA + 0x00c8, 0x0007)=
;
> +    create_unimplemented_device("usart 0", OFFSET_DATA + 0x00c0, 0x0007)=
;

"usart 0" is already mapped.

> +    create_unimplemented_device("twi", OFFSET_DATA + 0x00b8, 0x0006);
> +    create_unimplemented_device("timer-counter-async-8bit 2",
> +            OFFSET_DATA + 0x00b0, 0x0007);
> +    create_unimplemented_device("timer-counter-16bit 4",
> +            OFFSET_DATA + 0x00a0, 0x000e);
> +    create_unimplemented_device("timer-counter-16bit 3",
> +            OFFSET_DATA + 0x0090, 0x000e);
> +    create_unimplemented_device("timer-counter-16bit 1",
> +            OFFSET_DATA + 0x0080, 0x000e);

"timer-counter-16bit 1" is already mapped.

> +    create_unimplemented_device("ac / adc",
> +            OFFSET_DATA + 0x0078, 0x0008);
> +    create_unimplemented_device("ext-mem-iface",
> +            OFFSET_DATA + 0x0074, 0x0002);
> +    create_unimplemented_device("int-controller",
> +            OFFSET_DATA + 0x0068, 0x000c);

..., OFFSET_DATA + 0x0068, 0x0006);

> +    create_unimplemented_device("sys",
> +            OFFSET_DATA + 0x0060, 0x0007);
> +    create_unimplemented_device("spi",
> +            OFFSET_DATA + 0x004c, 0x0003);
> +    create_unimplemented_device("ext-mem-iface",
> +            OFFSET_DATA + 0x004a, 0x0002);
> +    create_unimplemented_device("timer-counter-pwm-8bit 0",
> +            OFFSET_DATA + 0x0043, 0x0006);

Per the DS:

..., OFFSET_DATA + 0x0044, 0x0005)


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
> +    memory_region_add_subregion(system_memory, OFFSET_DATA + 0x200, sms-=
>ram);
> +
> +    /* Power Reduction built-in peripheral */
> +    sms->prr[0] =3D AVR_MASK(sysbus_create_simple(TYPE_AVR_MASK,
> +                    OFFSET_DATA + PRR0_BASE, NULL));
> +    sms->prr[1] =3D AVR_MASK(sysbus_create_simple(TYPE_AVR_MASK,
> +                    OFFSET_DATA + PRR1_BASE, NULL));
> +
> +    /* USART 0 built-in peripheral */
> +    sms->usart0 =3D AVR_USART(object_new(TYPE_AVR_USART));
> +    busdev =3D SYS_BUS_DEVICE(sms->usart0);
> +    qdev_prop_set_chr(DEVICE(sms->usart0), "chardev", serial_hd(0));
> +    object_property_set_bool(OBJECT(sms->usart0), true, "realized",
> +            &error_fatal);
> +    sysbus_mmio_map(busdev, 0, OFFSET_DATA + USART_BASE);
> +    /*
> +     * These IRQ numbers don't match the datasheet because we're countin=
g from
> +     * zero and not including reset.
> +     */
> +    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev, USART_RXC_IRQ=
));
> +    sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev, USART_DRE_IRQ=
));
> +    sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev, USART_TXC_IRQ=
));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(sms->prr[1]), PRR1_BIT_PRUSART1,
> +            qdev_get_gpio_in(DEVICE(sms->usart0), 0));
> +
> +    /* Timer 1 built-in periphal */
> +    sms->timer1 =3D AVR_TIMER16(object_new(TYPE_AVR_TIMER16));

IIUC, here you create the timer with a default value of 20MHz:

static Property avr_timer16_properties[] =3D {
     DEFINE_PROP_UINT8("id", struct AVRTimer16State, id, 0),
     DEFINE_PROP_UINT64("cpu-frequency-hz", struct AVRTimer16State,
                        cpu_freq_hz, 20000000),
     DEFINE_PROP_END_OF_LIST(),
};

Then then the test you run is compiled for a 16MHz timer:

https://github.com/seharris/qemu-avr-tests/blob/master/free-rtos/Demo/AVR_A=
TMega2560_GCC/FreeRTOSConfig.h#L48

#define configCPU_CLOCK_HZ=09=09=09( ( unsigned long ) 16000000 )

So I guess your sample board misses:

        object_property_set_uint(OBJECT(sms->timer1), 16000000,
                                 "cpu-frequency-hz", &error_abort);

> +    object_property_set_bool(OBJECT(sms->timer1), true, "realized",
> +            &error_fatal);
> +    busdev =3D SYS_BUS_DEVICE(sms->timer1);
> +    sysbus_mmio_map(busdev, 0, OFFSET_DATA + TIMER1_BASE);
> +    sysbus_mmio_map(busdev, 1, OFFSET_DATA + TIMER1_IMSK_BASE);
> +    sysbus_mmio_map(busdev, 2, OFFSET_DATA + TIMER1_IFR_BASE);
> +    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev, TIMER1_CAPT_I=
RQ));
> +    sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev, TIMER1_COMPA_=
IRQ));
> +    sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev, TIMER1_COMPB_=
IRQ));
> +    sysbus_connect_irq(busdev, 3, qdev_get_gpio_in(cpudev, TIMER1_COMPC_=
IRQ));
> +    sysbus_connect_irq(busdev, 4, qdev_get_gpio_in(cpudev, TIMER1_OVF_IR=
Q));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(sms->prr[0]), PRR0_BIT_PRTIM1,
> +            qdev_get_gpio_in(DEVICE(sms->timer1), 0));
> +
> +    /* Load firmware (contents of flash) trying to auto-detect format */
> +    if (filename !=3D NULL) {
> +        bytes_loaded =3D load_elf(
> +            filename, NULL, NULL, NULL, NULL, NULL, NULL, 0, EM_NONE, 0,=
 0);
> +        if (bytes_loaded < 0) {
> +            bytes_loaded =3D load_image_targphys(
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
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    mc->desc =3D "AVR sample/example board (ATmega2560)";
> +    mc->init =3D sample_init;
> +    mc->default_cpus =3D 1;
> +    mc->min_cpus =3D mc->default_cpus;
> +    mc->max_cpus =3D mc->default_cpus;
> +    mc->default_cpu_type =3D "avr6-avr-cpu"; /* ATmega2560. */

Please use AVR_CPU_TYPE_NAME("avr6").

> +    mc->is_default =3D 1;
> +}
> +
> +static const TypeInfo sample_info =3D {
> +    .name =3D TYPE_SAMPLE_MACHINE,
> +    .parent =3D TYPE_MACHINE,
> +    .instance_size =3D sizeof(SampleMachineState),
> +    .class_size =3D sizeof(SampleMachineClass),
> +    .class_init =3D sample_class_init,
> +};
> +
> +static void sample_machine_init(void)
> +{
> +    type_register_static(&sample_info);
> +}
> +
> +type_init(sample_machine_init);
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 5099f27dc8..9961b4423b 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -438,7 +438,7 @@ int load_elf_ram(const char *filename,
>   {
>       return load_elf_ram_sym(filename, elf_note_fn,
>                               translate_fn, translate_opaque,
> -                            pentry, lowaddr, highaddr, big_endian,
> +                            pentry, lowaddr, highaddr, NULL, big_endian,
>                               elf_machine, clear_lsb, data_swab, as,
>                               load_rom, NULL);
>   }
> @@ -448,8 +448,9 @@ int load_elf_ram_sym(const char *filename,
>                        uint64_t (*elf_note_fn)(void *, void *, bool),
>                        uint64_t (*translate_fn)(void *, uint64_t),
>                        void *translate_opaque, uint64_t *pentry,
> -                     uint64_t *lowaddr, uint64_t *highaddr, int big_endi=
an,
> -                     int elf_machine, int clear_lsb, int data_swab,
> +                     uint64_t *lowaddr, uint64_t *highaddr, uint32_t *pe=
_flags,
> +                     int big_endian, int elf_machine,
> +                     int clear_lsb, int data_swab,
>                        AddressSpace *as, bool load_rom, symbol_fn_t sym_c=
b)
>   {
>       int fd, data_order, target_data_order, must_swab, ret =3D ELF_LOAD_=
FAILED;
> @@ -490,13 +491,13 @@ int load_elf_ram_sym(const char *filename,
>       if (e_ident[EI_CLASS] =3D=3D ELFCLASS64) {
>           ret =3D load_elf64(filename, fd, elf_note_fn,
>                            translate_fn, translate_opaque, must_swab,
> -                         pentry, lowaddr, highaddr, elf_machine, clear_l=
sb,
> -                         data_swab, as, load_rom, sym_cb);
> +                         pentry, lowaddr, highaddr, pe_flags, elf_machin=
e,
> +                         clear_lsb, data_swab, as, load_rom, sym_cb);
>       } else {
>           ret =3D load_elf32(filename, fd, elf_note_fn,
>                            translate_fn, translate_opaque, must_swab,
> -                         pentry, lowaddr, highaddr, elf_machine, clear_l=
sb,
> -                         data_swab, as, load_rom, sym_cb);
> +                         pentry, lowaddr, highaddr, pe_flags, elf_machin=
e,
> +                         clear_lsb, data_swab, as, load_rom, sym_cb);
>       }
>  =20
>    fail:
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 027303d2a3..746ca1f795 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -119,7 +119,7 @@ target_ulong riscv_load_kernel(const char *kernel_fil=
ename, symbol_fn_t sym_cb)
>       uint64_t kernel_entry, kernel_high;
>  =20
>       if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
> -                         &kernel_entry, NULL, &kernel_high, 0,
> +                         &kernel_entry, NULL, &kernel_high, NULL, 0,
>                            EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
>           return kernel_entry;
>       }
> diff --git a/hw/Kconfig b/hw/Kconfig
> index ecf491bf04..f80dff3b75 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -43,6 +43,7 @@ source watchdog/Kconfig
>   # arch Kconfig
>   source arm/Kconfig
>   source alpha/Kconfig
> +source avr/Kconfig
>   source cris/Kconfig
>   source hppa/Kconfig
>   source i386/Kconfig
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
> +obj-y +=3D sample.o
>=20


