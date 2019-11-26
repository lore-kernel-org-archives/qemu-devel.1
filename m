Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD09C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 23:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54482071A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 23:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkNqJmYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54482071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZjsX-0004Va-VQ
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 18:04:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZjrV-0003xF-Jf
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 18:03:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZjrS-0008F8-LP
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 18:03:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57606
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZjrQ-0008Dl-DN
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 18:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574809387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5NWZLSTfNlAuvcYmt9kyUpolI74EkCIl3UyLVbO3iww=;
 b=XkNqJmYmzmYr4w0LaaVU2z6YXzot2U//16YUxatjHU4lvKF/fLbgttjchWpLAspY9NOA/5
 DKyHmDqyWFa0O0cifiWPtyIrzqiIv1uhR6HJtNGDlzZ+IWrWhxKfZuTXl0i63uc/pt9GMp
 UeH40kiQQ7AYx+WvVhFIF5Girzcxb5c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-bPeEYLe5Nt2vNkeE4TNn_Q-1; Tue, 26 Nov 2019 18:03:06 -0500
Received: by mail-wr1-f71.google.com with SMTP id e3so11201001wrs.17
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 15:03:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=op2/2C5B9m0HzleWDOmkttJedG9AZjNw1SjvQERfFk8=;
 b=qbtjPG3+8IA0J3KkiHjwUqQa59XhesXQY1ZFPqxkziet9q8n+r1fL6rpD7+xfkBefu
 kJbGNa92VZUAEM+/TVeoBAbILy0O2ZLIUWtkSDVBiJU/Hq9LTyGx5zvdjXdpVskAJY7D
 9GG7rCgNeLXwEFkwFEQ09ESghTPVIJt1rWEH9feAPWCowbCknlVNYAmgWx+zCh/kp7fW
 uS5nLwckxYOUrERJZXRUHVkC6XYMkym2L+z+e1hTjTUZSMgEdiMgjKPHD5VRn/XiDVg0
 io9siLyFkCkZbX6jroO5HLzWGPcfMQGl2y3zX+PCCDLKr2p3BDo+SxMCWV5hInxvizxB
 Rm0w==
X-Gm-Message-State: APjAAAU1FNcY59JwooNp034AheDRt6D5inIORLeQPraQ1w370ZOk9+9k
 X0xq77IGqEl/51UrgvckIqVTI03+8n27P6yx4M6mBD6deyy+KqZ3C0lN5uCMysINfpTrUpCRELn
 67msd+AZZFX1Ssj4=
X-Received: by 2002:adf:f7cb:: with SMTP id a11mr17475782wrq.129.1574809384764; 
 Tue, 26 Nov 2019 15:03:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqwO3UtsuwC5EPF2DofpGYGm2EUm35rfxqBFM+SKeNvfkF0gIlN6vwsQ1XWJoKOxDNOubfJGkQ==
X-Received: by 2002:adf:f7cb:: with SMTP id a11mr17475749wrq.129.1574809384396; 
 Tue, 26 Nov 2019 15:03:04 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id b15sm16274912wrx.77.2019.11.26.15.03.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2019 15:03:03 -0800 (PST)
Subject: Re: [PATCH v36 12/17] target/avr: Add example board configuration
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-13-mrolnik@gmail.com>
 <CAL1e-=gOwA8L-vtTrcNPzY0RkL-fSW_JT9E2eRv8QRmzFYaEjA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6f1d52da-1ad6-59de-598e-b641074061ec@redhat.com>
