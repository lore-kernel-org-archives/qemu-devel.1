Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E736BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 04:27:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A1E20756
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 04:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrYeFKLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A1E20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbGK4-0003D2-Lt
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 00:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jbGJJ-0002GU-FC
 for qemu-devel@nongnu.org; Wed, 20 May 2020 00:26:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37701
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jbGJH-0001T6-KA
 for qemu-devel@nongnu.org; Wed, 20 May 2020 00:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589948785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=keeP0g4+7CfMOY7JCHcbFjV/j3Ckov2deZH8doyD188=;
 b=MrYeFKLdv0QGyeDpnTvGdBRTP29wY7LNYwzwOgBKRQOEgjv3L7kNnnNfWfI9w4n3dOGXqw
 GG92t8XcuKR8cgzjEcreHQ6n7et6fgv9M31H+Cnnzc537qz+6GAhdgsQbSA0I0Mb8+eMvK
 1rTDSX6EJmD8PC1FcqPcEjp089MQKPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-LUBi6E1WPJSqJadGUpQvZQ-1; Wed, 20 May 2020 00:26:22 -0400
X-MC-Unique: LUBi6E1WPJSqJadGUpQvZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBD61800053;
 Wed, 20 May 2020 04:26:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FC3F10013D9;
 Wed, 20 May 2020 04:26:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1112C11358BC; Wed, 20 May 2020 06:26:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alistair Francis <alistair23@gmail.com>
Subject: Re: [PATCH 03/55] qdev: New qdev_new(), qdev_realize(), etc.
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-4-armbru@redhat.com>
 <CAKmqyKP6ccwxc+6DoxJ3kH1uA-PLL47OMxw9RjBzcMXHo3S9Fw@mail.gmail.com>
