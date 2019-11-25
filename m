Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4841BC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:40:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055CD207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1tVdDAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055CD207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZEax-0001Yu-VH
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZEYT-0008Vd-Lw
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZEYR-00077k-Ht
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:37:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50868
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZEYR-00077N-Bm
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574689046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sXVl2pmE8sgcL0Gm1Jj2gijP5whuB4vilTsYhnVMceA=;
 b=W1tVdDAMSJ59ui1wauKIhG1C0COSHE+WPiXaEJIG0BqwV/p6KnnvP+LIkVFdIO24HwKqFu
 JrG4Bf4ZymEIxtdd+BmraLK3/p0ajnclTxKkxJj/goBsk+e9SMqrJwMPt7H+YqyqWUBtS2
 vjDjpnl/H6PWgcgNFtooyxDAtPAvo5o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-sKFbZ6lcNrShk5CrWH5Zrg-1; Mon, 25 Nov 2019 08:37:25 -0500
Received: by mail-wr1-f71.google.com with SMTP id t9so4783146wru.10
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 05:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p32ZRuKZsY0M8IfH5Oj/l+vZ/Q/3M4AI8ee5ljzQD/U=;
 b=LtPe1LF6h7fxGFRX0QrUyUIKiEP7zANqBtRjwIL4V3wAaVhnxeGR1xrk5Rbl+NdSUt
 JsNtoF+mQxNUD/00vulZcB7LDxgHRf2hUgeTUB3FZ7S/7f1ubKnjdtL6RpTBrGwehfXT
 pypPe5PQCVGBiDZQhZrZhRN2wcDIw42hLAMcaSdZzdW0hvD+xrVqqEWzHEA8hMm9Eafy
 F4dXIgdU020wBL31EnGOwI0mYp4SSoxAWIxYnEPy7KEYCLy9mxvTHRyCdQzDvfSmStx4
 2m7pbJDv57RaS4NlHxSsnPzZ70NCxrqXT1OTbz9dqkixopjn5xVyyjRxyxMVFD0I0EzX
 ma3Q==
X-Gm-Message-State: APjAAAVPGQs7CZptrTVfAPkqHrdP9tBc91+M5JRrOlj6FNjP8FtaJaUZ
 GR8bseLIi+l2OjdcUFboUFUVgFVLH0fsLkR9ZH4/byp+l0/tbNFhwQkUX9kOwHJoNaJVJBAOhT0
 1gsuTDaFppsTtnPo=
X-Received: by 2002:a1c:544b:: with SMTP id p11mr29154668wmi.46.1574689043855; 
 Mon, 25 Nov 2019 05:37:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwFjTMEsx9xTSgi8T9jD6mVe4qplFr3NPEB7A5myt3sHg/Q4OADhWrmh9T9y2ecukDxr3vnvQ==
X-Received: by 2002:a1c:544b:: with SMTP id p11mr29154642wmi.46.1574689043516; 
 Mon, 25 Nov 2019 05:37:23 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id w10sm8155717wmd.26.2019.11.25.05.37.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2019 05:37:22 -0800 (PST)
