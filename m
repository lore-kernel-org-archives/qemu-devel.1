Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E41C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 519B02072D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj0XPxMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519B02072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6dD3-0004Ye-9Y
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 11:37:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j6dC0-00043z-0v
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:36:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j6dBx-0003Rb-Rt
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:36:19 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:40125)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j6dBx-0003Pl-Ee; Tue, 25 Feb 2020 11:36:17 -0500
Received: by mail-lj1-x243.google.com with SMTP id n18so14762280ljo.7;
 Tue, 25 Feb 2020 08:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O9BFonl1P9D2TofO5FditgLrsKSNw7IMCHz941W92jU=;
 b=aj0XPxMW0U1xm0+LzLAx5P/p3YUvu54zlsOS0KioEj+XOurwrTpXkMGB6a+Nq0x4jG
 38uh75JHfOEnPpmHxN2pecXTULCPONqu/hK8Hh6iIZu0alJbslQuVZISyVkjWsqvPvT6
 WYK2yVSepeF/yv+SycpJFgZDfJsOcv2MP+OfJT8phee3SMTbrNd3F8T/bYOu6bd3AH20
 KZrnI9jAHshZtaDT2HCcJDV5v0ZE3fhW9Qhcvb9LrsDTVRdWxaIwcxtYhsX9FO1kMtTm
 J1+5bIZgolxdiiAoVt5hbp0egQvORac70cv1agxXdcr/Dug1pFVRAoozRutPsKPSACJq
 JdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O9BFonl1P9D2TofO5FditgLrsKSNw7IMCHz941W92jU=;
 b=G/TuDDn6IxFz+/GcAOn+d6xbpVi6zJbuUof4qC9mK+x+LdpDQOZclaz88PFNPWU3MU
 74nGs/TRH3S7WJ97pbzVQEauJ7ANWE5cy1z6kfeh3lvQytGuGe/3/ywpytLdQyBhz9U1
 6UNGacbx+6g7rbQPp+T00zPeS8w6o7+bhj9rKT8p2aQnhrBDaNgLT20hXDpOGi+hK8IM
 BE/rF43PZ3pm6wsBvcoAw4LSEZGRAUqkDnQjkj3v8ELTr7wTuYpOM4FmxWbMVyrNEh2O
 xfOM/SwXE/tADVcIy/r4iIYVNcUV/QkSsLvKn1cb8wCBwt8C5tiQhOGmROXBxQQqYC19
 ZI8w==
X-Gm-Message-State: APjAAAX4O77YQTfdLjltX3Vt05Jtc3C9e89S682pbEfnzJxmSK17G3ke
 EQdeOx044z3Oc3EE/nu6DOtlPAXbfKYJqyVJibU=
X-Google-Smtp-Source: APXvYqys2k0SQPQa+2rTk54arMjj5RPhBVIrUkvaJK0mPGAKrKRKbnC4PRhSRMzLT7N3JPpy78NgPjWiBYZz50hBIN8=
X-Received: by 2002:a2e:a36a:: with SMTP id i10mr33058930ljn.107.1582648573624; 
 Tue, 25 Feb 2020 08:36:13 -0800 (PST)
MIME-Version: 1.0
References: <20200225131422.53368-1-damien.hedde@greensocs.com>
 <20200225131422.53368-2-damien.hedde@greensocs.com>
