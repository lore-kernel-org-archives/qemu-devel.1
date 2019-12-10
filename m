Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3436AC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E069C2073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMCYLFI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E069C2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieiTo-0002Hz-MY
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:35:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ieiSE-0000XL-Ae
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:33:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ieiSB-0000Bl-5c
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:33:42 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ieiSA-0000Bc-UJ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:33:39 -0500
Received: by mail-oi1-x244.google.com with SMTP id i1so10341386oie.8
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 08:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PUz/A9KwuGRRQrxIYVTNoq6Aayft5XK4jTrSCC4SmC8=;
 b=hMCYLFI5GfneY7m1DjXQ77maZ6tVwxg2t4lNfaJkXeMEvlKVDWIeM/0wunmSgl7vIr
 etEpTqF7hfd16UvQr7OQv7sZumVpb+gcfok7R7pfTEHGCD/r8E5YYvTcBZwU4n3BRpL+
 OUnmChdaHkKnAjnAEQyWveXF7C1KhBh7ZQes7nYhbOzSg9N/lT3AFlFfjZIUUyHdft9N
 d2vOjKx/kIvFzexraek7/cMEF202phC8qXI7pW+TvbiKCPBFoCgBiTs2K5huzan8LYUM
 A8gIwSZjfP3vFivW+7ej1ZUfXTsE5Fk+GMO0r9QrX4p/I1py9XSgPrDFOw+EpTZ9FZuP
 f9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PUz/A9KwuGRRQrxIYVTNoq6Aayft5XK4jTrSCC4SmC8=;
 b=ACI0Dx/awEhrF4Y2FFApaH2NCUjmqWivM/5CEvOp7tMrWLpChDglPlUmg8bu0EZhPd
 knxr5xAQTzuNELJMyVXyBTOJOVFQ8ZllU51k2JXJ21SYy9Q7mjSJW+lnT4Co80heJ+E5
 rVCE9Hkt/l84L+1BFtgCx6CkVD82RXDJDDZBtCVATm9gVc7KDUjDRS85WxhICf8Fjtdp
 WZtikURNMtfdqTm+379lnOJF+mzk290WVlsKVazNitLuY4xmaGLMgi+rgqsZH18WhYb4
 nk8O7UJ2y76AGGj+yqKpIewIIkorxYh5cM5W+C4WRK0GPWWF9pxuMKiMsppwxdRyUlEG
 tkPA==
X-Gm-Message-State: APjAAAVyYE20aIYJRu5ojYqxnmoxfi0AoX8n5s1IkCtfKjgVSDtattQg
 mPpMbqYiQsTwwSJFT73Uh9/IPXEC+EmE2l1BcM8=
X-Google-Smtp-Source: APXvYqwlATDfxf9T3yBlz39hRss9pKD8lOtallBQBY68LBBIFvbSHCSvQNeI8hO4484dMVi13LzTp6XvN/SIU3FhJDQ=
X-Received: by 2002:aca:1b08:: with SMTP id b8mr4493747oib.106.1575995617803; 
 Tue, 10 Dec 2019 08:33:37 -0800 (PST)
MIME-Version: 1.0
References: <20191208183922.13757-1-mrolnik@gmail.com>
 <20191208183922.13757-16-mrolnik@gmail.com>
 <CAL1e-=hOw0_bfejCqj-VHG9Ww3HK3_C_P1f8KWy2myQ2GbTrQA@mail.gmail.com>
 <CAK4993guCAFetXrgZNUkSt3TCnr3yDo6KG-RQanHZ9_KSDpZVA@mail.gmail.com>
 <CAK4993gH=bOr9dT22ga3DdK+wFzqw9-DDCzhb4JYfrzgGYTZ7w@mail.gmail.com>
In-Reply-To: <CAK4993gH=bOr9dT22ga3DdK+wFzqw9-DDCzhb4JYfrzgGYTZ7w@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 10 Dec 2019 17:33:26 +0100
Message-ID: <CAL1e-=hWNYKRy729=YqxBPXhVHg9fQUdF4tnWA6vebMbyn_v7w@mail.gmail.com>
Subject: Re: [PATCH v38 15/22] target/avr: Add example board configuration
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 9, 2019 at 7:38 PM Michael Rolnik <mrolnik@gmail.com> wrote:
>
> I will check again.
>

On my test bed:

