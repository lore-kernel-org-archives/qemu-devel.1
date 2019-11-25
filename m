Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD074C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870D62075C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ej8aUFwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870D62075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZETh-00061b-LL
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZES7-0005RR-Ha
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:30:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZES4-0004vn-3f
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:30:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48223
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZES3-0004vY-Ud
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574688651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MSDxCyk6aZ+8GyszFUehnXS/2lBN06Ag/BxZE7NR9Ss=;
 b=ej8aUFwXnH1nS6Q0RHR3RlmVaemgpCJkjXi055TjeCKut4Q6aOCoN6HI4l2ASPVTFhH9sT
 UcLv3QUBml3PdSQg3unhUDjQYeyMRQ1EM+93dzTBWOrBikrlIn8DtxWOLHOP8u3g/EckAy
 R01kU6dpgh0gNVg67AMLCGZ403B9HT8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-6VATIjtDPuG425ByUN6bZQ-1; Mon, 25 Nov 2019 08:30:49 -0500
Received: by mail-wm1-f70.google.com with SMTP id o135so3760657wme.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 05:30:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2/SBS3X6e75Ej1uOZVCn0pr8f4c9JDDiwts6QSOnXow=;
 b=PjyEonXH3F1p/QrrWESrZwFQRTPS4a8hP808pKrxbwBl6oDkQl8l0Q3QT95UfCrzSh
 iJBzTREp255jVYXUHGXBvDanA6nXcQgBm77pPRUAGSp15aJOwRXA8MlegLNXAj3iy0Yh
 O6CcdwteXkwJCfV/3J2plsUtTrPaQEJ7fMdST7MQRZ3LiuqH526mP3RTzlOSRMogVL9+
 kQoFRO4/mrV23k9z11wbacx8y3CJ7LY3czkUI4aXoK8XvwzKATx4V4blFJuvuJ8UR/QB
 HHrMcMY9yK0kp4F9L1TBFcScCKHvFMON6hcl+0PMW7v8MJ8f6VFZHcTH2ZPjFQkDQ4jN
 EXoQ==
X-Gm-Message-State: APjAAAUn3HnFiJ+rGKnrNvHbtpQCZmqcRQjkVxr+Xi2ZGY095Wm/z3ha
 ZUBPkh9kJc4bC0MyhYw8e5xU0bbgqXnQFZHr3QgwGGdbkKQQbiAGqOPL2xs48nP7hhjilLnBumu
 ggyDYg6dmb9zqFbE=
X-Received: by 2002:adf:f709:: with SMTP id r9mr30734724wrp.8.1574688648331;
 Mon, 25 Nov 2019 05:30:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqyn7kHSGpT3g7gveNb+OcnlMzFWpsKcJfojCEUJV1bkRW5n1XPUtk63/WDrem1CDQiO7Icxgw==
X-Received: by 2002:adf:f709:: with SMTP id r9mr30734695wrp.8.1574688647893;
 Mon, 25 Nov 2019 05:30:47 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id y8sm8122481wmi.9.2019.11.25.05.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2019 05:30:47 -0800 (PST)
Subject: Re: [PATCH v6 3/9] qdev: add clock input&output support to devices.
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-4-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a7d0808d-b57a-f8a7-93ea-ec69aee81cf9@redhat.com>
Date: Mon, 25 Nov 2019 14:30:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190904125531.27545-4-damien.hedde@greensocs.com>
Content-Language: en-US
X-MC-Unique: 6VATIjtDPuG425ByUN6bZQ-1
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

Nitpick: remove trailing dot in patch subject

On 9/4/19 2:55 PM, Damien Hedde wrote:
> Add functions to easily add input or output clocks to a device.
> A clock objects is added as a child of the device.

<newline>?

> The api is very similar the gpio's one.

Maybe "This API is very similar to the QDEV GPIO API."

>=20
> This is based on the original work of Frederic Konrad.
>=20
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>=20
> ---
> I've removed the reviewed-by/tested-by of Philippe because I did a small
> modification.
>=20
> qdev_connect_clock() which allowed to connect an input to an output is
> now split in 2:
> + qdev_get_clock_in() which gets a given input from a device
> + qdev_connect_clock_out() which connect a given output to a clock
> (previously fetched by qdev_get_clock_in())
> This part is located in (qdev-clock.[c|h]).
> It better matches gpios api and also add the possibility to connect a
> device's input clock to a random output clock (used in patch 9).
>=20
> Also add missing qdev-clock in the test-qdev-global-props so that tests
> pass.
> ---
>   hw/core/Makefile.objs   |   2 +-
>   hw/core/qdev-clock.c    | 155 ++++++++++++++++++++++++++++++++++++++++
>   hw/core/qdev.c          |  32 +++++++++
>   include/hw/qdev-clock.h |  67 +++++++++++++++++
>   include/hw/qdev-core.h  |  14 ++++
>   tests/Makefile.include  |   1 +