Subject: Re: [PATCH v6 1/9] hw/core/clock: introduce clock objects
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-2-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <50c7d986-1630-e75c-acbd-24330e961dbb@redhat.com>
Date: Mon, 25 Nov 2019 14:37:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190904125531.27545-2-damien.hedde@greensocs.com>
Content-Language: en-US
X-MC-Unique: sKFbZ6lcNrShk5CrWH5Zrg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 alistair@alistair23.me, mark.burton@greensocs.com, marcandre.lureau@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/19 2:55 PM, Damien Hedde wrote:
> Introduce clock objects: ClockIn and ClockOut.
>=20
> These objects may be used to distribute clocks from an object to several
> other objects. Each ClockIn object contains the current state of the
> clock: the frequency; it allows an object to migrate its input clock stat=
e
> independently of other objects.
>=20
> A ClockIn may be connected to a ClockOut so that it receives update,
> through a callback, whenever the Clockout is updated using the
> ClockOut's set function.
>=20
> This is based on the original work of Frederic Konrad.
>=20
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   Makefile.objs         |   1 +
>   hw/core/Makefile.objs |   1 +
>   hw/core/clock.c       | 144 ++++++++++++++++++++++++++++++++++++++++++
>   hw/core/trace-events  |   6 ++
>   include/hw/clock.h    | 124 ++++++++++++++++++++++++++++++++++++
>   5 files changed, 276 insertions(+)
>   create mode 100644 hw/core/clock.c
>   create mode 100644 include/hw/clock.h
>=20
> diff --git a/Makefile.objs b/Makefile.objs
> index a723a47e14..4da623c759 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -153,6 +153,7 @@ trace-events-subdirs +=3D hw/audio
>   trace-events-subdirs +=3D hw/block
>   trace-events-subdirs +=3D hw/block/dataplane
>   trace-events-subdirs +=3D hw/char
> +trace-events-subdirs +=3D hw/core
>   trace-events-subdirs +=3D hw/dma
>   trace-events-subdirs +=3D hw/hppa
>   trace-events-subdirs +=3D hw/i2c
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index 69b408ad1c..c66a5b2c6b 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -7,6 +7,7 @@ common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
>   # irq.o needed for qdev GPIO handling:
>   common-obj-y +=3D irq.o
>   common-obj-y +=3D hotplug.o
> +common-obj-y +=3D clock.o
>   common-obj-$(CONFIG_SOFTMMU) +=3D nmi.o
>   common-obj-$(CONFIG_SOFTMMU) +=3D vm-change-state-handler.o
>  =20
> diff --git a/hw/core/clock.c b/hw/core/clock.c
> new file mode 100644
> index 0000000000..888f247f2a
> --- /dev/null
> +++ b/hw/core/clock.c
> @@ -0,0 +1,144 @@
> +/*
> + * Clock inputs and outputs
> + *
> + * Copyright GreenSocs 2016-2018
> + *
> + * Authors:
> + *  Frederic Konrad <fred.konrad@greensocs.com>
> + *  Damien Hedde <damien.hedde@greensocs.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/clock.h"
> +#include "trace.h"
> +
> +#define CLOCK_PATH(_clk) (_clk->canonical_path)
> +
> +void clock_out_setup_canonical_path(ClockOut *clk)
> +{
> +    g_free(clk->canonical_path);
> +    clk->canonical_path =3D object_get_canonical_path(OBJECT(clk));
> +}
> +
> +void clock_in_setup_canonical_path(ClockIn *clk)
> +{
> +    g_free(clk->canonical_path);
> +    clk->canonical_path =3D object_get_canonical_path(OBJECT(clk));
> +}
> +
> +void clock_set_callback(ClockIn *clk, ClockCallback *cb, void *opaque)
> +{
> +    assert(clk);
> +
> +    clk->callback =3D cb;
> +    clk->callback_opaque =3D opaque;
> +}
> +
> +void clock_init_frequency(ClockIn *clk, uint64_t freq)
> +{
> +    assert(clk);
> +
> +    clk->frequency =3D freq;
> +}
> +
> +void clock_clear_callback(ClockIn *clk)
> +{
> +    clock_set_callback(clk, NULL, NULL);
> +}
> +
> +void clock_connect(ClockIn *clkin, ClockOut *clkout)
> +{
> +    assert(clkin && clkin->driver =3D=3D NULL);
> +    assert(clkout);
> +
> +    trace_clock_connect(CLOCK_PATH(clkin), CLOCK_PATH(clkout));
> +
> +    QLIST_INSERT_HEAD(&clkout->followers, clkin, sibling);
> +    clkin->driver =3D clkout;
> +}
> +
> +static void clock_disconnect(ClockIn *clk)
> +{
> +    if (clk->driver =3D=3D NULL) {
> +        return;
> +    }
> +
> +    trace_clock_disconnect(CLOCK_PATH(clk));
> +
> +    clk->driver =3D NULL;
> +    QLIST_REMOVE(clk, sibling);
> +}
> +
> +void clock_set_frequency(ClockOut *clk, uint64_t freq)
> +{
> +    ClockIn *follower;
> +    trace_clock_set_frequency(CLOCK_PATH(clk), freq);
> +
> +    QLIST_FOREACH(follower, &clk->followers, sibling) {
> +        trace_clock_propagate(CLOCK_PATH(clk), CLOCK_PATH(follower));
> +        if (follower->frequency !=3D freq) {
> +            follower->frequency =3D freq;
> +            if (follower->callback) {
> +                follower->callback(follower->callback_opaque);
> +            }
> +        }
> +    }
> +}
> +
> +static void clock_out_initfn(Object *obj)
> +{
> +    ClockOut *clk =3D CLOCK_OUT(obj);
> +
> +    QLIST_INIT(&clk->followers);
> +}
> +
> +static void clock_out_finalizefn(Object *obj)
> +{
> +    ClockOut *clk =3D CLOCK_OUT(obj);
> +    ClockIn *follower, *next;
> +
> +    /* clear our list of followers */
> +    QLIST_FOREACH_SAFE(follower, &clk->followers, sibling, next) {
> +        clock_disconnect(follower);
> +    }
> +
> +    g_free(clk->canonical_path);
> +    clk->canonical_path =3D NULL;
> +}
> +
> +static void clock_in_finalizefn(Object *obj)
> +{
> +    ClockIn *clk =3D CLOCK_IN(obj);
> +
> +    /* remove us from driver's followers list */
> +    clock_disconnect(clk);
> +
> +    g_free(clk->canonical_path);
> +    clk->canonical_path =3D NULL;
> +}
> +
> +static const TypeInfo clock_out_info =3D {
> +    .name              =3D TYPE_CLOCK_OUT,
> +    .parent            =3D TYPE_OBJECT,
> +    .instance_size     =3D sizeof(ClockOut),
> +    .instance_init     =3D clock_out_initfn,
> +    .instance_finalize =3D clock_out_finalizefn,
> +};
> +
> +static const TypeInfo clock_in_info =3D {
> +    .name              =3D TYPE_CLOCK_IN,
> +    .parent            =3D TYPE_OBJECT,
> +    .instance_size     =3D sizeof(ClockIn),
> +    .instance_finalize =3D clock_in_finalizefn,
> +};
> +
> +static void clock_register_types(void)
> +{
> +    type_register_static(&clock_in_info);
> +    type_register_static(&clock_out_info);
> +}
> +
> +type_init(clock_register_types)
> diff --git a/hw/core/trace-events b/hw/core/trace-events
> index ecf966c314..aa940e268b 100644
> --- a/hw/core/trace-events
> +++ b/hw/core/trace-events
> @@ -34,3 +34,9 @@ resettable_phase_hold_end(void *obj, int needed) "obj=
=3D%p needed=3D%d"
>   resettable_phase_exit(void *obj, const char *type) "obj=3D%p(%s)"
>   resettable_phase_exit_end(void *obj, uint32_t count) "obj=3D%p count=3D=
%" PRIu32
>   resettable_count_underflow(void *obj) "obj=3D%p"
> +
> +# hw/core/clock-port.c

