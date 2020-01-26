Return-Path: <SRS0=sDSq=3P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3C3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2020 12:17:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0A2206D5
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2020 12:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xcancerberox.com.ar header.i=@xcancerberox.com.ar header.b="o4AU8KyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0A2206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xcancerberox.com.ar
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivgrB-00037F-Pz
	for qemu-devel@archiver.kernel.org; Sun, 26 Jan 2020 07:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <me@xcancerberox.com.ar>) id 1ivgp2-0002Y9-3Z
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 07:15:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <me@xcancerberox.com.ar>) id 1ivgow-0004AX-MW
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 07:15:24 -0500
Received: from [51.158.76.159] (port=41490 helo=mail.xcancerberox.com.ar)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <me@xcancerberox.com.ar>)
 id 1ivgov-00048z-Ov; Sun, 26 Jan 2020 07:15:18 -0500
Subject: Re: [PATCH rc2 01/25] target/avr: Add outward facing interfaces and
 core CPU logic
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xcancerberox.com.ar;
 s=mail; t=1580040910;
 bh=gQswIVgwLR025cAKNwyTX+yRKD3TZ3gi6HumlnLx4yU=;
 h=Subject:To:Cc:References:From:In-Reply-To;
 b=o4AU8KyDSas1ALMmmuy49QPKtPeLZSvROBMw0mTHTsu0x0KfBa4CoFeBnkKgnK8ZX
 fFBBTkppLNE4cpn3zBPYQgU8ZbMmSpaYRVE5rDInMb/6ayOFTx66C+t3Xvf9pH0U7c
 nzX1SzgcfwR6yBUv9JKtylV2979oZxHmbXHP9n1i/wdZ2XLvIMSIfA1AsTAMFCIOA/
 MyIWgjOUx9nQcIXRCRwvec9XRV2lu6Emwv4CjoBtd+gl20X8MEM/jqiuuKjPdQdxaf
 a8IR6niAFTkIKfBMXQaCK/+lRCa5h/Uz2oEl8HetM6wHB42XTLZzMWEgu2NVrPoETf
 Jd/G+Q0JlVF5Q==
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, mrolnik@gmail.com, richard.henderson@linaro.org
References: <20200124005131.16276-1-f4bug@amsat.org>
 <20200124005131.16276-2-f4bug@amsat.org>
From: Joaquin de Andres <me@xcancerberox.com.ar>
Openpgp: preference=signencrypt
Autocrypt: addr=me@xcancerberox.com.ar; keydata=
 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
 OZRo+ULKJ1xXuVGe8hnP9Q==
Message-ID: <7ae1607e-060e-23ac-f651-8f2ace8991ba@xcancerberox.com.ar>
Date: Sun, 26 Jan 2020 13:15:09 +0100
Mime-Version: 1.0
In-Reply-To: <20200124005131.16276-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 51.158.76.159
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
 S.E.Harris@kent.ac.uk, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, thuth@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 dovgaluk@ispras.ru, imammedo@redhat.com,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi! In this mail I only checked the general code and one of the listed
features for the different types of avr. I will check the rest in
following emails.

