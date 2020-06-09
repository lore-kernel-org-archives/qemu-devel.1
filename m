Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACBBC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:01:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79D0207ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DASrWdU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79D0207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiZBw-0002tz-Ph
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 04:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZAd-00026K-Pl
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:59:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58538
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZAc-0003eE-2u
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591689580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Iug+/inqT2hRTLfHmNbZqFOjoSIThMHU4ueWMMKJYGY=;
 b=DASrWdU+uTNdyUoN8232vFcCyjrds+PmVwyoW6iC/mES3lAedoojMOctXG1WuZAgIafRBq
 tO5lPiNReRnxJ6984C7LUmBCGsSaMg1joKCAxwivAu97Sn7lpLxh/SP7re51A0cJgCkZ5U
 IP7e/r22UxPr2IfFgkC/o6xsZuGD6to=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-EA10XCJIPo6tTfbFRdTUgw-1; Tue, 09 Jun 2020 03:59:38 -0400
X-MC-Unique: EA10XCJIPo6tTfbFRdTUgw-1
Received: by mail-wm1-f72.google.com with SMTP id t145so444362wmt.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 00:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Iug+/inqT2hRTLfHmNbZqFOjoSIThMHU4ueWMMKJYGY=;
 b=rWpgDmgFdxWyvN2X7PiiFjHJVSWxcQuvEHy9vLF6VEaboloZvIe+tZV0oCF17ecIMi
 PhM5hd3+nLNB+bYhOWhhD+hhNxe/gJ/c8aWjhwltTEola72KydirgYRAkJ40Q01wdG5D
 xsKk+pwAeE/Qv85UmdGVEdWt1HRAWzcnEvjuhL6qkYthwkzH/Tgh0kqPJQxqhFDRBd6a
 UifgMMXssUWEmiqZxbvBFSH0oHXqKEDjy3d0y1EgM/g9N0b70iHn42eDxGrbfbWL5yzS
 59gcegDHdD9YFmieIN7PNB/i/UQcWPriy1J4rSU74wfxyD6wULIgm8LHKAc93FIGnW3L
 RS+A==
X-Gm-Message-State: AOAM533GPTcFXLQ+5O6JynVuZ86hmPhHgbl+sHWgTwoBeMRZSPjDt+2a
 FTFkNO4JYr9H7BytJZW7mm8OHd5Zbs6ywybREAqcZp3ab6SwhE46J8IgyMRrQ33o+pJQ1Y+6ohf
 +YQE8rZHMQV7XJGI=
X-Received: by 2002:adf:9205:: with SMTP id 5mr2858315wrj.232.1591689577643;
 Tue, 09 Jun 2020 00:59:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFb11ObdzJcqRWDCQg9wXqoaD215zjF2GodfjtYsemETLqHzlbQ4SmdQmTnw8ZYyaLKvAapg==
X-Received: by 2002:adf:9205:: with SMTP id 5mr2858291wrj.232.1591689577336;
 Tue, 09 Jun 2020 00:59:37 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id x186sm2061050wmg.8.2020.06.09.00.59.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 00:59:36 -0700 (PDT)
Subject: Re: [PATCH v2 04/58] qdev: New qdev_new(), qdev_realize(), etc.
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200529134523.8477-1-armbru@redhat.com>
 <20200529134523.8477-5-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <a82f8ad1-0c53-b9e7-c837-3c05e8b96193@redhat.com>
