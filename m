Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C36C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 01:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3282071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 01:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPrbkGXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3282071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ3Cc-0001OS-Jf
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 20:30:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZ3Bh-0000xo-DX
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 20:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZ3BZ-0004p9-Ec
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 20:29:13 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:32912)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZ3BZ-0004p5-2c
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 20:29:05 -0500
Received: by mail-ot1-x343.google.com with SMTP id q23so5334505otn.0
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2019 17:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=qRQopyIcYeDJ9lMz8VKv+ZCscxLkRcagJvJOekVUeD0=;
 b=LPrbkGXQlrnljRhamWPvhbAVS74XD71k8xdr+RLIw5eLwxRFGgpAnWPGKTi8/jURWE
 OaKL97PZGizDmY3U25iFg32bWt6eK+Rt8PXl0MmjQcthhiuokko03pzs7nAxdwDVXdRK
 UUV/bYqBiz7TTk3oikh7OGEbAxCiQfUlXWNLIsyHRtR/SRpLwUQJgUH5ajR21VUo9u36
 UTe4dW590yG3ISb2CxTiTO1dwod6cCY1RD03KPHzk/1vbJgUMhU5XHVZVpoSkUqZ7afA
 pnO/NmVewbkp8ZGchnUwUtawTiV8aa+mvF2I1R3Xls3v3PFJkbSQQU0VNsfIQr5oXtEd
 wjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=qRQopyIcYeDJ9lMz8VKv+ZCscxLkRcagJvJOekVUeD0=;
 b=FUAik/f8wcERahCE4qBkT+HUT6Z9Y02s+6FLZMNxRZWil6Qc7e2GhGwHhWbOYJh5WP
 83stKI+axBPwNyUq2FNSNC8rZyHP9GK++pdctj1OAH7BVt63oJOw9PgU67LP0AO0bdiR
 WQEJtX1f1hN3xVhoZ0VXQoQxmGcXgRkMY8iAr+flpYj63jFa7hIZqlR7HGTBDNujftll
 CourOhvNwMYOlrMAHEO2VlwTvEmOatxhpDnmf+SXFUD4I19xjTXlEUX2UJdnkKQzbNrk
 6NvEBpK4bgvteKSr65Pm2ubSY8Y3FaD72nKbDvI0OuA0/M81vX9TPvLnA8tgcHO0FFAw
 bJ7Q==
X-Gm-Message-State: APjAAAWQTe8WTiZpFbdQ6LAibtrfLPjws5sF/ntjx2YQW1aC0GUtoUNz
 1di6wR6nPa5SFQJWXrHXu0uUthVJGjJ83dI+h0Y=
X-Google-Smtp-Source: APXvYqydqAG+yMnHUQjHqERQ6k7tSKVKc6ATmTuHxDhgByuKPopPtZRgA/4BDbeOmQ8YqaSJ9g0NAP5U4VyAWMhBH2U=
X-Received: by 2002:a05:6830:1383:: with SMTP id
 d3mr18530629otq.306.1574645343869; 
 Sun, 24 Nov 2019 17:29:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sun, 24 Nov 2019 17:29:03
 -0800 (PST)
In-Reply-To: <20191124050225.30351-2-mrolnik@gmail.com>
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-2-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 25 Nov 2019 02:29:03 +0100
Message-ID: <CAL1e-=jnkttW+czjfQR6CKm6UMnFfZ81pQzudwx8qBzfH_zdkg@mail.gmail.com>
Subject: Re: [PATCH v36 01/17] target/avr: Add outward facing interfaces and
 core CPU logic
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000005e5fb7059821b04f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005e5fb7059821b04f
Content-Type: text/plain; charset="UTF-8"

On Sunday, November 24, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> This includes:
> - CPU data structures
> - object model classes and functions
> - migration functions
> - GDB hooks
>
> Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
> Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  target/avr/cpu-param.h |  37 +++
>  target/avr/cpu-qom.h   |  54 ++++
>  target/avr/cpu.h       | 253 ++++++++++++++++++
>  target/avr/cpu.c       | 576 +++++++++++++++++++++++++++++++++++++++++
>  target/avr/gdbstub.c   |  85 ++++++
>  target/avr/machine.c   | 121 +++++++++
>  gdb-xml/avr-cpu.xml    |  49 ++++
>  7 files changed, 1175 insertions(+)


Very good!! Thanks a lot!! I see you ran the script git.orderfile, and now
headers appear before c files! Even in thsi changed file summary. In v35,
it used to be:

 gdb-xml/avr-cpu.xml    |  49 ++++
 target/avr/cpu-param.h |  37 +++
 target/avr/cpu-qom.h   |  54 ++++
 target/avr/cpu.c       | 576 +++++++++++++++++++++++++++++++++++++++++
 target/avr/cpu.h       | 253 ++++++++++++++++++
 target/avr/gdbstub.c   |  85 ++++++
 target/avr/machine.c   | 121 +++++++++
 7 files changed, 1175 insertions(+)


