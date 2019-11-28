Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63934C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 09:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092842176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 09:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0awIr9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092842176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaGUW-00079y-0t
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 04:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iaGKt-0007ZS-Ok
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 04:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iaG6J-0004bo-3R
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 04:28:43 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43458)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iaG6H-0004YI-0A
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 04:28:38 -0500
Received: by mail-ot1-x342.google.com with SMTP id l14so21644846oti.10
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 01:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=o4e6ivamVjNZZXyh5Crz+UrKdMWjiBr3i97TmsW6TRc=;
 b=u0awIr9C/BRUSZvWY49PJy/JoNEEwmWCdE4Ry2kjVPHAxFErz5vOEmfULE2lzaM8+5
 8xiXXpUDeY1jijt5LVgPAPb+ixuc6HY5AC6ILjA3ttP0kczlOFm9NDYFDTnVlVJPmNHO
 nwS+0IuTzGe7hdpcZgT7SqlP8P3+oJ46qKq3tI46h7/oyWp17URWVVO0H/R3aNR3vqwW
 eos0s30KD3SNqKAznMLBkPnKe6hfmQSWmd6Lh8Nv+k1GpzdxmTe3KWzmE5z7Z8WdJgp/
 KIIEp8zUXcwQ2en5MV3DxWBPyWU75FTnj0yInzYlqBkh2apL4uYiMsNQlZejDpifq6xi
 639Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=o4e6ivamVjNZZXyh5Crz+UrKdMWjiBr3i97TmsW6TRc=;
 b=pdAFxdwn/c3wPVKxgriOWgQdVutL8VHbggBnXwn+tkmTDlW9n6AuxbXHpMDCKUJneJ
 E5uvWeWzX0fiuH5QhgSYivHjugdTlAkCRYmCsaPCIfyTHeCyuDAkQJZtQY0JRn9pxvfN
 tm15TL4zO9zlBRxCVLzaPzMBz0o953sUCIHr1EMC9yj7XTE4Z+ICUgxQNQBdsp9Yl0Er
 QtCT4jX5oiW/KYUrZAwMJo4so6Fqla2kmxO0O0INwbPrc/df7OmtBd237gUCtxuGaaZf
 UlT2VViqa05Jqw3Ms/9LrY4Am/ZnzJC0711ZPdb1UPscOldK32HbHKOzWrYh9xmtY0bm
 HSrA==
X-Gm-Message-State: APjAAAWTyaIql58dwV7Tp++bkdxhu9DNGQkcUojjS6zXgbmU8FtkISdL
 HKYqizkjhRagTDqvoufy7NDMFcRg+3kgml88O4E=
X-Google-Smtp-Source: APXvYqy49CtRqrzXWhBRffQ0RNRomyN+EfBWx6UOrBnSv3rN/USxCYVmZL+k32l0/zM6cOUyXKf3C3lLmae3AMLt6uI=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr7210854otc.295.1574933313980; 
 Thu, 28 Nov 2019 01:28:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Thu, 28 Nov 2019 01:28:33
 -0800 (PST)
In-Reply-To: <20191128015030.27543-7-f4bug@amsat.org>
References: <20191128015030.27543-1-f4bug@amsat.org>
 <20191128015030.27543-7-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 28 Nov 2019 10:28:33 +0100
Message-ID: <CAL1e-=i=1zhx3q4xzh7oPzXLWAHwtEkUVTSHKqv5yy9BBRrVKw@mail.gmail.com>
Subject: Re: [RFC PATCH 06/10] hw/avr: Add ATmega microcontrollers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000b98cf2059864bc4a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Thomas Huth <huth@tuxfamily.org>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b98cf2059864bc4a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, November 28, 2019, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> Add famous ATmega MCUs:
>
> - middle range: ATmega168 and ATmega328
> - high range: ATmega1280 and ATmega2560
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---


Philippe, hi.

Thank you for the impetus you give us all.

However, is this the right direction?

Let's analyse some bits and pieces.

Starting from the commit message, the word "famous" is used, but I really
don't see enumerated CPUs/MCUs are any special in Atmel lineup. Other than
we often used the doc describing them (cited several times in our
discussions) as our reference, but that doesn't make them "famous".
Ofcourse, there other docs for other Atmel CPUs/MCUs, of at lest equivalent
significance. For example, "tiny" ones are at least as famous as "mega"
ones.

Then, you introduce the term MCU, without proper discussion with others on
terminology. In parlance of QEMU, ATmega168 at al. are CPUs (we all know
and assume that that are some peripherals in it). I am not against using
the term MCU, but let's first sync up on that.

The added terminology trouble is that MCUs, as you defined them, have in
array atmega_mcu[] a field called "cpu_type" - why is that field not called
"mcu_type"? *Very* confusing for any future reader. And then, similar
terminology conundrum continues with macro AVR_CPU_TYPE_NAME().

All of the above is far less important than this question: What are we
achieving with proposed CPU/MCU definitions? I certainly see the value of
fitting the complex variety of AVR CPUs/MCUs into QEMU object model. No
question about that. However, is this the right moment to do it? There are
still some unresolved architectural problems with peripheral definitions,
as I noted in yhe comment to Michael's last cover letter. This patch does
not solve them. It just assumes everything is ready with peripherals, let's
build CPUs/MCUs. The machines based on proposed CPUs/MCUs are not more real
that machine based on Michael's "sample" machine. At least Michal says
"this is not a real machine". If we used proposed CPUs/MCUs from this
patch, the resulting machine is as "paper" machine as yhe "sample" machine.
We would just live in a la-la lend of thinking: "wow, we model real
hardware now".

I would rather accept into QEMU a series admitting we are still far from
modelling real machine or CPU/MCU, than a series that gives an illusion
that we are modelling real machine or CPU/MCU.

As far as utility of this patch for Michael's series, it looks to me they
add more headake than help (not saying that the help is not present) to
Michael. He would have anotter abstraction layer to think of, at the moment
he desperately needs (in my opinion) to focus on providing the as solid as
possible, and as complete as possinle foundations. This patch looks like
building castles in the air. Again, I am not claiming that the patch is not
helpful at all.

In summary, I think that this patch is premature.

Sincerely,
Aleksansar