Date: Tue, 9 Jun 2020 09:59:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529134523.8477-5-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 3:44 PM, Markus Armbruster wrote:
> We commonly plug devices into their bus right when we create them,
> like this:
> 
>     dev = qdev_create(bus, type_name);
> 
> Note that @dev is a weak reference.  The reference from @bus to @dev
> is the only strong one.
> 
> We realize at some later time, either with
> 
>     object_property_set_bool(OBJECT(dev), true, "realized", errp);
> 
> or its convenience wrapper
> 
>     qdev_init_nofail(dev);
> 
> If @dev still has no QOM parent then, realizing makes the
> /machine/unattached/ orphanage its QOM parent.
> 
> Note that the device returned by qdev_create() is plugged into a bus,
> but doesn't have a QOM parent, yet.  Until it acquires one,
> unrealizing the bus will hang in bus_unparent():
> 
>     while ((kid = QTAILQ_FIRST(&bus->children)) != NULL) {
>         DeviceState *dev = kid->child;
>         object_unparent(OBJECT(dev));
>     }
> 
> object_unparent() does nothing when its argument has no QOM parent,
> and the loop spins forever.
> 
> Device state "no QOM parent, but plugged into bus" is dangerous.
> 
> Paolo suggested to delay plugging into the bus until realize.  We need
> to plug into the parent bus before we call the device's realize
> method, in case it uses the parent bus.  So the dangerous state still
> exists, but only within realization, where we can manage it safely.
> 
> This commit creates infrastructure to do this:
> 
>     dev = qdev_new(type_name);
>     ...
>     qdev_realize_and_unref(dev, bus, errp)
> 
> Note that @dev becomes a strong reference here.
> qdev_realize_and_unref() drops it.  There is also plain
> qdev_realize(), which doesn't drop it.
> 
> The remainder of this series will convert all users to this new
> interface.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/qdev-core.h | 11 +++++-
>  hw/core/bus.c          | 14 +++++++
>  hw/core/qdev.c         | 90 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 114 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index b870b27966..fba29308f7 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -57,7 +57,7 @@ typedef void (*BusUnrealize)(BusState *bus);
>   * After successful realization, setting static properties will fail.
>   *
>   * As an interim step, the #DeviceState:realized property can also be
> - * set with qdev_init_nofail().
> + * set with qdev_realize() or qdev_init_nofail().
>   * In the future, devices will propagate this state change to their children
>   * and along busses they expose.
>   * The point in time will be deferred to machine creation, so that values
> @@ -322,7 +322,13 @@ compat_props_add(GPtrArray *arr,
>  
>  DeviceState *qdev_create(BusState *bus, const char *name);
>  DeviceState *qdev_try_create(BusState *bus, const char *name);
> +DeviceState *qdev_new(const char *name);
> +DeviceState *qdev_try_new(const char *name);
>  void qdev_init_nofail(DeviceState *dev);
> +bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
> +bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
> +void qdev_unrealize(DeviceState *dev);
> +
>  void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
>                                   int required_for_version);
>  HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
> @@ -411,6 +417,9 @@ typedef int (qdev_walkerfn)(DeviceState *dev, void *opaque);
>  void qbus_create_inplace(void *bus, size_t size, const char *typename,
>                           DeviceState *parent, const char *name);
>  BusState *qbus_create(const char *typename, DeviceState *parent, const char *name);
> +bool qbus_realize(BusState *bus, Error **errp);
> +void qbus_unrealize(BusState *bus);
> +
>  /* Returns > 0 if either devfn or busfn skip walk somewhere in cursion,
>   *         < 0 if either devfn or busfn terminate walk somewhere in cursion,
>   *           0 otherwise. */
> diff --git a/hw/core/bus.c b/hw/core/bus.c
> index 33a4443217..6f6071f5fa 100644
> --- a/hw/core/bus.c
> +++ b/hw/core/bus.c
> @@ -164,6 +164,20 @@ BusState *qbus_create(const char *typename, DeviceState *parent, const char *nam
>      return bus;
>  }
>  
> +bool qbus_realize(BusState *bus, Error **errp)
> +{
> +    Error *err = NULL;
> +
> +    object_property_set_bool(OBJECT(bus), true, "realized", &err);
> +    error_propagate(errp, err);
> +    return !err;
> +}
> +
> +void qbus_unrealize(BusState *bus)
> +{
> +    object_property_set_bool(OBJECT(bus), false, "realized", &error_abort);
> +}
> +
>  static bool bus_get_realized(Object *obj, Error **errp)
>  {
>      BusState *bus = BUS(obj);
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index a68ba674db..f2c5cee278 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -176,6 +176,32 @@ DeviceState *qdev_try_create(BusState *bus, const char *type)
>      return dev;
>  }
>  
> +/*
> + * Create a device on the heap.
> + * A type @name must exist.
> + * This only initializes the device state structure and allows
> + * properties to be set.  The device still needs to be realized.  See
> + * qdev-core.h.
> + */
> +DeviceState *qdev_new(const char *name)
> +{
> +    return DEVICE(object_new(name));
> +}
> +
> +/*
> + * Try to create a device on the heap.
> + * This is like qdev_new(), except it returns %NULL when type @name
> + * does not exist.
> + */
> +DeviceState *qdev_try_new(const char *name)
> +{
> +    if (!object_class_by_name(name)) {
> +        return NULL;
> +    }
> +
> +    return DEVICE(object_new(name));

Or:

       return qdev_new(name);
> +}
> +
>  static QTAILQ_HEAD(, DeviceListener) device_listeners
>      = QTAILQ_HEAD_INITIALIZER(device_listeners);
>  
> @@ -427,6 +453,66 @@ void qdev_init_nofail(DeviceState *dev)
>      object_unref(OBJECT(dev));
>  }
>  
> +/*
> + * Realize @dev.
> + * @dev must not be plugged into a bus.
> + * Plug @dev into @bus if non-null, else into the main system bus.

So this is the historical part...

> + * This takes a reference to @dev.
> + * If @dev has no QOM parent, make one up, taking another reference.
> + * On success, return true.
> + * On failure, store an error through @errp and return false.
> + */
> +bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
> +{
> +    Error *err = NULL;
> +
> +    assert(!dev->realized && !dev->parent_bus);
> +
> +    if (!bus) {
> +        /*
> +         * Assert that the device really is a SysBusDevice before we
> +         * put it onto the sysbus.  Non-sysbus devices which aren't
> +         * being put onto a bus should be realized with
> +         * object_property_set_bool(OBJECT(dev), true, "realized",
> +         * errp);
> +         */
> +        g_assert(object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE));
> +        bus = sysbus_get_default();

OK, so we take a QDEV argument.

If we have a BUS argument, we use it as parent bus.

If we don't have a BUS argument, we expect the device is a SYSBUSDEV and
use sysbus_get_default as parent bus.

So we can not use this function realize a QDEV which is not a SYSBUSDEV.
For that, we have to use 'object_property_set_bool(OBJECT(QDEV), true,
"realized")'.

