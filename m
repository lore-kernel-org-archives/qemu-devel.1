Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3535C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3FA2068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbLQD10/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3FA2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic6QC-0004Y3-7d
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 06:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ic6NO-0003Fu-W3
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:29:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ic6NK-0000dA-Vb
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:29:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27474
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ic6NK-0000MG-Ly
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575372562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nr38vYAG+tolA2EjSFeuIbVgHA05sVGmPRGyH1waFIc=;
 b=YbLQD10/L15oB9xinFqXXpGoj/55jwz0dIwDHtQMTObCPwyLtDIF9t/w2rqTbAtEtr7mRD
 yqLKjnVs70NYrMip4AGrFNNysSxfv0cuLxoQcwHguqxjA/6kfFwDlIjyeB+3NUUHvE2kxM
 ds8otNpbFPbdgkiu4nVwIWP662RaeMg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416--y_WXqAINyG7MBnCkCmj6w-1; Tue, 03 Dec 2019 06:29:21 -0500
Received: by mail-wm1-f70.google.com with SMTP id p5so862686wmc.4
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 03:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kFKbM1SpH7lTNshlpLg/nTiFZA8ndczSoUpbBH5HLtA=;
 b=GkYsJY3R6udEu9BQMTEgz3VOKVbC9+DEeW1b8V/piW0PFXTeqFK9dGRpjTet59rQJk
 tm61GQT86mmlY/sUPhGNgQO3dq0S9BB/zc6jtYEvwyU+lZKYpMtOTE+ecXLjSBaQqFKz
 htb1god2HBKQLvJFKlUM2YqOquwFVV/wRwtX5G12zPdcfz76FWdzRsUbbd4FoIk9X+cT
 RznFWioodZTz6/GpnzcxZ8XTyvPfvFWaPl+qMwyxNuPOpuSY7mgC6OaS0bkVgcgEvSfF
 L/sJ7TKjaSs3doqBOvgtAb4t2HHp4vs7t1uDtRqpDcad0+vROqTEcCrh68Xy3nEneVkB
 +Gig==
X-Gm-Message-State: APjAAAXe/lrvGn2NTGpwoXtWHpnPZe0uYZ6oBYglrWoe0CTY3OTj/xxk
 q36sdiE1ubZ+p4dOokia5ry2a6w61KrTUYnyrnoc3SfbAt0zkFWP08rEW9zZBm5PKu75Qi096UF
 y5kVh1J+BD/Sn+JQ=
X-Received: by 2002:adf:93c6:: with SMTP id 64mr4397530wrp.212.1575372560103; 
 Tue, 03 Dec 2019 03:29:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqznTFOLypazxs0rIdbHuquMXv8RYw1RGUbqT2MwAXnlNchBzYbsRPt/fx4N9voQE7Fbj+J4Kg==
X-Received: by 2002:adf:93c6:: with SMTP id 64mr4397491wrp.212.1575372559741; 
 Tue, 03 Dec 2019 03:29:19 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id k19sm2573445wmi.42.2019.12.03.03.29.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 03:29:19 -0800 (PST)
Subject: Re: [PATCH v37 12/17] target/avr: Add example board configuration
To: Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <20191127175257.23480-13-mrolnik@gmail.com>
 <CAL1e-=iZ1641hbhhKzSOd+v82S+EN53kGtQ8GC1rfBaxH1Pzvg@mail.gmail.com>
 <CAK4993jpkD8WBzdjjL=kteGw0Gm=YYRuFm9c21s34Dn7QUcX=g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <76db90b0-244b-a322-d6e1-dfc2476faacc@redhat.com>
Date: Tue, 3 Dec 2019 12:29:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAK4993jpkD8WBzdjjL=kteGw0Gm=YYRuFm9c21s34Dn7QUcX=g@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: -y_WXqAINyG7MBnCkCmj6w-1
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
Cc: "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/30/19 5:57 PM, Michael Rolnik wrote:
> Hi Aleksandar.
>=20
> I guess no testing would be possible.
>=20
> My previous series of patches (about 2 years ago, before Sarah joined)=20
> did not contain any peripherals, there were only the CPU and the sample=
=20
> board, I used it to test instructions.
> Somebody complained that there are no peripherals=C2=A0and that was where=
 I=20
