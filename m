Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68DBC3F68F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 09:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D8820675
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 09:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="BrVGheMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D8820675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icR1z-0004wk-DD
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 04:33:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1icQbO-0005uX-3v
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:05:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1icQbG-00035g-4M
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:05:35 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:40680)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1icQb2-0002BS-RS; Wed, 04 Dec 2019 04:05:21 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 1319896EF0;
 Wed,  4 Dec 2019 09:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575450317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+M0eJbitAjFgLnmEEkFN14ss5YnhHtCP/lJks2m5PoU=;
 b=BrVGheMS1SijpDbh9BB2yAZ8aAshUHGK1gCtkry5pxKboXiJ5IRsYYlXDoiLMekrs9zFav
 Xn2Gkdib40qBV4GTpMMqEn3TukPSVNajft1IOc+bR+a35Q+qIPzBWDQVNUlUpTxSGrIj/8
 avZco9iGpTozTiltZkCHk9gQTbY9wY4=
From: Damien Hedde <damien.hedde@greensocs.com>
Subject: Re: [PATCH v6 3/9] qdev: add clock input&output support to devices.
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-4-damien.hedde@greensocs.com>
 <CAFEAcA9M4qR89wykURrUxqxeWoNqYHxuJSwC5Mum6GfmWSG=nA@mail.gmail.com>
Message-ID: <8ac54ca8-4acf-5145-9ead-6791a5181617@greensocs.com>
Date: Wed, 4 Dec 2019 10:05:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9M4qR89wykURrUxqxeWoNqYHxuJSwC5Mum6GfmWSG=nA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575450317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+M0eJbitAjFgLnmEEkFN14ss5YnhHtCP/lJks2m5PoU=;
 b=dFYrHkVAuxmer0WsqunZnmIjRuYHu/0p60LPyJZFH4/vSxIxtmfhwAmSfs591kPnaw+plm
 YxnimAV6jdI4tz1ryX8DSCZu294lSf32PcG4pcMMw0v/mqPKpxpVX7IwquHhn6C9GXbsQ8
 sOGEWVo8SQgbTES6DcTCGiR/sGcxt2w=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575450317; a=rsa-sha256; cv=none;
 b=TPA45jSn4WBMtWnkHnc0xyII4cym2ConvK1Eeut6Z2QKd+2WIVa0drSzWmrK+3GyXl42lp
 MDsetdRArx2YCUwaOw6jOxPyWNd5+5QgsA0Ez4TK5Lc8aGA3oXstw+LDObY2zXfOXHhIoT
 qgHKP+XwQWCbalWqP6x0yuomkz1lAZ0=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/2/19 3:34 PM, Peter Maydell wrote:
> On Wed, 4 Sep 2019 at 13:56, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> Add functions to easily add input or output clocks to a device.
>> A clock objects is added as a child of the device.
> 
> "object"
> 
>> The api is very similar the gpio's one.
> 
> "API"; "to the GPIO API".
> 
>>
>> This is based on the original work of Frederic Konrad.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>>
> 
>> +static NamedClockList *qdev_init_clocklist(DeviceState *dev, const char *name,
>> +        bool forward)
>> +{
>> +    NamedClockList *ncl;
>> +
>> +    /*
>> +     * The clock path will be computed by the device's realize function call.
>> +     * This is required to ensure the clock's canonical path is right and log
>> +     * messages are meaningfull.
> 
> "meaningful"
> 
>> +     */
>> +    assert(name);
>> +    assert(!dev->realized);
>> +
>> +    /* The ncl structure will be freed in device's finalize function call */
> 
> Do you mean "in device_finalize()", or "in the finalize method
> of the device" ?  If you mean a specific function, then it's
> good to name it, so the reader can go and check that code if
> they need to confirm that there's a matching free()/deref/etc.

Yes, it is device_finalize(). I'll update the comment.

> 
>> +    ncl = g_malloc0(sizeof(*ncl));
> 
> Prefer g_new0(NamedClockList, 1).
> 
>> +    ncl->name = g_strdup(name);
>> +    ncl->forward = forward;
>> +
>> +    QLIST_INSERT_HEAD(&dev->clocks, ncl, node);
>> +    return ncl;
>> +}
>> +
>> +ClockOut *qdev_init_clock_out(DeviceState *dev, const char *name)
>> +{
>> +    NamedClockList *ncl;
>> +    Object *clk;
>> +
>> +    ncl = qdev_init_clocklist(dev, name, false);
>> +
>> +    clk = object_new(TYPE_CLOCK_OUT);
>> +
>> +    /* will fail if name already exists */
> 
> This is true but it would be more helpful to say
>  /*
>   * Trying to create a clock whose name clashes with some other
>   * clock or property is a bug in the caller and we will abort().
>   */
> 
> (assuming that's what's going on here).

You're right.

> 
>> +    object_property_add_child(OBJECT(dev), name, clk, &error_abort);
>> +    object_unref(clk); /* remove the initial ref made by object_new */
>> +
>> +    ncl->out = CLOCK_OUT(clk);
>> +    return ncl->out;
>> +}
>> +
>> +ClockIn *qdev_init_clock_in(DeviceState *dev, const char *name,
>> +                        ClockCallback *callback, void *opaque)
>> +{
>> +    NamedClockList *ncl;
>> +    Object *clk;
>> +
>> +    ncl = qdev_init_clocklist(dev, name, false);
>> +
>> +    clk = object_new(TYPE_CLOCK_IN);
>> +    /*
>> +     * the ref initialized by object_new will be cleared during dev finalize.
> 
> This means "in device_finalize()", I think from reading later patches ?

Yes. I'll update the comment too.
> 
>> +     * It allows us to safely remove the callback.
>> +     */
>> +
>> +    /* will fail if name already exists */
> 
> Similar remark as for earlier comment.
> 
>> +    object_property_add_child(OBJECT(dev), name, clk, &error_abort);
>> +
>> +    ncl->in = CLOCK_IN(clk);
>> +    if (callback) {
>> +        clock_set_callback(ncl->in, callback, opaque);
>> +    }
>> +    return ncl->in;
>> +}
> 
>> +ClockIn *qdev_get_clock_in(DeviceState *dev, const char *name)
>> +{
>> +    NamedClockList *ncl;
>> +
>> +    assert(dev && name);
>> +
>> +    ncl = qdev_get_clocklist(dev, name);
>> +    return ncl ? ncl->in : NULL;
>> +}
> 
> Do we expect to want to be able to pass in the name of
> a clock that doesn't exist ? Should that be an error
> rather than returning NULL ?

I think it can be an error and we may assert the clock exists.

