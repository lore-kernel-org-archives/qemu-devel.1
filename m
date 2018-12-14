Received: from eggs.gnu.org ([2001:4830:134:3::10]:34899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gXja1-0008GZ-LG
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:16:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gXjZt-0002LI-JB
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:16:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gXjZt-0002K0-5X
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:16:13 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBE99d6t128565
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 04:16:10 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pc4v03dqt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 04:16:10 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 14 Dec 2018 09:16:08 -0000
Reply-To: pmorel@linux.ibm.com
References: <1544718402-8703-1-git-send-email-akrowiak@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 14 Dec 2018 10:16:04 +0100
MIME-Version: 1.0
In-Reply-To: <1544718402-8703-1-git-send-email-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <92cc8705-33cf-49ff-b63f-6297b81df02d@linux.ibm.com>
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
To: Tony Krowiak <akrowiak@linux.ibm.com>, qemu-devel@nongnu.org
Cc: pasic@linux.ibm.com, mammedo@redhat.com

On 13/12/2018 17:26, Tony Krowiak wrote:
> If the maximum number of devices allowed on a bus is 1 and a device
> which is plugged into the bus is subsequently unplugged, attempting to =
replug
> the device fails with error "Bus 'xxx' does not support hotplugging".
> The "error" is detected in the qbus_is_full(BusState *bus) function
> (qdev_monitor.c) because bus->max_index >=3D bus_class->max_dev. The
> root of the problem is that the bus->max_index is not decremented when =
a device
> is unplugged from the bus. This patch fixes that problem.

I think that the root of the problem is that the max_index is not the=20
right measure to determine the number of devices currently plugged.

With the comment amended in this direction:

Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>


>=20
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   hw/core/qdev.c         | 3 +++
>   include/hw/qdev-core.h | 1 +
>   qdev-monitor.c         | 2 +-
>   3 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 6b3cc55b27c2..956923f33520 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -59,6 +59,8 @@ static void bus_remove_child(BusState *bus, DeviceSta=
te *child)
>               snprintf(name, sizeof(name), "child[%d]", kid->index);
>               QTAILQ_REMOVE(&bus->children, kid, sibling);
>=20
> +            bus->num_children--;
> +
>               /* This gives back ownership of kid->child back to us.  *=
/
>               object_property_del(OBJECT(bus), name, NULL);
>               object_unref(OBJECT(kid->child));
> @@ -73,6 +75,7 @@ static void bus_add_child(BusState *bus, DeviceState =
*child)
>       char name[32];
>       BusChild *kid =3D g_malloc0(sizeof(*kid));
>=20
> +    bus->num_children++;
>       kid->index =3D bus->max_index++;
>       kid->child =3D child;
>       object_ref(OBJECT(kid->child));
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index a24d0dd566e3..521f0a947ead 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -206,6 +206,7 @@ struct BusState {
>       HotplugHandler *hotplug_handler;
>       int max_index;
>       bool realized;
> +    int num_children;
>       QTAILQ_HEAD(ChildrenHead, BusChild) children;
>       QLIST_ENTRY(BusState) sibling;
>   };
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 07147c63bf8b..45a8ba49644c 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -414,7 +414,7 @@ static DeviceState *qbus_find_dev(BusState *bus, ch=
ar *elem)
>   static inline bool qbus_is_full(BusState *bus)
>   {
>       BusClass *bus_class =3D BUS_GET_CLASS(bus);
> -    return bus_class->max_dev && bus->max_index >=3D bus_class->max_de=
v;
> +    return bus_class->max_dev && bus->num_children >=3D bus_class->max=
_dev;
>   }
>=20
>   /*
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
