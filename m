Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D47EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 18:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2AB720657
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 18:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHh3rxwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AB720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZInz-0002tq-6L
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 14:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZIml-0001n1-MY
 for qemu-devel@nongnu.org; Thu, 14 May 2020 14:40:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23029
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZImj-0005gV-CD
 for qemu-devel@nongnu.org; Thu, 14 May 2020 14:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589481644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rfBIAlR6xc18ltjzUV4xI6Mvxc3jU7QN3FmU7hyMYxw=;
 b=jHh3rxwSQqclKVjjbb9Ueq9zcT8g1eAhQms27Te4B1w4b897SBxsQGES8DKZKs0mLb3wNF
 lQXlu5ItM5rEZIE27SqinPYfdT7YUOWIV3I/WloGPa5wPlfgQ/LjdX0E4BLoat9Tio5Ls/
 CQCtYbJr5HP3HpbGd95WXMFRUmWTWCY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-eQ52_KeIPY6PZ-ycgGLuIQ-1; Thu, 14 May 2020 14:40:27 -0400
X-MC-Unique: eQ52_KeIPY6PZ-ycgGLuIQ-1
Received: by mail-wr1-f72.google.com with SMTP id p8so2002199wrj.5
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 11:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rfBIAlR6xc18ltjzUV4xI6Mvxc3jU7QN3FmU7hyMYxw=;
 b=b5rIDJ0b36jTh+KJtus65ojvz8M3IgNgHlwM2vSN3KsRje+IFqnPIa7m3gd1gbKW8Y
 uBoPyZzI8aHRGoDH9/nRZtP2n8VbQDbg5ciUDws4ziPJKYBCXkw3df3iWtdvsoFTgf3J
 Ybx8LzCbPp5FdvCKyN5awyLGIaMmlVd747fsv4wUDFLj61yoTfKO1iuW+eHPwBNwCD9G
 p7AlyE8dacbkma6gDr5aepHNcO0bhELj7PGfzMksF5apGTzz4Hc9ktDMiT6D58jZBuCl
 AiBF5BO9myB29U4KCP6RJbiSDO0NMYLnaWJUeKm23quCRN1cI2Ylfqig6Rbv2HOG3LpO
 KBOw==
X-Gm-Message-State: AOAM531x7JHxiHls/mtETJ1vjkVj6HVZajuevU7GEDaJG0Du4M0F7Bj9
 VRjuOznOYn/cUz/MmNHLhkEnjSOg259sXlND5CUa3VttE5YOzv7OHbwzRaloifNrfplRaiK2Xca
 khzcG+tL1j/KkC0Y=
X-Received: by 2002:adf:82b3:: with SMTP id 48mr6766800wrc.223.1589481626814; 
 Thu, 14 May 2020 11:40:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2Rr2h97I4QxLBPfSR+WzLexewS1Z49lTHQ5ql+BOF2jTHKbArUBO7DOBstc9nl9PpamUjDg==
X-Received: by 2002:adf:82b3:: with SMTP id 48mr6766773wrc.223.1589481626532; 
 Thu, 14 May 2020 11:40:26 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id x5sm5513991wro.12.2020.05.14.11.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2020 11:40:25 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] hw/intc: Initial commit of lowRISC Ibex PLIC
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1588878756.git.alistair.francis@wdc.com>
 <27436e8864997f4d67d9562f1db41da2db05f4cf.1588878756.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <50effad3-3f41-2d36-e4dd-d14c05e6ea8c@redhat.com>
