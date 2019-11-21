Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1517AC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1C2820672
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVnz80OP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C2820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXrdB-0003W0-0h
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 13:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXrcF-0000O4-5I
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXrcD-000714-38
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:55:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44664
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXrcC-0006zu-V4
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574362540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B08qELK+Sz6+YxpGBV26NFXD5kVXMHwsiHQxqFrXoRc=;
 b=jVnz80OPUbGu//KOz3P1WJWU3hs28qJTi+1l0FRWlJVBcSH485EGDL91rYYX/cn639XoTC
 MGkVEX6Q3DEVPWoV3LFEwea9J1Z9sq9DQA6lKx/iH+XG9VpMLI+IJ0R5bQMUSWD0yMOuLX
 clzvoZs1pIir+hnYK436CJD+a0fXvXk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-_6BpcM3rPFuUTkK26Y3heQ-1; Thu, 21 Nov 2019 13:55:38 -0500
Received: by mail-wm1-f70.google.com with SMTP id l23so1168614wmh.6
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 10:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ANgvZL2HaZgsgg2M06EhD0lXNVjKj8IvcuhTeF0ckqU=;
 b=GAiJLtmwLHNE5G8IVgSjSpfdJ9r64qTCW3fpHnqv59Hqt+682PgqJu/YaP/s/Oj7QI
 20znbt+8i/gVGrWvHlT0AtQgmxGEint6KEdjHzyRLl94azd95bE9AZ8QK7OQF6NyuRjK
 XdYzE6cJY6CCWJcaxkaaVW/jFy2SHlmiL8UsSVcOctsPK7ivXGknVQh1wRYHB58kJLsH
 D1PAQaV4F7QD9tDxhuHYq5jKDTuq9ebC6cyu5NNyt5dlfpWHOZstwj166TzSkKGLyDgI
 SLPOONBR5mk/B1BeMI+rVZhDk9eWRwaqnuw2FmjgnHCf+Woj/QAvbB26z5W/tR2Q2iwN
 3obw==
X-Gm-Message-State: APjAAAVvfPheTayeS+oS/hRqc+FeYPxGGyr+0xfsRL37fwxsMCQ/cOLe
 rrWtPeb1uxC5V8Xa7DbCeP2MvcQQ6arQSob8l/ZFhRQIeP4rVghwJY7wX8pBL+f4uAoGPxTSYVY
 hv1ArvCbxCwwBD2I=
X-Received: by 2002:adf:f147:: with SMTP id y7mr12727400wro.236.1574362537333; 
 Thu, 21 Nov 2019 10:55:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqz+v8JW+DyfHkhnVp2GZwlwAgbAsFvJ2kEtYTDjunk6IhI/E8iJm7KIFlT01fiydqVSljh9zQ==
X-Received: by 2002:adf:f147:: with SMTP id y7mr12727359wro.236.1574362537039; 
 Thu, 21 Nov 2019 10:55:37 -0800 (PST)
Received: from [192.168.43.238] (92.red-95-127-154.staticip.rima-tde.net.
 [95.127.154.92])
 by smtp.gmail.com with ESMTPSA id t185sm596879wmf.45.2019.11.21.10.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2019 10:55:36 -0800 (PST)
Subject: Re: [PATCH v35 01/13] target/avr: Add outward facing interfaces and
 core CPU logic
To: Michael Rolnik <mrolnik@gmail.com>, richard.henderson@linaro.org
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-2-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <750745b9-e51c-3757-3eb6-ffce51042d9c@redhat.com>
Date: Thu, 21 Nov 2019 19:55:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191029212430.20617-2-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: _6BpcM3rPFuUTkK26Y3heQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>, thuth@redhat.com,
 qemu-devel@nongnu.org, dovgaluk@ispras.ru, imammedo@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