Date: Wed, 27 Nov 2019 00:03:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gOwA8L-vtTrcNPzY0RkL-fSW_JT9E2eRv8QRmzFYaEjA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: bPeEYLe5Nt2vNkeE4TNn_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 11/26/19 2:08 AM, Aleksandar Markovic wrote:
> On Sunday, November 24, 2019, Michael Rolnik <mrolnik@gmail.com=20
> <mailto:mrolnik@gmail.com>> wrote:
>=20
>     A simple board setup that configures an AVR CPU to run a given
>     firmware image.
>     This is all that's useful to implement without peripheral emulation
>     as AVR CPUs include a lot of on-board peripherals.
>=20
>     NOTE: this is not a real board !!!!
>     NOTE: it's used for CPU testing!!!!
>=20
>     Signed-off-by: Michael Rolnik <mrolnik@gmail.com
>     <mailto:mrolnik@gmail.com>>
>     ---
>=20
>=20
> Given the complexities of peripherals of AVR CPUs, in my opinion it=20
> would be overly demanding to the submitters to require a real machine=20
> emulation at this point of time. So:
>=20
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com=20
> <mailto:amarkovic@wavecomp.com>>
>=20
> Hopefully this will superceeded with a real board emulation in not so=20
> distsnt future.
>=20
> Philippe, do you have something to add?

Joaquin started to work on the Arduino Mini board, with a ATmega168.

I'd prefer to not introduce the 'sample' board and directly use his=20
work, because we have datasheet and schematics to match, and=20
Michael/Sarah can use it to test their CPU the same way.

So since this series is blocked by QEMU 5.0 still closed anyway,
Nacked-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

If we get no news from Joaquin when 5.0 opens, then feel free to remove=20
this Nack tag.