Date: Thu, 14 May 2020 20:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <27436e8864997f4d67d9562f1db41da2db05f4cf.1588878756.git.alistair.francis@wdc.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 12:05:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 9:13 PM, Alistair Francis wrote:
> The Ibex core contains a PLIC that although similar to the RISC-V spec
> is not RISC-V spec compliant.
> 
> This patch implements a Ibex PLIC in a somewhat generic way.
> 
> As the current RISC-V PLIC needs tidying up, my hope is that as the Ibex
> PLIC move towards spec compliance this PLIC implementation can be
> updated until it can replace the current PLIC.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   MAINTAINERS                 |   2 +
>   hw/intc/Makefile.objs       |   1 +
>   hw/intc/ibex_plic.c         | 261 ++++++++++++++++++++++++++++++++++++
>   include/hw/intc/ibex_plic.h |  63 +++++++++
>   4 files changed, 327 insertions(+)
>   create mode 100644 hw/intc/ibex_plic.c
>   create mode 100644 include/hw/intc/ibex_plic.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d3d47564ce..f8c3cf6182 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1237,8 +1237,10 @@ L: qemu-riscv@nongnu.org
>   S: Supported
>   F: hw/riscv/opentitan.c
>   F: hw/char/ibex_uart.c
> +F: hw/intc/ibex_plic.c
>   F: include/hw/riscv/opentitan.h
>   F: include/hw/char/ibex_uart.h
> +F: include/hw/intc/ibex_plic.h
>   
>   
>   SH4 Machines
> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
> index f726d87532..a61e6728fe 100644
> --- a/hw/intc/Makefile.objs
> +++ b/hw/intc/Makefile.objs
> @@ -49,3 +49,4 @@ obj-$(CONFIG_ARM_GIC) += arm_gicv3_cpuif.o
>   obj-$(CONFIG_MIPS_CPS) += mips_gic.o
>   obj-$(CONFIG_NIOS2) += nios2_iic.o
>   obj-$(CONFIG_OMPIC) += ompic.o
> +obj-$(CONFIG_IBEX) += ibex_plic.o
> diff --git a/hw/intc/ibex_plic.c b/hw/intc/ibex_plic.c
> new file mode 100644
> index 0000000000..35c52d9d16
> --- /dev/null
> +++ b/hw/intc/ibex_plic.c
> @@ -0,0 +1,261 @@
> +/*
> + * QEMU RISC-V lowRISC Ibex PLIC
> + *
> + * Copyright (c) 2020 Western Digital
> + *
> + * Documentation avaliable: https://docs.opentitan.org/hw/ip/rv_plic/doc/
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/core/cpu.h"
> +#include "hw/boards.h"
> +#include "hw/pci/msi.h"
> +#include "target/riscv/cpu_bits.h"
> +#include "target/riscv/cpu.h"
> +#include "hw/intc/ibex_plic.h"
> +
> +static bool addr_between(uint32_t addr, uint32_t base, uint32_t num)
> +{
> +    uint32_t end = base + (num * 0x04);
> +
> +    if (addr >= base && addr < end) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +static void ibex_plic_irqs_set_pending(IbexPlicState *s, int irq, bool level)
> +{
> +    int pending_num = irq / 32;
> +
> +    s->pending[pending_num] |= level << (irq % 32);
> +}
> +
> +static bool ibex_plic_irqs_pending(IbexPlicState *s, uint32_t context)
> +{
> +    int i;
> +
> +    for (i = 0; i < s->pending_num; i++) {
> +        uint32_t irq_num = ctz64(s->pending[i]) + (i * 32);
> +
> +        if (!(s->pending[i] & s->enable[i])) {
> +            /* No pending and enabled IRQ */
> +            continue;
> +        }
> +
> +        if (s->priority[irq_num] > s->threshold) {
> +            if (!s->claim) {
> +                s->claim = irq_num;
> +            }
> +            return true;
> +        }
> +    }
> +
> +    return 0;

return 'false'.