...

  CC      riscv32-softmmu/hw/virtio/virtio-serial-pci.o
  CC      riscv32-softmmu/hw/riscv/boot.o
/home/rtrk/Build/qemu-rolnik/hw/riscv/boot.c: In function =E2=80=98riscv_lo=
ad_kernel=E2=80=99:
/home/rtrk/Build/qemu-rolnik/hw/riscv/boot.c:123:36: error: passing
argument 10 of =E2=80=98load_elf_ram_sym=E2=80=99 makes pointer from intege=
r without a
cast [-Werror=3Dint-conversion]
                          EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
                                    ^
In file included from /home/rtrk/Build/qemu-rolnik/hw/riscv/boot.c:26:0:
/home/rtrk/Build/qemu-rolnik/include/hw/loader.h:130:5: note: expected
=E2=80=98uint32_t * {aka unsigned int *}=E2=80=99 but argument is of type =
=E2=80=98int=E2=80=99
 int load_elf_ram_sym(const char *filename,
     ^~~~~~~~~~~~~~~~
/home/rtrk/Build/qemu-rolnik/hw/riscv/boot.c:123:42: error: passing
argument 12 of =E2=80=98load_elf_ram_sym=E2=80=99 makes integer from pointe=
r without a
cast [-Werror=3Dint-conversion]
                          EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
                                          ^~~~
In file included from /home/rtrk/Build/qemu-rolnik/hw/riscv/boot.c:26:0:
/home/rtrk/Build/qemu-rolnik/include/hw/loader.h:130:5: note: expected
=E2=80=98int=E2=80=99 but argument is of type =E2=80=98void *=E2=80=99
 int load_elf_ram_sym(const char *filename,
     ^~~~~~~~~~~~~~~~
/home/rtrk/Build/qemu-rolnik/hw/riscv/boot.c:123:48: error: passing
argument 13 of =E2=80=98load_elf_ram_sym=E2=80=99 makes pointer from intege=
r without a
cast [-Werror=3Dint-conversion]
                          EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
                                                ^~~~
In file included from /home/rtrk/Build/qemu-rolnik/hw/riscv/boot.c:26:0:
/home/rtrk/Build/qemu-rolnik/include/hw/loader.h:130:5: note: expected
=E2=80=98AddressSpace * {aka struct AddressSpace *}=E2=80=99 but argument i=
s of type
=E2=80=98int=E2=80=99
 int load_elf_ram_sym(const char *filename,
     ^~~~~~~~~~~~~~~~
/home/rtrk/Build/qemu-rolnik/hw/riscv/boot.c:121:9: error: too few
arguments to function =E2=80=98load_elf_ram_sym=E2=80=99
     if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
         ^~~~~~~~~~~~~~~~
In file included from /home/rtrk/Build/qemu-rolnik/hw/riscv/boot.c:26:0:
/home/rtrk/Build/qemu-rolnik/include/hw/loader.h:130:5: note: declared here
 int load_elf_ram_sym(const char *filename,
     ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
/home/rtrk/Build/qemu-rolnik/rules.mak:69: recipe for target
'hw/riscv/boot.o' failed
make[1]: *** [hw/riscv/boot.o] Error 1
Makefile:491: recipe for target 'riscv32-softmmu/all' failed
make: *** [riscv32-softmmu/all] Error 2



> On Mon, Dec 9, 2019 at 8:30 PM Michael Rolnik <mrolnik@gmail.com> wrote:
>>
>> Yes, I did compile other platforms.
>>
>> On Mon, Dec 9, 2019 at 8:24 PM Aleksandar Markovic <aleksandar.m.mail@gm=
ail.com> wrote:
>>>
>>>
>>>
>>> On Sunday, December 8, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>>>>
>>>> A simple board setup that configures an AVR CPU to run a given firmwar=
e image.
>>>> This is all that's useful to implement without peripheral emulation as=
 AVR CPUs include a lot of on-board peripherals.
>>>>
>>>> NOTE: this is not a real board !!!!
>>>> NOTE: it's used for CPU testing!!!!
>>>>
>>>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>>>> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>> Nacked-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> ---
>>>>  include/elf.h        |   2 +
>>>>  include/hw/elf_ops.h |   6 +-
>>>>  include/hw/loader.h  |   3 +-
>>>>  hw/avr/sample.c      | 293 ++++++++++++++++++++++++++++++++++++++++++=
+
>>>>  hw/core/loader.c     |  13 +-
>>>>  hw/Kconfig           |   1 +
>>>>  hw/avr/Kconfig       |   6 +
>>>>  hw/avr/Makefile.objs |   1 +
>>>>  8 files changed, 317 insertions(+), 8 deletions(-)
>>>>  create mode 100644 hw/avr/sample.c
>>>>  create mode 100644 hw/avr/Kconfig
>>>>  create mode 100644 hw/avr/Makefile.objs
>>>>
>>>> diff --git a/include/elf.h b/include/elf.h
>>>> index 3501e0c8d0..53cdfa23b7 100644
>>>> --- a/include/elf.h
>>>> +++ b/include/elf.h
>>>> @@ -202,6 +202,8 @@ typedef struct mips_elf_abiflags_v0 {
>>>>  #define EM_MOXIE           223     /* Moxie processor family */
>>>>  #define EM_MOXIE_OLD       0xFEED
>>>>
>>>> +#define EM_AVR 83 /* AVR 8-bit microcontroller */
>>>> +
>>>>  /* This is the info that is needed to parse the dynamic section of th=
e file */
>>>>  #define DT_NULL                0
>>>>  #define DT_NEEDED      1
>>>> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
>>>> index e07d276df7..9f28c16490 100644
>>>> --- a/include/hw/elf_ops.h
>>>> +++ b/include/hw/elf_ops.h
>>>> @@ -316,7 +316,8 @@ static int glue(load_elf, SZ)(const char *name, in=
t fd,
>>>>                                void *translate_opaque,
>>>>                                int must_swab, uint64_t *pentry,
>>>>                                uint64_t *lowaddr, uint64_t *highaddr,
>>>> -                              int elf_machine, int clear_lsb, int dat=
a_swab,
>>>> +                              int elf_machine, uint32_t *pflags,
>>>> +                              int clear_lsb, int data_swab,
>>>>                                AddressSpace *as, bool load_rom,
>>>>                                symbol_fn_t sym_cb)
>>>>
>>>>
>>>
>>>  New parameter uint32_t *pflags should go before int elf_machine, so th=
at input and output parameters are grouped together. The mane should be mor=
e precise, like pe_flags.
>>>
>>> But, it looks to me that you are breaking all other platforms with this=
 change. Did you try full qemu build after your series is applied?
>>>
>>>>
>>>>
>>>>
>>>>  {
>>>> @@ -594,6 +595,9 @@ static int glue(load_elf, SZ)(const char *name, in=
t fd,
>>>>          }
>>>>      }
>>>>
>>>> +    if (pflags) {
>>>> +        *pflags =3D (uint32_t)(elf_sword)ehdr.e_flags;
>>>> +    }
>>>>      if (lowaddr)
>>>>          *lowaddr =3D (uint64_t)(elf_sword)low;
>>>>      if (highaddr)
>>>> diff --git a/include/hw/loader.h b/include/hw/loader.h
>>>> index 48a96cd559..3dbdd1868d 100644
>>>> --- a/include/hw/loader.h
>>>> +++ b/include/hw/loader.h
>>>> @@ -132,7 +132,8 @@ int load_elf_ram_sym(const char *filename,
>>>>                       uint64_t (*translate_fn)(void *, uint64_t),
>>>>                       void *translate_opaque, uint64_t *pentry,
>>>>                       uint64_t *lowaddr, uint64_t *highaddr, int big_e=
ndian,
>>>> -                     int elf_machine, int clear_lsb, int data_swab,
>>>> +                     int elf_machine, uint32_t *pflags,
>>>> +                     int clear_lsb, int data_swab,
>>>>                       AddressSpace *as, bool load_rom, symbol_fn_t sym=
_cb);
>>>>
>>>>  /** load_elf_ram:
>>>> diff --git a/hw/avr/sample.c b/hw/avr/sample.c
>>>> new file mode 100644
>>>> index 0000000000..6574733b57
>>>> --- /dev/null
>>>> +++ b/hw/avr/sample.c
>>>> @@ -0,0 +1,293 @@
>>>> +/*
>>>> + * QEMU AVR CPU
>>>> + *
>>>> + * Copyright (c) 2019 Michael Rolnik
>>>> + *
>>>> + * This library is free software; you can redistribute it and/or
>>>> + * modify it under the terms of the GNU Lesser General Public
>>>> + * License as published by the Free Software Foundation; either
>>>> + * version 2.1 of the License, or (at your option) any later version.
>>>> + *
>>>> + * This library is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>>> + * Lesser General Public License for more details.
>>>> + *
>>>> + * You should have received a copy of the GNU Lesser General Public
>>>> + * License along with this library; if not, see
>>>> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
>>>> + */
>>>> +
>>>> +/*
>>>> + *  NOTE:
>>>> + *      This is not a real AVR board, this is an example!
>>>> + *      The CPU is an approximation of an ATmega2560, but is missing =
various
>>>> + *      built-in peripherals.
>>>> + *
>>>> + *      This example board loads provided binary file into flash memo=
ry and
>>>> + *      executes it from 0x00000000 address in the code memory space.
>>>> + *
>>>> + *      Currently used for AVR CPU validation
>>>> + *
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "qapi/error.h"
>>>> +#include "qemu-common.h"
>>>> +#include "cpu.h"
>>>> +#include "hw/hw.h"
>>>> +#include "sysemu/sysemu.h"
>>>> +#include "sysemu/qtest.h"
>>>> +#include "ui/console.h"
>>>> +#include "hw/boards.h"
>>>> +#include "hw/loader.h"
>>>> +#include "qemu/error-report.h"
>>>> +#include "exec/address-spaces.h"
>>>> +#include "include/hw/sysbus.h"
>>>> +#include "include/hw/char/avr_usart.h"
>>>> +#include "include/hw/timer/avr_timer16.h"
>>>> +#include "include/hw/misc/avr_mask.h"
>>>> +#include "elf.h"
>>>> +#include "hw/misc/unimp.h"
>>>> +
>>>> +#define SIZE_FLASH 0x00040000
>>>> +#define SIZE_SRAM 0x00002000
>>>> +/*
>>>> + * Size of additional "external" memory, as if the AVR were configure=
d to use
>>>> + * an external RAM chip.
>>>> + * Note that the configuration registers that normally enable this fe=
ature are
>>>> + * unimplemented.
>>>> + */
>>>> +#define SIZE_EXMEM 0x00000000
>>>> +
>>>> +/* Offsets of peripherals in emulated memory space (i.e. not host add=
resses)  */
>>>> +#define PRR0_BASE 0x64
>>>> +#define PRR1_BASE 0x65
>>>> +#define USART_BASE 0xc0
>>>> +#define TIMER1_BASE 0x80
>>>> +#define TIMER1_IMSK_BASE 0x6f
>>>> +#define TIMER1_IFR_BASE 0x36
>>>> +
>>>> +/* Interrupt numbers used by peripherals */
>>>> +#define USART_RXC_IRQ 24
>>>> +#define USART_DRE_IRQ 25
>>>> +#define USART_TXC_IRQ 26
>>>> +
>>>> +#define TIMER1_CAPT_IRQ 15
>>>> +#define TIMER1_COMPA_IRQ 16
>>>> +#define TIMER1_COMPB_IRQ 17
>>>> +#define TIMER1_COMPC_IRQ 18
>>>> +#define TIMER1_OVF_IRQ 19
>>>> +
>>>> +/*  Power reduction     */
>>>> +#define PRR1_BIT_PRTIM5     0x05    /*  Timer/Counter5  */
>>>> +#define PRR1_BIT_PRTIM4     0x04    /*  Timer/Counter4  */
>>>> +#define PRR1_BIT_PRTIM3     0x03    /*  Timer/Counter3  */
>>>> +#define PRR1_BIT_PRUSART3   0x02    /*  USART3  */
>>>> +#define PRR1_BIT_PRUSART2   0x01    /*  USART2  */
>>>> +#define PRR1_BIT_PRUSART1   0x00    /*  USART1  */
>>>> +
>>>> +#define PRR0_BIT_PRTWI      0x06    /*  TWI */
>>>> +#define PRR0_BIT_PRTIM2     0x05    /*  Timer/Counter2  */
>>>> +#define PRR0_BIT_PRTIM0     0x04    /*  Timer/Counter0  */
>>>> +#define PRR0_BIT_PRTIM1     0x03    /*  Timer/Counter1  */
>>>> +#define PRR0_BIT_PRSPI      0x02    /*  Serial Peripheral Interface *=
/
>>>> +#define PRR0_BIT_PRUSART0   0x01    /*  USART0  */
>>>> +#define PRR0_BIT_PRADC      0x00    /*  ADC */
>>>> +
>>>> +typedef struct {
>>>> +    MachineClass parent;
>>>> +} SampleMachineClass;
>>>> +
>>>> +typedef struct {
>>>> +    MachineState parent;
>>>> +    MemoryRegion *ram;
>>>> +    MemoryRegion *flash;
>>>> +    AVRUsartState *usart0;
>>>> +    AVRTimer16State *timer1;
>>>> +    AVRMaskState *prr[2];
>>>> +} SampleMachineState;
>>>> +
>>>> +#define TYPE_SAMPLE_MACHINE MACHINE_TYPE_NAME("sample")
>>>> +
>>>> +#define SAMPLE_MACHINE(obj) \
>>>> +    OBJECT_CHECK(SampleMachineState, obj, TYPE_SAMPLE_MACHINE)
>>>> +#define SAMPLE_MACHINE_GET_CLASS(obj) \
>>>> +    OBJECT_GET_CLASS(SampleMachineClass, obj, TYPE_SAMPLE_MACHINE)
>>>> +#define SAMPLE_MACHINE_CLASS(klass) \
>>>> +    OBJECT_CLASS_CHECK(SampleMachineClass, klass, TYPE_SAMPLE_MACHINE=
)
>>>> +
>>>> +static void sample_init(MachineState *machine)
>>>> +{
>>>> +    SampleMachineState *sms =3D SAMPLE_MACHINE(machine);
>>>> +    MemoryRegion *system_memory =3D get_system_memory();
>>>> +    AVRCPU *cpu;
>>>> +    const char *firmware =3D NULL;
>>>> +    const char *filename =3D NULL;
>>>> +    const char *cpu_type =3D NULL;
>>>> +    uint32_t flags;
>>>> +    int bytes_loaded;
>>>> +    SysBusDevice *busdev;
>>>> +    DeviceState *cpudev;
>>>> +
>>>> +    system_memory =3D get_system_memory();
>>>> +    sms->ram =3D g_new(MemoryRegion, 1);
>>>> +    sms->flash =3D g_new(MemoryRegion, 1);
>>>> +
>>>> +    /* if ELF file is provided, determine CPU type reading ELF flags =
*/
>>>> +    cpu_type =3D machine->cpu_type;
>>>> +    firmware =3D machine->firmware;
>>>> +    if (firmware !=3D NULL) {
>>>> +        filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
>>>> +        if (filename =3D=3D NULL) {
>>>> +            error_report("Unable to find %s", firmware);
>>>> +            exit(1);
>>>> +        }
>>>> +
>>>> +        bytes_loaded =3D load_elf_ram_sym(filename, NULL, NULL, NULL,=
 NULL, NULL,
>>>> +                NULL, 0, EM_AVR, &flags, 0, 0, NULL, 0, 0);
>>>> +        if (bytes_loaded > 0) {
>>>> +            cpu_type =3D avr_flags_to_cpu_type(flags, cpu_type);
>>>> +        }
>>>> +    }
>>>> +
>>>> +    cpu =3D AVR_CPU(cpu_create(cpu_type));
>>>> +    cpudev =3D DEVICE(cpu);
>>>> +
>>>> +    memory_region_init_rom(sms->flash, NULL, "avr.flash", SIZE_FLASH,
>>>> +            &error_fatal);
>>>> +    memory_region_add_subregion(system_memory, OFFSET_CODE, sms->flas=
h);
>>>> +
>>>> +    /* following are atmel2560 device */
>>>> +    create_unimplemented_device("usart 3", OFFSET_DATA + 0x0130, 0x00=
07);
>>>> +    create_unimplemented_device("timer-counter-16bit 5",
>>>> +            OFFSET_DATA + 0x0120, 0x000e);
>>>> +    create_unimplemented_device("gpio L", OFFSET_DATA + 0x0109, 0x000=
3);
>>>> +    create_unimplemented_device("gpio K", OFFSET_DATA + 0x0106, 0x000=
3);
>>>> +    create_unimplemented_device("gpio J", OFFSET_DATA + 0x0103, 0x000=
3);
>>>> +    create_unimplemented_device("gpio H", OFFSET_DATA + 0x0100, 0x000=
3);
>>>> +    create_unimplemented_device("usart 2", OFFSET_DATA + 0x00d0, 0x00=
07);
>>>> +    create_unimplemented_device("usart 1", OFFSET_DATA + 0x00c8, 0x00=
07);
>>>> +    create_unimplemented_device("usart 0", OFFSET_DATA + 0x00c0, 0x00=
07);
>>>> +    create_unimplemented_device("twi", OFFSET_DATA + 0x00b8, 0x0006);
>>>> +    create_unimplemented_device("timer-counter-async-8bit 2",
>>>> +            OFFSET_DATA + 0x00b0, 0x0007);
>>>> +    create_unimplemented_device("timer-counter-16bit 4",
>>>> +            OFFSET_DATA + 0x00a0, 0x000e);
>>>> +    create_unimplemented_device("timer-counter-16bit 3",
>>>> +            OFFSET_DATA + 0x0090, 0x000e);
>>>> +    create_unimplemented_device("timer-counter-16bit 1",
>>>> +            OFFSET_DATA + 0x0080, 0x000e);
>>>> +    create_unimplemented_device("ac / adc",
>>>> +            OFFSET_DATA + 0x0078, 0x0008);
>>>> +    create_unimplemented_device("ext-mem-iface",
>>>> +            OFFSET_DATA + 0x0074, 0x0002);
>>>> +    create_unimplemented_device("int-controller",
>>>> +            OFFSET_DATA + 0x0068, 0x000c);
>>>> +    create_unimplemented_device("sys",
>>>> +            OFFSET_DATA + 0x0060, 0x0007);
>>>> +    create_unimplemented_device("spi",
>>>> +            OFFSET_DATA + 0x004c, 0x0003);
>>>> +    create_unimplemented_device("ext-mem-iface",
>>>> +            OFFSET_DATA + 0x004a, 0x0002);
>>>> +    create_unimplemented_device("timer-counter-pwm-8bit 0",
>>>> +            OFFSET_DATA + 0x0043, 0x0006);
>>>> +    create_unimplemented_device("ext-mem-iface",
>>>> +            OFFSET_DATA + 0x003e, 0x0005);
>>>> +    create_unimplemented_device("int-controller",
>>>> +            OFFSET_DATA + 0x0035, 0x0009);
>>>> +    create_unimplemented_device("gpio G", OFFSET_DATA + 0x0032, 0x000=
3);
>>>> +    create_unimplemented_device("gpio F", OFFSET_DATA + 0x002f, 0x000=
3);
>>>> +    create_unimplemented_device("gpio E", OFFSET_DATA + 0x002c, 0x000=
3);
>>>> +    create_unimplemented_device("gpio D", OFFSET_DATA + 0x0029, 0x000=
3);
>>>> +    create_unimplemented_device("gpio C", OFFSET_DATA + 0x0026, 0x000=
3);
>>>> +    create_unimplemented_device("gpio B", OFFSET_DATA + 0x0023, 0x000=
3);
>>>> +    create_unimplemented_device("gpio A", OFFSET_DATA + 0x0020, 0x000=
3);
>>>> +
>>>> +    memory_region_allocate_system_memory(
>>>> +        sms->ram, NULL, "avr.ram", SIZE_SRAM + SIZE_EXMEM);
>>>> +    memory_region_add_subregion(system_memory, OFFSET_DATA + 0x200, s=
ms->ram);
>>>> +
>>>> +    /* Power Reduction built-in peripheral */
>>>> +    sms->prr[0] =3D AVR_MASK(sysbus_create_simple(TYPE_AVR_MASK,
>>>> +                    OFFSET_DATA + PRR0_BASE, NULL));
>>>> +    sms->prr[1] =3D AVR_MASK(sysbus_create_simple(TYPE_AVR_MASK,
>>>> +                    OFFSET_DATA + PRR1_BASE, NULL));
>>>> +
>>>> +    /* USART 0 built-in peripheral */
>>>> +    sms->usart0 =3D AVR_USART(object_new(TYPE_AVR_USART));
>>>> +    busdev =3D SYS_BUS_DEVICE(sms->usart0);
>>>> +    qdev_prop_set_chr(DEVICE(sms->usart0), "chardev", serial_hd(0));
>>>> +    object_property_set_bool(OBJECT(sms->usart0), true, "realized",
>>>> +            &error_fatal);
>>>> +    sysbus_mmio_map(busdev, 0, OFFSET_DATA + USART_BASE);
>>>> +    /*
>>>> +     * These IRQ numbers don't match the datasheet because we're coun=
ting from
>>>> +     * zero and not including reset.
>>>> +     */
>>>> +    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev, USART_RXC_=
IRQ));
>>>> +    sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev, USART_DRE_=
IRQ));
>>>> +    sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev, USART_TXC_=
IRQ));
>>>> +    sysbus_connect_irq(SYS_BUS_DEVICE(sms->prr[1]), PRR1_BIT_PRUSART1=
,
>>>> +            qdev_get_gpio_in(DEVICE(sms->usart0), 0));
>>>> +
>>>> +    /* Timer 1 built-in periphal */
>>>> +    sms->timer1 =3D AVR_TIMER16(object_new(TYPE_AVR_TIMER16));
>>>> +    object_property_set_bool(OBJECT(sms->timer1), true, "realized",
>>>> +            &error_fatal);
>>>> +    busdev =3D SYS_BUS_DEVICE(sms->timer1);
>>>> +    sysbus_mmio_map(busdev, 0, OFFSET_DATA + TIMER1_BASE);
>>>> +    sysbus_mmio_map(busdev, 1, OFFSET_DATA + TIMER1_IMSK_BASE);
>>>> +    sysbus_mmio_map(busdev, 2, OFFSET_DATA + TIMER1_IFR_BASE);
>>>> +    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev, TIMER1_CAP=
T_IRQ));
>>>> +    sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev, TIMER1_COM=
PA_IRQ));
>>>> +    sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev, TIMER1_COM=
PB_IRQ));
>>>> +    sysbus_connect_irq(busdev, 3, qdev_get_gpio_in(cpudev, TIMER1_COM=
PC_IRQ));
>>>> +    sysbus_connect_irq(busdev, 4, qdev_get_gpio_in(cpudev, TIMER1_OVF=
_IRQ));
>>>> +    sysbus_connect_irq(SYS_BUS_DEVICE(sms->prr[0]), PRR0_BIT_PRTIM1,
>>>> +            qdev_get_gpio_in(DEVICE(sms->timer1), 0));
>>>> +
>>>> +    /* Load firmware (contents of flash) trying to auto-detect format=
 */
