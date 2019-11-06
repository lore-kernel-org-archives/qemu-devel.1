Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1114C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 06:40:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E36207FA
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 06:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="JqN2Got0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E36207FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSEzx-0008Am-Oy
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 01:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anup@brainfault.org>) id 1iSEzE-0007cu-FN
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 01:40:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anup@brainfault.org>) id 1iSEzC-0005Jn-4i
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 01:40:12 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <anup@brainfault.org>) id 1iSEzB-0005FV-LL
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 01:40:10 -0500
Received: by mail-wm1-x344.google.com with SMTP id z19so1988150wmk.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 22:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rXPAvuBM7fM9vyxXDkZWhCmmonxA4T0AHDIVx4wOKJA=;
 b=JqN2Got0QRBzj7Hf9pgX4xIJMfw/KDcZilgNmixGxw7enHHvB4yU9CrLdW1G659+DM
 Hch5sm5SdhaLnWAMTXV0aLGD7YuP11OkEXRnL87pBBheEaJCBxguo7C6OKEEjjZTWw2b
 xUOwo88WnwjtZzlNkkk+zFqnzCxxnvT3SoZhSa+sb7GP2uAJxMUvguXEalHhSnMof+ut
 yFkQjgn8I3Bp9xp664WMKuC7vXwWbOLvhDTO8W2cHJS47i98PospayNxY27KYDzDYPVH
 gvbRtAphNLozPopZC8huls+vyaGMIw4LZBnmMrimRESYJvn69cLcWRFqHS4iH8EzwjeQ
 xkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rXPAvuBM7fM9vyxXDkZWhCmmonxA4T0AHDIVx4wOKJA=;
 b=Xz8nr2dTuX0FU5Cs/ADVJZ1sVRWdlr/cJE04XzWzw4Dj+xvWZduFlx5PpoLnA8OXGu
 sXGold8XRmEZbvDNtXbVEO2zd+DRQ611K9qI6U1PKxHQN3hEM9DBt5SErQCVLBRY5zgY
 FBSissRHe5PmVXbumbuIYa5o+VDL32ca/xzHS0kTUCi3o3VgtuM+st2icc97dkE7GOio
 NhJgN5+LmMKxoUPHqT7b3C8UeVIhEia5Yg3xKTL8CaqQtcbgN35ZnF869eWeauoTKhac
 QAC7fAqgESPQQqkDh/OH6WHGbvClM9GdQl6pC3TKGYXTn3VXsRI8qF6jh/hS2dwMEef8
 bm+w==
X-Gm-Message-State: APjAAAXDoiPMY5xf0bkTEG6ICpf+3Amm3zpGaNZXssJVYsFRX6lXRU50
 kq9Rz8bfriWwJjSRV0biZqBaIORjwOvlXHnbxzF33g==
X-Google-Smtp-Source: APXvYqwJYnnpya75Q3WzGzidxY3bumBjFmnwDIDWxwUgido9QpTnA/rzLsJAlCZVVZpI2+0fwb7uBIniKBXsuZhZ76U=
X-Received: by 2002:a1c:e386:: with SMTP id a128mr947392wmh.52.1573022407434; 
 Tue, 05 Nov 2019 22:40:07 -0800 (PST)
MIME-Version: 1.0
References: <20191103075353.86497-1-anup.patel@wdc.com>
 <20191103075353.86497-2-anup.patel@wdc.com>
 <c095f5d9-372e-8b3c-9bfb-ca7569e31830@redhat.com>
