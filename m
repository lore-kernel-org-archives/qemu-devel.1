Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E098C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9AF02074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NcH3EUOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AF02074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiawe-0001qz-2C
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 05:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jiavo-0001R3-Ol
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 05:52:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58910
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jiavm-0005Jy-Tr
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 05:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591696346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lWjqfah+Zpe3jl6NBIraprVxi+dcH+E/8q9RRqPaxAA=;
 b=NcH3EUOUV90z4EN6xn7kToU0h93uDm4DaARZsdZ+nlfsgRVK5YJ1uPs++MfimBv7Snpq9B
 ds4V4O4SO1VoehrRqaUiL/CdsMdMoxcHZfVGd5w59NBAGTzA6UVJA2sPODxajpprm6/Zum
 PMivORrEZ4StOeAeobdXjuMyMBqdejM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-l4ts3sJnMTqYraoGZbsJ7Q-1; Tue, 09 Jun 2020 05:52:24 -0400
X-MC-Unique: l4ts3sJnMTqYraoGZbsJ7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EB0B8014D4;
 Tue,  9 Jun 2020 09:52:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB29578FC5;
 Tue,  9 Jun 2020 09:52:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7D71F11386A6; Tue,  9 Jun 2020 11:52:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 04/58] qdev: New qdev_new(), qdev_realize(), etc.
References: <20200529134523.8477-1-armbru@redhat.com>
 <20200529134523.8477-5-armbru@redhat.com>
 <a82f8ad1-0c53-b9e7-c837-3c05e8b96193@redhat.com>
Date: Tue, 09 Jun 2020 11:52:15 +0200
In-Reply-To: <a82f8ad1-0c53-b9e7-c837-3c05e8b96193@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 9 Jun 2020 09:59:35
 +0200")
