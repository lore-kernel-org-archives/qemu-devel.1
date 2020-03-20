Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C50CC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36DB420739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/9q0tLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DB420739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFKA0-0001IT-Cm
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 12:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFK8z-0000Cz-2d
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFK8t-0000Mp-50
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:05:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33327)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFK8s-0000M6-ED
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584720301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3lwD9a7Dlf53c4nSDi4DvYefeiVpw/xoXIGZh9LWwkI=;
 b=H/9q0tLegKULf4YchVawsqKe7PKYmlTDejRwr1S9G1pGzSJr7Lp1NCGCja1QvH9WUkQXJa
 ROa7JdVPxxs8wD0tEHoKhBOUeHQykrdgRMdbhnkZAUxXopaaw+mS2mu7p/aN7mhQ720zEb
 A5iubiN5PB5FxjrslMmPQ+4U/PwhGS0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-QB7DiIpkPuGfQTA7WxoIiA-1; Fri, 20 Mar 2020 12:04:57 -0400
X-MC-Unique: QB7DiIpkPuGfQTA7WxoIiA-1
Received: by mail-ed1-f70.google.com with SMTP id ce13so5399671edb.11
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 09:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wg4ZK/gfKJE/VNm02+2lozauN8862DW7SQOXCnzdrIY=;
 b=Q1OfheiDK507tOhAXziNF1IyKjQR8ZXbFAwbaXuFamNJWgbXMtiGE7hUv8bxA31qzb
 HNFZH3O4Sj9oTAlXr6bNU4TRb8nWLRVYQFqEWCIsheYr3nAa+f83yFQ/TvUVJRRNu/ZL
 dNET06+49beag13XM5/2bfL5yE0cT2kr2W/5YuUnF268/Fi2+P4T5EzAD16Q1wRrX0vG
 2WI1e55C8DX2LdLpqySJN/bS6PyvLCOslYWx8Rav8OV3ypRHcTq5Cj/30ub6famA95Te
 q0EQzDygIlWVYD2cTr0NlSSwzHkHOgaBQvKj4b4ur0PIdL+OMayqtRAjSy/bqoFhw1DG
 QyGw==
X-Gm-Message-State: ANhLgQ06LI/Nbo9PQN9qgUo8QZFAclFyR+KtXZLE1fEJX+EG3SRFjuFx
 A6dd0v+KU/O6/fvjGopDWd3/NxqGYFOU+vCOwLTqHNIJB44eClQ0Dmps+Yjqe1BIF5CQ4T5EfZK
 qkKQ7ceQveCDL4aE=
X-Received: by 2002:a05:6402:1bcd:: with SMTP id
 ch13mr3122095edb.306.1584720295698; 
 Fri, 20 Mar 2020 09:04:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs1GR6K4P7aBI6Bwratab7cfFSA2L5u+ocwr54sEqRs+hzgYufDLSdD+29xIRZy1FHts5dYKw==
X-Received: by 2002:a05:6402:1bcd:: with SMTP id
 ch13mr3122033edb.306.1584720295160; 
 Fri, 20 Mar 2020 09:04:55 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id m1sm403537ejr.68.2020.03.20.09.04.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 09:04:54 -0700 (PDT)
Subject: Re: [PULL v2 05/13] target/rx: CPU definitions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20200320103551.29246-1-f4bug@amsat.org>
 <20200320103551.29246-2-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c7cf4bab-b9ac-4387-0709-a02c04b24061@redhat.com>
