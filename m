Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D413BC2D0D2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A3B21655
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMgOwZQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A3B21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiHU6-0008E6-Av
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iiHRY-0005fl-Qa
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:31:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iiHRT-0003h9-GE
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:31:44 -0500
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:32853)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iiHRT-0003bu-0U
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:31:39 -0500
Received: by mail-qv1-xf41.google.com with SMTP id z3so3552734qvn.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 04:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5JsOed9Tz6fjPPGWXzf3Vj1AsdtJB3wNbF1YXUCR0ZM=;
 b=hMgOwZQeg3YeWwZqR2wYyfHJgSzAHIJK7W8bdEdZrHXr9GVxKwlaBOfjdBfByqze49
 NcDSvvv27PO+MlZtoyNRcACsu4iKrCMH5dIfPuvTKZ1ipCcNSYsLBAAY93wBYYviU0OR
 iXkcGn2g7PgxcyQQTxGfa2DoZGGbjAOU/NVGaORywAtltn7oOS5Ysm4SMj9SdTmGDb3s
 LVbwMXy0g96NCHJkUt9heQf7fWiROu/KVvEuCNS4PxaqKUSEKxCBaoSCRf0O/82wBV/o
 +Ij0U68MzS+EhrLSymPkKI2PLhetG0TSvoXCOhDwDOGPs/qpBW1IJQVdaq2udCtr0Mqk
 mHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5JsOed9Tz6fjPPGWXzf3Vj1AsdtJB3wNbF1YXUCR0ZM=;
 b=VArUwd7ZGkVSdT4VYC8sEDxkMcsjDYgQywCwlXdePQ1wRVttXhVuX8jDSLats/vvtE
 4YXjBohclfvT7RtPuUSv71xKXqJ5eH0JkjBPgAn4Car6xXuX/eQAPvFFjANs09bR296i
 NMX9W7sWkCAqzcTXTQrCXyJmz55aPMJyUhH+5xA7KCCOdAJJ1NRCweP6XZWlM0vooq+Y
 8eKxSXCQIWsvn5Tc0tg4zo4g/2uMUomnT5zQD6mJPMQE6cW+B7E212GrE9jdeXP0oDjl
 93NS8ae7hO5T73P7QBCAhH8afeHw1NIYo1Vk7SSNHJWdVgCyiXFjR/kX1iaMhNxyQSR/
 /lnw==
X-Gm-Message-State: APjAAAWG4fEl5NY6VaNOSiWH9wjg/bQNrcBInpPVRANBxYENywcuk00G
 3KVwUDG9hr+ng+zA6cm+X6ff0r7mlR5R27z9yN8=
X-Google-Smtp-Source: APXvYqzqQZ0p+98uHLjkXsVgADeAQPr1PINTfdVwsQJQoYAH/IlZjjaRCpWjHAQoE5Rgw/qIwLMDveJg2wa4bRwOBIw=
X-Received: by 2002:a05:6214:1348:: with SMTP id
 b8mr12152577qvw.137.1576845097573; 
 Fri, 20 Dec 2019 04:31:37 -0800 (PST)
MIME-Version: 1.0
References: <20191218210329.1960-1-mrolnik@gmail.com>
 <20191218210329.1960-16-mrolnik@gmail.com>
 <20191220105135.2fac74f4@redhat.com>
In-Reply-To: <20191220105135.2fac74f4@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Fri, 20 Dec 2019 14:30:47 +0200
Message-ID: <CAK4993gggZ+ZvyuyHhXUMXvmVz5R8T8=UOkr9ykNo+t+iecn5A@mail.gmail.com>
Subject: Re: [PATCH v39 15/22] target/avr: Add example board configuration
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e82916059a21db44"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f41
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
Cc: Thomas Huth <thuth@redhat.com>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e82916059a21db44
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Igor.

I don't find where machine->ram is defined.

Regards,
Michael Rolnik

On Fri, Dec 20, 2019 at 11:51 AM Igor Mammedov <imammedo@redhat.com> wrote:

> On Wed, 18 Dec 2019 23:03:22 +0200
> Michael Rolnik <mrolnik@gmail.com> wrote:
>
> > A simple board setup that configures an AVR CPU to run a given firmware
> image.
> > This is all that's useful to implement without peripheral emulation as
> AVR CPUs include a lot of on-board peripherals.
> >
> > NOTE: this is not a real board !!!!
> > NOTE: it's used for CPU testing!!!!
> >
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > Nacked-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >  include/elf.h        |   2 +
> >  include/hw/elf_ops.h |   6 +-
> >  include/hw/loader.h  |   6 +-
> >  hw/avr/sample.c      | 293 +++++++++++++++++++++++++++++++++++++++++++
> >  hw/core/loader.c     |  15 +--
> >  hw/riscv/boot.c      |   2 +-
> >  hw/Kconfig           |   1 +
> >  hw/avr/Kconfig       |   6 +
> >  hw/avr/Makefile.objs |   1 +
> >  9 files changed, 321 insertions(+), 11 deletions(-)
> >  create mode 100644 hw/avr/sample.c
> >  create mode 100644 hw/avr/Kconfig
> >  create mode 100644 hw/avr/Makefile.objs
> >
> > diff --git a/include/elf.h b/include/elf.h
> > index 3501e0c8d0..53cdfa23b7 100644
> > --- a/include/elf.h
> > +++ b/include/elf.h
> > @@ -202,6 +202,8 @@ typedef struct mips_elf_abiflags_v0 {
> >  #define EM_MOXIE           223     /* Moxie processor family */
> >  #define EM_MOXIE_OLD       0xFEED
> >
> > +#define EM_AVR 83 /* AVR 8-bit microcontroller */
> > +
> >  /* This is the info that is needed to parse the dynamic section of the
> file */
> >  #define DT_NULL              0
> >  #define DT_NEEDED    1
> > diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> > index e07d276df7..70de85fa72 100644
> > --- a/include/hw/elf_ops.h
> > +++ b/include/hw/elf_ops.h
> > @@ -316,7 +316,8 @@ static int glue(load_elf, SZ)(const char *name, int
> fd,
> >                                void *translate_opaque,
> >                                int must_swab, uint64_t *pentry,
> >                                uint64_t *lowaddr, uint64_t *highaddr,
> > -                              int elf_machine, int clear_lsb, int
> data_swab,
> > +                              uint32_t *pe_flags, int elf_machine,
> > +                              int clear_lsb, int data_swab,
> >                                AddressSpace *as, bool load_rom,
> >                                symbol_fn_t sym_cb)
> >  {
> > @@ -594,6 +595,9 @@ static int glue(load_elf, SZ)(const char *name, int
> fd,
> >          }
> >      }
> >
> > +    if (pe_flags) {
> > +        *pe_flags =3D (uint32_t)(elf_sword)ehdr.e_flags;
> > +    }
> >      if (lowaddr)
> >          *lowaddr =3D (uint64_t)(elf_sword)low;
> >      if (highaddr)
> > diff --git a/include/hw/loader.h b/include/hw/loader.h
> > index 48a96cd559..22b59e15ba 100644
> > --- a/include/hw/loader.h
> > +++ b/include/hw/loader.h
> > @@ -101,6 +101,7 @@ const char *load_elf_strerror(int error);
> >   * @pentry: Populated with program entry point. Ignored if NULL.
> >   * @lowaddr: Populated with lowest loaded address. Ignored if NULL.
> >   * @highaddr: Populated with highest loaded address. Ignored if NULL.
> > + * @pe_flags: Populated with e_flags. Ignore if NULL.
> >   * @bigendian: Expected ELF endianness. 0 for LE otherwise BE
> >   * @elf_machine: Expected ELF machine type
> >   * @clear_lsb: Set to mask off LSB of addresses (Some architectures us=
e
> > @@ -131,8 +132,9 @@ int load_elf_ram_sym(const char *filename,
> >                       uint64_t (*elf_note_fn)(void *, void *, bool),
> >                       uint64_t (*translate_fn)(void *, uint64_t),
> >                       void *translate_opaque, uint64_t *pentry,
> > -                     uint64_t *lowaddr, uint64_t *highaddr, int
> big_endian,
> > -                     int elf_machine, int clear_lsb, int data_swab,
> > +                     uint64_t *lowaddr, uint64_t *highaddr, uint32_t
> *pe_flags,
> > +                     int big_endian, int elf_machine,
> > +                     int clear_lsb, int data_swab,
> >                       AddressSpace *as, bool load_rom, symbol_fn_t
> sym_cb);
> >
> >  /** load_elf_ram:
> > diff --git a/hw/avr/sample.c b/hw/avr/sample.c
> > new file mode 100644
> > index 0000000000..4fdbc17f1c
> > --- /dev/null
> > +++ b/hw/avr/sample.c
> > @@ -0,0 +1,293 @@
> > +/*
> > + * QEMU AVR CPU
> > + *
> > + * Copyright (c) 2019 Michael Rolnik
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2.1 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see
> > + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> > + */
> > +
> > +/*
> > + *  NOTE:
> > + *      This is not a real AVR board, this is an example!
> > + *      The CPU is an approximation of an ATmega2560, but is missing
> various
> > + *      built-in peripherals.
> > + *
> > + *      This example board loads provided binary file into flash memor=
y
> and
> > + *      executes it from 0x00000000 address in the code memory space.
> > + *
> > + *      Currently used for AVR CPU validation
> > + *
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qemu-common.h"
> > +#include "cpu.h"
> > +#include "hw/hw.h"
> > +#include "sysemu/sysemu.h"
> > +#include "sysemu/qtest.h"
> > +#include "ui/console.h"
> > +#include "hw/boards.h"
> > +#include "hw/loader.h"
> > +#include "qemu/error-report.h"
> > +#include "exec/address-spaces.h"
> > +#include "include/hw/sysbus.h"
> > +#include "include/hw/char/avr_usart.h"
> > +#include "include/hw/timer/avr_timer16.h"
> > +#include "include/hw/misc/avr_mask.h"
> > +#include "elf.h"
> > +#include "hw/misc/unimp.h"
> > +
> > +#define SIZE_FLASH 0x00040000
> > +#define SIZE_SRAM 0x00002000
> > +/*
> > + * Size of additional "external" memory, as if the AVR were configured
> to use
> > + * an external RAM chip.
> > + * Note that the configuration registers that normally enable this
> feature are
> > + * unimplemented.
> > + */
> > +#define SIZE_EXMEM 0x00000000
> > +
> > +/* Offsets of peripherals in emulated memory space (i.e. not host
> addresses)  */
> > +#define PRR0_BASE 0x64
> > +#define PRR1_BASE 0x65
> > +#define USART_BASE 0xc0
> > +#define TIMER1_BASE 0x80
> > +#define TIMER1_IMSK_BASE 0x6f
> > +#define TIMER1_IFR_BASE 0x36
> > +
> > +/* Interrupt numbers used by peripherals */
> > +#define USART_RXC_IRQ 24
> > +#define USART_DRE_IRQ 25
> > +#define USART_TXC_IRQ 26
> > +
> > +#define TIMER1_CAPT_IRQ 15
> > +#define TIMER1_COMPA_IRQ 16
> > +#define TIMER1_COMPB_IRQ 17
> > +#define TIMER1_COMPC_IRQ 18
> > +#define TIMER1_OVF_IRQ 19
> > +
> > +/*  Power reduction     */
> > +#define PRR1_BIT_PRTIM5     0x05    /*  Timer/Counter5  */
> > +#define PRR1_BIT_PRTIM4     0x04    /*  Timer/Counter4  */
> > +#define PRR1_BIT_PRTIM3     0x03    /*  Timer/Counter3  */
> > +#define PRR1_BIT_PRUSART3   0x02    /*  USART3  */
> > +#define PRR1_BIT_PRUSART2   0x01    /*  USART2  */
> > +#define PRR1_BIT_PRUSART1   0x00    /*  USART1  */
> > +
> > +#define PRR0_BIT_PRTWI      0x06    /*  TWI */
> > +#define PRR0_BIT_PRTIM2     0x05    /*  Timer/Counter2  */
> > +#define PRR0_BIT_PRTIM0     0x04    /*  Timer/Counter0  */
> > +#define PRR0_BIT_PRTIM1     0x03    /*  Timer/Counter1  */
> > +#define PRR0_BIT_PRSPI      0x02    /*  Serial Peripheral Interface */
> > +#define PRR0_BIT_PRUSART0   0x01    /*  USART0  */
> > +#define PRR0_BIT_PRADC      0x00    /*  ADC */
> > +
> > +typedef struct {
> > +    MachineClass parent;
> > +} SampleMachineClass;
> > +
> > +typedef struct {
> > +    MachineState parent;
> > +    MemoryRegion *ram;
> > +    MemoryRegion *flash;
> > +    AVRUsartState *usart0;
> > +    AVRTimer16State *timer1;
> > +    AVRMaskState *prr[2];
> > +} SampleMachineState;
> > +
> > +#define TYPE_SAMPLE_MACHINE MACHINE_TYPE_NAME("sample")
> > +
> > +#define SAMPLE_MACHINE(obj) \
> > +    OBJECT_CHECK(SampleMachineState, obj, TYPE_SAMPLE_MACHINE)
> > +#define SAMPLE_MACHINE_GET_CLASS(obj) \
> > +    OBJECT_GET_CLASS(SampleMachineClass, obj, TYPE_SAMPLE_MACHINE)
> > +#define SAMPLE_MACHINE_CLASS(klass) \
> > +    OBJECT_CLASS_CHECK(SampleMachineClass, klass, TYPE_SAMPLE_MACHINE)
> > +
> > +static void sample_init(MachineState *machine)
> > +{
> > +    SampleMachineState *sms =3D SAMPLE_MACHINE(machine);
> > +    MemoryRegion *system_memory =3D get_system_memory();
> > +    AVRCPU *cpu;
> > +    const char *firmware =3D NULL;
> > +    const char *filename =3D NULL;
> > +    const char *cpu_type =3D NULL;
> > +    uint32_t e_flags;
> > +    int bytes_loaded;
> > +    SysBusDevice *busdev;
> > +    DeviceState *cpudev;
> > +
> > +    system_memory =3D get_system_memory();
> > +    sms->ram =3D g_new(MemoryRegion, 1);
> > +    sms->flash =3D g_new(MemoryRegion, 1);
> > +
> > +    /* if ELF file is provided, determine CPU type reading ELF e_flags
> */
> > +    cpu_type =3D machine->cpu_type;
> > +    firmware =3D machine->firmware;
> > +    if (firmware !=3D NULL) {
> > +        filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
> > +        if (filename =3D=3D NULL) {
> > +            error_report("Unable to find %s", firmware);
> > +            exit(1);
> > +        }
> > +
> > +        bytes_loaded =3D load_elf_ram_sym(filename, NULL, NULL, NULL,
> NULL, NULL,
> > +                NULL, &e_flags, 0, EM_AVR, 0, 0, NULL, 0, 0);
> > +        if (bytes_loaded > 0) {
> > +            cpu_type =3D avr_flags_to_cpu_type(e_flags, cpu_type);
> > +        }
> > +    }
> > +
> > +    cpu =3D AVR_CPU(cpu_create(cpu_type));
> > +    cpudev =3D DEVICE(cpu);
> > +
> > +    memory_region_init_rom(sms->flash, NULL, "avr.flash", SIZE_FLASH,
> > +            &error_fatal);
> > +    memory_region_add_subregion(system_memory, OFFSET_CODE, sms->flash=
);
> > +
> > +    /* following are atmel2560 device */
> > +    create_unimplemented_device("usart 3", OFFSET_DATA + 0x0130,
> 0x0007);
> > +    create_unimplemented_device("timer-counter-16bit 5",
> > +            OFFSET_DATA + 0x0120, 0x000e);
> > +    create_unimplemented_device("gpio L", OFFSET_DATA + 0x0109, 0x0003=
);
> > +    create_unimplemented_device("gpio K", OFFSET_DATA + 0x0106, 0x0003=
);
> > +    create_unimplemented_device("gpio J", OFFSET_DATA + 0x0103, 0x0003=
);
> > +    create_unimplemented_device("gpio H", OFFSET_DATA + 0x0100, 0x0003=
);
> > +    create_unimplemented_device("usart 2", OFFSET_DATA + 0x00d0,
> 0x0007);
> > +    create_unimplemented_device("usart 1", OFFSET_DATA + 0x00c8,
> 0x0007);
> > +    create_unimplemented_device("usart 0", OFFSET_DATA + 0x00c0,
> 0x0007);
> > +    create_unimplemented_device("twi", OFFSET_DATA + 0x00b8, 0x0006);
> > +    create_unimplemented_device("timer-counter-async-8bit 2",
> > +            OFFSET_DATA + 0x00b0, 0x0007);
> > +    create_unimplemented_device("timer-counter-16bit 4",
> > +            OFFSET_DATA + 0x00a0, 0x000e);
> > +    create_unimplemented_device("timer-counter-16bit 3",
> > +            OFFSET_DATA + 0x0090, 0x000e);
> > +    create_unimplemented_device("timer-counter-16bit 1",
> > +            OFFSET_DATA + 0x0080, 0x000e);
> > +    create_unimplemented_device("ac / adc",
> > +            OFFSET_DATA + 0x0078, 0x0008);
> > +    create_unimplemented_device("ext-mem-iface",
> > +            OFFSET_DATA + 0x0074, 0x0002);
> > +    create_unimplemented_device("int-controller",
> > +            OFFSET_DATA + 0x0068, 0x000c);
> > +    create_unimplemented_device("sys",
> > +            OFFSET_DATA + 0x0060, 0x0007);
> > +    create_unimplemented_device("spi",
> > +            OFFSET_DATA + 0x004c, 0x0003);
> > +    create_unimplemented_device("ext-mem-iface",
> > +            OFFSET_DATA + 0x004a, 0x0002);
> > +    create_unimplemented_device("timer-counter-pwm-8bit 0",
> > +            OFFSET_DATA + 0x0043, 0x0006);
> > +    create_unimplemented_device("ext-mem-iface",
> > +            OFFSET_DATA + 0x003e, 0x0005);
> > +    create_unimplemented_device("int-controller",
> > +            OFFSET_DATA + 0x0035, 0x0009);
> > +    create_unimplemented_device("gpio G", OFFSET_DATA + 0x0032, 0x0003=
);
> > +    create_unimplemented_device("gpio F", OFFSET_DATA + 0x002f, 0x0003=
);
> > +    create_unimplemented_device("gpio E", OFFSET_DATA + 0x002c, 0x0003=
);
> > +    create_unimplemented_device("gpio D", OFFSET_DATA + 0x0029, 0x0003=
);
> > +    create_unimplemented_device("gpio C", OFFSET_DATA + 0x0026, 0x0003=
);
> > +    create_unimplemented_device("gpio B", OFFSET_DATA + 0x0023, 0x0003=
);
> > +    create_unimplemented_device("gpio A", OFFSET_DATA + 0x0020, 0x0003=
);
> > +
> > +    memory_region_allocate_system_memory(
> > +        sms->ram, NULL, "avr.ram", SIZE_SRAM + SIZE_EXMEM);
>
> Please use MachineClass::default_ram_size and add check that '-m' values
> matches it.
> See for example
>
> https://github.com/imammedo/qemu/commit/241c65d506ccba1e0239a2bc0632d7dc9=
c3517c1
>
> (if you respin amend this patch but otherwise it could be a patch on top
> of this series)
>
> > +    memory_region_add_subregion(system_memory, OFFSET_DATA + 0x200,
> sms->ram);
> > +
> > +    /* Power Reduction built-in peripheral */
> > +    sms->prr[0] =3D AVR_MASK(sysbus_create_simple(TYPE_AVR_MASK,
> > +                    OFFSET_DATA + PRR0_BASE, NULL));
> > +    sms->prr[1] =3D AVR_MASK(sysbus_create_simple(TYPE_AVR_MASK,
> > +                    OFFSET_DATA + PRR1_BASE, NULL));
> > +
> > +    /* USART 0 built-in peripheral */
> > +    sms->usart0 =3D AVR_USART(object_new(TYPE_AVR_USART));
> > +    busdev =3D SYS_BUS_DEVICE(sms->usart0);
> > +    qdev_prop_set_chr(DEVICE(sms->usart0), "chardev", serial_hd(0));
> > +    object_property_set_bool(OBJECT(sms->usart0), true, "realized",
> > +            &error_fatal);
> > +    sysbus_mmio_map(busdev, 0, OFFSET_DATA + USART_BASE);
> > +    /*
> > +     * These IRQ numbers don't match the datasheet because we're
> counting from
> > +     * zero and not including reset.
> > +     */
> > +    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev,
> USART_RXC_IRQ));
> > +    sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev,
> USART_DRE_IRQ));
> > +    sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev,
> USART_TXC_IRQ));
> > +    sysbus_connect_irq(SYS_BUS_DEVICE(sms->prr[1]), PRR1_BIT_PRUSART1,
> > +            qdev_get_gpio_in(DEVICE(sms->usart0), 0));
> > +
> > +    /* Timer 1 built-in periphal */
> > +    sms->timer1 =3D AVR_TIMER16(object_new(TYPE_AVR_TIMER16));
> > +    object_property_set_bool(OBJECT(sms->timer1), true, "realized",
> > +            &error_fatal);
> > +    busdev =3D SYS_BUS_DEVICE(sms->timer1);
> > +    sysbus_mmio_map(busdev, 0, OFFSET_DATA + TIMER1_BASE);
> > +    sysbus_mmio_map(busdev, 1, OFFSET_DATA + TIMER1_IMSK_BASE);
> > +    sysbus_mmio_map(busdev, 2, OFFSET_DATA + TIMER1_IFR_BASE);
> > +    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev,
> TIMER1_CAPT_IRQ));
> > +    sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev,
> TIMER1_COMPA_IRQ));
> > +    sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev,
> TIMER1_COMPB_IRQ));
> > +    sysbus_connect_irq(busdev, 3, qdev_get_gpio_in(cpudev,
> TIMER1_COMPC_IRQ));
> > +    sysbus_connect_irq(busdev, 4, qdev_get_gpio_in(cpudev,
> TIMER1_OVF_IRQ));
> > +    sysbus_connect_irq(SYS_BUS_DEVICE(sms->prr[0]), PRR0_BIT_PRTIM1,
> > +            qdev_get_gpio_in(DEVICE(sms->timer1), 0));
> > +
> > +    /* Load firmware (contents of flash) trying to auto-detect format =
*/
> > +    if (filename !=3D NULL) {
> > +        bytes_loaded =3D load_elf(
> > +            filename, NULL, NULL, NULL, NULL, NULL, NULL, 0, EM_NONE,
> 0, 0);
> > +        if (bytes_loaded < 0) {
> > +            bytes_loaded =3D load_image_targphys(
> > +                filename, OFFSET_CODE, SIZE_FLASH);
> > +        }
> > +        if (bytes_loaded < 0) {
> > +            error_report(
> > +                "Unable to load firmware image %s as ELF or raw binary=
",
> > +                firmware);
> > +            exit(1);
> > +        }
> > +    }
> > +}
> > +
> > +static void sample_class_init(ObjectClass *oc, void *data)
> > +{
> > +    MachineClass *mc =3D MACHINE_CLASS(oc);
> > +
> > +    mc->desc =3D "AVR sample/example board (ATmega2560)";
> > +    mc->init =3D sample_init;
> > +    mc->default_cpus =3D 1;
> > +    mc->min_cpus =3D mc->default_cpus;
> > +    mc->max_cpus =3D mc->default_cpus;
> > +    mc->default_cpu_type =3D "avr6-avr-cpu"; /* ATmega2560. */
> > +    mc->is_default =3D 1;
> > +}
> > +
> > +static const TypeInfo sample_info =3D {
> > +    .name =3D TYPE_SAMPLE_MACHINE,
> > +    .parent =3D TYPE_MACHINE,
> > +    .instance_size =3D sizeof(SampleMachineState),
> > +    .class_size =3D sizeof(SampleMachineClass),
> > +    .class_init =3D sample_class_init,
> > +};
> > +
> > +static void sample_machine_init(void)
> > +{
> > +    type_register_static(&sample_info);
> > +}
> > +
> > +type_init(sample_machine_init);
> > diff --git a/hw/core/loader.c b/hw/core/loader.c
> > index 5099f27dc8..9961b4423b 100644
> > --- a/hw/core/loader.c
> > +++ b/hw/core/loader.c
> > @@ -438,7 +438,7 @@ int load_elf_ram(const char *filename,
> >  {
> >      return load_elf_ram_sym(filename, elf_note_fn,
> >                              translate_fn, translate_opaque,
> > -                            pentry, lowaddr, highaddr, big_endian,
> > +                            pentry, lowaddr, highaddr, NULL, big_endia=
n,
> >                              elf_machine, clear_lsb, data_swab, as,
> >                              load_rom, NULL);
> >  }
> > @@ -448,8 +448,9 @@ int load_elf_ram_sym(const char *filename,
> >                       uint64_t (*elf_note_fn)(void *, void *, bool),
> >                       uint64_t (*translate_fn)(void *, uint64_t),
> >                       void *translate_opaque, uint64_t *pentry,
> > -                     uint64_t *lowaddr, uint64_t *highaddr, int
> big_endian,
> > -                     int elf_machine, int clear_lsb, int data_swab,
> > +                     uint64_t *lowaddr, uint64_t *highaddr, uint32_t
> *pe_flags,
> > +                     int big_endian, int elf_machine,
> > +                     int clear_lsb, int data_swab,
> >                       AddressSpace *as, bool load_rom, symbol_fn_t
> sym_cb)
> >  {
> >      int fd, data_order, target_data_order, must_swab, ret =3D
> ELF_LOAD_FAILED;
> > @@ -490,13 +491,13 @@ int load_elf_ram_sym(const char *filename,
> >      if (e_ident[EI_CLASS] =3D=3D ELFCLASS64) {
> >          ret =3D load_elf64(filename, fd, elf_note_fn,
> >                           translate_fn, translate_opaque, must_swab,
> > -                         pentry, lowaddr, highaddr, elf_machine,
> clear_lsb,
> > -                         data_swab, as, load_rom, sym_cb);
> > +                         pentry, lowaddr, highaddr, pe_flags,
> elf_machine,
> > +                         clear_lsb, data_swab, as, load_rom, sym_cb);
> >      } else {
> >          ret =3D load_elf32(filename, fd, elf_note_fn,
> >                           translate_fn, translate_opaque, must_swab,
> > -                         pentry, lowaddr, highaddr, elf_machine,
> clear_lsb,
> > -                         data_swab, as, load_rom, sym_cb);
> > +                         pentry, lowaddr, highaddr, pe_flags,
> elf_machine,
> > +                         clear_lsb, data_swab, as, load_rom, sym_cb);
> >      }
> >
> >   fail:
> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > index 027303d2a3..746ca1f795 100644
> > --- a/hw/riscv/boot.c
> > +++ b/hw/riscv/boot.c
> > @@ -119,7 +119,7 @@ target_ulong riscv_load_kernel(const char
> *kernel_filename, symbol_fn_t sym_cb)
> >      uint64_t kernel_entry, kernel_high;
> >
> >      if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
> > -                         &kernel_entry, NULL, &kernel_high, 0,
> > +                         &kernel_entry, NULL, &kernel_high, NULL, 0,
> >                           EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
> >          return kernel_entry;
> >      }
> > diff --git a/hw/Kconfig b/hw/Kconfig
> > index ecf491bf04..f80dff3b75 100644
> > --- a/hw/Kconfig
> > +++ b/hw/Kconfig
> > @@ -43,6 +43,7 @@ source watchdog/Kconfig
> >  # arch Kconfig
> >  source arm/Kconfig
> >  source alpha/Kconfig
> > +source avr/Kconfig
> >  source cris/Kconfig
> >  source hppa/Kconfig
> >  source i386/Kconfig
> > diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
> > new file mode 100644
> > index 0000000000..92aa1e6afb
> > --- /dev/null
> > +++ b/hw/avr/Kconfig
> > @@ -0,0 +1,6 @@
> > +config AVR_SAMPLE
> > +    bool
> > +    select AVR_TIMER16
> > +    select AVR_USART
> > +    select AVR_MASK
> > +    select UNIMP
> > diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
> > new file mode 100644
> > index 0000000000..626b7064b3
> > --- /dev/null
> > +++ b/hw/avr/Makefile.objs
> > @@ -0,0 +1 @@
> > +obj-y +=3D sample.o
>
>