>  create mode 100644 target/avr/cpu-param.h
>  create mode 100644 target/avr/cpu-qom.h
>  create mode 100644 target/avr/cpu.h
>  create mode 100644 target/avr/cpu.c
>  create mode 100644 target/avr/gdbstub.c
>  create mode 100644 target/avr/machine.c
>  create mode 100644 gdb-xml/avr-cpu.xml
>
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
> + * 1.  all IO registers occupy [0x0000 .. 0x00ff] address range, and they
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
> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> new file mode 100644
> index 0000000000..ed9218af5f
> --- /dev/null
> +++ b/target/avr/cpu.h
> @@ -0,0 +1,253 @@
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
> +#ifndef QEMU_AVR_CPU_H
> +#define QEMU_AVR_CPU_H
> +
> +#include "cpu-qom.h"
> +#include "exec/cpu-defs.h"
> +
> +#define TCG_GUEST_DEFAULT_MO 0
> +
> +#define CPU_RESOLVING_TYPE TYPE_AVR_CPU
> +
> +/*
> + * AVR has two memory spaces, data & code.
> + * e.g. both have 0 address
> + * ST/LD instructions access data space
> + * LPM/SPM and instruction fetching access code memory space
> + */
> +#define MMU_CODE_IDX 0
> +#define MMU_DATA_IDX 1
> +
> +#define EXCP_RESET 1
> +#define EXCP_INT(n) (EXCP_RESET + (n) + 1)
> +
> +/* Number of CPU registers */
> +#define NO_CPU_REGISTERS 32
> +/* Number of IO registers accessible by ld/st/in/out */
> +#define NO_IO_REGISTERS 64
> +
> +/*
> + * Offsets of AVR memory regions in host memory space.
> + *
> + * This is needed because the AVR has separate code and data address
> + * spaces that both have start from zero but have to go somewhere in
> + * host memory.
> + *
> + * It's also useful to know where some things are, like the IO registers.
> + */
> +/* Flash program memory */
> +#define OFFSET_CODE 0x00000000
> +/* CPU registers, IO registers, and SRAM */
> +#define OFFSET_DATA 0x00800000
> +/* CPU registers specifically, these are mapped at the start of data */
> +#define OFFSET_CPU_REGISTERS OFFSET_DATA
> +/*
> + * IO registers, including status register, stack pointer, and memory
> + * mapped peripherals, mapped just after CPU registers
> + */
> +#define OFFSET_IO_REGISTERS (OFFSET_DATA + NO_CPU_REGISTERS)
> +
> +enum avr_features {
> +    AVR_FEATURE_SRAM,
> +
> +    AVR_FEATURE_1_BYTE_PC,
> +    AVR_FEATURE_2_BYTE_PC,
> +    AVR_FEATURE_3_BYTE_PC,
> +
> +    AVR_FEATURE_1_BYTE_SP,
> +    AVR_FEATURE_2_BYTE_SP,
> +
> +    AVR_FEATURE_BREAK,
> +    AVR_FEATURE_DES,
> +    AVR_FEATURE_RMW, /* Read Modify Write - XCH LAC LAS LAT */
> +
> +    AVR_FEATURE_EIJMP_EICALL,
> +    AVR_FEATURE_IJMP_ICALL,
> +    AVR_FEATURE_JMP_CALL,
> +
> +    AVR_FEATURE_ADIW_SBIW,
> +
> +    AVR_FEATURE_SPM,
> +    AVR_FEATURE_SPMX,
> +
> +    AVR_FEATURE_ELPMX,
> +    AVR_FEATURE_ELPM,
> +    AVR_FEATURE_LPMX,
> +    AVR_FEATURE_LPM,
> +
> +    AVR_FEATURE_MOVW,
> +    AVR_FEATURE_MUL,
> +    AVR_FEATURE_RAMPD,
> +    AVR_FEATURE_RAMPX,
> +    AVR_FEATURE_RAMPY,
> +    AVR_FEATURE_RAMPZ,
> +};
> +
> +typedef struct CPUAVRState CPUAVRState;
> +
> +struct CPUAVRState {
> +    uint32_t pc_w; /* 0x003fffff up to 22 bits */
> +
> +    uint32_t sregC; /* 0x00000001 1 bit */
> +    uint32_t sregZ; /* 0x00000001 1 bit */
> +    uint32_t sregN; /* 0x00000001 1 bit */
> +    uint32_t sregV; /* 0x00000001 1 bit */
> +    uint32_t sregS; /* 0x00000001 1 bit */
> +    uint32_t sregH; /* 0x00000001 1 bit */
> +    uint32_t sregT; /* 0x00000001 1 bit */
> +    uint32_t sregI; /* 0x00000001 1 bit */
> +
> +    uint32_t rampD; /* 0x00ff0000 8 bits */
> +    uint32_t rampX; /* 0x00ff0000 8 bits */
> +    uint32_t rampY; /* 0x00ff0000 8 bits */
> +    uint32_t rampZ; /* 0x00ff0000 8 bits */
> +    uint32_t eind; /* 0x00ff0000 8 bits */
> +
> +    uint32_t r[NO_CPU_REGISTERS]; /* 8 bits each */
> +    uint32_t sp; /* 16 bits */
> +
> +    uint32_t skip; /* if set skip instruction */
> +
> +    uint64_t intsrc; /* interrupt sources */
> +    bool fullacc; /* CPU/MEM if true MEM only otherwise */
> +
> +    uint32_t features;
> +};
> +
> +/**
> + *  AVRCPU:
> + *  @env: #CPUAVRState
> + *
> + *  A AVR CPU.
> + */
> +typedef struct AVRCPU {
> +    /*< private >*/
> +    CPUState parent_obj;
> +    /*< public >*/
> +
> +    CPUNegativeOffsetState neg;
> +    CPUAVRState env;
> +} AVRCPU;
> +
> +#ifndef CONFIG_USER_ONLY
> +extern const struct VMStateDescription vms_avr_cpu;
> +#endif
> +
> +void avr_cpu_do_interrupt(CPUState *cpu);
> +bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
> +hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> +int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
> +int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> +
> +static inline int avr_feature(CPUAVRState *env, int feature)
> +{
> +    return (env->features & (1U << feature)) != 0;
> +}
> +
> +static inline void avr_set_feature(CPUAVRState *env, int feature)
> +{
> +    env->features |= (1U << feature);
> +}
> +
> +#define cpu_list avr_cpu_list
> +#define cpu_signal_handler cpu_avr_signal_handler
> +#define cpu_mmu_index avr_cpu_mmu_index
> +
> +static inline int avr_cpu_mmu_index(CPUAVRState *env, bool ifetch)
> +{
> +    return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
> +}
> +
> +void avr_cpu_tcg_init(void);
> +
> +void avr_cpu_list(void);
> +int cpu_avr_exec(CPUState *cpu);
> +int cpu_avr_signal_handler(int host_signum, void *pinfo, void *puc);
> +int avr_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
> +                                int rw, int mmu_idx);
> +int avr_cpu_memory_rw_debug(CPUState *cs, vaddr address, uint8_t *buf,
> +                                int len, bool is_write);
> +
> +enum {
> +    TB_FLAGS_FULL_ACCESS = 1,
> +    TB_FLAGS_SKIP = 2,
> +};
> +
> +static inline void cpu_get_tb_cpu_state(CPUAVRState *env, target_ulong
> *pc,
> +                                target_ulong *cs_base, uint32_t *pflags)
> +{
> +    uint32_t flags = 0;
> +
> +    *pc = env->pc_w * 2;
> +    *cs_base = 0;
> +
> +    if (env->fullacc) {
> +        flags |= TB_FLAGS_FULL_ACCESS;
> +    }
> +    if (env->skip) {
> +        flags |= TB_FLAGS_SKIP;
> +    }
> +
> +    *pflags = flags;
> +}
> +
> +static inline int cpu_interrupts_enabled(CPUAVRState *env)
> +{
> +    return env->sregI != 0;
> +}
> +
> +static inline uint8_t cpu_get_sreg(CPUAVRState *env)
> +{
> +    uint8_t sreg;
> +    sreg = (env->sregC) << 0
> +         | (env->sregZ) << 1
> +         | (env->sregN) << 2
> +         | (env->sregV) << 3
> +         | (env->sregS) << 4
> +         | (env->sregH) << 5
> +         | (env->sregT) << 6
> +         | (env->sregI) << 7;
> +    return sreg;
> +}
> +
> +static inline void cpu_set_sreg(CPUAVRState *env, uint8_t sreg)
> +{
> +    env->sregC = (sreg >> 0) & 0x01;
> +    env->sregZ = (sreg >> 1) & 0x01;
> +    env->sregN = (sreg >> 2) & 0x01;
> +    env->sregV = (sreg >> 3) & 0x01;
> +    env->sregS = (sreg >> 4) & 0x01;
> +    env->sregH = (sreg >> 5) & 0x01;
> +    env->sregT = (sreg >> 6) & 0x01;
> +    env->sregI = (sreg >> 7) & 0x01;
> +}
> +
> +bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                        MMUAccessType access_type, int mmu_idx,
> +                        bool probe, uintptr_t retaddr);
> +
> +typedef CPUAVRState CPUArchState;
> +typedef AVRCPU ArchCPU;
> +
> +#include "exec/cpu-all.h"
> +
> +#endif /* !defined (QEMU_AVR_CPU_H) */
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
> +    AVRCPU *cpu = AVR_CPU(cs);
> +
> +    cpu->env.pc_w = value / 2; /* internally PC points to words */
> +}
> +
> +static bool avr_cpu_has_work(CPUState *cs)
> +{
> +    AVRCPU *cpu = AVR_CPU(cs);
> +    CPUAVRState *env = &cpu->env;
> +
> +    return (cs->interrupt_request & (CPU_INTERRUPT_HARD |
> CPU_INTERRUPT_RESET))
> +            && cpu_interrupts_enabled(env);
> +}
> +
> +static void avr_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock
> *tb)
> +{
> +    AVRCPU *cpu = AVR_CPU(cs);
> +    CPUAVRState *env = &cpu->env;
> +
> +    env->pc_w = tb->pc / 2; /* internally PC points to words */
> +}
> +
> +static void avr_cpu_reset(CPUState *cs)
> +{
> +    AVRCPU *cpu = AVR_CPU(cs);
> +    AVRCPUClass *mcc = AVR_CPU_GET_CLASS(cpu);
> +    CPUAVRState *env = &cpu->env;
> +
> +    mcc->parent_reset(cs);
> +
> +    env->pc_w = 0;
> +    env->sregI = 1;
> +    env->sregC = 0;
> +    env->sregZ = 0;
> +    env->sregN = 0;
> +    env->sregV = 0;
> +    env->sregS = 0;
> +    env->sregH = 0;
> +    env->sregT = 0;
> +
> +    env->rampD = 0;
> +    env->rampX = 0;
> +    env->rampY = 0;
> +    env->rampZ = 0;
> +    env->eind = 0;
> +    env->sp = 0;
> +
> +    env->skip = 0;
> +
> +    memset(env->r, 0, sizeof(env->r));
> +
> +    tlb_flush(cs);
> +}
> +
> +static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
> +{
> +    info->mach = bfd_arch_avr;
> +    info->print_insn = NULL;
> +}
> +
> +static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
> +{
> +    CPUState *cs = CPU(dev);
> +    AVRCPUClass *mcc = AVR_CPU_GET_CLASS(dev);
> +    Error *local_err = NULL;
> +
> +    cpu_exec_realizefn(cs, &local_err);
> +    if (local_err != NULL) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    qemu_init_vcpu(cs);
> +    cpu_reset(cs);
> +
> +    mcc->parent_realize(dev, errp);
> +}
> +
> +static void avr_cpu_set_int(void *opaque, int irq, int level)
> +{
> +    AVRCPU *cpu = opaque;
> +    CPUAVRState *env = &cpu->env;
> +    CPUState *cs = CPU(cpu);
> +
> +    uint64_t mask = (1ull << irq);
> +    if (level) {
> +        env->intsrc |= mask;
> +        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> +    } else {
> +        env->intsrc &= ~mask;
> +        if (env->intsrc == 0) {
> +            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> +        }
> +    }
> +}
> +
> +static void avr_cpu_initfn(Object *obj)
> +{
> +    AVRCPU *cpu = AVR_CPU(obj);
> +
> +    cpu_set_cpustate_pointers(cpu);
> +
> +#ifndef CONFIG_USER_ONLY
> +    /* Set the number of interrupts supported by the CPU. */
> +    qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int, 57);
> +#endif
> +}
> +
> +static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
> +{
> +    ObjectClass *oc;
> +
> +    oc = object_class_by_name(cpu_model);
> +    if (object_class_dynamic_cast(oc, TYPE_AVR_CPU) == NULL ||
> +        object_class_is_abstract(oc)) {
> +        oc = NULL;
> +    }
> +    return oc;
> +}
> +
> +static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
> +{
> +    AVRCPU *cpu = AVR_CPU(cs);
> +    CPUAVRState *env = &cpu->env;
> +    int i;
> +
> +    qemu_fprintf(f, "\n");
> +    qemu_fprintf(f, "PC:    %06x\n", env->pc_w);
> +    qemu_fprintf(f, "SP:      %04x\n", env->sp);
> +    qemu_fprintf(f, "rampD:     %02x\n", env->rampD >> 16);
> +    qemu_fprintf(f, "rampX:     %02x\n", env->rampX >> 16);
> +    qemu_fprintf(f, "rampY:     %02x\n", env->rampY >> 16);
> +    qemu_fprintf(f, "rampZ:     %02x\n", env->rampZ >> 16);
> +    qemu_fprintf(f, "EIND:      %02x\n", env->eind >> 16);
> +    qemu_fprintf(f, "X:       %02x%02x\n", env->r[27], env->r[26]);
> +    qemu_fprintf(f, "Y:       %02x%02x\n", env->r[29], env->r[28]);
> +    qemu_fprintf(f, "Z:       %02x%02x\n", env->r[31], env->r[30]);
> +    qemu_fprintf(f, "SREG:    [ %c %c %c %c %c %c %c %c ]\n",
> +                        env->sregI ? 'I' : '-',
> +                        env->sregT ? 'T' : '-',
> +                        env->sregH ? 'H' : '-',
> +                        env->sregS ? 'S' : '-',
> +                        env->sregV ? 'V' : '-',
> +                        env->sregN ? '-' : 'N', /* Zf has negative logic
> */
> +                        env->sregZ ? 'Z' : '-',
> +                        env->sregC ? 'I' : '-');
> +    qemu_fprintf(f, "SKIP:    %02x\n", env->skip);
> +
> +    qemu_fprintf(f, "\n");
> +    for (i = 0; i < ARRAY_SIZE(env->r); i++) {
> +        qemu_fprintf(f, "R[%02d]:  %02x   ", i, env->r[i]);
> +
> +        if ((i % 8) == 7) {
> +            qemu_fprintf(f, "\n");
> +        }
> +    }
> +    qemu_fprintf(f, "\n");
> +}
> +
> +static void avr_cpu_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    CPUClass *cc = CPU_CLASS(oc);
> +    AVRCPUClass *mcc = AVR_CPU_CLASS(oc);
> +
> +    mcc->parent_realize = dc->realize;
> +    dc->realize = avr_cpu_realizefn;
> +
> +    mcc->parent_reset = cc->reset;
> +    cc->reset = avr_cpu_reset;
> +
> +    cc->class_by_name = avr_cpu_class_by_name;
> +
> +    cc->has_work = avr_cpu_has_work;
> +    cc->do_interrupt = avr_cpu_do_interrupt;
> +    cc->cpu_exec_interrupt = avr_cpu_exec_interrupt;
> +    cc->dump_state = avr_cpu_dump_state;
> +    cc->set_pc = avr_cpu_set_pc;
> +#if !defined(CONFIG_USER_ONLY)
> +    cc->memory_rw_debug = avr_cpu_memory_rw_debug;
> +#endif
> +#ifdef CONFIG_USER_ONLY
> +    cc->handle_mmu_fault = avr_cpu_handle_mmu_fault;
> +#else
> +    cc->get_phys_page_debug = avr_cpu_get_phys_page_debug;
> +    cc->vmsd = &vms_avr_cpu;
> +#endif
> +    cc->disas_set_info = avr_cpu_disas_set_info;
> +    cc->tlb_fill = avr_cpu_tlb_fill;
> +    cc->tcg_initialize = avr_cpu_tcg_init;
> +    cc->synchronize_from_tb = avr_cpu_synchronize_from_tb;
> +    cc->gdb_read_register = avr_cpu_gdb_read_register;
> +    cc->gdb_write_register = avr_cpu_gdb_write_register;
> +    cc->gdb_num_core_regs = 35;
> +    cc->gdb_core_xml_file = "avr-cpu.xml";
> +}
> +
> +static void avr_avr1_initfn(Object *obj)
> +{
> +    AVRCPU *cpu = AVR_CPU(obj);
> +    CPUAVRState *env = &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +}
> +
> +static void avr_avr2_initfn(Object *obj)
> +{
> +    AVRCPU *cpu = AVR_CPU(obj);
> +    CPUAVRState *env = &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +}
> +
> +static void avr_avr25_initfn(Object *obj)
> +{
> +    AVRCPU *cpu = AVR_CPU(obj);
> +    CPUAVRState *env = &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);
> +}
> +
> +static void avr_avr3_initfn(Object *obj)
> +{
> +    AVRCPU *cpu = AVR_CPU(obj);
> +    CPUAVRState *env = &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> +}
> +
> +static void avr_avr31_initfn(Object *obj)
> +{
> +    AVRCPU *cpu = AVR_CPU(obj);
> +    CPUAVRState *env = &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> +    avr_set_feature(env, AVR_FEATURE_ELPM);
> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> +}
> +
> +static void avr_avr35_initfn(Object *obj)
> +{
> +    AVRCPU *cpu = AVR_CPU(obj);
> +    CPUAVRState *env = &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);
> +}
> +
> +static void avr_avr4_initfn(Object *obj)
> +{
> +    AVRCPU *cpu = AVR_CPU(obj);
> +    CPUAVRState *env = &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);
> +    avr_set_feature(env, AVR_FEATURE_MUL);
> +}
> +
> +static void avr_avr5_initfn(Object *obj)
> +{
> +    AVRCPU *cpu = AVR_CPU(obj);
> +    CPUAVRState *env = &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);
> +    avr_set_feature(env, AVR_FEATURE_MUL);
> +}
> +
> +static void avr_avr51_initfn(Object *obj)
> +{
> +    AVRCPU *cpu = AVR_CPU(obj);
> +    CPUAVRState *env = &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> +    avr_set_feature(env, AVR_FEATURE_ELPM);
> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);
> +    avr_set_feature(env, AVR_FEATURE_MUL);
> +}
> +
> +static void avr_avr6_initfn(Object *obj)
> +{
> +    AVRCPU *cpu = AVR_CPU(obj);
> +    CPUAVRState *env = &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
> +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> +    avr_set_feature(env, AVR_FEATURE_ELPM);
> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);
> +    avr_set_feature(env, AVR_FEATURE_MUL);
> +}
> +
> +static void avr_xmega2_initfn(Object *obj)
> +{
> +    AVRCPU *cpu = AVR_CPU(obj);
> +    CPUAVRState *env = &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);
> +    avr_set_feature(env, AVR_FEATURE_MUL);
> +    avr_set_feature(env, AVR_FEATURE_RMW);
> +}
> +
> +static void avr_xmega4_initfn(Object *obj)
> +{
> +    AVRCPU *cpu = AVR_CPU(obj);
> +    CPUAVRState *env = &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> +    avr_set_feature(env, AVR_FEATURE_ELPM);
> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);
> +    avr_set_feature(env, AVR_FEATURE_MUL);
> +    avr_set_feature(env, AVR_FEATURE_RMW);
> +}
> +
> +static void avr_xmega5_initfn(Object *obj)
> +{
> +    AVRCPU *cpu = AVR_CPU(obj);
> +    CPUAVRState *env = &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_RAMPD);
> +    avr_set_feature(env, AVR_FEATURE_RAMPX);
> +    avr_set_feature(env, AVR_FEATURE_RAMPY);
> +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> +    avr_set_feature(env, AVR_FEATURE_ELPM);
> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);
> +    avr_set_feature(env, AVR_FEATURE_MUL);
> +    avr_set_feature(env, AVR_FEATURE_RMW);
> +}
> +
> +static void avr_xmega6_initfn(Object *obj)
> +{
> +    AVRCPU *cpu = AVR_CPU(obj);
> +    CPUAVRState *env = &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
> +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> +    avr_set_feature(env, AVR_FEATURE_ELPM);
> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);
> +    avr_set_feature(env, AVR_FEATURE_MUL);
> +    avr_set_feature(env, AVR_FEATURE_RMW);
> +}
> +
> +static void avr_xmega7_initfn(Object *obj)
> +{
> +    AVRCPU *cpu = AVR_CPU(obj);
> +    CPUAVRState *env = &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_RAMPD);
> +    avr_set_feature(env, AVR_FEATURE_RAMPX);
> +    avr_set_feature(env, AVR_FEATURE_RAMPY);
> +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
> +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> +    avr_set_feature(env, AVR_FEATURE_ELPM);
> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);
> +    avr_set_feature(env, AVR_FEATURE_MUL);
> +    avr_set_feature(env, AVR_FEATURE_RMW);
> +}
> +
> +typedef struct AVRCPUInfo {
> +    const char *name;
> +    void (*initfn)(Object *obj);
> +} AVRCPUInfo;
> +
> +
> +static void avr_cpu_list_entry(gpointer data, gpointer user_data)
> +{
> +    const char *typename = object_class_get_name(OBJECT_CLASS(data));
> +
> +    qemu_printf("%s\n", typename);
> +}
> +
> +void avr_cpu_list(void)
> +{
> +    GSList *list;
> +    list = object_class_get_list_sorted(TYPE_AVR_CPU, false);
> +    g_slist_foreach(list, avr_cpu_list_entry, NULL);
> +    g_slist_free(list);
> +}
> +
> +#define DEFINE_AVR_CPU_TYPE(model, initfn) \
> +    { \
> +        .parent = TYPE_AVR_CPU, \
> +        .instance_init = initfn, \
> +        .name = model "-avr-cpu", \
> +    }
> +
> +static const TypeInfo avr_cpu_type_info[] = {
> +    {
> +        .name = TYPE_AVR_CPU,
> +        .parent = TYPE_CPU,
> +        .instance_size = sizeof(AVRCPU),
> +        .instance_init = avr_cpu_initfn,
> +        .class_size = sizeof(AVRCPUClass),
> +        .class_init = avr_cpu_class_init,
> +        .abstract = true,
> +    },
> +    DEFINE_AVR_CPU_TYPE("avr1", avr_avr1_initfn),
> +    DEFINE_AVR_CPU_TYPE("avr2", avr_avr2_initfn),
> +    DEFINE_AVR_CPU_TYPE("avr25", avr_avr25_initfn),
> +    DEFINE_AVR_CPU_TYPE("avr3", avr_avr3_initfn),
> +    DEFINE_AVR_CPU_TYPE("avr31", avr_avr31_initfn),
> +    DEFINE_AVR_CPU_TYPE("avr35", avr_avr35_initfn),
> +    DEFINE_AVR_CPU_TYPE("avr4", avr_avr4_initfn),
> +    DEFINE_AVR_CPU_TYPE("avr5", avr_avr5_initfn),
> +    DEFINE_AVR_CPU_TYPE("avr51", avr_avr51_initfn),
> +    DEFINE_AVR_CPU_TYPE("avr6", avr_avr6_initfn),
> +    DEFINE_AVR_CPU_TYPE("xmega2", avr_xmega2_initfn),
> +    DEFINE_AVR_CPU_TYPE("xmega4", avr_xmega4_initfn),
> +    DEFINE_AVR_CPU_TYPE("xmega5", avr_xmega5_initfn),
> +    DEFINE_AVR_CPU_TYPE("xmega6", avr_xmega6_initfn),
> +    DEFINE_AVR_CPU_TYPE("xmega7", avr_xmega7_initfn),
> +};
> +
> +DEFINE_TYPES(avr_cpu_type_info)
> diff --git a/target/avr/gdbstub.c b/target/avr/gdbstub.c
> new file mode 100644
> index 0000000000..20a5252482
> --- /dev/null
> +++ b/target/avr/gdbstub.c
> @@ -0,0 +1,85 @@
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
> +#include "qemu-common.h"
> +#include "exec/gdbstub.h"
> +
> +int avr_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    AVRCPU *cpu = AVR_CPU(cs);
> +    CPUAVRState *env = &cpu->env;
> +
> +    /*  R */
> +    if (n < 32) {
> +        return gdb_get_reg8(mem_buf, env->r[n]);
> +    }
> +
> +    /*  SREG */
> +    if (n == 32) {
> +        uint8_t sreg = cpu_get_sreg(env);
> +
> +        return gdb_get_reg8(mem_buf, sreg);
> +    }
> +
> +    /*  SP */
> +    if (n == 33) {
> +        return gdb_get_reg16(mem_buf, env->sp & 0x0000ffff);
> +    }
> +
> +    /*  PC */
> +    if (n == 34) {
> +        return gdb_get_reg32(mem_buf, env->pc_w * 2);
> +    }
> +
> +    return 0;
> +}
> +
> +int avr_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    AVRCPU *cpu = AVR_CPU(cs);
> +    CPUAVRState *env = &cpu->env;
> +
> +    /*  R */
> +    if (n < 32) {
> +        env->r[n] = *mem_buf;
> +        return 1;
> +    }
> +
> +    /*  SREG */
> +    if (n == 32) {
> +        cpu_set_sreg(env, *mem_buf);
> +        return 1;
> +    }
> +
> +    /*  SP */
> +    if (n == 33) {
> +        env->sp = lduw_p(mem_buf);
> +        return 2;
> +    }
> +
> +    /*  PC */
> +    if (n == 34) {
> +        env->pc_w = ldl_p(mem_buf) / 2;
> +        return 4;
> +    }
> +
> +    return 0;
> +}
> diff --git a/target/avr/machine.c b/target/avr/machine.c
> new file mode 100644
> index 0000000000..f6dcda7adc
> --- /dev/null
> +++ b/target/avr/machine.c
> @@ -0,0 +1,121 @@
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
> +#include "cpu.h"
> +#include "migration/cpu.h"
> +
> +static int get_sreg(QEMUFile *f, void *opaque, size_t size,
> +    const VMStateField *field)
> +{
> +    CPUAVRState *env = opaque;
> +    uint8_t sreg;
> +
> +    sreg = qemu_get_byte(f);
> +    cpu_set_sreg(env, sreg);
> +    return 0;
> +}
> +
> +static int put_sreg(
> +    QEMUFile *f, void *opaque, size_t size,
> +    const VMStateField *field, QJSON *vmdesc)
> +{
> +    CPUAVRState *env = opaque;
> +    uint8_t sreg = cpu_get_sreg(env);
> +
> +    qemu_put_byte(f, sreg);
> +    return 0;
> +}
> +
> +static const VMStateInfo vms_sreg = {
> +    .name = "sreg",
> +    .get = get_sreg,
> +    .put = put_sreg,
> +};
> +
> +static int get_segment(
> +    QEMUFile *f, void *opaque, size_t size, const VMStateField *field)
> +{
> +    uint32_t *ramp = opaque;
> +    uint8_t temp;
> +
> +    temp = qemu_get_byte(f);
> +    *ramp = ((uint32_t)temp) << 16;
> +    return 0;
> +}
> +
> +static int put_segment(
> +    QEMUFile *f, void *opaque, size_t size,
> +    const VMStateField *field, QJSON *vmdesc)
> +{
> +    uint32_t *ramp = opaque;
> +    uint8_t temp = *ramp >> 16;
> +
> +    qemu_put_byte(f, temp);
> +    return 0;
> +}
> +
> +static const VMStateInfo vms_rampD = {
> +    .name = "rampD",
> +    .get = get_segment,
> +    .put = put_segment,
> +};
> +static const VMStateInfo vms_rampX = {
> +    .name = "rampX",
> +    .get = get_segment,
> +    .put = put_segment,
> +};
> +static const VMStateInfo vms_rampY = {
> +    .name = "rampY",
> +    .get = get_segment,
> +    .put = put_segment,
> +};
> +static const VMStateInfo vms_rampZ = {
> +    .name = "rampZ",
> +    .get = get_segment,
> +    .put = put_segment,
> +};
> +static const VMStateInfo vms_eind = {
> +    .name = "eind",
> +    .get = get_segment,
> +    .put = put_segment,
> +};
> +
> +const VMStateDescription vms_avr_cpu = {
> +    .name = "cpu",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(env.pc_w, AVRCPU),
> +        VMSTATE_UINT32(env.sp, AVRCPU),
> +        VMSTATE_UINT32(env.skip, AVRCPU),
> +
> +        VMSTATE_UINT32_ARRAY(env.r, AVRCPU, NO_CPU_REGISTERS),
> +
> +        VMSTATE_SINGLE(env, AVRCPU, 0, vms_sreg, CPUAVRState),
> +        VMSTATE_SINGLE(env.rampD, AVRCPU, 0, vms_rampD, uint32_t),
> +        VMSTATE_SINGLE(env.rampX, AVRCPU, 0, vms_rampX, uint32_t),
> +        VMSTATE_SINGLE(env.rampY, AVRCPU, 0, vms_rampY, uint32_t),
> +        VMSTATE_SINGLE(env.rampZ, AVRCPU, 0, vms_rampZ, uint32_t),
> +        VMSTATE_SINGLE(env.eind, AVRCPU, 0, vms_eind, uint32_t),
> +
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> diff --git a/gdb-xml/avr-cpu.xml b/gdb-xml/avr-cpu.xml
> new file mode 100644
> index 0000000000..c4747f5b40
> --- /dev/null
> +++ b/gdb-xml/avr-cpu.xml
> @@ -0,0 +1,49 @@
> +<?xml version="1.0"?>
> +<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!-- Register numbers are hard-coded in order to maintain backward
> +     compatibility with older versions of tools that didn't use xml
> +     register descriptions.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name="org.gnu.gdb.riscv.cpu">
> +  <reg name="r0" bitsize="8" type="int" regnum="0"/>
> +  <reg name="r1" bitsize="8" type="int"/>
> +  <reg name="r2" bitsize="8" type="int"/>
> +  <reg name="r3" bitsize="8" type="int"/>
> +  <reg name="r4" bitsize="8" type="int"/>
> +  <reg name="r5" bitsize="8" type="int"/>
> +  <reg name="r6" bitsize="8" type="int"/>
> +  <reg name="r7" bitsize="8" type="int"/>
> +  <reg name="r8" bitsize="8" type="int"/>
> +  <reg name="r9" bitsize="8" type="int"/>
> +  <reg name="r10" bitsize="8" type="int"/>
> +  <reg name="r11" bitsize="8" type="int"/>
> +  <reg name="r12" bitsize="8" type="int"/>
> +  <reg name="r13" bitsize="8" type="int"/>
> +  <reg name="r14" bitsize="8" type="int"/>
> +  <reg name="r15" bitsize="8" type="int"/>
> +  <reg name="r16" bitsize="8" type="int"/>
> +  <reg name="r17" bitsize="8" type="int"/>
> +  <reg name="r18" bitsize="8" type="int"/>
> +  <reg name="r19" bitsize="8" type="int"/>
> +  <reg name="r20" bitsize="8" type="int"/>
> +  <reg name="r21" bitsize="8" type="int"/>
> +  <reg name="r22" bitsize="8" type="int"/>
> +  <reg name="r23" bitsize="8" type="int"/>
> +  <reg name="r24" bitsize="8" type="int"/>
> +  <reg name="r25" bitsize="8" type="int"/>
> +  <reg name="r26" bitsize="8" type="int"/>
> +  <reg name="r27" bitsize="8" type="int"/>
> +  <reg name="r28" bitsize="8" type="int"/>
> +  <reg name="r29" bitsize="8" type="int"/>
> +  <reg name="r30" bitsize="8" type="int"/>
> +  <reg name="r31" bitsize="8" type="int"/>
> +  <reg name="sreg" bitsize="8" type="int"/>
> +  <reg name="sp" bitsize="8" type="int"/>
> +  <reg name="pc" bitsize="8" type="int"/>
> +</feature>
> --
> 2.17.2 (Apple Git-113)
>
>

--0000000000005e5fb7059821b04f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, November 24, 2019, Michael Rolnik &lt;<a href=3D"mailto:=
mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">This includes:<br>
- CPU data structures<br>
- object model classes and functions<br>
- migration functions<br>
- GDB hooks<br>
<br>
Co-developed-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mr=
olnik@gmail.com</a>&gt;<br>
Co-developed-by: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk">=
S.E.Harris@kent.ac.uk</a>&gt;<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrol=
nik@gmail.com</a>&gt;<br>
Signed-off-by: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk">S.=
E.Harris@kent.ac.uk</a>&gt;<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrol=
nik@gmail.com</a>&gt;<br>
Acked-by: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com">imammedo=
@redhat.com</a>&gt;<br>
---<br>
=C2=A0target/avr/cpu-param.h |=C2=A0 37 +++<br>
=C2=A0target/avr/cpu-qom.h=C2=A0 =C2=A0|=C2=A0 54 ++++<br>
=C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 253 ++++++++++++++++++<b=
r>
=C2=A0target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 576 ++++++++++++++++++++=
++++++++++<wbr>+++++++++++<br>
=C2=A0target/avr/gdbstub.c=C2=A0 =C2=A0|=C2=A0 85 ++++++<br>
=C2=A0target/avr/machine.c=C2=A0 =C2=A0| 121 +++++++++<br>
=C2=A0gdb-xml/avr-cpu.xml=C2=A0 =C2=A0 |=C2=A0 49 ++++<br>
=C2=A07 files changed, 1175 insertions(+)</blockquote><div><br></div><div>V=
ery good!! Thanks a lot!! I see you ran the script git.orderfile, and now h=
eaders appear before c files! Even in thsi changed file summary. In v35, it=
 used to be:</div><div><br></div><span style=3D"color:rgb(34,34,34);font-si=
ze:14px;line-height:22.1200008392334px">=C2=A0gdb-xml/avr-cpu.xml=C2=A0 =C2=
=A0 |=C2=A0 49 ++++</span><br style=3D"color:rgb(34,34,34);font-size:14px;l=
ine-height:22.1200008392334px"><span style=3D"color:rgb(34,34,34);font-size=
:14px;line-height:22.1200008392334px">=C2=A0target/avr/cpu-param.h |=C2=A0 =
37 +++</span><br style=3D"color:rgb(34,34,34);font-size:14px;line-height:22=
.1200008392334px"><span style=3D"color:rgb(34,34,34);font-size:14px;line-he=
ight:22.1200008392334px">=C2=A0target/avr/cpu-qom.h=C2=A0 =C2=A0|=C2=A0 54 =
++++</span><br style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1=
200008392334px"><span style=3D"color:rgb(34,34,34);font-size:14px;line-heig=
ht:22.1200008392334px">=C2=A0target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 5=
76 ++++++++++++++++++++++++++++++</span><wbr style=3D"color:rgb(34,34,34);f=
ont-size:14px;line-height:22.1200008392334px"><span style=3D"color:rgb(34,3=
4,34);font-size:14px;line-height:22.1200008392334px">+++++++++++</span><br =
style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px"=
><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.120000839=
2334px">=C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 253 ++++++++++++=
++++++</span><br style=3D"color:rgb(34,34,34);font-size:14px;line-height:22=
.1200008392334px"><span style=3D"color:rgb(34,34,34);font-size:14px;line-he=
ight:22.1200008392334px">=C2=A0target/avr/gdbstub.c=C2=A0 =C2=A0|=C2=A0 85 =
++++++</span><br style=3D"color:rgb(34,34,34);font-size:14px;line-height:22=
.1200008392334px"><span style=3D"color:rgb(34,34,34);font-size:14px;line-he=
ight:22.1200008392334px">=C2=A0target/avr/machine.c=C2=A0 =C2=A0| 121 +++++=
++++</span><br style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1=
200008392334px"><span style=3D"color:rgb(34,34,34);font-size:14px;line-heig=
ht:22.1200008392334px">=C2=A07 files changed, 1175 insertions(+)</span><br =
style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px"=
><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0create mode 100644 target/avr/cpu-param.h<br>
=C2=A0create mode 100644 target/avr/cpu-qom.h<br>
=C2=A0create mode 100644 target/avr/cpu.h<br>
=C2=A0create mode 100644 target/avr/cpu.c<br>
=C2=A0create mode 100644 target/avr/gdbstub.c<br>
=C2=A0create mode 100644 target/avr/machine.c<br>
=C2=A0create mode 100644 gdb-xml/avr-cpu.xml<br>
<br>
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h<br>
new file mode 100644<br>
index 0000000000..ccd1ea3429<br>
--- /dev/null<br>
+++ b/target/avr/cpu-param.h<br>
@@ -0,0 +1,37 @@<br>
+/*<br>
+ * QEMU AVR CPU<br>
+ *<br>
+ * Copyright (c) 2019 Michael Rolnik<br>
+ *<br>
+ * This library is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU Lesser General Public<br>
+ * License as published by the Free Software Foundation; either<br>
+ * version 2.1 of the License, or (at your option) any later version.<br>
+ *<br>
+ * This library is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU<=
br>
+ * Lesser General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU Lesser General Public<br>
+ * License along with this library; if not, see<br>
+ * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" target=3D"_bl=
ank">http://www.gnu.org/licenses/<wbr>lgpl-2.1.html</a>&gt;<br>
+ */<br>
+<br>
+#ifndef AVR_CPU_PARAM_H<br>
+#define AVR_CPU_PARAM_H 1<br>
+<br>
+#define TARGET_LONG_BITS 32<br>
+/*<br>
+ * TARGET_PAGE_BITS cannot be more than 8 bits because<br>
+ * 1.=C2=A0 all IO registers occupy [0x0000 .. 0x00ff] address range, and =
they<br>
+ *=C2=A0 =C2=A0 =C2=A0should be implemented as a device and not memory<br>
+ * 2.=C2=A0 SRAM starts at the address 0x0100<br>
+ */<br>
+#define TARGET_PAGE_BITS 8<br>
+#define TARGET_PHYS_ADDR_SPACE_BITS 24<br>
+#define TARGET_VIRT_ADDR_SPACE_BITS 24<br>
+#define NB_MMU_MODES 2<br>
+<br>
+<br>
+#endif<br>
diff --git a/target/avr/cpu-qom.h b/target/avr/cpu-qom.h<br>
new file mode 100644<br>
index 0000000000..e28b58c897<br>
--- /dev/null<br>
+++ b/target/avr/cpu-qom.h<br>
@@ -0,0 +1,54 @@<br>
+/*<br>
+ * QEMU AVR CPU<br>
+ *<br>
+ * Copyright (c) 2019 Michael Rolnik<br>
+ *<br>
+ * This library is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU Lesser General Public<br>
+ * License as published by the Free Software Foundation; either<br>
+ * version 2.1 of the License, or (at your option) any later version.<br>
+ *<br>
+ * This library is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU<=
br>
+ * Lesser General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU Lesser General Public<br>
+ * License along with this library; if not, see<br>
+ * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" target=3D"_bl=
ank">http://www.gnu.org/licenses/<wbr>lgpl-2.1.html</a>&gt;<br>
+ */<br>
+<br>
+#ifndef QEMU_AVR_QOM_H<br>
+#define QEMU_AVR_QOM_H<br>
+<br>
+#include &quot;hw/core/cpu.h&quot;<br>
+<br>
+#define TYPE_AVR_CPU &quot;avr-cpu&quot;<br>
+<br>
+#define AVR_CPU_CLASS(klass) \<br>
+=C2=A0 =C2=A0 OBJECT_CLASS_CHECK(<wbr>AVRCPUClass, (klass), TYPE_AVR_CPU)<=
br>
+#define AVR_CPU(obj) \<br>
+=C2=A0 =C2=A0 OBJECT_CHECK(AVRCPU, (obj), TYPE_AVR_CPU)<br>
+#define AVR_CPU_GET_CLASS(obj) \<br>
+=C2=A0 =C2=A0 OBJECT_GET_CLASS(AVRCPUClass, (obj), TYPE_AVR_CPU)<br>
+<br>
+/**<br>
+ *=C2=A0 AVRCPUClass:<br>
+ *=C2=A0 @parent_realize: The parent class&#39; realize handler.<br>
+ *=C2=A0 @parent_reset: The parent class&#39; reset handler.<br>
+ *=C2=A0 @vr: Version Register value.<br>
+ *<br>
+ *=C2=A0 A AVR CPU model.<br>
+ */<br>
+typedef struct AVRCPUClass {<br>
+=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
+=C2=A0 =C2=A0 CPUClass parent_class;<br>
+=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
+=C2=A0 =C2=A0 DeviceRealize parent_realize;<br>
+=C2=A0 =C2=A0 void (*parent_reset)(CPUState *cpu);<br>
+} AVRCPUClass;<br>
+<br>
+typedef struct AVRCPU AVRCPU;<br>
+<br>
+<br>
+#endif /* !defined (QEMU_AVR_CPU_QOM_H) */<br>
diff --git a/target/avr/cpu.h b/target/avr/cpu.h<br>
new file mode 100644<br>
index 0000000000..ed9218af5f<br>
--- /dev/null<br>
+++ b/target/avr/cpu.h<br>
@@ -0,0 +1,253 @@<br>
+/*<br>
+ * QEMU AVR CPU<br>
+ *<br>
+ * Copyright (c) 2019 Michael Rolnik<br>
+ *<br>
+ * This library is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU Lesser General Public<br>
+ * License as published by the Free Software Foundation; either<br>
+ * version 2.1 of the License, or (at your option) any later version.<br>
+ *<br>
+ * This library is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU<=
br>
+ * Lesser General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU Lesser General Public<br>
+ * License along with this library; if not, see<br>
+ * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" target=3D"_bl=
ank">http://www.gnu.org/licenses/<wbr>lgpl-2.1.html</a>&gt;<br>
+ */<br>
+<br>
+#ifndef QEMU_AVR_CPU_H<br>
+#define QEMU_AVR_CPU_H<br>
+<br>
+#include &quot;cpu-qom.h&quot;<br>
+#include &quot;exec/cpu-defs.h&quot;<br>
+<br>
+#define TCG_GUEST_DEFAULT_MO 0<br>
+<br>
+#define CPU_RESOLVING_TYPE TYPE_AVR_CPU<br>
+<br>
+/*<br>
+ * AVR has two memory spaces, data &amp; code.<br>
+ * e.g. both have 0 address<br>
+ * ST/LD instructions access data space<br>
+ * LPM/SPM and instruction fetching access code memory space<br>
+ */<br>
+#define MMU_CODE_IDX 0<br>
+#define MMU_DATA_IDX 1<br>
+<br>
+#define EXCP_RESET 1<br>
+#define EXCP_INT(n) (EXCP_RESET + (n) + 1)<br>
+<br>
+/* Number of CPU registers */<br>
+#define NO_CPU_REGISTERS 32<br>
+/* Number of IO registers accessible by ld/st/in/out */<br>
+#define NO_IO_REGISTERS 64<br>
+<br>
+/*<br>
+ * Offsets of AVR memory regions in host memory space.<br>
+ *<br>
+ * This is needed because the AVR has separate code and data address<br>
+ * spaces that both have start from zero but have to go somewhere in<br>
+ * host memory.<br>
+ *<br>
+ * It&#39;s also useful to know where some things are, like the IO registe=
rs.<br>
+ */<br>
+/* Flash program memory */<br>
+#define OFFSET_CODE 0x00000000<br>
+/* CPU registers, IO registers, and SRAM */<br>
+#define OFFSET_DATA 0x00800000<br>
+/* CPU registers specifically, these are mapped at the start of data */<br=
>
+#define OFFSET_CPU_REGISTERS OFFSET_DATA<br>
+/*<br>
+ * IO registers, including status register, stack pointer, and memory<br>
+ * mapped peripherals, mapped just after CPU registers<br>
+ */<br>
+#define OFFSET_IO_REGISTERS (OFFSET_DATA + NO_CPU_REGISTERS)<br>
+<br>
+enum avr_features {<br>
+=C2=A0 =C2=A0 AVR_FEATURE_SRAM,<br>
+<br>
+=C2=A0 =C2=A0 AVR_FEATURE_1_BYTE_PC,<br>
+=C2=A0 =C2=A0 AVR_FEATURE_2_BYTE_PC,<br>
+=C2=A0 =C2=A0 AVR_FEATURE_3_BYTE_PC,<br>
+<br>
+=C2=A0 =C2=A0 AVR_FEATURE_1_BYTE_SP,<br>
+=C2=A0 =C2=A0 AVR_FEATURE_2_BYTE_SP,<br>
+<br>
+=C2=A0 =C2=A0 AVR_FEATURE_BREAK,<br>
+=C2=A0 =C2=A0 AVR_FEATURE_DES,<br>
+=C2=A0 =C2=A0 AVR_FEATURE_RMW, /* Read Modify Write - XCH LAC LAS LAT */<b=
r>
+<br>
+=C2=A0 =C2=A0 AVR_FEATURE_EIJMP_EICALL,<br>
+=C2=A0 =C2=A0 AVR_FEATURE_IJMP_ICALL,<br>
+=C2=A0 =C2=A0 AVR_FEATURE_JMP_CALL,<br>
+<br>
+=C2=A0 =C2=A0 AVR_FEATURE_ADIW_SBIW,<br>
+<br>
+=C2=A0 =C2=A0 AVR_FEATURE_SPM,<br>
+=C2=A0 =C2=A0 AVR_FEATURE_SPMX,<br>
+<br>
+=C2=A0 =C2=A0 AVR_FEATURE_ELPMX,<br>
+=C2=A0 =C2=A0 AVR_FEATURE_ELPM,<br>
+=C2=A0 =C2=A0 AVR_FEATURE_LPMX,<br>
+=C2=A0 =C2=A0 AVR_FEATURE_LPM,<br>
+<br>
+=C2=A0 =C2=A0 AVR_FEATURE_MOVW,<br>
+=C2=A0 =C2=A0 AVR_FEATURE_MUL,<br>
+=C2=A0 =C2=A0 AVR_FEATURE_RAMPD,<br>
+=C2=A0 =C2=A0 AVR_FEATURE_RAMPX,<br>
+=C2=A0 =C2=A0 AVR_FEATURE_RAMPY,<br>
+=C2=A0 =C2=A0 AVR_FEATURE_RAMPZ,<br>
+};<br>
+<br>
+typedef struct CPUAVRState CPUAVRState;<br>
+<br>
+struct CPUAVRState {<br>
+=C2=A0 =C2=A0 uint32_t pc_w; /* 0x003fffff up to 22 bits */<br>
+<br>
+=C2=A0 =C2=A0 uint32_t sregC; /* 0x00000001 1 bit */<br>
+=C2=A0 =C2=A0 uint32_t sregZ; /* 0x00000001 1 bit */<br>
+=C2=A0 =C2=A0 uint32_t sregN; /* 0x00000001 1 bit */<br>
+=C2=A0 =C2=A0 uint32_t sregV; /* 0x00000001 1 bit */<br>
+=C2=A0 =C2=A0 uint32_t sregS; /* 0x00000001 1 bit */<br>
+=C2=A0 =C2=A0 uint32_t sregH; /* 0x00000001 1 bit */<br>
+=C2=A0 =C2=A0 uint32_t sregT; /* 0x00000001 1 bit */<br>
+=C2=A0 =C2=A0 uint32_t sregI; /* 0x00000001 1 bit */<br>
+<br>
+=C2=A0 =C2=A0 uint32_t rampD; /* 0x00ff0000 8 bits */<br>
+=C2=A0 =C2=A0 uint32_t rampX; /* 0x00ff0000 8 bits */<br>
+=C2=A0 =C2=A0 uint32_t rampY; /* 0x00ff0000 8 bits */<br>
+=C2=A0 =C2=A0 uint32_t rampZ; /* 0x00ff0000 8 bits */<br>
+=C2=A0 =C2=A0 uint32_t eind; /* 0x00ff0000 8 bits */<br>
+<br>
+=C2=A0 =C2=A0 uint32_t r[NO_CPU_REGISTERS]; /* 8 bits each */<br>
+=C2=A0 =C2=A0 uint32_t sp; /* 16 bits */<br>
+<br>
+=C2=A0 =C2=A0 uint32_t skip; /* if set skip instruction */<br>
+<br>
+=C2=A0 =C2=A0 uint64_t intsrc; /* interrupt sources */<br>
+=C2=A0 =C2=A0 bool fullacc; /* CPU/MEM if true MEM only otherwise */<br>
+<br>
+=C2=A0 =C2=A0 uint32_t features;<br>
+};<br>
+<br>
+/**<br>
+ *=C2=A0 AVRCPU:<br>
+ *=C2=A0 @env: #CPUAVRState<br>
+ *<br>
+ *=C2=A0 A AVR CPU.<br>
+ */<br>
+typedef struct AVRCPU {<br>
+=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
+=C2=A0 =C2=A0 CPUState parent_obj;<br>
+=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
+<br>
+=C2=A0 =C2=A0 CPUNegativeOffsetState neg;<br>
+=C2=A0 =C2=A0 CPUAVRState env;<br>
+} AVRCPU;<br>
+<br>
+#ifndef CONFIG_USER_ONLY<br>
+extern const struct VMStateDescription vms_avr_cpu;<br>
+#endif<br>
+<br>
+void avr_cpu_do_interrupt(CPUState *cpu);<br>
+bool avr_cpu_exec_interrupt(<wbr>CPUState *cpu, int int_req);<br>
+hwaddr avr_cpu_get_phys_page_debug(<wbr>CPUState *cpu, vaddr addr);<br>
+int avr_cpu_gdb_read_register(<wbr>CPUState *cpu, uint8_t *buf, int reg);<=
br>
+int avr_cpu_gdb_write_register(<wbr>CPUState *cpu, uint8_t *buf, int reg);=
<br>
+<br>
+static inline int avr_feature(CPUAVRState *env, int feature)<br>
+{<br>
+=C2=A0 =C2=A0 return (env-&gt;features &amp; (1U &lt;&lt; feature)) !=3D 0=
;<br>
+}<br>
+<br>
+static inline void avr_set_feature(CPUAVRState *env, int feature)<br>
+{<br>
+=C2=A0 =C2=A0 env-&gt;features |=3D (1U &lt;&lt; feature);<br>
+}<br>
+<br>
+#define cpu_list avr_cpu_list<br>
+#define cpu_signal_handler cpu_avr_signal_handler<br>
+#define cpu_mmu_index avr_cpu_mmu_index<br>
+<br>
+static inline int avr_cpu_mmu_index(CPUAVRState *env, bool ifetch)<br>
+{<br>
+=C2=A0 =C2=A0 return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;<br>
+}<br>
+<br>
+void avr_cpu_tcg_init(void);<br>
+<br>
+void avr_cpu_list(void);<br>
+int cpu_avr_exec(CPUState *cpu);<br>
+int cpu_avr_signal_handler(int host_signum, void *pinfo, void *puc);<br>
+int avr_cpu_handle_mmu_fault(<wbr>CPUState *cpu, vaddr address, int size,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int rw, int mmu_idx);<br>
+int avr_cpu_memory_rw_debug(<wbr>CPUState *cs, vaddr address, uint8_t *buf=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int len, bool is_write);<br>
+<br>
+enum {<br>
+=C2=A0 =C2=A0 TB_FLAGS_FULL_ACCESS =3D 1,<br>
+=C2=A0 =C2=A0 TB_FLAGS_SKIP =3D 2,<br>
+};<br>
+<br>
+static inline void cpu_get_tb_cpu_state(<wbr>CPUAVRState *env, target_ulon=
g *pc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong *cs_base, uint32_t *pfl=
ags)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t flags =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 *pc =3D env-&gt;pc_w * 2;<br>
+=C2=A0 =C2=A0 *cs_base =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 if (env-&gt;fullacc) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D TB_FLAGS_FULL_ACCESS;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (env-&gt;skip) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D TB_FLAGS_SKIP;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 *pflags =3D flags;<br>
+}<br>
+<br>
+static inline int cpu_interrupts_enabled(<wbr>CPUAVRState *env)<br>
+{<br>
+=C2=A0 =C2=A0 return env-&gt;sregI !=3D 0;<br>
+}<br>
+<br>
+static inline uint8_t cpu_get_sreg(CPUAVRState *env)<br>
+{<br>
+=C2=A0 =C2=A0 uint8_t sreg;<br>
+=C2=A0 =C2=A0 sreg =3D (env-&gt;sregC) &lt;&lt; 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregZ) &lt;&lt; 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregN) &lt;&lt; 2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregV) &lt;&lt; 3<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregS) &lt;&lt; 4<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregH) &lt;&lt; 5<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregT) &lt;&lt; 6<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregI) &lt;&lt; 7;<br>
+=C2=A0 =C2=A0 return sreg;<br>
+}<br>
+<br>
+static inline void cpu_set_sreg(CPUAVRState *env, uint8_t sreg)<br>
+{<br>
+=C2=A0 =C2=A0 env-&gt;sregC =3D (sreg &gt;&gt; 0) &amp; 0x01;<br>
+=C2=A0 =C2=A0 env-&gt;sregZ =3D (sreg &gt;&gt; 1) &amp; 0x01;<br>
+=C2=A0 =C2=A0 env-&gt;sregN =3D (sreg &gt;&gt; 2) &amp; 0x01;<br>
+=C2=A0 =C2=A0 env-&gt;sregV =3D (sreg &gt;&gt; 3) &amp; 0x01;<br>
+=C2=A0 =C2=A0 env-&gt;sregS =3D (sreg &gt;&gt; 4) &amp; 0x01;<br>
+=C2=A0 =C2=A0 env-&gt;sregH =3D (sreg &gt;&gt; 5) &amp; 0x01;<br>
+=C2=A0 =C2=A0 env-&gt;sregT =3D (sreg &gt;&gt; 6) &amp; 0x01;<br>
+=C2=A0 =C2=A0 env-&gt;sregI =3D (sreg &gt;&gt; 7) &amp; 0x01;<br>
+}<br>
+<br>
+bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 MMUAccessType access_type, int mmu_idx,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bool probe, uintptr_t retaddr);<br>
+<br>
+typedef CPUAVRState CPUArchState;<br>
+typedef AVRCPU ArchCPU;<br>
+<br>
+#include &quot;exec/cpu-all.h&quot;<br>
+<br>
+#endif /* !defined (QEMU_AVR_CPU_H) */<br>
diff --git a/target/avr/cpu.c b/target/avr/cpu.c<br>
new file mode 100644<br>
index 0000000000..dae56d7845<br>
--- /dev/null<br>
+++ b/target/avr/cpu.c<br>
@@ -0,0 +1,576 @@<br>
+/*<br>
+ * QEMU AVR CPU<br>
+ *<br>
+ * Copyright (c) 2019 Michael Rolnik<br>
+ *<br>
+ * This library is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU Lesser General Public<br>
+ * License as published by the Free Software Foundation; either<br>
+ * version 2.1 of the License, or (at your option) any later version.<br>
+ *<br>
+ * This library is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU<=
br>
+ * Lesser General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU Lesser General Public<br>
+ * License along with this library; if not, see<br>
+ * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" target=3D"_bl=
ank">http://www.gnu.org/licenses/<wbr>lgpl-2.1.html</a>&gt;<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;qemu/qemu-print.h&quot;<br>
+#include &quot;exec/exec-all.h&quot;<br>
+#include &quot;cpu.h&quot;<br>
+<br>
+static void avr_cpu_set_pc(CPUState *cs, vaddr value)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);<br>
+<br>
+=C2=A0 =C2=A0 cpu-&gt;env.pc_w =3D value / 2; /* internally PC points to w=
ords */<br>
+}<br>
+<br>
+static bool avr_cpu_has_work(CPUState *cs)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 return (cs-&gt;interrupt_request &amp; (CPU_INTERRUPT_HARD |=
 CPU_INTERRUPT_RESET))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; cpu_interrupts_enable=