> stopped to care as I did (and still don't) want to model devices.

This is why I introduced Joaquin to your series, as he expressed=20
interest in modeling the AVR devices :)

If he ever step in, you could be listed as maintainer of the CPU/TCG=20
section, and he could take the HW section. We'll see...

> I believed that others would join and add devices. then two years passed=
=20
> by, Sarah implemented the timer and the UART devices.
> And here we are.
>=20
> Regards,
> Michael Rolnik
>=20
> On Sat, Nov 30, 2019 at 12:49 PM Aleksandar Markovic=20
> <aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>> wrote:
>=20
>=20
>=20
>     On Wednesday, November 27, 2019, Michael Rolnik <mrolnik@gmail.com
>     <mailto:mrolnik@gmail.com>> wrote:
>=20
>         A simple board setup that configures an AVR CPU to run a given
>         firmware image.
>         This is all that's useful to implement without peripheral
>         emulation as AVR CPUs include a lot of on-board peripherals.
>=20
>         NOTE: this is not a real board !!!!
>         NOTE: it's used for CPU testing!!!!
>=20
>         Signed-off-by: Michael Rolnik <mrolnik@gmail.com
>         <mailto:mrolnik@gmail.com>>
>         Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com
>         <mailto:amarkovic@wavecomp.com>>
>         Nacked-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>         <mailto:philmd@redhat.com>>
>         ---
>          =C2=A0hw/avr/sample.c=C2=A0 =C2=A0 =C2=A0 | 282
>         +++++++++++++++++++++++++++++++++++++++++++
>          =C2=A0hw/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A01 +
>          =C2=A0hw/avr/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +
>          =C2=A0hw/avr/Makefile.objs |=C2=A0 =C2=A01 +
>          =C2=A04 files changed, 290 insertions(+)
>          =C2=A0create mode 100644 hw/avr/sample.c
>          =C2=A0create mode 100644 hw/avr/Kconfig
>          =C2=A0create mode 100644 hw/avr/Makefile.objs
>=20
>=20
>     Michael, hi.
>=20
>     I just need a clarification here:
>=20
>     - What will happen if this patch is removed? Would boot and Avocado
>     tests work? What else in general wouldn't work or be available? What
>     was, in fact, the ultimate motivation for you to insert this patch?

Avocado tests won't work (the FreeRTOS tests require the timer/uart).

The instruction-tests should work using 'qemu-avr-softmmu -M none -m 9'=20
with optional '-cpu $CPU'.

By using '-m 9' the 'none' machine maps 9MB of RAM at base address=20
0x0000.0000, until 0x008f.ffff. So the SRAM area from the Mega2560 MCU,=20
which is normally mapped at 0x0080.0200, is accessible by the tests.