>  hw/avr/atmega.h      |  58 +++++++
>  hw/avr/atmega.c      | 379 +++++++++++++++++++++++++++++++++++++++++++
>  hw/avr/Makefile.objs |   1 +
>  3 files changed, 438 insertions(+)
>  create mode 100644 hw/avr/atmega.h
>  create mode 100644 hw/avr/atmega.c
>
> diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h
> new file mode 100644
> index 0000000000..d22d90a962
> --- /dev/null
> +++ b/hw/avr/atmega.h
> @@ -0,0 +1,58 @@
> +/*
> + * QEMU ATmega MCU
> + *
> + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
> + *
> + * This work is licensed under the terms of the GNU GPLv2 or later.
> + * See the COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_AVR_ATMEGA_H
> +#define HW_AVR_ATMEGA_H
> +
> +#include "hw/char/avr_usart.h"
> +#include "hw/char/avr_usart.h"
> +#include "hw/timer/avr_timer16.h"
> +#include "hw/misc/avr_mask.h"
> +#include "target/avr/cpu.h"
> +
> +#define TYPE_ATMEGA     "ATmega"
> +#define TYPE_ATMEGA168  "ATmega168"
> +#define TYPE_ATMEGA328  "ATmega328"
> +#define TYPE_ATMEGA1280 "ATmega1280"
> +#define TYPE_ATMEGA2560 "ATmega2560"
> +#define ATMEGA(obj)     OBJECT_CHECK(AtmegaState, (obj), TYPE_ATMEGA)
> +
> +#define USART_MAX 4
> +#define TIMER_MAX 6
> +
> +typedef struct AtmegaState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    AVRCPU cpu;
> +    MemoryRegion flash;
> +    MemoryRegion eeprom;
> +    MemoryRegion sram;
> +    DeviceState *io;
> +    AVRMaskState pwr[2];
> +    AVRUsartState usart[USART_MAX];
> +    AVRTimer16State timer[TIMER_MAX];
> +    uint64_t xtal_freq_hz;
> +} AtmegaState;
> +
> +typedef struct AtmegaInfo AtmegaInfo;
> +
> +typedef struct AtmegaClass {
> +    SysBusDeviceClass parent_class;
> +    const AtmegaInfo *info;
> +} AtmegaClass;
> +
> +#define ATMEGA_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(AtmegaClass, (klass), TYPE_ATMEGA)
> +#define ATMEGA_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(AtmegaClass, (obj), TYPE_ATMEGA)
> +
> +#endif /* HW_AVR_ATMEGA_H */
> diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
> new file mode 100644
> index 0000000000..1f1b1246ef
> --- /dev/null
> +++ b/hw/avr/atmega.c
> @@ -0,0 +1,379 @@
> +/*
> + * QEMU ATmega MCU
> + *
> + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
> + *
> + * This work is licensed under the terms of the GNU GPLv2 or later.
> + * See the COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/module.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "exec/memory.h"
> +#include "exec/address-spaces.h"
> +#include "sysemu/sysemu.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/sysbus.h"
> +#include "hw/boards.h" /* FIXME memory_region_allocate_system_memory for
> sram */
> +#include "hw/misc/unimp.h"
> +#include "atmega.h"
> +
> +enum AtmegaIrq {
> +    USART0_RXC_IRQ, USART0_DRE_IRQ, USART0_TXC_IRQ,
> +    USART1_RXC_IRQ, USART1_DRE_IRQ, USART1_TXC_IRQ,
> +    USART2_RXC_IRQ, USART2_DRE_IRQ, USART2_TXC_IRQ,
> +    USART3_RXC_IRQ, USART3_DRE_IRQ, USART3_TXC_IRQ,
> +    TIMER0_CAPT_IRQ, TIMER0_COMPA_IRQ, TIMER0_COMPB_IRQ,
> +        TIMER0_COMPC_IRQ, TIMER0_OVF_IRQ,
> +    TIMER1_CAPT_IRQ, TIMER1_COMPA_IRQ, TIMER1_COMPB_IRQ,
> +        TIMER1_COMPC_IRQ, TIMER1_OVF_IRQ,
> +    TIMER2_CAPT_IRQ, TIMER2_COMPA_IRQ, TIMER2_COMPB_IRQ,
> +        TIMER2_COMPC_IRQ, TIMER2_OVF_IRQ,
> +    TIMER3_CAPT_IRQ, TIMER3_COMPA_IRQ, TIMER3_COMPB_IRQ,
> +        TIMER3_COMPC_IRQ, TIMER3_OVF_IRQ,
> +    TIMER4_CAPT_IRQ, TIMER4_COMPA_IRQ, TIMER4_COMPB_IRQ,
> +        TIMER4_COMPC_IRQ, TIMER4_OVF_IRQ,
> +    TIMER5_CAPT_IRQ, TIMER5_COMPA_IRQ, TIMER5_COMPB_IRQ,
> +        TIMER5_COMPC_IRQ, TIMER5_OVF_IRQ,
> +};
> +#define IRQ_MAX             64
> +
> +#define USART_RXC_IRQ(n)    (3 * n + USART0_RXC_IRQ)
> +#define USART_DRE_IRQ(n)    (3 * n + USART0_DRE_IRQ)
> +#define USART_TXC_IRQ(n)    (3 * n + USART0_TXC_IRQ)
> +#define TIMER_CAPT_IRQ(n)   (5 * n + TIMER0_CAPT_IRQ)
> +#define TIMER_COMPA_IRQ(n)  (5 * n + TIMER0_COMPA_IRQ)
> +#define TIMER_COMPB_IRQ(n)  (5 * n + TIMER0_COMPB_IRQ)
> +#define TIMER_COMPC_IRQ(n)  (5 * n + TIMER0_COMPC_IRQ)
> +#define TIMER_OVF_IRQ(n)    (5 * n + TIMER0_OVF_IRQ)
> +
> +static const uint8_t irq168_328[IRQ_MAX] =3D {
> +    [TIMER2_COMPA_IRQ]      =3D 8,
> +    [TIMER2_COMPB_IRQ]      =3D 9,
> +    [TIMER2_OVF_IRQ]        =3D 10,
> +    [TIMER1_CAPT_IRQ]       =3D 11,
> +    [TIMER1_COMPA_IRQ]      =3D 12,
> +    [TIMER1_COMPB_IRQ]      =3D 13,
> +    [TIMER1_OVF_IRQ]        =3D 14,
> +    [TIMER0_COMPA_IRQ]      =3D 15,
> +    [TIMER0_COMPB_IRQ]      =3D 16,
> +    [TIMER0_OVF_IRQ]        =3D 17,
> +    [USART0_RXC_IRQ]        =3D 19,
> +    [USART0_DRE_IRQ]        =3D 20,
> +    [USART0_TXC_IRQ]        =3D 21,
> +}, irq1280_2560[IRQ_MAX] =3D {
> +    [TIMER2_COMPA_IRQ]      =3D 14,
> +    [TIMER2_COMPB_IRQ]      =3D 15,
> +    [TIMER2_OVF_IRQ]        =3D 16,
> +    [TIMER1_CAPT_IRQ]       =3D 17,
> +    [TIMER1_COMPA_IRQ]      =3D 18,
> +    [TIMER1_COMPB_IRQ]      =3D 19,
> +    [TIMER1_COMPC_IRQ]      =3D 20,
> +    [TIMER1_OVF_IRQ]        =3D 21,
> +    [TIMER0_COMPA_IRQ]      =3D 22,
> +    [TIMER0_COMPB_IRQ]      =3D 23,
> +    [TIMER0_OVF_IRQ]        =3D 24,
> +    [USART0_RXC_IRQ]        =3D 26,
> +    [USART0_DRE_IRQ]        =3D 27,
> +    [USART0_TXC_IRQ]        =3D 28,
> +    [TIMER3_CAPT_IRQ]       =3D 32,
> +    [TIMER3_COMPA_IRQ]      =3D 33,
> +    [TIMER3_COMPB_IRQ]      =3D 34,
> +    [TIMER3_COMPC_IRQ]      =3D 35,
> +    [TIMER3_OVF_IRQ]        =3D 36,
> +    [USART1_RXC_IRQ]        =3D 37,
> +    [USART1_DRE_IRQ]        =3D 38,
> +    [USART1_TXC_IRQ]        =3D 39,
> +    [USART2_RXC_IRQ]        =3D 52,
> +    [USART2_DRE_IRQ]        =3D 53,
> +    [USART2_TXC_IRQ]        =3D 54,
> +    [USART3_RXC_IRQ]        =3D 55,
> +    [USART3_DRE_IRQ]        =3D 56,
> +    [USART3_TXC_IRQ]        =3D 57,
> +};
> +
> +enum AtmegaPeripheralAddress {
> +    USART0, USART1, USART2, USART3,
> +    TIMER0, TIMER1, TIMER2, TIMER3, TIMER4, TIMER5,
> +    DEV_MAX
> +};
> +
> +#define USART_ADDR(n)       (n + USART0)
> +#define TIMER_ADDR(n)       (n + TIMER0)
> +
> +typedef struct {
> +    uint16_t addr;
> +    uint16_t prr_addr;
> +    uint8_t prr_bit;
> +    /* timer specific */
> +    uint16_t intmask_addr;
> +    uint16_t intflag_addr;
> +    bool is_timer16;
> +} peripheral_cfg;
> +
> +static const peripheral_cfg dev168_328[DEV_MAX] =3D {
> +    [TIMER0]        =3D {  0x24, 0x64, 5, 0x6e, 0x35, false },
> +    [TIMER1]        =3D {  0x80, 0x64, 3, 0x6f, 0x36, true },
> +    [TIMER2]        =3D {  0xb0, 0x64, 6, 0x70, 0x37, false },
> +    [USART0]        =3D {  0xc0, 0x64, 1 },
> +}, dev1280_2560[DEV_MAX] =3D {
> +    [TIMER0]        =3D {  0x24, 0x64, 5, 0x6e, 0x35, false },
> +    [TIMER1]        =3D {  0x80, 0x64, 3, 0x6f, 0x36, true },
> +    [TIMER3]        =3D {  0x90, 0x65, 3, 0x71, 0x38, true },
> +    [TIMER4]        =3D {  0xa0, 0x65, 4, 0x72, 0x39, true },
> +    [TIMER2]        =3D {  0xb0, 0x64, 6, 0x70, 0x37, false },
> +    [USART0]        =3D {  0xc0, 0x64, 1 },
> +    [USART1]        =3D {  0xc8, 0x65, 0 },
> +    [USART2]        =3D {  0xd0, 0x65, 1 },
> +    [TIMER5]        =3D { 0x120, 0x65, 5, 0x73, 0x3a, true },
> +    [USART3]        =3D { 0x130, 0x65, 2 },
> +};
> +
> +struct AtmegaInfo {
> +    const char *uc_name;
> +    const char *cpu_type;
> +    size_t flash_size;
> +    size_t eeprom_size;
> +    size_t sram_size;
> +    size_t io_size;
> +    size_t uart_count;
> +    size_t timer_count;
> +    size_t gpio_count;
> +    size_t adc_count;
> +    const uint8_t *irq;
> +    const peripheral_cfg *dev;
> +};
> +
> +static const AtmegaInfo atmega_mcu[] =3D {
> +    {
> +        .uc_name =3D TYPE_ATMEGA168,
> +        .cpu_type =3D AVR_CPU_TYPE_NAME("avr5"),
> +        .flash_size =3D 16 * KiB,
> +        .eeprom_size =3D 512,
> +        .sram_size =3D 1 * KiB,
> +        .io_size =3D 256,
> +        .uart_count =3D 1,
> +        .gpio_count =3D 23,
> +        .adc_count =3D 6,
> +        .irq =3D irq168_328,
> +        .dev =3D dev168_328,
> +    },
> +    {
> +        .uc_name =3D TYPE_ATMEGA328,
> +        .cpu_type =3D AVR_CPU_TYPE_NAME("avr5"),
> +        .flash_size =3D 32 * KiB,
> +        .eeprom_size =3D 1 * KiB,
> +        .sram_size =3D 2 * KiB,
> +        .io_size =3D 256,
> +        .uart_count =3D 1,
> +        .timer_count =3D 3,
> +        .gpio_count =3D 23,
> +        .adc_count =3D 6,
> +        .irq =3D irq168_328,
> +        .dev =3D dev168_328,
> +    },
> +    {
> +        .uc_name =3D TYPE_ATMEGA1280,
> +        .cpu_type =3D AVR_CPU_TYPE_NAME("avr6"),
> +        .flash_size =3D 128 * KiB,
> +        .eeprom_size =3D 4 * KiB,
> +        .sram_size =3D 8 * KiB,
> +        .io_size =3D 512,
> +        .uart_count =3D 4,
> +        .timer_count =3D 6,
> +        .gpio_count =3D 86,
> +        .adc_count =3D 16,
> +        .irq =3D irq1280_2560,
> +        .dev =3D dev1280_2560,
> +    },
> +    {
> +        .uc_name =3D TYPE_ATMEGA2560,
> +        .cpu_type =3D AVR_CPU_TYPE_NAME("avr6"),
> +        .flash_size =3D 256 * KiB,
> +        .eeprom_size =3D 4 * KiB,
> +        .sram_size =3D 8 * KiB,
> +        .io_size =3D 512,
> +        .uart_count =3D 4,
> +        .timer_count =3D 6,
> +        .gpio_count =3D 54,
> +        .adc_count =3D 16,
> +        .irq =3D irq1280_2560,
> +        .dev =3D dev1280_2560,
> +    },
> +};
> +
> +static void connect_nonnull_irq(SysBusDevice *sbd, DeviceState *dev,
> +                                int n, int irq)
> +{
> +    if (irq) {
> +        sysbus_connect_irq(sbd, n, qdev_get_gpio_in(dev, irq));
> +    }
> +}
> +
> +static void connect_pr_irq(AtmegaState *s, const AtmegaInfo *info,
> +                           DeviceState *dev, int index)
> +{
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pwr[info->dev[index].prr_addr
> & 1]),
> +                       info->dev[index].prr_bit,
> +                       qdev_get_gpio_in(dev, 0));
> +}
> +
> +static void atmega_realize(DeviceState *dev, Error **errp)
> +{
> +    AtmegaState *s =3D ATMEGA(dev);
> +    AtmegaClass *bc =3D ATMEGA_GET_CLASS(dev);
> +    const AtmegaInfo *info =3D bc->info;
> +    DeviceState *cpudev;
> +    SysBusDevice *sbd;
> +    Error *err =3D NULL;
> +    char *devname;
> +    size_t i;
> +
> +    if (!s->xtal_freq_hz) {
> +        error_setg(errp, "\"xtal-frequency-hz\" property must be
> provided.");
> +        return;
> +    }
> +
> +    /* CPU */
> +    object_initialize_child(OBJECT(dev), "cpu", &s->cpu, sizeof(s->cpu),
> +                            info->cpu_type, &err, NULL);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    object_property_set_bool(OBJECT(&s->cpu), true, "realized",
> &error_abort);
> +    cpudev =3D DEVICE(&s->cpu);
> +
> +    /* SRAM */
> +    memory_region_allocate_system_memory(&s->sram, OBJECT(dev),
> +                                         "sram", info->sram_size);
> +    memory_region_add_subregion(get_system_memory(),
> +                                OFFSET_DATA + 0x200, &s->sram);
> +
> +    /* Flash */
> +    memory_region_init_rom(&s->flash, OBJECT(dev),
> +                           "flash", info->flash_size, &error_fatal);
> +    memory_region_add_subregion(get_system_memory(), OFFSET_CODE,
> &s->flash);
> +
> +    /* I/O */
> +    s->io =3D qdev_create(NULL, TYPE_UNIMPLEMENTED_DEVICE);
> +    qdev_prop_set_string(s->io, "name", "I/O");
> +    qdev_prop_set_uint64(s->io, "size", info->io_size);
> +    qdev_init_nofail(s->io);
> +    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->io), 0, OFFSET_DATA,
> -1234);
> +
> +    /* Power */
> +    for (i =3D 0; i < ARRAY_SIZE(s->pwr); i++) {
> +        devname =3D g_strdup_printf("pwr%zu", i);
> +        object_initialize_child(OBJECT(dev), devname,
> +                                &s->pwr[i], sizeof(s->pwr[i]),
> +                                TYPE_AVR_MASK, &error_abort, NULL);
> +        object_property_set_bool(OBJECT(&s->pwr[i]), true, "realized",
> +                                 &error_abort);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->pwr[i]), 0, OFFSET_DATA +
> 0x64 + i);
> +        g_free(devname);
> +    }
> +
> +    /* USART */
> +    for (i =3D 0; i < info->uart_count; i++) {
> +        devname =3D g_strdup_printf("usart%zu", i);
> +        object_initialize_child(OBJECT(dev), devname,
> +                                &s->usart[i], sizeof(s->usart[i]),
> +                                TYPE_AVR_USART, &error_abort, NULL);
> +        qdev_prop_set_chr(DEVICE(&s->usart[i]), "chardev", serial_hd(i))=
;
> +        object_property_set_bool(OBJECT(&s->usart[i]), true, "realized",
> +                                 &error_abort);
> +        sbd =3D SYS_BUS_DEVICE(&s->usart[i]);
> +        sysbus_mmio_map(sbd, 0, OFFSET_DATA +
> info->dev[USART_ADDR(i)].addr);
> +        connect_nonnull_irq(sbd, cpudev, 0, info->irq[USART_RXC_IRQ(i)])=
;
> +        connect_nonnull_irq(sbd, cpudev, 1, info->irq[USART_DRE_IRQ(i)])=
;
> +        connect_nonnull_irq(sbd, cpudev, 2, info->irq[USART_TXC_IRQ(i)])=
;
> +        connect_pr_irq(s, info, DEVICE(&s->usart[i]), 0);
> +        g_free(devname);
> +    }
> +
> +    /* Timer */
> +    for (i =3D 0; i < info->timer_count; i++) {
> +        int idx =3D TIMER_ADDR(i);
> +        if (!info->dev[idx].is_timer16) {
> +            create_unimplemented_device("avr-timer8",
> +                                        OFFSET_DATA +
> info->dev[idx].addr, 7);
> +            create_unimplemented_device("avr-timer8-intmask",
> +                                        OFFSET_DATA
> +                                        + info->dev[idx].intmask_addr, 1=
);
> +            create_unimplemented_device("avr-timer8-intflag",
> +                                        OFFSET_DATA
> +                                        + info->dev[idx].intflag_addr, 1=
);
> +            continue;
> +        }
> +        devname =3D g_strdup_printf("timer%zu", i);
> +        object_initialize_child(OBJECT(dev), devname,
> +                                &s->timer[i], sizeof(s->timer[i]),
> +                                TYPE_AVR_TIMER16, &error_abort, NULL);
> +        object_property_set_uint(OBJECT(&s->timer[i]), s->xtal_freq_hz,
> +                                 "cpu-frequency-hz", &error_abort);
> +        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized",
> +                                 &error_abort);
> +        sbd =3D SYS_BUS_DEVICE(&s->timer[i]);
> +        sysbus_mmio_map(sbd, 0, OFFSET_DATA + info->dev[idx].addr);
> +        sysbus_mmio_map(sbd, 1, OFFSET_DATA +
> info->dev[idx].intmask_addr);
> +        sysbus_mmio_map(sbd, 2, OFFSET_DATA +
> info->dev[idx].intflag_addr);
> +        connect_nonnull_irq(sbd, cpudev, 0, info->irq[TIMER_CAPT_IRQ(i)]=
);
> +        connect_nonnull_irq(sbd, cpudev, 1, info->irq[TIMER_COMPA_IRQ(i)=
])
> ;
> +        connect_nonnull_irq(sbd, cpudev, 2, info->irq[TIMER_COMPB_IRQ(i)=
])
> ;
> +        connect_nonnull_irq(sbd, cpudev, 3, info->irq[TIMER_COMPC_IRQ(i)=
])
> ;
> +        connect_nonnull_irq(sbd, cpudev, 4, info->irq[TIMER_OVF_IRQ(i)])=
;
> +        connect_pr_irq(s, info, DEVICE(&s->timer[i]), 0);
> +        g_free(devname);
> +    }
> +}
> +
> +static Property atmega_props[] =3D {
> +    DEFINE_PROP_UINT64("xtal-frequency-hz", AtmegaState,
> +                       xtal_freq_hz, 0),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
> +static void atmega_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +    AtmegaClass *bc =3D ATMEGA_CLASS(oc);
> +
> +    bc->info =3D data;
> +    dc->realize =3D atmega_realize;
> +    dc->props =3D atmega_props;
> +    /* Reason: Mapped at fixed location on the system bus */
> +    dc->user_creatable =3D false;
> +}
> +
> +static const TypeInfo atmega_type_info =3D {
> +    .name =3D TYPE_ATMEGA,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(AtmegaState),
> +    .class_size =3D sizeof(AtmegaClass),
> +    .abstract =3D true,
> +};
> +
> +static void atmega_register_types(void)
> +{
> +    size_t i;
> +
> +    type_register_static(&atmega_type_info);
> +    for (i =3D 0; i < ARRAY_SIZE(atmega_mcu); i++) {
> +        assert(atmega_mcu[i].io_size <=3D 0x200);
> +        assert(atmega_mcu[i].uart_count <=3D USART_MAX);
> +        assert(atmega_mcu[i].timer_count <=3D TIMER_MAX);
> +        TypeInfo ti =3D {
> +            .name =3D atmega_mcu[i].uc_name,
> +            .parent =3D TYPE_ATMEGA,
> +            .class_init =3D atmega_class_init,
> +            .class_data =3D (void *) &atmega_mcu[i],
> +        };
> +        type_register(&ti);
> +    }
> +}
> +
> +type_init(atmega_register_types)
> diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
> index 626b7064b3..4b6b911820 100644
> --- a/hw/avr/Makefile.objs
> +++ b/hw/avr/Makefile.objs
> @@ -1 +1,2 @@
>  obj-y +=3D sample.o
> +obj-y +=3D atmega.o
> --
> 2.21.0
>
>

