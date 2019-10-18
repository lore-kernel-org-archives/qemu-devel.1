Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3E1CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF8E320640
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FMCrW3Uv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8E320640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLXOJ-00038Q-1E
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iLXMp-000273-NT
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:52:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iLXMm-0004gW-LI
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:52:51 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iLXMm-0004g8-Bx
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:52:48 -0400
Received: by mail-pf1-x442.google.com with SMTP id q21so4401998pfn.11
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 11:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=e12d2I16S2H7skQh64ulaiE9LxLdhayMRRiw4zF71cA=;
 b=FMCrW3UvpYUa4jV8t35GErEO20bXhIITcIB6zGZwQ5y5eNexYrE7bGHKo3lZjMCN0O
 WkUzDHDxM2JwYO2afDGNDuoqQEVx0taVr6ml8uPcMw84KrkaHiwB/5UD05EIlxe3Pmle
 h0+/gC75JICsQY/CuOMhHDoWF/bm7PHluLT1C6unisblThqQTT2TrPuhH9mX7k6dz2SO
 lpCnW3wtps3OYYiyEayOpMwnxnivwixdgrNZmLi49NESg+4hiaWLE+8YUDB6pS7IaaZW
 mkERKm74lid7vjsoEaagC/rooy6iKm1IHLa6Y2HufEtKQy0zIczyIOttvlOsOpt97P45
 m1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=e12d2I16S2H7skQh64ulaiE9LxLdhayMRRiw4zF71cA=;
 b=Z8kjn0YIGbIrtXoVNNOx5IFKuGt4CTuHxms3LndodbK5e2dpWNeeboJzLSbMCO9S12
 3kLpHsIIDcT3jAgRtx3yZeFStFqZylaZnLTVc/Xf43R36/dfSVaVVAdLx3ZrJiFEk4yG
 nU1RaJDwgGz3xzssya/GeNVdK9F6pPIkPn3sVek1JwcLD4KNsYgzCFMBZKd4Ymt8NsKa
 0rYOZVB631d5znGlM7QCKaFm9uLzinFPP8p9mevVi6hbSsBqePAMfl4fZXYfHATlCpc7
 zX4kEu97BQxFv5GKaFul3yhLX1Lqojsw/Zt+pObDbuuGzQJnPucplg70ZNW0XVqEp794
 hZ3g==
X-Gm-Message-State: APjAAAWXs6UbSMVaEXJhLuwM0kDKDk5hUdPYq74f5z6atY7w7s3Zw9XE
 0R+meJQrujyMhMQ4Pc4Y+Zimvw==
X-Google-Smtp-Source: APXvYqy+V66UNiSRTxeNlL8bS2nHIhMf+5XwrWhEbCgQSFYuIL8Hea7G6SYB4oX66mh+/z22co/bZQ==
X-Received: by 2002:a63:1e5f:: with SMTP id p31mr11278436pgm.291.1571424766802; 
 Fri, 18 Oct 2019 11:52:46 -0700 (PDT)
Received: from localhost ([152.179.112.46])
 by smtp.gmail.com with ESMTPSA id k23sm6252006pgi.49.2019.10.18.11.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 11:52:46 -0700 (PDT)
Date: Fri, 18 Oct 2019 11:52:46 -0700 (PDT)
X-Google-Original-Date: Fri, 18 Oct 2019 11:46:24 PDT (-0700)
Subject: Re: [PATCH v3 1/2] hw: timer: Add Goldfish RTC device
In-Reply-To: <20191015083459.76959-2-anup.patel@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-25c9d8d6-192a-41f8-849e-0f7cea22a22e@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 sagark@eecs.berkeley.edu, anup@brainfault.org, Anup Patel <Anup.Patel@wdc.com>,
 qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Oct 2019 01:35:31 PDT (-0700), Anup Patel wrote:
> This patch adds model for Google Goldfish virtual platform RTC device.
>
> We will be adding Goldfish RTC device to the QEMU RISC-V virt machine
> for providing real date-time to Guest Linux. The corresponding Linux
> driver for Goldfish RTC device is already available in upstream Linux.
>
> For now, VM migration support is available but untested for Goldfish RTC
> device. It will be hardened in-future when we implement VM migration for
> KVM RISC-V.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  hw/rtc/Kconfig                  |   3 +
>  hw/rtc/Makefile.objs            |   1 +
>  hw/rtc/goldfish_rtc.c           | 278 ++++++++++++++++++++++++++++++++
>  include/hw/timer/goldfish_rtc.h |  46 ++++++
>  4 files changed, 328 insertions(+)
>  create mode 100644 hw/rtc/goldfish_rtc.c
>  create mode 100644 include/hw/timer/goldfish_rtc.h

I'd be happy to take a look at this, but I don't have a hw/rtc directory in my 
QEMU.  IIRC there was a refactoring going on here, is there a tree this is 
based on?

> diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> index 45daa8d655..bafe6ac2c9 100644
> --- a/hw/rtc/Kconfig
> +++ b/hw/rtc/Kconfig
> @@ -21,3 +21,6 @@ config MC146818RTC
>  
>  config SUN4V_RTC
>      bool
> +
> +config GOLDFISH_RTC
> +    bool
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index 8dc9fcd3a9..aa208d0d10 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -11,3 +11,4 @@ common-obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
>  obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
>  common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
>  common-obj-$(CONFIG_ASPEED_SOC) += aspeed_rtc.o
> +common-obj-$(CONFIG_GOLDFISH_RTC) += goldfish_rtc.o
> diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
> new file mode 100644
> index 0000000000..223616ed75
> --- /dev/null
> +++ b/hw/rtc/goldfish_rtc.c
> @@ -0,0 +1,278 @@
> +/*
> + * Goldfish virtual platform RTC
> + *
> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
> + *
> + * For more details on Google Goldfish virtual platform refer:
> + * https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT
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
> +#include "qemu-common.h"
> +#include "hw/timer/goldfish_rtc.h"
> +#include "migration/vmstate.h"
> +#include "hw/irq.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/sysbus.h"
> +#include "qemu/timer.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/cutils.h"
> +#include "qemu/log.h"
> +
> +#define RTC_TIME_LOW            0x00
> +#define RTC_TIME_HIGH           0x04
> +#define RTC_ALARM_LOW           0x08
> +#define RTC_ALARM_HIGH          0x0c
> +#define RTC_IRQ_ENABLED         0x10
> +#define RTC_CLEAR_ALARM         0x14
> +#define RTC_ALARM_STATUS        0x18
> +#define RTC_CLEAR_INTERRUPT     0x1c
> +
> +static void goldfish_rtc_update(GoldfishRTCState *s)
> +{
> +    qemu_set_irq(s->irq, (s->irq_pending & s->irq_enabled) ? 1 : 0);
> +}
> +
> +static void goldfish_rtc_interrupt(void *opaque)
> +{
> +    GoldfishRTCState *s = (GoldfishRTCState *)opaque;
> +
> +    s->alarm_running = 0;
> +    s->irq_pending = 1;
> +    goldfish_rtc_update(s);
> +}
> +
> +static uint64_t goldfish_rtc_get_count(GoldfishRTCState *s)
> +{
> +    return s->tick_offset + (uint64_t)qemu_clock_get_ns(rtc_clock);
> +}
> +
> +static void goldfish_rtc_clear_alarm(GoldfishRTCState *s)
> +{
> +    timer_del(s->timer);
> +    s->alarm_running = 0;
> +}
> +
> +static void goldfish_rtc_set_alarm(GoldfishRTCState *s)
> +{
> +    uint64_t ticks = goldfish_rtc_get_count(s);
> +    uint64_t event = s->alarm_next;
> +
> +    if (event <= ticks) {
> +        goldfish_rtc_clear_alarm(s);
> +        goldfish_rtc_interrupt(s);
> +    } else {
> +        int64_t now = qemu_clock_get_ns(rtc_clock);
> +        timer_mod(s->timer, now + (event - ticks));
> +        s->alarm_running = 1;
> +    }
> +}
> +
> +static uint64_t goldfish_rtc_read(void *opaque, hwaddr offset,
> +                                  unsigned size)
> +{
> +    GoldfishRTCState *s = (GoldfishRTCState *)opaque;
> +    uint64_t r;
> +
> +    switch (offset) {
> +    case RTC_TIME_LOW:
> +        r = goldfish_rtc_get_count(s) & 0xffffffff;
> +        break;
> +    case RTC_TIME_HIGH:
> +        r = goldfish_rtc_get_count(s) >> 32;
> +        break;
> +    case RTC_ALARM_LOW:
> +        r = s->alarm_next & 0xffffffff;
> +        break;
> +    case RTC_ALARM_HIGH:
> +        r = s->alarm_next >> 32;
> +        break;
> +    case RTC_IRQ_ENABLED:
> +        r = s->irq_enabled;
> +        break;
> +    case RTC_ALARM_STATUS:
> +        r = s->alarm_running;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "goldfish_rtc_read: Bad offset 0x%x\n", (int)offset);
> +        r = 0;
> +        break;
> +    }
> +
> +    return r;
> +}
> +
> +static void goldfish_rtc_write(void *opaque, hwaddr offset,
> +                               uint64_t value, unsigned size)
> +{
> +    uint64_t current_tick, new_tick;
> +    GoldfishRTCState *s = (GoldfishRTCState *)opaque;
> +
> +    switch (offset) {
> +    case RTC_TIME_LOW:
> +        current_tick = goldfish_rtc_get_count(s);
> +        new_tick = current_tick & (0xffffffffULL << 32);
> +        new_tick |= value;
> +        s->tick_offset += new_tick - current_tick;
> +        break;
> +    case RTC_TIME_HIGH:
> +        current_tick = goldfish_rtc_get_count(s);
> +        new_tick = current_tick & 0xffffffffULL;
> +        new_tick |= (value << 32);
> +        s->tick_offset += new_tick - current_tick;
> +        break;
> +    case RTC_ALARM_LOW:
> +        s->alarm_next &= (0xffffffffULL << 32);
> +        s->alarm_next |= value;
> +        goldfish_rtc_set_alarm(s);
> +        break;
> +    case RTC_ALARM_HIGH:
> +        s->alarm_next &= 0xffffffffULL;
> +        s->alarm_next |= (value << 32);
> +        break;
> +    case RTC_IRQ_ENABLED:
> +        s->irq_enabled = (uint32_t)(value & 0x1);
> +        goldfish_rtc_update(s);
> +        break;
> +    case RTC_CLEAR_ALARM:
> +        goldfish_rtc_clear_alarm(s);
> +        break;
> +    case RTC_CLEAR_INTERRUPT:
> +        s->irq_pending = 0;
> +        goldfish_rtc_update(s);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "goldfish_rtc_write: Bad offset 0x%x\n", (int)offset);
> +        break;
> +    }
> +}
> +
> +static int goldfish_rtc_pre_save(void *opaque)
> +{
> +    uint64_t delta;
> +    GoldfishRTCState *s = opaque;
> +
> +    /*
> +     * We want to migrate this offset, which sounds straightforward.
> +     * Unfortunately, we cannot directly pass tick_offset because
> +     * rtc_clock on destinetion Host might not be same source Host.
> +     *
> +     * To tackle, this we pass tick_offset relative to vm_clock from
> +     * source Host and make it relative to rtc_clock at destinetion Host.
> +     */
> +    delta = qemu_clock_get_ns(rtc_clock) -
> +            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    s->tick_offset_vmstate = s->tick_offset + delta;
> +
> +    return 0;
> +}
> +
> +static int goldfish_rtc_post_load(void *opaque, int version_id)
> +{
> +    uint64_t delta;
> +    GoldfishRTCState *s = opaque;
> +
> +    /*
> +     * We extract tick_offset from tick_offset_vmstate by doing
> +     * reverse math compared to pre_save() function.
> +     */
> +    delta = qemu_clock_get_ns(rtc_clock) -
> +            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    s->tick_offset = s->tick_offset_vmstate - delta;
> +
> +    return 0;
> +}
> +
> +static const MemoryRegionOps goldfish_rtc_ops = {
> +    .read = goldfish_rtc_read,
> +    .write = goldfish_rtc_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4
> +    }
> +};
> +
> +static const VMStateDescription goldfish_rtc_vmstate = {
> +    .name = TYPE_GOLDFISH_RTC,
> +    .version_id = 1,
> +    .pre_save = goldfish_rtc_pre_save,
> +    .post_load = goldfish_rtc_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64(tick_offset_vmstate, GoldfishRTCState),
> +        VMSTATE_UINT64(alarm_next, GoldfishRTCState),
> +        VMSTATE_UINT32(alarm_running, GoldfishRTCState),
> +        VMSTATE_UINT32(irq_pending, GoldfishRTCState),
> +        VMSTATE_UINT32(irq_enabled, GoldfishRTCState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void goldfish_rtc_reset(DeviceState *dev)
> +{
> +    GoldfishRTCState *s = GOLDFISH_RTC(dev);
> +    struct tm tm;
> +
> +    timer_del(s->timer);
> +
> +    qemu_get_timedate(&tm, 0);
> +    s->tick_offset = mktimegm(&tm);
> +    s->tick_offset *= NANOSECONDS_PER_SECOND;
> +    s->tick_offset -= qemu_clock_get_ns(rtc_clock);
> +    s->tick_offset_vmstate = 0;
> +    s->alarm_next = 0;
> +    s->alarm_running = 0;
> +    s->irq_pending = 0;
> +    s->irq_enabled = 0;
> +}
> +
> +static void goldfish_rtc_realize(DeviceState *d, Error **errp)
> +{
> +    SysBusDevice *dev = SYS_BUS_DEVICE(d);
> +    GoldfishRTCState *s = GOLDFISH_RTC(d);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &goldfish_rtc_ops, s,
> +                          "goldfish_rtc", 0x1000);
> +    sysbus_init_mmio(dev, &s->iomem);
> +
> +    sysbus_init_irq(dev, &s->irq);
> +
> +    s->timer = timer_new_ns(rtc_clock, goldfish_rtc_interrupt, s);
> +}
> +
> +static void goldfish_rtc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = goldfish_rtc_realize;
> +    dc->reset = goldfish_rtc_reset;
> +    dc->vmsd = &goldfish_rtc_vmstate;
> +}
> +
> +static const TypeInfo goldfish_rtc_info = {
> +    .name          = TYPE_GOLDFISH_RTC,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(GoldfishRTCState),
> +    .class_init    = goldfish_rtc_class_init,
> +};
> +
> +static void goldfish_rtc_register_types(void)
> +{
> +    type_register_static(&goldfish_rtc_info);
> +}
> +
> +type_init(goldfish_rtc_register_types)
> diff --git a/include/hw/timer/goldfish_rtc.h b/include/hw/timer/goldfish_rtc.h
> new file mode 100644
> index 0000000000..dfb6d70b86
> --- /dev/null
> +++ b/include/hw/timer/goldfish_rtc.h
> @@ -0,0 +1,46 @@
> +/*
> + * Goldfish virtual platform RTC
> + *
> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
> + *
> + * For more details on Google Goldfish virtual platform refer:
> + * https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT
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
> +#ifndef HW_TIMER_GOLDFISH_RTC_H
> +#define HW_TIMER_GOLDFISH_RTC_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_GOLDFISH_RTC "goldfish_rtc"
> +#define GOLDFISH_RTC(obj) \
> +OBJECT_CHECK(GoldfishRTCState, (obj), TYPE_GOLDFISH_RTC)
> +
> +typedef struct GoldfishRTCState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +    QEMUTimer *timer;
> +    qemu_irq irq;
> +
> +    uint64_t tick_offset;
> +    uint64_t tick_offset_vmstate;
> +    uint64_t alarm_next;
> +    uint32_t alarm_running;
> +    uint32_t irq_pending;
> +    uint32_t irq_enabled;
> +} GoldfishRTCState;
> +
> +#endif
> -- 
> 2.17.1

