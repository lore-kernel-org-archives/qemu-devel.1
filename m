Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F70C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 16:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5E22072B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 16:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FITLoUa6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5E22072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iihEb-0002J9-9B
	for qemu-devel@archiver.kernel.org; Sat, 21 Dec 2019 11:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iihDk-0001o8-Tc
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 11:03:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iihDf-0000ma-5y
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 11:03:12 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34186)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iihDe-0000it-Lg
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 11:03:07 -0500
Received: by mail-ot1-x343.google.com with SMTP id a15so16064718otf.1
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2019 08:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=G3MmReWa5j5sFld79AtxiU6R5eelzD0eh8rA096ZHOA=;
 b=FITLoUa6zHWK3qDrDJ7fXREjvFkslyjCqQpNRnjLnk44v5eh0iETSFN/91iNwJ8dDv
 uhIPkFBUdJN2TMrZ66hLWu8aXxgLQk5oChJPjWwX8+Y4rqQN7/fbPBSB7HHT1KS/GU/T
 t4+FaBskxM/WYSLbvNJI6wcjq84irF/R+u1v6BgX8vdxBLyz8XH455vG1mTuE9QcdlTZ
 NWxztyiHXfehx9i3JA8fUegCKuhhfTwYvaoGqZJ7lgAh9kr/23pJ0ABgBkAt7Yoqfehr
 MuJAmjyxNzCpwezRLwUAhH14GtlrvcZmr/B9RYylidjxFj6qL8NplnRmVJhP+GEZ7bgI
 411A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=G3MmReWa5j5sFld79AtxiU6R5eelzD0eh8rA096ZHOA=;
 b=U00/+8bLENrSg0K2HD5mhD9NtALUgsMeN3PuKFUHRxmCpj5VfutwTnHof3+nf5qHG1
 re0s33Gbv4NXoRar4zGCXfZ8bLbLb0r2HiiXxupOIF4pym0KvmK6iAZcG26wBsuHrsd1
 otglSSPmSqH6ZG6PKkEtBfRW/ggVgCMe1sAAPYKRfMXynd9x78rMMvzo2EEBcHdYcyKQ
 r0MS4vVLPJAHQhhCYSGOir8TbvsK5o1oPJQq+lW/8rK062ovVYeJ0xz/yiEt+AXHaCpx
 sAlBML2jDTdZxolWoSLZRa3917JoHPEodSXEPiaZfg3bI7lnaY9S8pSzErxwWMvfO0E8
 kfuA==
X-Gm-Message-State: APjAAAXV185Ho661iBEq3q00mWGNyyvqpaYKjN7HTuYGHsrT6cAKkgEy
 7RleL7nyBP6HXUs2dtjmNIrh/A8vex7M17bh3dk=
X-Google-Smtp-Source: APXvYqxbBtTS5/D+GxhU5wQkKCYzaFzfSm3GZ0cz58WrJEi04hKGC90Z9LCRFLUZKvVGIWMz/Sc8sLz6VKlT5EHjDxY=
X-Received: by 2002:a05:6830:1741:: with SMTP id
 1mr22707344otz.295.1576944185556; 
 Sat, 21 Dec 2019 08:03:05 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Sat, 21 Dec 2019 08:03:04 -0800 (PST)
In-Reply-To: <20191221144238.127766-7-ysato@users.sourceforge.jp>
References: <20191221144238.127766-1-ysato@users.sourceforge.jp>
 <20191221144238.127766-7-ysato@users.sourceforge.jp>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 21 Dec 2019 17:03:04 +0100
Message-ID: <CAL1e-=iFV=PumJ2M=rcpntkJ3NFWT7sqMcroJmiLYhsibwFf4Q@mail.gmail.com>
Subject: Re: [PATCH v27 06/21] target/rx: CPU definition
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: multipart/alternative; boundary="00000000000002c2eb059a38eeff"
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
Cc: "philmd@redhat.com" <philmd@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000002c2eb059a38eeff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Saturday, December 21, 2019, Yoshinori Sato <ysato@users.sourceforge.jp>
wrote:

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>
> Message-Id: <20190616142836.10614-4-ysato@users.sourceforge.jp>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20190607091116.49044-4-ysato@users.sourceforge.jp>


Hi, Yoshinori,

I noticed you have a lot of line like this

Message-Id: <20190607091116.49044-9-ysato@users.sourceforge.jp>

... sometimes even several in the same message.

May I ask you to delete *all* such lines from commit messages, and resend
the series?

