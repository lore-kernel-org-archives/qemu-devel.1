Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020FECA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 12:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8DF2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 12:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="OqeHt0uE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8DF2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRbLu-0002bg-Cq
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 07:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iRbHf-00074R-Me
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 07:16:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iRbHe-0004rr-AO
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 07:16:35 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:41754)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iRbHV-0004kD-8P; Mon, 04 Nov 2019 07:16:27 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 86FDB96EF0;
 Mon,  4 Nov 2019 12:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1572869778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i6Tpk6AXyDe7PMgxB49odyYmY16dx+pgUnO7RjeK2Fw=;
 b=OqeHt0uEhxkrN7JWB9L6kXvkzTrXnjPyMzBvXANpURMPcHSWjRTet0W5QGrECVhUPhP2JG
 A92fGhkG5KSAoljbfkklBjLmFoWcd9UQIU53ZtmIE/atFeXNEFeECXktMVGoDFfH+ynfDL
 +oxZ04G2c3oJBpfXjpa4+MXviYWrEec=
Subject: Re: [PATCH v5 02/13] hw/core/qdev: add trace events to help with
 resettable transition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-3-damien.hedde@greensocs.com>
 <f5d78215-ee4d-ae1a-74dc-52b3c179d88c@redhat.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <984a87d7-0430-d777-0fe9-ce5cfea712a1@greensocs.com>
Date: Mon, 4 Nov 2019 13:16:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <f5d78215-ee4d-ae1a-74dc-52b3c179d88c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1572869778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i6Tpk6AXyDe7PMgxB49odyYmY16dx+pgUnO7RjeK2Fw=;
 b=XiScZxKkrdroCmK5yR7oO1Ut6xkVx0qLNlSNsCwtOc0t5cm7ls+eUUOCO0KesG6b4lY45r
 UziEglRyeWz2Mia6BWw8QSrNlvOzfcN9Xc/kezmm1MB5yWtEgx6hMZdc1hgKnMr7oEWa64
 Lhs2Ji6yuylOOYJRLNl1zpQt7ndg7jg=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1572869778; a=rsa-sha256; cv=none;
 b=2zp18q1d3Hwped1Y2ZE0nOIR4AtHSHTlcbkctL7BySCzpqHwfrb8SSLcpb3fIx39Vmkhth
 BN1ZmUHvRj1l4BuLMMa59+Tc+ZXBOYqK/oXvV1kDkH3/7PQJKSVQgyzMcJdrZNt85zL4YD
 TogY1+SIrs2F/jWv6PL0prAf4HZB+KA=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 cohuck@redhat.com, mark.burton@greensocs.com, qemu-s390x@nongnu.org,
 edgari@xilinx.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 11/1/19 12:23 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 10/18/19 5:06 PM, Damien Hedde wrote:
>> Adds trace events to reset procedure and when updating the parent
>> bus of a device.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> ---
>> =C2=A0 hw/core/qdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 27 +++++++=
+++++++++++++++++---
>> =C2=A0 hw/core/trace-events |=C2=A0 9 +++++++++
>> =C2=A0 2 files changed, 33 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index 60be2f2fef..f230063189 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -38,6 +38,7 @@
>> =C2=A0 #include "hw/boards.h"
>> =C2=A0 #include "hw/sysbus.h"
>> =C2=A0 #include "migration/vmstate.h"
>> +#include "trace.h"
>> =C2=A0 =C2=A0 bool qdev_hotplug =3D false;
>> =C2=A0 static bool qdev_hot_added =3D false;
>> @@ -98,7 +99,9 @@ void qdev_set_parent_bus(DeviceState *dev, BusState
>> *bus)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool replugging =3D dev->parent_bus !=3D=
 NULL;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (replugging) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Keep a reference to the=
 device while it's not plugged into
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_qdev_update_parent_b=
us(dev, dev->parent_bus, bus);
>=20
> Nitpicking, if you respin, can you add object_get_typename(OBJECT(dev))=
)
> and object_get_typename(OBJECT(bus)))?

sure. I was wondering if having some kind of qom object support to trace
would be feasible. Because it's a bit tedious to add this each time. And
IMO it would be more useful to have the path, but we can't reasonably
compute it as a trace_..() arguments.

