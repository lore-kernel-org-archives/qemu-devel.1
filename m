Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47C2C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 578462068E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XA6lSJTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578462068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZjlq-0002N1-Eo
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 17:57:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZjjM-0000bD-VR
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZjjG-0007y8-DJ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:54:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27196
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZjjF-0007vW-Nf
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574808880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4yHz6XVm7UgYHmZ2mTL4JDpIdkv+YEYB3b8e1dXQAM=;
 b=XA6lSJTwQtcFlWObx65Vy5DFmYkiXa5z/vzeLiZRsHuVMXDYbAUCGPEiE13/AxcozLaU6z
 QiSpZ1ok2jBngoFrdltwRyaJ1vujNVZ92z3DMXK3hqWuzPSi6Q8UjnYHGyam5eXq8i6CvE
 nuo5E4/njAOgAhhiOYULPnC0Sb/3zwU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-_j7HF4_SO9mnZZiXf7BdzA-1; Tue, 26 Nov 2019 17:54:37 -0500
Received: by mail-wm1-f71.google.com with SMTP id z3so1728424wmk.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 14:54:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K4htZGKAL5TmYvE8AcSU75Zuvz2Gf6SSOODbNfsRrZs=;
 b=W2YiJJUKHEdqbWsE7SS/AhEB9QrHldeSNtO/4xDPqLjqkG5XqyS/WLB4w5PMPaplxV
 8I3Bbs0fl05i3V8qh5SVK3O5DxGZkf4byJqM8ZXXzlbTNGja+1rixXwerEPDDtb61UQY
 pI8sv4SEpKYeZw0GvFs3Cwg+gAY9PX275gbpE8arxEp95BQuMRmILroOeI9FoF+gn0L3
 EeYTIhjP1C8xl4ZPxicsJhLCEOcXQFI5WmqY7p8zogmbaB1ARxeSYsyCYl/6N4xqX4zT
 s7kNNoEPEWTbkkEJAyU2JAhi8rSMtqQP7q+e9AxOx6oso6iGn6oXk3lSBvRpwYGZX54O
 esnw==
X-Gm-Message-State: APjAAAU4Lh+eZ1AUUZMCA/R8zgFnPTz+BgllfkXloYmSvrxe6HbghWyU
 BgjhJgd1GrZj2Qi8bi4w+CGyfrWkLEWfc+DlE+88EuP/mvRLLcYGD44AblVTwm33EO+Oz5jphXa
 v2ed9hcoUPQj51wg=
X-Received: by 2002:a1c:46:: with SMTP id 67mr1321343wma.51.1574808875684;
 Tue, 26 Nov 2019 14:54:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqyvOeJj5jmPBUhXfc99zjvpAyc3FwPJepg4QWRYiP9sJdTrHyH+jlEgE1UluITvMlmfa2/Dxw==
X-Received: by 2002:a1c:46:: with SMTP id 67mr1321299wma.51.1574808874981;
 Tue, 26 Nov 2019 14:54:34 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id l204sm3312299wmf.2.2019.11.26.14.54.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2019 14:54:34 -0800 (PST)
Subject: Re: [PATCH v36 01/17] target/avr: Add outward facing interfaces and
 core CPU logic
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Michael Rolnik <mrolnik@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-2-mrolnik@gmail.com>
 <CAL1e-=hKLimSxQr-mf246N9SxR0P78nMuCcV6pYtKL04oQbvWQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <30fa4f50-1ee7-bbb2-15a5-fe631626b783@redhat.com>
Date: Tue, 26 Nov 2019 23:54:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hKLimSxQr-mf246N9SxR0P78nMuCcV6pYtKL04oQbvWQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: _j7HF4_SO9mnZZiXf7BdzA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "thuth@redhat.com" <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 11/24/19 5:21 PM, Aleksandar Markovic wrote:
> On Sunday, November 24, 2019, Michael Rolnik <mrolnik@gmail.com=20
> <mailto:mrolnik@gmail.com>> wrote:
>=20
>     This includes:
>     - CPU data structures
>     - object model classes and functions
>     - migration functions
>     - GDB hooks
>=20
>     Co-developed-by: Michael Rolnik <mrolnik@gmail.com
>     <mailto:mrolnik@gmail.com>>
>     Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk
>     <mailto:S.E.Harris@kent.ac.uk>>
>     Signed-off-by: Michael Rolnik <mrolnik@gmail.com
>     <mailto:mrolnik@gmail.com>>
>     Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk
>     <mailto:S.E.Harris@kent.ac.uk>>
>     Signed-off-by: Michael Rolnik <mrolnik@gmail.com
>     <mailto:mrolnik@gmail.com>>
>     Acked-by: Igor Mammedov <imammedo@redhat.com
>     <mailto:imammedo@redhat.com>>
>     ---
>=20
>=20
> Unfortunately, it appears to me that support for AVR-specific gdb=20
> command "info io_registers" is missing. This command looks very=20
> important in overall AVR/gdb context, and I think we shouldn't leave it=
=20
> unsupported. (please prove me wrong if I am mistaken here in any way).
>=20
> Cc- ing Alex as he is the maintainer for gdbstub QEMU component, for his=
=20
> opinion and advice.
>=20
> Philippe, what happens in your experimental AVR setups, if the gdb=20
> command =C2=A0"info io_registers" is used?

I use gdb-multiarch which doesn't have the AVR target:

