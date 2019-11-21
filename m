Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F6AC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6E720659
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaCXbKde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6E720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXsZC-0005ED-7r
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 14:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iXsXY-0004gZ-LJ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iXsXW-0000RU-Jb
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:54:56 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:35688)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iXsXW-0000Nd-A6
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:54:54 -0500
Received: by mail-qk1-x744.google.com with SMTP id i19so4219665qki.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 11:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FntM5YLbWq7cHhRArVlX2oSg9To4ITzANCLTBIIyYNM=;
 b=LaCXbKdexzjtj15z3s7e9SUgmUxJWAYpMgNQmlyPph9PuOljDDc2l6hpc/n40Ls12X
 QBv9l55y/BSykRV4H/Gx9Wq0rGXAxrUydeYHsPxXvNZtF800UY2RS8gkZrBCmTgrkUi4
 ilHgCCw407D2sBSNkahZ5u+EidK1BEbNRTdlruQ3ttJ6t3RfSnU6n0Qp0B/AJSb81Nsf
 +ZGZFYVzEyPPjIu1EGwFKQQ1TvyJ1c5NK0Viudw1YTKqHPM4c+iEpYafGrGswmC/TtD8
 FiPV9pQhoyDg6pagrDmKNioE9nhKlR0sPN8ELcyA2AAoiw+WKRj/fBdwLw4q6gj8oVDz
 WSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FntM5YLbWq7cHhRArVlX2oSg9To4ITzANCLTBIIyYNM=;
 b=uYRXNqEkL5WyvdhmUhht4u07ZD3nqRtoZU3L9ojWRNon1mB7w420thIZhh0A4lkV9J
 wio2AtDZxcsJ6yM44BEV7+KrUvElYGHMdeMUW9LiLKO25h/Bnt+0EePchmKWtinvwzRz
 TE+gzm/yAKIYOGzxhk02K+cn7aZzONahRSP8qXvkYpkpjNlwoaqHOVMDpcpzgoKiiRz3
 hqgOTGKG5HKPHhWaCkTKKRpAdW/1C6kOEIiK0jpMlMdC55u9tjXG2FmXEQ9MhUlA/UgI
 dErWslB2zcbS8+56v+PWxJolRAaoYRjGy/dEHpHXWv+jXzEO2Xzf7aHF4VEckjHjX4jD
 K+7A==
X-Gm-Message-State: APjAAAV6HZ06+jzryGQ86Iel/IWBw7yy2wYvxOgkFkIT5unMlgPXFOEM
 cGxJyIWYfpBA67GmAK8xHWcLKCr+JNlMsKFgH/g=
X-Google-Smtp-Source: APXvYqxS/knyMK0Q2qTNc4qGHCSlme/wT9HglItm+jHKkch87wg3FgTv2f+kKLM9BLabPFV9lxqhB00VZXdjFZvMwvg=
X-Received: by 2002:a37:7443:: with SMTP id p64mr9711001qkc.460.1574366093297; 
 Thu, 21 Nov 2019 11:54:53 -0800 (PST)
MIME-Version: 1.0
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-2-mrolnik@gmail.com>
 <750745b9-e51c-3757-3eb6-ffce51042d9c@redhat.com>
 <CAK4993gtPkqESswLBoo1cMuvJFzwSVgUP=Oh-hpG2JSTKezjmw@mail.gmail.com>
In-Reply-To: <CAK4993gtPkqESswLBoo1cMuvJFzwSVgUP=Oh-hpG2JSTKezjmw@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu, 21 Nov 2019 21:53:57 +0200
Message-ID: <CAK4993iFuC3LTzkwjAx7uKA18jh-zOo5aYx2+1ugc9fw8UPtYg@mail.gmail.com>
Subject: Re: [PATCH v35 01/13] target/avr: Add outward facing interfaces and
 core CPU logic
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It seems to be a huge investment. this function should parse the
binary data as `decode_insn` does, so I suggest to modify decodetree
tool to make decoding information available to the instruction print
function.
what do you think?