d(env);<br>
+}<br>
+<br>
+static void avr_cpu_synchronize_from_tb(<wbr>CPUState *cs, TranslationBloc=
k *tb)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 env-&gt;pc_w =3D tb-&gt;pc / 2; /* internally PC points to w=
ords */<br>
+}<br>
+<br>
+static void avr_cpu_reset(CPUState *cs)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);<br>
+=C2=A0 =C2=A0 AVRCPUClass *mcc =3D AVR_CPU_GET_CLASS(cpu);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 mcc-&gt;parent_reset(cs);<br>
+<br>
+=C2=A0 =C2=A0 env-&gt;pc_w =3D 0;<br>
+=C2=A0 =C2=A0 env-&gt;sregI =3D 1;<br>
+=C2=A0 =C2=A0 env-&gt;sregC =3D 0;<br>
+=C2=A0 =C2=A0 env-&gt;sregZ =3D 0;<br>
+=C2=A0 =C2=A0 env-&gt;sregN =3D 0;<br>
+=C2=A0 =C2=A0 env-&gt;sregV =3D 0;<br>
+=C2=A0 =C2=A0 env-&gt;sregS =3D 0;<br>
+=C2=A0 =C2=A0 env-&gt;sregH =3D 0;<br>
+=C2=A0 =C2=A0 env-&gt;sregT =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 env-&gt;rampD =3D 0;<br>
+=C2=A0 =C2=A0 env-&gt;rampX =3D 0;<br>
+=C2=A0 =C2=A0 env-&gt;rampY =3D 0;<br>
+=C2=A0 =C2=A0 env-&gt;rampZ =3D 0;<br>
+=C2=A0 =C2=A0 env-&gt;eind =3D 0;<br>
+=C2=A0 =C2=A0 env-&gt;sp =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 env-&gt;skip =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 memset(env-&gt;r, 0, sizeof(env-&gt;r));<br>
+<br>
+=C2=A0 =C2=A0 tlb_flush(cs);<br>
+}<br>
+<br>
+static void avr_cpu_disas_set_info(<wbr>CPUState *cpu, disassemble_info *i=
nfo)<br>
+{<br>
+=C2=A0 =C2=A0 info-&gt;mach =3D bfd_arch_avr;<br>
+=C2=A0 =C2=A0 info-&gt;print_insn =3D NULL;<br>
+}<br>
+<br>
+static void avr_cpu_realizefn(DeviceState *dev, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 CPUState *cs =3D CPU(dev);<br>
+=C2=A0 =C2=A0 AVRCPUClass *mcc =3D AVR_CPU_GET_CLASS(dev);<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 cpu_exec_realizefn(cs, &amp;local_err);<br>
+=C2=A0 =C2=A0 if (local_err !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 qemu_init_vcpu(cs);<br>
+=C2=A0 =C2=A0 cpu_reset(cs);<br>
+<br>
+=C2=A0 =C2=A0 mcc-&gt;parent_realize(dev, errp);<br>
+}<br>
+<br>
+static void avr_cpu_set_int(void *opaque, int irq, int level)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D opaque;<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+=C2=A0 =C2=A0 CPUState *cs =3D CPU(cpu);<br>
+<br>
+=C2=A0 =C2=A0 uint64_t mask =3D (1ull &lt;&lt; irq);<br>
+=C2=A0 =C2=A0 if (level) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;intsrc |=3D mask;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_interrupt(cs, CPU_INTERRUPT_HARD);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;intsrc &amp;=3D ~mask;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;intsrc =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_reset_interrupt(cs, CPU_INTE=
RRUPT_HARD);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void avr_cpu_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+<br>
+=C2=A0 =C2=A0 cpu_set_cpustate_pointers(cpu)<wbr>;<br>
+<br>
+#ifndef CONFIG_USER_ONLY<br>
+=C2=A0 =C2=A0 /* Set the number of interrupts supported by the CPU. */<br>
+=C2=A0 =C2=A0 qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int, 57);<br>
+#endif<br>
+}<br>
+<br>
+static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)<br>
+{<br>
+=C2=A0 =C2=A0 ObjectClass *oc;<br>
+<br>
+=C2=A0 =C2=A0 oc =3D object_class_by_name(cpu_<wbr>model);<br>
+=C2=A0 =C2=A0 if (object_class_dynamic_cast(oc, TYPE_AVR_CPU) =3D=3D NULL =
||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_class_is_abstract(oc)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 oc =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return oc;<br>
+}<br>
+<br>
+static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 qemu_fprintf(f, &quot;\n&quot;);<br>
+=C2=A0 =C2=A0 qemu_fprintf(f, &quot;PC:=C2=A0 =C2=A0 %06x\n&quot;, env-&gt=
;pc_w);<br>
+=C2=A0 =C2=A0 qemu_fprintf(f, &quot;SP:=C2=A0 =C2=A0 =C2=A0 %04x\n&quot;, =
env-&gt;sp);<br>
+=C2=A0 =C2=A0 qemu_fprintf(f, &quot;rampD:=C2=A0 =C2=A0 =C2=A0%02x\n&quot;=
, env-&gt;rampD &gt;&gt; 16);<br>
+=C2=A0 =C2=A0 qemu_fprintf(f, &quot;rampX:=C2=A0 =C2=A0 =C2=A0%02x\n&quot;=
, env-&gt;rampX &gt;&gt; 16);<br>
+=C2=A0 =C2=A0 qemu_fprintf(f, &quot;rampY:=C2=A0 =C2=A0 =C2=A0%02x\n&quot;=
, env-&gt;rampY &gt;&gt; 16);<br>
+=C2=A0 =C2=A0 qemu_fprintf(f, &quot;rampZ:=C2=A0 =C2=A0 =C2=A0%02x\n&quot;=
, env-&gt;rampZ &gt;&gt; 16);<br>
+=C2=A0 =C2=A0 qemu_fprintf(f, &quot;EIND:=C2=A0 =C2=A0 =C2=A0 %02x\n&quot;=
, env-&gt;eind &gt;&gt; 16);<br>
+=C2=A0 =C2=A0 qemu_fprintf(f, &quot;X:=C2=A0 =C2=A0 =C2=A0 =C2=A0%02x%02x\=
n&quot;, env-&gt;r[27], env-&gt;r[26]);<br>
+=C2=A0 =C2=A0 qemu_fprintf(f, &quot;Y:=C2=A0 =C2=A0 =C2=A0 =C2=A0%02x%02x\=
n&quot;, env-&gt;r[29], env-&gt;r[28]);<br>
+=C2=A0 =C2=A0 qemu_fprintf(f, &quot;Z:=C2=A0 =C2=A0 =C2=A0 =C2=A0%02x%02x\=
n&quot;, env-&gt;r[31], env-&gt;r[30]);<br>
+=C2=A0 =C2=A0 qemu_fprintf(f, &quot;SREG:=C2=A0 =C2=A0 [ %c %c %c %c %c %c=
 %c %c ]\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 env-&gt;sregI ? &#39;I&#39; : &#39;-&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 env-&gt;sregT ? &#39;T&#39; : &#39;-&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 env-&gt;sregH ? &#39;H&#39; : &#39;-&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 env-&gt;sregS ? &#39;S&#39; : &#39;-&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 env-&gt;sregV ? &#39;V&#39; : &#39;-&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 env-&gt;sregN ? &#39;-&#39; : &#39;N&#39;, /* Zf has negative lo=
gic */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 env-&gt;sregZ ? &#39;Z&#39; : &#39;-&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 env-&gt;sregC ? &#39;I&#39; : &#39;-&#39;);<br>
+=C2=A0 =C2=A0 qemu_fprintf(f, &quot;SKIP:=C2=A0 =C2=A0 %02x\n&quot;, env-&=
gt;skip);<br>
+<br>
+=C2=A0 =C2=A0 qemu_fprintf(f, &quot;\n&quot;);<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(env-&gt;r); i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot;R[%02d]:=C2=A0 %02x=C2=
=A0 =C2=A0&quot;, i, env-&gt;r[i]);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((i % 8) =3D=3D 7) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot;\n&quot;);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 qemu_fprintf(f, &quot;\n&quot;);<br>
+}<br>
+<br>
+static void avr_cpu_class_init(ObjectClass *oc, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(oc);<br>
+=C2=A0 =C2=A0 CPUClass *cc =3D CPU_CLASS(oc);<br>
+=C2=A0 =C2=A0 AVRCPUClass *mcc =3D AVR_CPU_CLASS(oc);<br>
+<br>
+=C2=A0 =C2=A0 mcc-&gt;parent_realize =3D dc-&gt;realize;<br>
+=C2=A0 =C2=A0 dc-&gt;realize =3D avr_cpu_realizefn;<br>
+<br>
+=C2=A0 =C2=A0 mcc-&gt;parent_reset =3D cc-&gt;reset;<br>
+=C2=A0 =C2=A0 cc-&gt;reset =3D avr_cpu_reset;<br>
+<br>
+=C2=A0 =C2=A0 cc-&gt;class_by_name =3D avr_cpu_class_by_name;<br>
+<br>
+=C2=A0 =C2=A0 cc-&gt;has_work =3D avr_cpu_has_work;<br>
+=C2=A0 =C2=A0 cc-&gt;do_interrupt =3D avr_cpu_do_interrupt;<br>
+=C2=A0 =C2=A0 cc-&gt;cpu_exec_interrupt =3D avr_cpu_exec_interrupt;<br>
+=C2=A0 =C2=A0 cc-&gt;dump_state =3D avr_cpu_dump_state;<br>
+=C2=A0 =C2=A0 cc-&gt;set_pc =3D avr_cpu_set_pc;<br>
+#if !defined(CONFIG_USER_ONLY)<br>
+=C2=A0 =C2=A0 cc-&gt;memory_rw_debug =3D avr_cpu_memory_rw_debug;<br>
+#endif<br>
+#ifdef CONFIG_USER_ONLY<br>
+=C2=A0 =C2=A0 cc-&gt;handle_mmu_fault =3D avr_cpu_handle_mmu_fault;<br>
+#else<br>
+=C2=A0 =C2=A0 cc-&gt;get_phys_page_debug =3D avr_cpu_get_phys_page_debug;<=
br>
+=C2=A0 =C2=A0 cc-&gt;vmsd =3D &amp;vms_avr_cpu;<br>
+#endif<br>
+=C2=A0 =C2=A0 cc-&gt;disas_set_info =3D avr_cpu_disas_set_info;<br>
+=C2=A0 =C2=A0 cc-&gt;tlb_fill =3D avr_cpu_tlb_fill;<br>
+=C2=A0 =C2=A0 cc-&gt;tcg_initialize =3D avr_cpu_tcg_init;<br>
+=C2=A0 =C2=A0 cc-&gt;synchronize_from_tb =3D avr_cpu_synchronize_from_tb;<=
br>
+=C2=A0 =C2=A0 cc-&gt;gdb_read_register =3D avr_cpu_gdb_read_register;<br>
+=C2=A0 =C2=A0 cc-&gt;gdb_write_register =3D avr_cpu_gdb_write_register;<br=
>
+=C2=A0 =C2=A0 cc-&gt;gdb_num_core_regs =3D 35;<br>
+=C2=A0 =C2=A0 cc-&gt;gdb_core_xml_file =3D &quot;avr-cpu.xml&quot;;<br>
+}<br>
+<br>
+static void avr_avr1_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+}<br>
+<br>
+static void avr_avr2_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+}<br>
+<br>
+static void avr_avr25_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
+}<br>
+<br>
+static void avr_avr3_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
+}<br>
+<br>
+static void avr_avr31_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
+}<br>
+<br>
+static void avr_avr35_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
+}<br>
+<br>
+static void avr_avr4_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
+}<br>
+<br>
+static void avr_avr5_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
+}<br>
+<br>
+static void avr_avr51_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
+}<br>
+<br>
+static void avr_avr6_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
+}<br>
+<br>
+static void avr_xmega2_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
+}<br>
+<br>
+static void avr_xmega4_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
+}<br>
+<br>
+static void avr_xmega5_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPD);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPX);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPY);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
+}<br>
+<br>
+static void avr_xmega6_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
+}<br>
+<br>
+static void avr_xmega7_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPD);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPX);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPY);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
+=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
+}<br>
+<br>
+typedef struct AVRCPUInfo {<br>
+=C2=A0 =C2=A0 const char *name;<br>
+=C2=A0 =C2=A0 void (*initfn)(Object *obj);<br>
+} AVRCPUInfo;<br>
+<br>
+<br>
+static void avr_cpu_list_entry(gpointer data, gpointer user_data)<br>
+{<br>
+=C2=A0 =C2=A0 const char *typename =3D object_class_get_name(OBJECT_<wbr>C=
LASS(data));<br>
+<br>
+=C2=A0 =C2=A0 qemu_printf(&quot;%s\n&quot;, typename);<br>
+}<br>
+<br>
+void avr_cpu_list(void)<br>
+{<br>
+=C2=A0 =C2=A0 GSList *list;<br>
+=C2=A0 =C2=A0 list =3D object_class_get_list_sorted(<wbr>TYPE_AVR_CPU, fal=
se);<br>
+=C2=A0 =C2=A0 g_slist_foreach(list, avr_cpu_list_entry, NULL);<br>
+=C2=A0 =C2=A0 g_slist_free(list);<br>
+}<br>
+<br>
+#define DEFINE_AVR_CPU_TYPE(model, initfn) \<br>
+=C2=A0 =C2=A0 { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D TYPE_AVR_CPU, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_init =3D initfn, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D model &quot;-avr-cpu&quot;, \<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+static const TypeInfo avr_cpu_type_info[] =3D {<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D TYPE_AVR_CPU,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D TYPE_CPU,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_size =3D sizeof(AVRCPU),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_init =3D avr_cpu_initfn,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_size =3D sizeof(AVRCPUClass),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init =3D avr_cpu_class_init,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .abstract =3D true,<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr1&quot;, avr_avr1_initfn),<br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr2&quot;, avr_avr2_initfn),<br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr25&quot;, avr_avr25_initfn),<br=
>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr3&quot;, avr_avr3_initfn),<br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr31&quot;, avr_avr31_initfn),<br=
>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr35&quot;, avr_avr35_initfn),<br=
>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr4&quot;, avr_avr4_initfn),<br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr5&quot;, avr_avr5_initfn),<br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr51&quot;, avr_avr51_initfn),<br=
>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr6&quot;, avr_avr6_initfn),<br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega2&quot;, avr_xmega2_initfn),<=
br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega4&quot;, avr_xmega4_initfn),<=
br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega5&quot;, avr_xmega5_initfn),<=
br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega6&quot;, avr_xmega6_initfn),<=
br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega7&quot;, avr_xmega7_initfn),<=
br>
+};<br>
+<br>
+DEFINE_TYPES(avr_cpu_type_<wbr>info)<br>
diff --git a/target/avr/gdbstub.c b/target/avr/gdbstub.c<br>
new file mode 100644<br>
index 0000000000..20a5252482<br>
--- /dev/null<br>
+++ b/target/avr/gdbstub.c<br>
@@ -0,0 +1,85 @@<br>
+/*<br>
+ * QEMU AVR CPU<br>
+ *<br>
+ * Copyright (c) 2019 Michael Rolnik<br>
+ *<br>
+ * This library is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU Lesser General Public<br>
+ * License as published by the Free Software Foundation; either<br>
+ * version 2.1 of the License, or (at your option) any later version.<br>
+ *<br>
+ * This library is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU<=
br>
+ * Lesser General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU Lesser General Public<br>
+ * License along with this library; if not, see<br>
+ * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" target=3D"_bl=
ank">http://www.gnu.org/licenses/<wbr>lgpl-2.1.html</a>&gt;<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu-common.h&quot;<br>
+#include &quot;exec/gdbstub.h&quot;<br>
+<br>
+int avr_cpu_gdb_read_register(<wbr>CPUState *cs, uint8_t *mem_buf, int n)<=
br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 /*=C2=A0 R */<br>
+=C2=A0 =C2=A0 if (n &lt; 32) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(mem_buf, env-&gt;r[n]);<br=
>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*=C2=A0 SREG */<br>
+=C2=A0 =C2=A0 if (n =3D=3D 32) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t sreg =3D cpu_get_sreg(env);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(mem_buf, sreg);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*=C2=A0 SP */<br>
+=C2=A0 =C2=A0 if (n =3D=3D 33) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg16(mem_buf, env-&gt;sp &amp;=
 0x0000ffff);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*=C2=A0 PC */<br>