$ gdb-multiarch -q
(gdb) set pagination off
(gdb) set architecture <tab>
Display all 200 possibilities? (y or n)y
aarch64                        mips:4120
aarch64:ilp32                  mips:4300
alpha                          mips:4400
alpha:ev4                      mips:4600
alpha:ev5                      mips:4650
alpha:ev6                      mips:5000
arm                            mips:5400
arm_any                        mips:5500
armv2                          mips:5900
armv2a                         mips:6000
armv3                          mips:7000
armv3m                         mips:8000
armv4                          mips:9000
armv4t                         mips:interaptiv-mr2
armv5                          mips:isa32
armv5t                         mips:isa32r2
armv5te                        mips:isa32r3
armv5tej                       mips:isa32r5
armv6                          mips:isa32r6
armv6-m                        mips:isa64
armv6k                         mips:isa64r2
armv6kz                        mips:isa64r3
armv6s-m                       mips:isa64r5
armv6t2                        mips:isa64r6
armv7                          mips:loongson_2e
armv7e-m                       mips:loongson_2f
armv8-a                        mips:loongson_3a
armv8-m.base                   mips:micromips
armv8-m.main                   mips:mips5
armv8-r                        mips:octeon
ep9312                         mips:octeon+
hppa1.0                        mips:octeon2
i386                           mips:octeon3
i386:intel                     mips:sb1
i386:nacl                      mips:xlr
i386:x64-32                    powerpc:403
i386:x64-32:intel              powerpc:601
i386:x64-32:nacl               powerpc:603
i386:x86-64                    powerpc:604
i386:x86-64:intel              powerpc:620
i386:x86-64:nacl               powerpc:630
i8086                          powerpc:7400
ia64-elf32                     powerpc:750
ia64-elf64                     powerpc:EC603e
iwmmxt                         powerpc:MPC8XX
iwmmxt2                        powerpc:a35
m68k                           powerpc:common
m68k:5200                      powerpc:common64
m68k:5206e                     powerpc:e500
m68k:521x                      powerpc:e500mc
m68k:5249                      powerpc:e500mc64
m68k:528x                      powerpc:e5500
m68k:5307                      powerpc:e6500
m68k:5407                      powerpc:rs64ii
m68k:547x                      powerpc:rs64iii
m68k:548x                      powerpc:titan
m68k:68000                     powerpc:vle
m68k:68008                     rs6000:6000
m68k:68010                     rs6000:rs1
m68k:68020                     rs6000:rs2
m68k:68030                     rs6000:rsc
m68k:68040                     s390:31-bit
m68k:68060                     s390:64-bit
m68k:cfv4e                     sh
m68k:cpu32                     sh-dsp
m68k:fido                      sh2
m68k:isa-a                     sh2a
m68k:isa-a:emac                sh2a-nofpu
m68k:isa-a:mac                 sh2a-nofpu-or-sh3-nommu
m68k:isa-a:nodiv               sh2a-nofpu-or-sh4-nommu-nofpu
m68k:isa-aplus                 sh2a-or-sh3e
m68k:isa-aplus:emac            sh2a-or-sh4
m68k:isa-aplus:mac             sh2e
m68k:isa-b                     sh3
m68k:isa-b:emac                sh3-dsp
m68k:isa-b:float               sh3-nommu
m68k:isa-b:float:emac          sh3e
m68k:isa-b:float:mac           sh4
m68k:isa-b:mac                 sh4-nofpu
m68k:isa-b:nousp               sh4-nommu-nofpu
m68k:isa-b:nousp:emac          sh4a
m68k:isa-b:nousp:mac           sh4a-nofpu
m68k:isa-c                     sh4al-dsp
m68k:isa-c:emac                sparc
m68k:isa-c:mac                 sparc:sparclet
m68k:isa-c:nodiv               sparc:sparclite
m68k:isa-c:nodiv:emac          sparc:sparclite_le
m68k:isa-c:nodiv:mac           sparc:v8plus
mips                           sparc:v8plusa
mips:10000                     sparc:v8plusb
mips:12000                     sparc:v8plusc
mips:14000                     sparc:v8plusd
mips:16                        sparc:v8pluse
mips:16000                     sparc:v9
mips:3000                      sparc:v9a
mips:3900                      sparc:v9b
mips:4000                      sparc:v9c
mips:4010                      sparc:v9d
mips:4100                      sparc:v9e
mips:4111                      xscale
*** List may be truncated, max-completions reached. ***
(gdb)