--=20
Best Regards,
Michael Rolnik

--000000000000e82916059a21db44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Igor.<div><br></div><div>I don&#39;t find where machine=
-&gt;ram is defined.</div><div><br></div><div>Regards,</div><div>Michael Ro=
lnik</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Fri, Dec 20, 2019 at 11:51 AM Igor Mammedov &lt;<a href=3D"mai=
lto:imammedo@redhat.com">imammedo@redhat.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On Wed, 18 Dec 2019 23:03:22 +0=
200<br>
Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">m=
rolnik@gmail.com</a>&gt; wrote:<br>
<br>
&gt; A simple board setup that configures an AVR CPU to run a given firmwar=
e image.<br>
&gt; This is all that&#39;s useful to implement without peripheral emulatio=
n as AVR CPUs include a lot of on-board peripherals.<br>
&gt; <br>
&gt; NOTE: this is not a real board !!!!<br>
&gt; NOTE: it&#39;s used for CPU testing!!!!<br>
&gt; <br>
&gt; Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com"=
 target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavec=
omp.com" target=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
&gt; Nacked-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@re=
dhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/elf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 include/hw/elf_ops.h |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 include/hw/loader.h=C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 hw/avr/sample.c=C2=A0 =C2=A0 =C2=A0 | 293 ++++++++++++++++++++++=
+++++++++++++++++++++<br>
&gt;=C2=A0 hw/core/loader.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 15 +--<br>
&gt;=C2=A0 hw/riscv/boot.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 hw/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A01 +<br>
&gt;=C2=A0 hw/avr/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +<br>
&gt;=C2=A0 hw/avr/Makefile.objs |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 9 files changed, 321 insertions(+), 11 deletions(-)<br>
&gt;=C2=A0 create mode 100644 hw/avr/sample.c<br>
&gt;=C2=A0 create mode 100644 hw/avr/Kconfig<br>
&gt;=C2=A0 create mode 100644 hw/avr/Makefile.objs<br>
&gt; <br>
&gt; diff --git a/include/elf.h b/include/elf.h<br>
&gt; index 3501e0c8d0..53cdfa23b7 100644<br>
&gt; --- a/include/elf.h<br>
&gt; +++ b/include/elf.h<br>
&gt; @@ -202,6 +202,8 @@ typedef struct mips_elf_abiflags_v0 {<br>
&gt;=C2=A0 #define EM_MOXIE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0223=C2=
=A0 =C2=A0 =C2=A0/* Moxie processor family */<br>
&gt;=C2=A0 #define EM_MOXIE_OLD=C2=A0 =C2=A0 =C2=A0 =C2=A00xFEED<br>
&gt;=C2=A0 <br>
&gt; +#define EM_AVR 83 /* AVR 8-bit microcontroller */<br>
&gt; +<br>
&gt;=C2=A0 /* This is the info that is needed to parse the dynamic section =
of the file */<br>
&gt;=C2=A0 #define DT_NULL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
0<br>
&gt;=C2=A0 #define DT_NEEDED=C2=A0 =C2=A0 1<br>
&gt; diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h<br>
&gt; index e07d276df7..70de85fa72 100644<br>
&gt; --- a/include/hw/elf_ops.h<br>
&gt; +++ b/include/hw/elf_ops.h<br>
&gt; @@ -316,7 +316,8 @@ static int glue(load_elf, SZ)(const char *name, in=
t fd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *translate_opaque,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int must_swab, uint64_t *pentry,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t *lowaddr, uint64_t *high=
addr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int elf_machine, int clear_lsb, int dat=
a_swab,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t *pe_flags, int elf_machine,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int clear_lsb, int data_swab,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AddressSpace *as, bool load_rom,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 symbol_fn_t sym_cb)<br>
&gt;=C2=A0 {<br>
&gt; @@ -594,6 +595,9 @@ static int glue(load_elf, SZ)(const char *name, in=
t fd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 if (pe_flags) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *pe_flags =3D (uint32_t)(elf_sword)ehdr.e=
_flags;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (lowaddr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *lowaddr =3D (uint64_t)(elf_sword)lo=
w;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (highaddr)<br>
&gt; diff --git a/include/hw/loader.h b/include/hw/loader.h<br>
&gt; index 48a96cd559..22b59e15ba 100644<br>
&gt; --- a/include/hw/loader.h<br>
&gt; +++ b/include/hw/loader.h<br>
&gt; @@ -101,6 +101,7 @@ const char *load_elf_strerror(int error);<br>
&gt;=C2=A0 =C2=A0* @pentry: Populated with program entry point. Ignored if =
NULL.<br>
&gt;=C2=A0 =C2=A0* @lowaddr: Populated with lowest loaded address. Ignored =
if NULL.<br>
&gt;=C2=A0 =C2=A0* @highaddr: Populated with highest loaded address. Ignore=
d if NULL.<br>
&gt; + * @pe_flags: Populated with e_flags. Ignore if NULL.<br>
&gt;=C2=A0 =C2=A0* @bigendian: Expected ELF endianness. 0 for LE otherwise =
BE<br>
&gt;=C2=A0 =C2=A0* @elf_machine: Expected ELF machine type<br>
&gt;=C2=A0 =C2=A0* @clear_lsb: Set to mask off LSB of addresses (Some archi=
tectures use<br>
&gt; @@ -131,8 +132,9 @@ int load_elf_ram_sym(const char *filename,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0uint64_t (*elf_note_fn)(void *, void *, bool),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0uint64_t (*translate_fn)(void *, uint64_t),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0void *translate_opaque, uint64_t *pentry,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0uint64_t *lowaddr, uint64_t *highaddr, int big_endian,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0int elf_machine, int clear_lsb, int data_swab,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0uint64_t *lowaddr, uint64_t *highaddr, uint32_t *pe_flags,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0int big_endian, int elf_machine,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0int clear_lsb, int data_swab,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0AddressSpace *as, bool load_rom, symbol_fn_t sym_cb);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /** load_elf_ram:<br>
&gt; diff --git a/hw/avr/sample.c b/hw/avr/sample.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..4fdbc17f1c<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/avr/sample.c<br>
&gt; @@ -0,0 +1,293 @@<br>
&gt; +/*<br>
&gt; + * QEMU AVR CPU<br>
&gt; + *<br>
&gt; + * Copyright (c) 2019 Michael Rolnik<br>
&gt; + *<br>
&gt; + * This library is free software; you can redistribute it and/or<br>
&gt; + * modify it under the terms of the GNU Lesser General Public<br>
&gt; + * License as published by the Free Software Foundation; either<br>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt; + *<br>
&gt; + * This library is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
&gt; + * Lesser General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU Lesser General Public<b=
r>
&gt; + * License along with this library; if not, see<br>
&gt; + * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" rel=3D"n=
oreferrer" target=3D"_blank">http://www.gnu.org/licenses/lgpl-2.1.html</a>&=
gt;<br>
&gt; + */<br>
&gt; +<br>
&gt; +/*<br>
&gt; + *=C2=A0 NOTE:<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 This is not a real AVR board, this is an examp=
le!<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 The CPU is an approximation of an ATmega2560, =
but is missing various<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 built-in peripherals.<br>
&gt; + *<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 This example board loads provided binary file =
into flash memory and<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 executes it from 0x00000000 address in the cod=
e memory space.<br>
&gt; + *<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 Currently used for AVR CPU validation<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;qemu-common.h&quot;<br>
&gt; +#include &quot;cpu.h&quot;<br>
&gt; +#include &quot;hw/hw.h&quot;<br>
&gt; +#include &quot;sysemu/sysemu.h&quot;<br>
&gt; +#include &quot;sysemu/qtest.h&quot;<br>
&gt; +#include &quot;ui/console.h&quot;<br>
&gt; +#include &quot;hw/boards.h&quot;<br>
&gt; +#include &quot;hw/loader.h&quot;<br>
&gt; +#include &quot;qemu/error-report.h&quot;<br>
&gt; +#include &quot;exec/address-spaces.h&quot;<br>
&gt; +#include &quot;include/hw/sysbus.h&quot;<br>
&gt; +#include &quot;include/hw/char/avr_usart.h&quot;<br>
&gt; +#include &quot;include/hw/timer/avr_timer16.h&quot;<br>
&gt; +#include &quot;include/hw/misc/avr_mask.h&quot;<br>
&gt; +#include &quot;elf.h&quot;<br>
&gt; +#include &quot;hw/misc/unimp.h&quot;<br>
&gt; +<br>
&gt; +#define SIZE_FLASH 0x00040000<br>
&gt; +#define SIZE_SRAM 0x00002000<br>
&gt; +/*<br>
&gt; + * Size of additional &quot;external&quot; memory, as if the AVR were=
 configured to use<br>
&gt; + * an external RAM chip.<br>
&gt; + * Note that the configuration registers that normally enable this fe=
ature are<br>
&gt; + * unimplemented.<br>
&gt; + */<br>
&gt; +#define SIZE_EXMEM 0x00000000<br>
&gt; +<br>
&gt; +/* Offsets of peripherals in emulated memory space (i.e. not host add=
resses)=C2=A0 */<br>
&gt; +#define PRR0_BASE 0x64<br>
&gt; +#define PRR1_BASE 0x65<br>
&gt; +#define USART_BASE 0xc0<br>
&gt; +#define TIMER1_BASE 0x80<br>
&gt; +#define TIMER1_IMSK_BASE 0x6f<br>
&gt; +#define TIMER1_IFR_BASE 0x36<br>
&gt; +<br>
&gt; +/* Interrupt numbers used by peripherals */<br>
&gt; +#define USART_RXC_IRQ 24<br>
&gt; +#define USART_DRE_IRQ 25<br>
&gt; +#define USART_TXC_IRQ 26<br>
&gt; +<br>
&gt; +#define TIMER1_CAPT_IRQ 15<br>
&gt; +#define TIMER1_COMPA_IRQ 16<br>
&gt; +#define TIMER1_COMPB_IRQ 17<br>
&gt; +#define TIMER1_COMPC_IRQ 18<br>
&gt; +#define TIMER1_OVF_IRQ 19<br>
&gt; +<br>
&gt; +/*=C2=A0 Power reduction=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +#define PRR1_BIT_PRTIM5=C2=A0 =C2=A0 =C2=A00x05=C2=A0 =C2=A0 /*=C2=A0=
 Timer/Counter5=C2=A0 */<br>
&gt; +#define PRR1_BIT_PRTIM4=C2=A0 =C2=A0 =C2=A00x04=C2=A0 =C2=A0 /*=C2=A0=
 Timer/Counter4=C2=A0 */<br>
&gt; +#define PRR1_BIT_PRTIM3=C2=A0 =C2=A0 =C2=A00x03=C2=A0 =C2=A0 /*=C2=A0=
 Timer/Counter3=C2=A0 */<br>
&gt; +#define PRR1_BIT_PRUSART3=C2=A0 =C2=A00x02=C2=A0 =C2=A0 /*=C2=A0 USAR=
T3=C2=A0 */<br>
&gt; +#define PRR1_BIT_PRUSART2=C2=A0 =C2=A00x01=C2=A0 =C2=A0 /*=C2=A0 USAR=
T2=C2=A0 */<br>
&gt; +#define PRR1_BIT_PRUSART1=C2=A0 =C2=A00x00=C2=A0 =C2=A0 /*=C2=A0 USAR=
T1=C2=A0 */<br>
&gt; +<br>
&gt; +#define PRR0_BIT_PRTWI=C2=A0 =C2=A0 =C2=A0 0x06=C2=A0 =C2=A0 /*=C2=A0=
 TWI */<br>
&gt; +#define PRR0_BIT_PRTIM2=C2=A0 =C2=A0 =C2=A00x05=C2=A0 =C2=A0 /*=C2=A0=
 Timer/Counter2=C2=A0 */<br>
&gt; +#define PRR0_BIT_PRTIM0=C2=A0 =C2=A0 =C2=A00x04=C2=A0 =C2=A0 /*=C2=A0=
 Timer/Counter0=C2=A0 */<br>
&gt; +#define PRR0_BIT_PRTIM1=C2=A0 =C2=A0 =C2=A00x03=C2=A0 =C2=A0 /*=C2=A0=
 Timer/Counter1=C2=A0 */<br>
&gt; +#define PRR0_BIT_PRSPI=C2=A0 =C2=A0 =C2=A0 0x02=C2=A0 =C2=A0 /*=C2=A0=
 Serial Peripheral Interface */<br>
&gt; +#define PRR0_BIT_PRUSART0=C2=A0 =C2=A00x01=C2=A0 =C2=A0 /*=C2=A0 USAR=
T0=C2=A0 */<br>
&gt; +#define PRR0_BIT_PRADC=C2=A0 =C2=A0 =C2=A0 0x00=C2=A0 =C2=A0 /*=C2=A0=
 ADC */<br>
&gt; +<br>
&gt; +typedef struct {<br>
&gt; +=C2=A0 =C2=A0 MachineClass parent;<br>
&gt; +} SampleMachineClass;<br>
&gt; +<br>
&gt; +typedef struct {<br>
&gt; +=C2=A0 =C2=A0 MachineState parent;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *ram;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *flash;<br>
&gt; +=C2=A0 =C2=A0 AVRUsartState *usart0;<br>
&gt; +=C2=A0 =C2=A0 AVRTimer16State *timer1;<br>
&gt; +=C2=A0 =C2=A0 AVRMaskState *prr[2];<br>
&gt; +} SampleMachineState;<br>
&gt; +<br>
&gt; +#define TYPE_SAMPLE_MACHINE MACHINE_TYPE_NAME(&quot;sample&quot;)<br>
&gt; +<br>
&gt; +#define SAMPLE_MACHINE(obj) \<br>
&gt; +=C2=A0 =C2=A0 OBJECT_CHECK(SampleMachineState, obj, TYPE_SAMPLE_MACHI=
NE)<br>
&gt; +#define SAMPLE_MACHINE_GET_CLASS(obj) \<br>
&gt; +=C2=A0 =C2=A0 OBJECT_GET_CLASS(SampleMachineClass, obj, TYPE_SAMPLE_M=
ACHINE)<br>
&gt; +#define SAMPLE_MACHINE_CLASS(klass) \<br>
&gt; +=C2=A0 =C2=A0 OBJECT_CLASS_CHECK(SampleMachineClass, klass, TYPE_SAMP=
LE_MACHINE)<br>
&gt; +<br>
&gt; +static void sample_init(MachineState *machine)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SampleMachineState *sms =3D SAMPLE_MACHINE(machine);<br=
>
&gt; +=C2=A0 =C2=A0 MemoryRegion *system_memory =3D get_system_memory();<br=
>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu;<br>
&gt; +=C2=A0 =C2=A0 const char *firmware =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 const char *filename =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 const char *cpu_type =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 uint32_t e_flags;<br>
&gt; +=C2=A0 =C2=A0 int bytes_loaded;<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *busdev;<br>
&gt; +=C2=A0 =C2=A0 DeviceState *cpudev;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 system_memory =3D get_system_memory();<br>
&gt; +=C2=A0 =C2=A0 sms-&gt;ram =3D g_new(MemoryRegion, 1);<br>
&gt; +=C2=A0 =C2=A0 sms-&gt;flash =3D g_new(MemoryRegion, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* if ELF file is provided, determine CPU type reading =
ELF e_flags */<br>
&gt; +=C2=A0 =C2=A0 cpu_type =3D machine-&gt;cpu_type;<br>
&gt; +=C2=A0 =C2=A0 firmware =3D machine-&gt;firmware;<br>
&gt; +=C2=A0 =C2=A0 if (firmware !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 filename =3D qemu_find_file(QEMU_FILE_TYP=
E_BIOS, firmware);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (filename =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Unable t=
o find %s&quot;, firmware);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_loaded =3D load_elf_ram_sym(filenam=
e, NULL, NULL, NULL, NULL, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, &amp;e_=
flags, 0, EM_AVR, 0, 0, NULL, 0, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bytes_loaded &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_type =3D avr_flags_to_c=
pu_type(e_flags, cpu_type);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cpu =3D AVR_CPU(cpu_create(cpu_type));<br>
&gt; +=C2=A0 =C2=A0 cpudev =3D DEVICE(cpu);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_rom(sms-&gt;flash, NULL, &quot;avr.f=
lash&quot;, SIZE_FLASH,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(system_memory, OFFSET_CODE,=
 sms-&gt;flash);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* following are atmel2560 device */<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;usart 3&quot;, OFFSET=
_DATA + 0x0130, 0x0007);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;timer-counter-16bit 5=
&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0120, 0x000=
e);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;gpio L&quot;, OFFSET_=
DATA + 0x0109, 0x0003);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;gpio K&quot;, OFFSET_=
DATA + 0x0106, 0x0003);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;gpio J&quot;, OFFSET_=
DATA + 0x0103, 0x0003);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;gpio H&quot;, OFFSET_=
DATA + 0x0100, 0x0003);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;usart 2&quot;, OFFSET=
_DATA + 0x00d0, 0x0007);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;usart 1&quot;, OFFSET=
_DATA + 0x00c8, 0x0007);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;usart 0&quot;, OFFSET=
_DATA + 0x00c0, 0x0007);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;twi&quot;, OFFSET_DAT=
A + 0x00b8, 0x0006);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;timer-counter-async-8=
bit 2&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x00b0, 0x000=
7);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;timer-counter-16bit 4=
&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x00a0, 0x000=
e);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;timer-counter-16bit 3=
&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0090, 0x000=
e);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;timer-counter-16bit 1=
&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0080, 0x000=
e);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;ac / adc&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0078, 0x000=
8);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;ext-mem-iface&quot;,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0074, 0x000=
2);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;int-controller&quot;,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0068, 0x000=
c);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;sys&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0060, 0x000=
7);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;spi&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x004c, 0x000=
3);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;ext-mem-iface&quot;,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x004a, 0x000=
2);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;timer-counter-pwm-8bi=
t 0&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0043, 0x000=
6);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;ext-mem-iface&quot;,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x003e, 0x000=
5);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;int-controller&quot;,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0035, 0x000=
9);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;gpio G&quot;, OFFSET_=
DATA + 0x0032, 0x0003);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;gpio F&quot;, OFFSET_=
DATA + 0x002f, 0x0003);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;gpio E&quot;, OFFSET_=
DATA + 0x002c, 0x0003);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;gpio D&quot;, OFFSET_=
DATA + 0x0029, 0x0003);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;gpio C&quot;, OFFSET_=
DATA + 0x0026, 0x0003);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;gpio B&quot;, OFFSET_=
DATA + 0x0023, 0x0003);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;gpio A&quot;, OFFSET_=
DATA + 0x0020, 0x0003);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memory_region_allocate_system_memory(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sms-&gt;ram, NULL, &quot;avr.ram&quot;, S=
IZE_SRAM + SIZE_EXMEM);<br>
<br>
Please use MachineClass::default_ram_size and add check that &#39;-m&#39; v=
alues matches it.<br>
See for example<br>
<a href=3D"https://github.com/imammedo/qemu/commit/241c65d506ccba1e0239a2bc=
0632d7dc9c3517c1" rel=3D"noreferrer" target=3D"_blank">https://github.com/i=
mammedo/qemu/commit/241c65d506ccba1e0239a2bc0632d7dc9c3517c1</a><br>
<br>
(if you respin amend this patch but otherwise it could be a patch on top of=
 this series)<br>
