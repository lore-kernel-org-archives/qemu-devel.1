Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871CEC43468
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0CE620872
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="FchpjUVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CE620872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJGMQ-0003Zy-JC
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kJGK8-00013g-8t
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:21:12 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kJGK2-0001Qr-VU
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:21:11 -0400
Received: by mail-wm1-x341.google.com with SMTP id w2so5319678wmi.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 06:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=loooFndZki+XmwihYp4FUP4LGz6ErP2vN4qy49LdFrI=;
 b=FchpjUVPqYHV8g2RL6Rc1z82dG0KxmKD7pcqUHX4nAhtfMUV3E2RXQIDFtKJqr/xeG
 /0o7a1PQG74xe5PXOaw0K0G+kXi85Po1Z0UbdnF74si3bkL9iwKe+T/Xvos/fN7rdOyH
 gCfV4/nlgd2De3fsykzpttLED7kaXoaitIf8fE8OTAHFR/e9fNGg/inBbiGO3TyOpCcI
 oJ57FtOAWvT6b546YHnwI79WWB7Gcq70yYr8+RfvYNZvwBxTOX/GBMpOgx+bx4+ns1RO
 +mxNu38pIu7N1mr3I+mdyHvrE1kE2X45Xa9CqeRAMvJV7R9WQr4zWGY+YF2lAP6itijf
 b3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=loooFndZki+XmwihYp4FUP4LGz6ErP2vN4qy49LdFrI=;
 b=IEmijTH7u0uOCFrsiLsvjipGhv0PQ/UMv084xpvG6nLfaqtf/ve2IB9GU7gs/DJ8PE
 PyQ7j+XNOuyr3fh+DjhPnpBmOnGEDkVkCnrahh7u2L3mzl5Pab35h4sAV/HfZy7dD4Lm
 7/apoUBFyve0GTuPQQWzWEmbGmLQkSvh9qJCp/BHU2N+rjbPabQCI+ahNBwU8v1KEW21
 fq6sBiP2Y/JZj7zSZWRvjL3oLqj1tDsfhrlX8nU9IaShSR7ivP4XHrPtPSTtmIq4/2Qu
 nlEq5M/ImKn61pAd6R4ZMFt33ye1Y/ABjor1e2JmgtJ/0wHnRvw3sfAoQlZarZqEMmqh
 ndGA==
X-Gm-Message-State: AOAM530ZMB2rjiwLV+8iVO7F4CjgHp2I7nd8k2yw/gvE6AIDVL5V/sFS
 7cqyEzt/qeuzEPUiZIEuX5Rwmg==
X-Google-Smtp-Source: ABdhPJzm/Fbw4BHzuVfPsRozQsu5gNALnxOPUmNcdNy/1Cpi4bVFT9QkzyZXqo0oVn8M/QptyRlJJg==
X-Received: by 2002:a1c:23c9:: with SMTP id j192mr16154918wmj.6.1600435265272; 
 Fri, 18 Sep 2020 06:21:05 -0700 (PDT)
Received: from xora-sinquacker ([2a02:8010:64d6::197e])
 by smtp.gmail.com with ESMTPSA id n66sm5081725wmb.35.2020.09.18.06.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 06:21:04 -0700 (PDT)
Date: Fri, 18 Sep 2020 13:21:02 +0000
From: Graeme Gregory <graeme@nuviainc.com>
To: Shashi Mallela <shashi.mallela@linaro.org>
Subject: Re: [EXTERNAL] [PATCH] hw/watchdog: Implement generic watchdog
 device model as per ARM BSAv0.9 hw/arm/sbsa-ref : Include SBSA watchdog
 device in sbsa-ref platform
Message-ID: <20200918132102.mifni2vv6turky4i@xora-sinquacker>
References: <20200917213702.hrldjbvhaig6ooul@xora-sinquacker>
 <28E5F544-3707-420F-8082-70E07C331683@getmailspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28E5F544-3707-420F-8082-70E07C331683@getmailspring.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=graeme@nuviainc.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "leif@nuviainc.com" <leif@nuviainc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "rad@semihalf.com" <rad@semihalf.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 05:51:33PM -0400, Shashi Mallela wrote:
> Hi Graeme,
> 
> In the generated patch file ,there is subject description (as below)before the
> "Signed-off-by: " line.Not sure why it doesn't show up in the mail.
> 
> Subject: [PATCH] hw/watchdog: Implement generic watchdog device model as per
>  ARM BSAv0.9 hw/arm/sbsa-ref : Include SBSA watchdog device in sbsa-ref
>  platform
> 
> I do not have link to updated ACPI tables.

