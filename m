Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8072CC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3436920714
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HN0+Umiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3436920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY7R2-0006z1-Sb
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 06:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iY7OD-0005YF-6w
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:46:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iY7OA-0002CH-3h
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:46:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24742
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iY7O9-0002C7-UV
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574423173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LtYw50obwAgCR6lwqR/n1Z4jG5LOOMOvQq5PbBBpaEo=;
 b=HN0+UmiwG1ZYayoAB98Oko7Ljl4aeJrH7x0Vd17GQEqggpmiKg2906I4+iHlfKd8iLZ3Ah
 jSw+e/UueUz5/a8qTVpGlSijCCaEr/AZOsfklHs4c6M01smJkzS+tkyuC4b1WseYkrnIoP
 1FgCzPgdkaYCWmqV2ts+gYIjavmVuA8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-zp7InhOoMpaICy3_L9QHgg-1; Fri, 22 Nov 2019 06:46:10 -0500
Received: by mail-wm1-f72.google.com with SMTP id t203so2938100wmt.7
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 03:46:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GAXQQYU6dFiC4gUp302Ri2lpTeP9Ou2de4CMAw/gpUA=;
 b=daoyu2svkRB8mAjCa8Cx5Uzw477JWccldfbEx42sEM3DdkdORLgXa1AqKhFKvPNHV/
 2SBZLwo585n4F2t4Ib3wClkRVgIrIQv9GYMfpuUkwlSGx3cxnsyVI4n9FikJUJahZsCQ
 C7lIGG84NMH2KnI+eJRXLTp2oJaXhAjQxdOTunCqbLw11nFe04I9y4poRYJS+Un7isw9
 /KBsKcixbrqw6MKqW4H0xkr1kshBPKiAE3zKTBLoiJ/giGclex5isf3Im82u031PaL7c
 uHXyxHpP/DksbS3bLcamBs0UkRwoQKOw8NRnhtXm0pY0Bht78Rtc8Nz8KqwL9PkQ47iW
 NIIw==
X-Gm-Message-State: APjAAAV9vo56Rs2j7pq0veZsmzU7+NuinNj7RKjKeAq+zXUAUyC6ffEi
 PzOPBiL7oWId5ooifmRW5WBuVkx7TMTyCGSaqDsBRE1PkPK14+6rO6tKVa8qkkV21cnENRBXEIB
 zyq8hZ7UODarbcsg=
X-Received: by 2002:a1c:8055:: with SMTP id b82mr16592232wmd.176.1574423169547; 
 Fri, 22 Nov 2019 03:46:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqxclz/EYqBvwoQIwaRwEGNGfHNV48VyAIvlg3nlDAT5jeMRDfLVa3Hn7vMKnU+FU4aOxlP20Q==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr16592202wmd.176.1574423169152; 
 Fri, 22 Nov 2019 03:46:09 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id w19sm3165135wmk.36.2019.11.22.03.46.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 03:46:08 -0800 (PST)
Subject: Re: [PATCH v35 02/13] target/avr: Add instruction helpers
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-3-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fee15497-6fb8-5345-b1ba-861a69266990@redhat.com>
Date: Fri, 22 Nov 2019 12:46:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191029212430.20617-3-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: zp7InhOoMpaICy3_L9QHgg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: thuth@redhat.com, Joaquin de Andres <me@xcancerberox.com.ar>,
 richard.henderson@linaro.org, dovgaluk@ispras.ru, imammedo@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/19 10:24 PM, Michael Rolnik wrote:
> Stubs for unimplemented instructions and helpers for instructions that ne=
ed to interact with QEMU.
> SPM and WDR are unimplemented because they require emulation of complex p=
eripherals.
> The implementation of SLEEP is very limited due to the lack of peripheral=
s to generate wake interrupts.
> Memory access instructions are implemented here because some address rang=
es actually refer to CPU registers.
>=20
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   target/avr/helper.c | 354 ++++++++++++++++++++++++++++++++++++++++++++
>   target/avr/helper.h |  29 ++++
>   2 files changed, 383 insertions(+)
>   create mode 100644 target/avr/helper.c
>   create mode 100644 target/avr/helper.h
>=20
> diff --git a/target/avr/helper.c b/target/avr/helper.c
> new file mode 100644
> index 0000000000..f0f0d4f15a
> --- /dev/null
> +++ b/target/avr/helper.c
> @@ -0,0 +1,354 @@
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
> +
> +#include "cpu.h"
> +#include "hw/irq.h"
> +#include "hw/sysbus.h"
> +#include "sysemu/sysemu.h"
> +#include "exec/exec-all.h"
> +#include "exec/cpu_ldst.h"
> +#include "exec/helper-proto.h"
> +#include "exec/ioport.h"
> +#include "qemu/host-utils.h"
> +#include "qemu/error-report.h"
> +
> +bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
> +{
> +    bool ret =3D false;
> +    CPUClass *cc =3D CPU_GET_CLASS(cs);
> +    AVRCPU *cpu =3D AVR_CPU(cs);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    if (interrupt_request & CPU_INTERRUPT_RESET) {
> +        if (cpu_interrupts_enabled(env)) {
> +            cs->exception_index =3D EXCP_RESET;
> +            cc->do_interrupt(cs);
> +
> +            cs->interrupt_request &=3D ~CPU_INTERRUPT_RESET;
> +
> +            ret =3D true;
> +        }
> +    }
> +    if (interrupt_request & CPU_INTERRUPT_HARD) {
> +        if (cpu_interrupts_enabled(env) && env->intsrc !=3D 0) {
> +            int index =3D ctz32(env->intsrc);
> +            cs->exception_index =3D EXCP_INT(index);
> +            cc->do_interrupt(cs);
> +
> +            env->intsrc &=3D env->intsrc - 1; /* clear the interrupt */
> +            cs->interrupt_request &=3D ~CPU_INTERRUPT_HARD;
> +
> +            ret =3D true;
> +        }
> +    }
> +    return ret;
> +}
> +
> +void avr_cpu_do_interrupt(CPUState *cs)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(cs);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    uint32_t ret =3D env->pc_w;
> +    int vector =3D 0;
> +    int size =3D avr_feature(env, AVR_FEATURE_JMP_CALL) ? 2 : 1;
> +    int base =3D 0;
> +
> +    if (cs->exception_index =3D=3D EXCP_RESET) {
> +        vector =3D 0;
> +    } else if (env->intsrc !=3D 0) {
> +        vector =3D ctz32(env->intsrc) + 1;
> +    }
> +
> +    if (avr_feature(env, AVR_FEATURE_3_BYTE_PC)) {
> +        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
> +        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >> 8);
> +        cpu_stb_data(env, env->sp--, (ret & 0xff0000) >> 16);
> +    } else if (avr_feature(env, AVR_FEATURE_2_BYTE_PC)) {
> +        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
> +        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >> 8);
> +    } else {
> +        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
> +    }
> +
> +    env->pc_w =3D base + vector * size;
> +    env->sregI =3D 0; /* clear Global Interrupt Flag */
> +
> +    cs->exception_index =3D -1;
> +}
> +
> +int avr_cpu_memory_rw_debug(CPUState *cs, vaddr addr, uint8_t *buf,
> +                                int len, bool is_write)
> +{
> +    return cpu_memory_rw_debug(cs, addr, buf, len, is_write);
> +}
> +
> +hwaddr avr_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
> +{
> +    return addr; /* I assume 1:1 address correspondance */
> +}
> +
> +int avr_cpu_handle_mmu_fault(
> +    CPUState *cs, vaddr address, int size, int rw, int mmu_idx)
> +{
> +    /* currently it's assumed that this will never happen */
> +    cs->exception_index =3D EXCP_DEBUG;
> +    cpu_dump_state(cs, stderr, 0);
> +    return 1;
> +}
> +
> +bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                        MMUAccessType access_type, int mmu_idx,
> +                        bool probe, uintptr_t retaddr)
> +{
> +    int prot =3D 0;
> +    MemTxAttrs attrs =3D {};
> +    uint32_t paddr;
> +
> +    address &=3D TARGET_PAGE_MASK;
> +
> +    if (mmu_idx =3D=3D MMU_CODE_IDX) {
> +        /* access to code in flash */
> +        paddr =3D OFFSET_CODE + address;
> +        prot =3D PAGE_READ | PAGE_EXEC;
> +        if (paddr + TARGET_PAGE_SIZE > OFFSET_DATA) {
> +            error_report("execution left flash memory");
> +            exit(1);
> +        }
> +    } else if (address < NO_CPU_REGISTERS + NO_IO_REGISTERS) {
> +        /*
> +         * access to CPU registers, exit and rebuilt this TB to use full=
 access
> +         * incase it touches specially handled registers like SREG or SP
> +         */
> +        AVRCPU *cpu =3D AVR_CPU(cs);
> +        CPUAVRState *env =3D &cpu->env;
> +        env->fullacc =3D 1;
> +        cpu_loop_exit_restore(cs, retaddr);
> +    } else {
> +        /* access to memory. nothing special */
> +        paddr =3D OFFSET_DATA + address;
> +        prot =3D PAGE_READ | PAGE_WRITE;
> +    }
> +
> +    tlb_set_page_with_attrs(
> +        cs, address, paddr, attrs, prot, mmu_idx, TARGET_PAGE_SIZE);
> +
> +    return true;
> +}
> +
> +void helper_sleep(CPUAVRState *env)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +
> +    cs->exception_index =3D EXCP_HLT;
> +    cpu_loop_exit(cs);
> +}
> +
> +void helper_unsupported(CPUAVRState *env)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +
> +    /*
> +     *  I count not find what happens on the real platform, so
> +     *  it's EXCP_DEBUG for meanwhile
> +     */
> +    cs->exception_index =3D EXCP_DEBUG;
> +    if (qemu_loglevel_mask(LOG_UNIMP)) {
> +        qemu_log("UNSUPPORTED\n");
> +        cpu_dump_state(cs, qemu_logfile, 0);
> +    }
> +    cpu_loop_exit(cs);
> +}
> +
> +void helper_debug(CPUAVRState *env)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +
> +    cs->exception_index =3D EXCP_DEBUG;
> +    cpu_loop_exit(cs);
> +}
> +
> +void helper_break(CPUAVRState *env)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +
> +    cs->exception_index =3D EXCP_DEBUG;
> +    cpu_loop_exit(cs);
> +}
> +
> +void helper_wdr(CPUAVRState *env)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +
> +    /* WD is not implemented yet, placeholder */
> +    cs->exception_index =3D EXCP_DEBUG;
> +    cpu_loop_exit(cs);
> +}
> +
> +/*
> + * This function implements IN instruction
> + *
> + * It does the following
> + * a.  if an IO register belongs to CPU, its value is read and returned
> + * b.  otherwise io address is translated to mem address and physical me=
mory
> + *     is read.
> + * c.  it caches the value for sake of SBI, SBIC, SBIS & CBI implementat=
ion
> + *
> + */
> +target_ulong helper_inb(CPUAVRState *env, uint32_t port)
> +{
> +    target_ulong data =3D 0;
> +
> +    switch (port) {
> +    case 0x38: /* RAMPD */
> +        data =3D 0xff & (env->rampD >> 16);
> +        break;
> +    case 0x39: /* RAMPX */
> +        data =3D 0xff & (env->rampX >> 16);
> +        break;
> +    case 0x3a: /* RAMPY */
> +        data =3D 0xff & (env->rampY >> 16);
> +        break;
> +    case 0x3b: /* RAMPZ */
> +        data =3D 0xff & (env->rampZ >> 16);
> +        break;
> +    case 0x3c: /* EIND */
> +        data =3D 0xff & (env->eind >> 16);
> +        break;
> +    case 0x3d: /* SPL */
> +        data =3D env->sp & 0x00ff;
> +        break;
> +    case 0x3e: /* SPH */
> +        data =3D env->sp >> 8;
> +        break;
> +    case 0x3f: /* SREG */
> +        data =3D cpu_get_sreg(env);
> +        break;
> +    default:
> +        /* not a special register, pass to normal memory access */
> +        cpu_physical_memory_read(OFFSET_IO_REGISTERS + port, &data, 1);
> +    }
> +
> +    return data;
> +}
> +
> +/*
> + *  This function implements OUT instruction
> + *
> + *  It does the following
> + *  a.  if an IO register belongs to CPU, its value is written into the =
register
> + *  b.  otherwise io address is translated to mem address and physical m=
emory
> + *      is written.
> + *  c.  it caches the value for sake of SBI, SBIC, SBIS & CBI implementa=
tion
> + *
> + */
> +void helper_outb(CPUAVRState *env, uint32_t port, uint32_t data)
> +{
> +    data &=3D 0x000000ff;
> +
> +    switch (port) {
> +    case 0x38: /* RAMPD */
> +        if (avr_feature(env, AVR_FEATURE_RAMPD)) {
> +            env->rampD =3D (data & 0xff) << 16;
> +        }
> +        break;
> +    case 0x39: /* RAMPX */
> +        if (avr_feature(env, AVR_FEATURE_RAMPX)) {
> +            env->rampX =3D (data & 0xff) << 16;
> +        }
> +        break;
> +    case 0x3a: /* RAMPY */
> +        if (avr_feature(env, AVR_FEATURE_RAMPY)) {
> +            env->rampY =3D (data & 0xff) << 16;
> +        }
> +        break;
> +    case 0x3b: /* RAMPZ */
> +        if (avr_feature(env, AVR_FEATURE_RAMPZ)) {
> +            env->rampZ =3D (data & 0xff) << 16;
> +        }
> +        break;
> +    case 0x3c: /* EIDN */
> +        env->eind =3D (data & 0xff) << 16;
> +        break;
> +    case 0x3d: /* SPL */
> +        env->sp =3D (env->sp & 0xff00) | (data);
> +        break;
> +    case 0x3e: /* SPH */
> +        if (avr_feature(env, AVR_FEATURE_2_BYTE_SP)) {
> +            env->sp =3D (env->sp & 0x00ff) | (data << 8);
> +        }
> +        break;
> +    case 0x3f: /* SREG */
> +        cpu_set_sreg(env, data);
> +        break;
> +    default:
> +        /* not a special register, pass to normal memory access */
> +        cpu_physical_memory_write(OFFSET_IO_REGISTERS + port, &data, 1);
> +    }
> +}
> +
> +/*
> + *  this function implements LD instruction when there is a posibility t=
o read
> + *  from a CPU register
> + */
> +target_ulong helper_fullrd(CPUAVRState *env, uint32_t addr)
> +{
> +    uint8_t data;
> +
> +    env->fullacc =3D false;
> +
> +    if (addr < NO_CPU_REGISTERS) {
> +        /* CPU registers */
> +        data =3D env->r[addr];
> +    } else if (addr < NO_CPU_REGISTERS + NO_IO_REGISTERS) {
> +        /* IO registers */
> +        data =3D helper_inb(env, addr - NO_CPU_REGISTERS);
> +    } else {
> +        /* memory */
> +        cpu_physical_memory_read(OFFSET_DATA + addr, &data, 1);
> +    }
> +    return data;
> +}
> +
> +/*
> + *  this function implements ST instruction when there is a posibility t=
o write
> + *  into a CPU register
> + */
> +void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
> +{
> +    env->fullacc =3D false;
> +
> +    /* Following logic assumes this: */
> +    assert(OFFSET_CPU_REGISTERS =3D=3D OFFSET_DATA);
> +    assert(OFFSET_IO_REGISTERS =3D=3D OFFSET_CPU_REGISTERS + NO_CPU_REGI=
STERS);
> +
> +    if (addr < NO_CPU_REGISTERS) {
> +        /* CPU registers */
> +        env->r[addr] =3D data;
> +    } else if (addr < NO_CPU_REGISTERS + NO_IO_REGISTERS) {
> +        /* IO registers */
> +        helper_outb(env, addr - NO_CPU_REGISTERS, data);
> +    } else {
> +        /* memory */
> +        cpu_physical_memory_write(OFFSET_DATA + addr, &data, 1);
> +    }
> +}
> diff --git a/target/avr/helper.h b/target/avr/helper.h
> new file mode 100644
> index 0000000000..bf087504a8
> --- /dev/null
> +++ b/target/avr/helper.h
> @@ -0,0 +1,29 @@
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
> +DEF_HELPER_1(wdr, void, env)
> +DEF_HELPER_1(debug, void, env)
> +DEF_HELPER_1(break, void, env)
> +DEF_HELPER_1(sleep, void, env)
> +DEF_HELPER_1(unsupported, void, env)
> +DEF_HELPER_3(outb, void, env, i32, i32)
> +DEF_HELPER_2(inb, tl, env, i32)
> +DEF_HELPER_3(fullwr, void, env, i32, i32)
> +DEF_HELPER_2(fullrd, tl, env, i32)
>=20


