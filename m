Received: from eggs.gnu.org ([2001:4830:134:3::10]:39463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gSLfY-0007va-JN
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gSLYe-0005OZ-VY
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:36:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43130
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gSLYe-0005Nr-N7
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:36:40 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wATCXtNv022372
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 07:36:39 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p2dtbxr6q-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 07:36:39 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Thu, 29 Nov 2018 12:36:37 -0000
Reply-To: pmorel@linux.ibm.com
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
	<1542904555-1136-3-git-send-email-pmorel@linux.ibm.com>
	<20181129124545.18e74622.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 29 Nov 2018 13:36:31 +0100
MIME-Version: 1.0
In-Reply-To: <20181129124545.18e74622.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <f7151299-ae22-10e1-073f-73303ee90262@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/6] s390x/vfio: ap: Use the APdevice as
 a child of the APBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com

On 29/11/2018 12:45, Cornelia Huck wrote:
> On Thu, 22 Nov 2018 17:35:51 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>=20
>> Two good reasons to use the base device as a child of the
>> AP BUS:
>> - We can easily find the device without traversing the qtree.
>> - In case we have different APdevice instantiation, VFIO with
>>    interception or emulation, we will need the APDevice as
>>    a parent device.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   hw/s390x/ap-device.c         | 22 ++++++++++++++++++++++
>>   hw/vfio/ap.c                 | 16 ++++++----------
>>   include/hw/s390x/ap-device.h |  2 ++
>>   3 files changed, 30 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/s390x/ap-device.c b/hw/s390x/ap-device.c
>> index f5ac8db..554d5aa 100644
>> --- a/hw/s390x/ap-device.c
>> +++ b/hw/s390x/ap-device.c
>> @@ -11,13 +11,35 @@
>>   #include "qemu/module.h"
>>   #include "qapi/error.h"
>>   #include "hw/qdev.h"
>> +#include "hw/s390x/ap-bridge.h"
>>   #include "hw/s390x/ap-device.h"
>>  =20
>> +APDevice *s390_get_ap(void)
>> +{
>> +    static DeviceState *apb;
>> +    BusState *bus;
>> +    BusChild *child;
>> +    static APDevice *ap;
>> +
>> +    if (ap) {
>> +        return ap;
>> +    }
>> +
>> +    apb =3D s390_get_ap_bridge();
>> +    /* We have only a single child on the BUS */
>=20
> So, there'll never a mixed environment? Or would that have a 'hybrid'
> ap device?

Not for now, we only support VFIOAPDevice and we can only have one=20
single VFIO device per guest.

>=20
>> +    bus =3D qdev_get_child_bus(apb, TYPE_AP_BUS);
>> +    child =3D QTAILQ_FIRST(&bus->children);
>> +    assert(child !=3D NULL);
>> +    ap =3D DO_UPCAST(APDevice, parent_obj, child->child);
>> +    return ap;
>> +}
>> +
>>   static void ap_class_init(ObjectClass *klass, void *data)
>>   {
>>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>>  =20
>>       dc->desc =3D "AP device class";
>> +    dc->bus_type =3D TYPE_AP_BUS;
>>       dc->hotpluggable =3D false;
>>   }
>>  =20
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index 65de952..94e5a1a 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -35,9 +35,6 @@ typedef struct VFIOAPDevice {
>>       VFIODevice vdev;
>>   } VFIOAPDevice;
>>  =20
>> -#define VFIO_AP_DEVICE(obj) \
>> -        OBJECT_CHECK(VFIOAPDevice, (obj), VFIO_AP_DEVICE_TYPE)
>=20
> Hm?

We do not need this anymore.
We used to plug directly the VFIOAPDevice on the BUS but the APDevice is=20
now plugged on the APBUS.

The VFIOAPDevice is plugged on the APBus through its APDevice.

This will allow to have different APDevice childs using APDevice features.
Usable for interception or emulation.


>=20
>> -
>>   static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>>   {
>>       vdev->needs_reset =3D false;
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