I used trace events to test this port (the FreeRTOS test, and trying to=20
boot some Atmega328 firmware.

So for the non-gdb part:
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>  From gdb docs:
>=20
>=20
>         21.3.8 Atmel AVR
>=20
> When configured for debugging the Atmel AVR, GDB=C2=A0supports the follow=
ing=20
> AVR-specific commands:
>=20
> |info io_registers|
>=20
>     This command displays information about the AVR I/O registers. For
>     each register, GDB=C2=A0prints its number and value.
>=20
>=20
>=20
>      =C2=A0target/avr/cpu-param.h |=C2=A0 37 +++
>      =C2=A0target/avr/cpu-qom.h=C2=A0 =C2=A0|=C2=A0 54 ++++
>      =C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 253 +++++++++++++=
+++++
>      =C2=A0target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 576 +++++++++++++=
++++++++++++++++++++++++++++
>      =C2=A0target/avr/gdbstub.c=C2=A0 =C2=A0|=C2=A0 85 ++++++
>      =C2=A0target/avr/machine.c=C2=A0 =C2=A0| 121 +++++++++
>      =C2=A0gdb-xml/avr-cpu.xml=C2=A0 =C2=A0 |=C2=A0 49 ++++
>      =C2=A07 files changed, 1175 insertions(+)
>      =C2=A0create mode 100644 target/avr/cpu-param.h
>      =C2=A0create mode 100644 target/avr/cpu-qom.h
>      =C2=A0create mode 100644 target/avr/cpu.h
>      =C2=A0create mode 100644 target/avr/cpu.c
>      =C2=A0create mode 100644 target/avr/gdbstub.c
>      =C2=A0create mode 100644 target/avr/machine.c
>      =C2=A0create mode 100644 gdb-xml/avr-cpu.xml
>=20
>     diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
>     new file mode 100644
>     index 0000000000..ccd1ea3429
>     --- /dev/null
>     +++ b/target/avr/cpu-param.h
>     @@ -0,0 +1,37 @@
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
>     +#ifndef AVR_CPU_PARAM_H
>     +#define AVR_CPU_PARAM_H 1
>     +
>     +#define TARGET_LONG_BITS 32
>     +/*
>     + * TARGET_PAGE_BITS cannot be more than 8 bits because
>     + * 1.=C2=A0 all IO registers occupy [0x0000 .. 0x00ff] address range=
,
>     and they
>     + *=C2=A0 =C2=A0 =C2=A0should be implemented as a device and not memo=
ry
>     + * 2.=C2=A0 SRAM starts at the address 0x0100
>     + */
>     +#define TARGET_PAGE_BITS 8
>     +#define TARGET_PHYS_ADDR_SPACE_BITS 24
>     +#define TARGET_VIRT_ADDR_SPACE_BITS 24
>     +#define NB_MMU_MODES 2
>     +
>     +
>     +#endif
>     diff --git a/target/avr/cpu-qom.h b/target/avr/cpu-qom.h
>     new file mode 100644
>     index 0000000000..e28b58c897
>     --- /dev/null
>     +++ b/target/avr/cpu-qom.h
>     @@ -0,0 +1,54 @@
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
>     +#ifndef QEMU_AVR_QOM_H
>     +#define QEMU_AVR_QOM_H
>     +
>     +#include "hw/core/cpu.h"
>     +
>     +#define TYPE_AVR_CPU "avr-cpu"
>     +
>     +#define AVR_CPU_CLASS(klass) \
>     +=C2=A0 =C2=A0 OBJECT_CLASS_CHECK(AVRCPUClass, (klass), TYPE_AVR_CPU)
>     +#define AVR_CPU(obj) \
>     +=C2=A0 =C2=A0 OBJECT_CHECK(AVRCPU, (obj), TYPE_AVR_CPU)
>     +#define AVR_CPU_GET_CLASS(obj) \
>     +=C2=A0 =C2=A0 OBJECT_GET_CLASS(AVRCPUClass, (obj), TYPE_AVR_CPU)
>     +
>     +/**
>     + *=C2=A0 AVRCPUClass:
>     + *=C2=A0 @parent_realize: The parent class' realize handler.
>     + *=C2=A0 @parent_reset: The parent class' reset handler.
>     + *=C2=A0 @vr: Version Register value.
>     + *
>     + *=C2=A0 A AVR CPU model.
>     + */
>     +typedef struct AVRCPUClass {
>     +=C2=A0 =C2=A0 /*< private >*/
>     +=C2=A0 =C2=A0 CPUClass parent_class;
>     +=C2=A0 =C2=A0 /*< public >*/
>     +=C2=A0 =C2=A0 DeviceRealize parent_realize;
>     +=C2=A0 =C2=A0 void (*parent_reset)(CPUState *cpu);
>     +} AVRCPUClass;
>     +
>     +typedef struct AVRCPU AVRCPU;
>     +
>     +
>     +#endif /* !defined (QEMU_AVR_CPU_QOM_H) */
>     diff --git a/target/avr/cpu.h b/target/avr/cpu.h
>     new file mode 100644
>     index 0000000000..ed9218af5f
>     --- /dev/null
>     +++ b/target/avr/cpu.h
>     @@ -0,0 +1,253 @@
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
>     +#ifndef QEMU_AVR_CPU_H
>     +#define QEMU_AVR_CPU_H
>     +
>     +#include "cpu-qom.h"
>     +#include "exec/cpu-defs.h"
>     +
>     +#define TCG_GUEST_DEFAULT_MO 0
>     +
>     +#define CPU_RESOLVING_TYPE TYPE_AVR_CPU
>     +
>     +/*
>     + * AVR has two memory spaces, data & code.
>     + * e.g. both have 0 address
>     + * ST/LD instructions access data space
>     + * LPM/SPM and instruction fetching access code memory space
>     + */
>     +#define MMU_CODE_IDX 0
>     +#define MMU_DATA_IDX 1
>     +
>     +#define EXCP_RESET 1
>     +#define EXCP_INT(n) (EXCP_RESET + (n) + 1)
>     +
>     +/* Number of CPU registers */
>     +#define NO_CPU_REGISTERS 32
>     +/* Number of IO registers accessible by ld/st/in/out */
>     +#define NO_IO_REGISTERS 64
>     +
>     +/*
>     + * Offsets of AVR memory regions in host memory space.
>     + *
>     + * This is needed because the AVR has separate code and data address
>     + * spaces that both have start from zero but have to go somewhere in
>     + * host memory.
>     + *
>     + * It's also useful to know where some things are, like the IO
>     registers.
>     + */
>     +/* Flash program memory */
>     +#define OFFSET_CODE 0x00000000
>     +/* CPU registers, IO registers, and SRAM */
>     +#define OFFSET_DATA 0x00800000
>     +/* CPU registers specifically, these are mapped at the start of data=
 */
>     +#define OFFSET_CPU_REGISTERS OFFSET_DATA
>     +/*
>     + * IO registers, including status register, stack pointer, and memor=
y
>     + * mapped peripherals, mapped just after CPU registers
>     + */
>     +#define OFFSET_IO_REGISTERS (OFFSET_DATA + NO_CPU_REGISTERS)
>     +
>     +enum avr_features {
>     +=C2=A0 =C2=A0 AVR_FEATURE_SRAM,
>     +
>     +=C2=A0 =C2=A0 AVR_FEATURE_1_BYTE_PC,
>     +=C2=A0 =C2=A0 AVR_FEATURE_2_BYTE_PC,
>     +=C2=A0 =C2=A0 AVR_FEATURE_3_BYTE_PC,
>     +
>     +=C2=A0 =C2=A0 AVR_FEATURE_1_BYTE_SP,
>     +=C2=A0 =C2=A0 AVR_FEATURE_2_BYTE_SP,
>     +
>     +=C2=A0 =C2=A0 AVR_FEATURE_BREAK,
>     +=C2=A0 =C2=A0 AVR_FEATURE_DES,
>     +=C2=A0 =C2=A0 AVR_FEATURE_RMW, /* Read Modify Write - XCH LAC LAS LA=
T */
>     +
>     +=C2=A0 =C2=A0 AVR_FEATURE_EIJMP_EICALL,
>     +=C2=A0 =C2=A0 AVR_FEATURE_IJMP_ICALL,
>     +=C2=A0 =C2=A0 AVR_FEATURE_JMP_CALL,
>     +
>     +=C2=A0 =C2=A0 AVR_FEATURE_ADIW_SBIW,
>     +
>     +=C2=A0 =C2=A0 AVR_FEATURE_SPM,
>     +=C2=A0 =C2=A0 AVR_FEATURE_SPMX,
>     +
>     +=C2=A0 =C2=A0 AVR_FEATURE_ELPMX,
>     +=C2=A0 =C2=A0 AVR_FEATURE_ELPM,
>     +=C2=A0 =C2=A0 AVR_FEATURE_LPMX,
>     +=C2=A0 =C2=A0 AVR_FEATURE_LPM,
>     +
>     +=C2=A0 =C2=A0 AVR_FEATURE_MOVW,
>     +=C2=A0 =C2=A0 AVR_FEATURE_MUL,
>     +=C2=A0 =C2=A0 AVR_FEATURE_RAMPD,
>     +=C2=A0 =C2=A0 AVR_FEATURE_RAMPX,
>     +=C2=A0 =C2=A0 AVR_FEATURE_RAMPY,
>     +=C2=A0 =C2=A0 AVR_FEATURE_RAMPZ,
>     +};
>     +
>     +typedef struct CPUAVRState CPUAVRState;
>     +
>     +struct CPUAVRState {
>     +=C2=A0 =C2=A0 uint32_t pc_w; /* 0x003fffff up to 22 bits */
>     +
>     +=C2=A0 =C2=A0 uint32_t sregC; /* 0x00000001 1 bit */
>     +=C2=A0 =C2=A0 uint32_t sregZ; /* 0x00000001 1 bit */
>     +=C2=A0 =C2=A0 uint32_t sregN; /* 0x00000001 1 bit */
>     +=C2=A0 =C2=A0 uint32_t sregV; /* 0x00000001 1 bit */
>     +=C2=A0 =C2=A0 uint32_t sregS; /* 0x00000001 1 bit */
>     +=C2=A0 =C2=A0 uint32_t sregH; /* 0x00000001 1 bit */
>     +=C2=A0 =C2=A0 uint32_t sregT; /* 0x00000001 1 bit */
>     +=C2=A0 =C2=A0 uint32_t sregI; /* 0x00000001 1 bit */
>     +
>     +=C2=A0 =C2=A0 uint32_t rampD; /* 0x00ff0000 8 bits */
>     +=C2=A0 =C2=A0 uint32_t rampX; /* 0x00ff0000 8 bits */
>     +=C2=A0 =C2=A0 uint32_t rampY; /* 0x00ff0000 8 bits */
>     +=C2=A0 =C2=A0 uint32_t rampZ; /* 0x00ff0000 8 bits */
>     +=C2=A0 =C2=A0 uint32_t eind; /* 0x00ff0000 8 bits */
>     +
>     +=C2=A0 =C2=A0 uint32_t r[NO_CPU_REGISTERS]; /* 8 bits each */
>     +=C2=A0 =C2=A0 uint32_t sp; /* 16 bits */
>     +
>     +=C2=A0 =C2=A0 uint32_t skip; /* if set skip instruction */
>     +
>     +=C2=A0 =C2=A0 uint64_t intsrc; /* interrupt sources */
>     +=C2=A0 =C2=A0 bool fullacc; /* CPU/MEM if true MEM only otherwise */
>     +
>     +=C2=A0 =C2=A0 uint32_t features;
>     +};
>     +
>     +/**
>     + *=C2=A0 AVRCPU:
>     + *=C2=A0 @env: #CPUAVRState
>     + *
>     + *=C2=A0 A AVR CPU.
>     + */
>     +typedef struct AVRCPU {
>     +=C2=A0 =C2=A0 /*< private >*/
>     +=C2=A0 =C2=A0 CPUState parent_obj;
>     +=C2=A0 =C2=A0 /*< public >*/
>     +
>     +=C2=A0 =C2=A0 CPUNegativeOffsetState neg;
>     +=C2=A0 =C2=A0 CPUAVRState env;
>     +} AVRCPU;
>     +
>     +#ifndef CONFIG_USER_ONLY
>     +extern const struct VMStateDescription vms_avr_cpu;
>     +#endif
>     +
>     +void avr_cpu_do_interrupt(CPUState *cpu);
>     +bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
>     +hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>     +int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>     +int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg)=
;
>     +
>     +static inline int avr_feature(CPUAVRState *env, int feature)
>     +{
>     +=C2=A0 =C2=A0 return (env->features & (1U << feature)) !=3D 0;
>     +}
>     +
>     +static inline void avr_set_feature(CPUAVRState *env, int feature)
>     +{
>     +=C2=A0 =C2=A0 env->features |=3D (1U << feature);
>     +}
>     +
>     +#define cpu_list avr_cpu_list
>     +#define cpu_signal_handler cpu_avr_signal_handler
>     +#define cpu_mmu_index avr_cpu_mmu_index
>     +
>     +static inline int avr_cpu_mmu_index(CPUAVRState *env, bool ifetch)
>     +{
>     +=C2=A0 =C2=A0 return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
>     +}
>     +
>     +void avr_cpu_tcg_init(void);
>     +
>     +void avr_cpu_list(void);
>     +int cpu_avr_exec(CPUState *cpu);
>     +int cpu_avr_signal_handler(int host_signum, void *pinfo, void *puc);
>     +int avr_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int rw, int mmu_idx);
>     +int avr_cpu_memory_rw_debug(CPUState *cs, vaddr address, uint8_t *bu=
f,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int len, bool is_write);
>     +
>     +enum {
>     +=C2=A0 =C2=A0 TB_FLAGS_FULL_ACCESS =3D 1,
>     +=C2=A0 =C2=A0 TB_FLAGS_SKIP =3D 2,
>     +};
>     +
>     +static inline void cpu_get_tb_cpu_state(CPUAVRState *env,
>     target_ulong *pc,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong *cs_base, uint32=
_t
>     *pflags)
>     +{
>     +=C2=A0 =C2=A0 uint32_t flags =3D 0;
>     +
>     +=C2=A0 =C2=A0 *pc =3D env->pc_w * 2;
>     +=C2=A0 =C2=A0 *cs_base =3D 0;
>     +
>     +=C2=A0 =C2=A0 if (env->fullacc) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D TB_FLAGS_FULL_ACCESS;
>     +=C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 if (env->skip) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D TB_FLAGS_SKIP;
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 *pflags =3D flags;
>     +}
>     +
>     +static inline int cpu_interrupts_enabled(CPUAVRState *env)
>     +{
>     +=C2=A0 =C2=A0 return env->sregI !=3D 0;
>     +}
>     +
>     +static inline uint8_t cpu_get_sreg(CPUAVRState *env)
>     +{
>     +=C2=A0 =C2=A0 uint8_t sreg;
>     +=C2=A0 =C2=A0 sreg =3D (env->sregC) << 0
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env->sregZ) << 1
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env->sregN) << 2
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env->sregV) << 3
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env->sregS) << 4
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env->sregH) << 5
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env->sregT) << 6
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env->sregI) << 7;
>     +=C2=A0 =C2=A0 return sreg;
>     +}
>     +
>     +static inline void cpu_set_sreg(CPUAVRState *env, uint8_t sreg)
>     +{
>     +=C2=A0 =C2=A0 env->sregC =3D (sreg >> 0) & 0x01;
>     +=C2=A0 =C2=A0 env->sregZ =3D (sreg >> 1) & 0x01;
>     +=C2=A0 =C2=A0 env->sregN =3D (sreg >> 2) & 0x01;
>     +=C2=A0 =C2=A0 env->sregV =3D (sreg >> 3) & 0x01;
>     +=C2=A0 =C2=A0 env->sregS =3D (sreg >> 4) & 0x01;
>     +=C2=A0 =C2=A0 env->sregH =3D (sreg >> 5) & 0x01;
>     +=C2=A0 =C2=A0 env->sregT =3D (sreg >> 6) & 0x01;
>     +=C2=A0 =C2=A0 env->sregI =3D (sreg >> 7) & 0x01;
>     +}
>     +
>     +bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 MMUAccessType access_type, int mmu_idx,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bool probe, uintptr_t retaddr);
>     +
>     +typedef CPUAVRState CPUArchState;
>     +typedef AVRCPU ArchCPU;
>     +
>     +#include "exec/cpu-all.h"
>     +
>     +#endif /* !defined (QEMU_AVR_CPU_H) */
>     diff --git a/target/avr/cpu.c b/target/avr/cpu.c
>     new file mode 100644
>     index 0000000000..dae56d7845
>     --- /dev/null
>     +++ b/target/avr/cpu.c
>     @@ -0,0 +1,576 @@
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
>     +#include "qemu/osdep.h"
>     +#include "qapi/error.h"
>     +#include "qemu/qemu-print.h"
>     +#include "exec/exec-all.h"
>     +#include "cpu.h"
>     +
>     +static void avr_cpu_set_pc(CPUState *cs, vaddr value)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);
>     +
>     +=C2=A0 =C2=A0 cpu->env.pc_w =3D value / 2; /* internally PC points t=
o words */
>     +}
>     +
>     +static bool avr_cpu_has_work(CPUState *cs)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +
>     +=C2=A0 =C2=A0 return (cs->interrupt_request & (CPU_INTERRUPT_HARD |
>     CPU_INTERRUPT_RESET))
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 && cpu_interrupts_enabled(=
env);
>     +}
>     +
>     +static void avr_cpu_synchronize_from_tb(CPUState *cs,
>     TranslationBlock *tb)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +
>     +=C2=A0 =C2=A0 env->pc_w =3D tb->pc / 2; /* internally PC points to w=
ords */
>     +}
>     +
>     +static void avr_cpu_reset(CPUState *cs)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);
>     +=C2=A0 =C2=A0 AVRCPUClass *mcc =3D AVR_CPU_GET_CLASS(cpu);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +
>     +=C2=A0 =C2=A0 mcc->parent_reset(cs);
>     +
>     +=C2=A0 =C2=A0 env->pc_w =3D 0;
>     +=C2=A0 =C2=A0 env->sregI =3D 1;
>     +=C2=A0 =C2=A0 env->sregC =3D 0;
>     +=C2=A0 =C2=A0 env->sregZ =3D 0;
>     +=C2=A0 =C2=A0 env->sregN =3D 0;
>     +=C2=A0 =C2=A0 env->sregV =3D 0;
>     +=C2=A0 =C2=A0 env->sregS =3D 0;
>     +=C2=A0 =C2=A0 env->sregH =3D 0;
>     +=C2=A0 =C2=A0 env->sregT =3D 0;
>     +
>     +=C2=A0 =C2=A0 env->rampD =3D 0;
>     +=C2=A0 =C2=A0 env->rampX =3D 0;
>     +=C2=A0 =C2=A0 env->rampY =3D 0;
>     +=C2=A0 =C2=A0 env->rampZ =3D 0;
>     +=C2=A0 =C2=A0 env->eind =3D 0;
>     +=C2=A0 =C2=A0 env->sp =3D 0;
>     +
>     +=C2=A0 =C2=A0 env->skip =3D 0;
>     +
>     +=C2=A0 =C2=A0 memset(env->r, 0, sizeof(env->r));
>     +
>     +=C2=A0 =C2=A0 tlb_flush(cs);
>     +}
>     +
>     +static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info
>     *info)
>     +{
>     +=C2=A0 =C2=A0 info->mach =3D bfd_arch_avr;
>     +=C2=A0 =C2=A0 info->print_insn =3D NULL;
>     +}
>     +
>     +static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
>     +{
>     +=C2=A0 =C2=A0 CPUState *cs =3D CPU(dev);
>     +=C2=A0 =C2=A0 AVRCPUClass *mcc =3D AVR_CPU_GET_CLASS(dev);
>     +=C2=A0 =C2=A0 Error *local_err =3D NULL;
>     +
>     +=C2=A0 =C2=A0 cpu_exec_realizefn(cs, &local_err);
>     +=C2=A0 =C2=A0 if (local_err !=3D NULL) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>     +=C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 qemu_init_vcpu(cs);
>     +=C2=A0 =C2=A0 cpu_reset(cs);
>     +
>     +=C2=A0 =C2=A0 mcc->parent_realize(dev, errp);
>     +}
>     +
>     +static void avr_cpu_set_int(void *opaque, int irq, int level)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D opaque;
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +=C2=A0 =C2=A0 CPUState *cs =3D CPU(cpu);
>     +
>     +=C2=A0 =C2=A0 uint64_t mask =3D (1ull << irq);
>     +=C2=A0 =C2=A0 if (level) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env->intsrc |=3D mask;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>     +=C2=A0 =C2=A0 } else {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env->intsrc &=3D ~mask;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env->intsrc =3D=3D 0) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_reset_interrupt(cs, CP=
U_INTERRUPT_HARD);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 }
>     +}
>     +
>     +static void avr_cpu_initfn(Object *obj)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>     +
>     +=C2=A0 =C2=A0 cpu_set_cpustate_pointers(cpu);
>     +
>     +#ifndef CONFIG_USER_ONLY
>     +=C2=A0 =C2=A0 /* Set the number of interrupts supported by the CPU. =
*/
>     +=C2=A0 =C2=A0 qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int, 57);
>     +#endif
>     +}
>     +
>     +static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
>     +{
>     +=C2=A0 =C2=A0 ObjectClass *oc;
>     +
>     +=C2=A0 =C2=A0 oc =3D object_class_by_name(cpu_model);
>     +=C2=A0 =C2=A0 if (object_class_dynamic_cast(oc, TYPE_AVR_CPU) =3D=3D=
 NULL ||
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_class_is_abstract(oc)) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 oc =3D NULL;
>     +=C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 return oc;
>     +}
>     +
>     +static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +=C2=A0 =C2=A0 int i;
>     +
>     +=C2=A0 =C2=A0 qemu_fprintf(f, "\n");
>     +=C2=A0 =C2=A0 qemu_fprintf(f, "PC:=C2=A0 =C2=A0 %06x\n", env->pc_w);
>     +=C2=A0 =C2=A0 qemu_fprintf(f, "SP:=C2=A0 =C2=A0 =C2=A0 %04x\n", env-=
>sp);
>     +=C2=A0 =C2=A0 qemu_fprintf(f, "rampD:=C2=A0 =C2=A0 =C2=A0%02x\n", en=
v->rampD >> 16);
>     +=C2=A0 =C2=A0 qemu_fprintf(f, "rampX:=C2=A0 =C2=A0 =C2=A0%02x\n", en=
v->rampX >> 16);
>     +=C2=A0 =C2=A0 qemu_fprintf(f, "rampY:=C2=A0 =C2=A0 =C2=A0%02x\n", en=
v->rampY >> 16);
>     +=C2=A0 =C2=A0 qemu_fprintf(f, "rampZ:=C2=A0 =C2=A0 =C2=A0%02x\n", en=
v->rampZ >> 16);
>     +=C2=A0 =C2=A0 qemu_fprintf(f, "EIND:=C2=A0 =C2=A0 =C2=A0 %02x\n", en=
v->eind >> 16);
>     +=C2=A0 =C2=A0 qemu_fprintf(f, "X:=C2=A0 =C2=A0 =C2=A0 =C2=A0%02x%02x=
\n", env->r[27], env->r[26]);
>     +=C2=A0 =C2=A0 qemu_fprintf(f, "Y:=C2=A0 =C2=A0 =C2=A0 =C2=A0%02x%02x=
\n", env->r[29], env->r[28]);
>     +=C2=A0 =C2=A0 qemu_fprintf(f, "Z:=C2=A0 =C2=A0 =C2=A0 =C2=A0%02x%02x=
\n", env->r[31], env->r[30]);
>     +=C2=A0 =C2=A0 qemu_fprintf(f, "SREG:=C2=A0 =C2=A0 [ %c %c %c %c %c %=
c %c %c ]\n",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env->sregI ? 'I' : '-',
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env->sregT ? 'T' : '-',
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env->sregH ? 'H' : '-',
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env->sregS ? 'S' : '-',
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env->sregV ? 'V' : '-',
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env->sregN ? '-' : 'N', /* Zf has negative
>     logic */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env->sregZ ? 'Z' : '-',
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env->sregC ? 'I' : '-');
>     +=C2=A0 =C2=A0 qemu_fprintf(f, "SKIP:=C2=A0 =C2=A0 %02x\n", env->skip=
);
>     +
>     +=C2=A0 =C2=A0 qemu_fprintf(f, "\n");
>     +=C2=A0 =C2=A0 for (i =3D 0; i < ARRAY_SIZE(env->r); i++) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, "R[%02d]:=C2=A0 %02x=C2=
=A0 =C2=A0", i, env->r[i]);
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((i % 8) =3D=3D 7) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, "\n");
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 qemu_fprintf(f, "\n");
>     +}
>     +
>     +static void avr_cpu_class_init(ObjectClass *oc, void *data)
>     +{
>     +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(oc);
>     +=C2=A0 =C2=A0 CPUClass *cc =3D CPU_CLASS(oc);
>     +=C2=A0 =C2=A0 AVRCPUClass *mcc =3D AVR_CPU_CLASS(oc);
>     +
>     +=C2=A0 =C2=A0 mcc->parent_realize =3D dc->realize;
>     +=C2=A0 =C2=A0 dc->realize =3D avr_cpu_realizefn;
>     +
>     +=C2=A0 =C2=A0 mcc->parent_reset =3D cc->reset;
>     +=C2=A0 =C2=A0 cc->reset =3D avr_cpu_reset;
>     +
>     +=C2=A0 =C2=A0 cc->class_by_name =3D avr_cpu_class_by_name;
>     +
>     +=C2=A0 =C2=A0 cc->has_work =3D avr_cpu_has_work;
>     +=C2=A0 =C2=A0 cc->do_interrupt =3D avr_cpu_do_interrupt;
>     +=C2=A0 =C2=A0 cc->cpu_exec_interrupt =3D avr_cpu_exec_interrupt;
>     +=C2=A0 =C2=A0 cc->dump_state =3D avr_cpu_dump_state;
>     +=C2=A0 =C2=A0 cc->set_pc =3D avr_cpu_set_pc;
>     +#if !defined(CONFIG_USER_ONLY)
>     +=C2=A0 =C2=A0 cc->memory_rw_debug =3D avr_cpu_memory_rw_debug;
>     +#endif
>     +#ifdef CONFIG_USER_ONLY
>     +=C2=A0 =C2=A0 cc->handle_mmu_fault =3D avr_cpu_handle_mmu_fault;
>     +#else
>     +=C2=A0 =C2=A0 cc->get_phys_page_debug =3D avr_cpu_get_phys_page_debu=
g;
>     +=C2=A0 =C2=A0 cc->vmsd =3D &vms_avr_cpu;
>     +#endif
>     +=C2=A0 =C2=A0 cc->disas_set_info =3D avr_cpu_disas_set_info;
>     +=C2=A0 =C2=A0 cc->tlb_fill =3D avr_cpu_tlb_fill;
>     +=C2=A0 =C2=A0 cc->tcg_initialize =3D avr_cpu_tcg_init;
>     +=C2=A0 =C2=A0 cc->synchronize_from_tb =3D avr_cpu_synchronize_from_t=
b;
>     +=C2=A0 =C2=A0 cc->gdb_read_register =3D avr_cpu_gdb_read_register;
>     +=C2=A0 =C2=A0 cc->gdb_write_register =3D avr_cpu_gdb_write_register;
>     +=C2=A0 =C2=A0 cc->gdb_num_core_regs =3D 35;
>     +=C2=A0 =C2=A0 cc->gdb_core_xml_file =3D "avr-cpu.xml";
>     +}
>     +
>     +static void avr_avr1_initfn(Object *obj)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>     +}
>     +
>     +static void avr_avr2_initfn(Object *obj)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>     +}
>     +
>     +static void avr_avr25_initfn(Object *obj)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>     +}
>     +
>     +static void avr_avr3_initfn(Object *obj)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>     +}
>     +
>     +static void avr_avr31_initfn(Object *obj)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>     +}
>     +
>     +static void avr_avr35_initfn(Object *obj)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>     +}
>     +
>     +static void avr_avr4_initfn(Object *obj)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);
>     +}
>     +
>     +static void avr_avr5_initfn(Object *obj)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);
>     +}
>     +
>     +static void avr_avr51_initfn(Object *obj)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);
>     +}
>     +
>     +static void avr_avr6_initfn(Object *obj)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);
>     +}
>     +
>     +static void avr_xmega2_initfn(Object *obj)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);
>     +}
>     +
>     +static void avr_xmega4_initfn(Object *obj)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);
>     +}
>     +
>     +static void avr_xmega5_initfn(Object *obj)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPD);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPX);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPY);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);
>     +}
>     +
>     +static void avr_xmega6_initfn(Object *obj)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);
>     +}
>     +
>     +static void avr_xmega7_initfn(Object *obj)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>     +
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPD);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPX);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPY);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);
>     +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);
>     +}
>     +
>     +typedef struct AVRCPUInfo {
>     +=C2=A0 =C2=A0 const char *name;
>     +=C2=A0 =C2=A0 void (*initfn)(Object *obj);
>     +} AVRCPUInfo;
>     +
>     +
>     +static void avr_cpu_list_entry(gpointer data, gpointer user_data)
>     +{
>     +=C2=A0 =C2=A0 const char *typename =3D object_class_get_name(OBJECT_=
CLASS(data));
>     +
>     +=C2=A0 =C2=A0 qemu_printf("%s\n", typename);
>     +}
>     +
>     +void avr_cpu_list(void)
>     +{
>     +=C2=A0 =C2=A0 GSList *list;
>     +=C2=A0 =C2=A0 list =3D object_class_get_list_sorted(TYPE_AVR_CPU, fa=
lse);
>     +=C2=A0 =C2=A0 g_slist_foreach(list, avr_cpu_list_entry, NULL);
>     +=C2=A0 =C2=A0 g_slist_free(list);
>     +}
>     +
>     +#define DEFINE_AVR_CPU_TYPE(model, initfn) \
>     +=C2=A0 =C2=A0 { \
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D TYPE_AVR_CPU, \
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_init =3D initfn, \
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D model "-avr-cpu", \
>     +=C2=A0 =C2=A0 }
>     +
>     +static const TypeInfo avr_cpu_type_info[] =3D {
>     +=C2=A0 =C2=A0 {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D TYPE_AVR_CPU,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D TYPE_CPU,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_size =3D sizeof(AVRCPU),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_init =3D avr_cpu_initfn,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_size =3D sizeof(AVRCPUClass),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init =3D avr_cpu_class_init,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .abstract =3D true,
>     +=C2=A0 =C2=A0 },
>     +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE("avr1", avr_avr1_initfn),
>     +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE("avr2", avr_avr2_initfn),
>     +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE("avr25", avr_avr25_initfn),
>     +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE("avr3", avr_avr3_initfn),
>     +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE("avr31", avr_avr31_initfn),
>     +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE("avr35", avr_avr35_initfn),
>     +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE("avr4", avr_avr4_initfn),
>     +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE("avr5", avr_avr5_initfn),
>     +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE("avr51", avr_avr51_initfn),
>     +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE("avr6", avr_avr6_initfn),
>     +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE("xmega2", avr_xmega2_initfn),
>     +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE("xmega4", avr_xmega4_initfn),
>     +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE("xmega5", avr_xmega5_initfn),
>     +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE("xmega6", avr_xmega6_initfn),
>     +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE("xmega7", avr_xmega7_initfn),
>     +};
>     +
>     +DEFINE_TYPES(avr_cpu_type_info)
>     diff --git a/target/avr/gdbstub.c b/target/avr/gdbstub.c
>     new file mode 100644
>     index 0000000000..20a5252482
>     --- /dev/null
>     +++ b/target/avr/gdbstub.c
>     @@ -0,0 +1,85 @@
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
>     +#include "qemu/osdep.h"
>     +#include "qemu-common.h"
>     +#include "exec/gdbstub.h"
>     +
>     +int avr_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +
>     +=C2=A0 =C2=A0 /*=C2=A0 R */
>     +=C2=A0 =C2=A0 if (n < 32) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(mem_buf, env->r[n]);
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 /*=C2=A0 SREG */
>     +=C2=A0 =C2=A0 if (n =3D=3D 32) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t sreg =3D cpu_get_sreg(env);
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(mem_buf, sreg);
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 /*=C2=A0 SP */
>     +=C2=A0 =C2=A0 if (n =3D=3D 33) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg16(mem_buf, env->sp & =
0x0000ffff);
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 /*=C2=A0 PC */
>     +=C2=A0 =C2=A0 if (n =3D=3D 34) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->pc_w =
* 2);
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 return 0;
>     +}
>     +
>     +int avr_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n=
)
>     +{
>     +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>     +
>     +=C2=A0 =C2=A0 /*=C2=A0 R */
>     +=C2=A0 =C2=A0 if (n < 32) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env->r[n] =3D *mem_buf;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 /*=C2=A0 SREG */
>     +=C2=A0 =C2=A0 if (n =3D=3D 32) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_set_sreg(env, *mem_buf);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 /*=C2=A0 SP */
>     +=C2=A0 =C2=A0 if (n =3D=3D 33) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env->sp =3D lduw_p(mem_buf);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 2;
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 /*=C2=A0 PC */
>     +=C2=A0 =C2=A0 if (n =3D=3D 34) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env->pc_w =3D ldl_p(mem_buf) / 2;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 4;
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 return 0;
>     +}
>     diff --git a/target/avr/machine.c b/target/avr/machine.c
>     new file mode 100644
>     index 0000000000..f6dcda7adc
>     --- /dev/null
>     +++ b/target/avr/machine.c
>     @@ -0,0 +1,121 @@
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
>     +#include "qemu/osdep.h"
>     +#include "cpu.h"
>     +#include "migration/cpu.h"
>     +
>     +static int get_sreg(QEMUFile *f, void *opaque, size_t size,
>     +=C2=A0 =C2=A0 const VMStateField *field)
>     +{
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D opaque;
>     +=C2=A0 =C2=A0 uint8_t sreg;
>     +
>     +=C2=A0 =C2=A0 sreg =3D qemu_get_byte(f);
>     +=C2=A0 =C2=A0 cpu_set_sreg(env, sreg);
>     +=C2=A0 =C2=A0 return 0;
>     +}
>     +
>     +static int put_sreg(
>     +=C2=A0 =C2=A0 QEMUFile *f, void *opaque, size_t size,
>     +=C2=A0 =C2=A0 const VMStateField *field, QJSON *vmdesc)
>     +{
>     +=C2=A0 =C2=A0 CPUAVRState *env =3D opaque;
>     +=C2=A0 =C2=A0 uint8_t sreg =3D cpu_get_sreg(env);
>     +
>     +=C2=A0 =C2=A0 qemu_put_byte(f, sreg);
>     +=C2=A0 =C2=A0 return 0;
>     +}
>     +
>     +static const VMStateInfo vms_sreg =3D {
>     +=C2=A0 =C2=A0 .name =3D "sreg",
>     +=C2=A0 =C2=A0 .get =3D get_sreg,
>     +=C2=A0 =C2=A0 .put =3D put_sreg,
>     +};
>     +
>     +static int get_segment(
>     +=C2=A0 =C2=A0 QEMUFile *f, void *opaque, size_t size, const VMStateF=
ield *field)
>     +{
>     +=C2=A0 =C2=A0 uint32_t *ramp =3D opaque;
>     +=C2=A0 =C2=A0 uint8_t temp;
>     +
>     +=C2=A0 =C2=A0 temp =3D qemu_get_byte(f);
>     +=C2=A0 =C2=A0 *ramp =3D ((uint32_t)temp) << 16;
>     +=C2=A0 =C2=A0 return 0;
>     +}
>     +
>     +static int put_segment(
>     +=C2=A0 =C2=A0 QEMUFile *f, void *opaque, size_t size,
>     +=C2=A0 =C2=A0 const VMStateField *field, QJSON *vmdesc)
>     +{
>     +=C2=A0 =C2=A0 uint32_t *ramp =3D opaque;
>     +=C2=A0 =C2=A0 uint8_t temp =3D *ramp >> 16;
>     +
>     +=C2=A0 =C2=A0 qemu_put_byte(f, temp);
>     +=C2=A0 =C2=A0 return 0;
>     +}
>     +
>     +static const VMStateInfo vms_rampD =3D {
>     +=C2=A0 =C2=A0 .name =3D "rampD",
>     +=C2=A0 =C2=A0 .get =3D get_segment,
>     +=C2=A0 =C2=A0 .put =3D put_segment,
>     +};
>     +static const VMStateInfo vms_rampX =3D {
>     +=C2=A0 =C2=A0 .name =3D "rampX",
>     +=C2=A0 =C2=A0 .get =3D get_segment,
>     +=C2=A0 =C2=A0 .put =3D put_segment,
>     +};
>     +static const VMStateInfo vms_rampY =3D {
>     +=C2=A0 =C2=A0 .name =3D "rampY",
>     +=C2=A0 =C2=A0 .get =3D get_segment,
>     +=C2=A0 =C2=A0 .put =3D put_segment,
>     +};
>     +static const VMStateInfo vms_rampZ =3D {
>     +=C2=A0 =C2=A0 .name =3D "rampZ",
>     +=C2=A0 =C2=A0 .get =3D get_segment,
>     +=C2=A0 =C2=A0 .put =3D put_segment,
>     +};
>     +static const VMStateInfo vms_eind =3D {
>     +=C2=A0 =C2=A0 .name =3D "eind",
>     +=C2=A0 =C2=A0 .get =3D get_segment,
>     +=C2=A0 =C2=A0 .put =3D put_segment,
>     +};
>     +
>     +const VMStateDescription vms_avr_cpu =3D {
>     +=C2=A0 =C2=A0 .name =3D "cpu",
>     +=C2=A0 =C2=A0 .version_id =3D 0,
>     +=C2=A0 =C2=A0 .minimum_version_id =3D 0,
>     +=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(env.pc_w, AVRCPU),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(env.sp, AVRCPU),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(env.skip, AVRCPU),
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(env.r, AVRCPU, NO_C=
PU_REGISTERS),
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_SINGLE(env, AVRCPU, 0, vms_sreg,=
 CPUAVRState),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_SINGLE(env.rampD, AVRCPU, 0, vms=
_rampD, uint32_t),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_SINGLE(env.rampX, AVRCPU, 0, vms=
_rampX, uint32_t),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_SINGLE(env.rampY, AVRCPU, 0, vms=
_rampY, uint32_t),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_SINGLE(env.rampZ, AVRCPU, 0, vms=
_rampZ, uint32_t),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_SINGLE(env.eind, AVRCPU, 0, vms_=
eind, uint32_t),
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()
>     +=C2=A0 =C2=A0 }
>     +};
>     diff --git a/gdb-xml/avr-cpu.xml b/gdb-xml/avr-cpu.xml
>     new file mode 100644
>     index 0000000000..c4747f5b40
>     --- /dev/null
>     +++ b/gdb-xml/avr-cpu.xml
>     @@ -0,0 +1,49 @@
>     +<?xml version=3D"1.0"?>
>     +<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
>     +
>     +=C2=A0 =C2=A0 =C2=A0Copying and distribution of this file, with or w=
ithout
>     modification,
>     +=C2=A0 =C2=A0 =C2=A0are permitted in any medium without royalty prov=
ided the copyright
>     +=C2=A0 =C2=A0 =C2=A0notice and this notice are preserved.=C2=A0 -->
>     +
>     +<!-- Register numbers are hard-coded in order to maintain backward
>     +=C2=A0 =C2=A0 =C2=A0compatibility with older versions of tools that =
didn't use xml
>     +=C2=A0 =C2=A0 =C2=A0register descriptions.=C2=A0 -->
>     +
>     +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
>     +<feature name=3D"org.gnu.gdb.riscv.cpu">
>     +=C2=A0 <reg name=3D"r0" bitsize=3D"8" type=3D"int" regnum=3D"0"/>
>     +=C2=A0 <reg name=3D"r1" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r2" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r3" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r4" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r5" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r6" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r7" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r8" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r9" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r10" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r11" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r12" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r13" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r14" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r15" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r16" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r17" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r18" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r19" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r20" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r21" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r22" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r23" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r24" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r25" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r26" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r27" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r28" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r29" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r30" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"r31" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"sreg" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"sp" bitsize=3D"8" type=3D"int"/>
>     +=C2=A0 <reg name=3D"pc" bitsize=3D"8" type=3D"int"/>
>     +</feature>
>     --=20
>     2.17.2 (Apple Git-113)
>=20


