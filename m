Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79EBC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:55:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4EE20702
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMRV8cT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4EE20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw0Ar-0004X7-Dk
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 03:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iw09v-0003s0-Ox
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:54:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iw09l-00031s-IJ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:54:15 -0500
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:40397)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>)
 id 1iw09l-00031I-7k; Mon, 27 Jan 2020 03:54:05 -0500
Received: by mail-qk1-x741.google.com with SMTP id t204so8024231qke.7;
 Mon, 27 Jan 2020 00:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TBumeDI4hC/TGqikiJa5qZ4R9WcSR1KOzr5cqR2iiA8=;
 b=QMRV8cT5uPCuXnt/ZS8xTai3aNAMrgGh0ilbBf+N6JtoGkJKZQAoGsye8yD7EzQ/X9
 buzM66eH5neWlaZLnxu0JdaASppyNC/+6qoPJbyIS5hYmb16PapeiayJp3Qsx3MGaoaV
 G4KhH1EvfEyrM+O6Z1OhnUTg8/JNendU0YkS9G8RvqJgUINk3edrtstfEupLUhRyH7l4
 KJ9/Um+DR+i3z8uvQ23Jh8GIXu99Y6CV9d9KJ4L8e3YU/lCFqHhrdrCN9CgEsNNf81dZ
 V1qMXuJzJ8rx/W8OOp7+HRBHWeVRjJMVyGQgpd002Fcu7z8Hel1IPDmVRDujAor2zk2b
 kTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TBumeDI4hC/TGqikiJa5qZ4R9WcSR1KOzr5cqR2iiA8=;
 b=YDw2+2DBCCPlwXh+WhDd1TgsoW39lN7LrUSgswSgSOXxzLd2p1DJ1lEpM32WZSUXQp
 81P9CVTqWnuM8d1ksdRuEfS/A6jB+EpvLdeLPcOoLI8X37ePo6dV34Hm7wC+rj89dFt3
 7CHOEBoXiKMvazRGJVNHmSPYm58zOCxeS5IIK/cRB+O2lrMzgCDvEjImhU3PWhi0Mem+
 ykeSU8t1RiviKmuSq5DGt+pM4fhf3UAOl+sAJCadStlvbFRUdnwm/tPrFoCHEjjNOFPd
 uybcbzPa1FQdUuDZe4DiAJ4Ql3feBqmSG1hOR5iO841tH1OWenG/BXrfHODjxwDGyy+y
 u8Kw==
X-Gm-Message-State: APjAAAVTOkVhruZPzVT7iwn8IvsQbguyvpaMbXWg/r5lgfyxMls6WTom
 /nxqfs0Oht7J4sWletGkzFOKoL0DkyvGl1r1pey+PH/PQhy3878n
X-Google-Smtp-Source: APXvYqxNffQQGVMFK6hda5oKOnlyb9+EHuz5ZEkBTKJGwZNvw1CY5VaAkky5SL38A/7OpbYQnOhtCmsyKt9WWDtFGm8=
X-Received: by 2002:ae9:ea08:: with SMTP id f8mr14391002qkg.489.1580115244212; 
 Mon, 27 Jan 2020 00:54:04 -0800 (PST)
MIME-Version: 1.0
References: <20200124005131.16276-1-f4bug@amsat.org>
 <20200124005131.16276-2-f4bug@amsat.org>
 <7ae1607e-060e-23ac-f651-8f2ace8991ba@xcancerberox.com.ar>
In-Reply-To: <7ae1607e-060e-23ac-f651-8f2ace8991ba@xcancerberox.com.ar>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 27 Jan 2020 10:53:20 +0200
Message-ID: <CAK4993iH77DfpHQbNNR41C=rJy2M+uHDNMuof6Fq7ofhMtB9hw@mail.gmail.com>
Subject: Re: [PATCH rc2 01/25] target/avr: Add outward facing interfaces and
 core CPU logic
To: Joaquin de Andres <me@xcancerberox.com.ar>
Content-Type: multipart/alternative; boundary="000000000000d5e7f8059d1b3fd1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d5e7f8059d1b3fd1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joaquin.

`AVR_FEATURE_1_BYTE_PC` is used in `gen_push_ret` function
(target/avr/translate.c)

Regards,
Michael Rolnik

On Sun, Jan 26, 2020 at 2:15 PM Joaquin de Andres <me@xcancerberox.com.ar>
wrote:

> Hi! In this mail I only checked the general code and one of the listed
> features for the different types of avr. I will check the rest in
> following emails.
>
> On 1/24/20 1:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > From: Michael Rolnik <mrolnik@gmail.com>
> >
> > This includes:
> > - CPU data structures
> > - object model classes and functions
> > - migration functions
> > - GDB hooks
> >
> > Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
> > Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > Acked-by: Igor Mammedov <imammedo@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Message-Id: <20200118191416.19934-2-mrolnik@gmail.com>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  target/avr/cpu-param.h |  37 ++
> >  target/avr/cpu-qom.h   |  54 +++
> >  target/avr/cpu.h       | 258 +++++++++++++
> >  target/avr/cpu.c       | 826 +++++++++++++++++++++++++++++++++++++++++
> >  target/avr/gdbstub.c   |  84 +++++
> >  target/avr/machine.c   | 121 ++++++
> >  gdb-xml/avr-cpu.xml    |  49 +++
> >  7 files changed, 1429 insertions(+)
> >  create mode 100644 target/avr/cpu-param.h
> >  create mode 100644 target/avr/cpu-qom.h
> >  create mode 100644 target/avr/cpu.h
> >  create mode 100644 target/avr/cpu.c
> >  create mode 100644 target/avr/gdbstub.c
> >  create mode 100644 target/avr/machine.c
> >  create mode 100644 gdb-xml/avr-cpu.xml
> >
> > diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
> > new file mode 100644
> > index 0000000000..0c29ce4223
> > --- /dev/null
> > +++ b/target/avr/cpu-param.h
> > @@ -0,0 +1,37 @@
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
> > +#ifndef AVR_CPU_PARAM_H
> > +#define AVR_CPU_PARAM_H
> > +
> > +#define TARGET_LONG_BITS 32
> > +/*
> > + * TARGET_PAGE_BITS cannot be more than 8 bits because
> > + * 1.  all IO registers occupy [0x0000 .. 0x00ff] address range, and
> they
> > + *     should be implemented as a device and not memory
> > + * 2.  SRAM starts at the address 0x0100
> > + */
> > +#define TARGET_PAGE_BITS 8
> > +#define TARGET_PHYS_ADDR_SPACE_BITS 24
> > +#define TARGET_VIRT_ADDR_SPACE_BITS 24
> > +#define NB_MMU_MODES 2
> > +
> > +
> > +#endif
> > diff --git a/target/avr/cpu-qom.h b/target/avr/cpu-qom.h
> > new file mode 100644
> > index 0000000000..e28b58c897
> > --- /dev/null
> > +++ b/target/avr/cpu-qom.h
> > @@ -0,0 +1,54 @@
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
> > +#ifndef QEMU_AVR_QOM_H
> > +#define QEMU_AVR_QOM_H
> > +
> > +#include "hw/core/cpu.h"
> > +
> > +#define TYPE_AVR_CPU "avr-cpu"
> > +
> > +#define AVR_CPU_CLASS(klass) \
> > +    OBJECT_CLASS_CHECK(AVRCPUClass, (klass), TYPE_AVR_CPU)
> > +#define AVR_CPU(obj) \
> > +    OBJECT_CHECK(AVRCPU, (obj), TYPE_AVR_CPU)
> > +#define AVR_CPU_GET_CLASS(obj) \
> > +    OBJECT_GET_CLASS(AVRCPUClass, (obj), TYPE_AVR_CPU)
> > +
> > +/**
> > + *  AVRCPUClass:
> > + *  @parent_realize: The parent class' realize handler.
> > + *  @parent_reset: The parent class' reset handler.
> > + *  @vr: Version Register value.
> > + *
> > + *  A AVR CPU model.
> > + */
> > +typedef struct AVRCPUClass {
> > +    /*< private >*/
> > +    CPUClass parent_class;
> > +    /*< public >*/
> > +    DeviceRealize parent_realize;
> > +    void (*parent_reset)(CPUState *cpu);
> > +} AVRCPUClass;
> > +
> > +typedef struct AVRCPU AVRCPU;
> > +
> > +
> > +#endif /* !defined (QEMU_AVR_CPU_QOM_H) */
> > diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> > new file mode 100644
> > index 0000000000..b74bcf01ae
> > --- /dev/null
> > +++ b/target/avr/cpu.h
> > @@ -0,0 +1,258 @@
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
> > +#ifndef QEMU_AVR_CPU_H
> > +#define QEMU_AVR_CPU_H
> > +
> > +#include "cpu-qom.h"
> > +#include "exec/cpu-defs.h"
> > +
> > +#define TCG_GUEST_DEFAULT_MO 0
> > +#define AVR_CPU_TYPE_SUFFIX "-" TYPE_AVR_CPU
> > +#define AVR_CPU_TYPE_NAME(name) (name AVR_CPU_TYPE_SUFFIX)
> > +#define CPU_RESOLVING_TYPE TYPE_AVR_CPU
> > +
> > +/*
> > + * AVR has two memory spaces, data & code.
> > + * e.g. both have 0 address
> > + * ST/LD instructions access data space
> > + * LPM/SPM and instruction fetching access code memory space
> > + */
> > +#define MMU_CODE_IDX 0
> > +#define MMU_DATA_IDX 1
> > +
> > +#define EXCP_RESET 1
> > +#define EXCP_INT(n) (EXCP_RESET + (n) + 1)
> > +
> > +/* Number of CPU registers */
> > +#define NUMBER_OF_CPU_REGISTERS 32
> > +/* Number of IO registers accessible by ld/st/in/out */
> > +#define NUMBER_OF_IO_REGISTERS 64
> > +
> > +/*
> > + * Offsets of AVR memory regions in host memory space.
> > + *
> > + * This is needed because the AVR has separate code and data address
> > + * spaces that both have start from zero but have to go somewhere in
> > + * host memory.
> > + *
> > + * It's also useful to know where some things are, like the IO
> registers.
> > + */
> > +/* Flash program memory */
> > +#define OFFSET_CODE 0x00000000
> > +/* CPU registers, IO registers, and SRAM */
> > +#define OFFSET_DATA 0x00800000
> > +/* CPU registers specifically, these are mapped at the start of data *=
/
> > +#define OFFSET_CPU_REGISTERS OFFSET_DATA
> > +/*
> > + * IO registers, including status register, stack pointer, and memory
> > + * mapped peripherals, mapped just after CPU registers
> > + */
> > +#define OFFSET_IO_REGISTERS (OFFSET_DATA + NUMBER_OF_CPU_REGISTERS)
> > +
> > +#define EF_AVR_MACH 0x7F
> > +
> > +typedef enum AVRFeature {
> > +    AVR_FEATURE_SRAM,
> > +
> > +    AVR_FEATURE_1_BYTE_PC,
> > +    AVR_FEATURE_2_BYTE_PC,
> > +    AVR_FEATURE_3_BYTE_PC,
> > +
> > +    AVR_FEATURE_1_BYTE_SP,
> > +    AVR_FEATURE_2_BYTE_SP,
> > +
> > +    AVR_FEATURE_BREAK,
> > +    AVR_FEATURE_DES,
> > +    AVR_FEATURE_RMW, /* Read Modify Write - XCH LAC LAS LAT */
> > +
> > +    AVR_FEATURE_EIJMP_EICALL,
> > +    AVR_FEATURE_IJMP_ICALL,
> > +    AVR_FEATURE_JMP_CALL,
> > +
> > +    AVR_FEATURE_ADIW_SBIW,
> > +
> > +    AVR_FEATURE_SPM,
> > +    AVR_FEATURE_SPMX,
> > +
> > +    AVR_FEATURE_ELPMX,
> > +    AVR_FEATURE_ELPM,
> > +    AVR_FEATURE_LPMX,
> > +    AVR_FEATURE_LPM,
> > +
> > +    AVR_FEATURE_MOVW,
> > +    AVR_FEATURE_MUL,
> > +    AVR_FEATURE_RAMPD,
> > +    AVR_FEATURE_RAMPX,
> > +    AVR_FEATURE_RAMPY,
> > +    AVR_FEATURE_RAMPZ,
> > +} AVRFeature;
> > +
> > +typedef struct CPUAVRState CPUAVRState;
> > +
> > +struct CPUAVRState {
> > +    uint32_t pc_w; /* 0x003fffff up to 22 bits */
> > +
> > +    uint32_t sregC; /* 0x00000001 1 bit */
> > +    uint32_t sregZ; /* 0x00000001 1 bit */
> > +    uint32_t sregN; /* 0x00000001 1 bit */
> > +    uint32_t sregV; /* 0x00000001 1 bit */
> > +    uint32_t sregS; /* 0x00000001 1 bit */
> > +    uint32_t sregH; /* 0x00000001 1 bit */
> > +    uint32_t sregT; /* 0x00000001 1 bit */
> > +    uint32_t sregI; /* 0x00000001 1 bit */
> > +
> > +    uint32_t rampD; /* 0x00ff0000 8 bits */
> > +    uint32_t rampX; /* 0x00ff0000 8 bits */
> > +    uint32_t rampY; /* 0x00ff0000 8 bits */
> > +    uint32_t rampZ; /* 0x00ff0000 8 bits */
> > +    uint32_t eind; /* 0x00ff0000 8 bits */
> > +
> > +    uint32_t r[NUMBER_OF_CPU_REGISTERS]; /* 8 bits each */
> > +    uint32_t sp; /* 16 bits */
> > +
> > +    uint32_t skip; /* if set skip instruction */
> > +
> > +    uint64_t intsrc; /* interrupt sources */
> > +    bool fullacc; /* CPU/MEM if true MEM only otherwise */
> > +
> > +    uint32_t features;
> > +};
>
> Why not use 'uint8_t' for all sreg bits, ramps, eind and user registers,
> and bool for skip flag?
>
> > +
> > +/**
> > + *  AVRCPU:
> > + *  @env: #CPUAVRState
> > + *
> > + *  A AVR CPU.
> > + */
> > +typedef struct AVRCPU {
> > +    /*< private >*/
> > +    CPUState parent_obj;
> > +    /*< public >*/
> > +
> > +    CPUNegativeOffsetState neg;
> > +    CPUAVRState env;
> > +} AVRCPU;
> > +
> > +#ifndef CONFIG_USER_ONLY
> > +extern const struct VMStateDescription vms_avr_cpu;
> > +#endif
> > +
> > +void avr_cpu_do_interrupt(CPUState *cpu);
> > +bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
> > +hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> > +int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
> > +int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> > +
> > +static inline int avr_feature(CPUAVRState *env, AVRFeature feature)
> > +{
> > +    return (env->features & (1U << feature)) !=3D 0;
> > +}
> > +
> > +static inline void avr_set_feature(CPUAVRState *env, int feature)
> > +{
> > +    env->features |=3D (1U << feature);
> > +}
> > +
> > +#define cpu_list avr_cpu_list
> > +#define cpu_signal_handler cpu_avr_signal_handler
> > +#define cpu_mmu_index avr_cpu_mmu_index
> > +
> > +static inline int avr_cpu_mmu_index(CPUAVRState *env, bool ifetch)
> > +{
> > +    return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
> > +}
> > +
> > +void avr_cpu_tcg_init(void);
> > +
> > +void avr_cpu_list(void);
> > +int cpu_avr_exec(CPUState *cpu);
> > +int cpu_avr_signal_handler(int host_signum, void *pinfo, void *puc);
> > +int avr_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
> > +                                int rw, int mmu_idx);
> > +int avr_cpu_memory_rw_debug(CPUState *cs, vaddr address, uint8_t *buf,
> > +                                int len, bool is_write);
> > +
> > +enum {
> > +    TB_FLAGS_FULL_ACCESS =3D 1,
> > +    TB_FLAGS_SKIP =3D 2,
> > +};
> > +
> > +static inline void cpu_get_tb_cpu_state(CPUAVRState *env, target_ulong
> *pc,
> > +                                target_ulong *cs_base, uint32_t *pflag=
s)
> > +{
> > +    uint32_t flags =3D 0;
> > +
> > +    *pc =3D env->pc_w * 2;
> > +    *cs_base =3D 0;
> > +
> > +    if (env->fullacc) {
> > +        flags |=3D TB_FLAGS_FULL_ACCESS;
> > +    }
> > +    if (env->skip) {
> > +        flags |=3D TB_FLAGS_SKIP;
> > +    }
> > +
> > +    *pflags =3D flags;
> > +}
> > +
> > +static inline int cpu_interrupts_enabled(CPUAVRState *env)
> > +{
> > +    return env->sregI !=3D 0;
> > +}
> > +
> > +static inline uint8_t cpu_get_sreg(CPUAVRState *env)
> > +{
> > +    uint8_t sreg;
> > +    sreg =3D (env->sregC) << 0
> > +         | (env->sregZ) << 1
> > +         | (env->sregN) << 2
> > +         | (env->sregV) << 3
> > +         | (env->sregS) << 4
> > +         | (env->sregH) << 5
> > +         | (env->sregT) << 6
> > +         | (env->sregI) << 7;
> > +    return sreg;
> > +}
> > +
> > +static inline void cpu_set_sreg(CPUAVRState *env, uint8_t sreg)
> > +{
> > +    env->sregC =3D (sreg >> 0) & 0x01;
> > +    env->sregZ =3D (sreg >> 1) & 0x01;
> > +    env->sregN =3D (sreg >> 2) & 0x01;
> > +    env->sregV =3D (sreg >> 3) & 0x01;
> > +    env->sregS =3D (sreg >> 4) & 0x01;
> > +    env->sregH =3D (sreg >> 5) & 0x01;
> > +    env->sregT =3D (sreg >> 6) & 0x01;
> > +    env->sregI =3D (sreg >> 7) & 0x01;
> > +}
> > +
> > +bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> > +                        MMUAccessType access_type, int mmu_idx,
> > +                        bool probe, uintptr_t retaddr);
> > +
> > +typedef CPUAVRState CPUArchState;
> > +typedef AVRCPU ArchCPU;
> > +
> > +#include "exec/cpu-all.h"
> > +
> > +const char *avr_flags_to_cpu_type(uint32_t flags, const char
> *def_cpu_type);
> > +
> > +#endif /* !defined (QEMU_AVR_CPU_H) */
> > diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> > new file mode 100644
> > index 0000000000..c74c5106fe
> > --- /dev/null
> > +++ b/target/avr/cpu.c
> > @@ -0,0 +1,826 @@
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
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qemu/qemu-print.h"
> > +#include "exec/exec-all.h"
> > +#include "cpu.h"
> > +#include "disas/dis-asm.h"
> > +
> > +static void avr_cpu_set_pc(CPUState *cs, vaddr value)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(cs);
> > +
> > +    cpu->env.pc_w =3D value / 2; /* internally PC points to words */
> > +}
>
> Isn't it safer to add 'assert(!(value % 2))' before this call?
>
> > +
> > +static bool avr_cpu_has_work(CPUState *cs)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(cs);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    return (cs->interrupt_request & (CPU_INTERRUPT_HARD |
> CPU_INTERRUPT_RESET))
> > +            && cpu_interrupts_enabled(env);
> > +}
> > +
> > +static void avr_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock
> *tb)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(cs);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    env->pc_w =3D tb->pc / 2; /* internally PC points to words */
>
> Same that above.
>
> > +}> +
> > +static void avr_cpu_reset(CPUState *cs)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(cs);
> > +    AVRCPUClass *mcc =3D AVR_CPU_GET_CLASS(cpu);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    mcc->parent_reset(cs);
> > +
> > +    env->pc_w =3D 0;
> > +    env->sregI =3D 1;
> > +    env->sregC =3D 0;
> > +    env->sregZ =3D 0;
> > +    env->sregN =3D 0;
> > +    env->sregV =3D 0;
> > +    env->sregS =3D 0;
> > +    env->sregH =3D 0;
> > +    env->sregT =3D 0;
> > +
> > +    env->rampD =3D 0;
> > +    env->rampX =3D 0;
> > +    env->rampY =3D 0;
> > +    env->rampZ =3D 0;
> > +    env->eind =3D 0;
> > +    env->sp =3D 0;
> > +
> > +    env->skip =3D 0;
> > +
> > +    memset(env->r, 0, sizeof(env->r));
> > +
> > +    tlb_flush(cs);
> > +}
> > +
> > +static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info
> *info)
> > +{
> > +    info->mach =3D bfd_arch_avr;
> > +    info->print_insn =3D NULL;
> > +}
> > +
> > +static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
> > +{
> > +    CPUState *cs =3D CPU(dev);
> > +    AVRCPUClass *mcc =3D AVR_CPU_GET_CLASS(dev);
> > +    Error *local_err =3D NULL;
> > +
> > +    cpu_exec_realizefn(cs, &local_err);
> > +    if (local_err !=3D NULL) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +    qemu_init_vcpu(cs);
> > +    cpu_reset(cs);
> > +
> > +    mcc->parent_realize(dev, errp);
> > +}
> > +
> > +static void avr_cpu_set_int(void *opaque, int irq, int level)
> > +{
> > +    AVRCPU *cpu =3D opaque;
> > +    CPUAVRState *env =3D &cpu->env;
> > +    CPUState *cs =3D CPU(cpu);
> > +
> > +    uint64_t mask =3D (1ull << irq);
> > +    if (level) {
> > +        env->intsrc |=3D mask;
> > +        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> > +    } else {
> > +        env->intsrc &=3D ~mask;
> > +        if (env->intsrc =3D=3D 0) {
> > +            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> > +        }
> > +    }
> > +}
> > +
> > +static void avr_cpu_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +
> > +    cpu_set_cpustate_pointers(cpu);
> > +
> > +#ifndef CONFIG_USER_ONLY
> > +    /* Set the number of interrupts supported by the CPU. */
> > +    qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int,
> > +            sizeof(cpu->env.intsrc) * 8);
> > +#endif
> > +}
> > +
> > +static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
> > +{
> > +    ObjectClass *oc;
> > +
> > +    oc =3D object_class_by_name(cpu_model);
> > +    if (object_class_dynamic_cast(oc, TYPE_AVR_CPU) =3D=3D NULL ||
> > +        object_class_is_abstract(oc)) {
> > +        oc =3D NULL;
> > +    }
> > +    return oc;
> > +}
> > +
> > +static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(cs);
> > +    CPUAVRState *env =3D &cpu->env;
> > +    int i;
> > +
> > +    qemu_fprintf(f, "\n");
> > +    qemu_fprintf(f, "PC:    %06x\n", env->pc_w);
> > +    qemu_fprintf(f, "SP:      %04x\n", env->sp);
> > +    qemu_fprintf(f, "rampD:     %02x\n", env->rampD >> 16);
> > +    qemu_fprintf(f, "rampX:     %02x\n", env->rampX >> 16);
> > +    qemu_fprintf(f, "rampY:     %02x\n", env->rampY >> 16);
> > +    qemu_fprintf(f, "rampZ:     %02x\n", env->rampZ >> 16);
> > +    qemu_fprintf(f, "EIND:      %02x\n", env->eind >> 16);
> > +    qemu_fprintf(f, "X:       %02x%02x\n", env->r[27], env->r[26]);
> > +    qemu_fprintf(f, "Y:       %02x%02x\n", env->r[29], env->r[28]);
> > +    qemu_fprintf(f, "Z:       %02x%02x\n", env->r[31], env->r[30]);
> > +    qemu_fprintf(f, "SREG:    [ %c %c %c %c %c %c %c %c ]\n",
> > +                        env->sregI ? 'I' : '-',
> > +                        env->sregT ? 'T' : '-',
> > +                        env->sregH ? 'H' : '-',
> > +                        env->sregS ? 'S' : '-',
> > +                        env->sregV ? 'V' : '-',
> > +                        env->sregN ? '-' : 'N', /* Zf has negative
> logic */
> > +                        env->sregZ ? 'Z' : '-',
> > +                        env->sregC ? 'I' : '-');
> > +    qemu_fprintf(f, "SKIP:    %02x\n", env->skip);
> > +
> > +    qemu_fprintf(f, "\n");
> > +    for (i =3D 0; i < ARRAY_SIZE(env->r); i++) {
> > +        qemu_fprintf(f, "R[%02d]:  %02x   ", i, env->r[i]);
> > +
> > +        if ((i % 8) =3D=3D 7) {
> > +            qemu_fprintf(f, "\n");
> > +        }
> > +    }
> > +    qemu_fprintf(f, "\n");
> > +}
> > +
> > +static void avr_cpu_class_init(ObjectClass *oc, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> > +    CPUClass *cc =3D CPU_CLASS(oc);
> > +    AVRCPUClass *mcc =3D AVR_CPU_CLASS(oc);
> > +
> > +    mcc->parent_realize =3D dc->realize;
> > +    dc->realize =3D avr_cpu_realizefn;
> > +
> > +    mcc->parent_reset =3D cc->reset;
> > +    cc->reset =3D avr_cpu_reset;
> > +
> > +    cc->class_by_name =3D avr_cpu_class_by_name;
> > +
> > +    cc->has_work =3D avr_cpu_has_work;
> > +    cc->do_interrupt =3D avr_cpu_do_interrupt;
> > +    cc->cpu_exec_interrupt =3D avr_cpu_exec_interrupt;
> > +    cc->dump_state =3D avr_cpu_dump_state;
> > +    cc->set_pc =3D avr_cpu_set_pc;
> > +#if !defined(CONFIG_USER_ONLY)
> > +    cc->memory_rw_debug =3D avr_cpu_memory_rw_debug;
> > +#endif
> > +#ifdef CONFIG_USER_ONLY
> > +    cc->handle_mmu_fault =3D avr_cpu_handle_mmu_fault;
> > +#else
> > +    cc->get_phys_page_debug =3D avr_cpu_get_phys_page_debug;
> > +    cc->vmsd =3D &vms_avr_cpu;
> > +#endif
> > +    cc->disas_set_info =3D avr_cpu_disas_set_info;
> > +    cc->tlb_fill =3D avr_cpu_tlb_fill;
> > +    cc->tcg_initialize =3D avr_cpu_tcg_init;
> > +    cc->synchronize_from_tb =3D avr_cpu_synchronize_from_tb;
> > +    cc->gdb_read_register =3D avr_cpu_gdb_read_register;
> > +    cc->gdb_write_register =3D avr_cpu_gdb_write_register;
> > +    cc->gdb_num_core_regs =3D 35;
> > +    cc->gdb_core_xml_file =3D "avr-cpu.xml";
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type avr1
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * at90s1200, attiny11, attiny12, attiny15, attiny28
> > + */
> > +static void avr_avr1_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>
> Checking features with the datasheet of the listed microcontroller I saw
> that the stack is a 3 level deep hardware stack dedicated to subroutines
> and interrupts.
> Why is the feature 2_BYTE_SP active?
>
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type avr2
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * at90s2313, at90s2323, at90s2333, at90s2343, attiny22, attiny26,
> at90s4414,
> > + * at90s4433, at90s4434, at90s8515, at90c8534, at90s8535
> > + */
> > +static void avr_avr2_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>
> Same. This microcontrollers (only checked with at90s2313 datasheet) use
> only SPL, why is the 2_BYTE_SP feature active?
>
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type avr25
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * ata5272, ata6616c, attiny13, attiny13a, attiny2313, attiny2313a,
> attiny24,
> > + * attiny24a, attiny4313, attiny44, attiny44a, attiny441, attiny84,
> attiny84a,
> > + * attiny25, attiny45, attiny85, attiny261, attiny261a, attiny461,
> attiny461a,
> > + * attiny861, attiny861a, attiny43u, attiny87, attiny48, attiny88,
> attiny828,
> > + * attiny841, at86rf401
> > + */
> > +static void avr_avr25_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>
> Same. This microcontrollers (only checked with attiny13 datasheet) use
> only SPL, why is the 2_BYTE_SP feature active?
>
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type avr3
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * at43usb355, at76c711
> > + */
> > +static void avr_avr3_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>
> Ok. Checked with at43usb355 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type avr31
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * atmega103, at43usb320
> > + */
> > +static void avr_avr31_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>
> Ok. Checked with atmega103 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type avr35
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * ata5505, ata6617c, ata664251, at90usb82, at90usb162, atmega8u2,
> atmega16u2,
> > + * atmega32u2, attiny167, attiny1634
> > + */
> > +static void avr_avr35_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>
> Ok. Checked with atmega8u2 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type avr4
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * ata6285, ata6286, ata6289, ata6612c, atmega8, atmega8a, atmega48,
> atmega48a,
> > + * atmega48p, atmega48pa, atmega48pb, atmega88, atmega88a, atmega88p,
> > + * atmega88pa, atmega88pb, atmega8515, atmega8535, atmega8hva, at90pwm=
1,
> > + * at90pwm2, at90pwm2b, at90pwm3, at90pwm3b, at90pwm81
> > + */
> > +static void avr_avr4_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>
> Ok. Checked with atmega8 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type avr5
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * ata5702m322, ata5782, ata5790, ata5790n, ata5791, ata5795, ata5831,
> ata6613c,
> > + * ata6614q, ata8210, ata8510, atmega16, atmega16a, atmega161,
> atmega162,
> > + * atmega163, atmega164a, atmega164p, atmega164pa, atmega165,
> atmega165a,
> > + * atmega165p, atmega165pa, atmega168, atmega168a, atmega168p,
> atmega168pa,
> > + * atmega168pb, atmega169, atmega169a, atmega169p, atmega169pa,
> atmega16hvb,
> > + * atmega16hvbrevb, atmega16m1, atmega16u4, atmega32a, atmega32,
> atmega323,
> > + * atmega324a, atmega324p, atmega324pa, atmega325, atmega325a,
> atmega325p,
> > + * atmega325pa, atmega3250, atmega3250a, atmega3250p, atmega3250pa,
> atmega328,
> > + * atmega328p, atmega328pb, atmega329, atmega329a, atmega329p,
> atmega329pa,
> > + * atmega3290, atmega3290a, atmega3290p, atmega3290pa, atmega32c1,
> atmega32m1,
> > + * atmega32u4, atmega32u6, atmega406, atmega64, atmega64a, atmega640,
> atmega644,
> > + * atmega644a, atmega644p, atmega644pa, atmega645, atmega645a,
> atmega645p,
> > + * atmega6450, atmega6450a, atmega6450p, atmega649, atmega649a,
> atmega649p,
> > + * atmega6490, atmega16hva, atmega16hva2, atmega32hvb, atmega6490a,
> atmega6490p,
> > + * atmega64c1, atmega64m1, atmega64hve, atmega64hve2, atmega64rfr2,
> > + * atmega644rfr2, atmega32hvbrevb, at90can32, at90can64, at90pwm161,
> at90pwm216,
> > + * at90pwm316, at90scr100, at90usb646, at90usb647, at94k, m3000
> > + */
> > +static void avr_avr5_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>
> Ok. Checked with atmega64 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type avr51
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * atmega128, atmega128a, atmega1280, atmega1281, atmega1284,
> atmega1284p,
> > + * atmega128rfa1, atmega128rfr2, atmega1284rfr2, at90can128,
> at90usb1286,
> > + * at90usb1287
> > + */
> > +static void avr_avr51_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>
> Ok. Checked with atmega128 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type avr6
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * atmega2560, atmega2561, atmega256rfr2, atmega2564rfr2
> > + */
> > +static void avr_avr6_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>
> Ok. Checked with atmega2560 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type avrtiny
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * attiny4, attiny5, attiny9, attiny10, attiny20, attiny40
> > + */
> > +static void avr_avrtiny_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_1_BYTE_SP);
>
> The attiny4 datasheet writes:
> "The AVR stack pointer is implemented as two 8-bit registers in the I/O
> space. The number of bits actually used is implementation dependent."
> Not using AVR_FEATURE_2_BYTE_SP isn't leaving out the ones with two
> bytes SP?
>
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type xmega2
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * atxmega8e5, atxmega16a4, atxmega16d4, atxmega16e5, atxmega32a4,
> atxmega32c3,
> > + * atxmega32d3, atxmega32d4, atxmega16a4u, atxmega16c4, atxmega32a4u,
> > + * atxmega32c4, atxmega32e5
> > + */
> > +static void avr_xmega2_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>
> Ok. Checked with atxmega8e5 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type xmega3
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * attiny212, attiny214, attiny412, attiny414, attiny416, attiny417,
> attiny814,
> > + * attiny816, attiny817, attiny1614, attiny1616, attiny1617, attiny321=
4,
> > + * attiny3216, attiny3217, atmega808, atmega809, atmega1608, atmega160=
9,
> > + * atmega3208, atmega3209, atmega4808, atmega4809
> > + */
> > +static void avr_xmega3_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>
> Ok. Checked with attiny212 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type xmega4
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * atxmega64a3, atxmega64d3, atxmega64a3u, atxmega64a4u, atxmega64b1,
> > + * atxmega64b3, atxmega64c3, atxmega64d4
> > + */
> > +static void avr_xmega4_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>
> Ok. I couldn't find an exact definition of the SP length but it says
> that the SRAM is used as stack. The max length of ram being 16KB.
> Checked with atxmega64a3 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type xmega5
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * atxmega64a1, atxmega64a1u
> > + */
> > +static void avr_xmega5_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>
> Ok. Checked with atxmega64a1 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_RAMPD);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPX);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPY);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type xmega6
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * atxmega128a3, atxmega128d3, atxmega192a3, atxmega192d3, atxmega256a=
3,
> > + * atxmega256a3b, atxmega256a3bu, atxmega256d3, atxmega128a3u,
> atxmega128b1,
> > + * atxmega128b3, atxmega128c3, atxmega128d4, atxmega192a3u,
> atxmega192c3,
> > + * atxmega256a3u, atxmega256c3, atxmega384c3, atxmega384d3
> > + */
> > +static void avr_xmega6_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>
> Ok. I couldn't find an exact definition of the SP length but it says
> that the SRAM is used as stack. The max length of ram being 16KB.
> Checked with atxmega128a3 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type xmega7
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * atxmega128a1, atxmega128a1u, atxmega128a4u
> > + */
> > +static void avr_xmega7_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>
> Ok. Checked with atxmega128a1 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_RAMPD);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPX);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPY);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > +}
> > +
> > +typedef struct AVRCPUInfo {
> > +    const char *name;
> > +    void (*initfn)(Object *obj);
> > +} AVRCPUInfo;
> > +
> > +
> > +static void avr_cpu_list_entry(gpointer data, gpointer user_data)
> > +{
> > +    const char *typename =3D object_class_get_name(OBJECT_CLASS(data))=
;
> > +
> > +    qemu_printf("%s\n", typename);
> > +}
> > +
> > +void avr_cpu_list(void)
> > +{
> > +    GSList *list;
> > +    list =3D object_class_get_list_sorted(TYPE_AVR_CPU, false);
> > +    g_slist_foreach(list, avr_cpu_list_entry, NULL);
> > +    g_slist_free(list);
> > +}
> > +
> > +#define DEFINE_AVR_CPU_TYPE(model, initfn) \
> > +    { \
> > +        .parent =3D TYPE_AVR_CPU, \
> > +        .instance_init =3D initfn, \
> > +        .name =3D AVR_CPU_TYPE_NAME(model), \
> > +    }
> > +
> > +static const TypeInfo avr_cpu_type_info[] =3D {
> > +    {
> > +        .name =3D TYPE_AVR_CPU,
> > +        .parent =3D TYPE_CPU,
> > +        .instance_size =3D sizeof(AVRCPU),
> > +        .instance_init =3D avr_cpu_initfn,
> > +        .class_size =3D sizeof(AVRCPUClass),
> > +        .class_init =3D avr_cpu_class_init,
> > +        .abstract =3D true,
> > +    },
> > +    DEFINE_AVR_CPU_TYPE("avrtiny", avr_avrtiny_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr1", avr_avr1_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr2", avr_avr2_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr25", avr_avr25_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr3", avr_avr3_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr31", avr_avr31_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr35", avr_avr35_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr4", avr_avr4_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr5", avr_avr5_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr51", avr_avr51_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr6", avr_avr6_initfn),
> > +    DEFINE_AVR_CPU_TYPE("xmega2", avr_xmega2_initfn),
> > +    DEFINE_AVR_CPU_TYPE("xmega3", avr_xmega3_initfn),
> > +    DEFINE_AVR_CPU_TYPE("xmega4", avr_xmega4_initfn),
> > +    DEFINE_AVR_CPU_TYPE("xmega5", avr_xmega5_initfn),
> > +    DEFINE_AVR_CPU_TYPE("xmega6", avr_xmega6_initfn),
> > +    DEFINE_AVR_CPU_TYPE("xmega7", avr_xmega7_initfn),
> > +};
> > +
> > +const char *avr_flags_to_cpu_type(uint32_t flags, const char
> *def_cpu_type)
> > +{
> > +    switch (flags & EF_AVR_MACH) {
> > +    case bfd_mach_avr1:
> > +        return AVR_CPU_TYPE_NAME("avr1");
> > +    case bfd_mach_avr2:
> > +        return AVR_CPU_TYPE_NAME("avr2");
> > +    case bfd_mach_avr25:
> > +        return AVR_CPU_TYPE_NAME("avr25");
> > +    case bfd_mach_avr3:
> > +        return AVR_CPU_TYPE_NAME("avr3");
> > +    case bfd_mach_avr31:
> > +        return AVR_CPU_TYPE_NAME("avr31");
> > +    case bfd_mach_avr35:
> > +        return AVR_CPU_TYPE_NAME("avr35");
> > +    case bfd_mach_avr4:
> > +        return AVR_CPU_TYPE_NAME("avr4");
> > +    case bfd_mach_avr5:
> > +        return AVR_CPU_TYPE_NAME("avr5");
> > +    case bfd_mach_avr51:
> > +        return AVR_CPU_TYPE_NAME("avr51");
> > +    case bfd_mach_avr6:
> > +        return AVR_CPU_TYPE_NAME("avr6");
> > +    case bfd_mach_avrtiny:
> > +        return AVR_CPU_TYPE_NAME("avrtiny");
> > +    case bfd_mach_avrxmega2:
> > +        return AVR_CPU_TYPE_NAME("xmega2");
> > +    case bfd_mach_avrxmega3:
> > +        return AVR_CPU_TYPE_NAME("xmega3");
> > +    case bfd_mach_avrxmega4:
> > +        return AVR_CPU_TYPE_NAME("xmega4");
> > +    case bfd_mach_avrxmega5:
> > +        return AVR_CPU_TYPE_NAME("xmega5");
> > +    case bfd_mach_avrxmega6:
> > +        return AVR_CPU_TYPE_NAME("xmega6");
> > +    case bfd_mach_avrxmega7:
> > +        return AVR_CPU_TYPE_NAME("xmega7");
> > +    default:
> > +        return def_cpu_type;
> > +    }
> > +}
> > +
> > +DEFINE_TYPES(avr_cpu_type_info)
> > diff --git a/target/avr/gdbstub.c b/target/avr/gdbstub.c
> > new file mode 100644
> > index 0000000000..733184c08f
> > --- /dev/null
> > +++ b/target/avr/gdbstub.c
> > @@ -0,0 +1,84 @@
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
> > +#include "qemu/osdep.h"
> > +#include "exec/gdbstub.h"
> > +
> > +int avr_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(cs);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    /*  R */
> > +    if (n < 32) {
> > +        return gdb_get_reg8(mem_buf, env->r[n]);
> > +    }
> > +
> > +    /*  SREG */
> > +    if (n =3D=3D 32) {
> > +        uint8_t sreg =3D cpu_get_sreg(env);
> > +
> > +        return gdb_get_reg8(mem_buf, sreg);
> > +    }
> > +
> > +    /*  SP */
> > +    if (n =3D=3D 33) {
> > +        return gdb_get_reg16(mem_buf, env->sp & 0x0000ffff);
> > +    }
> > +
> > +    /*  PC */
> > +    if (n =3D=3D 34) {
> > +        return gdb_get_reg32(mem_buf, env->pc_w * 2);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +int avr_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(cs);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    /*  R */
> > +    if (n < 32) {
> > +        env->r[n] =3D *mem_buf;
> > +        return 1;
> > +    }
> > +
> > +    /*  SREG */
> > +    if (n =3D=3D 32) {
> > +        cpu_set_sreg(env, *mem_buf);
> > +        return 1;
> > +    }
> > +
> > +    /*  SP */
> > +    if (n =3D=3D 33) {
> > +        env->sp =3D lduw_p(mem_buf);
> > +        return 2;
> > +    }
> > +
> > +    /*  PC */
> > +    if (n =3D=3D 34) {
> > +        env->pc_w =3D ldl_p(mem_buf) / 2;
> > +        return 4;
> > +    }
> > +
> > +    return 0;
> > +}
> > diff --git a/target/avr/machine.c b/target/avr/machine.c
> > new file mode 100644
> > index 0000000000..ba44bd042b
> > --- /dev/null
> > +++ b/target/avr/machine.c
> > @@ -0,0 +1,121 @@
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
> > +#include "qemu/osdep.h"
> > +#include "cpu.h"
> > +#include "migration/cpu.h"
> > +
> > +static int get_sreg(QEMUFile *f, void *opaque, size_t size,
> > +    const VMStateField *field)
> > +{
> > +    CPUAVRState *env =3D opaque;
> > +    uint8_t sreg;
> > +
> > +    sreg =3D qemu_get_byte(f);
> > +    cpu_set_sreg(env, sreg);
> > +    return 0;
> > +}
> > +
> > +static int put_sreg(
> > +    QEMUFile *f, void *opaque, size_t size,
> > +    const VMStateField *field, QJSON *vmdesc)
> > +{
> > +    CPUAVRState *env =3D opaque;
> > +    uint8_t sreg =3D cpu_get_sreg(env);
> > +
> > +    qemu_put_byte(f, sreg);
> > +    return 0;
> > +}
> > +
> > +static const VMStateInfo vms_sreg =3D {
> > +    .name =3D "sreg",
> > +    .get =3D get_sreg,
> > +    .put =3D put_sreg,
> > +};
> > +
> > +static int get_segment(
> > +    QEMUFile *f, void *opaque, size_t size, const VMStateField *field)
> > +{
> > +    uint32_t *ramp =3D opaque;
> > +    uint8_t temp;
> > +
> > +    temp =3D qemu_get_byte(f);
> > +    *ramp =3D ((uint32_t)temp) << 16;
> > +    return 0;
> > +}
> > +
> > +static int put_segment(
> > +    QEMUFile *f, void *opaque, size_t size,
> > +    const VMStateField *field, QJSON *vmdesc)
> > +{
> > +    uint32_t *ramp =3D opaque;
> > +    uint8_t temp =3D *ramp >> 16;
> > +
> > +    qemu_put_byte(f, temp);
> > +    return 0;
> > +}
> > +
> > +static const VMStateInfo vms_rampD =3D {
> > +    .name =3D "rampD",
> > +    .get =3D get_segment,
> > +    .put =3D put_segment,
> > +};
> > +static const VMStateInfo vms_rampX =3D {
> > +    .name =3D "rampX",
> > +    .get =3D get_segment,
> > +    .put =3D put_segment,
> > +};
> > +static const VMStateInfo vms_rampY =3D {
> > +    .name =3D "rampY",
> > +    .get =3D get_segment,
> > +    .put =3D put_segment,
> > +};
> > +static const VMStateInfo vms_rampZ =3D {
> > +    .name =3D "rampZ",
> > +    .get =3D get_segment,
> > +    .put =3D put_segment,
> > +};
> > +static const VMStateInfo vms_eind =3D {
> > +    .name =3D "eind",
> > +    .get =3D get_segment,
> > +    .put =3D put_segment,
> > +};
> > +
> > +const VMStateDescription vms_avr_cpu =3D {
> > +    .name =3D "cpu",
> > +    .version_id =3D 0,
> > +    .minimum_version_id =3D 0,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT32(env.pc_w, AVRCPU),
> > +        VMSTATE_UINT32(env.sp, AVRCPU),
> > +        VMSTATE_UINT32(env.skip, AVRCPU),
> > +
> > +        VMSTATE_UINT32_ARRAY(env.r, AVRCPU, NUMBER_OF_CPU_REGISTERS),
> > +
> > +        VMSTATE_SINGLE(env, AVRCPU, 0, vms_sreg, CPUAVRState),
> > +        VMSTATE_SINGLE(env.rampD, AVRCPU, 0, vms_rampD, uint32_t),
> > +        VMSTATE_SINGLE(env.rampX, AVRCPU, 0, vms_rampX, uint32_t),
> > +        VMSTATE_SINGLE(env.rampY, AVRCPU, 0, vms_rampY, uint32_t),
> > +        VMSTATE_SINGLE(env.rampZ, AVRCPU, 0, vms_rampZ, uint32_t),
> > +        VMSTATE_SINGLE(env.eind, AVRCPU, 0, vms_eind, uint32_t),
> > +
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > diff --git a/gdb-xml/avr-cpu.xml b/gdb-xml/avr-cpu.xml
> > new file mode 100644
> > index 0000000000..c4747f5b40
> > --- /dev/null
> > +++ b/gdb-xml/avr-cpu.xml
> > @@ -0,0 +1,49 @@
> > +<?xml version=3D"1.0"?>
> > +<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
> > +
> > +     Copying and distribution of this file, with or without
> modification,
> > +     are permitted in any medium without royalty provided the copyrigh=
t
> > +     notice and this notice are preserved.  -->
> > +
> > +<!-- Register numbers are hard-coded in order to maintain backward
> > +     compatibility with older versions of tools that didn't use xml
> > +     register descriptions.  -->
> > +
> > +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> > +<feature name=3D"org.gnu.gdb.riscv.cpu">
> > +  <reg name=3D"r0" bitsize=3D"8" type=3D"int" regnum=3D"0"/>
> > +  <reg name=3D"r1" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r2" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r3" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r4" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r5" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r6" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r7" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r8" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r9" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r10" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r11" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r12" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r13" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r14" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r15" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r16" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r17" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r18" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r19" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r20" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r21" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r22" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r23" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r24" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r25" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r26" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r27" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r28" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r29" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r30" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"r31" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"sreg" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"sp" bitsize=3D"8" type=3D"int"/>
> > +  <reg name=3D"pc" bitsize=3D"8" type=3D"int"/>
> > +</feature>
> >
>
> General concern: why is there an AVR_FEATURE_1_BYTE_PC when the code
> does nothing with it?
>
> --Joa
>


--=20
Best Regards,
Michael Rolnik

--000000000000d5e7f8059d1b3fd1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Joaquin.<div><br></div><div>`AVR_FEATURE_1_BYTE_PC` is =
used in `gen_push_ret` function (target/avr/translate.c)</div><div><br></di=
v><div>Regards,</div><div>Michael Rolnik</div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jan 26, 2020 at 2:15 =
PM Joaquin de Andres &lt;<a href=3D"mailto:me@xcancerberox.com.ar">me@xcanc=
erberox.com.ar</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Hi! In this mail I only checked the general code and one of t=
he listed<br>
features for the different types of avr. I will check the rest in<br>
following emails.<br>
<br>
On 1/24/20 1:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; From: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=
=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; <br>
&gt; This includes:<br>
&gt; - CPU data structures<br>
&gt; - object model classes and functions<br>
&gt; - migration functions<br>
&gt; - GDB hooks<br>
&gt; <br>
&gt; Co-developed-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.co=
m" target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; Co-developed-by: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac=
.uk" target=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
&gt; Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com"=
 target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.u=
k" target=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
&gt; Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com"=
 target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; Acked-by: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" tar=
get=3D"_blank">imammedo@redhat.com</a>&gt;<br>
&gt; Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@re=
dhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
&gt; Message-Id: &lt;<a href=3D"mailto:20200118191416.19934-2-mrolnik@gmail=
.com" target=3D"_blank">20200118191416.19934-2-mrolnik@gmail.com</a>&gt;<br=
>
&gt; Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henders=
on@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/avr/cpu-param.h |=C2=A0 37 ++<br>
&gt;=C2=A0 target/avr/cpu-qom.h=C2=A0 =C2=A0|=C2=A0 54 +++<br>
&gt;=C2=A0 target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 258 +++++++++++++<b=
r>
&gt;=C2=A0 target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 826 +++++++++++++++=
++++++++++++++++++++++++++<br>
&gt;=C2=A0 target/avr/gdbstub.c=C2=A0 =C2=A0|=C2=A0 84 +++++<br>
&gt;=C2=A0 target/avr/machine.c=C2=A0 =C2=A0| 121 ++++++<br>
&gt;=C2=A0 gdb-xml/avr-cpu.xml=C2=A0 =C2=A0 |=C2=A0 49 +++<br>
&gt;=C2=A0 7 files changed, 1429 insertions(+)<br>
&gt;=C2=A0 create mode 100644 target/avr/cpu-param.h<br>
&gt;=C2=A0 create mode 100644 target/avr/cpu-qom.h<br>
&gt;=C2=A0 create mode 100644 target/avr/cpu.h<br>
&gt;=C2=A0 create mode 100644 target/avr/cpu.c<br>
&gt;=C2=A0 create mode 100644 target/avr/gdbstub.c<br>
&gt;=C2=A0 create mode 100644 target/avr/machine.c<br>
&gt;=C2=A0 create mode 100644 gdb-xml/avr-cpu.xml<br>
&gt; <br>
&gt; diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..0c29ce4223<br>
&gt; --- /dev/null<br>
&gt; +++ b/target/avr/cpu-param.h<br>
&gt; @@ -0,0 +1,37 @@<br>
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
&gt; +#ifndef AVR_CPU_PARAM_H<br>
&gt; +#define AVR_CPU_PARAM_H<br>
&gt; +<br>
&gt; +#define TARGET_LONG_BITS 32<br>
&gt; +/*<br>
&gt; + * TARGET_PAGE_BITS cannot be more than 8 bits because<br>
&gt; + * 1.=C2=A0 all IO registers occupy [0x0000 .. 0x00ff] address range,=
 and they<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0should be implemented as a device and not memor=
y<br>
&gt; + * 2.=C2=A0 SRAM starts at the address 0x0100<br>
&gt; + */<br>
&gt; +#define TARGET_PAGE_BITS 8<br>
&gt; +#define TARGET_PHYS_ADDR_SPACE_BITS 24<br>
&gt; +#define TARGET_VIRT_ADDR_SPACE_BITS 24<br>
&gt; +#define NB_MMU_MODES 2<br>
&gt; +<br>
&gt; +<br>
&gt; +#endif<br>
&gt; diff --git a/target/avr/cpu-qom.h b/target/avr/cpu-qom.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..e28b58c897<br>
&gt; --- /dev/null<br>
&gt; +++ b/target/avr/cpu-qom.h<br>
&gt; @@ -0,0 +1,54 @@<br>
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
&gt; +#ifndef QEMU_AVR_QOM_H<br>
&gt; +#define QEMU_AVR_QOM_H<br>
&gt; +<br>
&gt; +#include &quot;hw/core/cpu.h&quot;<br>
&gt; +<br>
&gt; +#define TYPE_AVR_CPU &quot;avr-cpu&quot;<br>
&gt; +<br>
&gt; +#define AVR_CPU_CLASS(klass) \<br>
&gt; +=C2=A0 =C2=A0 OBJECT_CLASS_CHECK(AVRCPUClass, (klass), TYPE_AVR_CPU)<=
br>
&gt; +#define AVR_CPU(obj) \<br>
&gt; +=C2=A0 =C2=A0 OBJECT_CHECK(AVRCPU, (obj), TYPE_AVR_CPU)<br>
&gt; +#define AVR_CPU_GET_CLASS(obj) \<br>
&gt; +=C2=A0 =C2=A0 OBJECT_GET_CLASS(AVRCPUClass, (obj), TYPE_AVR_CPU)<br>
&gt; +<br>
&gt; +/**<br>
&gt; + *=C2=A0 AVRCPUClass:<br>
&gt; + *=C2=A0 @parent_realize: The parent class&#39; realize handler.<br>
&gt; + *=C2=A0 @parent_reset: The parent class&#39; reset handler.<br>
&gt; + *=C2=A0 @vr: Version Register value.<br>
&gt; + *<br>
&gt; + *=C2=A0 A AVR CPU model.<br>
&gt; + */<br>
&gt; +typedef struct AVRCPUClass {<br>
&gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; +=C2=A0 =C2=A0 CPUClass parent_class;<br>
&gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; +=C2=A0 =C2=A0 DeviceRealize parent_realize;<br>
&gt; +=C2=A0 =C2=A0 void (*parent_reset)(CPUState *cpu);<br>
&gt; +} AVRCPUClass;<br>
&gt; +<br>
&gt; +typedef struct AVRCPU AVRCPU;<br>
&gt; +<br>
&gt; +<br>
&gt; +#endif /* !defined (QEMU_AVR_CPU_QOM_H) */<br>
&gt; diff --git a/target/avr/cpu.h b/target/avr/cpu.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..b74bcf01ae<br>
&gt; --- /dev/null<br>
&gt; +++ b/target/avr/cpu.h<br>
&gt; @@ -0,0 +1,258 @@<br>
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
&gt; +#ifndef QEMU_AVR_CPU_H<br>
&gt; +#define QEMU_AVR_CPU_H<br>
&gt; +<br>
&gt; +#include &quot;cpu-qom.h&quot;<br>
&gt; +#include &quot;exec/cpu-defs.h&quot;<br>
&gt; +<br>
&gt; +#define TCG_GUEST_DEFAULT_MO 0<br>
&gt; +#define AVR_CPU_TYPE_SUFFIX &quot;-&quot; TYPE_AVR_CPU<br>
&gt; +#define AVR_CPU_TYPE_NAME(name) (name AVR_CPU_TYPE_SUFFIX)<br>
&gt; +#define CPU_RESOLVING_TYPE TYPE_AVR_CPU<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * AVR has two memory spaces, data &amp; code.<br>
&gt; + * e.g. both have 0 address<br>
&gt; + * ST/LD instructions access data space<br>
&gt; + * LPM/SPM and instruction fetching access code memory space<br>
&gt; + */<br>
&gt; +#define MMU_CODE_IDX 0<br>
&gt; +#define MMU_DATA_IDX 1<br>
&gt; +<br>
&gt; +#define EXCP_RESET 1<br>
&gt; +#define EXCP_INT(n) (EXCP_RESET + (n) + 1)<br>
&gt; +<br>
&gt; +/* Number of CPU registers */<br>
&gt; +#define NUMBER_OF_CPU_REGISTERS 32<br>
&gt; +/* Number of IO registers accessible by ld/st/in/out */<br>
&gt; +#define NUMBER_OF_IO_REGISTERS 64<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Offsets of AVR memory regions in host memory space.<br>
&gt; + *<br>
&gt; + * This is needed because the AVR has separate code and data address<=
br>
&gt; + * spaces that both have start from zero but have to go somewhere in<=
br>
&gt; + * host memory.<br>
&gt; + *<br>
&gt; + * It&#39;s also useful to know where some things are, like the IO re=
gisters.<br>
&gt; + */<br>
&gt; +/* Flash program memory */<br>
&gt; +#define OFFSET_CODE 0x00000000<br>
&gt; +/* CPU registers, IO registers, and SRAM */<br>
&gt; +#define OFFSET_DATA 0x00800000<br>
&gt; +/* CPU registers specifically, these are mapped at the start of data =
*/<br>
&gt; +#define OFFSET_CPU_REGISTERS OFFSET_DATA<br>
&gt; +/*<br>
&gt; + * IO registers, including status register, stack pointer, and memory=
<br>
&gt; + * mapped peripherals, mapped just after CPU registers<br>
&gt; + */<br>
&gt; +#define OFFSET_IO_REGISTERS (OFFSET_DATA + NUMBER_OF_CPU_REGISTERS)<b=
r>
&gt; +<br>
&gt; +#define EF_AVR_MACH 0x7F<br>
&gt; +<br>
&gt; +typedef enum AVRFeature {<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_SRAM,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_1_BYTE_PC,<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_2_BYTE_PC,<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_3_BYTE_PC,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_1_BYTE_SP,<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_2_BYTE_SP,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_BREAK,<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_DES,<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_RMW, /* Read Modify Write - XCH LAC LAS LAT=
 */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_EIJMP_EICALL,<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_IJMP_ICALL,<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_JMP_CALL,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_ADIW_SBIW,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_SPM,<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_SPMX,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_ELPMX,<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_ELPM,<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_LPMX,<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_LPM,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_MOVW,<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_MUL,<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_RAMPD,<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_RAMPX,<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_RAMPY,<br>
&gt; +=C2=A0 =C2=A0 AVR_FEATURE_RAMPZ,<br>
&gt; +} AVRFeature;<br>
&gt; +<br>
&gt; +typedef struct CPUAVRState CPUAVRState;<br>
&gt; +<br>
&gt; +struct CPUAVRState {<br>
&gt; +=C2=A0 =C2=A0 uint32_t pc_w; /* 0x003fffff up to 22 bits */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t sregC; /* 0x00000001 1 bit */<br>
&gt; +=C2=A0 =C2=A0 uint32_t sregZ; /* 0x00000001 1 bit */<br>
&gt; +=C2=A0 =C2=A0 uint32_t sregN; /* 0x00000001 1 bit */<br>
&gt; +=C2=A0 =C2=A0 uint32_t sregV; /* 0x00000001 1 bit */<br>
&gt; +=C2=A0 =C2=A0 uint32_t sregS; /* 0x00000001 1 bit */<br>
&gt; +=C2=A0 =C2=A0 uint32_t sregH; /* 0x00000001 1 bit */<br>
&gt; +=C2=A0 =C2=A0 uint32_t sregT; /* 0x00000001 1 bit */<br>
&gt; +=C2=A0 =C2=A0 uint32_t sregI; /* 0x00000001 1 bit */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t rampD; /* 0x00ff0000 8 bits */<br>
&gt; +=C2=A0 =C2=A0 uint32_t rampX; /* 0x00ff0000 8 bits */<br>
&gt; +=C2=A0 =C2=A0 uint32_t rampY; /* 0x00ff0000 8 bits */<br>
&gt; +=C2=A0 =C2=A0 uint32_t rampZ; /* 0x00ff0000 8 bits */<br>
&gt; +=C2=A0 =C2=A0 uint32_t eind; /* 0x00ff0000 8 bits */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t r[NUMBER_OF_CPU_REGISTERS]; /* 8 bits each */<=
br>
&gt; +=C2=A0 =C2=A0 uint32_t sp; /* 16 bits */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t skip; /* if set skip instruction */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint64_t intsrc; /* interrupt sources */<br>
&gt; +=C2=A0 =C2=A0 bool fullacc; /* CPU/MEM if true MEM only otherwise */<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t features;<br>
&gt; +};<br>
<br>
Why not use &#39;uint8_t&#39; for all sreg bits, ramps, eind and user regis=
ters,<br>
and bool for skip flag?<br>
<br>
&gt; +<br>
&gt; +/**<br>
&gt; + *=C2=A0 AVRCPU:<br>
&gt; + *=C2=A0 @env: #CPUAVRState<br>
&gt; + *<br>
&gt; + *=C2=A0 A AVR CPU.<br>
&gt; + */<br>
&gt; +typedef struct AVRCPU {<br>
&gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; +=C2=A0 =C2=A0 CPUState parent_obj;<br>
&gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 CPUNegativeOffsetState neg;<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState env;<br>
&gt; +} AVRCPU;<br>
&gt; +<br>
&gt; +#ifndef CONFIG_USER_ONLY<br>
&gt; +extern const struct VMStateDescription vms_avr_cpu;<br>
&gt; +#endif<br>
&gt; +<br>
&gt; +void avr_cpu_do_interrupt(CPUState *cpu);<br>
&gt; +bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);<br>
&gt; +hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);<br>
&gt; +int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);<=
br>
&gt; +int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);=
<br>
&gt; +<br>
&gt; +static inline int avr_feature(CPUAVRState *env, AVRFeature feature)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return (env-&gt;features &amp; (1U &lt;&lt; feature)) !=
=3D 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline void avr_set_feature(CPUAVRState *env, int feature)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 env-&gt;features |=3D (1U &lt;&lt; feature);<br>
&gt; +}<br>
&gt; +<br>
&gt; +#define cpu_list avr_cpu_list<br>
&gt; +#define cpu_signal_handler cpu_avr_signal_handler<br>
&gt; +#define cpu_mmu_index avr_cpu_mmu_index<br>
&gt; +<br>
&gt; +static inline int avr_cpu_mmu_index(CPUAVRState *env, bool ifetch)<br=
>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;<br>
&gt; +}<br>
&gt; +<br>
&gt; +void avr_cpu_tcg_init(void);<br>
&gt; +<br>
&gt; +void avr_cpu_list(void);<br>
&gt; +int cpu_avr_exec(CPUState *cpu);<br>
&gt; +int cpu_avr_signal_handler(int host_signum, void *pinfo, void *puc);<=
br>
&gt; +int avr_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int rw, int mmu_idx);<br>
&gt; +int avr_cpu_memory_rw_debug(CPUState *cs, vaddr address, uint8_t *buf=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int len, bool is_write);<br>
&gt; +<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 TB_FLAGS_FULL_ACCESS =3D 1,<br>
&gt; +=C2=A0 =C2=A0 TB_FLAGS_SKIP =3D 2,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static inline void cpu_get_tb_cpu_state(CPUAVRState *env, target_ulon=
g *pc,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong *cs_base, uint32_t =
*pflags)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t flags =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 *pc =3D env-&gt;pc_w * 2;<br>
&gt; +=C2=A0 =C2=A0 *cs_base =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (env-&gt;fullacc) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D TB_FLAGS_FULL_ACCESS;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (env-&gt;skip) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D TB_FLAGS_SKIP;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 *pflags =3D flags;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline int cpu_interrupts_enabled(CPUAVRState *env)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return env-&gt;sregI !=3D 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline uint8_t cpu_get_sreg(CPUAVRState *env)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint8_t sreg;<br>
&gt; +=C2=A0 =C2=A0 sreg =3D (env-&gt;sregC) &lt;&lt; 0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregZ) &lt;&lt; 1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregN) &lt;&lt; 2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregV) &lt;&lt; 3<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregS) &lt;&lt; 4<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregH) &lt;&lt; 5<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregT) &lt;&lt; 6<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregI) &lt;&lt; 7;<br>
&gt; +=C2=A0 =C2=A0 return sreg;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline void cpu_set_sreg(CPUAVRState *env, uint8_t sreg)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregC =3D (sreg &gt;&gt; 0) &amp; 0x01;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregZ =3D (sreg &gt;&gt; 1) &amp; 0x01;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregN =3D (sreg &gt;&gt; 2) &amp; 0x01;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregV =3D (sreg &gt;&gt; 3) &amp; 0x01;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregS =3D (sreg &gt;&gt; 4) &amp; 0x01;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregH =3D (sreg &gt;&gt; 5) &amp; 0x01;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregT =3D (sreg &gt;&gt; 6) &amp; 0x01;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregI =3D (sreg &gt;&gt; 7) &amp; 0x01;<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 MMUAccessType access_type, int mmu_idx,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 bool probe, uintptr_t retaddr);<br>
&gt; +<br>
&gt; +typedef CPUAVRState CPUArchState;<br>
&gt; +typedef AVRCPU ArchCPU;<br>
&gt; +<br>
&gt; +#include &quot;exec/cpu-all.h&quot;<br>
&gt; +<br>
&gt; +const char *avr_flags_to_cpu_type(uint32_t flags, const char *def_cpu=
_type);<br>
&gt; +<br>
&gt; +#endif /* !defined (QEMU_AVR_CPU_H) */<br>
&gt; diff --git a/target/avr/cpu.c b/target/avr/cpu.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..c74c5106fe<br>
&gt; --- /dev/null<br>
&gt; +++ b/target/avr/cpu.c<br>
&gt; @@ -0,0 +1,826 @@<br>
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
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;qemu/qemu-print.h&quot;<br>
&gt; +#include &quot;exec/exec-all.h&quot;<br>
&gt; +#include &quot;cpu.h&quot;<br>
&gt; +#include &quot;disas/dis-asm.h&quot;<br>
&gt; +<br>
&gt; +static void avr_cpu_set_pc(CPUState *cs, vaddr value)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cpu-&gt;env.pc_w =3D value / 2; /* internally PC points=
 to words */<br>
