Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFD9C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 21:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149B221527
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 21:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYTUPYW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149B221527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMHPo-0008FQ-St
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 17:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMHOG-0006y8-Al; Sat, 26 Sep 2020 17:05:56 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMHOC-0005Jf-Nu; Sat, 26 Sep 2020 17:05:55 -0400
Received: by mail-wr1-x442.google.com with SMTP id k15so7566238wrn.10;
 Sat, 26 Sep 2020 14:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hPeQ+JT8pw8kz+uaPyyNGDdxkQPDBkBAUqVu7IeF5WY=;
 b=dYTUPYW9W4fYAsVl+vhiiyvtxCDGVJwGJdJZS/4QfUvpT/a1V19q7QlbY3lt6Wb5Sb
 pU6QvJRzDQjzeDU/gtAEvgn7Z02zjZTy3I9od6PP8Sf2eO8oMoyp/qlxoPGEbWIJtcnh
 PEdqO2/NFayfr2QuhOEhjAxX9guObvVSt+xcud0dbJAdkG6rUgwBvtGtRKeXSCssfYe8
 LWEw9KJtdyYVtEIvYk7+aYgXyfhJbMoB16jmMyyFzEjqK0oR3rycUQmn2fMqOJvRvgmZ
 8QVopKEbr+xxCM+ZLrM2el5RHtnQtnnfpOG33q87CcemzkpcaL4CRX1z9wW7Ig79Y0tL
 WEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hPeQ+JT8pw8kz+uaPyyNGDdxkQPDBkBAUqVu7IeF5WY=;
 b=kKCyhm72xBW2UB6DBTRqAYWEcBGuhq9pdR9GQ2jHLB/eZV9i1fj0LsqzcR8e0oMPih
 +QtiL6mViyFj4zYYyRV6vEqqlDa6Wq7E8vezkIC/0ILvILKC1Sb8COgOHe5adSBg/1j3
 jzZ0tPHivk9b6F4LBUhBjBAi68Bx/MJnc9T349IurpJIQ9CjVfU+q0TSrbeOJNlqr9xw
 s2S0g89HQws6iOENOYmkasrPGNsvL4ZE+Sc0fz+6c/Pt4mMqtV8PbinzLVx0uUh7fGmo
 tBln9Kf8A+zekwr7ag18wZ3GirfN0FtzKoloMVH1SFVG58Vl/LkQIVieJGkmFHTP4DEP
 BW/A==
X-Gm-Message-State: AOAM530YP6g0UCO98wPuXy5SeVZos+F08NDWcy+BtfRwVCyZ2V2BJCqa
 8sPie9HTlWaHWthVCUOaXn4=
X-Google-Smtp-Source: ABdhPJyzfbzk6TEUvOvC93H3BQvvbDr2L6k7wHrIQReS8dCqETE80awUZ0MEDstBECYzn1I/aBGpEQ==
X-Received: by 2002:adf:ea44:: with SMTP id j4mr10927552wrn.368.1601154350156; 
 Sat, 26 Sep 2020 14:05:50 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id d23sm3587298wmb.6.2020.09.26.14.05.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 14:05:49 -0700 (PDT)
Subject: Re: [PATCH 04/14] hw/arm/raspi: add a skeleton implementation of the
 cprman
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20200925101731.2159827-1-luc@lmichel.fr>
 <20200925101731.2159827-5-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <85ccb491-8d4a-caf3-595d-7415471f5dc7@amsat.org>
Date: Sat, 26 Sep 2020 23:05:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925101731.2159827-5-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.213,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 12:17 PM, Luc Michel wrote:
> The BCM2835 cprman is the clock manager of the SoC. It is composed of a

Can we use CPRMAN in caps?