On 1/24/20 1:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> From: Michael Rolnik <mrolnik@gmail.com>
>=20
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
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-Id: <20200118191416.19934-2-mrolnik@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/avr/cpu-param.h |  37 ++
>  target/avr/cpu-qom.h   |  54 +++
>  target/avr/cpu.h       | 258 +++++++++++++
>  target/avr/cpu.c       | 826 +++++++++++++++++++++++++++++++++++++++++
>  target/avr/gdbstub.c   |  84 +++++
>  target/avr/machine.c   | 121 ++++++
>  gdb-xml/avr-cpu.xml    |  49 +++
>  7 files changed, 1429 insertions(+)
>  create mode 100644 target/avr/cpu-param.h
>  create mode 100644 target/avr/cpu-qom.h
>  create mode 100644 target/avr/cpu.h
>  create mode 100644 target/avr/cpu.c
>  create mode 100644 target/avr/gdbstub.c
>  create mode 100644 target/avr/machine.c
>  create mode 100644 gdb-xml/avr-cpu.xml
>=20
> diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
> new file mode 100644
> index 0000000000..0c29ce4223
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
> +#define AVR_CPU_PARAM_H
> +
> +#define TARGET_LONG_BITS 32
> +/*
> + * TARGET_PAGE_BITS cannot be more than 8 bits because
> + * 1.  all IO registers occupy [0x0000 .. 0x00ff] address range, and t=
hey
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
> index 0000000000..b74bcf01ae
> --- /dev/null
> +++ b/target/avr/cpu.h
> @@ -0,0 +1,258 @@
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
> +#define AVR_CPU_TYPE_SUFFIX "-" TYPE_AVR_CPU
> +#define AVR_CPU_TYPE_NAME(name) (name AVR_CPU_TYPE_SUFFIX)
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
> +#define NUMBER_OF_CPU_REGISTERS 32
> +/* Number of IO registers accessible by ld/st/in/out */
> +#define NUMBER_OF_IO_REGISTERS 64
> +
> +/*
> + * Offsets of AVR memory regions in host memory space.
> + *
> + * This is needed because the AVR has separate code and data address
> + * spaces that both have start from zero but have to go somewhere in
> + * host memory.
> + *
> + * It's also useful to know where some things are, like the IO registe=
rs.
> + */
> +/* Flash program memory */
> +#define OFFSET_CODE 0x00000000
> +/* CPU registers, IO registers, and SRAM */
> +#define OFFSET_DATA 0x00800000
> +/* CPU registers specifically, these are mapped at the start of data *=
/
> +#define OFFSET_CPU_REGISTERS OFFSET_DATA
> +/*
> + * IO registers, including status register, stack pointer, and memory
> + * mapped peripherals, mapped just after CPU registers
> + */
> +#define OFFSET_IO_REGISTERS (OFFSET_DATA + NUMBER_OF_CPU_REGISTERS)
> +
> +#define EF_AVR_MACH 0x7F
> +
> +typedef enum AVRFeature {
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
> +} AVRFeature;
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
> +    uint32_t r[NUMBER_OF_CPU_REGISTERS]; /* 8 bits each */
> +    uint32_t sp; /* 16 bits */
> +
> +    uint32_t skip; /* if set skip instruction */
> +
> +    uint64_t intsrc; /* interrupt sources */
> +    bool fullacc; /* CPU/MEM if true MEM only otherwise */
> +
> +    uint32_t features;
> +};

Why not use 'uint8_t' for all sreg bits, ramps, eind and user registers,
and bool for skip flag?

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
> +static inline int avr_feature(CPUAVRState *env, AVRFeature feature)
> +{
> +    return (env->features & (1U << feature)) !=3D 0;
> +}
> +
> +static inline void avr_set_feature(CPUAVRState *env, int feature)
> +{
> +    env->features |=3D (1U << feature);
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
> +    TB_FLAGS_FULL_ACCESS =3D 1,
> +    TB_FLAGS_SKIP =3D 2,
> +};
> +
> +static inline void cpu_get_tb_cpu_state(CPUAVRState *env, target_ulong=
 *pc,
> +                                target_ulong *cs_base, uint32_t *pflag=
s)
> +{
> +    uint32_t flags =3D 0;
> +
> +    *pc =3D env->pc_w * 2;
> +    *cs_base =3D 0;
> +
> +    if (env->fullacc) {
> +        flags |=3D TB_FLAGS_FULL_ACCESS;
> +    }
> +    if (env->skip) {
> +        flags |=3D TB_FLAGS_SKIP;
> +    }
> +
> +    *pflags =3D flags;
> +}
> +
> +static inline int cpu_interrupts_enabled(CPUAVRState *env)
> +{
> +    return env->sregI !=3D 0;
> +}
> +
> +static inline uint8_t cpu_get_sreg(CPUAVRState *env)
> +{
> +    uint8_t sreg;
> +    sreg =3D (env->sregC) << 0
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
> +    env->sregC =3D (sreg >> 0) & 0x01;
> +    env->sregZ =3D (sreg >> 1) & 0x01;
> +    env->sregN =3D (sreg >> 2) & 0x01;
> +    env->sregV =3D (sreg >> 3) & 0x01;
> +    env->sregS =3D (sreg >> 4) & 0x01;
> +    env->sregH =3D (sreg >> 5) & 0x01;
> +    env->sregT =3D (sreg >> 6) & 0x01;
> +    env->sregI =3D (sreg >> 7) & 0x01;
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
> +const char *avr_flags_to_cpu_type(uint32_t flags, const char *def_cpu_=
type);
> +
> +#endif /* !defined (QEMU_AVR_CPU_H) */
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> new file mode 100644
> index 0000000000..c74c5106fe
> --- /dev/null
> +++ b/target/avr/cpu.c
> @@ -0,0 +1,826 @@
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
> +#include "disas/dis-asm.h"
> +
> +static void avr_cpu_set_pc(CPUState *cs, vaddr value)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(cs);
> +
> +    cpu->env.pc_w =3D value / 2; /* internally PC points to words */
> +}