I suspect this shows that it really should be two patches.

[PATCH 1/2] hw/watchdog: Implement SBSA watchdog device

More detailed description including spec references.

SoB:

[PATCH 2/2] hw/arm/sbsa-ref: add SBSA watchdog device

More detailed description.

SoB:

The [Patch X/X] bit obviously being automatically added by
format-patch/send-email.

Thanks

Graeme

> 
> Thanks
> Shashi
> 
> Sent from [1]Mailspring, the best free email app for work
> On Sep 17 2020, at 5:37 pm, Graeme Gregory <graeme@nuviainc.com> wrote:
> 
>     Something still seems to have gone wrong with subject, and description
>     of patch is missing? Missed blank line between 1st line and description?
> 
>     Do you have the link to updated ACPI tables for testing out of interest?
> 
>     On Thu, Sep 17, 2020 at 02:12:45PM -0400, Shashi Mallela wrote:
>     > Signed-off-by: Shashi Mallela <shashi.mallela@linaro.org>
>     > ---
>     > hw/arm/Kconfig | 1 +
>     > hw/arm/sbsa-ref.c | 23 ++
>     > hw/watchdog/Kconfig | 4 +
>     > hw/watchdog/meson.build | 1 +
>     > hw/watchdog/wdt_sbsa_gwdt.c | 343 ++++++++++++++++++++++++++++
>     > include/hw/watchdog/wdt_sbsa_gwdt.h | 68 ++++++
>     > 6 files changed, 440 insertions(+)
>     > create mode 100644 hw/watchdog/wdt_sbsa_gwdt.c
>     > create mode 100644 include/hw/watchdog/wdt_sbsa_gwdt.h
>     >
>     > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>     > index f303c6bead25..6b97e64595d3 100644
>     > --- a/hw/arm/Kconfig
>     > +++ b/hw/arm/Kconfig
>     > @@ -210,6 +210,7 @@ config SBSA_REF
>     > select PL031 # RTC
>     > select PL061 # GPIO
>     > select USB_EHCI_SYSBUS
>     > + select WDT_SBSA_GWDT
>     >
>     > config SABRELITE
>     > bool
>     > diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
>     > index ac68b4640d0d..652079a12e37 100644
>     > --- a/hw/arm/sbsa-ref.c
>     > +++ b/hw/arm/sbsa-ref.c
>     > @@ -40,6 +40,7 @@
>     > #include "hw/qdev-properties.h"
>     > #include "hw/usb.h"
>     > #include "hw/char/pl011.h"
>     > +#include "hw/watchdog/wdt_sbsa_gwdt.h"
>     > #include "net/net.h"
>     > #include "qom/object.h"
>     >
>     > @@ -64,6 +65,9 @@ enum {
>     > SBSA_GIC_DIST,
>     > SBSA_GIC_REDIST,
>     > SBSA_SECURE_EC,
>     > + SBSA_GWDT,
>     > + SBSA_GWDT_REFRESH,
>     > + SBSA_GWDT_CONTROL,
>     > SBSA_SMMU,
>     > SBSA_UART,
>     > SBSA_RTC,
>     > @@ -111,6 +115,8 @@ static const MemMapEntry sbsa_ref_memmap[] = {
>     > [SBSA_GIC_DIST] = { 0x40060000, 0x00010000 },
>     > [SBSA_GIC_REDIST] = { 0x40080000, 0x04000000 },
>     > [SBSA_SECURE_EC] = { 0x50000000, 0x00001000 },
>     > + [SBSA_GWDT_REFRESH] = { 0x50010000, 0x00001000 },
>     > + [SBSA_GWDT_CONTROL] = { 0x50011000, 0x00001000 },
>     > [SBSA_UART] = { 0x60000000, 0x00001000 },
>     > [SBSA_RTC] = { 0x60010000, 0x00001000 },
>     > [SBSA_GPIO] = { 0x60020000, 0x00001000 },
>     > @@ -140,6 +146,7 @@ static const int sbsa_ref_irqmap[] = {
>     > [SBSA_SECURE_UART_MM] = 9,
>     > [SBSA_AHCI] = 10,
>     > [SBSA_EHCI] = 11,
>     > + [SBSA_GWDT] = 12,
>     > };
>     >
>     > static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
>     > @@ -454,6 +461,20 @@ static void create_rtc(const SBSAMachineState *sms)
>     > sysbus_create_simple("pl031", base, qdev_get_gpio_in(sms->gic, irq));
>     > }
>     >
>     > +static void create_wdt(const SBSAMachineState *sms)
>     > +{
>     > + hwaddr rbase = sbsa_ref_memmap[SBSA_GWDT_REFRESH].base;
>     > + hwaddr cbase = sbsa_ref_memmap[SBSA_GWDT_CONTROL].base;
>     > + DeviceState *dev = qdev_new(TYPE_WDT_SBSA_GWDT);
>     > + SysBusDevice *s = SYS_BUS_DEVICE(dev);
>     > + int irq = sbsa_ref_irqmap[SBSA_GWDT];
>     > +
>     > + sysbus_realize_and_unref(s, &error_fatal);
>     > + sysbus_mmio_map(s, 0, rbase);
>     > + sysbus_mmio_map(s, 1, cbase);
>     > + sysbus_connect_irq(s, 0, qdev_get_gpio_in(sms->gic, irq));
>     > +}
>     > +
>     > static DeviceState *gpio_key_dev;
>     > static void sbsa_ref_powerdown_req(Notifier *n, void *opaque)
>     > {
>     > @@ -737,6 +758,8 @@ static void sbsa_ref_init(MachineState *machine)
>     >
>     > create_rtc(sms);
>     >
>     > + create_wdt(sms);
>     > +
>     > create_gpio(sms);
>     >
>     > create_ahci(sms);
>     > diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
>     > index 293209b291d6..94ac0d5b76b1 100644
>     > --- a/hw/watchdog/Kconfig
>     > +++ b/hw/watchdog/Kconfig
>     > @@ -17,3 +17,7 @@ config WDT_DIAG288
>     >
>     > config WDT_IMX2
>     > bool
>     > +
>     > +config WDT_SBSA_GWDT
>     > + bool
>     > + default y if SBSA_REF
>     > \ No newline at end of file
>     > diff --git a/hw/watchdog/meson.build b/hw/watchdog/meson.build
>     > index 9b8725e64288..a9a23307acfe 100644
>     > --- a/hw/watchdog/meson.build
>     > +++ b/hw/watchdog/meson.build
>     > @@ -5,3 +5,4 @@ softmmu_ss.add(when: 'CONFIG_WDT_IB700', if_true: files
>     ('wdt_ib700.c'))
>     > softmmu_ss.add(when: 'CONFIG_WDT_DIAG288', if_true: files
>     ('wdt_diag288.c'))
>     > softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('wdt_aspeed.c'))
>     > softmmu_ss.add(when: 'CONFIG_WDT_IMX2', if_true: files('wdt_imx2.c'))
>     > +softmmu_ss.add(when: 'CONFIG_WDT_SBSA_GWDT', if_true: files
>     ('wdt_sbsa_gwdt.c'))
>     > diff --git a/hw/watchdog/wdt_sbsa_gwdt.c b/hw/watchdog/wdt_sbsa_gwdt.c
>     > new file mode 100644
>     > index 000000000000..eb3be0862cf1
>     > --- /dev/null
>     > +++ b/hw/watchdog/wdt_sbsa_gwdt.c
>     > @@ -0,0 +1,343 @@
>     > +/*
>     > + * Generic watchdog device model for SBSA
>     > + *
>     > + * Copyright Linaro.org 2020
>     > + *
>     > + * Authors:
>     > + * Shashi Mallela <shashi.mallela@linaro.org>
>     > + *
>     > + * This work is licensed under the terms of the GNU GPL, version 2 or
>     (at your
>     > + * option) any later version. See the COPYING file in the top-level
>     directory.
>     > + *
>     > + */
>     > +
>     > +#include "qemu/osdep.h"
>     > +#include "sysemu/reset.h"
>     > +#include "sysemu/watchdog.h"
>     > +#include "hw/watchdog/wdt_sbsa_gwdt.h"
>     > +#include "qemu/timer.h"
>     > +#include "migration/vmstate.h"
>     > +#include "qemu/log.h"
>     > +#include "qemu/module.h"
>     > +
>     > +static WatchdogTimerModel model = {
>     > + .wdt_name = TYPE_WDT_SBSA_GWDT,
>     > + .wdt_description = "sbsa_gwdt device for sbsa_ref platform",
>     > +};
>     > +
>     > +static const VMStateDescription vmstate_sbsa_gwdt = {
>     > + .name = "vmstate_sbsa_gwdt",
>     > + .version_id = 1,
>     > + .minimum_version_id = 1,
>     > + .fields = (VMStateField[]) {
>     > + VMSTATE_TIMER_PTR(timer, SBSA_GWDTState),
>     > + VMSTATE_BOOL(enabled, SBSA_GWDTState),
>     > + VMSTATE_BOOL(ws0, SBSA_GWDTState),
>     > + VMSTATE_BOOL(ws1, SBSA_GWDTState),
>     > + VMSTATE_UINT32(wrr, SBSA_GWDTState),
>     > + VMSTATE_UINT32(wcs, SBSA_GWDTState),
>     > + VMSTATE_UINT32(worl, SBSA_GWDTState),
>     > + VMSTATE_UINT32(woru, SBSA_GWDTState),
>     > + VMSTATE_UINT32(wcvl, SBSA_GWDTState),
>     > + VMSTATE_UINT32(wcvu, SBSA_GWDTState),
>     > + VMSTATE_END_OF_LIST()
>     > + }
>     > +};
>     > +
>     > +static uint64_t sbsa_gwdt_rread(void *opaque, hwaddr addr, unsigned int
>     size)
>     > +{
>     > + uint32_t ret;
>     > +
>     > + if (addr == SBSA_GWDT_WRR) {
>     > + /* watch refresh read has no effect and returns 0 */
>     > + ret = 0;
>     > + } else {
>     > + fprintf(stderr, "bad address in refresh frame read : 0x%x\n",
>     > + (int)addr);
> 
>     I suspect this and the other fprintf's should be using the
>     qemu_log_mask(LOG_GUEST_ERROR, ... API
> 
>     Graeme
> 
>     > + }
>     > + return ret;
>     > +}
>     > +
>     > +static uint64_t sbsa_gwdt_read(void *opaque, hwaddr addr, unsigned int
>     size)
>     > +{
>     > + SBSA_GWDTState *s = SBSA_GWDT(opaque);
>     > + uint32_t ret = 0;
>     > +
>     > + switch (addr) {
>     > + case SBSA_GWDT_WCS:
>     > + ret = s->wcs;
>     > + break;
>     > + case SBSA_GWDT_WOR:
>     > + ret = s->worl;
>     > + break;
>     > + case SBSA_GWDT_WORU:
>     > + ret = s->woru;
>     > + break;
>     > + case SBSA_GWDT_WCV:
>     > + ret = s->wcvl;
>     > + break;
>     > + case SBSA_GWDT_WCVU:
>     > + ret = s->wcvu;
>     > + break;
>     > + case SBSA_GWDT_W_IIDR:
>     > + ret = s->id;
>     > + break;
>     > + default:
>     > + fprintf(stderr, "bad address in control frame read : 0x%x\n",
>     > + (int)addr);
>     > + }
>     > + return ret;
>     > +}
>     > +
>     > +static void sbsa_gwdt_update_timer(SBSA_GWDTState *s, bool refresh,
>     > + bool expired)
>     > +{
>     > + uint64_t timeout = 0;
>     > +
>     > + if (s->enabled) {
>     > + if ((refresh) || (expired && !s->ws0)) {
>     > + /*
>     > + * Extract the upper 16 bits from woru & 32 bits from worl
>     > + * registers to construct the 48 bit offset value
>     > + */
>     > + timeout = s->woru & SBSA_GWDT_WOR_MASK;
>     > + timeout <<= 32;
>     > + timeout |= s->worl;
>     > + timeout += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>     > +
>     > + /* store the current timeout value into compare registers */
>     > + s->wcvu = timeout >> 32;
>     > + s->wcvl = timeout;
>     > + } else {
>     > + timeout = s->wcvu;
>     > + timeout <<= 32;
>     > + timeout |= s->wcvl;
>     > + }
>     > +
>     > + if (!s->ws0) {
>     > + timer_del(s->timer);
>     > + timer_mod(s->ptimer,
>     > + timeout * NANOSECONDS_PER_SECOND);
>     > + } else {
>     > + timer_del(s->ptimer);
>     > + timer_mod(s->timer,
>     > + timeout * NANOSECONDS_PER_SECOND);
>     > + }
>     > + } else {
>     > + timer_del(s->ptimer);
>     > + timer_del(s->timer);
>     > + }
>     > +}
>     > +
>     > +static void sbsa_gwdt_rwrite(void *opaque, hwaddr offset, uint64_t data,
>     > + unsigned size) {
>     > + SBSA_GWDTState *s = SBSA_GWDT(opaque);
>     > +
>     > + if (offset == SBSA_GWDT_WRR) {
>     > + s->wrr = data;
>     > + s->wcs &= ~SBSA_GWDT_WCS_WS0;
>     > + s->wcs &= ~SBSA_GWDT_WCS_WS1;
>     > + s->ws0 = false;
>     > + s->ws1 = false;
>     > + sbsa_gwdt_update_timer(s, true , false);
>     > + } else {
>     > + fprintf(stderr, "bad address in refresh frame write : 0x%x\n",
>     > + (int)offset);
>     > + }
>     > +}
>     > +
>     > +static void sbsa_gwdt_write(void *opaque, hwaddr offset, uint64_t data,
>     > + unsigned size) {
>     > + SBSA_GWDTState *s = SBSA_GWDT(opaque);
>     > + bool enable;
>     > +
>     > + switch (offset) {
>     > + case SBSA_GWDT_WCS:
>     > + enable = data & SBSA_GWDT_WCS_EN;
>     > + if (enable) {
>     > + s->wcs |= SBSA_GWDT_WCS_EN;
>     > + s->enabled = true;
>     > + } else {
>     > + s->wcs &= ~SBSA_GWDT_WCS_EN;
>     > + s->enabled = false;
>     > + s->ws0 = false;
>     > + s->ws1 = false;
>     > + }
>     > + sbsa_gwdt_update_timer(s, false, false);
>     > + break;
>     > +
>     > + case SBSA_GWDT_WOR:
>     > + s->worl = data;
>     > + /*
>     > + * TODO:- setting woru to 0 and triggering update timer(below) is a
>     > + * temporary workaround to handle current linux driver which is
>     > + * based on earlier version of BSA specification.Once the linux
>     > + * driver is updated to BSA v0.9 will remove these next 2 lines.
>     > + */
>     > + s->woru = 0;
>     > + sbsa_gwdt_update_timer(s, true , false);
>     > + break;
>     > +
>     > + case SBSA_GWDT_WORU:
>     > + s->woru = data;
>     > + sbsa_gwdt_update_timer(s, true , false);
>     > + break;
>     > +
>     > + case SBSA_GWDT_WCV:
>     > + s->wcvl = data;
>     > + break;
>     > +
>     > + case SBSA_GWDT_WCVU:
>     > + s->wcvu = data;
>     > + break;
>     > +
>     > + default:
>     > + fprintf(stderr, "bad address in control frame write : 0x%x\n",
>     > + (int)offset);
>     > + }
>     > + return;
>     > +}
>     > +
>     > +static void wdt_sbsa_gwdt_reset(DeviceState *dev)
>     > +{
>     > + SBSA_GWDTState *s = SBSA_GWDT(dev);
>     > +
>     > + timer_del(s->ptimer);
>     > + timer_del(s->timer);
>     > +
>     > + s->enabled = false;
>     > + s->ws0 = false;
>     > + s->ws1 = false;
>     > + s->wcs &= ~SBSA_GWDT_WCS_EN;
>     > + s->wcs &= ~SBSA_GWDT_WCS_WS0;
>     > + s->wcs &= ~SBSA_GWDT_WCS_WS1;
>     > + s->wcvl = 0;
>     > + s->wcvu = 0;
>     > + s->worl = 0;
>     > + s->woru = 0;
>     > + s->id = SBSA_GWDT_ID;
>     > +}
>     > +
>     > +static void sbsa_gwdt_reset(void *opaque)
>     > +{
>     > + DeviceState *sbsa_gwdt = opaque;
>     > +
>     > + wdt_sbsa_gwdt_reset(sbsa_gwdt);
>     > +}
>     > +
>     > +static void sbsa_gwdt_timer_sysinterrupt(void *opaque)
>     > +{
>     > + SBSA_GWDTState *s = SBSA_GWDT(opaque);
>     > +
>     > + s->wcs |= SBSA_GWDT_WCS_WS0;
>     > + s->ws0 = true;
>     > + qemu_set_irq(s->irq, 1);
>     > + sbsa_gwdt_update_timer(s, false, true);
>     > +}
>     > +
>     > +static void sbsa_gwdt_timer_sysreset(void *dev)
>     > +{
>     > + SBSA_GWDTState *s = SBSA_GWDT(dev);
>     > + s->wcs |= SBSA_GWDT_WCS_WS1;
>     > + s->ws1 = true;
>     > + qemu_log_mask(CPU_LOG_RESET, "Watchdog timer expired.\n");
>     > + /*
>     > + * Reset the watchdog only if the guest gets notified about
>     > + * expiry. watchdog_perform_action() may temporarily relinquish
>     > + * the BQL; reset before triggering the action to avoid races with
>     > + * sbsa_gwdt instructions.
>     > + */
>     > + switch (get_watchdog_action()) {
>     > + case WATCHDOG_ACTION_DEBUG:
>     > + case WATCHDOG_ACTION_NONE:
>     > + case WATCHDOG_ACTION_PAUSE:
>     > + break;
>     > + default:
>     > + wdt_sbsa_gwdt_reset(dev);
>     > + }
>     > + watchdog_perform_action();
>     > +}
>     > +
>     > +static const MemoryRegionOps sbsa_gwdt_rops = {
>     > + .read = sbsa_gwdt_rread,
>     > + .write = sbsa_gwdt_rwrite,
>     > + .endianness = DEVICE_LITTLE_ENDIAN,
>     > + .valid.min_access_size = 4,
>     > + .valid.max_access_size = 4,
>     > + .valid.unaligned = false,
>     > +};
>     > +
>     > +static const MemoryRegionOps sbsa_gwdt_ops = {
>     > + .read = sbsa_gwdt_read,
>     > + .write = sbsa_gwdt_write,
>     > + .endianness = DEVICE_LITTLE_ENDIAN,
>     > + .valid.min_access_size = 4,
>     > + .valid.max_access_size = 4,
>     > + .valid.unaligned = false,
>     > +};
>     > +
>     > +static void wdt_sbsa_gwdt_realize(DeviceState *dev, Error **errp)
>     > +{
>     > + SBSA_GWDTState *s = SBSA_GWDT(dev);
>     > + SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>     > +
>     > + memory_region_init_io(&s->rmmio, OBJECT(dev),
>     > + &sbsa_gwdt_rops, s,
>     > + "sbsa_gwdt.refresh",
>     > + SBSA_GWDT_RMMIO_SIZE);
>     > +
>     > + memory_region_init_io(&s->cmmio, OBJECT(dev),
>     > + &sbsa_gwdt_ops, s,
>     > + "sbsa_gwdt.control",
>     > + SBSA_GWDT_CMMIO_SIZE);
>     > +
>     > + sysbus_init_mmio(sbd, &s->rmmio);
>     > + sysbus_init_mmio(sbd, &s->cmmio);
>     > +
>     > + sysbus_init_irq(sbd, &s->irq);
>     > +
>     > + qemu_register_reset(sbsa_gwdt_reset, s);
>     > +
>     > + s->ptimer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
>     sbsa_gwdt_timer_sysinterrupt,
>     > + dev);
>     > + s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sbsa_gwdt_timer_sysreset,
>     > + dev);
>     > +}
>     > +
>     > +static void wdt_sbsa_gwdt_unrealize(DeviceState *dev)
>     > +{
>     > + SBSA_GWDTState *s = SBSA_GWDT(dev);
>     > +
>     > + timer_del(s->ptimer);
>     > + timer_free(s->ptimer);
>     > +
>     > + timer_del(s->timer);
>     > + timer_free(s->timer);
>     > +}
>     > +
>     > +static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, void *data)
>     > +{
>     > + DeviceClass *dc = DEVICE_CLASS(klass);
>     > +
>     > + dc->realize = wdt_sbsa_gwdt_realize;
>     > + dc->unrealize = wdt_sbsa_gwdt_unrealize;
>     > + dc->reset = wdt_sbsa_gwdt_reset;
>     > + dc->hotpluggable = false;
>     > + set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>     > + dc->vmsd = &vmstate_sbsa_gwdt;
>     > +}
>     > +
>     > +static const TypeInfo wdt_sbsa_gwdt_info = {
>     > + .class_init = wdt_sbsa_gwdt_class_init,
>     > + .parent = TYPE_SYS_BUS_DEVICE,
>     > + .name = TYPE_WDT_SBSA_GWDT,
>     > + .instance_size = sizeof(SBSA_GWDTState),
>     > +};
>     > +
>     > +static void wdt_sbsa_gwdt_register_types(void)
>     > +{
>     > + watchdog_add_model(&model);
>     > + type_register_static(&wdt_sbsa_gwdt_info);
>     > +}
>     > +
>     > +type_init(wdt_sbsa_gwdt_register_types)
>     > diff --git a/include/hw/watchdog/wdt_sbsa_gwdt.h b/include/hw/watchdog/
>     wdt_sbsa_gwdt.h
>     > new file mode 100644
>     > index 000000000000..8044646fa62d
>     > --- /dev/null
>     > +++ b/include/hw/watchdog/wdt_sbsa_gwdt.h
>     > @@ -0,0 +1,68 @@
>     > +#ifndef WDT_SBSA_GWDT_H
>     > +#define WDT_SBSA_GWDT_H
>     > +
>     > +#include "qemu/bitops.h"
>     > +#include "hw/sysbus.h"
>     > +#include "hw/irq.h"
>     > +
>     > +#define TYPE_WDT_SBSA_GWDT "sbsa_gwdt"
>     > +#define SBSA_GWDT(obj) \
>     > + OBJECT_CHECK(SBSA_GWDTState, (obj), TYPE_WDT_SBSA_GWDT)
>     > +#define SBSA_GWDT_CLASS(klass) \
>     > + OBJECT_CLASS_CHECK(SBSA_GWDTClass, (klass), TYPE_WDT_SBSA_GWDT)
>     > +#define SBSA_GWDT_GET_CLASS(obj) \
>     > + OBJECT_GET_CLASS(SBSA_GWDTClass, (obj), TYPE_WDT_SBSA_GWDT)
>     > +
>     > +/* SBSA Generic Watchdog register definitions */
>     > +/* refresh frame */
>     > +#define SBSA_GWDT_WRR 0x000
>     > +
>     > +/* control frame */
>     > +#define SBSA_GWDT_WCS 0x000
>     > +#define SBSA_GWDT_WOR 0x008
>     > +#define SBSA_GWDT_WORU 0x00C
>     > +#define SBSA_GWDT_WCV 0x010
>     > +#define SBSA_GWDT_WCVU 0x014
>     > +
>     > +/* Watchdog Interface Identification Register */
>     > +#define SBSA_GWDT_W_IIDR 0xFCC
>     > +
>     > +/* Watchdog Control and Status Register Bits */
>     > +#define SBSA_GWDT_WCS_EN BIT(0)
>     > +#define SBSA_GWDT_WCS_WS0 BIT(1)
>     > +#define SBSA_GWDT_WCS_WS1 BIT(2)
>     > +
>     > +#define SBSA_GWDT_WOR_MASK 0x0000FFFF
>     > +
>     > +/* Watchdog Interface Identification Register definition*/
>     > +#define SBSA_GWDT_ID 0x1043B
>     > +
>     > +/* 2 Separate memory regions for each of refresh & control register
>     frames */
>     > +#define SBSA_GWDT_RMMIO_SIZE 0x1000
>     > +#define SBSA_GWDT_CMMIO_SIZE 0x1000
>     > +
>     > +typedef struct SBSA_GWDTState {
>     > + /* <private> */
>     > + SysBusDevice parent_obj;
>     > +
>     > + /*< public >*/
>     > + MemoryRegion rmmio;
>     > + MemoryRegion cmmio;
>     > + qemu_irq irq;
>     > +
>     > + QEMUTimer *ptimer, *timer;
>     > +
>     > + uint32_t id;
>     > + uint32_t wrr;
>     > + uint32_t wcs;
>     > + uint32_t worl;
>     > + uint32_t woru;
>     > + uint32_t wcvl;
>     > + uint32_t wcvu;
>     > + bool enabled;
>     > + bool ws0, ws1;
>     > +
>     > + /*< public >*/
>     > +} SBSA_GWDTState;
>     > +
>     > +#endif /* WDT_SBSA_GWDT_H */
>     > --
>     > 2.18.4
>     >
>     >
> 
> Sent from Mailspring
> 
> References:
> 
> [1] https://link.getmailspring.com/link/28E5F544-3707-420F-8082-70E07C331683@getmailspring.com/0?redirect=https%3A%2F%2Fgetmailspring.com%2F&recipient=Z3JhZW1lQG51dmlhaW5jLmNvbQ%3D%3D