>     Thanks,
>     Aleksandar
>=20
>         diff --git a/hw/avr/sample.c b/hw/avr/sample.c
>         new file mode 100644
>         index 0000000000..2295ec1b79
>         --- /dev/null
>         +++ b/hw/avr/sample.c
>         @@ -0,0 +1,282 @@
>         +/*
>         + * QEMU AVR CPU
>         + *
>         + * Copyright (c) 2019 Michael Rolnik
>         + *
>         + * This library is free software; you can redistribute it and/or
>         + * modify it under the terms of the GNU Lesser General Public
>         + * License as published by the Free Software Foundation; either
>         + * version 2.1 of the License, or (at your option) any later
>         version.
>         + *
>         + * This library is distributed in the hope that it will be usefu=
l,
>         + * but WITHOUT ANY WARRANTY; without even the implied warranty o=
f
>         + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 Se=
e
>         the GNU
>         + * Lesser General Public License for more details.
>         + *
>         + * You should have received a copy of the GNU Lesser General Pub=
lic
>         + * License along with this library; if not, see
>         + * <http://www.gnu.org/licenses/lgpl-2.1.html>
>         + */
>         +
>         +/*
>         + *=C2=A0 NOTE:
>         + *=C2=A0 =C2=A0 =C2=A0 This is not a real AVR board, this is an =
example!
>         + *=C2=A0 =C2=A0 =C2=A0 The CPU is an approximation of an ATmega2=
560, but is
>         missing various
>         + *=C2=A0 =C2=A0 =C2=A0 built-in peripherals.
>         + *
>         + *=C2=A0 =C2=A0 =C2=A0 This example board loads provided binary =
file into
>         flash memory and
>         + *=C2=A0 =C2=A0 =C2=A0 executes it from 0x00000000 address in th=
e code memory
>         space.
>         + *
>         + *=C2=A0 =C2=A0 =C2=A0 Currently used for AVR CPU validation
>         + *
>         + */
>         +
>         +#include "qemu/osdep.h"
>         +#include "qapi/error.h"
>         +#include "qemu-common.h"
>         +#include "cpu.h"
>         +#include "hw/hw.h"
>         +#include "sysemu/sysemu.h"
>         +#include "sysemu/qtest.h"
>         +#include "ui/console.h"
>         +#include "hw/boards.h"
>         +#include "hw/loader.h"
>         +#include "qemu/error-report.h"
>         +#include "exec/address-spaces.h"
>         +#include "include/hw/sysbus.h"
>         +#include "include/hw/char/avr_usart.h"
>         +#include "include/hw/timer/avr_timer16.h"
>         +#include "include/hw/misc/avr_mask.h"
>         +#include "elf.h"
>         +#include "hw/misc/unimp.h"
>         +
>         +#define SIZE_FLASH 0x00040000
>         +#define SIZE_SRAM 0x00002000
>         +/*
>         + * Size of additional "external" memory, as if the AVR were
>         configured to use
>         + * an external RAM chip.
>         + * Note that the configuration registers that normally enable
>         this feature are
>         + * unimplemented.
>         + */
>         +#define SIZE_EXMEM 0x00000000
>         +
>         +/* Offsets of peripherals in emulated memory space (i.e. not
>         host addresses)=C2=A0 */
>         +#define PRR0_BASE 0x64
>         +#define PRR1_BASE 0x65
>         +#define USART_BASE 0xc0
>         +#define TIMER1_BASE 0x80
>         +#define TIMER1_IMSK_BASE 0x6f
>         +#define TIMER1_IFR_BASE 0x36
>         +
>         +/* Interrupt numbers used by peripherals */
>         +#define USART_RXC_IRQ 24
>         +#define USART_DRE_IRQ 25
>         +#define USART_TXC_IRQ 26
>         +
>         +#define TIMER1_CAPT_IRQ 15
>         +#define TIMER1_COMPA_IRQ 16
>         +#define TIMER1_COMPB_IRQ 17
>         +#define TIMER1_COMPC_IRQ 18
>         +#define TIMER1_OVF_IRQ 19
>         +
>         +/*=C2=A0 Power reduction=C2=A0 =C2=A0 =C2=A0*/
>         +#define PRR1_BIT_PRTIM5=C2=A0 =C2=A0 =C2=A00x05=C2=A0 =C2=A0 /*=
=C2=A0 Timer/Counter5=C2=A0 */
>         +#define PRR1_BIT_PRTIM4=C2=A0 =C2=A0 =C2=A00x04=C2=A0 =C2=A0 /*=
=C2=A0 Timer/Counter4=C2=A0 */
>         +#define PRR1_BIT_PRTIM3=C2=A0 =C2=A0 =C2=A00x03=C2=A0 =C2=A0 /*=
=C2=A0 Timer/Counter3=C2=A0 */
>         +#define PRR1_BIT_PRUSART3=C2=A0 =C2=A00x02=C2=A0 =C2=A0 /*=C2=A0=
 USART3=C2=A0 */
>         +#define PRR1_BIT_PRUSART2=C2=A0 =C2=A00x01=C2=A0 =C2=A0 /*=C2=A0=
 USART2=C2=A0 */
>         +#define PRR1_BIT_PRUSART1=C2=A0 =C2=A00x00=C2=A0 =C2=A0 /*=C2=A0=
 USART1=C2=A0 */