Isn't it safer to add 'assert(!(value % 2))' before this call?

> +
> +static bool avr_cpu_has_work(CPUState *cs)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(cs);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    return (cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUP=
T_RESET))
> +            && cpu_interrupts_enabled(env);
> +}
> +
> +static void avr_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock=
 *tb)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(cs);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    env->pc_w =3D tb->pc / 2; /* internally PC points to words */

Same that above.

> +}> +
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
> +static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *in=
fo)
> +{
> +    info->mach =3D bfd_arch_avr;
> +    info->print_insn =3D NULL;
> +}
> +
> +static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
> +{
> +    CPUState *cs =3D CPU(dev);
> +    AVRCPUClass *mcc =3D AVR_CPU_GET_CLASS(dev);
> +    Error *local_err =3D NULL;
> +
> +    cpu_exec_realizefn(cs, &local_err);
> +    if (local_err !=3D NULL) {
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
> +    AVRCPU *cpu =3D opaque;
> +    CPUAVRState *env =3D &cpu->env;
> +    CPUState *cs =3D CPU(cpu);
> +
> +    uint64_t mask =3D (1ull << irq);
> +    if (level) {
> +        env->intsrc |=3D mask;
> +        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> +    } else {
> +        env->intsrc &=3D ~mask;
> +        if (env->intsrc =3D=3D 0) {
> +            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> +        }
> +    }
> +}
> +
> +static void avr_cpu_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +
> +    cpu_set_cpustate_pointers(cpu);
> +
> +#ifndef CONFIG_USER_ONLY
> +    /* Set the number of interrupts supported by the CPU. */
> +    qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int,
> +            sizeof(cpu->env.intsrc) * 8);
> +#endif
> +}
> +
> +static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
> +{
> +    ObjectClass *oc;
> +
> +    oc =3D object_class_by_name(cpu_model);
> +    if (object_class_dynamic_cast(oc, TYPE_AVR_CPU) =3D=3D NULL ||
> +        object_class_is_abstract(oc)) {
> +        oc =3D NULL;
> +    }
> +    return oc;
> +}
> +
> +static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(cs);
> +    CPUAVRState *env =3D &cpu->env;
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
> +                        env->sregN ? '-' : 'N', /* Zf has negative log=
ic */
> +                        env->sregZ ? 'Z' : '-',
> +                        env->sregC ? 'I' : '-');
> +    qemu_fprintf(f, "SKIP:    %02x\n", env->skip);
> +
> +    qemu_fprintf(f, "\n");
> +    for (i =3D 0; i < ARRAY_SIZE(env->r); i++) {
> +        qemu_fprintf(f, "R[%02d]:  %02x   ", i, env->r[i]);
> +
> +        if ((i % 8) =3D=3D 7) {
> +            qemu_fprintf(f, "\n");
> +        }
> +    }
> +    qemu_fprintf(f, "\n");
> +}
> +
> +static void avr_cpu_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +    CPUClass *cc =3D CPU_CLASS(oc);
> +    AVRCPUClass *mcc =3D AVR_CPU_CLASS(oc);
> +
> +    mcc->parent_realize =3D dc->realize;
> +    dc->realize =3D avr_cpu_realizefn;
> +
> +    mcc->parent_reset =3D cc->reset;
> +    cc->reset =3D avr_cpu_reset;
> +
> +    cc->class_by_name =3D avr_cpu_class_by_name;
> +
> +    cc->has_work =3D avr_cpu_has_work;
> +    cc->do_interrupt =3D avr_cpu_do_interrupt;
> +    cc->cpu_exec_interrupt =3D avr_cpu_exec_interrupt;
> +    cc->dump_state =3D avr_cpu_dump_state;
> +    cc->set_pc =3D avr_cpu_set_pc;
> +#if !defined(CONFIG_USER_ONLY)
> +    cc->memory_rw_debug =3D avr_cpu_memory_rw_debug;
> +#endif
> +#ifdef CONFIG_USER_ONLY
> +    cc->handle_mmu_fault =3D avr_cpu_handle_mmu_fault;
> +#else
> +    cc->get_phys_page_debug =3D avr_cpu_get_phys_page_debug;
> +    cc->vmsd =3D &vms_avr_cpu;
> +#endif
> +    cc->disas_set_info =3D avr_cpu_disas_set_info;
> +    cc->tlb_fill =3D avr_cpu_tlb_fill;
> +    cc->tcg_initialize =3D avr_cpu_tcg_init;
> +    cc->synchronize_from_tb =3D avr_cpu_synchronize_from_tb;
> +    cc->gdb_read_register =3D avr_cpu_gdb_read_register;
> +    cc->gdb_write_register =3D avr_cpu_gdb_write_register;
> +    cc->gdb_num_core_regs =3D 35;
> +    cc->gdb_core_xml_file =3D "avr-cpu.xml";
> +}
> +
> +/*
> + * Setting features of AVR core type avr1
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * at90s1200, attiny11, attiny12, attiny15, attiny28
> + */
> +static void avr_avr1_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);