Message-ID: <87r1uopnw0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 5/29/20 3:44 PM, Markus Armbruster wrote:
>> We commonly plug devices into their bus right when we create them,
>> like this:
>>=20
>>     dev =3D qdev_create(bus, type_name);
>>=20
>> Note that @dev is a weak reference.  The reference from @bus to @dev
>> is the only strong one.
>>=20
>> We realize at some later time, either with
>>=20
>>     object_property_set_bool(OBJECT(dev), true, "realized", errp);
>>=20
>> or its convenience wrapper
>>=20
>>     qdev_init_nofail(dev);
>>=20
>> If @dev still has no QOM parent then, realizing makes the
>> /machine/unattached/ orphanage its QOM parent.
>>=20
>> Note that the device returned by qdev_create() is plugged into a bus,
>> but doesn't have a QOM parent, yet.  Until it acquires one,
>> unrealizing the bus will hang in bus_unparent():
>>=20
>>     while ((kid =3D QTAILQ_FIRST(&bus->children)) !=3D NULL) {
>>         DeviceState *dev =3D kid->child;
>>         object_unparent(OBJECT(dev));
>>     }
>>=20
>> object_unparent() does nothing when its argument has no QOM parent,
>> and the loop spins forever.
>>=20
>> Device state "no QOM parent, but plugged into bus" is dangerous.
>>=20
>> Paolo suggested to delay plugging into the bus until realize.  We need
>> to plug into the parent bus before we call the device's realize
>> method, in case it uses the parent bus.  So the dangerous state still
>> exists, but only within realization, where we can manage it safely.
>>=20
>> This commit creates infrastructure to do this:
>>=20
>>     dev =3D qdev_new(type_name);
>>     ...
>>     qdev_realize_and_unref(dev, bus, errp)
>>=20
>> Note that @dev becomes a strong reference here.
>> qdev_realize_and_unref() drops it.  There is also plain
>> qdev_realize(), which doesn't drop it.
>>=20
>> The remainder of this series will convert all users to this new
>> interface.
>>=20
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Cc: Alistair Francis <alistair@alistair23.me>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  include/hw/qdev-core.h | 11 +++++-
>>  hw/core/bus.c          | 14 +++++++
>>  hw/core/qdev.c         | 90 ++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 114 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index b870b27966..fba29308f7 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -57,7 +57,7 @@ typedef void (*BusUnrealize)(BusState *bus);
>>   * After successful realization, setting static properties will fail.
>>   *
>>   * As an interim step, the #DeviceState:realized property can also be
>> - * set with qdev_init_nofail().
>> + * set with qdev_realize() or qdev_init_nofail().
>>   * In the future, devices will propagate this state change to their chi=
ldren
>>   * and along busses they expose.
>>   * The point in time will be deferred to machine creation, so that valu=
es
>> @@ -322,7 +322,13 @@ compat_props_add(GPtrArray *arr,
>> =20
>>  DeviceState *qdev_create(BusState *bus, const char *name);
>>  DeviceState *qdev_try_create(BusState *bus, const char *name);
>> +DeviceState *qdev_new(const char *name);
>> +DeviceState *qdev_try_new(const char *name);
>>  void qdev_init_nofail(DeviceState *dev);
>> +bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
>> +bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **er=
rp);
>> +void qdev_unrealize(DeviceState *dev);
>> +
>>  void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
>>                                   int required_for_version);
>>  HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
>> @@ -411,6 +417,9 @@ typedef int (qdev_walkerfn)(DeviceState *dev, void *=
opaque);
>>  void qbus_create_inplace(void *bus, size_t size, const char *typename,
>>                           DeviceState *parent, const char *name);
>>  BusState *qbus_create(const char *typename, DeviceState *parent, const =
char *name);
>> +bool qbus_realize(BusState *bus, Error **errp);
>> +void qbus_unrealize(BusState *bus);
>> +
>>  /* Returns > 0 if either devfn or busfn skip walk somewhere in cursion,
>>   *         < 0 if either devfn or busfn terminate walk somewhere in cur=
sion,
>>   *           0 otherwise. */
>> diff --git a/hw/core/bus.c b/hw/core/bus.c
>> index 33a4443217..6f6071f5fa 100644
>> --- a/hw/core/bus.c
>> +++ b/hw/core/bus.c
>> @@ -164,6 +164,20 @@ BusState *qbus_create(const char *typename, DeviceS=
tate *parent, const char *nam
>>      return bus;
>>  }
>> =20
>> +bool qbus_realize(BusState *bus, Error **errp)
>> +{
>> +    Error *err =3D NULL;
>> +
>> +    object_property_set_bool(OBJECT(bus), true, "realized", &err);
>> +    error_propagate(errp, err);
>> +    return !err;
>> +}
>> +
>> +void qbus_unrealize(BusState *bus)
>> +{
>> +    object_property_set_bool(OBJECT(bus), false, "realized", &error_abo=
rt);
>> +}
>> +
>>  static bool bus_get_realized(Object *obj, Error **errp)
>>  {
>>      BusState *bus =3D BUS(obj);
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index a68ba674db..f2c5cee278 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -176,6 +176,32 @@ DeviceState *qdev_try_create(BusState *bus, const c=
har *type)
>>      return dev;
>>  }
>> =20
>> +/*
>> + * Create a device on the heap.
>> + * A type @name must exist.
>> + * This only initializes the device state structure and allows
>> + * properties to be set.  The device still needs to be realized.  See
>> + * qdev-core.h.
>> + */
>> +DeviceState *qdev_new(const char *name)
>> +{
>> +    return DEVICE(object_new(name));
>> +}
>> +
>> +/*
>> + * Try to create a device on the heap.
>> + * This is like qdev_new(), except it returns %NULL when type @name
>> + * does not exist.
>> + */
>> +DeviceState *qdev_try_new(const char *name)
>> +{
>> +    if (!object_class_by_name(name)) {
>> +        return NULL;
>> +    }
>> +
>> +    return DEVICE(object_new(name));
>
> Or:
>
>        return qdev_new(name);

Yes, that's better.

>> +}
>> +
>>  static QTAILQ_HEAD(, DeviceListener) device_listeners
>>      =3D QTAILQ_HEAD_INITIALIZER(device_listeners);
>> =20
>> @@ -427,6 +453,66 @@ void qdev_init_nofail(DeviceState *dev)
>>      object_unref(OBJECT(dev));
>>  }
>> =20
>> +/*
>> + * Realize @dev.
>> + * @dev must not be plugged into a bus.
>> + * Plug @dev into @bus if non-null, else into the main system bus.
>
> So this is the historical part...

Yes, same behavior as qdev_create(), to ease conversion.

>> + * This takes a reference to @dev.
>> + * If @dev has no QOM parent, make one up, taking another reference.
>> + * On success, return true.
>> + * On failure, store an error through @errp and return false.
>> + */
>> +bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
>> +{
>> +    Error *err =3D NULL;
>> +
>> +    assert(!dev->realized && !dev->parent_bus);
>> +
>> +    if (!bus) {
>> +        /*
>> +         * Assert that the device really is a SysBusDevice before we
>> +         * put it onto the sysbus.  Non-sysbus devices which aren't
>> +         * being put onto a bus should be realized with
>> +         * object_property_set_bool(OBJECT(dev), true, "realized",
>> +         * errp);
>> +         */
>> +        g_assert(object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE))=
;
>> +        bus =3D sysbus_get_default();
>
> OK, so we take a QDEV argument.
>
> If we have a BUS argument, we use it as parent bus.
>
> If we don't have a BUS argument, we expect the device is a SYSBUSDEV and
> use sysbus_get_default as parent bus.
>
> So we can not use this function realize a QDEV which is not a SYSBUSDEV.
> For that, we have to use 'object_property_set_bool(OBJECT(QDEV), true,
> "realized")'.