>     hw/avr/sample.c=C2=A0 =C2=A0 =C2=A0 | 282 +++++++++++++++++++++++++++=
++++++++++++++++
>      =C2=A0hw/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A01 +
>      =C2=A0hw/avr/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +
>      =C2=A0hw/avr/Makefile.objs |=C2=A0 =C2=A01 +
>      =C2=A04 files changed, 290 insertions(+)
>      =C2=A0create mode 100644 hw/avr/sample.c
>      =C2=A0create mode 100644 hw/avr/Kconfig
>      =C2=A0create mode 100644 hw/avr/Makefile.objs
>=20
>     diff --git a/hw/avr/sample.c b/hw/avr/sample.c
>     new file mode 100644
>     index 0000000000..2295ec1b79
>     --- /dev/null
>     +++ b/hw/avr/sample.c
>     @@ -0,0 +1,282 @@
>     +/*
>     + * QEMU AVR CPU
>     + *
>     + * Copyright (c) 2019 Michael Rolnik
>     + *
>     + * This library is free software; you can redistribute it and/or
>     + * modify it under the terms of the GNU Lesser General Public
>     + * License as published by the Free Software Foundation; either
>     + * version 2.1 of the License, or (at your option) any later version=
.
>     + *
>     + * This library is distributed in the hope that it will be useful,
>     + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>     + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See th=
e GNU
>     + * Lesser General Public License for more details.
>     + *
>     + * You should have received a copy of the GNU Lesser General Public
>     + * License along with this library; if not, see
>     + * <http://www.gnu.org/licenses/lgpl-2.1.html
>     <http://www.gnu.org/licenses/lgpl-2.1.html>>
>     + */
>     +
>     +/*
>     + *=C2=A0 NOTE:
>     + *=C2=A0 =C2=A0 =C2=A0 This is not a real AVR board, this is an exam=
ple!
>     + *=C2=A0 =C2=A0 =C2=A0 The CPU is an approximation of an ATmega2560,=
 but is
>     missing various
>     + *=C2=A0 =C2=A0 =C2=A0 built-in peripherals.
>     + *
>     + *=C2=A0 =C2=A0 =C2=A0 This example board loads provided binary file=
 into flash
>     memory and
>     + *=C2=A0 =C2=A0 =C2=A0 executes it from 0x00000000 address in the co=
de memory space.
>     + *
>     + *=C2=A0 =C2=A0 =C2=A0 Currently used for AVR CPU validation
>     + *
>     + */
>     +
>     +#include "qemu/osdep.h"
>     +#include "qapi/error.h"
>     +#include "qemu-common.h"
>     +#include "cpu.h"
>     +#include "hw/hw.h"
>     +#include "sysemu/sysemu.h"
>     +#include "sysemu/qtest.h"
>     +#include "ui/console.h"
>     +#include "hw/boards.h"
>     +#include "hw/loader.h"
>     +#include "qemu/error-report.h"
>     +#include "exec/address-spaces.h"
>     +#include "include/hw/sysbus.h"
>     +#include "include/hw/char/avr_usart.h"
>     +#include "include/hw/timer/avr_timer16.h"
>     +#include "include/hw/misc/avr_mask.h"
>     +#include "elf.h"
>     +#include "hw/misc/unimp.h"
>     +
>     +#define SIZE_FLASH 0x00040000
>     +#define SIZE_SRAM 0x00002000
>     +/*
>     + * Size of additional "external" memory, as if the AVR were
>     configured to use
>     + * an external RAM chip.
>     + * Note that the configuration registers that normally enable this
>     feature are
>     + * unimplemented.
>     + */
>     +#define SIZE_EXMEM 0x00000000
>     +
>     +/* Offsets of peripherals in emulated memory space (i.e. not host
>     addresses)=C2=A0 */
>     +#define PRR0_BASE 0x64
>     +#define PRR1_BASE 0x65
>     +#define USART_BASE 0xc0
>     +#define TIMER1_BASE 0x80
>     +#define TIMER1_IMSK_BASE 0x6f
>     +#define TIMER1_IFR_BASE 0x36
>     +
>     +/* Interrupt numbers used by peripherals */
>     +#define USART_RXC_IRQ 24
>     +#define USART_DRE_IRQ 25
>     +#define USART_TXC_IRQ 26
>     +
>     +#define TIMER1_CAPT_IRQ 15
>     +#define TIMER1_COMPA_IRQ 16
>     +#define TIMER1_COMPB_IRQ 17
>     +#define TIMER1_COMPC_IRQ 18
>     +#define TIMER1_OVF_IRQ 19
>     +
>     +/*=C2=A0 Power reduction=C2=A0 =C2=A0 =C2=A0*/
>     +#define PRR1_BIT_PRTIM5=C2=A0 =C2=A0 =C2=A00x05=C2=A0 =C2=A0 /*=C2=
=A0 Timer/Counter5=C2=A0 */
>     +#define PRR1_BIT_PRTIM4=C2=A0 =C2=A0 =C2=A00x04=C2=A0 =C2=A0 /*=C2=
=A0 Timer/Counter4=C2=A0 */
>     +#define PRR1_BIT_PRTIM3=C2=A0 =C2=A0 =C2=A00x03=C2=A0 =C2=A0 /*=C2=
=A0 Timer/Counter3=C2=A0 */
>     +#define PRR1_BIT_PRUSART3=C2=A0 =C2=A00x02=C2=A0 =C2=A0 /*=C2=A0 USA=
RT3=C2=A0 */
>     +#define PRR1_BIT_PRUSART2=C2=A0 =C2=A00x01=C2=A0 =C2=A0 /*=C2=A0 USA=
RT2=C2=A0 */
>     +#define PRR1_BIT_PRUSART1=C2=A0 =C2=A00x00=C2=A0 =C2=A0 /*=C2=A0 USA=
RT1=C2=A0 */
>     +
>     +#define PRR0_BIT_PRTWI=C2=A0 =C2=A0 =C2=A0 0x06=C2=A0 =C2=A0 /*=C2=
=A0 TWI */
>     +#define PRR0_BIT_PRTIM2=C2=A0 =C2=A0 =C2=A00x05=C2=A0 =C2=A0 /*=C2=
=A0 Timer/Counter2=C2=A0 */
>     +#define PRR0_BIT_PRTIM0=C2=A0 =C2=A0 =C2=A00x04=C2=A0 =C2=A0 /*=C2=
=A0 Timer/Counter0=C2=A0 */
>     +#define PRR0_BIT_PRTIM1=C2=A0 =C2=A0 =C2=A00x03=C2=A0 =C2=A0 /*=C2=
=A0 Timer/Counter1=C2=A0 */
>     +#define PRR0_BIT_PRSPI=C2=A0 =C2=A0 =C2=A0 0x02=C2=A0 =C2=A0 /*=C2=
=A0 Serial Peripheral Interface */
>     +#define PRR0_BIT_PRUSART0=C2=A0 =C2=A00x01=C2=A0 =C2=A0 /*=C2=A0 USA=
RT0=C2=A0 */
>     +#define PRR0_BIT_PRADC=C2=A0 =C2=A0 =C2=A0 0x00=C2=A0 =C2=A0 /*=C2=
=A0 ADC */
>     +
>     +typedef struct {
>     +=C2=A0 =C2=A0 MachineClass parent;
>     +} SampleMachineClass;
>     +
>     +typedef struct {
>     +=C2=A0 =C2=A0 MachineState parent;
>     +=C2=A0 =C2=A0 MemoryRegion *ram;
>     +=C2=A0 =C2=A0 MemoryRegion *flash;
>     +=C2=A0 =C2=A0 AVRUsartState *usart0;
>     +=C2=A0 =C2=A0 AVRTimer16State *timer1;
>     +=C2=A0 =C2=A0 AVRMaskState *prr[2];
>     +} SampleMachineState;
>     +
>     +#define TYPE_SAMPLE_MACHINE MACHINE_TYPE_NAME("sample")
>     +
>     +#define SAMPLE_MACHINE(obj) \
>     +=C2=A0 =C2=A0 OBJECT_CHECK(SampleMachineState, obj, TYPE_SAMPLE_MACH=
INE)
>     +#define SAMPLE_MACHINE_GET_CLASS(obj) \
>     +=C2=A0 =C2=A0 OBJECT_GET_CLASS(SampleMachineClass, obj, TYPE_SAMPLE_=
MACHINE)
>     +#define SAMPLE_MACHINE_CLASS(klass) \
>     +=C2=A0 =C2=A0 OBJECT_CLASS_CHECK(SampleMachineClass, klass, TYPE_SAM=
PLE_MACHINE)
>     +
>     +static void sample_init(MachineState *machine)
>     +{
>     +=C2=A0 =C2=A0 SampleMachineState *sms =3D SAMPLE_MACHINE(machine);
>     +=C2=A0 =C2=A0 MemoryRegion *system_memory =3D get_system_memory();
>     +=C2=A0 =C2=A0 AVRCPU *cpu;
>     +=C2=A0 =C2=A0 const char *firmware =3D NULL;
>     +=C2=A0 =C2=A0 const char *filename;
>     +=C2=A0 =C2=A0 int bytes_loaded;
>     +=C2=A0 =C2=A0 SysBusDevice *busdev;
>     +=C2=A0 =C2=A0 DeviceState *cpudev;
>     +
>     +=C2=A0 =C2=A0 system_memory =3D get_system_memory();
>     +=C2=A0 =C2=A0 sms->ram =3D g_new(MemoryRegion, 1);
>     +=C2=A0 =C2=A0 sms->flash =3D g_new(MemoryRegion, 1);
>     +
>     +=C2=A0 =C2=A0 cpu =3D AVR_CPU(cpu_create(machine->cpu_type));
>     +=C2=A0 =C2=A0 cpudev =3D DEVICE(cpu);
>     +
>     +
>     +=C2=A0 =C2=A0 memory_region_init_rom(sms->flash, NULL, "avr.flash", =
SIZE_FLASH,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &error_fatal);
>     +=C2=A0 =C2=A0 memory_region_add_subregion(system_memory, OFFSET_CODE=
,
>     sms->flash);
>     +
>     +=C2=A0 =C2=A0 /* following are atmel2560 device */
>     +=C2=A0 =C2=A0 create_unimplemented_device("usart 3", OFFSET_DATA + 0=
x0130,
>     0x0007);
>     +=C2=A0 =C2=A0 create_unimplemented_device("timer-counter-16bit 5",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0120, 0x00=
0e);
>     +=C2=A0 =C2=A0 create_unimplemented_device("gpio L", OFFSET_DATA + 0x=
0109,
>     0x0003);
>     +=C2=A0 =C2=A0 create_unimplemented_device("gpio K", OFFSET_DATA + 0x=
0106,
>     0x0003);
>     +=C2=A0 =C2=A0 create_unimplemented_device("gpio J", OFFSET_DATA + 0x=
0103,
>     0x0003);
>     +=C2=A0 =C2=A0 create_unimplemented_device("gpio H", OFFSET_DATA + 0x=
0100,
>     0x0003);
>     +=C2=A0 =C2=A0 create_unimplemented_device("usart 2", OFFSET_DATA + 0=
x00d0,
>     0x0007);
>     +=C2=A0 =C2=A0 create_unimplemented_device("usart 1", OFFSET_DATA + 0=
x00c8,
>     0x0007);
>     +=C2=A0 =C2=A0 create_unimplemented_device("usart 0", OFFSET_DATA + 0=
x00c0,
>     0x0007);
>     +=C2=A0 =C2=A0 create_unimplemented_device("twi", OFFSET_DATA + 0x00b=
8, 0x0006);
>     +=C2=A0 =C2=A0 create_unimplemented_device("timer-counter-async-8bit =
2",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x00b0, 0x00=
07);
>     +=C2=A0 =C2=A0 create_unimplemented_device("timer-counter-16bit 4",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x00a0, 0x00=
0e);
>     +=C2=A0 =C2=A0 create_unimplemented_device("timer-counter-16bit 3",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0090, 0x00=
0e);
>     +=C2=A0 =C2=A0 create_unimplemented_device("timer-counter-16bit 1",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0080, 0x00=
0e);
>     +=C2=A0 =C2=A0 create_unimplemented_device("ac / adc",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0078, 0x00=
08);
>     +=C2=A0 =C2=A0 create_unimplemented_device("ext-mem-iface",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0074, 0x00=
02);
>     +=C2=A0 =C2=A0 create_unimplemented_device("int-controller",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0068, 0x00=
0c);
>     +=C2=A0 =C2=A0 create_unimplemented_device("sys",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0060, 0x00=
07);
>     +=C2=A0 =C2=A0 create_unimplemented_device("spi",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x004c, 0x00=
03);
>     +=C2=A0 =C2=A0 create_unimplemented_device("ext-mem-iface",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x004a, 0x00=
02);
>     +=C2=A0 =C2=A0 create_unimplemented_device("timer-counter-pwm-8bit 0"=
,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0043, 0x00=
06);
>     +=C2=A0 =C2=A0 create_unimplemented_device("ext-mem-iface",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x003e, 0x00=
05);
>     +=C2=A0 =C2=A0 create_unimplemented_device("int-controller",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0035, 0x00=
09);
>     +=C2=A0 =C2=A0 create_unimplemented_device("gpio G", OFFSET_DATA + 0x=
0032,
>     0x0003);
>     +=C2=A0 =C2=A0 create_unimplemented_device("gpio F", OFFSET_DATA + 0x=
002f,
>     0x0003);
>     +=C2=A0 =C2=A0 create_unimplemented_device("gpio E", OFFSET_DATA + 0x=
002c,
>     0x0003);
>     +=C2=A0 =C2=A0 create_unimplemented_device("gpio D", OFFSET_DATA + 0x=
0029,
>     0x0003);
>     +=C2=A0 =C2=A0 create_unimplemented_device("gpio C", OFFSET_DATA + 0x=
0026,
>     0x0003);
>     +=C2=A0 =C2=A0 create_unimplemented_device("gpio B", OFFSET_DATA + 0x=
0023,
>     0x0003);
>     +=C2=A0 =C2=A0 create_unimplemented_device("gpio A", OFFSET_DATA + 0x=
0020,
>     0x0003);
>     +
>     +=C2=A0 =C2=A0 memory_region_allocate_system_memory(
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sms->ram, NULL, "avr.ram", SIZE_SRAM + S=
IZE_EXMEM);
>     +=C2=A0 =C2=A0 memory_region_add_subregion(system_memory, OFFSET_DATA=
 + 0x200,
>     sms->ram);
>     +
>     +=C2=A0 =C2=A0 /* Power Reduction built-in peripheral */
>     +=C2=A0 =C2=A0 sms->prr[0] =3D AVR_MASK(sysbus_create_simple(TYPE_AVR=
_MASK,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 OFFSET_DATA + PRR0_BASE, NULL));
>     +=C2=A0 =C2=A0 sms->prr[1] =3D AVR_MASK(sysbus_create_simple(TYPE_AVR=
_MASK,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 OFFSET_DATA + PRR1_BASE, NULL));
>     +
>     +=C2=A0 =C2=A0 /* USART 0 built-in peripheral */
>     +=C2=A0 =C2=A0 sms->usart0 =3D AVR_USART(object_new(TYPE_AVR_USART));
>     +=C2=A0 =C2=A0 busdev =3D SYS_BUS_DEVICE(sms->usart0);
>     +=C2=A0 =C2=A0 qdev_prop_set_chr(DEVICE(sms->usart0), "chardev", seri=
al_hd(0));
>     +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(sms->usart0), true, "r=
ealized",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &error_fatal);
>     +=C2=A0 =C2=A0 sysbus_mmio_map(busdev, 0, OFFSET_DATA + USART_BASE);
>     +=C2=A0 =C2=A0 /*
>     +=C2=A0 =C2=A0 =C2=A0* These IRQ numbers don't match the datasheet be=
cause we're
>     counting from
>     +=C2=A0 =C2=A0 =C2=A0* zero and not including reset.
>     +=C2=A0 =C2=A0 =C2=A0*/
>     +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev,
>     USART_RXC_IRQ));
>     +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev,
>     USART_DRE_IRQ));
>     +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev,
>     USART_TXC_IRQ));
>     +=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(sms->prr[1]), PRR1_B=
IT_PRUSART1,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(sm=
s->usart0), 0));
>     +
>     +=C2=A0 =C2=A0 /* Timer 1 built-in periphal */
>     +=C2=A0 =C2=A0 sms->timer1 =3D AVR_TIMER16(object_new(TYPE_AVR_TIMER1=
6));
>     +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(sms->timer1), true, "r=
ealized",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &error_fatal);
>     +=C2=A0 =C2=A0 busdev =3D SYS_BUS_DEVICE(sms->timer1);
>     +=C2=A0 =C2=A0 sysbus_mmio_map(busdev, 0, OFFSET_DATA + TIMER1_BASE);
>     +=C2=A0 =C2=A0 sysbus_mmio_map(busdev, 1, OFFSET_DATA + TIMER1_IMSK_B=
ASE);
>     +=C2=A0 =C2=A0 sysbus_mmio_map(busdev, 2, OFFSET_DATA + TIMER1_IFR_BA=
SE);
>     +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev,
>     TIMER1_CAPT_IRQ));
>     +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev,
>     TIMER1_COMPA_IRQ));
>     +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev,
>     TIMER1_COMPB_IRQ));
>     +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 3, qdev_get_gpio_in(cpudev,
>     TIMER1_COMPC_IRQ));
>     +=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 4, qdev_get_gpio_in(cpudev,
>     TIMER1_OVF_IRQ));
>     +=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(sms->prr[0]), PRR0_B=
IT_PRTIM1,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(sm=
s->timer1), 0));
>     +
>     +=C2=A0 =C2=A0 /* Load firmware (contents of flash) trying to auto-de=
tect
>     format */
>     +=C2=A0 =C2=A0 firmware =3D machine->firmware;
>     +=C2=A0 =C2=A0 if (firmware !=3D NULL) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 filename =3D qemu_find_file(QEMU_FILE_TY=
PE_BIOS, firmware);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (filename =3D=3D NULL) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report("Unable to fi=
nd %s", firmware);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_loaded =3D load_elf(
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename, NULL, NULL, NULL=
, NULL, NULL, NULL, 0,
>     EM_NONE, 0, 0);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bytes_loaded < 0) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_loaded =3D load_imag=
e_targphys(
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename, OF=
FSET_CODE, SIZE_FLASH);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bytes_loaded < 0) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Unable to l=
oad firmware image %s as ELF or raw
>     binary",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 firmware);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 }
>     +}
>     +
>     +static void sample_class_init(ObjectClass *oc, void *data)
>     +{
>     +=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_CLASS(oc);
>     +
>     +=C2=A0 =C2=A0 mc->desc =3D "AVR sample/example board (ATmega2560)";
>     +=C2=A0 =C2=A0 mc->init =3D sample_init;
>     +=C2=A0 =C2=A0 mc->default_cpus =3D 1;
>     +=C2=A0 =C2=A0 mc->min_cpus =3D mc->default_cpus;
>     +=C2=A0 =C2=A0 mc->max_cpus =3D mc->default_cpus;
>     +=C2=A0 =C2=A0 mc->default_cpu_type =3D "avr6-avr-cpu"; /* ATmega2560=
. */
>     +=C2=A0 =C2=A0 mc->is_default =3D 1;
>     +}
>     +
>     +static const TypeInfo sample_info =3D {
>     +=C2=A0 =C2=A0 .name =3D TYPE_SAMPLE_MACHINE,
>     +=C2=A0 =C2=A0 .parent =3D TYPE_MACHINE,
>     +=C2=A0 =C2=A0 .instance_size =3D sizeof(SampleMachineState),
>     +=C2=A0 =C2=A0 .class_size =3D sizeof(SampleMachineClass),
>     +=C2=A0 =C2=A0 .class_init =3D sample_class_init,
>     +};
>     +
>     +static void sample_machine_init(void)
>     +{
>     +=C2=A0 =C2=A0 type_register_static(&sample_info);
>     +}
>     +
>     +type_init(sample_machine_init);
>     diff --git a/hw/Kconfig b/hw/Kconfig
>     index b9685b3944..07b8abb342 100644
>     --- a/hw/Kconfig
>     +++ b/hw/Kconfig
>     @@ -44,6 +44,7 @@ source watchdog/Kconfig
>      =C2=A0# arch Kconfig
>      =C2=A0source arm/Kconfig
>      =C2=A0source alpha/Kconfig
>     +source avr/Kconfig
>      =C2=A0source cris/Kconfig
>      =C2=A0source hppa/Kconfig
>      =C2=A0source i386/Kconfig
>     diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
>     new file mode 100644
>     index 0000000000..92aa1e6afb
>     --- /dev/null
>     +++ b/hw/avr/Kconfig
>     @@ -0,0 +1,6 @@
>     +config AVR_SAMPLE
>     +=C2=A0 =C2=A0 bool
>     +=C2=A0 =C2=A0 select AVR_TIMER16
>     +=C2=A0 =C2=A0 select AVR_USART
>     +=C2=A0 =C2=A0 select AVR_MASK
>     +=C2=A0 =C2=A0 select UNIMP
>     diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
>     new file mode 100644
>     index 0000000000..626b7064b3
>     --- /dev/null
>     +++ b/hw/avr/Makefile.objs
>     @@ -0,0 +1 @@
>     +obj-y +=3D sample.o
>     --=20
>     2.17.2 (Apple Git-113)
>=20