Checking features with the datasheet of the listed microcontroller I saw
that the stack is a 3 level deep hardware stack dedicated to subroutines
and interrupts.
Why is the feature 2_BYTE_SP active?

> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +}
> +
> +/*
> + * Setting features of AVR core type avr2
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * at90s2313, at90s2323, at90s2333, at90s2343, attiny22, attiny26, at9=
0s4414,
> + * at90s4433, at90s4434, at90s8515, at90c8534, at90s8535
> + */
> +static void avr_avr2_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);

Same. This microcontrollers (only checked with at90s2313 datasheet) use
only SPL, why is the 2_BYTE_SP feature active?

> +}
> +
> +/*
> + * Setting features of AVR core type avr25
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * ata5272, ata6616c, attiny13, attiny13a, attiny2313, attiny2313a, at=
tiny24,
> + * attiny24a, attiny4313, attiny44, attiny44a, attiny441, attiny84, at=
tiny84a,
> + * attiny25, attiny45, attiny85, attiny261, attiny261a, attiny461, att=
iny461a,
> + * attiny861, attiny861a, attiny43u, attiny87, attiny48, attiny88, att=
iny828,
> + * attiny841, at86rf401
> + */
> +static void avr_avr25_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);

Same. This microcontrollers (only checked with attiny13 datasheet) use
only SPL, why is the 2_BYTE_SP feature active?

> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);
> +}
> +
> +/*
> + * Setting features of AVR core type avr3
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * at43usb355, at76c711
> + */
> +static void avr_avr3_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);

Ok. Checked with at43usb355 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> +}
> +
> +/*
> + * Setting features of AVR core type avr31
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atmega103, at43usb320
> + */
> +static void avr_avr31_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);

Ok. Checked with atmega103 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> +    avr_set_feature(env, AVR_FEATURE_ELPM);
> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> +}
> +
> +/*
> + * Setting features of AVR core type avr35
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * ata5505, ata6617c, ata664251, at90usb82, at90usb162, atmega8u2, atm=
ega16u2,
> + * atmega32u2, attiny167, attiny1634
> + */
> +static void avr_avr35_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);

