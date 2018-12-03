Received: from eggs.gnu.org ([2001:4830:134:3::10]:40575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gTjUZ-0002bY-7q
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gTjBl-0000eY-2M
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:02:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gTjBk-0000e9-Py
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:02:45 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB37wM0J050195
	for <qemu-devel@nongnu.org>; Mon, 3 Dec 2018 03:02:43 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p50ckrrt2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 03:02:35 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Mon, 3 Dec 2018 08:02:32 -0000
Reply-To: pmorel@linux.ibm.com
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
	<1542904555-1136-3-git-send-email-pmorel@linux.ibm.com>
	<07102a0f-d37e-b9a6-047e-370bc3209686@linux.ibm.com>
	<b2e78d9d-a939-1b5f-df6d-cdc143dfe380@linux.ibm.com>
	<49c28e28-9380-474b-b5d3-5ab61dd0af9e@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 3 Dec 2018 09:02:25 +0100
MIME-Version: 1.0
In-Reply-To: <49c28e28-9380-474b-b5d3-5ab61dd0af9e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <c00e8814-2490-cb8b-6417-efd870ec8573@linux.ibm.com>
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
To: Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc: cohuck@redhat.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, pasic@linux.ibm.com

On 30/11/2018 16:58, Tony Krowiak wrote:
> On 11/30/18 4:31 AM, Pierre Morel wrote:
>> On 29/11/2018 21:42, Tony Krowiak wrote:
>>> On 11/22/18 11:35 AM, Pierre Morel wrote:
>>>> Two good reasons to use the base device as a child of the
>>>> AP BUS:
>>>> - We can easily find the device without traversing the qtree.
>>>> - In case we have different APdevice instantiation, VFIO with
>>>> =C2=A0=C2=A0 interception or emulation, we will need the APDevice as
>>>> =C2=A0=C2=A0 a parent device.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> ---
>>>> =C2=A0 hw/s390x/ap-device.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 22 ++++++++++++++++++++++
>>>> =C2=A0 hw/vfio/ap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++----------
>>>> =C2=A0 include/hw/s390x/ap-device.h |=C2=A0 2 ++
>>>> =C2=A0 3 files changed, 30 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/hw/s390x/ap-device.c b/hw/s390x/ap-device.c
>>>> index f5ac8db..554d5aa 100644
>>>> --- a/hw/s390x/ap-device.c
>>>> +++ b/hw/s390x/ap-device.c
>>>> @@ -11,13 +11,35 @@
>>>> =C2=A0 #include "qemu/module.h"
>>>> =C2=A0 #include "qapi/error.h"
>>>> =C2=A0 #include "hw/qdev.h"
>>>> +#include "hw/s390x/ap-bridge.h"
>>>> =C2=A0 #include "hw/s390x/ap-device.h"
>>>> +APDevice *s390_get_ap(void)
>>>
>>> How about ap_get_device(void)?
>>
>> Yes, keep same conventions.
>>
>>>
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 static DeviceState *apb;
>>>
>>> Why static if you call s390_get_ap_bridge()
>>> to retrieve it without first checking for NULL?
>>
>> static are initialized as NULL.
>=20
> Yes, but down below, you call s390_get_ap_bridge() to set apb
> regardless of whether apb is NULL or not. It makes no sense to
> declare is as static here. It is also redundant because the=20
> s390_get_ap_bridge() function already caches it in a static
> variable.


OK thanks, yes we do not need the static for apb here.



--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