On 10/29/19 10:24 PM, Michael Rolnik wrote:
> This includes:
> - CPU data structures
> - object model classes and functions
> - migration functions
> - GDB hooks
>=20
> Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
> Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   gdb-xml/avr-cpu.xml    |  49 ++++
>   target/avr/cpu-param.h |  37 +++
>   target/avr/cpu-qom.h   |  54 ++++
>   target/avr/cpu.c       | 576 +++++++++++++++++++++++++++++++++++++++++
>   target/avr/cpu.h       | 253 ++++++++++++++++++
>   target/avr/gdbstub.c   |  85 ++++++
>   target/avr/machine.c   | 121 +++++++++
>   7 files changed, 1175 insertions(+)
>   create mode 100644 gdb-xml/avr-cpu.xml
>   create mode 100644 target/avr/cpu-param.h
>   create mode 100644 target/avr/cpu-qom.h
>   create mode 100644 target/avr/cpu.c
>   create mode 100644 target/avr/cpu.h
>   create mode 100644 target/avr/gdbstub.c
>   create mode 100644 target/avr/machine.c
>=20
> diff --git a/gdb-xml/avr-cpu.xml b/gdb-xml/avr-cpu.xml
> new file mode 100644
> index 0000000000..c4747f5b40
> --- /dev/null
> +++ b/gdb-xml/avr-cpu.xml
> @@ -0,0 +1,49 @@
> +<?xml version=3D"1.0"?>
> +<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification=
,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!-- Register numbers are hard-coded in order to maintain backward
> +     compatibility with older versions of tools that didn't use xml
> +     register descriptions.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name=3D"org.gnu.gdb.riscv.cpu">
> +  <reg name=3D"r0" bitsize=3D"8" type=3D"int" regnum=3D"0"/>
> +  <reg name=3D"r1" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r2" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r3" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r4" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r5" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r6" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r7" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r8" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r9" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r10" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r11" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r12" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r13" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r14" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r15" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r16" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r17" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r18" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r19" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r20" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r21" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r22" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r23" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r24" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r25" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r26" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r27" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r28" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r29" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r30" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"r31" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"sreg" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"sp" bitsize=3D"8" type=3D"int"/>
> +  <reg name=3D"pc" bitsize=3D"8" type=3D"int"/>
> +</feature>
> diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
> new file mode 100644
> index 0000000000..ccd1ea3429
> --- /dev/null
> +++ b/target/avr/cpu-param.h
> @@ -0,0 +1,37 @@
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
> +#ifndef AVR_CPU_PARAM_H
> +#define AVR_CPU_PARAM_H 1
> +
> +#define TARGET_LONG_BITS 32
> +/*
> + * TARGET_PAGE_BITS cannot be more than 8 bits because
> + * 1.  all IO registers occupy [0x0000 .. 0x00ff] address range, and the=
y
> + *     should be implemented as a device and not memory
> + * 2.  SRAM starts at the address 0x0100
> + */
> +#define TARGET_PAGE_BITS 8
> +#define TARGET_PHYS_ADDR_SPACE_BITS 24
> +#define TARGET_VIRT_ADDR_SPACE_BITS 24
> +#define NB_MMU_MODES 2
> +
> +
> +#endif
> diff --git a/target/avr/cpu-qom.h b/target/avr/cpu-qom.h
> new file mode 100644
> index 0000000000..e28b58c897
> --- /dev/null
> +++ b/target/avr/cpu-qom.h
> @@ -0,0 +1,54 @@
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
> +#ifndef QEMU_AVR_QOM_H
> +#define QEMU_AVR_QOM_H
> +
> +#include "hw/core/cpu.h"
> +
> +#define TYPE_AVR_CPU "avr-cpu"
> +
> +#define AVR_CPU_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(AVRCPUClass, (klass), TYPE_AVR_CPU)
> +#define AVR_CPU(obj) \
> +    OBJECT_CHECK(AVRCPU, (obj), TYPE_AVR_CPU)
> +#define AVR_CPU_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(AVRCPUClass, (obj), TYPE_AVR_CPU)
> +
> +/**
> + *  AVRCPUClass:
> + *  @parent_realize: The parent class' realize handler.
> + *  @parent_reset: The parent class' reset handler.
> + *  @vr: Version Register value.
> + *
> + *  A AVR CPU model.
> + */
> +typedef struct AVRCPUClass {
> +    /*< private >*/
> +    CPUClass parent_class;
> +    /*< public >*/
> +    DeviceRealize parent_realize;
> +    void (*parent_reset)(CPUState *cpu);
> +} AVRCPUClass;
> +
> +typedef struct AVRCPU AVRCPU;
> +
> +
> +#endif /* !defined (QEMU_AVR_CPU_QOM_H) */
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> new file mode 100644
> index 0000000000..dae56d7845
> --- /dev/null
> +++ b/target/avr/cpu.c
> @@ -0,0 +1,576 @@
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
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/qemu-print.h"
> +#include "exec/exec-all.h"
> +#include "cpu.h"
> +
> +static void avr_cpu_set_pc(CPUState *cs, vaddr value)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(cs);
> +
> +    cpu->env.pc_w =3D value / 2; /* internally PC points to words */
> +}
> +
> +static bool avr_cpu_has_work(CPUState *cs)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(cs);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    return (cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_=
RESET))
> +            && cpu_interrupts_enabled(env);
> +}
> +
> +static void avr_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *=
tb)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(cs);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    env->pc_w =3D tb->pc / 2; /* internally PC points to words */
> +}
> +
> +static void avr_cpu_reset(CPUState *cs)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(cs);
> +    AVRCPUClass *mcc =3D AVR_CPU_GET_CLASS(cpu);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    mcc->parent_reset(cs);
> +
> +    env->pc_w =3D 0;
> +    env->sregI =3D 1;
> +    env->sregC =3D 0;
> +    env->sregZ =3D 0;
> +    env->sregN =3D 0;
> +    env->sregV =3D 0;
> +    env->sregS =3D 0;
> +    env->sregH =3D 0;
> +    env->sregT =3D 0;
> +
> +    env->rampD =3D 0;
> +    env->rampX =3D 0;
> +    env->rampY =3D 0;
> +    env->rampZ =3D 0;
> +    env->eind =3D 0;
> +    env->sp =3D 0;
> +
> +    env->skip =3D 0;
> +
> +    memset(env->r, 0, sizeof(env->r));
> +
> +    tlb_flush(cs);
> +}
> +
> +static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *info=
)
> +{
> +    info->mach =3D bfd_arch_avr;
> +    info->print_insn =3D NULL;

Why not implement the dump_ASM code? This is very useful...

Richard what is your position on this? I'd rather enforce this as a=20
requirement for each ports.

> +}
> +
[...]