Ok. Checked with atmega8u2 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);
> +}
> +
> +/*
> + * Setting features of AVR core type avr4
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * ata6285, ata6286, ata6289, ata6612c, atmega8, atmega8a, atmega48, a=
tmega48a,
> + * atmega48p, atmega48pa, atmega48pb, atmega88, atmega88a, atmega88p,
> + * atmega88pa, atmega88pb, atmega8515, atmega8535, atmega8hva, at90pwm=
1,
> + * at90pwm2, at90pwm2b, at90pwm3, at90pwm3b, at90pwm81
> + */
> +static void avr_avr4_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);

Ok. Checked with atmega8 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);
> +    avr_set_feature(env, AVR_FEATURE_MUL);
> +}
> +
> +/*
> + * Setting features of AVR core type avr5
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * ata5702m322, ata5782, ata5790, ata5790n, ata5791, ata5795, ata5831,=
 ata6613c,
> + * ata6614q, ata8210, ata8510, atmega16, atmega16a, atmega161, atmega1=
62,
> + * atmega163, atmega164a, atmega164p, atmega164pa, atmega165, atmega16=
5a,
> + * atmega165p, atmega165pa, atmega168, atmega168a, atmega168p, atmega1=
68pa,
> + * atmega168pb, atmega169, atmega169a, atmega169p, atmega169pa, atmega=
16hvb,
> + * atmega16hvbrevb, atmega16m1, atmega16u4, atmega32a, atmega32, atmeg=
a323,
> + * atmega324a, atmega324p, atmega324pa, atmega325, atmega325a, atmega3=
25p,
> + * atmega325pa, atmega3250, atmega3250a, atmega3250p, atmega3250pa, at=
mega328,
> + * atmega328p, atmega328pb, atmega329, atmega329a, atmega329p, atmega3=
29pa,
> + * atmega3290, atmega3290a, atmega3290p, atmega3290pa, atmega32c1, atm=
ega32m1,
> + * atmega32u4, atmega32u6, atmega406, atmega64, atmega64a, atmega640, =
atmega644,
> + * atmega644a, atmega644p, atmega644pa, atmega645, atmega645a, atmega6=
45p,
> + * atmega6450, atmega6450a, atmega6450p, atmega649, atmega649a, atmega=
649p,
> + * atmega6490, atmega16hva, atmega16hva2, atmega32hvb, atmega6490a, at=
mega6490p,
> + * atmega64c1, atmega64m1, atmega64hve, atmega64hve2, atmega64rfr2,
> + * atmega644rfr2, atmega32hvbrevb, at90can32, at90can64, at90pwm161, a=
t90pwm216,
> + * at90pwm316, at90scr100, at90usb646, at90usb647, at94k, m3000
> + */
> +static void avr_avr5_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);

Ok. Checked with atmega64 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);
> +    avr_set_feature(env, AVR_FEATURE_MUL);
> +}
> +
> +/*
> + * Setting features of AVR core type avr51
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atmega128, atmega128a, atmega1280, atmega1281, atmega1284, atmega12=
84p,
> + * atmega128rfa1, atmega128rfr2, atmega1284rfr2, at90can128, at90usb12=
86,
> + * at90usb1287
> + */
> +static void avr_avr51_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);

Ok. Checked with atmega128 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> +    avr_set_feature(env, AVR_FEATURE_ELPM);
> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);
> +    avr_set_feature(env, AVR_FEATURE_MUL);
> +}
> +
> +/*
> + * Setting features of AVR core type avr6
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atmega2560, atmega2561, atmega256rfr2, atmega2564rfr2
> + */
> +static void avr_avr6_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);

Ok. Checked with atmega2560 datasheet.

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
> +/*
> + * Setting features of AVR core type avrtiny
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * attiny4, attiny5, attiny9, attiny10, attiny20, attiny40
> + */
> +static void avr_avrtiny_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_1_BYTE_SP);

The attiny4 datasheet writes:
"The AVR stack pointer is implemented as two 8-bit registers in the I/O
space. The number of bits actually used is implementation dependent."
Not using AVR_FEATURE_2_BYTE_SP isn't leaving out the ones with two
bytes SP?