>=20
> With/without it:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Keep a reference t=
o the device while it's not plugged into
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * any bus=
, to avoid it potentially evaporating when it is
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * dereffe=
d in bus_remove_child().
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> @@ -272,6 +275,18 @@ HotplugHandler
>> *qdev_get_hotplug_handler(DeviceState *dev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return hotplug_ctrl;
>> =C2=A0 }
>> =C2=A0 +static int qdev_prereset(DeviceState *dev, void *opaque)
>> +{
>> +=C2=A0=C2=A0=C2=A0 trace_qdev_reset_tree(dev, object_get_typename(OBJ=
ECT(dev)));
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static int qbus_prereset(BusState *bus, void *opaque)
>> +{
>> +=C2=A0=C2=A0=C2=A0 trace_qbus_reset_tree(bus, object_get_typename(OBJ=
ECT(bus)));
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> =C2=A0 static int qdev_reset_one(DeviceState *dev, void *opaque)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_legacy_reset(dev);
>> @@ -282,6 +297,7 @@ static int qdev_reset_one(DeviceState *dev, void
>> *opaque)
>> =C2=A0 static int qbus_reset_one(BusState *bus, void *opaque)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BusClass *bc =3D BUS_GET_CLASS(bus);
>> +=C2=A0=C2=A0=C2=A0 trace_qbus_reset(bus, object_get_typename(OBJECT(b=
us)));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bc->reset) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bc->reset(bus);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -290,7 +306,9 @@ static int qbus_reset_one(BusState *bus, void
>> *opaque)
>> =C2=A0 =C2=A0 void qdev_reset_all(DeviceState *dev)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 qdev_walk_children(dev, NULL, NULL, qdev_reset_one=
,
>> qbus_reset_one, NULL);
>> +=C2=A0=C2=A0=C2=A0 trace_qdev_reset_all(dev, object_get_typename(OBJE=
CT(dev)));
>> +=C2=A0=C2=A0=C2=A0 qdev_walk_children(dev, qdev_prereset, qbus_preres=
et,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_rese=
t_one, qbus_reset_one, NULL);
>> =C2=A0 }
>> =C2=A0 =C2=A0 void qdev_reset_all_fn(void *opaque)
>> @@ -300,7 +318,9 @@ void qdev_reset_all_fn(void *opaque)
>> =C2=A0 =C2=A0 void qbus_reset_all(BusState *bus)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 qbus_walk_children(bus, NULL, NULL, qdev_reset_one=
,
>> qbus_reset_one, NULL);
>> +=C2=A0=C2=A0=C2=A0 trace_qbus_reset_all(bus, object_get_typename(OBJE=
CT(bus)));
>> +=C2=A0=C2=A0=C2=A0 qbus_walk_children(bus, qdev_prereset, qbus_preres=
et,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_rese=
t_one, qbus_reset_one, NULL);
>> =C2=A0 }
>> =C2=A0 =C2=A0 void qbus_reset_all_fn(void *opaque)
>> @@ -1108,6 +1128,7 @@ void device_legacy_reset(DeviceState *dev)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceClass *klass =3D DEVICE_GET_CLASS=
(dev);
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 trace_qdev_reset(dev, object_get_typename(O=
BJECT(dev)));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (klass->reset) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 klass->reset(de=
v);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> diff --git a/hw/core/trace-events b/hw/core/trace-events
>> index fe47a9c8cb..1a669be0ea 100644
>> --- a/hw/core/trace-events
>> +++ b/hw/core/trace-events
>> @@ -1,2 +1,11 @@
>> =C2=A0 # loader.c
>> =C2=A0 loader_write_rom(const char *name, uint64_t gpa, uint64_t size,=
 bool
>> isrom) "%s: @0x%"PRIx64" size=3D0x%"PRIx64" ROM=3D%d"
>> +
>> +# qdev.c
>> +qdev_reset(void *obj, const char *objtype) "obj=3D%p(%s)"
>> +qdev_reset_all(void *obj, const char *objtype) "obj=3D%p(%s)"
>> +qdev_reset_tree(void *obj, const char *objtype) "obj=3D%p(%s)"
>> +qbus_reset(void *obj, const char *objtype) "obj=3D%p(%s)"
>> +qbus_reset_all(void *obj, const char *objtype) "obj=3D%p(%s)"
>> +qbus_reset_tree(void *obj, const char *objtype) "obj=3D%p(%s)"
>> +qdev_update_parent_bus(void *obj, void *oldp, void *newp) "obj=3D%p
>> old_parent=3D%p new_parent=3D%p"
>>