Also, I don't see  the documentation update for the new target. Please
provide dome appropriate content in qemu-doc.texi (
https://github.com/qemu/qemu/blob/master/qemu-doc.texi ), and include it in
the next version.

Best regards,

Aleksandar


> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> [PMD: Use newer QOM style, split cpu-qom.h, restrict access to
>  extable array, use rx_cpu_tlb_fill() extracted from patch of
>  Yoshinori Sato 'Convert to CPUClass::tlb_fill']
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  target/rx/cpu-param.h   |  31 ++++++
>  target/rx/cpu-qom.h     |  42 ++++++++
>  target/rx/cpu.h         | 181 +++++++++++++++++++++++++++++++++
>  target/rx/cpu.c         | 217 ++++++++++++++++++++++++++++++++++++++++
>  target/rx/gdbstub.c     | 112 +++++++++++++++++++++
>  target/rx/Makefile.objs |   1 -
>  6 files changed, 583 insertions(+), 1 deletion(-)
>  create mode 100644 target/rx/cpu-param.h
>  create mode 100644 target/rx/cpu-qom.h
>  create mode 100644 target/rx/cpu.h
>  create mode 100644 target/rx/cpu.c
>  create mode 100644 target/rx/gdbstub.c
>
> diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
> new file mode 100644
> index 0000000000..5da87fbebe
> --- /dev/null
> +++ b/target/rx/cpu-param.h
> @@ -0,0 +1,31 @@
> +/*
> + *  RX cpu parameters
> + *
> + *  Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef RX_CPU_PARAM_H
> +#define RX_CPU_PARAM_H
> +
> +#define TARGET_LONG_BITS 32
> +#define TARGET_PAGE_BITS 12
> +
> +#define TARGET_PHYS_ADDR_SPACE_BITS 32
> +#define TARGET_VIRT_ADDR_SPACE_BITS 32
> +
> +#define NB_MMU_MODES 1
> +#define MMU_MODE0_SUFFIX _all
> +
> +#endif
> diff --git a/target/rx/cpu-qom.h b/target/rx/cpu-qom.h
> new file mode 100644
> index 0000000000..8328900f3f
> --- /dev/null
> +++ b/target/rx/cpu-qom.h
> @@ -0,0 +1,42 @@
> +#ifndef QEMU_RX_CPU_QOM_H
> +#define QEMU_RX_CPU_QOM_H
> +
> +#include "hw/core/cpu.h"
> +/*
> + * RX CPU
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + * SPDX-License-Identifier: LGPL-2.0+
> + */
> +
> +#define TYPE_RX_CPU "rx-cpu"
> +
> +#define TYPE_RX62N_CPU RX_CPU_TYPE_NAME("rx62n")
> +
> +#define RXCPU_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(RXCPUClass, (klass), TYPE_RX_CPU)
> +#define RXCPU(obj) \
> +    OBJECT_CHECK(RXCPU, (obj), TYPE_RX_CPU)
> +#define RXCPU_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(RXCPUClass, (obj), TYPE_RX_CPU)
> +
> +/*
> + * RXCPUClass:
> + * @parent_realize: The parent class' realize handler.
> + * @parent_reset: The parent class' reset handler.
> + *
> + * A RX CPU model.
> + */
> +typedef struct RXCPUClass {
> +    /*< private >*/
> +    CPUClass parent_class;
> +    /*< public >*/
> +
> +    DeviceRealize parent_realize;
> +    void (*parent_reset)(CPUState *cpu);
> +
> +} RXCPUClass;
> +
> +#define CPUArchState struct CPURXState
> +
> +#endif
> diff --git a/target/rx/cpu.h b/target/rx/cpu.h
> new file mode 100644
> index 0000000000..2d1eb7665c
> --- /dev/null
> +++ b/target/rx/cpu.h
> @@ -0,0 +1,181 @@
> +/*
> + *  RX emulation definition
> + *
> + *  Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef RX_CPU_H
> +#define RX_CPU_H
> +
> +#include "qemu/bitops.h"
> +#include "qemu-common.h"
> +#include "hw/registerfields.h"
> +#include "cpu-qom.h"
> +
> +#include "exec/cpu-defs.h"
> +
> +/* PSW define */
> +REG32(PSW, 0)
> +FIELD(PSW, C, 0, 1)
> +FIELD(PSW, Z, 1, 1)
> +FIELD(PSW, S, 2, 1)
> +FIELD(PSW, O, 3, 1)
> +FIELD(PSW, I, 16, 1)
> +FIELD(PSW, U, 17, 1)
> +FIELD(PSW, PM, 20, 1)
> +FIELD(PSW, IPL, 24, 4)
> +
> +/* FPSW define */
> +REG32(FPSW, 0)
> +FIELD(FPSW, RM, 0, 2)
> +FIELD(FPSW, CV, 2, 1)
> +FIELD(FPSW, CO, 3, 1)
> +FIELD(FPSW, CZ, 4, 1)
> +FIELD(FPSW, CU, 5, 1)
> +FIELD(FPSW, CX, 6, 1)
> +FIELD(FPSW, CE, 7, 1)
> +FIELD(FPSW, CAUSE, 2, 6)
> +FIELD(FPSW, DN, 8, 1)
> +FIELD(FPSW, EV, 10, 1)
> +FIELD(FPSW, EO, 11, 1)
> +FIELD(FPSW, EZ, 12, 1)
> +FIELD(FPSW, EU, 13, 1)
> +FIELD(FPSW, EX, 14, 1)
> +FIELD(FPSW, ENABLE, 10, 5)
> +FIELD(FPSW, FV, 26, 1)
> +FIELD(FPSW, FO, 27, 1)
> +FIELD(FPSW, FZ, 28, 1)
> +FIELD(FPSW, FU, 29, 1)
> +FIELD(FPSW, FX, 30, 1)
> +FIELD(FPSW, FLAGS, 26, 4)
> +FIELD(FPSW, FS, 31, 1)
> +
> +enum {
> +    NUM_REGS =3D 16,
> +};
> +
> +typedef struct CPURXState {
> +    /* CPU registers */
> +    uint32_t regs[NUM_REGS];    /* general registers */
> +    uint32_t psw_o;             /* O bit of status register */
> +    uint32_t psw_s;             /* S bit of status register */
> +    uint32_t psw_z;             /* Z bit of status register */
> +    uint32_t psw_c;             /* C bit of status register */
> +    uint32_t psw_u;
> +    uint32_t psw_i;
> +    uint32_t psw_pm;
> +    uint32_t psw_ipl;
> +    uint32_t bpsw;              /* backup status */
> +    uint32_t bpc;               /* backup pc */
> +    uint32_t isp;               /* global base register */
> +    uint32_t usp;               /* vector base register */
> +    uint32_t pc;                /* program counter */
> +    uint32_t intb;              /* interrupt vector */
> +    uint32_t fintv;
> +    uint32_t fpsw;
> +    uint64_t acc;
> +
> +    /* Fields up to this point are cleared by a CPU reset */
> +    struct {} end_reset_fields;
> +
> +    /* Internal use */
> +    uint32_t in_sleep;
> +    uint32_t req_irq;           /* Requested interrupt no (hard) */
> +    uint32_t req_ipl;           /* Requested interrupt level */
> +    uint32_t ack_irq;           /* execute irq */
> +    uint32_t ack_ipl;           /* execute ipl */
> +    float_status fp_status;
> +    qemu_irq ack;               /* Interrupt acknowledge */
> +} CPURXState;
> +
> +/*
> + * RXCPU:
> + * @env: #CPURXState
> + *
> + * A RX CPU
> + */
> +struct RXCPU {
> +    /*< private >*/
> +    CPUState parent_obj;
> +    /*< public >*/
> +
> +    CPUNegativeOffsetState neg;
> +    CPURXState env;
> +};
> +
> +typedef struct RXCPU RXCPU;
> +typedef RXCPU ArchCPU;
> +
> +#define ENV_OFFSET offsetof(RXCPU, env)
> +
> +#define RX_CPU_TYPE_SUFFIX "-" TYPE_RX_CPU
> +#define RX_CPU_TYPE_NAME(model) model RX_CPU_TYPE_SUFFIX
> +#define CPU_RESOLVING_TYPE TYPE_RX_CPU
> +
> +extern const char rx_crname[][6];
> +
> +void rx_cpu_do_interrupt(CPUState *cpu);
> +bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
> +void rx_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> +int rx_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
> +int rx_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> +hwaddr rx_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> +
> +void rx_translate_init(void);
> +int cpu_rx_signal_handler(int host_signum, void *pinfo,
> +                           void *puc);
> +
> +void rx_cpu_list(void);
> +void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte);
> +
> +#define cpu_signal_handler cpu_rx_signal_handler
> +#define cpu_list rx_cpu_list
> +
> +#include "exec/cpu-all.h"
> +
> +#define CPU_INTERRUPT_SOFT CPU_INTERRUPT_TGT_INT_0
> +#define CPU_INTERRUPT_FIR  CPU_INTERRUPT_TGT_INT_1
> +
> +#define RX_CPU_IRQ 0
> +#define RX_CPU_FIR 1
> +
> +static inline void cpu_get_tb_cpu_state(CPURXState *env, target_ulong
> *pc,
> +                                        target_ulong *cs_base, uint32_t
> *flags)
> +{
> +    *pc =3D env->pc;
> +    *cs_base =3D 0;
> +    *flags =3D FIELD_DP32(0, PSW, PM, env->psw_pm);
> +}
> +
> +static inline int cpu_mmu_index(CPURXState *env, bool ifetch)
> +{
> +    return 0;
> +}
> +
> +static inline uint32_t rx_cpu_pack_psw(CPURXState *env)
> +{
> +    uint32_t psw =3D 0;
> +    psw =3D FIELD_DP32(psw, PSW, IPL, env->psw_ipl);
> +    psw =3D FIELD_DP32(psw, PSW, PM,  env->psw_pm);
> +    psw =3D FIELD_DP32(psw, PSW, U,   env->psw_u);
> +    psw =3D FIELD_DP32(psw, PSW, I,   env->psw_i);
> +    psw =3D FIELD_DP32(psw, PSW, O,   env->psw_o >> 31);
> +    psw =3D FIELD_DP32(psw, PSW, S,   env->psw_s >> 31);
> +    psw =3D FIELD_DP32(psw, PSW, Z,   env->psw_z =3D=3D 0);
> +    psw =3D FIELD_DP32(psw, PSW, C,   env->psw_c);
> +    return psw;
> +}
> +
> +#endif /* RX_CPU_H */
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> new file mode 100644
> index 0000000000..ea38639f47
> --- /dev/null
> +++ b/target/rx/cpu.c
> @@ -0,0 +1,217 @@
> +/*
> + * QEMU RX CPU
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/qemu-print.h"
> +#include "qapi/error.h"
> +#include "cpu.h"
> +#include "qemu-common.h"
> +#include "migration/vmstate.h"
> +#include "exec/exec-all.h"
> +#include "hw/loader.h"
> +#include "fpu/softfloat.h"
> +
> +static void rx_cpu_set_pc(CPUState *cs, vaddr value)
> +{
> +    RXCPU *cpu =3D RXCPU(cs);
> +
> +    cpu->env.pc =3D value;
> +}
> +
> +static void rx_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock
> *tb)
> +{
> +    RXCPU *cpu =3D RXCPU(cs);
> +
> +    cpu->env.pc =3D tb->pc;
> +}
> +
> +static bool rx_cpu_has_work(CPUState *cs)
> +{
> +    return cs->interrupt_request &
> +        (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
> +}
> +
> +static void rx_cpu_reset(CPUState *s)
> +{
> +    RXCPU *cpu =3D RXCPU(s);
> +    RXCPUClass *rcc =3D RXCPU_GET_CLASS(cpu);
> +    CPURXState *env =3D &cpu->env;
> +    uint32_t *resetvec;
> +
> +    rcc->parent_reset(s);
> +
> +    memset(env, 0, offsetof(CPURXState, end_reset_fields));
> +
> +    resetvec =3D rom_ptr(0xfffffffc, 4);
> +    if (resetvec) {
> +        /* In the case of kernel, it is ignored because it is not set. *=
/
> +        env->pc =3D ldl_p(resetvec);
> +    }
> +    rx_cpu_unpack_psw(env, 0, 1);
> +    env->regs[0] =3D env->isp =3D env->usp =3D 0;
> +    env->fpsw =3D 0;
> +    set_flush_to_zero(1, &env->fp_status);
> +    set_flush_inputs_to_zero(1, &env->fp_status);
> +}
> +
> +static void rx_cpu_list_entry(gpointer data, gpointer user_data)
> +{
> +    const char *typename =3D object_class_get_name(OBJECT_CLASS(data));
> +
> +    qemu_printf("%s\n", typename);
> +}
> +
> +void rx_cpu_list(void)
> +{
> +    GSList *list;
> +    list =3D object_class_get_list_sorted(TYPE_RX_CPU, false);
> +    g_slist_foreach(list, rx_cpu_list_entry, NULL);
> +    g_slist_free(list);
> +}
> +
> +static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
> +{
> +    ObjectClass *oc;
> +
> +    oc =3D object_class_by_name(cpu_model);
> +    if (object_class_dynamic_cast(oc, TYPE_RX_CPU) =3D=3D NULL ||
> +        object_class_is_abstract(oc)) {
> +        oc =3D NULL;
> +    }
> +
> +    return oc;
> +}
> +
> +static void rx_cpu_realize(DeviceState *dev, Error **errp)
> +{
> +    CPUState *cs =3D CPU(dev);
> +    RXCPUClass *rcc =3D RXCPU_GET_CLASS(dev);
> +    Error *local_err =3D NULL;
> +
> +    cpu_exec_realizefn(cs, &local_err);
> +    if (local_err !=3D NULL) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    cpu_reset(cs);
> +    qemu_init_vcpu(cs);
> +
> +    rcc->parent_realize(dev, errp);
> +}
> +
> +static void rx_cpu_set_irq(void *opaque, int no, int request)
> +{
> +    RXCPU *cpu =3D opaque;
> +    CPUState *cs =3D CPU(cpu);
> +    int irq =3D request & 0xff;
> +
> +    static const int mask[] =3D {
> +        [RX_CPU_IRQ] =3D CPU_INTERRUPT_HARD,
> +        [RX_CPU_FIR] =3D CPU_INTERRUPT_FIR,
> +    };
> +    if (irq) {
> +        cpu->env.req_irq =3D irq;
> +        cpu->env.req_ipl =3D (request >> 8) & 0x0f;
> +        cpu_interrupt(cs, mask[no]);
> +    } else {
> +        cpu_reset_interrupt(cs, mask[no]);
> +    }
> +}
> +
> +static void rx_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
> +{
> +    info->mach =3D bfd_mach_rx;
> +    info->print_insn =3D print_insn_rx;
> +}
> +
> +static bool rx_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
> +                            MMUAccessType access_type, int mmu_idx,
> +                            bool probe, uintptr_t retaddr)
> +{
> +    uint32_t address, physical, prot;
> +
> +    /* Linear mapping */
> +    address =3D physical =3D addr & TARGET_PAGE_MASK;
> +    prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +    tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE)=
;
> +    return true;
> +}
> +
> +static void rx_cpu_init(Object *obj)
> +{
> +    CPUState *cs =3D CPU(obj);
> +    RXCPU *cpu =3D RXCPU(obj);
> +    CPURXState *env =3D &cpu->env;
> +
> +    cpu_set_cpustate_pointers(cpu);
> +    cs->env_ptr =3D env;
> +    qdev_init_gpio_in(DEVICE(cpu), rx_cpu_set_irq, 2);
> +}
> +
> +static void rx_cpu_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    CPUClass *cc =3D CPU_CLASS(klass);
> +    RXCPUClass *rcc =3D RXCPU_CLASS(klass);
> +
> +    device_class_set_parent_realize(dc, rx_cpu_realize,
> +                                    &rcc->parent_realize);
> +
> +    rcc->parent_reset =3D cc->reset;
> +    cc->reset =3D rx_cpu_reset;
> +
> +    cc->class_by_name =3D rx_cpu_class_by_name;
> +    cc->has_work =3D rx_cpu_has_work;
> +    cc->do_interrupt =3D rx_cpu_do_interrupt;
> +    cc->cpu_exec_interrupt =3D rx_cpu_exec_interrupt;
> +    cc->dump_state =3D rx_cpu_dump_state;
> +    cc->set_pc =3D rx_cpu_set_pc;
> +    cc->synchronize_from_tb =3D rx_cpu_synchronize_from_tb;
> +    cc->gdb_read_register =3D rx_cpu_gdb_read_register;
> +    cc->gdb_write_register =3D rx_cpu_gdb_write_register;
> +    cc->get_phys_page_debug =3D rx_cpu_get_phys_page_debug;
> +    cc->disas_set_info =3D rx_cpu_disas_set_info;
> +    cc->tcg_initialize =3D rx_translate_init;
> +    cc->tlb_fill =3D rx_cpu_tlb_fill;
> +
> +    cc->gdb_num_core_regs =3D 26;
> +}
> +
> +static const TypeInfo rx_cpu_info =3D {
> +    .name =3D TYPE_RX_CPU,
> +    .parent =3D TYPE_CPU,
> +    .instance_size =3D sizeof(RXCPU),
> +    .instance_init =3D rx_cpu_init,
> +    .abstract =3D true,
> +    .class_size =3D sizeof(RXCPUClass),
> +    .class_init =3D rx_cpu_class_init,
> +};
> +
> +static const TypeInfo rx62n_rx_cpu_info =3D {
> +    .name =3D TYPE_RX62N_CPU,
> +    .parent =3D TYPE_RX_CPU,
> +};
> +
> +static void rx_cpu_register_types(void)
> +{
> +    type_register_static(&rx_cpu_info);
> +    type_register_static(&rx62n_rx_cpu_info);
> +}
> +
> +type_init(rx_cpu_register_types)
> diff --git a/target/rx/gdbstub.c b/target/rx/gdbstub.c
> new file mode 100644
> index 0000000000..d76ca52e82
> --- /dev/null
> +++ b/target/rx/gdbstub.c
> @@ -0,0 +1,112 @@
> +/*
> + * RX gdb server stub
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "exec/gdbstub.h"
> +
> +int rx_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    RXCPU *cpu =3D RXCPU(cs);
> +    CPURXState *env =3D &cpu->env;
> +
> +    switch (n) {
> +    case 0 ... 15:
> +        return gdb_get_regl(mem_buf, env->regs[n]);
> +    case 16:
> +        return gdb_get_regl(mem_buf, (env->psw_u) ? env->regs[0] :
> env->usp);
> +    case 17:
> +        return gdb_get_regl(mem_buf, (!env->psw_u) ? env->regs[0] :
> env->isp);
> +    case 18:
> +        return gdb_get_regl(mem_buf, rx_cpu_pack_psw(env));
> +    case 19:
> +        return gdb_get_regl(mem_buf, env->pc);
> +    case 20:
> +        return gdb_get_regl(mem_buf, env->intb);
> +    case 21:
> +        return gdb_get_regl(mem_buf, env->bpsw);
> +    case 22:
> +        return gdb_get_regl(mem_buf, env->bpc);
> +    case 23:
> +        return gdb_get_regl(mem_buf, env->fintv);
> +    case 24:
> +        return gdb_get_regl(mem_buf, env->fpsw);
> +    case 25:
> +        return 0;
> +    }
> +    return 0;
> +}
> +
> +int rx_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    RXCPU *cpu =3D RXCPU(cs);
> +    CPURXState *env =3D &cpu->env;
> +    uint32_t psw;
> +    switch (n) {
> +    case 0 ... 15:
> +        env->regs[n] =3D ldl_p(mem_buf);
> +        if (n =3D=3D 0) {
> +            if (env->psw_u) {
> +                env->usp =3D env->regs[0];
> +            } else {
> +                env->isp =3D env->regs[0];
> +            }
> +        }
> +        break;
> +    case 16:
> +        env->usp =3D ldl_p(mem_buf);
> +        if (env->psw_u) {
> +            env->regs[0] =3D ldl_p(mem_buf);
> +        }
> +        break;
> +    case 17:
> +        env->isp =3D ldl_p(mem_buf);
> +        if (!env->psw_u) {
> +            env->regs[0] =3D ldl_p(mem_buf);
> +        }
> +        break;
> +    case 18:
> +        psw =3D ldl_p(mem_buf);
> +        rx_cpu_unpack_psw(env, psw, 1);
> +        break;
> +    case 19:
> +        env->pc =3D ldl_p(mem_buf);
> +        break;
> +    case 20:
> +        env->intb =3D ldl_p(mem_buf);
> +        break;
> +    case 21:
> +        env->bpsw =3D ldl_p(mem_buf);
> +        break;
> +    case 22:
> +        env->bpc =3D ldl_p(mem_buf);
> +        break;
> +    case 23:
> +        env->fintv =3D ldl_p(mem_buf);
> +        break;
> +    case 24:
> +        env->fpsw =3D ldl_p(mem_buf);
> +        break;
> +    case 25:
> +        return 8;
> +    default:
> +        return 0;
> +    }
> +
> +    return 4;
> +}
> diff --git a/target/rx/Makefile.objs b/target/rx/Makefile.objs
> index aa6f2d2d6c..a0018d5bc5 100644
> --- a/target/rx/Makefile.objs
> +++ b/target/rx/Makefile.objs
> @@ -1,5 +1,4 @@
>  obj-y +=3D translate.o op_helper.o helper.o cpu.o gdbstub.o disas.o
> -obj-$(CONFIG_SOFTMMU) +=3D monitor.o
>
>  DECODETREE =3D $(SRC_PATH)/scripts/decodetree.py
>
> --
> 2.20.1
>
>
>

--00000000000002c2eb059a38eeff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, December 21, 2019, Yoshinori Sato &lt;<a href=3D"mailt=
o:ysato@users.sourceforge.jp">ysato@users.sourceforge.jp</a>&gt; wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Signed-off-by: Yoshinori Sato &lt;<a href=3D=
"mailto:ysato@users.sourceforge.jp">ysato@users.sourceforge.jp</a>&gt;<br>
<br>
Message-Id: &lt;<a href=3D"mailto:20190616142836.10614-4-ysato@users.source=
forge.jp">20190616142836.10614-4-ysato@users.sourceforge.jp</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org">richard.henderson@linaro.org</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20190607091116.49044-4-ysato@users.source=
forge.jp">20190607091116.49044-4-ysato@users.sourceforge.jp</a>&gt;</blockq=
uote><div><br></div><div>Hi, Yoshinori,</div><div><br></div><div>I noticed =
you have a lot of line like this</div><div><br></div><div>Message-Id: &lt;<=
a href=3D"mailto:20190607091116.49044-9-ysato@users.sourceforge.jp">2019060=
7091116.49044-9-ysato@users.sourceforge.jp</a>&gt;<br></div><div><br></div>=
<div>... sometimes even several in the same message.</div><div><br></div><d=
iv>May I ask you to delete *all* such lines from commit messages, and resen=
d the series?</div><div><br></div><div>Also, I don&#39;t see =C2=A0the docu=
mentation update for the new target. Please provide dome appropriate conten=
t in qemu-doc.texi (</div><div><a href=3D"https://github.com/qemu/qemu/blob=
/master/qemu-doc.texi">https://github.com/qemu/qemu/blob/master/qemu-doc.te=
xi</a> ), and include it in the next version.<br></div><div><br></div><div>=
Best regards,</div><div><br></div><div>Aleksandar</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org">richard.henderson@linaro.org</a>&gt;<br>
[PMD: Use newer QOM style, split cpu-qom.h, restrict access to<br>
=C2=A0extable array, use rx_cpu_tlb_fill() extracted from patch of<br>
=C2=A0Yoshinori Sato &#39;Convert to CPUClass::tlb_fill&#39;]<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
Acked-by: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com">imammedo=
@redhat.com</a>&gt;<br>
Signed-off-by: Yoshinori Sato &lt;<a href=3D"mailto:ysato@users.sourceforge=
.jp">ysato@users.sourceforge.jp</a>&gt;<br>
---<br>
=C2=A0target/rx/cpu-param.h=C2=A0 =C2=A0|=C2=A0 31 ++++++<br>
=C2=A0target/rx/cpu-qom.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 42 ++++++++<br>
=C2=A0target/rx/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 181 ++++++++++++++=
++++++++++++++++<wbr>+++<br>
=C2=A0target/rx/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 217 ++++++++++++++=
++++++++++++++++<wbr>++++++++++<br>
=C2=A0target/rx/gdbstub.c=C2=A0 =C2=A0 =C2=A0| 112 +++++++++++++++++++++<br=
>
=C2=A0target/rx/Makefile.objs |=C2=A0 =C2=A01 -<br>
=C2=A06 files changed, 583 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 target/rx/cpu-param.h<br>
=C2=A0create mode 100644 target/rx/cpu-qom.h<br>
=C2=A0create mode 100644 target/rx/cpu.h<br>
=C2=A0create mode 100644 target/rx/cpu.c<br>
=C2=A0create mode 100644 target/rx/gdbstub.c<br>
<br>
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h<br>
new file mode 100644<br>
index 0000000000..5da87fbebe<br>
--- /dev/null<br>
+++ b/target/rx/cpu-param.h<br>
@@ -0,0 +1,31 @@<br>
+/*<br>
+ *=C2=A0 RX cpu parameters<br>
+ *<br>
+ *=C2=A0 Copyright (c) 2019 Yoshinori Sato<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or modify it=
<br>
+ * under the terms and conditions of the GNU General Public License,<br>
+ * version 2 or later, as published by the Free Software Foundation.<br>
+ *<br>
+ * This program is distributed in the hope it will be useful, but WITHOUT<=
br>
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or<b=
r>
+ * FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU General Public Lice=
nse for<br>
+ * more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License along=
 with<br>
+ * this program.=C2=A0 If not, see &lt;<a href=3D"http://www.gnu.org/licen=
ses/" target=3D"_blank">http://www.gnu.org/licenses/</a>&gt;<wbr>.<br>
+ */<br>
+<br>
+#ifndef RX_CPU_PARAM_H<br>
+#define RX_CPU_PARAM_H<br>
+<br>
+#define TARGET_LONG_BITS 32<br>
+#define TARGET_PAGE_BITS 12<br>
+<br>
+#define TARGET_PHYS_ADDR_SPACE_BITS 32<br>
+#define TARGET_VIRT_ADDR_SPACE_BITS 32<br>
+<br>
+#define NB_MMU_MODES 1<br>
+#define MMU_MODE0_SUFFIX _all<br>
+<br>
+#endif<br>
diff --git a/target/rx/cpu-qom.h b/target/rx/cpu-qom.h<br>
new file mode 100644<br>
index 0000000000..8328900f3f<br>
--- /dev/null<br>
+++ b/target/rx/cpu-qom.h<br>
@@ -0,0 +1,42 @@<br>
+#ifndef QEMU_RX_CPU_QOM_H<br>
+#define QEMU_RX_CPU_QOM_H<br>
+<br>
+#include &quot;hw/core/cpu.h&quot;<br>
+/*<br>
+ * RX CPU<br>
+ *<br>
+ * Copyright (c) 2019 Yoshinori Sato<br>
+ * SPDX-License-Identifier: LGPL-2.0+<br>
+ */<br>
+<br>
+#define TYPE_RX_CPU &quot;rx-cpu&quot;<br>
+<br>
+#define TYPE_RX62N_CPU RX_CPU_TYPE_NAME(&quot;rx62n&quot;)<br>
+<br>
+#define RXCPU_CLASS(klass) \<br>
+=C2=A0 =C2=A0 OBJECT_CLASS_CHECK(RXCPUClass, (klass), TYPE_RX_CPU)<br>
+#define RXCPU(obj) \<br>
+=C2=A0 =C2=A0 OBJECT_CHECK(RXCPU, (obj), TYPE_RX_CPU)<br>
+#define RXCPU_GET_CLASS(obj) \<br>
+=C2=A0 =C2=A0 OBJECT_GET_CLASS(RXCPUClass, (obj), TYPE_RX_CPU)<br>
+<br>
+/*<br>
+ * RXCPUClass:<br>
+ * @parent_realize: The parent class&#39; realize handler.<br>
+ * @parent_reset: The parent class&#39; reset handler.<br>
+ *<br>
+ * A RX CPU model.<br>
+ */<br>
+typedef struct RXCPUClass {<br>
+=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
+=C2=A0 =C2=A0 CPUClass parent_class;<br>
+=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
+<br>
+=C2=A0 =C2=A0 DeviceRealize parent_realize;<br>
+=C2=A0 =C2=A0 void (*parent_reset)(CPUState *cpu);<br>
+<br>
+} RXCPUClass;<br>
+<br>
+#define CPUArchState struct CPURXState<br>
+<br>
+#endif<br>
diff --git a/target/rx/cpu.h b/target/rx/cpu.h<br>
new file mode 100644<br>
index 0000000000..2d1eb7665c<br>
--- /dev/null<br>
+++ b/target/rx/cpu.h<br>
@@ -0,0 +1,181 @@<br>
+/*<br>
+ *=C2=A0 RX emulation definition<br>
+ *<br>
+ *=C2=A0 Copyright (c) 2019 Yoshinori Sato<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or modify it=
<br>
+ * under the terms and conditions of the GNU General Public License,<br>
+ * version 2 or later, as published by the Free Software Foundation.<br>
+ *<br>
+ * This program is distributed in the hope it will be useful, but WITHOUT<=
br>
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or<b=
r>
+ * FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU General Public Lice=
nse for<br>
+ * more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License along=
 with<br>
+ * this program.=C2=A0 If not, see &lt;<a href=3D"http://www.gnu.org/licen=
ses/" target=3D"_blank">http://www.gnu.org/licenses/</a>&gt;<wbr>.<br>
+ */<br>
+<br>
+#ifndef RX_CPU_H<br>
+#define RX_CPU_H<br>
+<br>
+#include &quot;qemu/bitops.h&quot;<br>
+#include &quot;qemu-common.h&quot;<br>
+#include &quot;hw/registerfields.h&quot;<br>
+#include &quot;cpu-qom.h&quot;<br>
+<br>
+#include &quot;exec/cpu-defs.h&quot;<br>
+<br>
+/* PSW define */<br>
+REG32(PSW, 0)<br>
+FIELD(PSW, C, 0, 1)<br>
+FIELD(PSW, Z, 1, 1)<br>
+FIELD(PSW, S, 2, 1)<br>
+FIELD(PSW, O, 3, 1)<br>
+FIELD(PSW, I, 16, 1)<br>
+FIELD(PSW, U, 17, 1)<br>
+FIELD(PSW, PM, 20, 1)<br>
+FIELD(PSW, IPL, 24, 4)<br>
+<br>
+/* FPSW define */<br>
+REG32(FPSW, 0)<br>
+FIELD(FPSW, RM, 0, 2)<br>
+FIELD(FPSW, CV, 2, 1)<br>
+FIELD(FPSW, CO, 3, 1)<br>
+FIELD(FPSW, CZ, 4, 1)<br>
+FIELD(FPSW, CU, 5, 1)<br>
+FIELD(FPSW, CX, 6, 1)<br>
+FIELD(FPSW, CE, 7, 1)<br>
+FIELD(FPSW, CAUSE, 2, 6)<br>
+FIELD(FPSW, DN, 8, 1)<br>
+FIELD(FPSW, EV, 10, 1)<br>
+FIELD(FPSW, EO, 11, 1)<br>
+FIELD(FPSW, EZ, 12, 1)<br>
+FIELD(FPSW, EU, 13, 1)<br>
+FIELD(FPSW, EX, 14, 1)<br>
+FIELD(FPSW, ENABLE, 10, 5)<br>
+FIELD(FPSW, FV, 26, 1)<br>
+FIELD(FPSW, FO, 27, 1)<br>
+FIELD(FPSW, FZ, 28, 1)<br>
+FIELD(FPSW, FU, 29, 1)<br>
+FIELD(FPSW, FX, 30, 1)<br>
+FIELD(FPSW, FLAGS, 26, 4)<br>
+FIELD(FPSW, FS, 31, 1)<br>
+<br>
+enum {<br>
+=C2=A0 =C2=A0 NUM_REGS =3D 16,<br>
+};<br>
+<br>
+typedef struct CPURXState {<br>
+=C2=A0 =C2=A0 /* CPU registers */<br>
+=C2=A0 =C2=A0 uint32_t regs[NUM_REGS];=C2=A0 =C2=A0 /* general registers *=
/<br>
+=C2=A0 =C2=A0 uint32_t psw_o;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* O bit of status register */<br>
+=C2=A0 =C2=A0 uint32_t psw_s;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* S bit of status register */<br>
+=C2=A0 =C2=A0 uint32_t psw_z;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* Z bit of status register */<br>
+=C2=A0 =C2=A0 uint32_t psw_c;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* C bit of status register */<br>
+=C2=A0 =C2=A0 uint32_t psw_u;<br>
+=C2=A0 =C2=A0 uint32_t psw_i;<br>
+=C2=A0 =C2=A0 uint32_t psw_pm;<br>
+=C2=A0 =C2=A0 uint32_t psw_ipl;<br>
+=C2=A0 =C2=A0 uint32_t bpsw;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* backup status */<br>
+=C2=A0 =C2=A0 uint32_t bpc;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* backup pc */<br>
+=C2=A0 =C2=A0 uint32_t isp;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* global base register */<br>
+=C2=A0 =C2=A0 uint32_t usp;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* vector base register */<br>
+=C2=A0 =C2=A0 uint32_t pc;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /* program counter */<br>
+=C2=A0 =C2=A0 uint32_t intb;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* interrupt vector */<br>
+=C2=A0 =C2=A0 uint32_t fintv;<br>
+=C2=A0 =C2=A0 uint32_t fpsw;<br>
+=C2=A0 =C2=A0 uint64_t acc;<br>
+<br>
+=C2=A0 =C2=A0 /* Fields up to this point are cleared by a CPU reset */<br>
+=C2=A0 =C2=A0 struct {} end_reset_fields;<br>
+<br>
+=C2=A0 =C2=A0 /* Internal use */<br>
+=C2=A0 =C2=A0 uint32_t in_sleep;<br>
+=C2=A0 =C2=A0 uint32_t req_irq;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 Requested interrupt no (hard) */<br>
+=C2=A0 =C2=A0 uint32_t req_ipl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 Requested interrupt level */<br>
+=C2=A0 =C2=A0 uint32_t ack_irq;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 execute irq */<br>
+=C2=A0 =C2=A0 uint32_t ack_ipl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 execute ipl */<br>
+=C2=A0 =C2=A0 float_status fp_status;<br>
+=C2=A0 =C2=A0 qemu_irq ack;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Interrupt acknowledge */<br>
+} CPURXState;<br>
+<br>
+/*<br>
+ * RXCPU:<br>
+ * @env: #CPURXState<br>
+ *<br>
+ * A RX CPU<br>
+ */<br>
+struct RXCPU {<br>
+=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
+=C2=A0 =C2=A0 CPUState parent_obj;<br>
+=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
+<br>
+=C2=A0 =C2=A0 CPUNegativeOffsetState neg;<br>
+=C2=A0 =C2=A0 CPURXState env;<br>
+};<br>
+<br>
+typedef struct RXCPU RXCPU;<br>
+typedef RXCPU ArchCPU;<br>
+<br>
+#define ENV_OFFSET offsetof(RXCPU, env)<br>
+<br>
+#define RX_CPU_TYPE_SUFFIX &quot;-&quot; TYPE_RX_CPU<br>
+#define RX_CPU_TYPE_NAME(model) model RX_CPU_TYPE_SUFFIX<br>
+#define CPU_RESOLVING_TYPE TYPE_RX_CPU<br>
+<br>
+extern const char rx_crname[][6];<br>
+<br>
+void rx_cpu_do_interrupt(CPUState *cpu);<br>
+bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);<br>
+void rx_cpu_dump_state(CPUState *cpu, FILE *f, int flags);<br>
+int rx_cpu_gdb_read_register(<wbr>CPUState *cpu, uint8_t *buf, int reg);<b=
r>
+int rx_cpu_gdb_write_register(<wbr>CPUState *cpu, uint8_t *buf, int reg);<=
br>
+hwaddr rx_cpu_get_phys_page_debug(<wbr>CPUState *cpu, vaddr addr);<br>
+<br>
+void rx_translate_init(void);<br>
+int cpu_rx_signal_handler(int host_signum, void *pinfo,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0void *puc);<br>
+<br>
+void rx_cpu_list(void);<br>
+void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte);<br>
+<br>
+#define cpu_signal_handler cpu_rx_signal_handler<br>
+#define cpu_list rx_cpu_list<br>
+<br>
+#include &quot;exec/cpu-all.h&quot;<br>
+<br>
+#define CPU_INTERRUPT_SOFT CPU_INTERRUPT_TGT_INT_0<br>
+#define CPU_INTERRUPT_FIR=C2=A0 CPU_INTERRUPT_TGT_INT_1<br>
+<br>
+#define RX_CPU_IRQ 0<br>
+#define RX_CPU_FIR 1<br>
+<br>
+static inline void cpu_get_tb_cpu_state(<wbr>CPURXState *env, target_ulong=
 *pc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_u=
long *cs_base, uint32_t *flags)<br>
+{<br>
+=C2=A0 =C2=A0 *pc =3D env-&gt;pc;<br>
+=C2=A0 =C2=A0 *cs_base =3D 0;<br>
+=C2=A0 =C2=A0 *flags =3D FIELD_DP32(0, PSW, PM, env-&gt;psw_pm);<br>
+}<br>
+<br>
+static inline int cpu_mmu_index(CPURXState *env, bool ifetch)<br>
+{<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static inline uint32_t rx_cpu_pack_psw(CPURXState *env)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t psw =3D 0;<br>
+=C2=A0 =C2=A0 psw =3D FIELD_DP32(psw, PSW, IPL, env-&gt;psw_ipl);<br>
+=C2=A0 =C2=A0 psw =3D FIELD_DP32(psw, PSW, PM,=C2=A0 env-&gt;psw_pm);<br>
+=C2=A0 =C2=A0 psw =3D FIELD_DP32(psw, PSW, U,=C2=A0 =C2=A0env-&gt;psw_u);<=
br>
+=C2=A0 =C2=A0 psw =3D FIELD_DP32(psw, PSW, I,=C2=A0 =C2=A0env-&gt;psw_i);<=
br>
+=C2=A0 =C2=A0 psw =3D FIELD_DP32(psw, PSW, O,=C2=A0 =C2=A0env-&gt;psw_o &g=
t;&gt; 31);<br>
+=C2=A0 =C2=A0 psw =3D FIELD_DP32(psw, PSW, S,=C2=A0 =C2=A0env-&gt;psw_s &g=
t;&gt; 31);<br>
+=C2=A0 =C2=A0 psw =3D FIELD_DP32(psw, PSW, Z,=C2=A0 =C2=A0env-&gt;psw_z =
=3D=3D 0);<br>
+=C2=A0 =C2=A0 psw =3D FIELD_DP32(psw, PSW, C,=C2=A0 =C2=A0env-&gt;psw_c);<=
br>
+=C2=A0 =C2=A0 return psw;<br>
+}<br>
+<br>
+#endif /* RX_CPU_H */<br>
diff --git a/target/rx/cpu.c b/target/rx/cpu.c<br>
new file mode 100644<br>
index 0000000000..ea38639f47<br>
--- /dev/null<br>
+++ b/target/rx/cpu.c<br>
@@ -0,0 +1,217 @@<br>
+/*<br>
+ * QEMU RX CPU<br>
+ *<br>
+ * Copyright (c) 2019 Yoshinori Sato<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or modify it=
<br>
+ * under the terms and conditions of the GNU General Public License,<br>
+ * version 2 or later, as published by the Free Software Foundation.<br>
+ *<br>
+ * This program is distributed in the hope it will be useful, but WITHOUT<=
br>
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or<b=
r>
+ * FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU General Public Lice=
nse for<br>
+ * more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License along=
 with<br>
+ * this program.=C2=A0 If not, see &lt;<a href=3D"http://www.gnu.org/licen=
ses/" target=3D"_blank">http://www.gnu.org/licenses/</a>&gt;<wbr>.<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/qemu-print.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;cpu.h&quot;<br>
+#include &quot;qemu-common.h&quot;<br>
+#include &quot;migration/vmstate.h&quot;<br>
+#include &quot;exec/exec-all.h&quot;<br>
+#include &quot;hw/loader.h&quot;<br>
+#include &quot;fpu/softfloat.h&quot;<br>
+<br>
+static void rx_cpu_set_pc(CPUState *cs, vaddr value)<br>
+{<br>
+=C2=A0 =C2=A0 RXCPU *cpu =3D RXCPU(cs);<br>
+<br>
+=C2=A0 =C2=A0 cpu-&gt;env.pc =3D value;<br>
+}<br>
+<br>
+static void rx_cpu_synchronize_from_tb(<wbr>CPUState *cs, TranslationBlock=
 *tb)<br>
+{<br>
+=C2=A0 =C2=A0 RXCPU *cpu =3D RXCPU(cs);<br>
+<br>
+=C2=A0 =C2=A0 cpu-&gt;env.pc =3D tb-&gt;pc;<br>
+}<br>
+<br>
+static bool rx_cpu_has_work(CPUState *cs)<br>
+{<br>
+=C2=A0 =C2=A0 return cs-&gt;interrupt_request &amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);<br>
+}<br>
+<br>
+static void rx_cpu_reset(CPUState *s)<br>
+{<br>
+=C2=A0 =C2=A0 RXCPU *cpu =3D RXCPU(s);<br>
+=C2=A0 =C2=A0 RXCPUClass *rcc =3D RXCPU_GET_CLASS(cpu);<br>
+=C2=A0 =C2=A0 CPURXState *env =3D &amp;cpu-&gt;env;<br>
+=C2=A0 =C2=A0 uint32_t *resetvec;<br>
+<br>
+=C2=A0 =C2=A0 rcc-&gt;parent_reset(s);<br>
+<br>
+=C2=A0 =C2=A0 memset(env, 0, offsetof(CPURXState, end_reset_fields));<br>
+<br>
+=C2=A0 =C2=A0 resetvec =3D rom_ptr(0xfffffffc, 4);<br>
+=C2=A0 =C2=A0 if (resetvec) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* In the case of kernel, it is ignored becaus=
e it is not set. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;pc =3D ldl_p(resetvec);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 rx_cpu_unpack_psw(env, 0, 1);<br>
+=C2=A0 =C2=A0 env-&gt;regs[0] =3D env-&gt;isp =3D env-&gt;usp =3D 0;<br>
+=C2=A0 =C2=A0 env-&gt;fpsw =3D 0;<br>
+=C2=A0 =C2=A0 set_flush_to_zero(1, &amp;env-&gt;fp_status);<br>
+=C2=A0 =C2=A0 set_flush_inputs_to_zero(1, &amp;env-&gt;fp_status);<br>
+}<br>
+<br>
+static void rx_cpu_list_entry(gpointer data, gpointer user_data)<br>
+{<br>
+=C2=A0 =C2=A0 const char *typename =3D object_class_get_name(OBJECT_<wbr>C=
LASS(data));<br>
+<br>
+=C2=A0 =C2=A0 qemu_printf(&quot;%s\n&quot;, typename);<br>
+}<br>
+<br>
+void rx_cpu_list(void)<br>
+{<br>
+=C2=A0 =C2=A0 GSList *list;<br>
+=C2=A0 =C2=A0 list =3D object_class_get_list_sorted(<wbr>TYPE_RX_CPU, fals=
e);<br>
+=C2=A0 =C2=A0 g_slist_foreach(list, rx_cpu_list_entry, NULL);<br>
+=C2=A0 =C2=A0 g_slist_free(list);<br>
+}<br>
+<br>
+static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)<br>
+{<br>
+=C2=A0 =C2=A0 ObjectClass *oc;<br>
+<br>
+=C2=A0 =C2=A0 oc =3D object_class_by_name(cpu_<wbr>model);<br>
+=C2=A0 =C2=A0 if (object_class_dynamic_cast(oc, TYPE_RX_CPU) =3D=3D NULL |=
|<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_class_is_abstract(oc)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 oc =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return oc;<br>
+}<br>
+<br>
+static void rx_cpu_realize(DeviceState *dev, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 CPUState *cs =3D CPU(dev);<br>
+=C2=A0 =C2=A0 RXCPUClass *rcc =3D RXCPU_GET_CLASS(dev);<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 cpu_exec_realizefn(cs, &amp;local_err);<br>
+=C2=A0 =C2=A0 if (local_err !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 cpu_reset(cs);<br>
+=C2=A0 =C2=A0 qemu_init_vcpu(cs);<br>
+<br>
+=C2=A0 =C2=A0 rcc-&gt;parent_realize(dev, errp);<br>
+}<br>
+<br>
+static void rx_cpu_set_irq(void *opaque, int no, int request)<br>
+{<br>
+=C2=A0 =C2=A0 RXCPU *cpu =3D opaque;<br>
+=C2=A0 =C2=A0 CPUState *cs =3D CPU(cpu);<br>
+=C2=A0 =C2=A0 int irq =3D request &amp; 0xff;<br>
+<br>
+=C2=A0 =C2=A0 static const int mask[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [RX_CPU_IRQ] =3D CPU_INTERRUPT_HARD,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [RX_CPU_FIR] =3D CPU_INTERRUPT_FIR,<br>
+=C2=A0 =C2=A0 };<br>
+=C2=A0 =C2=A0 if (irq) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;env.req_irq =3D irq;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;env.req_ipl =3D (request &gt;&gt; 8) &=
amp; 0x0f;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_interrupt(cs, mask[no]);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_reset_interrupt(cs, mask[no]);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void rx_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)<b=
r>
+{<br>
+=C2=A0 =C2=A0 info-&gt;mach =3D bfd_mach_rx;<br>
+=C2=A0 =C2=A0 info-&gt;print_insn =3D print_insn_rx;<br>
+}<br>
+<br>
+static bool rx_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 MMUAccessType access_type, int mmu_idx,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 bool probe, uintptr_t retaddr)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t address, physical, prot;<br>
+<br>
+=C2=A0 =C2=A0 /* Linear mapping */<br>
+=C2=A0 =C2=A0 address =3D physical =3D addr &amp; TARGET_PAGE_MASK;<br>
+=C2=A0 =C2=A0 prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;<br>
+=C2=A0 =C2=A0 tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PA=
GE_SIZE);<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static void rx_cpu_init(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 CPUState *cs =3D CPU(obj);<br>
+=C2=A0 =C2=A0 RXCPU *cpu =3D RXCPU(obj);<br>
+=C2=A0 =C2=A0 CPURXState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 cpu_set_cpustate_pointers(cpu)<wbr>;<br>
+=C2=A0 =C2=A0 cs-&gt;env_ptr =3D env;<br>
+=C2=A0 =C2=A0 qdev_init_gpio_in(DEVICE(cpu), rx_cpu_set_irq, 2);<br>
+}<br>
+<br>
+static void rx_cpu_class_init(ObjectClass *klass, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
+=C2=A0 =C2=A0 CPUClass *cc =3D CPU_CLASS(klass);<br>
+=C2=A0 =C2=A0 RXCPUClass *rcc =3D RXCPU_CLASS(klass);<br>
+<br>
+=C2=A0 =C2=A0 device_class_set_parent_<wbr>realize(dc, rx_cpu_realize,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;rcc-&gt;parent_re=
alize);<br>
+<br>
+=C2=A0 =C2=A0 rcc-&gt;parent_reset =3D cc-&gt;reset;<br>
+=C2=A0 =C2=A0 cc-&gt;reset =3D rx_cpu_reset;<br>
+<br>
+=C2=A0 =C2=A0 cc-&gt;class_by_name =3D rx_cpu_class_by_name;<br>
+=C2=A0 =C2=A0 cc-&gt;has_work =3D rx_cpu_has_work;<br>
+=C2=A0 =C2=A0 cc-&gt;do_interrupt =3D rx_cpu_do_interrupt;<br>
+=C2=A0 =C2=A0 cc-&gt;cpu_exec_interrupt =3D rx_cpu_exec_interrupt;<br>
+=C2=A0 =C2=A0 cc-&gt;dump_state =3D rx_cpu_dump_state;<br>
+=C2=A0 =C2=A0 cc-&gt;set_pc =3D rx_cpu_set_pc;<br>
+=C2=A0 =C2=A0 cc-&gt;synchronize_from_tb =3D rx_cpu_synchronize_from_tb;<b=
r>
+=C2=A0 =C2=A0 cc-&gt;gdb_read_register =3D rx_cpu_gdb_read_register;<br>
+=C2=A0 =C2=A0 cc-&gt;gdb_write_register =3D rx_cpu_gdb_write_register;<br>
+=C2=A0 =C2=A0 cc-&gt;get_phys_page_debug =3D rx_cpu_get_phys_page_debug;<b=
r>
+=C2=A0 =C2=A0 cc-&gt;disas_set_info =3D rx_cpu_disas_set_info;<br>
+=C2=A0 =C2=A0 cc-&gt;tcg_initialize =3D rx_translate_init;<br>
+=C2=A0 =C2=A0 cc-&gt;tlb_fill =3D rx_cpu_tlb_fill;<br>
+<br>
+=C2=A0 =C2=A0 cc-&gt;gdb_num_core_regs =3D 26;<br>
+}<br>
+<br>
+static const TypeInfo rx_cpu_info =3D {<br>
+=C2=A0 =C2=A0 .name =3D TYPE_RX_CPU,<br>
+=C2=A0 =C2=A0 .parent =3D TYPE_CPU,<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(RXCPU),<br>
+=C2=A0 =C2=A0 .instance_init =3D rx_cpu_init,<br>
+=C2=A0 =C2=A0 .abstract =3D true,<br>
+=C2=A0 =C2=A0 .class_size =3D sizeof(RXCPUClass),<br>
+=C2=A0 =C2=A0 .class_init =3D rx_cpu_class_init,<br>
+};<br>
+<br>
+static const TypeInfo rx62n_rx_cpu_info =3D {<br>
+=C2=A0 =C2=A0 .name =3D TYPE_RX62N_CPU,<br>
+=C2=A0 =C2=A0 .parent =3D TYPE_RX_CPU,<br>
+};<br>
+<br>
+static void rx_cpu_register_types(void)<br>
+{<br>
+=C2=A0 =C2=A0 type_register_static(&amp;rx_cpu_<wbr>info);<br>
+=C2=A0 =C2=A0 type_register_static(&amp;rx62n_<wbr>rx_cpu_info);<br>
+}<br>
+<br>
+type_init(rx_cpu_register_<wbr>types)<br>
diff --git a/target/rx/gdbstub.c b/target/rx/gdbstub.c<br>
new file mode 100644<br>
index 0000000000..d76ca52e82<br>
--- /dev/null<br>
+++ b/target/rx/gdbstub.c<br>
@@ -0,0 +1,112 @@<br>
+/*<br>
+ * RX gdb server stub<br>
+ *<br>
+ * Copyright (c) 2019 Yoshinori Sato<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or modify it=
<br>
+ * under the terms and conditions of the GNU General Public License,<br>
+ * version 2 or later, as published by the Free Software Foundation.<br>
+ *<br>
+ * This program is distributed in the hope it will be useful, but WITHOUT<=
br>
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or<b=
r>
+ * FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU General Public Lice=
nse for<br>
+ * more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License along=
 with<br>
+ * this program.=C2=A0 If not, see &lt;<a href=3D"http://www.gnu.org/licen=
ses/" target=3D"_blank">http://www.gnu.org/licenses/</a>&gt;<wbr>.<br>
+ */<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu-common.h&quot;<br>
+#include &quot;cpu.h&quot;<br>
+#include &quot;exec/gdbstub.h&quot;<br>
+<br>
+int rx_cpu_gdb_read_register(<wbr>CPUState *cs, uint8_t *mem_buf, int n)<b=
r>
+{<br>
+=C2=A0 =C2=A0 RXCPU *cpu =3D RXCPU(cs);<br>
+=C2=A0 =C2=A0 CPURXState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 switch (n) {<br>
+=C2=A0 =C2=A0 case 0 ... 15:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env-&gt;regs[n]);=
<br>
+=C2=A0 =C2=A0 case 16:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, (env-&gt;psw_u) ?=
 env-&gt;regs[0] : env-&gt;usp);<br>