> +}
> +
> +/*
> + * Setting features of AVR core type xmega2
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atxmega8e5, atxmega16a4, atxmega16d4, atxmega16e5, atxmega32a4, atx=
mega32c3,
> + * atxmega32d3, atxmega32d4, atxmega16a4u, atxmega16c4, atxmega32a4u,
> + * atxmega32c4, atxmega32e5
> + */
> +static void avr_xmega2_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);

Ok. Checked with atxmega8e5 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);
> +    avr_set_feature(env, AVR_FEATURE_MUL);
> +    avr_set_feature(env, AVR_FEATURE_RMW);
> +}
> +
> +/*
> + * Setting features of AVR core type xmega3
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * attiny212, attiny214, attiny412, attiny414, attiny416, attiny417, a=
ttiny814,
> + * attiny816, attiny817, attiny1614, attiny1616, attiny1617, attiny321=
4,
> + * attiny3216, attiny3217, atmega808, atmega809, atmega1608, atmega160=
9,
> + * atmega3208, atmega3209, atmega4808, atmega4809
> + */
> +static void avr_xmega3_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);

Ok. Checked with attiny212 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);
> +    avr_set_feature(env, AVR_FEATURE_MUL);
> +    avr_set_feature(env, AVR_FEATURE_RMW);
> +}
> +
> +/*
> + * Setting features of AVR core type xmega4
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atxmega64a3, atxmega64d3, atxmega64a3u, atxmega64a4u, atxmega64b1,
> + * atxmega64b3, atxmega64c3, atxmega64d4
> + */
> +static void avr_xmega4_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);

Ok. I couldn't find an exact definition of the SP length but it says
that the SRAM is used as stack. The max length of ram being 16KB.
Checked with atxmega64a3 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> +    avr_set_feature(env, AVR_FEATURE_ELPM);
> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);
> +    avr_set_feature(env, AVR_FEATURE_MUL);
> +    avr_set_feature(env, AVR_FEATURE_RMW);
> +}
> +
> +/*
> + * Setting features of AVR core type xmega5
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atxmega64a1, atxmega64a1u
> + */
> +static void avr_xmega5_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);

Ok. Checked with atxmega64a1 datasheet.

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
> +/*
> + * Setting features of AVR core type xmega6
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atxmega128a3, atxmega128d3, atxmega192a3, atxmega192d3, atxmega256a=
3,
> + * atxmega256a3b, atxmega256a3bu, atxmega256d3, atxmega128a3u, atxmega=
128b1,
> + * atxmega128b3, atxmega128c3, atxmega128d4, atxmega192a3u, atxmega192=
c3,
> + * atxmega256a3u, atxmega256c3, atxmega384c3, atxmega384d3
> + */
> +static void avr_xmega6_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);

Ok. I couldn't find an exact definition of the SP length but it says
that the SRAM is used as stack. The max length of ram being 16KB.
Checked with atxmega128a3 datasheet.

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
> +/*
> + * Setting features of AVR core type xmega7
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atxmega128a1, atxmega128a1u, atxmega128a4u
> + */
> +static void avr_xmega7_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);
> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);