In-Reply-To: <c095f5d9-372e-8b3c-9bfb-ca7569e31830@redhat.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 6 Nov 2019 12:09:55 +0530
Message-ID: <CAAhSdy3wixKV_i38gN1nnOQbTKJQY-nX=VvqTnpCuG9g7uVU2w@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] hw: rtc: Add Goldfish RTC device
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anup Patel <Anup.Patel@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 6, 2019 at 4:54 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Hi Anup,
>
> On 11/3/19 8:55 AM, Anup Patel wrote:
> > This patch adds model for Google Goldfish virtual platform RTC device.
> >
> > We will be adding Goldfish RTC device to the QEMU RISC-V virt machine
> > for providing real date-time to Guest Linux. The corresponding Linux
> > driver for Goldfish RTC device is already available in upstream Linux.
> >
> > For now, VM migration support is available but untested for Goldfish RT=
C
> > device. It will be hardened in-future when we implement VM migration fo=
r
> > KVM RISC-V.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   hw/rtc/Kconfig                |   3 +
> >   hw/rtc/Makefile.objs          |   1 +
> >   hw/rtc/goldfish_rtc.c         | 288 +++++++++++++++++++++++++++++++++=
+
> >   hw/rtc/trace-events           |   4 +
> >   include/hw/rtc/goldfish_rtc.h |  46 ++++++
>
> Correct path, thanks :)
>
> >   5 files changed, 342 insertions(+)
> >   create mode 100644 hw/rtc/goldfish_rtc.c
> >   create mode 100644 include/hw/rtc/goldfish_rtc.h
> >
> > diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> > index 45daa8d655..bafe6ac2c9 100644
> > --- a/hw/rtc/Kconfig
> > +++ b/hw/rtc/Kconfig
> > @@ -21,3 +21,6 @@ config MC146818RTC
> >
> >   config SUN4V_RTC
> >       bool
> > +
> > +config GOLDFISH_RTC
> > +    bool
> > diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> > index 8dc9fcd3a9..aa208d0d10 100644
> > --- a/hw/rtc/Makefile.objs
> > +++ b/hw/rtc/Makefile.objs
> > @@ -11,3 +11,4 @@ common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_rtc.o
> >   obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
> >   common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
> >   common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_rtc.o
> > +common-obj-$(CONFIG_GOLDFISH_RTC) +=3D goldfish_rtc.o
> > diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
> > new file mode 100644
> > index 0000000000..f71f6eaab0
> > --- /dev/null
> > +++ b/hw/rtc/goldfish_rtc.c
> > @@ -0,0 +1,288 @@
> > +/*
> > + * Goldfish virtual platform RTC
> > + *
> > + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
> > + *
> > + * For more details on Google Goldfish virtual platform refer:
> > + * https://android.googlesource.com/platform/external/qemu/+/master/do=
cs/GOLDFISH-VIRTUAL-HARDWARE.TXT
>
> I'd use a (fixed) release tag, and not the (unstable) master branch:
>
> https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-=
2.0-release/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT

Sure, I will update the URL.

>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2 or later, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but WITH=
OUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License a=
long with
> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu-common.h"
> > +#include "hw/rtc/goldfish_rtc.h"
> > +#include "migration/vmstate.h"
> > +#include "hw/irq.h"
> > +#include "hw/qdev-properties.h"
> > +#include "hw/sysbus.h"
> > +#include "qemu/timer.h"
> > +#include "sysemu/sysemu.h"
> > +#include "qemu/cutils.h"
> > +#include "qemu/log.h"
> > +
> > +#include "trace.h"
> > +
> > +#define RTC_TIME_LOW            0x00
> > +#define RTC_TIME_HIGH           0x04
> > +#define RTC_ALARM_LOW           0x08
> > +#define RTC_ALARM_HIGH          0x0c
> > +#define RTC_IRQ_ENABLED         0x10
> > +#define RTC_CLEAR_ALARM         0x14
> > +#define RTC_ALARM_STATUS        0x18
> > +#define RTC_CLEAR_INTERRUPT     0x1c
> > +
> > +static void goldfish_rtc_update(GoldfishRTCState *s)
> > +{
> > +    qemu_set_irq(s->irq, (s->irq_pending & s->irq_enabled) ? 1 : 0);
> > +}
> > +
> > +static void goldfish_rtc_interrupt(void *opaque)
> > +{
> > +    GoldfishRTCState *s =3D (GoldfishRTCState *)opaque;
> > +
> > +    s->alarm_running =3D 0;
> > +    s->irq_pending =3D 1;
> > +    goldfish_rtc_update(s);
> > +}
> > +
> > +static uint64_t goldfish_rtc_get_count(GoldfishRTCState *s)
> > +{
> > +    return s->tick_offset + (uint64_t)qemu_clock_get_ns(rtc_clock);
> > +}
> > +
> > +static void goldfish_rtc_clear_alarm(GoldfishRTCState *s)
> > +{
> > +    timer_del(s->timer);
> > +    s->alarm_running =3D 0;
> > +}
> > +
> > +static void goldfish_rtc_set_alarm(GoldfishRTCState *s)
> > +{
> > +    uint64_t ticks =3D goldfish_rtc_get_count(s);
> > +    uint64_t event =3D s->alarm_next;
> > +
> > +    if (event <=3D ticks) {
> > +        goldfish_rtc_clear_alarm(s);
> > +        goldfish_rtc_interrupt(s);
> > +    } else {
> > +        /*
> > +         * We should be setting timer expiry to:
> > +         *     qemu_clock_get_ns(rtc_clock) + (event - ticks)
> > +         * but this is equivalent to:
> > +         *     event - s->tick_offset
> > +         */
> > +        timer_mod(s->timer, event - s->tick_offset);
> > +        s->alarm_running =3D 1;
> > +    }
> > +}
> > +
> > +static uint64_t goldfish_rtc_read(void *opaque, hwaddr offset,
> > +                                  unsigned size)
> > +{
> > +    GoldfishRTCState *s =3D opaque;
> > +    uint64_t r =3D 0;
> > +
> > +    switch (offset) {
> > +    case RTC_TIME_LOW:
> > +        r =3D goldfish_rtc_get_count(s) & 0xffffffff;
> > +        break;
> > +    case RTC_TIME_HIGH:
> > +        r =3D goldfish_rtc_get_count(s) >> 32;
> > +        break;
> > +    case RTC_ALARM_LOW:
> > +        r =3D s->alarm_next & 0xffffffff;
> > +        break;
> > +    case RTC_ALARM_HIGH:
> > +        r =3D s->alarm_next >> 32;
> > +        break;
> > +    case RTC_IRQ_ENABLED:
> > +        r =3D s->irq_enabled;
> > +        break;
> > +    case RTC_ALARM_STATUS:
> > +        r =3D s->alarm_running;
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Bad offset 0x%x\n", __func__, (uint32_t)off=
set);
>
> Hmm 0x20 is UNIMP.

Sure, I will update.

>
> > +        break;
> > +    }
> > +
> > +    trace_goldfish_rtc_read(offset, r);
> > +
> > +    return r;
> > +}
> > +
> > +static void goldfish_rtc_write(void *opaque, hwaddr offset,
> > +                               uint64_t value, unsigned size)
> > +{
> > +    GoldfishRTCState *s =3D opaque;
> > +    uint64_t current_tick, new_tick;
> > +
> > +    switch (offset) {
> > +    case RTC_TIME_LOW:
> > +        current_tick =3D goldfish_rtc_get_count(s);
>
> FYI, this 2 lines ...:
>
> > +        new_tick =3D current_tick & (0xffffffffULL << 32);
> > +        new_tick |=3D value;
>
> ... can also be written as:
>
>             new_tick =3D deposit64(current_tick, 0, 32, value);
>
> (I find this notation easier to review).

Sure, I will use deposite64() here and everywhere below.

Thanks for this suggestion.

>
> > +        s->tick_offset +=3D new_tick - current_tick;
> > +        break;
> > +    case RTC_TIME_HIGH:
> > +        current_tick =3D goldfish_rtc_get_count(s);
> > +        new_tick =3D current_tick & 0xffffffffULL;
> > +        new_tick |=3D (value << 32);
> > +        s->tick_offset +=3D new_tick - current_tick;
> > +        break;
> > +    case RTC_ALARM_LOW:
> > +        s->alarm_next &=3D (0xffffffffULL << 32);
> > +        s->alarm_next |=3D value;
> > +        goldfish_rtc_set_alarm(s);
> > +        break;
> > +    case RTC_ALARM_HIGH:
>
> Ditto these ...
>
> > +        s->alarm_next &=3D 0xffffffffULL;
> > +        s->alarm_next |=3D (value << 32);
>
> ... as:
>
>             s->alarm_next =3D deposit64(s->alarm_next, 32, 32, value);
>
> > +        break;
> > +    case RTC_IRQ_ENABLED:
> > +        s->irq_enabled =3D (uint32_t)(value & 0x1);
> > +        goldfish_rtc_update(s);
> > +        break;
> > +    case RTC_CLEAR_ALARM:
> > +        goldfish_rtc_clear_alarm(s);
> > +        break;
> > +    case RTC_CLEAR_INTERRUPT:
> > +        s->irq_pending =3D 0;
> > +        goldfish_rtc_update(s);
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Bad offset 0x%x\n", __func__, (uint32_t)off=
set);
>
> 0x20 is UNIMP.
>
> > +        break;
> > +    }
> > +
> > +    trace_goldfish_rtc_write(offset, value);
> > +}
> > +
> > +static int goldfish_rtc_pre_save(void *opaque)
> > +{
> > +    uint64_t delta;
> > +    GoldfishRTCState *s =3D opaque;
> > +
> > +    /*
> > +     * We want to migrate this offset, which sounds straightforward.
> > +     * Unfortunately, we cannot directly pass tick_offset because
> > +     * rtc_clock on destination Host might not be same source Host.
> > +     *
> > +     * To tackle, this we pass tick_offset relative to vm_clock from
> > +     * source Host and make it relative to rtc_clock at destination Ho=
st.
>
> Hmm this is the fix from commit 032cfe6a79c.
>
> > +     */
> > +    delta =3D qemu_clock_get_ns(rtc_clock) -
> > +            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > +    s->tick_offset_vmstate =3D s->tick_offset + delta;
> > +
> > +    return 0;
> > +}
> > +
> > +static int goldfish_rtc_post_load(void *opaque, int version_id)
> > +{
> > +    uint64_t delta;
> > +    GoldfishRTCState *s =3D opaque;
> > +
> > +    /*
> > +     * We extract tick_offset from tick_offset_vmstate by doing
> > +     * reverse math compared to pre_save() function.
> > +     */
> > +    delta =3D qemu_clock_get_ns(rtc_clock) -
> > +            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > +    s->tick_offset =3D s->tick_offset_vmstate - delta;
> > +
> > +    return 0;
> > +}
> > +
> > +static const MemoryRegionOps goldfish_rtc_ops =3D {
> > +    .read =3D goldfish_rtc_read,
> > +    .write =3D goldfish_rtc_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4
>
> OK.
>
> > +    }
> > +};
> > +
> > +static const VMStateDescription goldfish_rtc_vmstate =3D {
> > +    .name =3D TYPE_GOLDFISH_RTC,
> > +    .version_id =3D 1,
> > +    .pre_save =3D goldfish_rtc_pre_save,
> > +    .post_load =3D goldfish_rtc_post_load,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT64(tick_offset_vmstate, GoldfishRTCState),
> > +        VMSTATE_UINT64(alarm_next, GoldfishRTCState),
> > +        VMSTATE_UINT32(alarm_running, GoldfishRTCState),
> > +        VMSTATE_UINT32(irq_pending, GoldfishRTCState),
> > +        VMSTATE_UINT32(irq_enabled, GoldfishRTCState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static void goldfish_rtc_reset(DeviceState *dev)
> > +{
> > +    GoldfishRTCState *s =3D GOLDFISH_RTC(dev);
> > +    struct tm tm;
> > +
> > +    timer_del(s->timer);
> > +
> > +    qemu_get_timedate(&tm, 0);
> > +    s->tick_offset =3D mktimegm(&tm);
> > +    s->tick_offset *=3D NANOSECONDS_PER_SECOND;
> > +    s->tick_offset -=3D qemu_clock_get_ns(rtc_clock);
> > +    s->tick_offset_vmstate =3D 0;
> > +    s->alarm_next =3D 0;
> > +    s->alarm_running =3D 0;
> > +    s->irq_pending =3D 0;
> > +    s->irq_enabled =3D 0;
> > +}
> > +
> > +static void goldfish_rtc_realize(DeviceState *d, Error **errp)
> > +{
> > +    SysBusDevice *dev =3D SYS_BUS_DEVICE(d);
> > +    GoldfishRTCState *s =3D GOLDFISH_RTC(d);
> > +
> > +    memory_region_init_io(&s->iomem, OBJECT(s), &goldfish_rtc_ops, s,
> > +                          "goldfish_rtc", 0x1000);
>
> The spec says this device's io region is 0x24 bytes. 0x1000 might be
> your SoC mapping. Restricting it to the spec allow other targets to use
> this device.

Sure, I will update this.

>
> > +    sysbus_init_mmio(dev, &s->iomem);
> > +
> > +    sysbus_init_irq(dev, &s->irq);
> > +
> > +    s->timer =3D timer_new_ns(rtc_clock, goldfish_rtc_interrupt, s);
> > +}
> > +
> > +static void goldfish_rtc_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->realize =3D goldfish_rtc_realize;
> > +    dc->reset =3D goldfish_rtc_reset;
> > +    dc->vmsd =3D &goldfish_rtc_vmstate;
> > +}
> > +
> > +static const TypeInfo goldfish_rtc_info =3D {
> > +    .name          =3D TYPE_GOLDFISH_RTC,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(GoldfishRTCState),
> > +    .class_init    =3D goldfish_rtc_class_init,
> > +};
> > +
> > +static void goldfish_rtc_register_types(void)
> > +{
> > +    type_register_static(&goldfish_rtc_info);
> > +}
> > +
> > +type_init(goldfish_rtc_register_types)
> > diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
> > index d6749f4616..0bfaa26cb8 100644
> > --- a/hw/rtc/trace-events
> > +++ b/hw/rtc/trace-events
> > @@ -17,3 +17,7 @@ pl031_set_alarm(uint32_t ticks) "alarm set for %u tic=
ks"
> >   # aspeed-rtc.c
> >   aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " =
value 0x%08" PRIx64
> >   aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 "=
 value 0x%08" PRIx64
> > +
> > +# goldfish_rtc.c
> > +goldfish_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 "=
 value 0x%08" PRIx64
> > +goldfish_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 =
" value 0x%08" PRIx64
>
> You declared a region of 0x1000 bytes, shouldn't the address format be
> 0x%03? I'd rather use the correct region size and keep 0x02 which is enou=
gh.

I will update the region size so we don't need to change here.

>
> > diff --git a/include/hw/rtc/goldfish_rtc.h b/include/hw/rtc/goldfish_rt=
c.h
> > new file mode 100644
> > index 0000000000..3be586bdcb
> > --- /dev/null
> > +++ b/include/hw/rtc/goldfish_rtc.h
> > @@ -0,0 +1,46 @@
> > +/*
> > + * Goldfish virtual platform RTC
> > + *
> > + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
> > + *
> > + * For more details on Google Goldfish virtual platform refer:
> > + * https://android.googlesource.com/platform/external/qemu/+/master/do=
cs/GOLDFISH-VIRTUAL-HARDWARE.TXT
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2 or later, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but WITH=
OUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License a=
long with
> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#ifndef HW_RTC_GOLDFISH_RTC_H
> > +#define HW_RTC_GOLDFISH_RTC_H
> > +
> > +#include "hw/sysbus.h"
> > +
> > +#define TYPE_GOLDFISH_RTC "goldfish_rtc"
> > +#define GOLDFISH_RTC(obj) \
> > +OBJECT_CHECK(GoldfishRTCState, (obj), TYPE_GOLDFISH_RTC)
>
> Maybe insert some spaces before the macro to improve readability.

Okay.

>
> > +
> > +typedef struct GoldfishRTCState {
> > +    SysBusDevice parent_obj;
> > +
> > +    MemoryRegion iomem;
> > +    QEMUTimer *timer;
> > +    qemu_irq irq;
> > +
> > +    uint64_t tick_offset;
> > +    uint64_t tick_offset_vmstate;
> > +    uint64_t alarm_next;
> > +    uint32_t alarm_running;
> > +    uint32_t irq_pending;
> > +    uint32_t irq_enabled;
> > +} GoldfishRTCState;
> > +
> > +#endif
> >
>
> Rest of the patch looks good.

Thanks,
Anup