On Thu, Nov 21, 2019 at 9:44 PM Michael Rolnik <mrolnik@gmail.com> wrote:
>
> On Thu, Nov 21, 2019 at 8:55 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > Hi Michael,
> >
> > On 10/29/19 10:24 PM, Michael Rolnik wrote:
> > > This includes:
> > > - CPU data structures
> > > - object model classes and functions
> > > - migration functions
> > > - GDB hooks
> > >
> > > Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
> > > Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> > > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > > Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> > > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > > Acked-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > >   gdb-xml/avr-cpu.xml    |  49 ++++
> > >   target/avr/cpu-param.h |  37 +++
> > >   target/avr/cpu-qom.h   |  54 ++++
> > >   target/avr/cpu.c       | 576 ++++++++++++++++++++++++++++++++++++++=
+++
> > >   target/avr/cpu.h       | 253 ++++++++++++++++++
> > >   target/avr/gdbstub.c   |  85 ++++++
> > >   target/avr/machine.c   | 121 +++++++++
> > >   7 files changed, 1175 insertions(+)
> > >   create mode 100644 gdb-xml/avr-cpu.xml
> > >   create mode 100644 target/avr/cpu-param.h
> > >   create mode 100644 target/avr/cpu-qom.h
> > >   create mode 100644 target/avr/cpu.c
> > >   create mode 100644 target/avr/cpu.h
> > >   create mode 100644 target/avr/gdbstub.c
> > >   create mode 100644 target/avr/machine.c
> > >
> > > diff --git a/gdb-xml/avr-cpu.xml b/gdb-xml/avr-cpu.xml
> > > new file mode 100644
> > > index 0000000000..c4747f5b40
> > > --- /dev/null
> > > +++ b/gdb-xml/avr-cpu.xml
> > > @@ -0,0 +1,49 @@
> > > +<?xml version=3D"1.0"?>
> > > +<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
> > > +
> > > +     Copying and distribution of this file, with or without modifica=
tion,
> > > +     are permitted in any medium without royalty provided the copyri=
ght
> > > +     notice and this notice are preserved.  -->
> > > +
> > > +<!-- Register numbers are hard-coded in order to maintain backward
> > > +     compatibility with older versions of tools that didn't use xml
> > > +     register descriptions.  -->
> > > +
> > > +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> > > +<feature name=3D"org.gnu.gdb.riscv.cpu">
> > > +  <reg name=3D"r0" bitsize=3D"8" type=3D"int" regnum=3D"0"/>
> > > +  <reg name=3D"r1" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r2" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r3" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r4" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r5" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r6" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r7" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r8" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r9" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r10" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r11" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r12" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r13" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r14" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r15" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r16" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r17" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r18" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r19" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r20" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r21" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r22" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r23" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r24" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r25" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r26" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r27" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r28" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r29" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r30" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"r31" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"sreg" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"sp" bitsize=3D"8" type=3D"int"/>
> > > +  <reg name=3D"pc" bitsize=3D"8" type=3D"int"/>
> > > +</feature>
> > > diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
> > > new file mode 100644
> > > index 0000000000..ccd1ea3429
> > > --- /dev/null
> > > +++ b/target/avr/cpu-param.h
> > > @@ -0,0 +1,37 @@
> > > +/*
> > > + * QEMU AVR CPU
> > > + *
> > > + * Copyright (c) 2019 Michael Rolnik
> > > + *
> > > + * This library is free software; you can redistribute it and/or
> > > + * modify it under the terms of the GNU Lesser General Public
> > > + * License as published by the Free Software Foundation; either
> > > + * version 2.1 of the License, or (at your option) any later version=
.
> > > + *
> > > + * This library is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > > + * Lesser General Public License for more details.
> > > + *
> > > + * You should have received a copy of the GNU Lesser General Public
> > > + * License along with this library; if not, see
> > > + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> > > + */
> > > +
> > > +#ifndef AVR_CPU_PARAM_H
> > > +#define AVR_CPU_PARAM_H 1
> > > +
> > > +#define TARGET_LONG_BITS 32
> > > +/*
> > > + * TARGET_PAGE_BITS cannot be more than 8 bits because
> > > + * 1.  all IO registers occupy [0x0000 .. 0x00ff] address range, and=
 they
> > > + *     should be implemented as a device and not memory
> > > + * 2.  SRAM starts at the address 0x0100
> > > + */
> > > +#define TARGET_PAGE_BITS 8
> > > +#define TARGET_PHYS_ADDR_SPACE_BITS 24
> > > +#define TARGET_VIRT_ADDR_SPACE_BITS 24
> > > +#define NB_MMU_MODES 2
> > > +
> > > +
> > > +#endif
> > > diff --git a/target/avr/cpu-qom.h b/target/avr/cpu-qom.h
> > > new file mode 100644
> > > index 0000000000..e28b58c897
> > > --- /dev/null
> > > +++ b/target/avr/cpu-qom.h
> > > @@ -0,0 +1,54 @@
> > > +/*
> > > + * QEMU AVR CPU
> > > + *
> > > + * Copyright (c) 2019 Michael Rolnik
> > > + *
> > > + * This library is free software; you can redistribute it and/or
> > > + * modify it under the terms of the GNU Lesser General Public
> > > + * License as published by the Free Software Foundation; either
> > > + * version 2.1 of the License, or (at your option) any later version=
.
> > > + *
> > > + * This library is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > > + * Lesser General Public License for more details.
> > > + *
> > > + * You should have received a copy of the GNU Lesser General Public
> > > + * License along with this library; if not, see
> > > + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> > > + */
> > > +
> > > +#ifndef QEMU_AVR_QOM_H
> > > +#define QEMU_AVR_QOM_H
> > > +
> > > +#include "hw/core/cpu.h"
> > > +
> > > +#define TYPE_AVR_CPU "avr-cpu"
> > > +
> > > +#define AVR_CPU_CLASS(klass) \
> > > +    OBJECT_CLASS_CHECK(AVRCPUClass, (klass), TYPE_AVR_CPU)
> > > +#define AVR_CPU(obj) \
> > > +    OBJECT_CHECK(AVRCPU, (obj), TYPE_AVR_CPU)
> > > +#define AVR_CPU_GET_CLASS(obj) \
> > > +    OBJECT_GET_CLASS(AVRCPUClass, (obj), TYPE_AVR_CPU)
> > > +
> > > +/**
> > > + *  AVRCPUClass:
> > > + *  @parent_realize: The parent class' realize handler.
> > > + *  @parent_reset: The parent class' reset handler.
> > > + *  @vr: Version Register value.
> > > + *
> > > + *  A AVR CPU model.
> > > + */
> > > +typedef struct AVRCPUClass {
> > > +    /*< private >*/
> > > +    CPUClass parent_class;
> > > +    /*< public >*/
> > > +    DeviceRealize parent_realize;
> > > +    void (*parent_reset)(CPUState *cpu);
> > > +} AVRCPUClass;
> > > +
> > > +typedef struct AVRCPU AVRCPU;
> > > +
> > > +
> > > +#endif /* !defined (QEMU_AVR_CPU_QOM_H) */
> > > diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> > > new file mode 100644
> > > index 0000000000..dae56d7845
> > > --- /dev/null
> > > +++ b/target/avr/cpu.c
> > > @@ -0,0 +1,576 @@
> > > +/*
> > > + * QEMU AVR CPU
> > > + *
> > > + * Copyright (c) 2019 Michael Rolnik
> > > + *
> > > + * This library is free software; you can redistribute it and/or
> > > + * modify it under the terms of the GNU Lesser General Public
> > > + * License as published by the Free Software Foundation; either
> > > + * version 2.1 of the License, or (at your option) any later version=
.
> > > + *
> > > + * This library is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > > + * Lesser General Public License for more details.
> > > + *
> > > + * You should have received a copy of the GNU Lesser General Public
> > > + * License along with this library; if not, see
> > > + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "qapi/error.h"
> > > +#include "qemu/qemu-print.h"
> > > +#include "exec/exec-all.h"
> > > +#include "cpu.h"
> > > +
> > > +static void avr_cpu_set_pc(CPUState *cs, vaddr value)
> > > +{
> > > +    AVRCPU *cpu =3D AVR_CPU(cs);
> > > +
> > > +    cpu->env.pc_w =3D value / 2; /* internally PC points to words */
> > > +}
> > > +
> > > +static bool avr_cpu_has_work(CPUState *cs)
> > > +{
> > > +    AVRCPU *cpu =3D AVR_CPU(cs);
> > > +    CPUAVRState *env =3D &cpu->env;
> > > +
> > > +    return (cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERR=
UPT_RESET))
> > > +            && cpu_interrupts_enabled(env);
> > > +}
> > > +
> > > +static void avr_cpu_synchronize_from_tb(CPUState *cs, TranslationBlo=
ck *tb)
> > > +{
> > > +    AVRCPU *cpu =3D AVR_CPU(cs);
> > > +    CPUAVRState *env =3D &cpu->env;
> > > +
> > > +    env->pc_w =3D tb->pc / 2; /* internally PC points to words */
> > > +}
> > > +
> > > +static void avr_cpu_reset(CPUState *cs)
> > > +{
> > > +    AVRCPU *cpu =3D AVR_CPU(cs);
> > > +    AVRCPUClass *mcc =3D AVR_CPU_GET_CLASS(cpu);
> > > +    CPUAVRState *env =3D &cpu->env;
> > > +
> > > +    mcc->parent_reset(cs);
> > > +
> > > +    env->pc_w =3D 0;
> > > +    env->sregI =3D 1;
> > > +    env->sregC =3D 0;
> > > +    env->sregZ =3D 0;
> > > +    env->sregN =3D 0;
> > > +    env->sregV =3D 0;
> > > +    env->sregS =3D 0;
> > > +    env->sregH =3D 0;
> > > +    env->sregT =3D 0;
> > > +
> > > +    env->rampD =3D 0;
> > > +    env->rampX =3D 0;
> > > +    env->rampY =3D 0;
> > > +    env->rampZ =3D 0;
> > > +    env->eind =3D 0;
> > > +    env->sp =3D 0;
> > > +
> > > +    env->skip =3D 0;
> > > +
> > > +    memset(env->r, 0, sizeof(env->r));
> > > +
> > > +    tlb_flush(cs);
> > > +}
> > > +
> > > +static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *=
info)
> > > +{
> > > +    info->mach =3D bfd_arch_avr;
> > > +    info->print_insn =3D NULL;
> >
> > Why not implement the dump_ASM code? This is very useful...
> >
> > Richard what is your position on this? I'd rather enforce this as a
> > requirement for each ports.
>
> Hi Philippe.
>
> I will, however it could be a functionality of the instruction parser.
>
> Regards,
> Michael
> >
> > > +}
> > > +
> > [...]
> >
>
>
> --
> Best Regards,
> Michael Rolnik



--=20
Best Regards,
Michael Rolnik