+=C2=A0 =C2=A0 case 17:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, (!env-&gt;psw_u) =
? env-&gt;regs[0] : env-&gt;isp);<br>
+=C2=A0 =C2=A0 case 18:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, rx_cpu_pack_psw(e=
nv));<br>
+=C2=A0 =C2=A0 case 19:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env-&gt;pc);<br>
+=C2=A0 =C2=A0 case 20:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env-&gt;intb);<br=
>
+=C2=A0 =C2=A0 case 21:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env-&gt;bpsw);<br=
>
+=C2=A0 =C2=A0 case 22:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env-&gt;bpc);<br>
+=C2=A0 =C2=A0 case 23:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env-&gt;fintv);<b=
r>
+=C2=A0 =C2=A0 case 24:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env-&gt;fpsw);<br=
>
+=C2=A0 =C2=A0 case 25:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+int rx_cpu_gdb_write_register(<wbr>CPUState *cs, uint8_t *mem_buf, int n)<=
br>
+{<br>
+=C2=A0 =C2=A0 RXCPU *cpu =3D RXCPU(cs);<br>
+=C2=A0 =C2=A0 CPURXState *env =3D &amp;cpu-&gt;env;<br>
+=C2=A0 =C2=A0 uint32_t psw;<br>
+=C2=A0 =C2=A0 switch (n) {<br>
+=C2=A0 =C2=A0 case 0 ... 15:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;regs[n] =3D ldl_p(mem_buf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;psw_u) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;usp =3D en=
v-&gt;regs[0];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;isp =3D en=
v-&gt;regs[0];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 16:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;usp =3D ldl_p(mem_buf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;psw_u) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;regs[0] =3D ldl_p(mem_bu=
f);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 17:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;isp =3D ldl_p(mem_buf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!env-&gt;psw_u) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;regs[0] =3D ldl_p(mem_bu=
f);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 18:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 psw =3D ldl_p(mem_buf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_cpu_unpack_psw(env, psw, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 19:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;pc =3D ldl_p(mem_buf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 20:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;intb =3D ldl_p(mem_buf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 21:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;bpsw =3D ldl_p(mem_buf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 22:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;bpc =3D ldl_p(mem_buf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 23:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;fintv =3D ldl_p(mem_buf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 24:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;fpsw =3D ldl_p(mem_buf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 25:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 8;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return 4;<br>
+}<br>
diff --git a/target/rx/Makefile.objs b/target/rx/Makefile.objs<br>
index aa6f2d2d6c..a0018d5bc5 100644<br>
--- a/target/rx/Makefile.objs<br>
+++ b/target/rx/Makefile.objs<br>
@@ -1,5 +1,4 @@<br>
=C2=A0obj-y +=3D translate.o op_helper.o helper.o cpu.o gdbstub.o disas.o<b=
r>
-obj-$(CONFIG_SOFTMMU) +=3D monitor.o<br>
<br>
=C2=A0DECODETREE =3D $(SRC_PATH)/scripts/<wbr>decodetree.py<br>
=C2=A0<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote>

--00000000000002c2eb059a38eeff--