Ok. Checked with atxmega128a1 datasheet.

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
> +    const char *typename =3D object_class_get_name(OBJECT_CLASS(data))=
;
> +
> +    qemu_printf("%s\n", typename);
> +}
> +
> +void avr_cpu_list(void)
> +{
> +    GSList *list;
> +    list =3D object_class_get_list_sorted(TYPE_AVR_CPU, false);
> +    g_slist_foreach(list, avr_cpu_list_entry, NULL);
> +    g_slist_free(list);
> +}
> +
> +#define DEFINE_AVR_CPU_TYPE(model, initfn) \
> +    { \
> +        .parent =3D TYPE_AVR_CPU, \
> +        .instance_init =3D initfn, \
> +        .name =3D AVR_CPU_TYPE_NAME(model), \
> +    }
> +
> +static const TypeInfo avr_cpu_type_info[] =3D {
> +    {
> +        .name =3D TYPE_AVR_CPU,
> +        .parent =3D TYPE_CPU,
> +        .instance_size =3D sizeof(AVRCPU),
> +        .instance_init =3D avr_cpu_initfn,
> +        .class_size =3D sizeof(AVRCPUClass),
> +        .class_init =3D avr_cpu_class_init,
> +        .abstract =3D true,
> +    },
> +    DEFINE_AVR_CPU_TYPE("avrtiny", avr_avrtiny_initfn),
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
> +    DEFINE_AVR_CPU_TYPE("xmega3", avr_xmega3_initfn),
> +    DEFINE_AVR_CPU_TYPE("xmega4", avr_xmega4_initfn),
> +    DEFINE_AVR_CPU_TYPE("xmega5", avr_xmega5_initfn),
> +    DEFINE_AVR_CPU_TYPE("xmega6", avr_xmega6_initfn),
> +    DEFINE_AVR_CPU_TYPE("xmega7", avr_xmega7_initfn),
> +};
> +
> +const char *avr_flags_to_cpu_type(uint32_t flags, const char *def_cpu_=
type)
> +{
> +    switch (flags & EF_AVR_MACH) {
> +    case bfd_mach_avr1:
> +        return AVR_CPU_TYPE_NAME("avr1");
> +    case bfd_mach_avr2:
> +        return AVR_CPU_TYPE_NAME("avr2");
> +    case bfd_mach_avr25:
> +        return AVR_CPU_TYPE_NAME("avr25");
> +    case bfd_mach_avr3:
> +        return AVR_CPU_TYPE_NAME("avr3");
> +    case bfd_mach_avr31:
> +        return AVR_CPU_TYPE_NAME("avr31");
> +    case bfd_mach_avr35:
> +        return AVR_CPU_TYPE_NAME("avr35");
> +    case bfd_mach_avr4:
> +        return AVR_CPU_TYPE_NAME("avr4");
> +    case bfd_mach_avr5:
> +        return AVR_CPU_TYPE_NAME("avr5");
> +    case bfd_mach_avr51:
> +        return AVR_CPU_TYPE_NAME("avr51");
> +    case bfd_mach_avr6:
> +        return AVR_CPU_TYPE_NAME("avr6");
> +    case bfd_mach_avrtiny:
> +        return AVR_CPU_TYPE_NAME("avrtiny");
> +    case bfd_mach_avrxmega2:
> +        return AVR_CPU_TYPE_NAME("xmega2");
> +    case bfd_mach_avrxmega3:
> +        return AVR_CPU_TYPE_NAME("xmega3");
> +    case bfd_mach_avrxmega4:
> +        return AVR_CPU_TYPE_NAME("xmega4");
> +    case bfd_mach_avrxmega5:
> +        return AVR_CPU_TYPE_NAME("xmega5");
> +    case bfd_mach_avrxmega6:
> +        return AVR_CPU_TYPE_NAME("xmega6");
> +    case bfd_mach_avrxmega7:
> +        return AVR_CPU_TYPE_NAME("xmega7");
> +    default:
> +        return def_cpu_type;
> +    }
> +}
> +
> +DEFINE_TYPES(avr_cpu_type_info)
> diff --git a/target/avr/gdbstub.c b/target/avr/gdbstub.c
> new file mode 100644
> index 0000000000..733184c08f
> --- /dev/null
> +++ b/target/avr/gdbstub.c
> @@ -0,0 +1,84 @@
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
> +#include "exec/gdbstub.h"
> +
> +int avr_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(cs);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    /*  R */
> +    if (n < 32) {
> +        return gdb_get_reg8(mem_buf, env->r[n]);
> +    }
> +
> +    /*  SREG */
> +    if (n =3D=3D 32) {
> +        uint8_t sreg =3D cpu_get_sreg(env);
> +
> +        return gdb_get_reg8(mem_buf, sreg);
> +    }
> +
> +    /*  SP */
> +    if (n =3D=3D 33) {
> +        return gdb_get_reg16(mem_buf, env->sp & 0x0000ffff);
> +    }
> +
> +    /*  PC */
> +    if (n =3D=3D 34) {
> +        return gdb_get_reg32(mem_buf, env->pc_w * 2);
> +    }
> +
> +    return 0;
> +}
> +
> +int avr_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(cs);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    /*  R */
> +    if (n < 32) {
> +        env->r[n] =3D *mem_buf;
> +        return 1;
> +    }
> +
> +    /*  SREG */
> +    if (n =3D=3D 32) {
> +        cpu_set_sreg(env, *mem_buf);
> +        return 1;
> +    }
> +
> +    /*  SP */
> +    if (n =3D=3D 33) {
> +        env->sp =3D lduw_p(mem_buf);
> +        return 2;
> +    }
> +
> +    /*  PC */
> +    if (n =3D=3D 34) {
> +        env->pc_w =3D ldl_p(mem_buf) / 2;
> +        return 4;
> +    }
> +
> +    return 0;
> +}
> diff --git a/target/avr/machine.c b/target/avr/machine.c
> new file mode 100644
> index 0000000000..ba44bd042b
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
> +    CPUAVRState *env =3D opaque;
> +    uint8_t sreg;
> +
> +    sreg =3D qemu_get_byte(f);
> +    cpu_set_sreg(env, sreg);
> +    return 0;
> +}
> +
> +static int put_sreg(
> +    QEMUFile *f, void *opaque, size_t size,
> +    const VMStateField *field, QJSON *vmdesc)
> +{
> +    CPUAVRState *env =3D opaque;
> +    uint8_t sreg =3D cpu_get_sreg(env);
> +
> +    qemu_put_byte(f, sreg);
> +    return 0;
> +}
> +
> +static const VMStateInfo vms_sreg =3D {
> +    .name =3D "sreg",
> +    .get =3D get_sreg,
> +    .put =3D put_sreg,
> +};
> +
> +static int get_segment(
> +    QEMUFile *f, void *opaque, size_t size, const VMStateField *field)
> +{
> +    uint32_t *ramp =3D opaque;
> +    uint8_t temp;
> +
> +    temp =3D qemu_get_byte(f);
> +    *ramp =3D ((uint32_t)temp) << 16;
> +    return 0;
> +}
> +
> +static int put_segment(
> +    QEMUFile *f, void *opaque, size_t size,
> +    const VMStateField *field, QJSON *vmdesc)
> +{
> +    uint32_t *ramp =3D opaque;
> +    uint8_t temp =3D *ramp >> 16;
> +
> +    qemu_put_byte(f, temp);
> +    return 0;
> +}
> +
> +static const VMStateInfo vms_rampD =3D {
> +    .name =3D "rampD",
> +    .get =3D get_segment,
> +    .put =3D put_segment,
> +};
> +static const VMStateInfo vms_rampX =3D {
> +    .name =3D "rampX",
> +    .get =3D get_segment,
> +    .put =3D put_segment,
> +};
> +static const VMStateInfo vms_rampY =3D {
> +    .name =3D "rampY",
> +    .get =3D get_segment,
> +    .put =3D put_segment,
> +};
> +static const VMStateInfo vms_rampZ =3D {
> +    .name =3D "rampZ",
> +    .get =3D get_segment,
> +    .put =3D put_segment,
> +};
> +static const VMStateInfo vms_eind =3D {
> +    .name =3D "eind",
> +    .get =3D get_segment,
> +    .put =3D put_segment,
> +};
> +
> +const VMStateDescription vms_avr_cpu =3D {
> +    .name =3D "cpu",
> +    .version_id =3D 0,
> +    .minimum_version_id =3D 0,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(env.pc_w, AVRCPU),
> +        VMSTATE_UINT32(env.sp, AVRCPU),
> +        VMSTATE_UINT32(env.skip, AVRCPU),
> +
> +        VMSTATE_UINT32_ARRAY(env.r, AVRCPU, NUMBER_OF_CPU_REGISTERS),
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
> +<?xml version=3D"1.0"?>
> +<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modificati=
on,
> +     are permitted in any medium without royalty provided the copyrigh=
t
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
>=20

General concern: why is there an AVR_FEATURE_1_BYTE_PC when the code
does nothing with it?

--Joa