> 
>> +
>> +static ClockOut *qdev_get_clock_out(DeviceState *dev, const char *name)
>> +{
>> +    NamedClockList *ncl;
>> +
>> +    assert(dev && name);
>> +
>> +    ncl = qdev_get_clocklist(dev, name);
>> +    return ncl ? ncl->out : NULL;
> 
> Ditto.
> 
>> +}
>> +
>> +void qdev_connect_clock_out(DeviceState *dev, const char *name, ClockIn *clk,
>> +                            Error **errp)
>> +{
>> +    ClockOut *clkout = qdev_get_clock_out(dev, name);
>> +
>> +    if (!clk) {
>> +        error_setg(errp, "NULL input clock");
>> +        return;
>> +    }
>> +
>> +    if (!clkout) {
>> +        error_setg(errp, "no output clock '%s' in device", name);
>> +        return;
>> +    }
>> +
>> +    clock_connect(clk, clkout);
> 
> Do we need to support returning an error here, or would it
> always be a programming bug to try to connect a non-existent clock?

As for above, I think it can be considered an error. Should I remove the
errp and do an assert instead ?

> 
>> --- /dev/null
>> +++ b/include/hw/qdev-clock.h
>> @@ -0,0 +1,67 @@
>> +#ifndef QDEV_CLOCK_H
>> +#define QDEV_CLOCK_H
> 
> Another missing copyright/license comment.
> 
>> +
>> +#include "hw/clock.h"
>> +
>> +/**
>> + * qdev_init_clock_in:
>> + * @dev: the device in which to add a clock
> 
> "the device to add a clock input to"
> 
>> + * @name: the name of the clock (can't be NULL).
>> + * @callback: optional callback to be called on update or NULL.
>> + * @opaque:   argument for the callback
>> + * @returns: a pointer to the newly added clock
>> + *
>> + * Add a input clock to device @dev as a clock named @name.
>> + * This adds a child<> property.
>> + * The callback will be called with @dev as opaque parameter.
> 
> Isn't it called with @opaque, not @dev ?
> 
>> + */
>> +ClockIn *qdev_init_clock_in(DeviceState *dev, const char *name,
>> +                            ClockCallback *callback, void *opaque);
>> +
>> +/**
>> + * qdev_init_clock_out:
>> + * @dev: the device to add a clock to
> 
> "the device to add a clock output to"
> 
>> + * @name: the name of the clock (can't be NULL).
>> + * @callback: optional callback to be called on update or NULL.
>> + * @returns: a pointer to the newly added clock
>> + *
>> + * Add a output clock to device @dev as a clock named @name.
>> + * This adds a child<> property.
>> + */
>> +ClockOut *qdev_init_clock_out(DeviceState *dev, const char *name);
>> +
>> +/**
>> + * qdev_get_clock_in:
>> + * @dev: the device which has the clock
>> + * @name: the name of the clock (can't be NULL).
>> + * @returns: a pointer to the clock
>> + *
>> + * Get the clock @name from @dev or NULL if does not exists.
> 
> "if it does not exist"
> 
>> + */
>> +ClockIn *qdev_get_clock_in(DeviceState *dev, const char *name);
>> +
>> +/**
>> + * qdev_connect_clock_out:
>> + * @dev: the device which has the clock
>> + * @name: the name of the clock (can't be NULL).
>> + * @errp: error report
>> + *
>> + * Connect @clk to the output clock @name of @dev.
>> + * Reports an error if clk is NULL or @name does not exists in @dev.
> 
> "or if @name does not exist in @dev"
> 
>> + */
>> +void qdev_connect_clock_out(DeviceState *dev, const char *name, ClockIn *clk,
>> +                            Error **errp);
>> +
>> +/**
>> + * qdev_pass_clock:
>> + * @dev: the device to forward the clock to
>> + * @name: the name of the clock to be added (can't be NULL)
>> + * @container: the device which already has the clock
>> + * @cont_name: the name of the clock in the container device
>> + *
>> + * Add a clock @name to @dev which forward to the clock @cont_name in @container
>> + */
> 
> 'container' seems odd terminology here, because I would expect
> the usual use of this function to be when a 'container' object
> like an SoC wants to forward a clock to one of its components;
> in that case the 'container' SoC would be @dev, wouldn't it?

Yes. I agree it is confusing.
This function just allow a a device 'A' to exhibit a clock from another
device 'B' (typically a composing sub-device, inside a soc like you
said). The device A is not supposed to interact with the clock itself.
The original sub-device is the true
owner/controller of the clock and is the only one which should use the
clock API: setting a callback on it (input clock); or updating the clock
frequency (output clock).
Basically, it just add the clock into the device clock namespace without
interfering with it.

> We should get this to be the same way round as qdev_pass_gpios(),
> which takes "DeviceState *dev, DeviceState *container", and
> passes the gpios that exist on 'dev' over to 'container' so that
> 'container' now has gpios which it did not before.

Ok, I'll invert the arguments.

> 
> Also, your use of 'forward to' is inconsistent: in the 'dev'
> documentation you say we're forwarding the clock to 'dev',
> but in the body of the documentation you say we're forwarding
> the clock to the clock in 'container'.

I'll try to clarify this and make the documentation more consistent with
the comments here.

> 
> I think the way to resolve this is to stick to the terminology
> in the function name itself:
>  @dev: the device which has the clock
>  @name: the name of the clock on @dev
>  @container: the name of the device which the clock should
>   be passed to
>  @cont_name: the name to use for the clock on @container

I think container is confusing because depending on how we reason (clock
in a device; device in another device), we end up thinking the opposite.

Maybe we can use "exhibit" instead of "container" in the 2nd pair of
parameters, or prefix use "origin" or "owner" as a prefix for the first
pair of parameters.

> 
> Q: if you pass a clock to another device with this function,
> does it still exist to be used directly on the original
> device? For qdev_pass_gpios it does not (I think), but
> this is more accident of implementation than anything else.

It depends what we mean by "used by".
Original device can:
+ set the callback in case it is an input
+ update the frequency in case it is an output
But since an input clock can only be connected once,
I think the logic here is that any connection should now go through the
new device. But this is not checked and using one or the other is
exactly the same.

Maybe I misunderstood the meaning of qdev_pass_gpios().

> 
>> +void qdev_pass_clock(DeviceState *dev, const char *name,
>> +                     DeviceState *container, const char *cont_name);
>> +
>> +#endif /* QDEV_CLOCK_H */
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index eb11f0f801..60a65f6142 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -131,6 +131,19 @@ struct NamedGPIOList {
>>      QLIST_ENTRY(NamedGPIOList) node;
>>  };
>>
>> +typedef struct NamedClockList NamedClockList;
>> +
>> +typedef struct ClockIn ClockIn;
>> +typedef struct ClockOut ClockOut;
>> +
>> +struct NamedClockList {
>> +    char *name;
> 
> Could this be 'const char*' ?

Yes.

--
Damien