<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(system_memory, OFFSET_DATA =
+ 0x200, sms-&gt;ram);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Power Reduction built-in peripheral */<br>
&gt; +=C2=A0 =C2=A0 sms-&gt;prr[0] =3D AVR_MASK(sysbus_create_simple(TYPE_A=
VR_MASK,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 OFFSET_DATA + PRR0_BASE, NULL));<br>
&gt; +=C2=A0 =C2=A0 sms-&gt;prr[1] =3D AVR_MASK(sysbus_create_simple(TYPE_A=
VR_MASK,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 OFFSET_DATA + PRR1_BASE, NULL));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* USART 0 built-in peripheral */<br>
&gt; +=C2=A0 =C2=A0 sms-&gt;usart0 =3D AVR_USART(object_new(TYPE_AVR_USART)=
);<br>
&gt; +=C2=A0 =C2=A0 busdev =3D SYS_BUS_DEVICE(sms-&gt;usart0);<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_chr(DEVICE(sms-&gt;usart0), &quot;chardev=
&quot;, serial_hd(0));<br>
&gt; +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(sms-&gt;usart0), true, =
&quot;realized&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(busdev, 0, OFFSET_DATA + USART_BASE);<b=
r>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* These IRQ numbers don&#39;t match the datasheet=
 because we&#39;re counting from<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* zero and not including reset.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev, =