>         +
>         +#define PRR0_BIT_PRTWI=C2=A0 =C2=A0 =C2=A0 0x06=C2=A0 =C2=A0 /*=
=C2=A0 TWI */
>         +#define PRR0_BIT_PRTIM2=C2=A0 =C2=A0 =C2=A00x05=C2=A0 =C2=A0 /*=
=C2=A0 Timer/Counter2=C2=A0 */
>         +#define PRR0_BIT_PRTIM0=C2=A0 =C2=A0 =C2=A00x04=C2=A0 =C2=A0 /*=
=C2=A0 Timer/Counter0=C2=A0 */
>         +#define PRR0_BIT_PRTIM1=C2=A0 =C2=A0 =C2=A00x03=C2=A0 =C2=A0 /*=
=C2=A0 Timer/Counter1=C2=A0 */
>         +#define PRR0_BIT_PRSPI=C2=A0 =C2=A0 =C2=A0 0x02=C2=A0 =C2=A0 /*=
=C2=A0 Serial Peripheral
>         Interface */
>         +#define PRR0_BIT_PRUSART0=C2=A0 =C2=A00x01=C2=A0 =C2=A0 /*=C2=A0=
 USART0=C2=A0 */
>         +#define PRR0_BIT_PRADC=C2=A0 =C2=A0 =C2=A0 0x00=C2=A0 =C2=A0 /*=
=C2=A0 ADC */
>         +
>         +typedef struct {
>         +=C2=A0 =C2=A0 MachineClass parent;
>         +} SampleMachineClass;
>         +
>         +typedef struct {
>         +=C2=A0 =C2=A0 MachineState parent;
>         +=C2=A0 =C2=A0 MemoryRegion *ram;
>         +=C2=A0 =C2=A0 MemoryRegion *flash;
>         +=C2=A0 =C2=A0 AVRUsartState *usart0;
>         +=C2=A0 =C2=A0 AVRTimer16State *timer1;
>         +=C2=A0 =C2=A0 AVRMaskState *prr[2];
>         +} SampleMachineState;
>         +
>         +#define TYPE_SAMPLE_MACHINE MACHINE_TYPE_NAME("sample")
>         +
>         +#define SAMPLE_MACHINE(obj) \
>         +=C2=A0 =C2=A0 OBJECT_CHECK(SampleMachineState, obj, TYPE_SAMPLE_=
MACHINE)
>         +#define SAMPLE_MACHINE_GET_CLASS(obj) \
>         +=C2=A0 =C2=A0 OBJECT_GET_CLASS(SampleMachineClass, obj, TYPE_SAM=
PLE_MACHINE)
>         +#define SAMPLE_MACHINE_CLASS(klass) \
>         +=C2=A0 =C2=A0 OBJECT_CLASS_CHECK(SampleMachineClass, klass,
>         TYPE_SAMPLE_MACHINE)
>         +
>         +static void sample_init(MachineState *machine)
>         +{
>         +=C2=A0 =C2=A0 SampleMachineState *sms =3D SAMPLE_MACHINE(machine=
);
>         +=C2=A0 =C2=A0 MemoryRegion *system_memory =3D get_system_memory(=
);
>         +=C2=A0 =C2=A0 AVRCPU *cpu;
>         +=C2=A0 =C2=A0 const char *firmware =3D NULL;
>         +=C2=A0 =C2=A0 const char *filename;
>         +=C2=A0 =C2=A0 int bytes_loaded;
>         +=C2=A0 =C2=A0 SysBusDevice *busdev;
>         +=C2=A0 =C2=A0 DeviceState *cpudev;
>         +
>         +=C2=A0 =C2=A0 system_memory =3D get_system_memory();
>         +=C2=A0 =C2=A0 sms->ram =3D g_new(MemoryRegion, 1);
>         +=C2=A0 =C2=A0 sms->flash =3D g_new(MemoryRegion, 1);
>         +
>         +=C2=A0 =C2=A0 cpu =3D AVR_CPU(cpu_create(machine->cpu_type));
>         +=C2=A0 =C2=A0 cpudev =3D DEVICE(cpu);
>         +
>         +
>         +=C2=A0 =C2=A0 memory_region_init_rom(sms->flash, NULL, "avr.flas=
h",
>         SIZE_FLASH,
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &error_fatal);
>         +=C2=A0 =C2=A0 memory_region_add_subregion(system_memory, OFFSET_=
CODE,
>         sms->flash);
>         +
>         +=C2=A0 =C2=A0 /* following are atmel2560 device */
>         +=C2=A0 =C2=A0 create_unimplemented_device("usart 3", OFFSET_DATA=
 +
>         0x0130, 0x0007);
>         +=C2=A0 =C2=A0 create_unimplemented_device("timer-counter-16bit 5=
",
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0120, =
0x000e);
>         +=C2=A0 =C2=A0 create_unimplemented_device("gpio L", OFFSET_DATA =
+ 0x0109,
>         0x0003);
>         +=C2=A0 =C2=A0 create_unimplemented_device("gpio K", OFFSET_DATA =
+ 0x0106,
>         0x0003);
>         +=C2=A0 =C2=A0 create_unimplemented_device("gpio J", OFFSET_DATA =
+ 0x0103,
>         0x0003);
>         +=C2=A0 =C2=A0 create_unimplemented_device("gpio H", OFFSET_DATA =
+ 0x0100,
>         0x0003);
>         +=C2=A0 =C2=A0 create_unimplemented_device("usart 2", OFFSET_DATA=
 +
>         0x00d0, 0x0007);
>         +=C2=A0 =C2=A0 create_unimplemented_device("usart 1", OFFSET_DATA=
 +
>         0x00c8, 0x0007);
>         +=C2=A0 =C2=A0 create_unimplemented_device("usart 0", OFFSET_DATA=
 +
>         0x00c0, 0x0007);
>         +=C2=A0 =C2=A0 create_unimplemented_device("twi", OFFSET_DATA + 0=
x00b8,
>         0x0006);
>         +=C2=A0 =C2=A0 create_unimplemented_device("timer-counter-async-8=
bit 2",
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x00b0, =
0x0007);
>         +=C2=A0 =C2=A0 create_unimplemented_device("timer-counter-16bit 4=
",
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x00a0, =
0x000e);
>         +=C2=A0 =C2=A0 create_unimplemented_device("timer-counter-16bit 3=
",
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0090, =
0x000e);
>         +=C2=A0 =C2=A0 create_unimplemented_device("timer-counter-16bit 1=
",
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0080, =
0x000e);
>         +=C2=A0 =C2=A0 create_unimplemented_device("ac / adc",
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0078, =
0x0008);
>         +=C2=A0 =C2=A0 create_unimplemented_device("ext-mem-iface",
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0074, =
0x0002);
>         +=C2=A0 =C2=A0 create_unimplemented_device("int-controller",
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0068, =
0x000c);
>         +=C2=A0 =C2=A0 create_unimplemented_device("sys",
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0060, =
0x0007);
>         +=C2=A0 =C2=A0 create_unimplemented_device("spi",
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x004c, =
0x0003);
>         +=C2=A0 =C2=A0 create_unimplemented_device("ext-mem-iface",
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x004a, =
0x0002);
>         +=C2=A0 =C2=A0 create_unimplemented_device("timer-counter-pwm-8bi=
t 0",
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0043, =
0x0006);
>         +=C2=A0 =C2=A0 create_unimplemented_device("ext-mem-iface",
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x003e, =
0x0005);
>         +=C2=A0 =C2=A0 create_unimplemented_device("int-controller",
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0035, =
0x0009);
>         +=C2=A0 =C2=A0 create_unimplemented_device("gpio G", OFFSET_DATA =
+ 0x0032,
>         0x0003);
>         +=C2=A0 =C2=A0 create_unimplemented_device("gpio F", OFFSET_DATA =
+ 0x002f,
>         0x0003);
>         +=C2=A0 =C2=A0 create_unimplemented_device("gpio E", OFFSET_DATA =
+ 0x002c,
>         0x0003);
>         +=C2=A0 =C2=A0 create_unimplemented_device("gpio D", OFFSET_DATA =
+ 0x0029,
>         0x0003);
>         +=C2=A0 =C2=A0 create_unimplemented_device("gpio C", OFFSET_DATA =
+ 0x0026,
>         0x0003);
>         +=C2=A0 =C2=A0 create_unimplemented_device("gpio B", OFFSET_DATA =
+ 0x0023,
>         0x0003);
>         +=C2=A0 =C2=A0 create_unimplemented_device("gpio A", OFFSET_DATA =
+ 0x0020,
>         0x0003);
>         +
>         +=C2=A0 =C2=A0 memory_region_allocate_system_memory(
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sms->ram, NULL, "avr.ram", SIZE_SRAM=
 + SIZE_EXMEM);
>         +=C2=A0 =C2=A0 memory_region_add_subregion(system_memory, OFFSET_=
DATA +
>         0x200, sms->ram);
>         +
>         +=C2=A0 =C2=A0 /* Power Reduction built-in peripheral */
>         +=C2=A0 =C2=A0 sms->prr[0] =3D AVR_MASK(sysbus_create_simple(TYPE=
_AVR_MASK,
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 OFFSET_DATA + PRR0_BASE, NULL));
>         +=C2=A0 =C2=A0 sms->prr[1] =3D AVR_MASK(sysbus_create_simple(TYPE=
_AVR_MASK,
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 OFFSET_DATA + PRR1_BASE, NULL));
>         +
>         +=C2=A0 =C2=A0 /* USART 0 built-in peripheral */
>         +=C2=A0 =C2=A0 sms->usart0 =3D AVR_USART(object_new(TYPE_AVR_USAR=
T));
>         +=C2=A0 =C2=A0 busdev =3D SYS_BUS_DEVICE(sms->usart0);
>         +=C2=A0 =C2=A0 qdev_prop_set_chr(DEVICE(sms->usart0), "chardev",
>         serial_hd(0));
>         +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(sms->usart0), true=
, "realized",
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &error_fatal);
>         +=C2=A0 =C2=A0 sysbus_mmio_map(busdev, 0, OFFSET_DATA + USART_BAS=
E);
>         +=C2=A0 =C2=A0 /*
>         +=C2=A0 =C2=A0 =C2=A0* These IRQ numbers don't match the datashee=
t because
>         we're counting from
>         +=C2=A0 =C2=A0 =C2=A0* zero and not including reset.
>         +=C2=A0 =C2=A0 =C2=A0*/
>         +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpu=
dev,
>         USART_RXC_IRQ));
>         +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpu=
dev,
>         USART_DRE_IRQ));
>         +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpu=
dev,
>         USART_TXC_IRQ));
>         +=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(sms->prr[1]),
>         PRR1_BIT_PRUSART1,
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVIC=
E(sms->usart0), 0));
>         +
>         +=C2=A0 =C2=A0 /* Timer 1 built-in periphal */
>         +=C2=A0 =C2=A0 sms->timer1 =3D AVR_TIMER16(object_new(TYPE_AVR_TI=
MER16));
>         +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(sms->timer1), true=
, "realized",
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &error_fatal);
>         +=C2=A0 =C2=A0 busdev =3D SYS_BUS_DEVICE(sms->timer1);
>         +=C2=A0 =C2=A0 sysbus_mmio_map(busdev, 0, OFFSET_DATA + TIMER1_BA=
SE);
>         +=C2=A0 =C2=A0 sysbus_mmio_map(busdev, 1, OFFSET_DATA + TIMER1_IM=
SK_BASE);
>         +=C2=A0 =C2=A0 sysbus_mmio_map(busdev, 2, OFFSET_DATA + TIMER1_IF=
R_BASE);
>         +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpu=
dev,
>         TIMER1_CAPT_IRQ));
>         +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpu=
dev,
>         TIMER1_COMPA_IRQ));
>         +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpu=
dev,
>         TIMER1_COMPB_IRQ));
>         +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 3, qdev_get_gpio_in(cpu=
dev,
>         TIMER1_COMPC_IRQ));
>         +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 4, qdev_get_gpio_in(cpu=
dev,
>         TIMER1_OVF_IRQ));
>         +=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(sms->prr[0]),
>         PRR0_BIT_PRTIM1,
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVIC=
E(sms->timer1), 0));
>         +
>         +=C2=A0 =C2=A0 /* Load firmware (contents of flash) trying to aut=
o-detect
>         format */
>         +=C2=A0 =C2=A0 firmware =3D machine->firmware;
>         +=C2=A0 =C2=A0 if (firmware !=3D NULL) {
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 filename =3D qemu_find_file(QEMU_FIL=
E_TYPE_BIOS, firmware);
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (filename =3D=3D NULL) {
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report("Unable t=
o find %s", firmware);
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>         +
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_loaded =3D load_elf(
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename, NULL, NULL, =
NULL, NULL, NULL, NULL, 0,
>         EM_NONE, 0, 0);
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bytes_loaded < 0) {
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_loaded =3D load_=
image_targphys(
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename=
, OFFSET_CODE, SIZE_FLASH);
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bytes_loaded < 0) {
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Unable =
to load firmware image %s as ELF or raw
>         binary",
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 firmware=
);
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);
>         +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>         +=C2=A0 =C2=A0 }
>         +}
>         +
>         +static void sample_class_init(ObjectClass *oc, void *data)
>         +{
>         +=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_CLASS(oc);
>         +
>         +=C2=A0 =C2=A0 mc->desc =3D "AVR sample/example board (ATmega2560=
)";
>         +=C2=A0 =C2=A0 mc->init =3D sample_init;
>         +=C2=A0 =C2=A0 mc->default_cpus =3D 1;
>         +=C2=A0 =C2=A0 mc->min_cpus =3D mc->default_cpus;
>         +=C2=A0 =C2=A0 mc->max_cpus =3D mc->default_cpus;
>         +=C2=A0 =C2=A0 mc->default_cpu_type =3D "avr6-avr-cpu"; /* ATmega=
2560. */
>         +=C2=A0 =C2=A0 mc->is_default =3D 1;
>         +}
>         +
>         +static const TypeInfo sample_info =3D {
>         +=C2=A0 =C2=A0 .name =3D TYPE_SAMPLE_MACHINE,
>         +=C2=A0 =C2=A0 .parent =3D TYPE_MACHINE,
>         +=C2=A0 =C2=A0 .instance_size =3D sizeof(SampleMachineState),
>         +=C2=A0 =C2=A0 .class_size =3D sizeof(SampleMachineClass),
>         +=C2=A0 =C2=A0 .class_init =3D sample_class_init,
>         +};
>         +
>         +static void sample_machine_init(void)
>         +{
>         +=C2=A0 =C2=A0 type_register_static(&sample_info);
>         +}
>         +
>         +type_init(sample_machine_init);
>         diff --git a/hw/Kconfig b/hw/Kconfig
>         index b9685b3944..07b8abb342 100644
>         --- a/hw/Kconfig
>         +++ b/hw/Kconfig
>         @@ -44,6 +44,7 @@ source watchdog/Kconfig
>          =C2=A0# arch Kconfig
>          =C2=A0source arm/Kconfig
>          =C2=A0source alpha/Kconfig
>         +source avr/Kconfig
>          =C2=A0source cris/Kconfig
>          =C2=A0source hppa/Kconfig
>          =C2=A0source i386/Kconfig
>         diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
>         new file mode 100644
>         index 0000000000..92aa1e6afb
>         --- /dev/null
>         +++ b/hw/avr/Kconfig
>         @@ -0,0 +1,6 @@
>         +config AVR_SAMPLE
>         +=C2=A0 =C2=A0 bool
>         +=C2=A0 =C2=A0 select AVR_TIMER16
>         +=C2=A0 =C2=A0 select AVR_USART
>         +=C2=A0 =C2=A0 select AVR_MASK
>         +=C2=A0 =C2=A0 select UNIMP
>         diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
>         new file mode 100644
>         index 0000000000..626b7064b3
>         --- /dev/null
>         +++ b/hw/avr/Makefile.objs
>         @@ -0,0 +1 @@
>         +obj-y +=3D sample.o
>         --=20
>         2.17.2 (Apple Git-113)
>=20
>=20
>=20
> --=20
> Best Regards,
> Michael Rolnik