IOW:
- to realize a QDEV, we have to use the OBJECT API,
- to realize a SYSBUSDEV, we have to use the QDEV API.

I'm not suggesting you to clean that now, I'm simply taking notes about
future improvements, because this is really not clear for new contributors.

> +    }
> +
> +    qdev_set_parent_bus(dev, bus);
> +
> +    object_property_set_bool(OBJECT(dev), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +    }
> +    return !err;
> +}
> +
> +/*
> + * Realize @dev and drop a reference.
> + * This is like qdev_realize(), except the caller must hold a
> + * (private) reference, which is dropped on return regardless of
> + * success or failure.  Intended use:
> + *     dev = qdev_new();
> + *     [...]
> + *     qdev_realize_and_unref(dev, bus, errp);
> + * Now @dev can go away without further ado.
> + */
> +bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp)
> +{
> +    bool ret;
> +
> +    ret = qdev_realize(dev, bus, errp);
> +    object_unref(OBJECT(dev));
> +    return ret;
> +}
> +
> +void qdev_unrealize(DeviceState *dev)
> +{
> +    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
> +}
> +
>  static int qdev_assert_realized_properly(Object *obj, void *opaque)
>  {
>      DeviceState *dev = DEVICE(object_dynamic_cast(obj, TYPE_DEVICE));
> @@ -1002,6 +1088,10 @@ post_realize_fail:
>  fail:
>      error_propagate(errp, local_err);
>      if (unattached_parent) {
> +        /*
> +         * Beware, this doesn't just revert
> +         * object_property_add_child(), it also runs bus_remove()!
> +         */
>          object_unparent(OBJECT(dev));
>          unattached_count--;
>      }
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


