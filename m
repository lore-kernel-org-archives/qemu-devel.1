Received: from eggs.gnu.org ([209.51.188.92]:53228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1h151l-0006vc-Lw
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 03:02:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1h151e-0007gH-9C
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 03:02:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1h151a-0007Zg-NG
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 03:02:08 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x257xDtv132150
	for <qemu-devel@nongnu.org>; Tue, 5 Mar 2019 03:02:02 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r1n0g0pa7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 03:01:59 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Tue, 5 Mar 2019 08:01:54 -0000
Reply-To: pmorel@linux.ibm.com
References: <1545062250-7573-1-git-send-email-akrowiak@linux.ibm.com>
	<3b9ea255-6a77-9309-56d4-6d7fe5a2044c@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 5 Mar 2019 09:01:50 +0100
MIME-Version: 1.0
In-Reply-To: <3b9ea255-6a77-9309-56d4-6d7fe5a2044c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <3eac7ebb-7fe8-6d4e-b7d8-6c676853253a@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] qdev/core: fix qbus_is_full()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>, qemu-devel@nongnu.org
Cc: pasic@linux.ibm.com, imammedo@redhat.com

On 04/03/2019 18:35, Tony Krowiak wrote:
> On 12/17/18 10:57 AM, Tony Krowiak wrote:
>=20
> Ping!! I'm wondering who might be responsible for merging this fix?

To alert the maintainers, you must send the patch with putting them or=20
part of them in CC and put the qemu mailing list in CC too.

use get_maintainer.pl like:

$ ./scripts/get_maintainer.pl -f hw/core/qdev.c
get_maintainer.pl: No maintainers found, printing recent contributors.
get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.

Markus Armbruster <armbru@redhat.com> (commit_signer:4/6=3D67%)
Paolo Bonzini <pbonzini@redhat.com> (commit_signer:3/6=3D50%)
Stefan Hajnoczi <stefanha@redhat.com> (commit_signer:2/6=3D33%)
Peter Xu <peterx@redhat.com> (commit_signer:1/6=3D17%)
"Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> (commit_signer:1/6=3D17%)
qemu-devel@nongnu.org (open list:All patches CC here)


Regards,
Pierre


>=20
>> The qbus_is_full(BusState *bus) function (qdev_monitor.c) compares the=
=20
>> max_index
>> value of the BusState structure with the max_dev value of the BusClass=
=20
>> structure
>> to determine whether the maximum number of children has been reached=20
>> for the
>> bus. The problem is, the max_index field of the BusState structure=20
>> does not
>> necessarily reflect the number of devices that have been plugged into
>> the bus.
>>
>> Whenever a child device is plugged into the bus, the bus's max_index=20
>> value is
>> assigned to the child device and then incremented. If the child is=20
>> subsequently
>> unplugged, the value of the max_index does not change and no longer=20
>> reflects the
>> number of children.
>>
>> When the bus's max_index value reaches the maximum number of devices
>> allowed for the bus (i.e., the max_dev field in the BusClass structure=
),
>> attempts to plug another device will be rejected claiming that the bus=
 is
>> full -- even if the bus is actually empty.
>>
>> To resolve the problem, a new 'num_children' field is being added to t=
he
>> BusState structure to keep track of the number of children plugged=20
>> into the
>> bus. It will be incremented when a child is plugged, and decremented=20
>> when a
>> child is unplugged.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
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
>> =C2=A0 /*
>>
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