"# clock.c"

> +clock_connect(const char *clk, const char *driver) "'%s' drived-by '%s'"
> +clock_disconnect(const char *clk) "'%s'"
> +clock_set_frequency(const char *clk, uint64_t freq) "'%s' freq_hz=3D%" P=
RIu64
> +clock_propagate(const char *clko, const char *clki) "'%s' =3D> '%s'"
> diff --git a/include/hw/clock.h b/include/hw/clock.h
> new file mode 100644
> index 0000000000..fd11202ba4
> --- /dev/null
> +++ b/include/hw/clock.h
> @@ -0,0 +1,124 @@
> +#ifndef QEMU_HW_CLOCK_H
> +#define QEMU_HW_CLOCK_H
> +
> +#include "qom/object.h"
> +#include "qemu/queue.h"
> +
> +#define TYPE_CLOCK_IN "clock-in"
> +#define CLOCK_IN(obj) OBJECT_CHECK(ClockIn, (obj), TYPE_CLOCK_IN)
> +#define TYPE_CLOCK_OUT "clock-out"
> +#define CLOCK_OUT(obj) OBJECT_CHECK(ClockOut, (obj), TYPE_CLOCK_OUT)
> +
> +typedef void ClockCallback(void *opaque);
> +
> +typedef struct ClockOut ClockOut;
> +typedef struct ClockIn ClockIn;
> +
> +struct ClockIn {
> +    /*< private >*/
> +    Object parent_obj;
> +    /*< private >*/
> +    uint64_t frequency;
> +    char *canonical_path; /* clock path cache */
> +    ClockOut *driver; /* clock output controlling this clock */
> +    ClockCallback *callback; /* local callback */
> +    void *callback_opaque; /* opaque argument for the callback */
> +    QLIST_ENTRY(ClockIn) sibling;  /* entry in a followers list */
> +};
> +
> +struct ClockOut {
> +    /*< private >*/
> +    Object parent_obj;
> +    /*< private >*/
> +    char *canonical_path; /* clock path cache */
> +    QLIST_HEAD(, ClockIn) followers; /* list of registered clocks */
> +};