>>>> +    if (filename !=3D NULL) {
>>>> +        bytes_loaded =3D load_elf(
>>>> +            filename, NULL, NULL, NULL, NULL, NULL, NULL, 0, EM_NONE,=
 0, 0);
>>>> +        if (bytes_loaded < 0) {
>>>> +            bytes_loaded =3D load_image_targphys(
>>>> +                filename, OFFSET_CODE, SIZE_FLASH);
>>>> +        }
>>>> +        if (bytes_loaded < 0) {
>>>> +            error_report(
>>>> +                "Unable to load firmware image %s as ELF or raw binar=
y",
>>>> +                firmware);
>>>> +            exit(1);
>>>> +        }
>>>> +    }
>>>> +}
>>>> +
>>>> +static void sample_class_init(ObjectClass *oc, void *data)
>>>> +{
>>>> +    MachineClass *mc =3D MACHINE_CLASS(oc);
>>>> +
>>>> +    mc->desc =3D "AVR sample/example board (ATmega2560)";
>>>> +    mc->init =3D sample_init;
>>>> +    mc->default_cpus =3D 1;
>>>> +    mc->min_cpus =3D mc->default_cpus;
>>>> +    mc->max_cpus =3D mc->default_cpus;
>>>> +    mc->default_cpu_type =3D "avr6-avr-cpu"; /* ATmega2560. */
>>>> +    mc->is_default =3D 1;
>>>> +}
>>>> +
>>>> +static const TypeInfo sample_info =3D {
>>>> +    .name =3D TYPE_SAMPLE_MACHINE,
>>>> +    .parent =3D TYPE_MACHINE,
>>>> +    .instance_size =3D sizeof(SampleMachineState),
>>>> +    .class_size =3D sizeof(SampleMachineClass),
>>>> +    .class_init =3D sample_class_init,
>>>> +};
>>>> +
>>>> +static void sample_machine_init(void)
>>>> +{
>>>> +    type_register_static(&sample_info);
>>>> +}
>>>> +
>>>> +type_init(sample_machine_init);
>>>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>>>> index 5099f27dc8..e6511466ba 100644
>>>> --- a/hw/core/loader.c
>>>> +++ b/hw/core/loader.c
>>>> @@ -439,7 +439,7 @@ int load_elf_ram(const char *filename,
>>>>      return load_elf_ram_sym(filename, elf_note_fn,
>>>>                              translate_fn, translate_opaque,
>>>>                              pentry, lowaddr, highaddr, big_endian,
>>>> -                            elf_machine, clear_lsb, data_swab, as,
>>>> +                            elf_machine, NULL, clear_lsb, data_swab, =
as,
>>>>                              load_rom, NULL);
>>>>  }
>>>>
>>>> @@ -449,7 +449,8 @@ int load_elf_ram_sym(const char *filename,
>>>>                       uint64_t (*translate_fn)(void *, uint64_t),
>>>>                       void *translate_opaque, uint64_t *pentry,
>>>>                       uint64_t *lowaddr, uint64_t *highaddr, int big_e=
ndian,
>>>> -                     int elf_machine, int clear_lsb, int data_swab,
>>>> +                     int elf_machine, uint32_t *pflags,
>>>> +                     int clear_lsb, int data_swab,
>>>>                       AddressSpace *as, bool load_rom, symbol_fn_t sym=
_cb)
>>>>  {
>>>>      int fd, data_order, target_data_order, must_swab, ret =3D ELF_LOA=
D_FAILED;
>>>> @@ -490,13 +491,13 @@ int load_elf_ram_sym(const char *filename,
>>>>      if (e_ident[EI_CLASS] =3D=3D ELFCLASS64) {
>>>>          ret =3D load_elf64(filename, fd, elf_note_fn,
>>>>                           translate_fn, translate_opaque, must_swab,
>>>> -                         pentry, lowaddr, highaddr, elf_machine, clea=
r_lsb,
>>>> -                         data_swab, as, load_rom, sym_cb);
>>>> +                         pentry, lowaddr, highaddr, elf_machine, pfla=
gs,
>>>> +                         clear_lsb, data_swab, as, load_rom, sym_cb);
>>>>      } else {
>>>>          ret =3D load_elf32(filename, fd, elf_note_fn,
>>>>                           translate_fn, translate_opaque, must_swab,
>>>> -                         pentry, lowaddr, highaddr, elf_machine, clea=
r_lsb,
>>>> -                         data_swab, as, load_rom, sym_cb);
>>>> +                         pentry, lowaddr, highaddr, elf_machine, pfla=
gs,
>>>> +                         clear_lsb, data_swab, as, load_rom, sym_cb);
>>>>      }
>>>>
>>>>   fail:
>>>> diff --git a/hw/Kconfig b/hw/Kconfig
>>>> index b9685b3944..07b8abb342 100644
>>>> --- a/hw/Kconfig
>>>> +++ b/hw/Kconfig
>>>> @@ -44,6 +44,7 @@ source watchdog/Kconfig
>>>>  # arch Kconfig
>>>>  source arm/Kconfig
>>>>  source alpha/Kconfig
>>>> +source avr/Kconfig
>>>>  source cris/Kconfig
>>>>  source hppa/Kconfig
>>>>  source i386/Kconfig
>>>> diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
>>>> new file mode 100644
>>>> index 0000000000..92aa1e6afb
>>>> --- /dev/null
>>>> +++ b/hw/avr/Kconfig
>>>> @@ -0,0 +1,6 @@
>>>> +config AVR_SAMPLE
>>>> +    bool
>>>> +    select AVR_TIMER16
>>>> +    select AVR_USART
>>>> +    select AVR_MASK
>>>> +    select UNIMP
>>>> diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
>>>> new file mode 100644
>>>> index 0000000000..626b7064b3
>>>> --- /dev/null
>>>> +++ b/hw/avr/Makefile.objs
>>>> @@ -0,0 +1 @@
>>>> +obj-y +=3D sample.o
>>>> --
>>>> 2.17.2 (Apple Git-113)
>>>>
>>
>>
>> --
>> Best Regards,
>> Michael Rolnik
>
>
>
> --
> Best Regards,
> Michael Rolnik

