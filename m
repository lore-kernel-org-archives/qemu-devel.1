Received: from eggs.gnu.org ([2001:4830:134:3::10]:50714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gKWZC-0002pq-8i
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 17:44:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gKWZ7-0006dA-0j
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 17:44:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gKWZ6-0006RL-Kt
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 17:44:48 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA7Mi8ei134748
	for <qemu-devel@nongnu.org>; Wed, 7 Nov 2018 17:44:26 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nm6y3w2s6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 17:44:25 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Wed, 7 Nov 2018 22:44:23 -0000
Reply-To: pmorel@linux.ibm.com
References: <1541154621-22423-1-git-send-email-pmorel@linux.ibm.com>
	<1541154621-22423-5-git-send-email-pmorel@linux.ibm.com>
	<20181107134053.0f5929d3.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 7 Nov 2018 23:44:17 +0100
MIME-Version: 1.0
In-Reply-To: <20181107134053.0f5929d3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <e33514cb-1380-a28a-241f-ccf1457422c9@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 4/5] s390x/vfio: ap: Intercepting AP
 Queue Interrupt Control
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

On 07/11/2018 13:40, Cornelia Huck wrote:
> On Fri,  2 Nov 2018 11:30:20 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>=20
>> From: Pierre Morel <pmorel@linux.vnet.ibm.com>
>=20
> Meta: you may want to rewrite your authorship to the shorter address.

right thanks (this patch is in my queue since too long)

>=20
>>
>> We intercept the PQAP(AQIC) instruction.
>>
>> Until we implement AQIC we return a PGM_OPERATION.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   hw/vfio/ap.c                 | 10 ++++++++++
>>   include/hw/s390x/ap-device.h |  9 +++++++++
>>   target/s390x/kvm.c           | 20 ++++++++++++++++++++
>>   3 files changed, 39 insertions(+)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index 3962bb74e5..d8d9cadc46 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -38,6 +38,16 @@ typedef struct VFIOAPDevice {
>>   #define VFIO_AP_DEVICE(obj) \
>>           OBJECT_CHECK(VFIOAPDevice, (obj), VFIO_AP_DEVICE_TYPE)
>>  =20
>> +/*
>> + * ap_pqap
>> + * @env: environment pointing to registers
>> + * return value: Code Condition
>> + */
>> +int ap_pqap(CPUS390XState *env)
>> +{
>> +    return -PGM_OPERATION;
>> +}
>=20
> I'm not sure whether it makes sense to add such a skeleton handler
> here; perhaps we should merge with the next patch that actually does
> something for AQCI?

OK

>=20
>> +
>>   static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>>   {
>>       vdev->needs_reset =3D false;
>> diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device=
.h
>> index 765e9082a3..a83ea096c7 100644
>> --- a/include/hw/s390x/ap-device.h
>> +++ b/include/hw/s390x/ap-device.h
>> @@ -19,4 +19,13 @@ typedef struct APDevice {
>>   #define AP_DEVICE(obj) \
>>       OBJECT_CHECK(APDevice, (obj), AP_DEVICE_TYPE)
>>  =20
>> +#define AP_DEVICE_GET_CLASS(obj) \
>> +    OBJECT_GET_CLASS(APDeviceClass, (obj), AP_DEVICE_TYPE)
>> +
>> +#define AP_DEVICE_CLASS(klass) \
>> +    OBJECT_CLASS_CHECK(APDeviceClass, (klass), AP_DEVICE_TYPE)
>=20
> Looks like an unrelated change -- does that maybe belong into the next
> patch?

Seems indeed.

>=20
>> +
>> +#include "cpu.h"
>> +int ap_pqap(CPUS390XState *env);
>> +
>>   #endif /* HW_S390X_AP_DEVICE_H */
>=20
> The wiring up looks reasonable.
>=20

Thanks,
Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