&gt; +}<br>
<br>
Isn&#39;t it safer to add &#39;assert(!(value % 2))&#39; before this call?<=
br>
<br>
&gt; +<br>
&gt; +static bool avr_cpu_has_work(CPUState *cs)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return (cs-&gt;interrupt_request &amp; (CPU_INTERRUPT_H=
ARD | CPU_INTERRUPT_RESET))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; cpu_interrupts_e=
nabled(env);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void avr_cpu_synchronize_from_tb(CPUState *cs, TranslationBloc=
k *tb)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 env-&gt;pc_w =3D tb-&gt;pc / 2; /* internally PC points=
 to words */<br>
<br>
Same that above.<br>
<br>
&gt; +}&gt; +<br>
&gt; +static void avr_cpu_reset(CPUState *cs)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);<br>
&gt; +=C2=A0 =C2=A0 AVRCPUClass *mcc =3D AVR_CPU_GET_CLASS(cpu);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mcc-&gt;parent_reset(cs);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 env-&gt;pc_w =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregI =3D 1;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregC =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregZ =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregN =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregV =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregS =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregH =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregT =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 env-&gt;rampD =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;rampX =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;rampY =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;rampZ =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;eind =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sp =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 env-&gt;skip =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memset(env-&gt;r, 0, sizeof(env-&gt;r));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 tlb_flush(cs);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *i=
nfo)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 info-&gt;mach =3D bfd_arch_avr;<br>
&gt; +=C2=A0 =C2=A0 info-&gt;print_insn =3D NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void avr_cpu_realizefn(DeviceState *dev, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 CPUState *cs =3D CPU(dev);<br>
&gt; +=C2=A0 =C2=A0 AVRCPUClass *mcc =3D AVR_CPU_GET_CLASS(dev);<br>
&gt; +=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cpu_exec_realizefn(cs, &amp;local_err);<br>
&gt; +=C2=A0 =C2=A0 if (local_err !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 qemu_init_vcpu(cs);<br>
&gt; +=C2=A0 =C2=A0 cpu_reset(cs);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mcc-&gt;parent_realize(dev, errp);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void avr_cpu_set_int(void *opaque, int irq, int level)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +=C2=A0 =C2=A0 CPUState *cs =3D CPU(cpu);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint64_t mask =3D (1ull &lt;&lt; irq);<br>
&gt; +=C2=A0 =C2=A0 if (level) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;intsrc |=3D mask;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_interrupt(cs, CPU_INTERRUPT_HARD);<br=
>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;intsrc &amp;=3D ~mask;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;intsrc =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_reset_interrupt(cs, CPU=
_INTERRUPT_HARD);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void avr_cpu_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cpu_set_cpustate_pointers(cpu);<br>
&gt; +<br>
&gt; +#ifndef CONFIG_USER_ONLY<br>
&gt; +=C2=A0 =C2=A0 /* Set the number of interrupts supported by the CPU. *=
/<br>
&gt; +=C2=A0 =C2=A0 qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(cpu-&gt;env.intsrc) =
* 8);<br>
&gt; +#endif<br>
&gt; +}<br>
&gt; +<br>
&gt; +static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 ObjectClass *oc;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 oc =3D object_class_by_name(cpu_model);<br>
&gt; +=C2=A0 =C2=A0 if (object_class_dynamic_cast(oc, TYPE_AVR_CPU) =3D=3D =
NULL ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_class_is_abstract(oc)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 oc =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return oc;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;PC:=C2=A0 =C2=A0 %06x\n&quot;, en=
v-&gt;pc_w);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;SP:=C2=A0 =C2=A0 =C2=A0 %04x\n&qu=
ot;, env-&gt;sp);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;rampD:=C2=A0 =C2=A0 =C2=A0%02x\n&=
quot;, env-&gt;rampD &gt;&gt; 16);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;rampX:=C2=A0 =C2=A0 =C2=A0%02x\n&=
quot;, env-&gt;rampX &gt;&gt; 16);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;rampY:=C2=A0 =C2=A0 =C2=A0%02x\n&=
quot;, env-&gt;rampY &gt;&gt; 16);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;rampZ:=C2=A0 =C2=A0 =C2=A0%02x\n&=
quot;, env-&gt;rampZ &gt;&gt; 16);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;EIND:=C2=A0 =C2=A0 =C2=A0 %02x\n&=
quot;, env-&gt;eind &gt;&gt; 16);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;X:=C2=A0 =C2=A0 =C2=A0 =C2=A0%02x=
%02x\n&quot;, env-&gt;r[27], env-&gt;r[26]);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;Y:=C2=A0 =C2=A0 =C2=A0 =C2=A0%02x=
%02x\n&quot;, env-&gt;r[29], env-&gt;r[28]);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;Z:=C2=A0 =C2=A0 =C2=A0 =C2=A0%02x=
%02x\n&quot;, env-&gt;r[31], env-&gt;r[30]);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;SREG:=C2=A0 =C2=A0 [ %c %c %c %c =
%c %c %c %c ]\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 env-&gt;sregI ? &#39;I&#39; : &#39;-&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 env-&gt;sregT ? &#39;T&#39; : &#39;-&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 env-&gt;sregH ? &#39;H&#39; : &#39;-&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 env-&gt;sregS ? &#39;S&#39; : &#39;-&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 env-&gt;sregV ? &#39;V&#39; : &#39;-&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 env-&gt;sregN ? &#39;-&#39; : &#39;N&#39;, /* Zf has negativ=
e logic */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 env-&gt;sregZ ? &#39;Z&#39; : &#39;-&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 env-&gt;sregC ? &#39;I&#39; : &#39;-&#39;);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;SKIP:=C2=A0 =C2=A0 %02x\n&quot;, =
env-&gt;skip);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(env-&gt;r); i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot;R[%02d]:=C2=A0 %02x=
=C2=A0 =C2=A0&quot;, i, env-&gt;r[i]);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((i % 8) =3D=3D 7) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot;\n&qu=
ot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;\n&quot;);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void avr_cpu_class_init(ObjectClass *oc, void *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(oc);<br>
&gt; +=C2=A0 =C2=A0 CPUClass *cc =3D CPU_CLASS(oc);<br>
&gt; +=C2=A0 =C2=A0 AVRCPUClass *mcc =3D AVR_CPU_CLASS(oc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mcc-&gt;parent_realize =3D dc-&gt;realize;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;realize =3D avr_cpu_realizefn;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mcc-&gt;parent_reset =3D cc-&gt;reset;<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;reset =3D avr_cpu_reset;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;class_by_name =3D avr_cpu_class_by_name;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;has_work =3D avr_cpu_has_work;<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;do_interrupt =3D avr_cpu_do_interrupt;<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;cpu_exec_interrupt =3D avr_cpu_exec_interrupt;<b=
r>
&gt; +=C2=A0 =C2=A0 cc-&gt;dump_state =3D avr_cpu_dump_state;<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;set_pc =3D avr_cpu_set_pc;<br>
&gt; +#if !defined(CONFIG_USER_ONLY)<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;memory_rw_debug =3D avr_cpu_memory_rw_debug;<br>
&gt; +#endif<br>
&gt; +#ifdef CONFIG_USER_ONLY<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;handle_mmu_fault =3D avr_cpu_handle_mmu_fault;<b=
r>
&gt; +#else<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;get_phys_page_debug =3D avr_cpu_get_phys_page_de=
bug;<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;vmsd =3D &amp;vms_avr_cpu;<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;disas_set_info =3D avr_cpu_disas_set_info;<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;tlb_fill =3D avr_cpu_tlb_fill;<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;tcg_initialize =3D avr_cpu_tcg_init;<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;synchronize_from_tb =3D avr_cpu_synchronize_from=
_tb;<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;gdb_read_register =3D avr_cpu_gdb_read_register;=
<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;gdb_write_register =3D avr_cpu_gdb_write_registe=
r;<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;gdb_num_core_regs =3D 35;<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;gdb_core_xml_file =3D &quot;avr-cpu.xml&quot;;<b=
r>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avr1<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * at90s1200, attiny11, attiny12, attiny15, attiny28<br>
&gt; + */<br>
&gt; +static void avr_avr1_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
<br>
Checking features with the datasheet of the listed microcontroller I saw<br=
>
that the stack is a 3 level deep hardware stack dedicated to subroutines<br=
>
and interrupts.<br>
Why is the feature 2_BYTE_SP active?<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avr2<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * at90s2313, at90s2323, at90s2333, at90s2343, attiny22, attiny26, at=
90s4414,<br>
&gt; + * at90s4433, at90s4434, at90s8515, at90c8534, at90s8535<br>
&gt; + */<br>
&gt; +static void avr_avr2_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
<br>
Same. This microcontrollers (only checked with at90s2313 datasheet) use<br>
only SPL, why is the 2_BYTE_SP feature active?<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avr25<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * ata5272, ata6616c, attiny13, attiny13a, attiny2313, attiny2313a, a=
ttiny24,<br>
&gt; + * attiny24a, attiny4313, attiny44, attiny44a, attiny441, attiny84, a=
ttiny84a,<br>
&gt; + * attiny25, attiny45, attiny85, attiny261, attiny261a, attiny461, at=
tiny461a,<br>
&gt; + * attiny861, attiny861a, attiny43u, attiny87, attiny48, attiny88, at=
tiny828,<br>
&gt; + * attiny841, at86rf401<br>
&gt; + */<br>
&gt; +static void avr_avr25_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
<br>
Same. This microcontrollers (only checked with attiny13 datasheet) use<br>
only SPL, why is the 2_BYTE_SP feature active?<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avr3<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * at43usb355, at76c711<br>
&gt; + */<br>
&gt; +static void avr_avr3_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
<br>
Ok. Checked with at43usb355 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avr31<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * atmega103, at43usb320<br>
&gt; + */<br>
&gt; +static void avr_avr31_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
<br>
Ok. Checked with atmega103 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avr35<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * ata5505, ata6617c, ata664251, at90usb82, at90usb162, atmega8u2, at=
mega16u2,<br>
&gt; + * atmega32u2, attiny167, attiny1634<br>
&gt; + */<br>
&gt; +static void avr_avr35_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
<br>
Ok. Checked with atmega8u2 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avr4<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * ata6285, ata6286, ata6289, ata6612c, atmega8, atmega8a, atmega48, =
atmega48a,<br>
&gt; + * atmega48p, atmega48pa, atmega48pb, atmega88, atmega88a, atmega88p,=
<br>
&gt; + * atmega88pa, atmega88pb, atmega8515, atmega8535, atmega8hva, at90pw=
m1,<br>
&gt; + * at90pwm2, at90pwm2b, at90pwm3, at90pwm3b, at90pwm81<br>
&gt; + */<br>
&gt; +static void avr_avr4_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
<br>
Ok. Checked with atmega8 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avr5<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * ata5702m322, ata5782, ata5790, ata5790n, ata5791, ata5795, ata5831=
, ata6613c,<br>
&gt; + * ata6614q, ata8210, ata8510, atmega16, atmega16a, atmega161, atmega=
162,<br>
&gt; + * atmega163, atmega164a, atmega164p, atmega164pa, atmega165, atmega1=
65a,<br>
&gt; + * atmega165p, atmega165pa, atmega168, atmega168a, atmega168p, atmega=
168pa,<br>
&gt; + * atmega168pb, atmega169, atmega169a, atmega169p, atmega169pa, atmeg=
a16hvb,<br>
&gt; + * atmega16hvbrevb, atmega16m1, atmega16u4, atmega32a, atmega32, atme=
ga323,<br>
&gt; + * atmega324a, atmega324p, atmega324pa, atmega325, atmega325a, atmega=
325p,<br>
&gt; + * atmega325pa, atmega3250, atmega3250a, atmega3250p, atmega3250pa, a=
tmega328,<br>
&gt; + * atmega328p, atmega328pb, atmega329, atmega329a, atmega329p, atmega=
329pa,<br>
&gt; + * atmega3290, atmega3290a, atmega3290p, atmega3290pa, atmega32c1, at=
mega32m1,<br>
&gt; + * atmega32u4, atmega32u6, atmega406, atmega64, atmega64a, atmega640,=
 atmega644,<br>
&gt; + * atmega644a, atmega644p, atmega644pa, atmega645, atmega645a, atmega=
645p,<br>
&gt; + * atmega6450, atmega6450a, atmega6450p, atmega649, atmega649a, atmeg=
a649p,<br>
&gt; + * atmega6490, atmega16hva, atmega16hva2, atmega32hvb, atmega6490a, a=
tmega6490p,<br>
&gt; + * atmega64c1, atmega64m1, atmega64hve, atmega64hve2, atmega64rfr2,<b=
r>
&gt; + * atmega644rfr2, atmega32hvbrevb, at90can32, at90can64, at90pwm161, =
at90pwm216,<br>
&gt; + * at90pwm316, at90scr100, at90usb646, at90usb647, at94k, m3000<br>
&gt; + */<br>
&gt; +static void avr_avr5_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
<br>
Ok. Checked with atmega64 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avr51<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * atmega128, atmega128a, atmega1280, atmega1281, atmega1284, atmega1=
284p,<br>
&gt; + * atmega128rfa1, atmega128rfr2, atmega1284rfr2, at90can128, at90usb1=
286,<br>
&gt; + * at90usb1287<br>
&gt; + */<br>
&gt; +static void avr_avr51_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
<br>
Ok. Checked with atmega128 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avr6<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * atmega2560, atmega2561, atmega256rfr2, atmega2564rfr2<br>
&gt; + */<br>
&gt; +static void avr_avr6_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
<br>
Ok. Checked with atmega2560 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avrtiny<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * attiny4, attiny5, attiny9, attiny10, attiny20, attiny40<br>
&gt; + */<br>
&gt; +static void avr_avrtiny_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_1_BYTE_SP);<br>
<br>
The attiny4 datasheet writes:<br>
&quot;The AVR stack pointer is implemented as two 8-bit registers in the I/=
O<br>
space. The number of bits actually used is implementation dependent.&quot;<=
br>
Not using AVR_FEATURE_2_BYTE_SP isn&#39;t leaving out the ones with two<br>
bytes SP?<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type xmega2<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * atxmega8e5, atxmega16a4, atxmega16d4, atxmega16e5, atxmega32a4, at=
xmega32c3,<br>
&gt; + * atxmega32d3, atxmega32d4, atxmega16a4u, atxmega16c4, atxmega32a4u,=
<br>
&gt; + * atxmega32c4, atxmega32e5<br>
&gt; + */<br>
&gt; +static void avr_xmega2_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
<br>
Ok. Checked with atxmega8e5 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type xmega3<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * attiny212, attiny214, attiny412, attiny414, attiny416, attiny417, =
attiny814,<br>
&gt; + * attiny816, attiny817, attiny1614, attiny1616, attiny1617, attiny32=
14,<br>
&gt; + * attiny3216, attiny3217, atmega808, atmega809, atmega1608, atmega16=
09,<br>
&gt; + * atmega3208, atmega3209, atmega4808, atmega4809<br>
&gt; + */<br>
&gt; +static void avr_xmega3_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
<br>
Ok. Checked with attiny212 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type xmega4<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * atxmega64a3, atxmega64d3, atxmega64a3u, atxmega64a4u, atxmega64b1,=
<br>
&gt; + * atxmega64b3, atxmega64c3, atxmega64d4<br>
&gt; + */<br>
&gt; +static void avr_xmega4_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
<br>
Ok. I couldn&#39;t find an exact definition of the SP length but it says<br=
>
that the SRAM is used as stack. The max length of ram being 16KB.<br>
Checked with atxmega64a3 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type xmega5<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * atxmega64a1, atxmega64a1u<br>
&gt; + */<br>
&gt; +static void avr_xmega5_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
<br>
Ok. Checked with atxmega64a1 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPD);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPY);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type xmega6<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * atxmega128a3, atxmega128d3, atxmega192a3, atxmega192d3, atxmega256=
a3,<br>
&gt; + * atxmega256a3b, atxmega256a3bu, atxmega256d3, atxmega128a3u, atxmeg=
a128b1,<br>
&gt; + * atxmega128b3, atxmega128c3, atxmega128d4, atxmega192a3u, atxmega19=
2c3,<br>
&gt; + * atxmega256a3u, atxmega256c3, atxmega384c3, atxmega384d3<br>
&gt; + */<br>
&gt; +static void avr_xmega6_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
<br>
Ok. I couldn&#39;t find an exact definition of the SP length but it says<br=
>
that the SRAM is used as stack. The max length of ram being 16KB.<br>
Checked with atxmega128a3 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type xmega7<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * atxmega128a1, atxmega128a1u, atxmega128a4u<br>
&gt; + */<br>
&gt; +static void avr_xmega7_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
<br>
Ok. Checked with atxmega128a1 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPD);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPY);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
&gt; +}<br>
&gt; +<br>
&gt; +typedef struct AVRCPUInfo {<br>
&gt; +=C2=A0 =C2=A0 const char *name;<br>
&gt; +=C2=A0 =C2=A0 void (*initfn)(Object *obj);<br>
&gt; +} AVRCPUInfo;<br>
&gt; +<br>
&gt; +<br>
&gt; +static void avr_cpu_list_entry(gpointer data, gpointer user_data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 const char *typename =3D object_class_get_name(OBJECT_C=
LASS(data));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_printf(&quot;%s\n&quot;, typename);<br>
&gt; +}<br>
&gt; +<br>
&gt; +void avr_cpu_list(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 GSList *list;<br>
&gt; +=C2=A0 =C2=A0 list =3D object_class_get_list_sorted(TYPE_AVR_CPU, fal=
se);<br>
&gt; +=C2=A0 =C2=A0 g_slist_foreach(list, avr_cpu_list_entry, NULL);<br>
&gt; +=C2=A0 =C2=A0 g_slist_free(list);<br>
&gt; +}<br>
&gt; +<br>
&gt; +#define DEFINE_AVR_CPU_TYPE(model, initfn) \<br>
&gt; +=C2=A0 =C2=A0 { \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D TYPE_AVR_CPU, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_init =3D initfn, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D AVR_CPU_TYPE_NAME(model), \<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +static const TypeInfo avr_cpu_type_info[] =3D {<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D TYPE_AVR_CPU,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D TYPE_CPU,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_size =3D sizeof(AVRCPU),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_init =3D avr_cpu_initfn,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_size =3D sizeof(AVRCPUClass),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init =3D avr_cpu_class_init,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .abstract =3D true,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avrtiny&quot;, avr_avrtiny_in=
itfn),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr1&quot;, avr_avr1_initfn),=
<br>
&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr2&quot;, avr_avr2_initfn),=
<br>
&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr25&quot;, avr_avr25_initfn=
),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr3&quot;, avr_avr3_initfn),=
<br>
&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr31&quot;, avr_avr31_initfn=
),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr35&quot;, avr_avr35_initfn=
),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr4&quot;, avr_avr4_initfn),=
<br>
&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr5&quot;, avr_avr5_initfn),=
<br>
&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr51&quot;, avr_avr51_initfn=
),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr6&quot;, avr_avr6_initfn),=
<br>
&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega2&quot;, avr_xmega2_init=
fn),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega3&quot;, avr_xmega3_init=
fn),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega4&quot;, avr_xmega4_init=
fn),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega5&quot;, avr_xmega5_init=
fn),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega6&quot;, avr_xmega6_init=
fn),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega7&quot;, avr_xmega7_init=
fn),<br>
&gt; +};<br>
&gt; +<br>
&gt; +const char *avr_flags_to_cpu_type(uint32_t flags, const char *def_cpu=
_type)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 switch (flags &amp; EF_AVR_MACH) {<br>
&gt; +=C2=A0 =C2=A0 case bfd_mach_avr1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avr1&quot;=
);<br>
&gt; +=C2=A0 =C2=A0 case bfd_mach_avr2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avr2&quot;=
);<br>
&gt; +=C2=A0 =C2=A0 case bfd_mach_avr25:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avr25&quot=
;);<br>
&gt; +=C2=A0 =C2=A0 case bfd_mach_avr3:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avr3&quot;=
);<br>
&gt; +=C2=A0 =C2=A0 case bfd_mach_avr31:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avr31&quot=
;);<br>
&gt; +=C2=A0 =C2=A0 case bfd_mach_avr35:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avr35&quot=
;);<br>
&gt; +=C2=A0 =C2=A0 case bfd_mach_avr4:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avr4&quot;=
);<br>
&gt; +=C2=A0 =C2=A0 case bfd_mach_avr5:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avr5&quot;=
);<br>
&gt; +=C2=A0 =C2=A0 case bfd_mach_avr51:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avr51&quot=
;);<br>
&gt; +=C2=A0 =C2=A0 case bfd_mach_avr6:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avr6&quot;=
);<br>
&gt; +=C2=A0 =C2=A0 case bfd_mach_avrtiny:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avrtiny&qu=
ot;);<br>
&gt; +=C2=A0 =C2=A0 case bfd_mach_avrxmega2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;xmega2&quo=
t;);<br>
&gt; +=C2=A0 =C2=A0 case bfd_mach_avrxmega3:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;xmega3&quo=
t;);<br>
&gt; +=C2=A0 =C2=A0 case bfd_mach_avrxmega4:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;xmega4&quo=
t;);<br>
&gt; +=C2=A0 =C2=A0 case bfd_mach_avrxmega5:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;xmega5&quo=
t;);<br>
&gt; +=C2=A0 =C2=A0 case bfd_mach_avrxmega6:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;xmega6&quo=
t;);<br>
&gt; +=C2=A0 =C2=A0 case bfd_mach_avrxmega7:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;xmega7&quo=
t;);<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return def_cpu_type;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +DEFINE_TYPES(avr_cpu_type_info)<br>
&gt; diff --git a/target/avr/gdbstub.c b/target/avr/gdbstub.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..733184c08f<br>
&gt; --- /dev/null<br>
&gt; +++ b/target/avr/gdbstub.c<br>
&gt; @@ -0,0 +1,84 @@<br>
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
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;exec/gdbstub.h&quot;<br>
&gt; +<br>
&gt; +int avr_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*=C2=A0 R */<br>
&gt; +=C2=A0 =C2=A0 if (n &lt; 32) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(mem_buf, env-&gt;r[n]=
);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*=C2=A0 SREG */<br>
&gt; +=C2=A0 =C2=A0 if (n =3D=3D 32) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t sreg =3D cpu_get_sreg(env);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(mem_buf, sreg);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*=C2=A0 SP */<br>
&gt; +=C2=A0 =C2=A0 if (n =3D=3D 33) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg16(mem_buf, env-&gt;sp =
&amp; 0x0000ffff);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*=C2=A0 PC */<br>
&gt; +=C2=A0 =C2=A0 if (n =3D=3D 34) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env-&gt;pc_=
w * 2);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +int avr_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*=C2=A0 R */<br>
&gt; +=C2=A0 =C2=A0 if (n &lt; 32) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;r[n] =3D *mem_buf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*=C2=A0 SREG */<br>
&gt; +=C2=A0 =C2=A0 if (n =3D=3D 32) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_set_sreg(env, *mem_buf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*=C2=A0 SP */<br>
&gt; +=C2=A0 =C2=A0 if (n =3D=3D 33) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;sp =3D lduw_p(mem_buf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 2;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*=C2=A0 PC */<br>
&gt; +=C2=A0 =C2=A0 if (n =3D=3D 34) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;pc_w =3D ldl_p(mem_buf) / 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 4;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; diff --git a/target/avr/machine.c b/target/avr/machine.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..ba44bd042b<br>
&gt; --- /dev/null<br>
&gt; +++ b/target/avr/machine.c<br>
&gt; @@ -0,0 +1,121 @@<br>
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
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;cpu.h&quot;<br>
&gt; +#include &quot;migration/cpu.h&quot;<br>
&gt; +<br>
&gt; +static int get_sreg(QEMUFile *f, void *opaque, size_t size,<br>
&gt; +=C2=A0 =C2=A0 const VMStateField *field)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 uint8_t sreg;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sreg =3D qemu_get_byte(f);<br>
&gt; +=C2=A0 =C2=A0 cpu_set_sreg(env, sreg);<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int put_sreg(<br>
&gt; +=C2=A0 =C2=A0 QEMUFile *f, void *opaque, size_t size,<br>
&gt; +=C2=A0 =C2=A0 const VMStateField *field, QJSON *vmdesc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 uint8_t sreg =3D cpu_get_sreg(env);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_put_byte(f, sreg);<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const VMStateInfo vms_sreg =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D &quot;sreg&quot;,<br>
&gt; +=C2=A0 =C2=A0 .get =3D get_sreg,<br>
&gt; +=C2=A0 =C2=A0 .put =3D put_sreg,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int get_segment(<br>
&gt; +=C2=A0 =C2=A0 QEMUFile *f, void *opaque, size_t size, const VMStateFi=
eld *field)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t *ramp =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 uint8_t temp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 temp =3D qemu_get_byte(f);<br>
&gt; +=C2=A0 =C2=A0 *ramp =3D ((uint32_t)temp) &lt;&lt; 16;<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int put_segment(<br>
&gt; +=C2=A0 =C2=A0 QEMUFile *f, void *opaque, size_t size,<br>
&gt; +=C2=A0 =C2=A0 const VMStateField *field, QJSON *vmdesc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t *ramp =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 uint8_t temp =3D *ramp &gt;&gt; 16;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_put_byte(f, temp);<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const VMStateInfo vms_rampD =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D &quot;rampD&quot;,<br>
&gt; +=C2=A0 =C2=A0 .get =3D get_segment,<br>
&gt; +=C2=A0 =C2=A0 .put =3D put_segment,<br>
&gt; +};<br>
&gt; +static const VMStateInfo vms_rampX =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D &quot;rampX&quot;,<br>
&gt; +=C2=A0 =C2=A0 .get =3D get_segment,<br>
&gt; +=C2=A0 =C2=A0 .put =3D put_segment,<br>
&gt; +};<br>
&gt; +static const VMStateInfo vms_rampY =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D &quot;rampY&quot;,<br>
&gt; +=C2=A0 =C2=A0 .get =3D get_segment,<br>
&gt; +=C2=A0 =C2=A0 .put =3D put_segment,<br>
&gt; +};<br>
&gt; +static const VMStateInfo vms_rampZ =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D &quot;rampZ&quot;,<br>
&gt; +=C2=A0 =C2=A0 .get =3D get_segment,<br>
&gt; +=C2=A0 =C2=A0 .put =3D put_segment,<br>
&gt; +};<br>
&gt; +static const VMStateInfo vms_eind =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D &quot;eind&quot;,<br>
&gt; +=C2=A0 =C2=A0 .get =3D get_segment,<br>
&gt; +=C2=A0 =C2=A0 .put =3D put_segment,<br>
&gt; +};<br>
&gt; +<br>
&gt; +const VMStateDescription vms_avr_cpu =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D &quot;cpu&quot;,<br>
&gt; +=C2=A0 =C2=A0 .version_id =3D 0,<br>
&gt; +=C2=A0 =C2=A0 .minimum_version_id =3D 0,<br>
&gt; +=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(env.pc_w, AVRCPU),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(env.sp, AVRCPU),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(env.skip, AVRCPU),<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(env.r, AVRCPU, NUMBE=
R_OF_CPU_REGISTERS),<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_SINGLE(env, AVRCPU, 0, vms_sreg, =
CPUAVRState),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_SINGLE(env.rampD, AVRCPU, 0, vms_=
rampD, uint32_t),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_SINGLE(env.rampX, AVRCPU, 0, vms_=
rampX, uint32_t),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_SINGLE(env.rampY, AVRCPU, 0, vms_=
rampY, uint32_t),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_SINGLE(env.rampZ, AVRCPU, 0, vms_=
rampZ, uint32_t),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_SINGLE(env.eind, AVRCPU, 0, vms_e=
ind, uint32_t),<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +};<br>
&gt; diff --git a/gdb-xml/avr-cpu.xml b/gdb-xml/avr-cpu.xml<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..c4747f5b40<br>
&gt; --- /dev/null<br>
&gt; +++ b/gdb-xml/avr-cpu.xml<br>
&gt; @@ -0,0 +1,49 @@<br>
&gt; +&lt;?xml version=3D&quot;1.0&quot;?&gt;<br>
&gt; +&lt;!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0Copying and distribution of this file, with or wi=
thout modification,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0are permitted in any medium without royalty provi=
ded the copyright<br>
&gt; +=C2=A0 =C2=A0 =C2=A0notice and this notice are preserved.=C2=A0 --&gt=
;<br>
&gt; +<br>
&gt; +&lt;!-- Register numbers are hard-coded in order to maintain backward=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0compatibility with older versions of tools that d=
idn&#39;t use xml<br>
&gt; +=C2=A0 =C2=A0 =C2=A0register descriptions.=C2=A0 --&gt;<br>
&gt; +<br>
&gt; +&lt;!DOCTYPE feature SYSTEM &quot;gdb-target.dtd&quot;&gt;<br>
&gt; +&lt;feature name=3D&quot;org.gnu.gdb.riscv.cpu&quot;&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r0&quot; bitsize=3D&quot;8&quot; type=3D&=
quot;int&quot; regnum=3D&quot;0&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r1&quot; bitsize=3D&quot;8&quot; type=3D&=
quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r2&quot; bitsize=3D&quot;8&quot; type=3D&=
quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r3&quot; bitsize=3D&quot;8&quot; type=3D&=
quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r4&quot; bitsize=3D&quot;8&quot; type=3D&=
quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r5&quot; bitsize=3D&quot;8&quot; type=3D&=
quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r6&quot; bitsize=3D&quot;8&quot; type=3D&=
quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r7&quot; bitsize=3D&quot;8&quot; type=3D&=
quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r8&quot; bitsize=3D&quot;8&quot; type=3D&=
quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r9&quot; bitsize=3D&quot;8&quot; type=3D&=
quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r10&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r11&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r12&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r13&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r14&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r15&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r16&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r17&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r18&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r19&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r20&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r21&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r22&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r23&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r24&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r25&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r26&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r27&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r28&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r29&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r30&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;r31&quot; bitsize=3D&quot;8&quot; type=3D=
&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;sreg&quot; bitsize=3D&quot;8&quot; type=
=3D&quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;sp&quot; bitsize=3D&quot;8&quot; type=3D&=
quot;int&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;pc&quot; bitsize=3D&quot;8&quot; type=3D&=
quot;int&quot;/&gt;<br>
&gt; +&lt;/feature&gt;<br>
&gt; <br>
<br>
General concern: why is there an AVR_FEATURE_1_BYTE_PC when the code<br>
does nothing with it?<br>
<br>
--Joa<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--000000000000d5e7f8059d1b3fd1--