In-Reply-To: <20200225131422.53368-2-damien.hedde@greensocs.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 25 Feb 2020 08:35:46 -0800
Message-ID: <CAKmqyKO6cib8Bz92cf2BvCqXBZEU3_Ovf22TXWpEXBzVWisWsQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/9] hw/core/clock: introduce clock object
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Edgar Iglesias <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 5:23 AM Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> This object may be used to represent a clock inside a clock tree.
>
> A clock may be connected to another clock so that it receives update,
> through a callback, whenever the source/parent clock is updated.
>
> Although only the root clock of a clock tree controls the values
> (represented as periods) of all clocks in tree, each clock holds
> a local state containing the current value so that it can be fetched
> independently. It will allows us to fullfill migration requirements
> by migrating each clock independently of others.
>
> This is based on the original work of Frederic Konrad.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> --
>
> v8:
> + fix hw/core/Makefiles.objs entry (Alistair)
> + no more field zeroing in finalizefn (Alistair)
> + typos (Alistair)
>
> v7:
> + merge ClockIn & ClockOut into a single type Clock
> + switch clock state to a period with 2^-32ns unit
> + add some Hz and ns helpers
> + propagate clock period when setting the source so that
>   clocks with fixed period are easy to handle.
> ---
>  include/hw/clock.h    | 216 ++++++++++++++++++++++++++++++++++++++++++
>  hw/core/clock.c       | 130 +++++++++++++++++++++++++
>  hw/core/Makefile.objs |   1 +
>  hw/core/trace-events  |   7 ++
>  4 files changed, 354 insertions(+)
>  create mode 100644 include/hw/clock.h
>  create mode 100644 hw/core/clock.c
>
> diff --git a/include/hw/clock.h b/include/hw/clock.h
> new file mode 100644
> index 0000000000..82a7f3c698
> --- /dev/null
> +++ b/include/hw/clock.h
> @@ -0,0 +1,216 @@
> +/*
> + * Hardware Clocks
> + *
> + * Copyright GreenSocs 2016-2020
> + *
> + * Authors:
> + *  Frederic Konrad
> + *  Damien Hedde
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_HW_CLOCK_H
> +#define QEMU_HW_CLOCK_H
> +
> +#include "qom/object.h"
> +#include "qemu/queue.h"
> +
> +#define TYPE_CLOCK "clock"
> +#define CLOCK(obj) OBJECT_CHECK(Clock, (obj), TYPE_CLOCK)
> +
> +typedef void ClockCallback(void *opaque);
> +
> +/*
> + * clock store a value representing the clock's period in 2^-32ns unit.
> + * It can represent:
> + *  + periods from 2^-32ns up to 4seconds
> + *  + frequency from ~0.25Hz 2e10Ghz
> + * Resolution of frequency representation decreases with frequency:
> + * + at 100MHz, resolution is ~2mHz
> + * + at 1Ghz,   resolution is ~0.2Hz
> + * + at 10Ghz,  resolution is ~20Hz
> + */
> +#define CLOCK_SECOND (1000000000llu << 32)
> +
> +/*
> + * macro helpers to convert to hertz / nanosecond
> + */
> +#define CLOCK_PERIOD_FROM_NS(ns) ((ns) * (CLOCK_SECOND / 1000000000llu))
> +#define CLOCK_PERIOD_TO_NS(per) ((per) / (CLOCK_SECOND / 1000000000llu))
> +#define CLOCK_PERIOD_FROM_HZ(hz) (((hz) != 0) ? CLOCK_SECOND / (hz) : 0u)
> +#define CLOCK_PERIOD_TO_HZ(per) (((per) != 0) ? CLOCK_SECOND / (per) : 0u)
> +
> +/**
> + * Clock:
> + * @parent_obj: parent class
> + * @period: unsigned integer representing the period of the clock
> + * @canonical_path: clock path string cache (used for trace purpose)
> + * @callback: called when clock changes
> + * @callback_opaque: argument for @callback
> + * @source: source (or parent in clock tree) of the clock
> + * @children: list of clocks connected to this one (it is their source)
> + * @sibling: structure used to form a clock list
> + */
> +
> +typedef struct Clock Clock;
> +
> +struct Clock {
> +    /*< private >*/
> +    Object parent_obj;
> +
> +    /* all fields are private and should not be modified directly */
> +
> +    /* fields */
> +    uint64_t period;
> +    char *canonical_path;
> +    ClockCallback *callback;
> +    void *callback_opaque;
> +
> +    /* Clocks are organized in a clock tree */
> +    Clock *source;
> +    QLIST_HEAD(, Clock) children;
> +    QLIST_ENTRY(Clock) sibling;
> +};
> +
> +/**
> + * clock_setup_canonical_path:
> + * @clk: clock
> + *
> + * compute the canonical path of the clock (used by log messages)
> + */
> +void clock_setup_canonical_path(Clock *clk);
> +
> +/**
> + * clock_set_callback:
> + * @clk: the clock to register the callback into
> + * @cb: the callback function
> + * @opaque: the argument to the callback
> + *
> + * Register a callback called on every clock update.
> + */
> +void clock_set_callback(Clock *clk, ClockCallback *cb, void *opaque);
> +
> +/**
> + * clock_clear_callback:
> + * @clk: the clock to delete the callback from
> + *
> + * Unregister the callback registered with clock_set_callback.
> + */
> +void clock_clear_callback(Clock *clk);
> +
> +/**
> + * clock_set_source:
> + * @clk: the clock.
> + * @src: the source clock
> + *
> + * Setup @src as the clock source of @clk. The current @src period
> + * value is also copied to @clk and its subtree but no callback is
> + * called.
> + * Further @src update will be propagated to @clk and its subtree.
> + */
> +void clock_set_source(Clock *clk, Clock *src);
> +
> +/**
> + * clock_set:
> + * @clk: the clock to initialize.
> + * @value: the clock's value, 0 means unclocked
> + *
> + * Set the local cached period value of @clk to @value.
> + */
> +void clock_set(Clock *clk, uint64_t value);
> +
> +static inline void clock_set_hz(Clock *clk, unsigned hz)
> +{
> +    clock_set(clk, CLOCK_PERIOD_FROM_HZ(hz));
> +}
> +
> +static inline void clock_set_ns(Clock *clk, unsigned ns)
> +{
> +    clock_set(clk, CLOCK_PERIOD_FROM_NS(ns));
> +}
> +
> +/**
> + * clock_propagate:
> + * @clk: the clock
> + *
> + * Propagate the clock period that has been previously configured using
> + * @clock_set(). This will update recursively all connected clocks.
> + * It is an error to call this function on a clock which has a source.
> + * Note: this function must not be called during device inititialization
> + * or migration.
> + */
> +void clock_propagate(Clock *clk);
> +
> +/**
> + * clock_update:
> + * @clk: the clock to update.
> + * @value: the new clock's value, 0 means unclocked
> + *
> + * Update the @clk to the new @value. All connected clocks will be informed
> + * of this update. This is equivalent to call @clock_set() then
> + * @clock_propagate().
> + */
> +static inline void clock_update(Clock *clk, uint64_t value)
> +{
> +    clock_set(clk, value);
> +    clock_propagate(clk);
> +}
> +
> +static inline void clock_update_hz(Clock *clk, unsigned hz)
> +{
> +    clock_update(clk, CLOCK_PERIOD_FROM_HZ(hz));
> +}
> +
> +static inline void clock_update_ns(Clock *clk, unsigned ns)
> +{
> +    clock_update(clk, CLOCK_PERIOD_FROM_NS(ns));
> +}
> +
> +/**
> + * clock_get:
> + * @clk: the clk to fetch the clock
> + *
> + * @return: the current period.
> + */
> +static inline uint64_t clock_get(const Clock *clk)
> +{
> +    return clk->period;
> +}
> +
> +static inline unsigned clock_get_hz(Clock *clk)
> +{
> +    return CLOCK_PERIOD_TO_HZ(clock_get(clk));
> +}
> +
> +static inline unsigned clock_get_ns(Clock *clk)
> +{
> +    return CLOCK_PERIOD_TO_NS(clock_get(clk));
> +}
> +
> +/**
> + * clock_is_enabled:
> + * @clk: a clock
> + *
> + * @return: true if the clock is running.
> + */
> +static inline bool clock_is_enabled(const Clock *clk)
> +{
> +    return clock_get(clk) != 0;
> +}
> +
> +static inline void clock_init(Clock *clk, uint64_t value)
> +{
> +    clock_set(clk, value);
> +}
> +static inline void clock_init_hz(Clock *clk, uint64_t value)
> +{
> +    clock_set_hz(clk, value);
> +}
> +static inline void clock_init_ns(Clock *clk, uint64_t value)
> +{
> +    clock_set_ns(clk, value);
> +}
> +
> +#endif /* QEMU_HW_CLOCK_H */
> diff --git a/hw/core/clock.c b/hw/core/clock.c
> new file mode 100644
> index 0000000000..3c0daf7d4c
> --- /dev/null
> +++ b/hw/core/clock.c
> @@ -0,0 +1,130 @@
> +/*
> + * Hardware Clocks
> + *
> + * Copyright GreenSocs 2016-2020
> + *
> + * Authors:
> + *  Frederic Konrad
> + *  Damien Hedde
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/clock.h"
> +#include "trace.h"
> +
> +#define CLOCK_PATH(_clk) (_clk->canonical_path)
> +
> +void clock_setup_canonical_path(Clock *clk)
> +{
> +    g_free(clk->canonical_path);
> +    clk->canonical_path = object_get_canonical_path(OBJECT(clk));
> +}
> +
> +void clock_set_callback(Clock *clk, ClockCallback *cb, void *opaque)
> +{
> +    clk->callback = cb;
> +    clk->callback_opaque = opaque;
> +}
> +
> +void clock_clear_callback(Clock *clk)
> +{
> +    clock_set_callback(clk, NULL, NULL);
> +}
> +
> +void clock_set(Clock *clk, uint64_t period)
> +{
> +    trace_clock_set(CLOCK_PATH(clk), CLOCK_PERIOD_TO_NS(clk->period),
> +                    CLOCK_PERIOD_TO_NS(period));
> +    clk->period = period;
> +}
> +
> +static void clock_propagate_period(Clock *clk, bool call_callbacks)
> +{
> +    Clock *child;
> +
> +    QLIST_FOREACH(child, &clk->children, sibling) {
> +        if (child->period != clk->period) {
> +            child->period = clk->period;
> +            trace_clock_update(CLOCK_PATH(child), CLOCK_PATH(clk),
> +                               CLOCK_PERIOD_TO_NS(clk->period),
> +                               call_callbacks);
> +            if (call_callbacks && child->callback) {
> +                child->callback(child->callback_opaque);
> +            }
> +            clock_propagate_period(child, call_callbacks);
> +        }
> +    }
> +}
> +
> +void clock_propagate(Clock *clk)
> +{
> +    assert(clk->source == NULL);
> +    trace_clock_propagate(CLOCK_PATH(clk));
> +    clock_propagate_period(clk, true);
> +}
> +
> +void clock_set_source(Clock *clk, Clock *src)
> +{
> +    /* changing clock source is not supported */
> +    assert(!clk->source);
> +
> +    trace_clock_set_source(CLOCK_PATH(clk), CLOCK_PATH(src));
> +
> +    clk->period = src->period;
> +    QLIST_INSERT_HEAD(&src->children, clk, sibling);
> +    clk->source = src;
> +    clock_propagate_period(clk, false);
> +}
> +
> +static void clock_disconnect(Clock *clk)
> +{
> +    if (clk->source == NULL) {
> +        return;
> +    }
> +
> +    trace_clock_disconnect(CLOCK_PATH(clk));
> +
> +    clk->source = NULL;
> +    QLIST_REMOVE(clk, sibling);
> +}
> +
> +static void clock_initfn(Object *obj)
> +{
> +    Clock *clk = CLOCK(obj);
> +
> +    QLIST_INIT(&clk->children);
> +}
> +
> +static void clock_finalizefn(Object *obj)
> +{
> +    Clock *clk = CLOCK(obj);
> +    Clock *child, *next;
> +
> +    /* clear our list of children */
> +    QLIST_FOREACH_SAFE(child, &clk->children, sibling, next) {
> +        clock_disconnect(child);
> +    }
> +
> +    /* remove us from source's children list */
> +    clock_disconnect(clk);
> +
> +    g_free(clk->canonical_path);
> +}
> +
> +static const TypeInfo clock_info = {
> +    .name              = TYPE_CLOCK,
> +    .parent            = TYPE_OBJECT,
> +    .instance_size     = sizeof(Clock),
> +    .instance_init     = clock_initfn,
> +    .instance_finalize = clock_finalizefn,
> +};
> +
> +static void clock_register_types(void)
> +{
> +    type_register_static(&clock_info);
> +}
> +
> +type_init(clock_register_types)
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index 6215e7c208..1d9b0aa205 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -7,6 +7,7 @@ common-obj-y += hotplug.o
>  common-obj-y += vmstate-if.o
>  # irq.o needed for qdev GPIO handling:
>  common-obj-y += irq.o
> +common-obj-y += clock.o
>
>  common-obj-$(CONFIG_SOFTMMU) += reset.o
>  common-obj-$(CONFIG_SOFTMMU) += qdev-fw.o
> diff --git a/hw/core/trace-events b/hw/core/trace-events
> index aecd8e160e..39301621ce 100644
> --- a/hw/core/trace-events
> +++ b/hw/core/trace-events
> @@ -27,3 +27,10 @@ resettable_phase_exit_begin(void *obj, const char *objtype, unsigned count, int
>  resettable_phase_exit_exec(void *obj, const char *objtype, int has_method) "obj=%p(%s) method=%d"
>  resettable_phase_exit_end(void *obj, const char *objtype, unsigned count) "obj=%p(%s) count=%d"
>  resettable_transitional_function(void *obj, const char *objtype) "obj=%p(%s)"
> +
> +# clock.c
> +clock_set_source(const char *clk, const char *src) "'%s', src='%s'"
> +clock_disconnect(const char *clk) "'%s'"
> +clock_set(const char *clk, unsigned long long old, unsigned long long new) "'%s', ns=%llu->%llu"
> +clock_propagate(const char *clk) "'%s'"
> +clock_update(const char *clk, const char *src, unsigned long long val, int cb) "'%s', src='%s', ns=%llu, cb=%d"
> --
> 2.25.1
>
>