+=C2=A0 =C2=A0 if (n =3D=3D 34) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env-&gt;pc_w * 2=
);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+int avr_cpu_gdb_write_register(<wbr>CPUState *cs, uint8_t *mem_buf, int n)=
<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 /*=C2=A0 R */<br>
+=C2=A0 =C2=A0 if (n &lt; 32) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;r[n] =3D *mem_buf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*=C2=A0 SREG */<br>
+=C2=A0 =C2=A0 if (n =3D=3D 32) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_set_sreg(env, *mem_buf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*=C2=A0 SP */<br>
+=C2=A0 =C2=A0 if (n =3D=3D 33) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;sp =3D lduw_p(mem_buf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 2;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*=C2=A0 PC */<br>
+=C2=A0 =C2=A0 if (n =3D=3D 34) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;pc_w =3D ldl_p(mem_buf) / 2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 4;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
diff --git a/target/avr/machine.c b/target/avr/machine.c<br>
new file mode 100644<br>
index 0000000000..f6dcda7adc<br>
--- /dev/null<br>
+++ b/target/avr/machine.c<br>
@@ -0,0 +1,121 @@<br>
+/*<br>
+ * QEMU AVR CPU<br>
+ *<br>
+ * Copyright (c) 2019 Michael Rolnik<br>
+ *<br>
+ * This library is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU Lesser General Public<br>
+ * License as published by the Free Software Foundation; either<br>
+ * version 2.1 of the License, or (at your option) any later version.<br>
+ *<br>
+ * This library is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU<=
br>
+ * Lesser General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU Lesser General Public<br>
+ * License along with this library; if not, see<br>
+ * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" target=3D"_bl=
ank">http://www.gnu.org/licenses/<wbr>lgpl-2.1.html</a>&gt;<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;cpu.h&quot;<br>
+#include &quot;migration/cpu.h&quot;<br>
+<br>
+static int get_sreg(QEMUFile *f, void *opaque, size_t size,<br>
+=C2=A0 =C2=A0 const VMStateField *field)<br>
+{<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D opaque;<br>
+=C2=A0 =C2=A0 uint8_t sreg;<br>
+<br>
+=C2=A0 =C2=A0 sreg =3D qemu_get_byte(f);<br>
+=C2=A0 =C2=A0 cpu_set_sreg(env, sreg);<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static int put_sreg(<br>
+=C2=A0 =C2=A0 QEMUFile *f, void *opaque, size_t size,<br>
+=C2=A0 =C2=A0 const VMStateField *field, QJSON *vmdesc)<br>
+{<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D opaque;<br>
+=C2=A0 =C2=A0 uint8_t sreg =3D cpu_get_sreg(env);<br>
+<br>
+=C2=A0 =C2=A0 qemu_put_byte(f, sreg);<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static const VMStateInfo vms_sreg =3D {<br>
+=C2=A0 =C2=A0 .name =3D &quot;sreg&quot;,<br>
+=C2=A0 =C2=A0 .get =3D get_sreg,<br>
+=C2=A0 =C2=A0 .put =3D put_sreg,<br>
+};<br>
+<br>
+static int get_segment(<br>
+=C2=A0 =C2=A0 QEMUFile *f, void *opaque, size_t size, const VMStateField *=
field)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t *ramp =3D opaque;<br>
+=C2=A0 =C2=A0 uint8_t temp;<br>
+<br>
+=C2=A0 =C2=A0 temp =3D qemu_get_byte(f);<br>
+=C2=A0 =C2=A0 *ramp =3D ((uint32_t)temp) &lt;&lt; 16;<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static int put_segment(<br>
+=C2=A0 =C2=A0 QEMUFile *f, void *opaque, size_t size,<br>
+=C2=A0 =C2=A0 const VMStateField *field, QJSON *vmdesc)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t *ramp =3D opaque;<br>
+=C2=A0 =C2=A0 uint8_t temp =3D *ramp &gt;&gt; 16;<br>
+<br>
+=C2=A0 =C2=A0 qemu_put_byte(f, temp);<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static const VMStateInfo vms_rampD =3D {<br>
+=C2=A0 =C2=A0 .name =3D &quot;rampD&quot;,<br>
+=C2=A0 =C2=A0 .get =3D get_segment,<br>
+=C2=A0 =C2=A0 .put =3D put_segment,<br>
+};<br>
+static const VMStateInfo vms_rampX =3D {<br>
+=C2=A0 =C2=A0 .name =3D &quot;rampX&quot;,<br>
+=C2=A0 =C2=A0 .get =3D get_segment,<br>
+=C2=A0 =C2=A0 .put =3D put_segment,<br>
+};<br>
+static const VMStateInfo vms_rampY =3D {<br>
+=C2=A0 =C2=A0 .name =3D &quot;rampY&quot;,<br>
+=C2=A0 =C2=A0 .get =3D get_segment,<br>
+=C2=A0 =C2=A0 .put =3D put_segment,<br>
+};<br>
+static const VMStateInfo vms_rampZ =3D {<br>
+=C2=A0 =C2=A0 .name =3D &quot;rampZ&quot;,<br>
+=C2=A0 =C2=A0 .get =3D get_segment,<br>
+=C2=A0 =C2=A0 .put =3D put_segment,<br>
+};<br>
+static const VMStateInfo vms_eind =3D {<br>
+=C2=A0 =C2=A0 .name =3D &quot;eind&quot;,<br>
+=C2=A0 =C2=A0 .get =3D get_segment,<br>
+=C2=A0 =C2=A0 .put =3D put_segment,<br>
+};<br>
+<br>
+const VMStateDescription vms_avr_cpu =3D {<br>
+=C2=A0 =C2=A0 .name =3D &quot;cpu&quot;,<br>
+=C2=A0 =C2=A0 .version_id =3D 0,<br>
+=C2=A0 =C2=A0 .minimum_version_id =3D 0,<br>
+=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(env.pc_w, AVRCPU),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(env.sp, AVRCPU),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(env.skip, AVRCPU),<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(env.r, AVRCPU, NO_CPU_REG=
ISTERS),<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_SINGLE(env, AVRCPU, 0, vms_sreg, CPUAV=
RState),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_SINGLE(env.rampD, AVRCPU, 0, vms_rampD=
, uint32_t),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_SINGLE(env.rampX, AVRCPU, 0, vms_rampX=
, uint32_t),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_SINGLE(env.rampY, AVRCPU, 0, vms_rampY=
, uint32_t),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_SINGLE(env.rampZ, AVRCPU, 0, vms_rampZ=
, uint32_t),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_SINGLE(env.eind, AVRCPU, 0, vms_eind, =
uint32_t),<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
+=C2=A0 =C2=A0 }<br>
+};<br>
diff --git a/gdb-xml/avr-cpu.xml b/gdb-xml/avr-cpu.xml<br>
new file mode 100644<br>
index 0000000000..c4747f5b40<br>
--- /dev/null<br>
+++ b/gdb-xml/avr-cpu.xml<br>
@@ -0,0 +1,49 @@<br>
+&lt;?xml version=3D&quot;1.0&quot;?&gt;<br>
+&lt;!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0Copying and distribution of this file, with or without=
 modification,<br>
+=C2=A0 =C2=A0 =C2=A0are permitted in any medium without royalty provided t=
he copyright<br>
+=C2=A0 =C2=A0 =C2=A0notice and this notice are preserved.=C2=A0 --&gt;<br>
+<br>
+&lt;!-- Register numbers are hard-coded in order to maintain backward<br>
+=C2=A0 =C2=A0 =C2=A0compatibility with older versions of tools that didn&#=
39;t use xml<br>
+=C2=A0 =C2=A0 =C2=A0register descriptions.=C2=A0 --&gt;<br>
+<br>
+&lt;!DOCTYPE feature SYSTEM &quot;gdb-target.dtd&quot;&gt;<br>
+&lt;feature name=3D&quot;org.gnu.gdb.riscv.cpu&quot;&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r0&quot; bitsize=3D&quot;8&quot; type=3D&quot;=
int&quot; regnum=3D&quot;0&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r1&quot; bitsize=3D&quot;8&quot; type=3D&quot;=
int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r2&quot; bitsize=3D&quot;8&quot; type=3D&quot;=
int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r3&quot; bitsize=3D&quot;8&quot; type=3D&quot;=
int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r4&quot; bitsize=3D&quot;8&quot; type=3D&quot;=
int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r5&quot; bitsize=3D&quot;8&quot; type=3D&quot;=
int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r6&quot; bitsize=3D&quot;8&quot; type=3D&quot;=
int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r7&quot; bitsize=3D&quot;8&quot; type=3D&quot;=
int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r8&quot; bitsize=3D&quot;8&quot; type=3D&quot;=
int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r9&quot; bitsize=3D&quot;8&quot; type=3D&quot;=
int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r10&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r11&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r12&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r13&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r14&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r15&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r16&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r17&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r18&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r19&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r20&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r21&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r22&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r23&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r24&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r25&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r26&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r27&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r28&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r29&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r30&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;r31&quot; bitsize=3D&quot;8&quot; type=3D&quot=
;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;sreg&quot; bitsize=3D&quot;8&quot; type=3D&quo=
t;int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;sp&quot; bitsize=3D&quot;8&quot; type=3D&quot;=
int&quot;/&gt;<br>
+=C2=A0 &lt;reg name=3D&quot;pc&quot; bitsize=3D&quot;8&quot; type=3D&quot;=
int&quot;/&gt;<br>
+&lt;/feature&gt;<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>

--0000000000005e5fb7059821b04f--