Correct.

> IOW:
> - to realize a QDEV, we have to use the OBJECT API,

To realize a bus-less device, actually.

> - to realize a SYSBUSDEV, we have to use the QDEV API.

To realize a device that plugs into a bus, including the sysbus
pseudo-bus.

> I'm not suggesting you to clean that now, I'm simply taking notes about
> future improvements, because this is really not clear for new contributor=
s.

You're right, it's less than clear at this point of the series.

PATCH 46 gets rid of the unintuitive "null means main system bus" in
qdev_realize().

PATCH 54 makes qdev_realize() support bus-less devices the obvious way:
pass a null bus argument.  PATCH 55+56 put that to use.

No realization with object_property_set_bool() remains.

I figure I could've made review easier by better explaining where the
series is headed.

>> +    }
>> +
>> +    qdev_set_parent_bus(dev, bus);
>> +
>> +    object_property_set_bool(OBJECT(dev), true, "realized", &err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +    }
>> +    return !err;
>> +}
>> +
>> +/*
>> + * Realize @dev and drop a reference.
>> + * This is like qdev_realize(), except the caller must hold a
>> + * (private) reference, which is dropped on return regardless of
>> + * success or failure.  Intended use:
>> + *     dev =3D qdev_new();
>> + *     [...]
>> + *     qdev_realize_and_unref(dev, bus, errp);
>> + * Now @dev can go away without further ado.
>> + */
>> +bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **er=
rp)
>> +{
>> +    bool ret;
>> +
>> +    ret =3D qdev_realize(dev, bus, errp);
>> +    object_unref(OBJECT(dev));
>> +    return ret;
>> +}
>> +
>> +void qdev_unrealize(DeviceState *dev)
>> +{
>> +    object_property_set_bool(OBJECT(dev), false, "realized", &error_abo=
rt);
>> +}
>> +
>>  static int qdev_assert_realized_properly(Object *obj, void *opaque)
>>  {
>>      DeviceState *dev =3D DEVICE(object_dynamic_cast(obj, TYPE_DEVICE));
>> @@ -1002,6 +1088,10 @@ post_realize_fail:
>>  fail:
>>      error_propagate(errp, local_err);
>>      if (unattached_parent) {
>> +        /*
>> +         * Beware, this doesn't just revert
>> +         * object_property_add_child(), it also runs bus_remove()!
>> +         */
>>          object_unparent(OBJECT(dev));
>>          unattached_count--;
>>      }
>>=20
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!