Date: Fri, 20 Mar 2020 17:04:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320103551.29246-2-f4bug@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/20/20 11:35 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> From: Yoshinori Sato <ysato@users.sourceforge.jp>
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> [PMD: Use newer QOM style, split cpu-qom.h, restrict access to
>   extable array, use rx_cpu_tlb_fill() extracted from patch of
>   Yoshinori Sato 'Convert to CPUClass::tlb_fill', call cpu_reset
>   after qemu_init_vcpu, make rx_crname a function]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Message-Id: <20200224141923.82118-7-ysato@users.sourceforge.jp>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> [PMD: Use GByteArray in gdbstub (rebase commit a010bdbe),
>   use device_class_set_parent_reset (rebase commit 781c67ca)]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   target/rx/cpu-param.h   |  30 ++++++
>   target/rx/cpu-qom.h     |  53 ++++++++++
>   target/rx/cpu.h         | 180 ++++++++++++++++++++++++++++++++
>   target/rx/cpu.c         | 225 ++++++++++++++++++++++++++++++++++++++++
>   target/rx/gdbstub.c     | 112 ++++++++++++++++++++
>   target/rx/translate.c   |  17 ++-
>   gdb-xml/rx-core.xml     |  70 +++++++++++++
>   target/rx/Makefile.objs |   1 -
>   8 files changed, 682 insertions(+), 6 deletions(-)
>   create mode 100644 target/rx/cpu-param.h
>   create mode 100644 target/rx/cpu-qom.h
>   create mode 100644 target/rx/cpu.h
>   create mode 100644 target/rx/cpu.c
>   create mode 100644 target/rx/gdbstub.c
>   create mode 100644 gdb-xml/rx-core.xml
>=20
> diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
> new file mode 100644
> index 0000000000..b156ad1ca0
> --- /dev/null
> +++ b/target/rx/cpu-param.h
> @@ -0,0 +1,30 @@
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
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
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
> +
> +#endif
> diff --git a/target/rx/cpu-qom.h b/target/rx/cpu-qom.h
> new file mode 100644
> index 0000000000..3e81856ef5
> --- /dev/null
> +++ b/target/rx/cpu-qom.h
> @@ -0,0 +1,53 @@
> +/*
> + * RX CPU
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
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef RX_CPU_QOM_H
> +#define RX_CPU_QOM_H
> +
> +#include "hw/core/cpu.h"
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
> +    DeviceReset parent_reset;
> +} RXCPUClass;
> +
> +#define CPUArchState struct CPURXState
> +
> +#endif
> diff --git a/target/rx/cpu.h b/target/rx/cpu.h
> new file mode 100644
> index 0000000000..d1fb1ef3ca
> --- /dev/null
> +++ b/target/rx/cpu.h
> @@ -0,0 +1,180 @@
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
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
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
> +const char *rx_crname(uint8_t cr);
> +void rx_cpu_do_interrupt(CPUState *cpu);
> +bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
> +void rx_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> +int rx_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
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
> +static inline void cpu_get_tb_cpu_state(CPURXState *env, target_ulong *p=
c,
> +                                        target_ulong *cs_base, uint32_t =
*flags)
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
> index 0000000000..219e05397b
> --- /dev/null
> +++ b/target/rx/cpu.c
> @@ -0,0 +1,225 @@
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
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
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
> +static void rx_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *t=
b)
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
> +static void rx_cpu_reset(DeviceState *dev)
> +{
> +    RXCPU *cpu =3D RXCPU(dev);
> +    RXCPUClass *rcc =3D RXCPU_GET_CLASS(cpu);
> +    CPURXState *env =3D &cpu->env;
> +    uint32_t *resetvec;
> +
> +    rcc->parent_reset(dev);
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
> +    ObjectClass *oc =3D data;
> +
> +    qemu_printf("  %s\n", object_class_get_name(oc));
> +}
> +
> +void rx_cpu_list(void)
> +{
> +    GSList *list;
> +    list =3D object_class_get_list_sorted(TYPE_RX_CPU, false);
> +    qemu_printf("Available CPUs:\n");
> +    g_slist_foreach(list, rx_cpu_list_entry, NULL);
> +    g_slist_free(list);
> +}
> +
> +static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
> +{
> +    ObjectClass *oc;
> +    char *typename;
> +
> +    oc =3D object_class_by_name(cpu_model);
> +    if (oc !=3D NULL && object_class_dynamic_cast(oc, TYPE_RX_CPU) !=3D =
NULL &&
> +        !object_class_is_abstract(oc)) {
> +        return oc;
> +    }
> +    typename =3D g_strdup_printf(RX_CPU_TYPE_NAME("%s"), cpu_model);
> +    oc =3D object_class_by_name(typename);
> +    g_free(typename);
> +    if (oc !=3D NULL && object_class_is_abstract(oc)) {
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
> +    qemu_init_vcpu(cs);
> +    cpu_reset(cs);
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

Not related to this patch, but this line generates a warning with Clang:

   CC      rx-softmmu/target/rx/cpu.o
target/rx/cpu.c:158:33: warning: The result of the left shift is=20
undefined because the left operand is negative
     address =3D physical =3D addr & TARGET_PAGE_MASK;
                                 ^~~~~~~~~~~~~~~~
include/exec/cpu-all.h:234:45: note: expanded from macro 'TARGET_PAGE_MASK'
#define TARGET_PAGE_MASK   ((target_long)-1 << TARGET_PAGE_BITS)
                             ~~~~~~~~~~~~~~~ ^
1 warning generated.


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
> +    device_class_set_parent_reset(dc, rx_cpu_reset,
> +                                  &rcc->parent_reset);
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
> +    cc->gdb_core_xml_file =3D "rx-core.xml";
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
> index 0000000000..9391e8151e
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
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "exec/gdbstub.h"
> +
> +int rx_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
> +{
> +    RXCPU *cpu =3D RXCPU(cs);
> +    CPURXState *env =3D &cpu->env;
> +
> +    switch (n) {
> +    case 0 ... 15:
> +        return gdb_get_regl(mem_buf, env->regs[n]);
> +    case 16:
> +        return gdb_get_regl(mem_buf, (env->psw_u) ? env->regs[0] : env->=
usp);
> +    case 17:
> +        return gdb_get_regl(mem_buf, (!env->psw_u) ? env->regs[0] : env-=
>isp);
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
> diff --git a/target/rx/translate.c b/target/rx/translate.c
> index 6b52424d0f..b3d7305f23 100644
> --- a/target/rx/translate.c
> +++ b/target/rx/translate.c
> @@ -41,10 +41,17 @@ typedef struct DisasCompare {
>       TCGCond cond;
>   } DisasCompare;
>  =20
> -const char rx_crname[][6] =3D {
> -    "psw", "pc", "usp", "fpsw", "", "", "", "",
> -    "bpsw", "bpc", "isp", "fintv", "intb", "", "", "",
> -};
> +const char *rx_crname(uint8_t cr)
> +{
> +    static const char *cr_names[] =3D {
> +        "psw", "pc", "usp", "fpsw", "", "", "", "",
> +        "bpsw", "bpc", "isp", "fintv", "intb", "", "", ""
> +    };
> +    if (cr >=3D ARRAY_SIZE(cr_names)) {
> +        return "illegal";
> +    }
> +    return cr_names[cr];
> +}
>  =20
>   /* Target-specific values for dc->base.is_jmp.  */
>   #define DISAS_JUMP    DISAS_TARGET_0
> @@ -365,7 +372,7 @@ static void move_to_cr(DisasContext *ctx, TCGv val, i=
nt cr)
>       if (cr >=3D 8 && !is_privileged(ctx, 0)) {
>           /* Some control registers can only be written in privileged mod=
e. */
>           qemu_log_mask(LOG_GUEST_ERROR,
> -                      "disallow control register write %s", rx_crname[cr=
]);
> +                      "disallow control register write %s", rx_crname(cr=
));
>           return;
>       }
>       z =3D tcg_const_i32(0);
> diff --git a/gdb-xml/rx-core.xml b/gdb-xml/rx-core.xml
> new file mode 100644
> index 0000000000..b5aa9ac4a8
> --- /dev/null
> +++ b/gdb-xml/rx-core.xml
> @@ -0,0 +1,70 @@
> +<?xml version=3D"1.0"?>
> +<!-- Copyright (C) 2019 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification=
,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name=3D"org.gnu.gdb.rx.core">
> +  <reg name=3D"r0" bitsize=3D"32" type=3D"data_ptr"/>
> +  <reg name=3D"r1" bitsize=3D"32" type=3D"uint32"/>
> +  <reg name=3D"r2" bitsize=3D"32" type=3D"uint32"/>
> +  <reg name=3D"r3" bitsize=3D"32" type=3D"uint32"/>
> +  <reg name=3D"r4" bitsize=3D"32" type=3D"uint32"/>
> +  <reg name=3D"r5" bitsize=3D"32" type=3D"uint32"/>
> +  <reg name=3D"r6" bitsize=3D"32" type=3D"uint32"/>
> +  <reg name=3D"r7" bitsize=3D"32" type=3D"uint32"/>
> +  <reg name=3D"r8" bitsize=3D"32" type=3D"uint32"/>
> +  <reg name=3D"r9" bitsize=3D"32" type=3D"uint32"/>
> +  <reg name=3D"r10" bitsize=3D"32" type=3D"uint32"/>
> +  <reg name=3D"r11" bitsize=3D"32" type=3D"uint32"/>
> +  <reg name=3D"r12" bitsize=3D"32" type=3D"uint32"/>
> +  <reg name=3D"r13" bitsize=3D"32" type=3D"uint32"/>
> +  <reg name=3D"r14" bitsize=3D"32" type=3D"uint32"/>
> +  <reg name=3D"r15" bitsize=3D"32" type=3D"uint32"/>
> +
> +  <flags id=3D"psw_flags" size=3D"4">
> +    <field name=3D"C" start=3D"0" end=3D"0"/>
> +    <field name=3D"Z" start=3D"1" end=3D"1"/>
> +    <field name=3D"S" start=3D"2" end=3D"2"/>
> +    <field name=3D"O" start=3D"3" end=3D"3"/>
> +    <field name=3D"I" start=3D"16" end=3D"16"/>
> +    <field name=3D"U" start=3D"17" end=3D"17"/>
> +    <field name=3D"PM" start=3D"20" end=3D"20"/>
> +    <field name=3D"IPL" start=3D"24" end=3D"27"/>
> +  </flags>
> +
> +  <flags id=3D"fpsw_flags" size=3D"4">
> +    <field name=3D"RM" start=3D"0" end=3D"1"/>
> +    <field name=3D"CV" start=3D"2" end=3D"2"/>
> +    <field name=3D"CO" start=3D"3" end=3D"3"/>
> +    <field name=3D"CZ" start=3D"4" end=3D"4"/>
> +    <field name=3D"CU" start=3D"5" end=3D"5"/>
> +    <field name=3D"CX" start=3D"6" end=3D"6"/>
> +    <field name=3D"CE" start=3D"7" end=3D"7"/>
> +    <field name=3D"DN" start=3D"8" end=3D"8"/>
> +    <field name=3D"EV" start=3D"10" end=3D"10"/>
> +    <field name=3D"EO" start=3D"11" end=3D"11"/>
> +    <field name=3D"EZ" start=3D"12" end=3D"12"/>
> +    <field name=3D"EU" start=3D"13" end=3D"13"/>
> +    <field name=3D"EX" start=3D"14" end=3D"14"/>
> +    <field name=3D"FV" start=3D"26" end=3D"26"/>
> +    <field name=3D"FO" start=3D"27" end=3D"27"/>
> +    <field name=3D"FZ" start=3D"28" end=3D"28"/>
> +    <field name=3D"FU" start=3D"29" end=3D"29"/>
> +    <field name=3D"FX" start=3D"30" end=3D"30"/>
> +    <field name=3D"FS" start=3D"31" end=3D"31"/>
> +  </flags>
> +
> +  <reg name=3D"usp" bitsize=3D"32" type=3D"data_ptr"/>
> +  <reg name=3D"isp" bitsize=3D"32" type=3D"data_ptr"/>
> +  <reg name=3D"psw" bitsize=3D"32" type=3D"psw_flags"/>
> +  <reg name=3D"pc" bitsize=3D"32" type=3D"code_ptr"/>
> +  <reg name=3D"intb" bitsize=3D"32" type=3D"data_ptr"/>
> +  <reg name=3D"bpsw" bitsize=3D"32" type=3D"psw_flags"/>
> +  <reg name=3D"bpc" bitsize=3D"32" type=3D"code_ptr"/>
> +  <reg name=3D"fintv" bitsize=3D"32" type=3D"code_ptr"/>
> +  <reg name=3D"fpsw" bitsize=3D"32" type=3D"fpsw_flags"/>
> +  <reg name=3D"acc" bitsize=3D"64" type=3D"uint64"/>
> +</feature>
> diff --git a/target/rx/Makefile.objs b/target/rx/Makefile.objs
> index aa6f2d2d6c..a0018d5bc5 100644
> --- a/target/rx/Makefile.objs
> +++ b/target/rx/Makefile.objs
> @@ -1,5 +1,4 @@
>   obj-y +=3D translate.o op_helper.o helper.o cpu.o gdbstub.o disas.o
> -obj-$(CONFIG_SOFTMMU) +=3D monitor.o
>  =20
>   DECODETREE =3D $(SRC_PATH)/scripts/decodetree.py
>  =20
>=20