--000000000000b98cf2059864bc4a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, November 28, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a =
href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">Add famous ATmega MCUs:<br>
<br>
- middle range: ATmega168 and ATmega328<br>
- high range: ATmega1280 and ATmega2560<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org">f4bug@amsat.org</a>&gt;<br>
---</blockquote><div><br></div><div>Philippe, hi.</div><div><br></div><div>=
Thank you for the impetus you give us all.</div><div><br></div><div>However=
, is this the right direction?</div><div><br></div><div>Let&#39;s analyse s=
ome bits and pieces.</div><div><br></div><div>Starting from the commit mess=
age, the word &quot;famous&quot; is used, but I really don&#39;t see enumer=
ated CPUs/MCUs are any special in Atmel lineup. Other than we often used th=
e doc describing them=C2=A0(cited several times in our discussions)=C2=A0as=
=C2=A0our reference, but that=C2=A0doesn&#39;t make them &quot;famous&quot;=
. Ofcourse, there other docs for other Atmel CPUs/MCUs, of at lest equivale=
nt significance. For example, &quot;tiny&quot; ones are at least as famous =
as &quot;mega&quot; ones.</div><div><br></div><div>Then, you introduce the =
term MCU, without proper discussion with others on terminology. In parlance=
 of QEMU, ATmega168 at al. are CPUs (we all know and assume that that are s=
ome peripherals in it). I am not against using the term MCU, but let&#39;s =
first sync up on that.</div><div><br></div><div>The added terminology troub=
le is that MCUs, as you defined them, have in array atmega_mcu[] a field ca=
lled &quot;cpu_type&quot; - why is that field not called &quot;mcu_type&quo=
t;? *Very* confusing for any future reader. And then, similar terminology c=
onundrum continues with macro AVR_CPU_TYPE_NAME().</div><div><br></div><div=
>All of the above is far less important than this question: What are we ach=
ieving with proposed CPU/MCU definitions? I certainly see the value of fitt=
ing the complex variety of AVR CPUs/MCUs into QEMU object model. No questio=
n about that. However, is this the right moment to do it? There are still s=
ome unresolved architectural problems with peripheral definitions, as I not=
ed in yhe comment to Michael&#39;s last cover letter. This patch does not s=
olve them. It just assumes everything is ready with peripherals, let&#39;s =
build CPUs/MCUs. The machines based on proposed CPUs/MCUs are not more real=
 that machine based on Michael&#39;s &quot;sample&quot; machine. At least M=