> main oscillator, and several sub-components (PLLs, multiplexers, ...) to
> generate the BCM2835 clock tree.
> 
> This commit adds a skeleton of the cprman, with a dummy register
> read/write implementation. It embeds the main oscillator (xosc) from
> which all the clocks will be derived.
> 
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
>  include/hw/arm/bcm2835_peripherals.h       |   3 +-
>  include/hw/misc/bcm2835_cprman.h           |  37 +++++
>  include/hw/misc/bcm2835_cprman_internals.h |  24 +++
>  hw/arm/bcm2835_peripherals.c               |  11 +-
>  hw/misc/bcm2835_cprman.c                   | 171 +++++++++++++++++++++
>  hw/misc/meson.build                        |   1 +
>  hw/misc/trace-events                       |   5 +
>  7 files changed, 250 insertions(+), 2 deletions(-)
>  create mode 100644 include/hw/misc/bcm2835_cprman.h
>  create mode 100644 include/hw/misc/bcm2835_cprman_internals.h
>  create mode 100644 hw/misc/bcm2835_cprman.c
> 
> diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
> index 199088425a..002bb5e73b 100644
> --- a/include/hw/arm/bcm2835_peripherals.h
> +++ b/include/hw/arm/bcm2835_peripherals.h
> @@ -21,10 +21,11 @@
>  #include "hw/misc/bcm2835_property.h"
>  #include "hw/misc/bcm2835_rng.h"
>  #include "hw/misc/bcm2835_mbox.h"
>  #include "hw/misc/bcm2835_mphi.h"
>  #include "hw/misc/bcm2835_thermal.h"
> +#include "hw/misc/bcm2835_cprman.h"
>  #include "hw/sd/sdhci.h"
>  #include "hw/sd/bcm2835_sdhost.h"
>  #include "hw/gpio/bcm2835_gpio.h"
>  #include "hw/timer/bcm2835_systmr.h"
>  #include "hw/usb/hcd-dwc2.h"
> @@ -45,11 +46,11 @@ struct BCM2835PeripheralState {
>  
>      BCM2835SystemTimerState systmr;
>      BCM2835MphiState mphi;
>      UnimplementedDeviceState armtmr;
>      UnimplementedDeviceState powermgt;
> -    UnimplementedDeviceState cprman;
> +    BCM2835CprmanState cprman;
>      PL011State uart0;
>      BCM2835AuxState aux;
>      BCM2835FBState fb;
>      BCM2835DMAState dma;
>      BCM2835ICState ic;
> diff --git a/include/hw/misc/bcm2835_cprman.h b/include/hw/misc/bcm2835_cprman.h
> new file mode 100644
> index 0000000000..de9bd01b23
> --- /dev/null
> +++ b/include/hw/misc/bcm2835_cprman.h
> @@ -0,0 +1,37 @@
> +/*
> + * BCM2835 cprman clock manager
> + *
> + * Copyright (c) 2020 Luc Michel <luc@lmichel.fr>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_MISC_CPRMAN_H
> +#define HW_MISC_CPRMAN_H
> +
> +#include "hw/sysbus.h"
> +#include "hw/qdev-clock.h"
> +
> +#define TYPE_BCM2835_CPRMAN "bcm2835-cprman"
> +
> +typedef struct BCM2835CprmanState BCM2835CprmanState;
> +
> +DECLARE_INSTANCE_CHECKER(BCM2835CprmanState, CPRMAN,
> +                         TYPE_BCM2835_CPRMAN)
> +
> +#define CPRMAN_NUM_REGS (0x2000 / sizeof(uint32_t))
> +
> +struct BCM2835CprmanState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    MemoryRegion iomem;
> +
> +    uint32_t regs[CPRMAN_NUM_REGS];
> +    uint32_t xosc_freq;
> +
> +    Clock *xosc;
> +};
> +
> +#endif
> diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
> new file mode 100644
> index 0000000000..6a10b60930
> --- /dev/null
> +++ b/include/hw/misc/bcm2835_cprman_internals.h
> @@ -0,0 +1,24 @@
> +/*
> + * BCM2835 cprman clock manager
> + *
> + * Copyright (c) 2020 Luc Michel <luc@lmichel.fr>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_MISC_CPRMAN_INTERNALS_H
> +#define HW_MISC_CPRMAN_INTERNALS_H
> +
> +#include "hw/registerfields.h"
> +#include "hw/misc/bcm2835_cprman.h"
> +
> +/* Register map */
> +
> +/*
> + * This field is common to all registers. Each register write value must match
> + * the CPRMAN_PASSWORD magic value in its 8 MSB.
> + */
> +FIELD(CPRMAN, PASSWORD, 24, 8)
> +#define CPRMAN_PASSWORD 0x5a

s/PASSWORD/KEY/?

> +
> +#endif
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index f0802c91e0..958aadeeb9 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -119,10 +119,13 @@ static void bcm2835_peripherals_init(Object *obj)
>      object_initialize_child(obj, "mphi", &s->mphi, TYPE_BCM2835_MPHI);
>  
>      /* DWC2 */
>      object_initialize_child(obj, "dwc2", &s->dwc2, TYPE_DWC2_USB);
>  
> +    /* CPRMAN clock manager */
> +    object_initialize_child(obj, "cprman", &s->cprman, TYPE_BCM2835_CPRMAN);
> +
>      object_property_add_const_link(OBJECT(&s->dwc2), "dma-mr",
>                                     OBJECT(&s->gpu_bus_mr));
>  }
>  
>  static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
> @@ -158,10 +161,17 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>      /* Interrupt Controller */
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->ic), errp)) {
>          return;
>      }
>  
> +    /* CPRMAN clock manager */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cprman), errp)) {
> +        return;
> +    }
> +    memory_region_add_subregion(&s->peri_mr, CPRMAN_OFFSET,
> +                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cprman), 0));
> +
>      memory_region_add_subregion(&s->peri_mr, ARMCTRL_IC_OFFSET,
>                  sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ic), 0));
>      sysbus_pass_irq(SYS_BUS_DEVICE(s), SYS_BUS_DEVICE(&s->ic));
>  
>      /* Sys Timer */
> @@ -343,11 +353,10 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>          qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
>                                 INTERRUPT_USB));
>  
>      create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
>      create_unimp(s, &s->powermgt, "bcm2835-powermgt", PM_OFFSET, 0x114);
> -    create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x2000);
>      create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
>      create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
>      create_unimp(s, &s->spi[0], "bcm2835-spi0", SPI0_OFFSET, 0x20);
>      create_unimp(s, &s->bscsl, "bcm2835-spis", BSC_SL_OFFSET, 0x100);
>      create_unimp(s, &s->i2c[0], "bcm2835-i2c0", BSC0_OFFSET, 0x20);
> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> new file mode 100644
> index 0000000000..d2ea0c9236
> --- /dev/null
> +++ b/hw/misc/bcm2835_cprman.c
> @@ -0,0 +1,171 @@
> +/*
> + * BCM2835 cprman clock manager
> + *
> + * Copyright (c) 2020 Luc Michel <luc@lmichel.fr>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +/*
> + * This peripheral is roughly divided into 3 main parts:
> + *   - the PLLs
> + *   - the PLL channels
> + *   - the clock muxes
> + *
> + * A main oscillator (xosc) feeds all the PLLs. Each PLLs has one or more
> + * channels. Those channel are then connected to the clock muxes. Each mux has
> + * multiples sources (usually the xosc, some of the PLL channels and some "test
> + * debug" clocks). It can selects one or the other through a control register.

"It" is unclear (to me) in this sentence. Assuming the mux.

> + * Each mux has one output clock that also goes out of the CPRMAN. It usually

Here is "It" the mux or the output clock? Assuming the mux.

> + * connects to another peripheral in the SoC (so a given mux is dedicated to a
> + * peripheral).
> + *
> + * At each level (PLL, channel and mux), the clock can be altered through
> + * dividers (and multipliers in case of the PLLs), and can be disabled (in this
> + * case, the next levels see no clock).
> + *
> + * This can be sum-up as follows (this is an example and not the actual BCM2835
> + * clock tree):
> + *
> + *          /-->[PLL]-|->[PLL channel]--...            [mux]--> to peripherals
> + *          |         |->[PLL channel]  muxes takes    [mux]
> + *          |         \->[PLL channel]  inputs from    [mux]
> + *          |                           some channels  [mux]
> + * [xosc]---|-->[PLL]-|->[PLL channel]  and other srcs [mux]
> + *          |         \->[PLL channel]           ...-->[mux]
> + *          |                                          [mux]
> + *          \-->[PLL]--->[PLL channel]                 [mux]
> + *
> + * The page at https://elinux.org/The_Undocumented_Pi gives the actual clock
> + * tree configuration.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "migration/vmstate.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/misc/bcm2835_cprman.h"
> +#include "hw/misc/bcm2835_cprman_internals.h"
> +#include "trace.h"
> +
> +/* CPRMAN "top level" model */
> +
> +static uint64_t cprman_read(void *opaque, hwaddr offset,
> +                                    unsigned size)