USART_RXC_IRQ));<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev, =
USART_DRE_IRQ));<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev, =
USART_TXC_IRQ));<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(sms-&gt;prr[1]), PRR1=
_BIT_PRUSART1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(sms=
-&gt;usart0), 0));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Timer 1 built-in periphal */<br>
&gt; +=C2=A0 =C2=A0 sms-&gt;timer1 =3D AVR_TIMER16(object_new(TYPE_AVR_TIME=
R16));<br>
&gt; +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(sms-&gt;timer1), true, =
&quot;realized&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
&gt; +=C2=A0 =C2=A0 busdev =3D SYS_BUS_DEVICE(sms-&gt;timer1);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(busdev, 0, OFFSET_DATA + TIMER1_BASE);<=
br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(busdev, 1, OFFSET_DATA + TIMER1_IMSK_BA=
SE);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(busdev, 2, OFFSET_DATA + TIMER1_IFR_BAS=
E);<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev, =
TIMER1_CAPT_IRQ));<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev, =
TIMER1_COMPA_IRQ));<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev, =
TIMER1_COMPB_IRQ));<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 3, qdev_get_gpio_in(cpudev, =
TIMER1_COMPC_IRQ));<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 4, qdev_get_gpio_in(cpudev, =
TIMER1_OVF_IRQ));<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(sms-&gt;prr[0]), PRR0=
_BIT_PRTIM1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(sms=
-&gt;timer1), 0));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Load firmware (contents of flash) trying to auto-det=
ect format */<br>
&gt; +=C2=A0 =C2=A0 if (filename !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_loaded =3D load_elf(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename, NULL, NULL, NULL,=
 NULL, NULL, NULL, 0, EM_NONE, 0, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bytes_loaded &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_loaded =3D load_image=
_targphys(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename, OFF=
SET_CODE, SIZE_FLASH);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bytes_loaded &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Unable =
to load firmware image %s as ELF or raw binary&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 firmware);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void sample_class_init(ObjectClass *oc, void *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_CLASS(oc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;desc =3D &quot;AVR sample/example board (ATmega2=
560)&quot;;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;init =3D sample_init;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;default_cpus =3D 1;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;min_cpus =3D mc-&gt;default_cpus;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;max_cpus =3D mc-&gt;default_cpus;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;default_cpu_type =3D &quot;avr6-avr-cpu&quot;; /=
* ATmega2560. */<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;is_default =3D 1;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo sample_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D TYPE_SAMPLE_MACHINE,<br>
&gt; +=C2=A0 =C2=A0 .parent =3D TYPE_MACHINE,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(SampleMachineState),<br>
&gt; +=C2=A0 =C2=A0 .class_size =3D sizeof(SampleMachineClass),<br>
&gt; +=C2=A0 =C2=A0 .class_init =3D sample_class_init,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void sample_machine_init(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;sample_info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(sample_machine_init);<br>
&gt; diff --git a/hw/core/loader.c b/hw/core/loader.c<br>
&gt; index 5099f27dc8..9961b4423b 100644<br>
&gt; --- a/hw/core/loader.c<br>
&gt; +++ b/hw/core/loader.c<br>
&gt; @@ -438,7 +438,7 @@ int load_elf_ram(const char *filename,<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return load_elf_ram_sym(filename, elf_note_fn,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 translate_fn, translate_opaque,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pentry, lowaddr, highaddr, big_endian,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pentry, lowaddr, highaddr, NULL, big_endian,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elf_machine, clear_lsb, data_swab, as,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 load_rom, NULL);<br>
&gt;=C2=A0 }<br>
&gt; @@ -448,8 +448,9 @@ int load_elf_ram_sym(const char *filename,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0uint64_t (*elf_note_fn)(void *, void *, bool),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0uint64_t (*translate_fn)(void *, uint64_t),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0void *translate_opaque, uint64_t *pentry,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0uint64_t *lowaddr, uint64_t *highaddr, int big_endian,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0int elf_machine, int clear_lsb, int data_swab,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0uint64_t *lowaddr, uint64_t *highaddr, uint32_t *pe_flags,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0int big_endian, int elf_machine,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0int clear_lsb, int data_swab,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0AddressSpace *as, bool load_rom, symbol_fn_t sym_cb)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int fd, data_order, target_data_order, must_swab, =
ret =3D ELF_LOAD_FAILED;<br>
&gt; @@ -490,13 +491,13 @@ int load_elf_ram_sym(const char *filename,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (e_ident[EI_CLASS] =3D=3D ELFCLASS64) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D load_elf64(filename, fd, elf=
_note_fn,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0translate_fn, translate_opaque, must_swab,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0pentry, lowaddr, highaddr, elf_machine, clear_lsb,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0data_swab, as, load_rom, sym_cb);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0pentry, lowaddr, highaddr, pe_flags, elf_machine,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0clear_lsb, data_swab, as, load_rom, sym_cb);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D load_elf32(filename, fd, elf=
_note_fn,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0translate_fn, translate_opaque, must_swab,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0pentry, lowaddr, highaddr, elf_machine, clear_lsb,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0data_swab, as, load_rom, sym_cb);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0pentry, lowaddr, highaddr, pe_flags, elf_machine,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0clear_lsb, data_swab, as, load_rom, sym_cb);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0fail:<br>
&gt; diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c<br>
&gt; index 027303d2a3..746ca1f795 100644<br>
&gt; --- a/hw/riscv/boot.c<br>
&gt; +++ b/hw/riscv/boot.c<br>
&gt; @@ -119,7 +119,7 @@ target_ulong riscv_load_kernel(const char *kernel_=
filename, symbol_fn_t sym_cb)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t kernel_entry, kernel_high;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (load_elf_ram_sym(kernel_filename, NULL, NULL, =
NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&amp;kernel_entry, NULL, &amp;kernel_high, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&amp;kernel_entry, NULL, &amp;kernel_high, NULL, 0,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0EM_RISCV, 1, 0, NULL, true, sym_cb) &gt; 0) {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return kernel_entry;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; diff --git a/hw/Kconfig b/hw/Kconfig<br>
&gt; index ecf491bf04..f80dff3b75 100644<br>
&gt; --- a/hw/Kconfig<br>
&gt; +++ b/hw/Kconfig<br>
&gt; @@ -43,6 +43,7 @@ source watchdog/Kconfig<br>
&gt;=C2=A0 # arch Kconfig<br>
&gt;=C2=A0 source arm/Kconfig<br>
&gt;=C2=A0 source alpha/Kconfig<br>
&gt; +source avr/Kconfig<br>
&gt;=C2=A0 source cris/Kconfig<br>
&gt;=C2=A0 source hppa/Kconfig<br>
&gt;=C2=A0 source i386/Kconfig<br>
&gt; diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..92aa1e6afb<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/avr/Kconfig<br>
&gt; @@ -0,0 +1,6 @@<br>
&gt; +config AVR_SAMPLE<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt; +=C2=A0 =C2=A0 select AVR_TIMER16<br>
&gt; +=C2=A0 =C2=A0 select AVR_USART<br>
&gt; +=C2=A0 =C2=A0 select AVR_MASK<br>
&gt; +=C2=A0 =C2=A0 select UNIMP<br>
&gt; diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..626b7064b3<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/avr/Makefile.objs<br>
&gt; @@ -0,0 +1 @@<br>
&gt; +obj-y +=3D sample.o<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--000000000000e82916059a21db44--

