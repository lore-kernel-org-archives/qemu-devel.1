Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D195C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2F920758
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJZV4p7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2F920758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb9XK-0003kH-Gt
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jb9WZ-0003J9-Hs
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:11:43 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:37814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jb9WX-0003DO-WD
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:11:43 -0400
Received: by mail-il1-x141.google.com with SMTP id n11so918221ilj.4
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G3eiMPALaGyVwqUiv5nIRCLk5czfyJdXMejw8+2tsOw=;
 b=MJZV4p7HK8GT1aVCUlU6vhd5nXuwH1WHMH1dfOyK3YJR4sBkwGWRkv/i0/J4VJ6/b1
 wG96T5eNhsQ14gleC2BHCENSHO2BqLiT1P+g+dfRoH+kBLNTA3XKWRwKwDof+dza98tR
 Bf5OLF2kZUGq6E4voAZAHkIZ0BG966BpOPbvsfe+eV53J01joMCOtardVzgOV53tGQLT
 nkojhBEr40eih2w8tc3ZK5GwZV9of8kviKCFEpHVwklODl5F5+cU/w+Y9Yj4336VzaX7
 kmr6q488GcnKHcZBqPsTgYVx8o2H2+/noyJENBeRKKexCrGr0n1ss9AZ80eMxZ4XCdfy
 Oqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G3eiMPALaGyVwqUiv5nIRCLk5czfyJdXMejw8+2tsOw=;
 b=gWgD50iPK38Ubx+ycPkcPGDBv+sqgqX+0X/m4mlCypc9qvH3LqEzeYiYhPDzFk5OXC
 H/AHjxcdbUFDcOzSJZdsW1nD015I24IRlDoz+c94vfpATuoAThO+1Q9wWq+6ZifysvAE
 AqKga2OQkjLd/fLr7Pbhqin1HhxkabHotCvNjJYjvKnf6m9XDF5fc0nG+r93fz7HPA8o
 /Ixjmdye4IjIBhmLJ5KBE1bRM3EOvPmQ687OlxZFhVggDDb0B5lpNsdaNjEj/GwGFrNm
 cRrIl4+52E4B2Lfoj4k5Q1XboJ+DmOA8Dwul8jbA14iVQcUu5vsQqxKrrylkBHjrdX7R
 cYRA==
X-Gm-Message-State: AOAM530s79zFZTQ6dq0rNjSWAMwQ2daZ/AHj0NGIZLh9lgPL3sy3lk0Y
 m+oiBpCF7D6IVtGeTOKqiaZkQaQVCxDFrWnjFqmTvlZT
X-Google-Smtp-Source: ABdhPJzHWKPKRchH4Hyl85zrzK4K/X+NWYbqEota7AL7uxo//pETRuG192GteVAsIe6j3rfPPLP7SFBLzYAN6pfkEkc=
X-Received: by 2002:a92:48d1:: with SMTP id j78mr1016986ilg.131.1589922700620; 
 Tue, 19 May 2020 14:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-4-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-4-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2020 14:02:47 -0700
Message-ID: <CAKmqyKP6ccwxc+6DoxJ3kH1uA-PLL47OMxw9RjBzcMXHo3S9Fw@mail.gmail.com>
Subject: Re: [PATCH 03/55] qdev: New qdev_new(), qdev_realize(), etc.
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 19, 2020 at 8:11 AM Markus Armbruster <armbru@redhat.com> wrote:
>
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
> ---
>  include/hw/qdev-core.h | 11 ++++-
>  hw/core/bus.c          | 14 +++++++
>  hw/core/qdev.c         | 94 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 118 insertions(+), 1 deletion(-)
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
> index 08c5eab24a..bf622604a3 100644
> --- a/hw/core/bus.c
> +++ b/hw/core/bus.c
> @@ -169,6 +169,20 @@ BusState *qbus_create(const char *typename, DeviceState *parent, const char *nam
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
> +    object_property_set_bool(OBJECT(bus), true, "realized", &error_abort);

Not false?

Alistair

> +}
> +
>  static bool bus_get_realized(Object *obj, Error **errp)
>  {
>      BusState *bus = BUS(obj);
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index a68ba674db..82deeb7841 100644
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
> +}
> +
>  static QTAILQ_HEAD(, DeviceListener) device_listeners
>      = QTAILQ_HEAD_INITIALIZER(device_listeners);
>
> @@ -427,6 +453,70 @@ void qdev_init_nofail(DeviceState *dev)
>      object_unref(OBJECT(dev));
>  }
>
> +/*
> + * Realize @dev.
> + * @dev must not be plugged into a bus.
> + * Plug @dev into @bus if non-null, else into the main system bus.
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
> +    }
> +
> +    qdev_set_parent_bus(dev, bus);
> +
> +    object_ref(OBJECT(dev));
> +    object_property_set_bool(OBJECT(dev), true, "realized", &err);
> +    if (err) {
> +        error_propagate_prepend(errp, err,
> +                                "Initialization of device %s failed: ",
> +                                object_get_typename(OBJECT(dev)));
> +    }
> +    object_unref(OBJECT(dev));
> +    return !err;
> +}
> +
> +/*
> + * Realize @dev and drop a reference.
> + * This is like qdev_realize(), except it steals a reference rather
> + * than take one to plug @dev into @bus.  On failure, it drops that
> + * reference instead.  Intended use:
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
> @@ -1002,6 +1092,10 @@ post_realize_fail:
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
> --
> 2.21.1
>
>