Please setup the scripts/git.orderfile to ease reviews.

>   6 files changed, 270 insertions(+), 1 deletion(-)
>   create mode 100644 hw/core/qdev-clock.c
>   create mode 100644 include/hw/qdev-clock.h
>=20
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index 8fcebf2e67..4523d3b5c7 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -1,5 +1,5 @@
>   # core qdev-related obj files, also used by *-user:
> -common-obj-y +=3D qdev.o qdev-properties.o
> +common-obj-y +=3D qdev.o qdev-properties.o qdev-clock.o
>   common-obj-y +=3D bus.o reset.o
>   common-obj-y +=3D resettable.o
>   common-obj-$(CONFIG_SOFTMMU) +=3D qdev-fw.o
> diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
> new file mode 100644
> index 0000000000..bebdd8fa15
> --- /dev/null
> +++ b/hw/core/qdev-clock.c
> @@ -0,0 +1,155 @@
> +/*
> + * Device's clock
> + *
> + * Copyright GreenSocs 2016-2018

2019

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
> +#include "hw/qdev-clock.h"
> +#include "hw/qdev-core.h"
> +#include "qapi/error.h"
> +
> +static NamedClockList *qdev_init_clocklist(DeviceState *dev, const char =
*name,
> +        bool forward)

Indentation off.

> +{
> +    NamedClockList *ncl;
> +
> +    /*
> +     * The clock path will be computed by the device's realize function =
call.
> +     * This is required to ensure the clock's canonical path is right an=
d log
> +     * messages are meaningfull.
> +     */
> +    assert(name);
> +    assert(!dev->realized);
> +
> +    /* The ncl structure will be freed in device's finalize function cal=
l */
> +    ncl =3D g_malloc0(sizeof(*ncl));

Similar but easier to review:

        ncl =3D g_new0(NamedClockList, 1)

> +    ncl->name =3D g_strdup(name);
> +    ncl->forward =3D forward;
> +
> +    QLIST_INSERT_HEAD(&dev->clocks, ncl, node);
> +    return ncl;
> +}
> +
> +ClockOut *qdev_init_clock_out(DeviceState *dev, const char *name)
> +{
> +    NamedClockList *ncl;
> +    Object *clk;
> +
> +    ncl =3D qdev_init_clocklist(dev, name, false);
> +
> +    clk =3D object_new(TYPE_CLOCK_OUT);
> +
> +    /* will fail if name already exists */
> +    object_property_add_child(OBJECT(dev), name, clk, &error_abort);
> +    object_unref(clk); /* remove the initial ref made by object_new */
> +
> +    ncl->out =3D CLOCK_OUT(clk);
> +    return ncl->out;
> +}
> +
> +ClockIn *qdev_init_clock_in(DeviceState *dev, const char *name,
> +                        ClockCallback *callback, void *opaque)

Indentation off.