Can we keep the structure definitions opaque in hw/core/clock.c?
If so, clock_get_frequency() can't be inlined anymore.

> +
> +/**
> + * clock_out_setup_canonical_path:
> + * @clk: clock
> + *
> + * compute the canonical path of the clock (used by log messages)
> + */
> +void clock_out_setup_canonical_path(ClockOut *clk);
> +
> +/**
> + * clock_in_setup_canonical_path:
> + * @clk: clock
> + *
> + * compute the canonical path of the clock (used by log messages)
> + */
> +void clock_in_setup_canonical_path(ClockIn *clk);
> +
> +/**
> + * clock_add_callback:
> + * @clk: the clock to register the callback into
> + * @cb: the callback function
> + * @opaque: the argument to the callback
> + *
> + * Register a callback called on every clock update.
> + */
> +void clock_set_callback(ClockIn *clk, ClockCallback *cb, void *opaque);
> +
> +/**
> + * clock_clear_callback:
> + * @clk: the clock to delete the callback from
> + *
> + * Unregister the callback registered with clock_set_callback.
> + */
> +void clock_clear_callback(ClockIn *clk);
> +
> +/**
> + * clock_init_frequency:
> + * @clk: the clock to initialize.
> + * @freq: the clock's frequency in Hz or 0 if unclocked.
> + *
> + * Initialize the local cached frequency value of @clk to @freq.
> + * Note: this function must only be called during device inititializatio=
n
> + * or migration.
> + */
> +void clock_init_frequency(ClockIn *clk, uint64_t freq);
> +
> +/**
> + * clock_connect:
> + * @clkin: the drived clock.
> + * @clkout: the driving clock.
> + *
> + * Setup @clkout to drive @clkin: Any @clkout update will be propagated
> + * to @clkin.
> + */
> +void clock_connect(ClockIn *clkin, ClockOut *clkout);
> +
> +/**
> + * clock_set_frequency:
> + * @clk: the clock to update.
> + * @freq: the new clock's frequency in Hz or 0 if unclocked.
> + *
> + * Update the @clk to the new @freq.
> + * This change will be propagated through registered clock inputs.
> + */
> +void clock_set_frequency(ClockOut *clk, uint64_t freq);
> +
> +/**
> + * clock_get_frequency:
> + * @clk: the clk to fetch the clock
> + *
> + * @return: the current frequency of @clk in Hz. If @clk is NULL, return=
 0.
> + */
> +static inline uint64_t clock_get_frequency(const ClockIn *clk)
> +{
> +    return clk ? clk->frequency : 0;
> +}
> +
> +/**
> + * clock_is_enabled:
> + * @clk: a clock state
> + *
> + * @return: true if the clock is running. If @clk is NULL return false.
> + */
> +static inline bool clock_is_enabled(const ClockIn *clk)
> +{
> +    return clock_get_frequency(clk) !=3D 0;
> +}
> +
> +#endif /* QEMU_HW_CLOCK_H */
>=20