Date: Wed, 20 May 2020 06:26:13 +0200
In-Reply-To: <CAKmqyKP6ccwxc+6DoxJ3kH1uA-PLL47OMxw9RjBzcMXHo3S9Fw@mail.gmail.com>
 (Alistair Francis's message of "Tue, 19 May 2020 14:02:47 -0700")
Message-ID: <87mu63ut96.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

Alistair Francis <alistair23@gmail.com> writes:

> On Tue, May 19, 2020 at 8:11 AM Markus Armbruster <armbru@redhat.com> wrote:
>>
>> We commonly plug devices into their bus right when we create them,
>> like this:
>>
>>     dev = qdev_create(bus, type_name);
>>
>> Note that @dev is a weak reference.  The reference from @bus to @dev
>> is the only strong one.
>>
>> We realize at some later time, either with
>>
>>     object_property_set_bool(OBJECT(dev), true, "realized", errp);
>>
>> or its convenience wrapper
>>
>>     qdev_init_nofail(dev);
>>
>> If @dev still has no QOM parent then, realizing makes the
>> /machine/unattached/ orphanage its QOM parent.
>>
>> Note that the device returned by qdev_create() is plugged into a bus,
>> but doesn't have a QOM parent, yet.  Until it acquires one,
>> unrealizing the bus will hang in bus_unparent():
>>
>>     while ((kid = QTAILQ_FIRST(&bus->children)) != NULL) {
>>         DeviceState *dev = kid->child;
>>         object_unparent(OBJECT(dev));
>>     }
>>
>> object_unparent() does nothing when its argument has no QOM parent,
>> and the loop spins forever.
>>
>> Device state "no QOM parent, but plugged into bus" is dangerous.
>>
>> Paolo suggested to delay plugging into the bus until realize.  We need
>> to plug into the parent bus before we call the device's realize
>> method, in case it uses the parent bus.  So the dangerous state still
>> exists, but only within realization, where we can manage it safely.
>>
>> This commit creates infrastructure to do this:
>>
>>     dev = qdev_new(type_name);
>>     ...
>>     qdev_realize_and_unref(dev, bus, errp)
>>
>> Note that @dev becomes a strong reference here.
>> qdev_realize_and_unref() drops it.  There is also plain
>> qdev_realize(), which doesn't drop it.
>>
>> The remainder of this series will convert all users to this new
>> interface.
>>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Cc: Alistair Francis <alistair@alistair23.me>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  include/hw/qdev-core.h | 11 ++++-
>>  hw/core/bus.c          | 14 +++++++
>>  hw/core/qdev.c         | 94 ++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 118 insertions(+), 1 deletion(-)
>>
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
>>   * In the future, devices will propagate this state change to their children
>>   * and along busses they expose.
>>   * The point in time will be deferred to machine creation, so that values
>> @@ -322,7 +322,13 @@ compat_props_add(GPtrArray *arr,
>>
>>  DeviceState *qdev_create(BusState *bus, const char *name);
>>  DeviceState *qdev_try_create(BusState *bus, const char *name);
>> +DeviceState *qdev_new(const char *name);
>> +DeviceState *qdev_try_new(const char *name);
>>  void qdev_init_nofail(DeviceState *dev);
>> +bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
>> +bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
>> +void qdev_unrealize(DeviceState *dev);
>> +
>>  void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
>>                                   int required_for_version);
>>  HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
>> @@ -411,6 +417,9 @@ typedef int (qdev_walkerfn)(DeviceState *dev, void *opaque);
>>  void qbus_create_inplace(void *bus, size_t size, const char *typename,
>>                           DeviceState *parent, const char *name);
>>  BusState *qbus_create(const char *typename, DeviceState *parent, const char *name);
>> +bool qbus_realize(BusState *bus, Error **errp);
>> +void qbus_unrealize(BusState *bus);
>> +
>>  /* Returns > 0 if either devfn or busfn skip walk somewhere in cursion,
>>   *         < 0 if either devfn or busfn terminate walk somewhere in cursion,
>>   *           0 otherwise. */
>> diff --git a/hw/core/bus.c b/hw/core/bus.c
>> index 08c5eab24a..bf622604a3 100644
>> --- a/hw/core/bus.c
>> +++ b/hw/core/bus.c
>> @@ -169,6 +169,20 @@ BusState *qbus_create(const char *typename, DeviceState *parent, const char *nam
>>      return bus;
>>  }
>>
>> +bool qbus_realize(BusState *bus, Error **errp)
>> +{
>> +    Error *err = NULL;
>> +
>> +    object_property_set_bool(OBJECT(bus), true, "realized", &err);
>> +    error_propagate(errp, err);
>> +    return !err;
>> +}
>> +
>> +void qbus_unrealize(BusState *bus)
>> +{
>> +    object_property_set_bool(OBJECT(bus), true, "realized", &error_abort);
>
> Not false?
>
> Alistair

Reasons it's &error_abort:

1. PATCH 06 and 07 transform variations of

      object_property_set_bool(..., false, "realized", &error_abort);

   to

      qdev_unrealize(...);

   No untransformed unrealization remain.  Thus, we always abort on
   unrealization error before this series.

2. If unrealize could fail, we'd be in deep trouble.  Recent commit
   b69c3c21a5 "qdev: Unrealize must not fail" explains:

   Devices may have component devices and buses.

   Device realization may fail.  Realization is recursive: a device's
   realize() method realizes its components, and device_set_realized()
   realizes its buses (which should in turn realize the devices on that
   bus, except bus_set_realized() doesn't implement that, yet).

   When realization of a component or bus fails, we need to roll back:
   unrealize everything we realized so far.  If any of these unrealizes
   failed, the device would be left in an inconsistent state.  Must not
   happen.

   device_set_realized() lets it happen: it ignores errors in the roll
   back code starting at label child_realize_fail.

   Since realization is recursive, unrealization must be recursive, too.
   But how could a partly failed unrealize be rolled back?  We'd have to
   re-realize, which can fail.  This design is fundamentally broken.

   device_set_realized() does not roll back at all.  Instead, it keeps
   unrealizing, ignoring further errors.

   It can screw up even for a device with no buses: if the lone
   dc->unrealize() fails, it still unregisters vmstate, and calls
   listeners' unrealize() callback.

   bus_set_realized() does not roll back either.  Instead, it stops
   unrealizing.

   Fortunately, no unrealize method can fail, as we'll see below.

Clearer now?

With any luck, people will use the simpler qdev_unrealize() and
qbus_unrealize(), which is the form that doesn't let them get the error
handling wrong.  I like it when interfaces make misuse hard :)