Indent off.

> +{
> +    BCM2835CprmanState *s = CPRMAN(opaque);
> +    uint64_t r = 0;
> +    size_t idx = offset / sizeof(uint32_t);
> +
> +    switch (idx) {
> +    default:
> +        r = s->regs[idx];
> +    }
> +
> +    trace_bcm2835_cprman_read(offset, r);
> +    return r;
> +}
> +
> +static void cprman_write(void *opaque, hwaddr offset,
> +                         uint64_t value, unsigned size)
> +{
> +    BCM2835CprmanState *s = CPRMAN(opaque);
> +    size_t idx = offset / sizeof(uint32_t);
> +
> +    if (FIELD_EX32(value, CPRMAN, PASSWORD) != CPRMAN_PASSWORD) {
> +        trace_bcm2835_cprman_write_invalid_magic(offset, value);
> +        return;
> +    }
> +
> +    value &= ~R_CPRMAN_PASSWORD_MASK;
> +
> +    trace_bcm2835_cprman_write(offset, value);
> +    s->regs[idx] = value;
> +
> +}
> +
> +static const MemoryRegionOps cprman_ops = {
> +    .read = cprman_read,
> +    .write = cprman_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid      = {
> +        .min_access_size        = 4,
> +        .max_access_size        = 4,

I couldn't find this in the public datasheets (any pointer?).

Since your implementation is 32bit, can you explicit .impl
min/max = 4?

> +        .unaligned              = false,
> +    },
> +};
> +
> +static void cprman_reset(DeviceState *dev)
> +{
> +    BCM2835CprmanState *s = CPRMAN(dev);
> +
> +    memset(s->regs, 0, sizeof(s->regs));
> +
> +    clock_update_hz(s->xosc, s->xosc_freq);
> +}
> +
> +static Clock *init_internal_clock(BCM2835CprmanState *s,
> +                                  const char *name)

