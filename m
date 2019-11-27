Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19D3C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 22:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A8A20870
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 22:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gI0Zhpf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A8A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia5mL-0007b1-Ed
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 17:27:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ia5lE-000796-4Z
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 17:26:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ia5l8-0004RX-2F
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 17:26:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26450
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ia5l7-0004Ob-Qz
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 17:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574893560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bfa3a5L/bSIIedJeVVP9xRszkjUiZ1BQOm0lXlXmi44=;
 b=gI0Zhpf8DhX/CRqRxORxLyfbuQjI6cxGxQZowppf6002jZlvNPVxlDQqvkznfvxVMq/7nB
 4CPfKV55JkTUQe7DTCArmfc/S5IfsDACE1NSq56B74MrnoJsbFmNfLU0nQznW7KLCD0fbo
 NwsRoIjatXb81Newa8luMDgl0T8UNaM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-LLWyQ_leNxaR4MR1OFWXsw-1; Wed, 27 Nov 2019 17:25:59 -0500
Received: by mail-wr1-f72.google.com with SMTP id e3so12787578wrs.17
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 14:25:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qxTU7E/pgkbPpVD1s9V8j1NLpjZmcPnqk9zgoUJiFzg=;
 b=M4ytCBr3rRcQTMKzrzl1/mDXNCm38T4llcujO/wsI1w860/b2BEeHIl2OsY3Vth3my
 jos2EwuAU7dGE/b7tS8vfjHZxynBKw8OQ9tX/Gx5RD2d6hcXKLd6lRBaPUtiYKvWtiXR
 OGVf/MrWiK6TbDQBNLaVcOV8DQbmPgFDwnCx/EbkfkHjkcX9NPQbCqO+VS0wOsrfxG4A
 nvxfYN0TSMwaqTz5EmPAMZDKNqiX2Z4wTxsYjo8ape7K0fwoBidurQW2kf9nTZWSok9C
 L/1yUqWpleC0wWPv0LR4BPpctaRDLOhdS6XCBn/7VGqxK8JQcfG7Yw6fS6bxOk6RPpI/
 5wwA==
X-Gm-Message-State: APjAAAXtcTWoUOF2lLWqDo7Zu5BzbBUOD657Dw6DDauVbDMuJ8Q16k5P
 tr8WFf4+QKaRQzCuJuXlcHreyzH9S6Ew7ETOPNzgBEJhccGt5FFw1r7ybnbJ7+DGmc1WL1q8Pse
 Qb3vvg/5LKLrUkHk=
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr26451228wrn.50.1574893557809; 
 Wed, 27 Nov 2019 14:25:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzv01H4K+956eNw6ZHaG12eEbDfYozhgAw0grneTe48Eri9WauTFY46OS6+MltwEcjCUsDgJw==
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr26451202wrn.50.1574893557395; 
 Wed, 27 Nov 2019 14:25:57 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id z8sm4935961wrq.22.2019.11.27.14.25.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2019 14:25:56 -0800 (PST)
Subject: Re: [PATCH v37 01/17] target/avr: Add outward facing interfaces and
 core CPU logic
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <20191127175257.23480-2-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <861986d1-11e4-8cb2-5fb6-e19cfef67f61@redhat.com>
Date: Wed, 27 Nov 2019 23:25:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191127175257.23480-2-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: LLWyQ_leNxaR4MR1OFWXsw-1
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
Cc: thuth@redhat.com, me@xcancerberox.com.ar, richard.henderson@linaro.org,
 Sarah Harris <S.E.Harris@kent.ac.uk>, dovgaluk@ispras.ru, imammedo@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

On 11/27/19 6:52 PM, Michael Rolnik wrote:
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
> ---
>   target/avr/cpu-param.h |  37 +++
>   target/avr/cpu-qom.h   |  54 ++++
>   target/avr/cpu.h       | 253 ++++++++++++++++++
>   target/avr/cpu.c       | 576 +++++++++++++++++++++++++++++++++++++++++
>   target/avr/gdbstub.c   |  85 ++++++
>   target/avr/machine.c   | 121 +++++++++
>   gdb-xml/avr-cpu.xml    |  49 ++++
>   7 files changed, 1175 insertions(+)
>   create mode 100644 target/avr/cpu-param.h
>   create mode 100644 target/avr/cpu-qom.h
>   create mode 100644 target/avr/cpu.h
>   create mode 100644 target/avr/cpu.c
>   create mode 100644 target/avr/gdbstub.c
>   create mode 100644 target/avr/machine.c
>   create mode 100644 gdb-xml/avr-cpu.xml
>=20
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
> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> new file mode 100644
> index 0000000000..9ea5260165
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

Please add:

  #define AVR_CPU_TYPE_SUFFIX "-" TYPE_AVR_CPU
  #define AVR_CPU_TYPE_NAME(name) (name AVR_CPU_TYPE_SUFFIX)

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

Is the following block <...

> +/*
> + * Offsets of AVR memory regions in host memory space.
> + *
> + * This is needed because the AVR has separate code and data address
> + * spaces that both have start from zero but have to go somewhere in
> + * host memory.
> + *
> + * It's also useful to know where some things are, like the IO registers=
.
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
> +#define OFFSET_IO_REGISTERS (OFFSET_DATA + NUMBER_OF_CPU_REGISTERS)

...> really CPU specific? This doesn't seem used by the CPU (core) code,=20
but by the MCU devices. Maybe we can extract them into=20
"target/avr/addrspace.h".

Can be done later.

[...]
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
> +    qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int, 57);

Deeply buried magic number...

I'm trying to understand the following comment in sample.c:

     /*
      * These IRQ numbers don't match the datasheet because we're=20
counting from
      * zero and not including reset.
      */

RESET is IRQ#1. IIUC qdev_get_gpio_in(cpu, 0) will return IRQ#2?
Then qdev_get_gpio_in(cpu, 55) will return IRQ#57?

This is related to:

  #define EXCP_RESET 1
  #define EXCP_INT(n) (EXCP_RESET + (n) + 1)

But then you use the hardware numbering:

/* Interrupt numbers used by peripherals */
#define USART_RXC_IRQ 24
#define USART_DRE_IRQ 25
#define USART_TXC_IRQ 26

So for USART3_TX=3D57, have we qdev_get_gpio_in(cpu, 57) out of bound?

Trying so trigger an abort:

#1  0x00007f2ed58e1895 in abort () at /lib64/libc.so.6
#2  0x00007f2ed58e1769 in _nl_load_domain.cold () at /lib64/libc.so.6
#3  0x00007f2ed58ef566 in annobin_assert.c_end () at /lib64/libc.so.6
#4  0x0000561fbbb37417 in qdev_get_gpio_in_named (dev=3D0x561fbd8b19d0,=20
name=3D0x0, n=3D57) at hw/core/qdev.c:478
#5  0x0000561fbbb37454 in qdev_get_gpio_in (dev=3D0x561fbd8b19d0, n=3D57) a=
t=20
hw/core/qdev.c:484

[This has to be fixed before merging]

Also, what about other MCUs with more than 57 lines? Can we use some=20
maximum value instead? Maybe 64?

Else we need to add a property and move that into realize(), because we=20
won't know the value at init() time.

Please use a #define for this value.

> +#endif
> +}
[...]

Thanks,

Phil.


