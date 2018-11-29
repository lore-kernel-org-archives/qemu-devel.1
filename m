Received: from eggs.gnu.org ([2001:4830:134:3::10]:36724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gSNpv-00044L-1M
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:02:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gSNpr-00017l-7I
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:02:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gSNpq-000177-V0
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:02:35 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wATEx2jB058870
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 10:02:34 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p2g4x6yag-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 10:02:32 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Thu, 29 Nov 2018 15:02:29 -0000
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
	<1542904555-1136-3-git-send-email-pmorel@linux.ibm.com>
	<20181129124545.18e74622.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 29 Nov 2018 10:02:24 -0500
MIME-Version: 1.0
In-Reply-To: <20181129124545.18e74622.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b56b8efd-2532-5028-d4c4-94d163104dd5@linux.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, pasic@linux.ibm.com

On 11/29/18 6:45 AM, Cornelia Huck wrote:
> On Thu, 22 Nov 2018 17:35:51 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
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
>>   
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
>> +    apb = s390_get_ap_bridge();
>> +    /* We have only a single child on the BUS */
> 
> So, there'll never a mixed environment? Or would that have a 'hybrid'
> ap device?

It is not possible to have interpretation and interception. I suppose
one could mix emulated and virtual AP devices, but that seems highly
unlikely; in fact, I think it is highly unlikely that emulation is ever
implemented.

> 
>> +    bus = qdev_get_child_bus(apb, TYPE_AP_BUS);
>> +    child = QTAILQ_FIRST(&bus->children);
>> +    assert(child != NULL);
>> +    ap = DO_UPCAST(APDevice, parent_obj, child->child);
>> +    return ap;
>> +}
>> +
>>   static void ap_class_init(ObjectClass *klass, void *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>>   
>>       dc->desc = "AP device class";
>> +    dc->bus_type = TYPE_AP_BUS;
>>       dc->hotpluggable = false;
>>   }
>>   
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index 65de952..94e5a1a 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -35,9 +35,6 @@ typedef struct VFIOAPDevice {
>>       VFIODevice vdev;
>>   } VFIOAPDevice;
>>   
>> -#define VFIO_AP_DEVICE(obj) \
>> -        OBJECT_CHECK(VFIOAPDevice, (obj), VFIO_AP_DEVICE_TYPE)
> 
> Hm?

I received a comment from Thomas Huth in Message ID
<2291104a-4cbf-e4fd-3496-fa0910beb96a@redhat.com>
that DO_UPCAST should be avoided in new code. This macro
should probably be restored and an AP_DEVICE() macro added.

> 
>> -
>>   static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>>   {
>>       vdev->needs_reset = false;
> 