Interesting. Shouldn't this be a public function from the
Clock API? (Taking Object + name arguments)?

> +{
> +    Object *obj;
> +    Clock *clk;
> +
> +    obj = object_new(TYPE_CLOCK);
> +    object_property_add_child(OBJECT(s), name, obj);
> +    object_unref(obj);
> +
> +    clk = CLOCK(obj);
> +    clock_setup_canonical_path(clk);
> +
> +    return clk;
> +}
> +
> +static void cprman_init(Object *obj)
> +{
> +    BCM2835CprmanState *s = CPRMAN(obj);
> +
> +    s->xosc = init_internal_clock(s, "xosc");
> +
> +    memory_region_init_io(&s->iomem, obj, &cprman_ops,
> +                          s, "bcm2835-cprman", 0x2000);

Again assuming this is a 8KB MMIO device:

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
> +}
> +
> +static const VMStateDescription cprman_vmstate = {
> +    .name = TYPE_BCM2835_CPRMAN,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, BCM2835CprmanState, CPRMAN_NUM_REGS),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static Property cprman_properties[] = {
> +    DEFINE_PROP_UINT32("xosc-freq", BCM2835CprmanState, xosc_freq, 19200000),

Eventually "xosc-freq-hz".

> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
> +static void cprman_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = cprman_reset;
> +    dc->vmsd = &cprman_vmstate;
> +    device_class_set_props(dc, cprman_properties);
> +}
> +
> +static const TypeInfo cprman_info = {
> +    .name = TYPE_BCM2835_CPRMAN,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(BCM2835CprmanState),
> +    .class_init = cprman_class_init,
> +    .instance_init = cprman_init,
> +};
> +
> +static void cprman_register_types(void)
> +{
> +    type_register_static(&cprman_info);
> +}
> +
> +type_init(cprman_register_types);
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 793d45b1dc..c94cf70e82 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -71,10 +71,11 @@ softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files(
>    'bcm2835_mbox.c',
>    'bcm2835_mphi.c',
>    'bcm2835_property.c',
>    'bcm2835_rng.c',
>    'bcm2835_thermal.c',
> +  'bcm2835_cprman.c',
>  ))
>  softmmu_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
>  softmmu_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c', 'zynq-xadc.c'))
>  softmmu_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true: files('stm32f2xx_syscfg.c'))
>  softmmu_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_true: files('stm32f4xx_syscfg.c'))
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 6054f9adf3..d718a2b177 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -224,5 +224,10 @@ grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0x%03"PRIx6
>  grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx64" data:0x%08x"
>  
>  # pca9552.c
>  pca955x_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
>  pca955x_gpio_change(const char *description, unsigned id, unsigned prev_state, unsigned current_state) "%s GPIO id:%u status: %u -> %u"
> +
> +# bcm2835_cprman.c
> +bcm2835_cprman_read(uint64_t offset, uint64_t value) "offset:0x%" PRIx64 " value:0x%" PRIx64
> +bcm2835_cprman_write(uint64_t offset, uint64_t value) "offset:0x%" PRIx64 " value:0x%" PRIx64
> +bcm2835_cprman_write_invalid_magic(uint64_t offset, uint64_t value) "offset:0x%" PRIx64 " value:0x%" PRIx64
> 