ichal says &quot;this is not a real machine&quot;. If we used proposed CPUs=
/MCUs from this patch, the resulting machine is as &quot;paper&quot; machin=
e as yhe &quot;sample&quot; machine. We would just live in a la-la lend of =
thinking: &quot;wow, we model real hardware now&quot;.</div><div><br></div>=
<div>I would rather accept into QEMU a series admitting we are still far fr=
om modelling real machine or CPU/MCU, than a series that gives an illusion =
that we are modelling real machine or CPU/MCU.</div><div><br></div><div>As =
far as utility of this patch for Michael&#39;s series, it looks to me they =
add more headake than help (not saying that the help is not present) to Mic=
hael. He would have anotter abstraction layer to think of, at the moment he=
 desperately needs (in my opinion) to focus on providing the as solid as po=
ssible, and as complete as possinle foundations. This patch looks like buil=
ding castles in the air. Again, I am not claiming that the patch is not hel=
pful at all.</div><div><br></div><div>In summary, I think that this patch i=
s premature.</div><div><br></div><div>Sincerely,</div><div>Aleksansar</div>=
<div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0hw/avr/atmega.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 58 +++++++<br>
=C2=A0hw/avr/atmega.c=C2=A0 =C2=A0 =C2=A0 | 379 +++++++++++++++++++++++++++=
+++<wbr>+++++++++++++<br>
=C2=A0hw/avr/Makefile.objs |=C2=A0 =C2=A01 +<br>
=C2=A03 files changed, 438 insertions(+)<br>
=C2=A0create mode 100644 hw/avr/atmega.h<br>
=C2=A0create mode 100644 hw/avr/atmega.c<br>
<br>
diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h<br>
new file mode 100644<br>
index 0000000000..d22d90a962<br>
--- /dev/null<br>
+++ b/hw/avr/atmega.h<br>
@@ -0,0 +1,58 @@<br>
+/*<br>
+ * QEMU ATmega MCU<br>
+ *<br>
+ * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9<br>
+ *<br>
+ * This work is licensed under the terms of the GNU GPLv2 or later.<br>
+ * See the COPYING file in the top-level directory.<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#ifndef HW_AVR_ATMEGA_H<br>
+#define HW_AVR_ATMEGA_H<br>
+<br>
+#include &quot;hw/char/avr_usart.h&quot;<br>
+#include &quot;hw/char/avr_usart.h&quot;<br>
+#include &quot;hw/timer/avr_timer16.h&quot;<br>
+#include &quot;hw/misc/avr_mask.h&quot;<br>
+#include &quot;target/avr/cpu.h&quot;<br>
+<br>
+#define TYPE_ATMEGA=C2=A0 =C2=A0 =C2=A0&quot;ATmega&quot;<br>
+#define TYPE_ATMEGA168=C2=A0 &quot;ATmega168&quot;<br>
+#define TYPE_ATMEGA328=C2=A0 &quot;ATmega328&quot;<br>
+#define TYPE_ATMEGA1280 &quot;ATmega1280&quot;<br>
+#define TYPE_ATMEGA2560 &quot;ATmega2560&quot;<br>
+#define ATMEGA(obj)=C2=A0 =C2=A0 =C2=A0OBJECT_CHECK(AtmegaState, (obj), TY=
PE_ATMEGA)<br>
+<br>
+#define USART_MAX 4<br>
+#define TIMER_MAX 6<br>
+<br>
+typedef struct AtmegaState {<br>
+=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
+=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
+=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
+<br>
+=C2=A0 =C2=A0 AVRCPU cpu;<br>
+=C2=A0 =C2=A0 MemoryRegion flash;<br>
+=C2=A0 =C2=A0 MemoryRegion eeprom;<br>
+=C2=A0 =C2=A0 MemoryRegion sram;<br>
+=C2=A0 =C2=A0 DeviceState *io;<br>
+=C2=A0 =C2=A0 AVRMaskState pwr[2];<br>
+=C2=A0 =C2=A0 AVRUsartState usart[USART_MAX];<br>
+=C2=A0 =C2=A0 AVRTimer16State timer[TIMER_MAX];<br>
+=C2=A0 =C2=A0 uint64_t xtal_freq_hz;<br>
+} AtmegaState;<br>
+<br>
+typedef struct AtmegaInfo AtmegaInfo;<br>
+<br>
+typedef struct AtmegaClass {<br>
+=C2=A0 =C2=A0 SysBusDeviceClass parent_class;<br>
+=C2=A0 =C2=A0 const AtmegaInfo *info;<br>
+} AtmegaClass;<br>
+<br>
+#define ATMEGA_CLASS(klass) \<br>
+=C2=A0 =C2=A0 OBJECT_CLASS_CHECK(<wbr>AtmegaClass, (klass), TYPE_ATMEGA)<b=
r>
+#define ATMEGA_GET_CLASS(obj) \<br>
+=C2=A0 =C2=A0 OBJECT_GET_CLASS(AtmegaClass, (obj), TYPE_ATMEGA)<br>
+<br>
+#endif /* HW_AVR_ATMEGA_H */<br>
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c<br>
new file mode 100644<br>
index 0000000000..1f1b1246ef<br>
--- /dev/null<br>
+++ b/hw/avr/atmega.c<br>
@@ -0,0 +1,379 @@<br>
+/*<br>
+ * QEMU ATmega MCU<br>
+ *<br>
+ * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9<br>
+ *<br>
+ * This work is licensed under the terms of the GNU GPLv2 or later.<br>
+ * See the COPYING file in the top-level directory.<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/module.h&quot;<br>
+#include &quot;qemu/units.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;exec/memory.h&quot;<br>
+#include &quot;exec/address-spaces.h&quot;<br>
+#include &quot;sysemu/sysemu.h&quot;<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;hw/boards.h&quot; /* FIXME memory_region_allocate_system_<w=
br>memory for sram */<br>
+#include &quot;hw/misc/unimp.h&quot;<br>
+#include &quot;atmega.h&quot;<br>
+<br>
+enum AtmegaIrq {<br>
+=C2=A0 =C2=A0 USART0_RXC_IRQ, USART0_DRE_IRQ, USART0_TXC_IRQ,<br>
+=C2=A0 =C2=A0 USART1_RXC_IRQ, USART1_DRE_IRQ, USART1_TXC_IRQ,<br>
+=C2=A0 =C2=A0 USART2_RXC_IRQ, USART2_DRE_IRQ, USART2_TXC_IRQ,<br>
+=C2=A0 =C2=A0 USART3_RXC_IRQ, USART3_DRE_IRQ, USART3_TXC_IRQ,<br>
+=C2=A0 =C2=A0 TIMER0_CAPT_IRQ, TIMER0_COMPA_IRQ, TIMER0_COMPB_IRQ,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TIMER0_COMPC_IRQ, TIMER0_OVF_IRQ,<br>
+=C2=A0 =C2=A0 TIMER1_CAPT_IRQ, TIMER1_COMPA_IRQ, TIMER1_COMPB_IRQ,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TIMER1_COMPC_IRQ, TIMER1_OVF_IRQ,<br>
+=C2=A0 =C2=A0 TIMER2_CAPT_IRQ, TIMER2_COMPA_IRQ, TIMER2_COMPB_IRQ,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TIMER2_COMPC_IRQ, TIMER2_OVF_IRQ,<br>
+=C2=A0 =C2=A0 TIMER3_CAPT_IRQ, TIMER3_COMPA_IRQ, TIMER3_COMPB_IRQ,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TIMER3_COMPC_IRQ, TIMER3_OVF_IRQ,<br>
+=C2=A0 =C2=A0 TIMER4_CAPT_IRQ, TIMER4_COMPA_IRQ, TIMER4_COMPB_IRQ,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TIMER4_COMPC_IRQ, TIMER4_OVF_IRQ,<br>
+=C2=A0 =C2=A0 TIMER5_CAPT_IRQ, TIMER5_COMPA_IRQ, TIMER5_COMPB_IRQ,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TIMER5_COMPC_IRQ, TIMER5_OVF_IRQ,<br>
+};<br>
+#define IRQ_MAX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A064<br>
+<br>
+#define USART_RXC_IRQ(n)=C2=A0 =C2=A0 (3 * n + USART0_RXC_IRQ)<br>
+#define USART_DRE_IRQ(n)=C2=A0 =C2=A0 (3 * n + USART0_DRE_IRQ)<br>
+#define USART_TXC_IRQ(n)=C2=A0 =C2=A0 (3 * n + USART0_TXC_IRQ)<br>
+#define TIMER_CAPT_IRQ(n)=C2=A0 =C2=A0(5 * n + TIMER0_CAPT_IRQ)<br>
+#define TIMER_COMPA_IRQ(n)=C2=A0 (5 * n + TIMER0_COMPA_IRQ)<br>
+#define TIMER_COMPB_IRQ(n)=C2=A0 (5 * n + TIMER0_COMPB_IRQ)<br>
+#define TIMER_COMPC_IRQ(n)=C2=A0 (5 * n + TIMER0_COMPC_IRQ)<br>
+#define TIMER_OVF_IRQ(n)=C2=A0 =C2=A0 (5 * n + TIMER0_OVF_IRQ)<br>
+<br>
+static const uint8_t irq168_328[IRQ_MAX] =3D {<br>
+=C2=A0 =C2=A0 [TIMER2_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 8,<br>
+=C2=A0 =C2=A0 [TIMER2_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 9,<br>
+=C2=A0 =C2=A0 [TIMER2_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 10,<br>
+=C2=A0 =C2=A0 [TIMER1_CAPT_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 11,<br>
+=C2=A0 =C2=A0 [TIMER1_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 12,<br>
+=C2=A0 =C2=A0 [TIMER1_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 13,<br>
+=C2=A0 =C2=A0 [TIMER1_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 14,<br>
+=C2=A0 =C2=A0 [TIMER0_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 15,<br>
+=C2=A0 =C2=A0 [TIMER0_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 16,<br>
+=C2=A0 =C2=A0 [TIMER0_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 17,<br>
+=C2=A0 =C2=A0 [USART0_RXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 19,<br>
+=C2=A0 =C2=A0 [USART0_DRE_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 20,<br>
+=C2=A0 =C2=A0 [USART0_TXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 21,<br>
+}, irq1280_2560[IRQ_MAX] =3D {<br>
+=C2=A0 =C2=A0 [TIMER2_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 14,<br>
+=C2=A0 =C2=A0 [TIMER2_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 15,<br>
+=C2=A0 =C2=A0 [TIMER2_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 16,<br>
+=C2=A0 =C2=A0 [TIMER1_CAPT_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 17,<br>
+=C2=A0 =C2=A0 [TIMER1_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 18,<br>
+=C2=A0 =C2=A0 [TIMER1_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 19,<br>
+=C2=A0 =C2=A0 [TIMER1_COMPC_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 20,<br>
+=C2=A0 =C2=A0 [TIMER1_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 21,<br>
+=C2=A0 =C2=A0 [TIMER0_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 22,<br>
+=C2=A0 =C2=A0 [TIMER0_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 23,<br>
+=C2=A0 =C2=A0 [TIMER0_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 24,<br>
+=C2=A0 =C2=A0 [USART0_RXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 26,<br>
+=C2=A0 =C2=A0 [USART0_DRE_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 27,<br>
+=C2=A0 =C2=A0 [USART0_TXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 28,<br>
+=C2=A0 =C2=A0 [TIMER3_CAPT_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 32,<br>
+=C2=A0 =C2=A0 [TIMER3_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 33,<br>
+=C2=A0 =C2=A0 [TIMER3_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 34,<br>
+=C2=A0 =C2=A0 [TIMER3_COMPC_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 35,<br>
+=C2=A0 =C2=A0 [TIMER3_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 36,<br>
+=C2=A0 =C2=A0 [USART1_RXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 37,<br>
+=C2=A0 =C2=A0 [USART1_DRE_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 38,<br>
+=C2=A0 =C2=A0 [USART1_TXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 39,<br>
+=C2=A0 =C2=A0 [USART2_RXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 52,<br>
+=C2=A0 =C2=A0 [USART2_DRE_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 53,<br>
+=C2=A0 =C2=A0 [USART2_TXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 54,<br>
+=C2=A0 =C2=A0 [USART3_RXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 55,<br>
+=C2=A0 =C2=A0 [USART3_DRE_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 56,<br>
+=C2=A0 =C2=A0 [USART3_TXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 57,<br>
+};<br>
+<br>
+enum AtmegaPeripheralAddress {<br>
+=C2=A0 =C2=A0 USART0, USART1, USART2, USART3,<br>
+=C2=A0 =C2=A0 TIMER0, TIMER1, TIMER2, TIMER3, TIMER4, TIMER5,<br>
+=C2=A0 =C2=A0 DEV_MAX<br>
+};<br>
+<br>
+#define USART_ADDR(n)=C2=A0 =C2=A0 =C2=A0 =C2=A0(n + USART0)<br>
+#define TIMER_ADDR(n)=C2=A0 =C2=A0 =C2=A0 =C2=A0(n + TIMER0)<br>
+<br>
+typedef struct {<br>
+=C2=A0 =C2=A0 uint16_t addr;<br>
+=C2=A0 =C2=A0 uint16_t prr_addr;<br>
+=C2=A0 =C2=A0 uint8_t prr_bit;<br>
+=C2=A0 =C2=A0 /* timer specific */<br>
+=C2=A0 =C2=A0 uint16_t intmask_addr;<br>
+=C2=A0 =C2=A0 uint16_t intflag_addr;<br>
+=C2=A0 =C2=A0 bool is_timer16;<br>
+} peripheral_cfg;<br>
+<br>
+static const peripheral_cfg dev168_328[DEV_MAX] =3D {<br>
+=C2=A0 =C2=A0 [TIMER0]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x24, 0x64, =
5, 0x6e, 0x35, false },<br>
+=C2=A0 =C2=A0 [TIMER1]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x80, 0x64, =
3, 0x6f, 0x36, true },<br>
+=C2=A0 =C2=A0 [TIMER2]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xb0, 0x64, =
6, 0x70, 0x37, false },<br>
+=C2=A0 =C2=A0 [USART0]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xc0, 0x64, =
1 },<br>
+}, dev1280_2560[DEV_MAX] =3D {<br>
+=C2=A0 =C2=A0 [TIMER0]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x24, 0x64, =
5, 0x6e, 0x35, false },<br>
+=C2=A0 =C2=A0 [TIMER1]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x80, 0x64, =
3, 0x6f, 0x36, true },<br>
+=C2=A0 =C2=A0 [TIMER3]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x90, 0x65, =
3, 0x71, 0x38, true },<br>
+=C2=A0 =C2=A0 [TIMER4]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xa0, 0x65, =
4, 0x72, 0x39, true },<br>
+=C2=A0 =C2=A0 [TIMER2]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xb0, 0x64, =
6, 0x70, 0x37, false },<br>
+=C2=A0 =C2=A0 [USART0]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xc0, 0x64, =
1 },<br>
+=C2=A0 =C2=A0 [USART1]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xc8, 0x65, =
0 },<br>
+=C2=A0 =C2=A0 [USART2]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xd0, 0x65, =
1 },<br>
+=C2=A0 =C2=A0 [TIMER5]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D { 0x120, 0x65, 5, 0x=
73, 0x3a, true },<br>
+=C2=A0 =C2=A0 [USART3]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D { 0x130, 0x65, 2 },<=
br>
+};<br>
+<br>
+struct AtmegaInfo {<br>
+=C2=A0 =C2=A0 const char *uc_name;<br>
+=C2=A0 =C2=A0 const char *cpu_type;<br>
+=C2=A0 =C2=A0 size_t flash_size;<br>
+=C2=A0 =C2=A0 size_t eeprom_size;<br>
+=C2=A0 =C2=A0 size_t sram_size;<br>
+=C2=A0 =C2=A0 size_t io_size;<br>
+=C2=A0 =C2=A0 size_t uart_count;<br>
+=C2=A0 =C2=A0 size_t timer_count;<br>
+=C2=A0 =C2=A0 size_t gpio_count;<br>
+=C2=A0 =C2=A0 size_t adc_count;<br>
+=C2=A0 =C2=A0 const uint8_t *irq;<br>
+=C2=A0 =C2=A0 const peripheral_cfg *dev;<br>
+};<br>
+<br>
+static const AtmegaInfo atmega_mcu[] =3D {<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .uc_name =3D TYPE_ATMEGA168,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cpu_type =3D AVR_CPU_TYPE_NAME(&quot;avr5&quo=
t;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flash_size =3D 16 * KiB,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .eeprom_size =3D 512,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .sram_size =3D 1 * KiB,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .io_size =3D 256,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .uart_count =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .gpio_count =3D 23,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .adc_count =3D 6,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .irq =3D irq168_328,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .dev =3D dev168_328,<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .uc_name =3D TYPE_ATMEGA328,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cpu_type =3D AVR_CPU_TYPE_NAME(&quot;avr5&quo=
t;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flash_size =3D 32 * KiB,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .eeprom_size =3D 1 * KiB,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .sram_size =3D 2 * KiB,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .io_size =3D 256,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .uart_count =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .timer_count =3D 3,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .gpio_count =3D 23,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .adc_count =3D 6,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .irq =3D irq168_328,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .dev =3D dev168_328,<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .uc_name =3D TYPE_ATMEGA1280,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cpu_type =3D AVR_CPU_TYPE_NAME(&quot;avr6&quo=
t;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flash_size =3D 128 * KiB,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .eeprom_size =3D 4 * KiB,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .sram_size =3D 8 * KiB,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .io_size =3D 512,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .uart_count =3D 4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .timer_count =3D 6,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .gpio_count =3D 86,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .adc_count =3D 16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .irq =3D irq1280_2560,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .dev =3D dev1280_2560,<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .uc_name =3D TYPE_ATMEGA2560,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cpu_type =3D AVR_CPU_TYPE_NAME(&quot;avr6&quo=
t;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flash_size =3D 256 * KiB,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .eeprom_size =3D 4 * KiB,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .sram_size =3D 8 * KiB,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .io_size =3D 512,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .uart_count =3D 4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .timer_count =3D 6,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .gpio_count =3D 54,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .adc_count =3D 16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .irq =3D irq1280_2560,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .dev =3D dev1280_2560,<br>
+=C2=A0 =C2=A0 },<br>
+};<br>
+<br>
+static void connect_nonnull_irq(<wbr>SysBusDevice *sbd, DeviceState *dev,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int n, int irq)<br>
+{<br>
+=C2=A0 =C2=A0 if (irq) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(sbd, n, qdev_get_gpio_in(de=
v, irq));<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void connect_pr_irq(AtmegaState *s, const AtmegaInfo *info,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0DeviceState *dev, int index)<br>
+{<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_<wbr>DEVICE(&amp;s-&gt;pwr[info-&=
gt;dev[<wbr>index].prr_addr &amp; 1]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0info-&gt;dev[index].prr_bit,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0qdev_get_gpio_in(dev, 0));<br>
+}<br>
+<br>
+static void atmega_realize(DeviceState *dev, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 AtmegaState *s =3D ATMEGA(dev);<br>
+=C2=A0 =C2=A0 AtmegaClass *bc =3D ATMEGA_GET_CLASS(dev);<br>
+=C2=A0 =C2=A0 const AtmegaInfo *info =3D bc-&gt;info;<br>
+=C2=A0 =C2=A0 DeviceState *cpudev;<br>
+=C2=A0 =C2=A0 SysBusDevice *sbd;<br>
+=C2=A0 =C2=A0 Error *err =3D NULL;<br>
+=C2=A0 =C2=A0 char *devname;<br>
+=C2=A0 =C2=A0 size_t i;<br>
+<br>
+=C2=A0 =C2=A0 if (!s-&gt;xtal_freq_hz) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;\&quot;xtal-frequency-h=
z\&quot; property must be provided.&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* CPU */<br>
+=C2=A0 =C2=A0 object_initialize_child(<wbr>OBJECT(dev), &quot;cpu&quot;, &=
amp;s-&gt;cpu, sizeof(s-&gt;cpu),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;cpu_type, &amp;err, NULL);<br>
+=C2=A0 =C2=A0 if (err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 object_property_set_bool(<wbr>OBJECT(&amp;s-&gt;cpu), true, =
&quot;realized&quot;, &amp;error_abort);<br>
+=C2=A0 =C2=A0 cpudev =3D DEVICE(&amp;s-&gt;cpu);<br>
+<br>
+=C2=A0 =C2=A0 /* SRAM */<br>
+=C2=A0 =C2=A0 memory_region_allocate_system_<wbr>memory(&amp;s-&gt;sram, O=
BJECT(dev),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&q=
uot;sram&quot;, info-&gt;sram_size);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(<wbr>get_system_memory(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x200, &amp;s-&gt;sram=
);<br>
+<br>
+=C2=A0 =C2=A0 /* Flash */<br>
+=C2=A0 =C2=A0 memory_region_init_rom(&amp;s-&gt;<wbr>flash, OBJECT(dev),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;flash&quot;, info-&gt;flash_size, &amp;error_=
fatal);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(<wbr>get_system_memory(), OFFSET=
_CODE, &amp;s-&gt;flash);<br>
+<br>
+=C2=A0 =C2=A0 /* I/O */<br>
+=C2=A0 =C2=A0 s-&gt;io =3D qdev_create(NULL, TYPE_UNIMPLEMENTED_DEVICE);<b=
r>
+=C2=A0 =C2=A0 qdev_prop_set_string(s-&gt;io, &quot;name&quot;, &quot;I/O&q=
uot;);<br>
+=C2=A0 =C2=A0 qdev_prop_set_uint64(s-&gt;io, &quot;size&quot;, info-&gt;io=
_size);<br>
+=C2=A0 =C2=A0 qdev_init_nofail(s-&gt;io);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map_overlap(SYS_<wbr>BUS_DEVICE(s-&gt;io), 0, OF=
FSET_DATA, -1234);<br>
+<br>
+=C2=A0 =C2=A0 /* Power */<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(s-&gt;pwr); i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 devname =3D g_strdup_printf(&quot;pwr%zu&quot;=
, i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_initialize_child(<wbr>OBJECT(dev), devn=
ame,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;pwr[i], sizeof(s-&gt;pwr[=
i]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_AVR_MASK, &amp;error_abort, NUL=
L);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(<wbr>OBJECT(&amp;s-&g=
t;pwr[i]), true, &quot;realized&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_abort);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_<wbr>DEVICE(&amp;s-&gt=
;pwr[i]), 0, OFFSET_DATA + 0x64 + i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(devname);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* USART */<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; info-&gt;uart_count; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 devname =3D g_strdup_printf(&quot;usart%zu&quo=
t;, i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_initialize_child(<wbr>OBJECT(dev), devn=
ame,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;usart[i], sizeof(s-&gt;us=
art[i]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_AVR_USART, &amp;error_abort, NU=
LL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_chr(DEVICE(&amp;s-&gt;<wbr>usart=
[i]), &quot;chardev&quot;, serial_hd(i));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(<wbr>OBJECT(&amp;s-&g=
t;usart[i]), true, &quot;realized&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_abort);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sbd =3D SYS_BUS_DEVICE(&amp;s-&gt;usart[i]);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(sbd, 0, OFFSET_DATA + info-&gt=
;dev[USART_ADDR(i)].addr)<wbr>;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_nonnull_irq(sbd, cpudev, 0, info-&gt;i=
rq[USART_RXC_IRQ(i)]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_nonnull_irq(sbd, cpudev, 1, info-&gt;i=
rq[USART_DRE_IRQ(i)]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_nonnull_irq(sbd, cpudev, 2, info-&gt;i=
rq[USART_TXC_IRQ(i)]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_pr_irq(s, info, DEVICE(&amp;s-&gt;usar=
t[i]), 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(devname);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Timer */<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; info-&gt;timer_count; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int idx =3D TIMER_ADDR(i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!info-&gt;dev[idx].is_timer16) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 create_unimplemented_device(&quo=
t;<wbr>avr-timer8&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_D=
ATA + info-&gt;dev[idx].addr, 7);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 create_unimplemented_device(&quo=
t;<wbr>avr-timer8-intmask&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_D=
ATA<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + info-&=
gt;dev[idx].intmask_addr, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 create_unimplemented_device(&quo=
t;<wbr>avr-timer8-intflag&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_D=
ATA<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + info-&=
gt;dev[idx].intflag_addr, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 devname =3D g_strdup_printf(&quot;timer%zu&quo=
t;, i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_initialize_child(<wbr>OBJECT(dev), devn=
ame,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;timer[i], sizeof(s-&gt;ti=
mer[i]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_AVR_TIMER16, &amp;error_abort, =
NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_uint(<wbr>OBJECT(&amp;s-&g=
t;timer[i]), s-&gt;xtal_freq_hz,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;cpu-frequency-hz&quot;, =
&amp;error_abort);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(<wbr>OBJECT(&amp;s-&g=
t;timer[i]), true, &quot;realized&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_abort);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sbd =3D SYS_BUS_DEVICE(&amp;s-&gt;timer[i]);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(sbd, 0, OFFSET_DATA + info-&gt=
;dev[idx].addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(sbd, 1, OFFSET_DATA + info-&gt=
;dev[idx].intmask_addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(sbd, 2, OFFSET_DATA + info-&gt=
;dev[idx].intflag_addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_nonnull_irq(sbd, cpudev, 0, info-&gt;i=
rq[TIMER_CAPT_IRQ(i)]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_nonnull_irq(sbd, cpudev, 1, info-&gt;i=
rq[TIMER_COMPA_IRQ(i)])<wbr>;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_nonnull_irq(sbd, cpudev, 2, info-&gt;i=
rq[TIMER_COMPB_IRQ(i)])<wbr>;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_nonnull_irq(sbd, cpudev, 3, info-&gt;i=
rq[TIMER_COMPC_IRQ(i)])<wbr>;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_nonnull_irq(sbd, cpudev, 4, info-&gt;i=
rq[TIMER_OVF_IRQ(i)]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_pr_irq(s, info, DEVICE(&amp;s-&gt;time=
r[i]), 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(devname);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static Property atmega_props[] =3D {<br>
+=C2=A0 =C2=A0 DEFINE_PROP_UINT64(&quot;xtal-<wbr>frequency-hz&quot;, Atmeg=
aState,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0xtal_freq_hz, 0),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST()<br>
+};<br>
+<br>
+static void atmega_class_init(ObjectClass *oc, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(oc);<br>
+=C2=A0 =C2=A0 AtmegaClass *bc =3D ATMEGA_CLASS(oc);<br>
+<br>
+=C2=A0 =C2=A0 bc-&gt;info =3D data;<br>
+=C2=A0 =C2=A0 dc-&gt;realize =3D atmega_realize;<br>
+=C2=A0 =C2=A0 dc-&gt;props =3D atmega_props;<br>
+=C2=A0 =C2=A0 /* Reason: Mapped at fixed location on the system bus */<br>
+=C2=A0 =C2=A0 dc-&gt;user_creatable =3D false;<br>
+}<br>
+<br>
+static const TypeInfo atmega_type_info =3D {<br>
+=C2=A0 =C2=A0 .name =3D TYPE_ATMEGA,<br>
+=C2=A0 =C2=A0 .parent =3D TYPE_SYS_BUS_DEVICE,<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(AtmegaState),<br>
+=C2=A0 =C2=A0 .class_size =3D sizeof(AtmegaClass),<br>
+=C2=A0 =C2=A0 .abstract =3D true,<br>
+};<br>
+<br>
+static void atmega_register_types(void)<br>
+{<br>
+=C2=A0 =C2=A0 size_t i;<br>
+<br>
+=C2=A0 =C2=A0 type_register_static(&amp;atmega_<wbr>type_info);<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(atmega_mcu); i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(atmega_mcu[i].io_size &lt;=3D 0x200);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(atmega_mcu[i].uart_<wbr>count &lt;=3D U=
SART_MAX);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(atmega_mcu[i].timer_<wbr>count &lt;=3D =
TIMER_MAX);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TypeInfo ti =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D atmega_mcu[i].uc_name,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D TYPE_ATMEGA,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init =3D atmega_class_ini=
t,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_data =3D (void *) &amp;at=
mega_mcu[i],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 type_register(&amp;ti);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+type_init(atmega_register_<wbr>types)<br>
diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs<br>
index 626b7064b3..4b6b911820 100644<br>
--- a/hw/avr/Makefile.objs<br>
+++ b/hw/avr/Makefile.objs<br>
@@ -1 +1,2 @@<br>
=C2=A0obj-y +=3D sample.o<br>
+obj-y +=3D atmega.o<br>
-- <br>
2.21.0<br>
<br>
</blockquote>

--000000000000b98cf2059864bc4a--

