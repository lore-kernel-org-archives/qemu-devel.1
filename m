Received: from eggs.gnu.org ([2001:4830:134:3::10]:35825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gXoYW-0004nh-GH
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:35:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gXoYT-0006AR-9O
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:35:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44076
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gXoYT-0006A6-37
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:35:05 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBEETDCQ105266
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 09:35:04 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pccs6w6wq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 09:35:04 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Fri, 14 Dec 2018 14:35:03 -0000
References: <1544718402-8703-1-git-send-email-akrowiak@linux.ibm.com>
	<92cc8705-33cf-49ff-b63f-6297b81df02d@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Fri, 14 Dec 2018 09:35:00 -0500
MIME-Version: 1.0
In-Reply-To: <92cc8705-33cf-49ff-b63f-6297b81df02d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <c8d07af9-3977-5b5b-0ae1-0ec5b632717c@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qdev/core: Can not replug device on bus
 that allows one device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pmorel@linux.ibm.com, qemu-devel@nongnu.org
Cc: pasic@linux.ibm.com, mammedo@redhat.com

On 12/14/18 4:16 AM, Pierre Morel wrote:
> On 13/12/2018 17:26, Tony Krowiak wrote:
>> If the maximum number of devices allowed on a bus is 1 and a device
>> which is plugged into the bus is subsequently unplugged, attempting to=
=20
>> replug
>> the device fails with error "Bus 'xxx' does not support hotplugging".
>> The "error" is detected in the qbus_is_full(BusState *bus) function
>> (qdev_monitor.c) because bus->max_index >=3D bus_class->max_dev. The
>> root of the problem is that the bus->max_index is not decremented when=
=20
>> a device
>> is unplugged from the bus. This patch fixes that problem.
>=20
> I think that the root of the problem is that the max_index is not the=20
> right measure to determine the number of devices currently plugged.
>=20
> With the comment amended in this direction:

Good point, I should have changed that when I refactored this fix.

>=20
> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
>=20
>=20
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>> =C2=A0 hw/core/qdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 3 +++
>> =C2=A0 include/hw/qdev-core.h | 1 +
>> =C2=A0 qdev-monitor.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 2 +-
>> =C2=A0 3 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index 6b3cc55b27c2..956923f33520 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -59,6 +59,8 @@ static void bus_remove_child(BusState *bus,=20
>> DeviceState *child)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 snprintf(name, sizeof(name), "child[%d]", kid->index);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 QTAILQ_REMOVE(&bus->children, kid, sibling);
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bu=
s->num_children--;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* This gives back ownership of kid->child back to us.=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 object_property_del(OBJECT(bus), name, NULL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 object_unref(OBJECT(kid->child));
>> @@ -73,6 +75,7 @@ static void bus_add_child(BusState *bus, DeviceState=
=20
>> *child)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char name[32];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BusChild *kid =3D g_malloc0(sizeof(*kid=
));
>>
>> +=C2=A0=C2=A0=C2=A0 bus->num_children++;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kid->index =3D bus->max_index++;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kid->child =3D child;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_ref(OBJECT(kid->child));
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index a24d0dd566e3..521f0a947ead 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -206,6 +206,7 @@ struct BusState {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HotplugHandler *hotplug_handler;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int max_index;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool realized;
>> +=C2=A0=C2=A0=C2=A0 int num_children;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QTAILQ_HEAD(ChildrenHead, BusChild) chi=
ldren;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QLIST_ENTRY(BusState) sibling;
>> =C2=A0 };
>> diff --git a/qdev-monitor.c b/qdev-monitor.c
>> index 07147c63bf8b..45a8ba49644c 100644
>> --- a/qdev-monitor.c
>> +++ b/qdev-monitor.c
>> @@ -414,7 +414,7 @@ static DeviceState *qbus_find_dev(BusState *bus,=20
>> char *elem)
>> =C2=A0 static inline bool qbus_is_full(BusState *bus)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BusClass *bus_class =3D BUS_GET_CLASS(b=
us);
>> -=C2=A0=C2=A0=C2=A0 return bus_class->max_dev && bus->max_index >=3D b=
us_class->max_dev;
>> +=C2=A0=C2=A0=C2=A0 return bus_class->max_dev && bus->num_children >=3D=
=20
>> bus_class->max_dev;
>> =C2=A0 }
>>
>> =C2=A0 /*
>>
>=20
>=20