> +}
> +
> +static void ibex_plic_update(IbexPlicState *s)
> +{
> +    CPUState *cpu;
> +    int level, i;
> +
> +    for (i = 0; i < s->num_cpus; i++) {
> +        cpu = qemu_get_cpu(i);
> +
> +        if (!cpu) {
> +            continue;
> +        }
> +
> +        level = ibex_plic_irqs_pending(s, 0);
> +
> +        riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_MEIP, BOOL_TO_MASK(level));
> +    }
> +}
> +
> +static void ibex_plic_reset(DeviceState *dev)
> +{
> +    IbexPlicState *s = IBEX_PLIC(dev);
> +
> +    s->threshold = 0x00000000;
> +    s->claim = 0x00000000;

I haven't check the datasheet reset values, for the rest:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +}
> +
> +static uint64_t ibex_plic_read(void *opaque, hwaddr addr,
> +                               unsigned int size)
> +{
> +    IbexPlicState *s = opaque;
> +    int offset;
> +    uint32_t ret = 0;
> +
> +    if (addr_between(addr, s->pending_base, s->pending_num)) {
> +        offset = (addr - s->pending_base) / 4;
> +        ret = s->pending[offset];
> +    } else if (addr_between(addr, s->source_base, s->source_num)) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Interrupt source mode not supported\n", __func__);
> +    } else if (addr_between(addr, s->priority_base, s->priority_num)) {
> +        offset = (addr - s->priority_base) / 4;
> +        ret = s->priority[offset];
> +    } else if (addr_between(addr, s->enable_base, s->enable_num)) {
> +        offset = (addr - s->enable_base) / 4;
> +        ret = s->enable[offset];
> +    } else if (addr_between(addr, s->threshold_base, 1)) {
> +        ret = s->threshold;
> +    } else if (addr_between(addr, s->claim_base, 1)) {
> +        int pending_num = s->claim / 32;
> +        s->pending[pending_num] &= ~(1 << (s->claim % 32));
> +
> +        ret = s->claim;
> +    }
> +
> +    return ret;
> +}
> +
> +static void ibex_plic_write(void *opaque, hwaddr addr,
> +                            uint64_t value, unsigned int size)
> +{
> +    IbexPlicState *s = opaque;
> +
> +    if (addr_between(addr, s->pending_base, s->pending_num)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Pending registers are read only\n", __func__);
> +    } else if (addr_between(addr, s->source_base, s->source_num)) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Interrupt source mode not supported\n", __func__);
> +    } else if (addr_between(addr, s->priority_base, s->priority_num)) {
> +        uint32_t irq = ((addr - s->priority_base) >> 2) + 1;
> +        s->priority[irq] = value & 7;
> +    } else if (addr_between(addr, s->enable_base, s->enable_num)) {
> +        uint32_t enable_reg = (addr - s->enable_base) / 4;
> +
> +        s->enable[enable_reg] = value;
> +    } else if (addr_between(addr, s->threshold_base, 1)) {
> +        s->threshold = value & 3;
> +    } else if (addr_between(addr, s->claim_base, 1)) {
> +        if (s->claim == value) {
> +            /* Interrupt was completed */
> +            s->claim = 0;
> +        }
> +    }
> +
> +    ibex_plic_update(s);
> +}
> +
> +static const MemoryRegionOps ibex_plic_ops = {
> +    .read = ibex_plic_read,
> +    .write = ibex_plic_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4
> +    }
> +};
> +
> +static void ibex_plic_irq_request(void *opaque, int irq, int level)
> +{
> +    IbexPlicState *s = opaque;
> +
> +    ibex_plic_irqs_set_pending(s, irq, level > 0);
> +    ibex_plic_update(s);
> +}
> +
> +static Property ibex_plic_properties[] = {
> +    DEFINE_PROP_UINT32("num-cpus", IbexPlicState, num_cpus, 1),
> +    DEFINE_PROP_UINT32("num-sources", IbexPlicState, num_sources, 80),
> +
> +    DEFINE_PROP_UINT32("pending-base", IbexPlicState, pending_base, 0),
> +    DEFINE_PROP_UINT32("pending-num", IbexPlicState, pending_num, 3),
> +
> +    DEFINE_PROP_UINT32("source-base", IbexPlicState, source_base, 0x0c),
> +    DEFINE_PROP_UINT32("source-num", IbexPlicState, source_num, 3),
> +
> +    DEFINE_PROP_UINT32("priority-base", IbexPlicState, priority_base, 0x18),
> +    DEFINE_PROP_UINT32("priority-num", IbexPlicState, priority_num, 80),
> +
> +    DEFINE_PROP_UINT32("enable-base", IbexPlicState, enable_base, 0x200),
> +    DEFINE_PROP_UINT32("enable-num", IbexPlicState, enable_num, 3),
> +
> +    DEFINE_PROP_UINT32("threshold-base", IbexPlicState, threshold_base, 0x20c),
> +
> +    DEFINE_PROP_UINT32("claim-base", IbexPlicState, claim_base, 0x210),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void ibex_plic_init(Object *obj)
> +{
> +    IbexPlicState *s = IBEX_PLIC(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &ibex_plic_ops, s,
> +                          TYPE_IBEX_PLIC, 0x400);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +}
> +
> +static void ibex_plic_realize(DeviceState *dev, Error **errp)
> +{
> +    IbexPlicState *s = IBEX_PLIC(dev);
> +    int i;
> +
> +    s->pending = g_new0(uint32_t, s->pending_num);
> +    s->source = g_new0(uint32_t, s->source_num);
> +    s->priority = g_new0(uint32_t, s->priority_num);
> +    s->enable = g_new0(uint32_t, s->enable_num);
> +
> +    qdev_init_gpio_in(dev, ibex_plic_irq_request, s->num_sources);
> +
> +    /*
> +     * We can't allow the supervisor to control SEIP as this would allow the
> +     * supervisor to clear a pending external interrupt which will result in
> +     * a lost interrupt in the case a PLIC is attached. The SEIP bit must be
> +     * hardware controlled when a PLIC is attached.
> +     */
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int smp_cpus = ms->smp.cpus;
> +    for (i = 0; i < smp_cpus; i++) {
> +        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(i));
> +        if (riscv_cpu_claim_interrupts(cpu, MIP_SEIP) < 0) {
> +            error_report("SEIP already claimed");
> +            exit(1);
> +        }
> +    }
> +
> +    msi_nonbroken = true;
> +}
> +
> +static void ibex_plic_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = ibex_plic_reset;
> +    device_class_set_props(dc, ibex_plic_properties);
> +    dc->realize = ibex_plic_realize;
> +}
> +
> +static const TypeInfo ibex_plic_info = {
> +    .name          = TYPE_IBEX_PLIC,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(IbexPlicState),
> +    .instance_init = ibex_plic_init,
> +    .class_init    = ibex_plic_class_init,
> +};
> +
> +static void ibex_plic_register_types(void)
> +{
> +    type_register_static(&ibex_plic_info);
> +}
> +
> +type_init(ibex_plic_register_types)
> diff --git a/include/hw/intc/ibex_plic.h b/include/hw/intc/ibex_plic.h
> new file mode 100644
> index 0000000000..ddc7909903
> --- /dev/null
> +++ b/include/hw/intc/ibex_plic.h
> @@ -0,0 +1,63 @@
> +/*
> + * QEMU RISC-V lowRISC Ibex PLIC
> + *
> + * Copyright (c) 2020 Western Digital
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_IBEX_PLIC_H
> +#define HW_IBEX_PLIC_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_IBEX_PLIC "ibex-plic"
> +#define IBEX_PLIC(obj) \
> +    OBJECT_CHECK(IbexPlicState, (obj), TYPE_IBEX_PLIC)
> +
> +typedef struct IbexPlicState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    MemoryRegion mmio;
> +
> +    uint32_t *pending;
> +    uint32_t *source;
> +    uint32_t *priority;
> +    uint32_t *enable;
> +    uint32_t threshold;
> +    uint32_t claim;
> +
> +    /* config */
> +    uint32_t num_cpus;
> +    uint32_t num_sources;
> +
> +    uint32_t pending_base;
> +    uint32_t pending_num;
> +
> +    uint32_t source_base;
> +    uint32_t source_num;
> +
> +    uint32_t priority_base;
> +    uint32_t priority_num;
> +
> +    uint32_t enable_base;
> +    uint32_t enable_num;
> +
> +    uint32_t threshold_base;
> +
> +    uint32_t claim_base;
> +} IbexPlicState;
> +
> +#endif /* HW_IBEX_PLIC_H */
> 