> +{
> +    NamedClockList *ncl;
> +    Object *clk;
> +
> +    ncl =3D qdev_init_clocklist(dev, name, false);
> +
> +    clk =3D object_new(TYPE_CLOCK_IN);
> +    /*
> +     * the ref initialized by object_new will be cleared during dev fina=
lize.
> +     * It allows us to safely remove the callback.
> +     */
> +
> +    /* will fail if name already exists */
> +    object_property_add_child(OBJECT(dev), name, clk, &error_abort);
> +
> +    ncl->in =3D CLOCK_IN(clk);
> +    if (callback) {
> +        clock_set_callback(ncl->in, callback, opaque);
> +    }
> +    return ncl->in;
> +}
> +
> +static NamedClockList *qdev_get_clocklist(DeviceState *dev, const char *=
name)
> +{
> +    NamedClockList *ncl;
> +
> +    QLIST_FOREACH(ncl, &dev->clocks, node) {
> +        if (strcmp(name, ncl->name) =3D=3D 0) {
> +            return ncl;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +void qdev_pass_clock(DeviceState *dev, const char *name,
> +                     DeviceState *container, const char *cont_name)
> +{
> +    NamedClockList *original_ncl, *ncl;
> +    Object **clk;

Is it really a Object** or a Object*?

> +
> +    assert(container && cont_name);
> +
> +    original_ncl =3D qdev_get_clocklist(container, cont_name);
> +    assert(original_ncl); /* clock must exist in origin */
> +
> +    ncl =3D qdev_init_clocklist(dev, name, true);
> +
> +    if (ncl->out) {
> +        clk =3D (Object **)&ncl->out;
> +    } else {
> +        clk =3D (Object **)&ncl->in;
> +    }
> +
> +    /* will fail if name already exists */
> +    object_property_add_link(OBJECT(dev), name, object_get_typename(*clk=
),
> +                             clk, NULL, OBJ_PROP_LINK_STRONG, &error_abo=
rt);
> +}
> +
> +ClockIn *qdev_get_clock_in(DeviceState *dev, const char *name)
> +{
> +    NamedClockList *ncl;
> +
> +    assert(dev && name);
> +
> +    ncl =3D qdev_get_clocklist(dev, name);
> +    return ncl ? ncl->in : NULL;
> +}
> +
> +static ClockOut *qdev_get_clock_out(DeviceState *dev, const char *name)
> +{
> +    NamedClockList *ncl;
> +
> +    assert(dev && name);
> +
> +    ncl =3D qdev_get_clocklist(dev, name);
> +    return ncl ? ncl->out : NULL;
> +}
> +
> +void qdev_connect_clock_out(DeviceState *dev, const char *name, ClockIn =
*clk,
> +                            Error **errp)
> +{
> +    ClockOut *clkout =3D qdev_get_clock_out(dev, name);
> +
> +    if (!clk) {
> +        error_setg(errp, "NULL input clock");
> +        return;
> +    }
> +
> +    if (!clkout) {
> +        error_setg(errp, "no output clock '%s' in device", name);
> +        return;
> +    }
> +
> +    clock_connect(clk, clkout);
> +}
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 9095f2b9c1..eae6cd3e09 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -37,6 +37,7 @@
>   #include "hw/qdev-properties.h"
>   #include "hw/boards.h"
>   #include "hw/sysbus.h"
> +#include "hw/clock.h"
>   #include "migration/vmstate.h"
>  =20
>   bool qdev_hotplug =3D false;
> @@ -821,6 +822,7 @@ static void device_set_realized(Object *obj, bool val=
ue, Error **errp)
>       DeviceClass *dc =3D DEVICE_GET_CLASS(dev);
>       HotplugHandler *hotplug_ctrl;
>       BusState *bus;
> +    NamedClockList *clk;
>       Error *local_err =3D NULL;
>       bool unattached_parent =3D false;
>       static int unattached_count;
> @@ -869,6 +871,15 @@ static void device_set_realized(Object *obj, bool va=
lue, Error **errp)
>            */
>           g_free(dev->canonical_path);
>           dev->canonical_path =3D object_get_canonical_path(OBJECT(dev));
> +        QLIST_FOREACH(clk, &dev->clocks, node) {
> +            if (clk->forward) {
> +                continue;
> +            } else if (clk->in !=3D NULL) {
> +                clock_in_setup_canonical_path(clk->in);
> +            } else {
> +                clock_out_setup_canonical_path(clk->out);
> +            }
> +        }
>  =20
>           if (qdev_get_vmsd(dev)) {
>               if (vmstate_register_with_alias_id(dev, -1, qdev_get_vmsd(d=
ev), dev,
> @@ -999,6 +1010,7 @@ static void device_initfn(Object *obj)
>                                (Object **)&dev->parent_bus, NULL, 0,
>                                &error_abort);
>       QLIST_INIT(&dev->gpios);
> +    QLIST_INIT(&dev->clocks);
>   }
>  =20
>   static void device_post_init(Object *obj)
> @@ -1015,6 +1027,7 @@ static void device_post_init(Object *obj)
>   static void device_finalize(Object *obj)
>   {
>       NamedGPIOList *ngl, *next;
> +    NamedClockList *clk, *clk_next;
>  =20
>       DeviceState *dev =3D DEVICE(obj);
>  =20
> @@ -1028,6 +1041,25 @@ static void device_finalize(Object *obj)
>            */
>       }
>  =20
> +    QLIST_FOREACH_SAFE(clk, &dev->clocks, node, clk_next) {
> +        QLIST_REMOVE(clk, node);
> +        if (!clk->forward && clk->in) {
> +            /*
> +             * if this clock is not forwarded, clk->in is a child of dev=
.
> +             * At this point the child property and associated reference=
 is
> +             * already deleted but we kept a ref on clk->in to ensure it=
 lives
> +             * up to this point and we can safely remove the callback.
> +             * It avoids having a lost callback to a deleted device if t=
he
> +             * clk->in is still referenced somewhere else (eg: by a cloc=
k
> +             * output).
> +             */
> +            clock_clear_callback(clk->in);
> +            object_unref(OBJECT(clk->in));
> +        }
> +        g_free(clk->name);
> +        g_free(clk);
> +    }
> +
>       /* Only send event if the device had been completely realized */
>       if (dev->pending_deleted_event) {
>           g_assert(dev->canonical_path);
> diff --git a/include/hw/qdev-clock.h b/include/hw/qdev-clock.h
> new file mode 100644
> index 0000000000..c4ea912fdc
> --- /dev/null
> +++ b/include/hw/qdev-clock.h
> @@ -0,0 +1,67 @@
> +#ifndef QDEV_CLOCK_H
> +#define QDEV_CLOCK_H
> +
> +#include "hw/clock.h"
> +
> +/**
> + * qdev_init_clock_in:
> + * @dev: the device in which to add a clock
> + * @name: the name of the clock (can't be NULL).

I'd drop the trailing dot in property descriptions.

> + * @callback: optional callback to be called on update or NULL.
> + * @opaque:   argument for the callback
> + * @returns: a pointer to the newly added clock
> + *
> + * Add a input clock to device @dev as a clock named @name.
> + * This adds a child<> property.
> + * The callback will be called with @dev as opaque parameter.
> + */
> +ClockIn *qdev_init_clock_in(DeviceState *dev, const char *name,
> +                            ClockCallback *callback, void *opaque);
> +
> +/**
> + * qdev_init_clock_out:
> + * @dev: the device to add a clock to
> + * @name: the name of the clock (can't be NULL).
> + * @callback: optional callback to be called on update or NULL.
> + * @returns: a pointer to the newly added clock
> + *
> + * Add a output clock to device @dev as a clock named @name.
> + * This adds a child<> property.
> + */
> +ClockOut *qdev_init_clock_out(DeviceState *dev, const char *name);
> +
> +/**
> + * qdev_get_clock_in:
> + * @dev: the device which has the clock
> + * @name: the name of the clock (can't be NULL).
> + * @returns: a pointer to the clock
> + *
> + * Get the clock @name from @dev or NULL if does not exists.
> + */
> +ClockIn *qdev_get_clock_in(DeviceState *dev, const char *name);
> +
> +/**
> + * qdev_connect_clock_out:
> + * @dev: the device which has the clock
> + * @name: the name of the clock (can't be NULL).
> + * @errp: error report
> + *
> + * Connect @clk to the output clock @name of @dev.
> + * Reports an error if clk is NULL or @name does not exists in @dev.
> + */
> +void qdev_connect_clock_out(DeviceState *dev, const char *name, ClockIn =
*clk,
> +                            Error **errp);
> +
> +/**
> + * qdev_pass_clock:
> + * @dev: the device to forward the clock to
> + * @name: the name of the clock to be added (can't be NULL)
> + * @container: the device which already has the clock
> + * @cont_name: the name of the clock in the container device
> + *
> + * Add a clock @name to @dev which forward to the clock @cont_name in @c=
ontainer
> + */
> +void qdev_pass_clock(DeviceState *dev, const char *name,
> +                     DeviceState *container, const char *cont_name);
> +
> +#endif /* QDEV_CLOCK_H */
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index eb11f0f801..60a65f6142 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -131,6 +131,19 @@ struct NamedGPIOList {
>       QLIST_ENTRY(NamedGPIOList) node;
>   };
>  =20
> +typedef struct NamedClockList NamedClockList;
> +
> +typedef struct ClockIn ClockIn;
> +typedef struct ClockOut ClockOut;
> +
> +struct NamedClockList {
> +    char *name;
> +    bool forward;
> +    ClockIn *in;
> +    ClockOut *out;
> +    QLIST_ENTRY(NamedClockList) node;
> +};
> +
>   /**
>    * DeviceState:
>    * @realized: Indicates whether the device has been fully constructed.
> @@ -152,6 +165,7 @@ struct DeviceState {
>       int hotplugged;
>       BusState *parent_bus;
>       QLIST_HEAD(, NamedGPIOList) gpios;
> +    QLIST_HEAD(, NamedClockList) clocks;
>       QLIST_HEAD(, BusState) child_bus;
>       int num_child_bus;
>       int instance_id_alias;
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index f0b4628cc6..5c54beb29e 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -566,6 +566,7 @@ tests/test-qdev-global-props$(EXESUF): tests/test-qde=
v-global-props.o \
>   =09hw/core/irq.o \
>   =09hw/core/fw-path-provider.o \
>   =09hw/core/reset.o \
> +=09hw/core/clock.o \
>   =09$(test-qapi-obj-y)
>   tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
>   =09migration/vmstate.o migration/vmstate-types.o migration/qemu-file.o =
\
>=20

Except the cosmetic comments:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

(Note, this series needs a rebase now).


