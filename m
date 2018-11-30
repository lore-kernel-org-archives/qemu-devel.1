Received: from eggs.gnu.org ([2001:4830:134:3::10]:50004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gShWX-0001z3-0i
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:03:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gShWS-0004y4-0V
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:03:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gShWR-0004xm-NB
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:03:51 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAUBwn4k092459
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 07:03:50 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p342ra5qp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 07:03:50 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 30 Nov 2018 12:03:47 -0000
Reply-To: pmorel@linux.ibm.com
From: Pierre Morel <pmorel@linux.ibm.com>
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
	<1542904555-1136-3-git-send-email-pmorel@linux.ibm.com>
	<07102a0f-d37e-b9a6-047e-370bc3209686@linux.ibm.com>
	<b2e78d9d-a939-1b5f-df6d-cdc143dfe380@linux.ibm.com>
Date: Fri, 30 Nov 2018 13:03:42 +0100
MIME-Version: 1.0
In-Reply-To: <b2e78d9d-a939-1b5f-df6d-cdc143dfe380@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <b265969f-0861-e380-e307-aa7b4f80f1d4@linux.ibm.com>
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
Cc: peter.maydell@linaro.org, david@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, agraf@suse.de, pasic@linux.ibm.com, eric.auger@redhat.com, qemu-s390x@nongnu.org, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net

On 30/11/2018 10:31, Pierre Morel wrote:
> On 29/11/2018 21:42, Tony Krowiak wrote:
>> On 11/22/18 11:35 AM, Pierre Morel wrote:
>>> Two good reasons to use the base device as a child of the
>>> AP BUS:
>>> - We can easily find the device without traversing the qtree.
>>> - In case we have different APdevice instantiation, VFIO with
>>> =C2=A0=C2=A0 interception or emulation, we will need the APDevice as
>>> =C2=A0=C2=A0 a parent device.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>> =C2=A0 hw/s390x/ap-device.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 22 ++++++++++++++++++++++
>>> =C2=A0 hw/vfio/ap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++----------
>>> =C2=A0 include/hw/s390x/ap-device.h |=C2=A0 2 ++
>>> =C2=A0 3 files changed, 30 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/hw/s390x/ap-device.c b/hw/s390x/ap-device.c
>>> index f5ac8db..554d5aa 100644
>>> --- a/hw/s390x/ap-device.c
>>> +++ b/hw/s390x/ap-device.c
>>> @@ -11,13 +11,35 @@
>>> =C2=A0 #include "qemu/module.h"
>>> =C2=A0 #include "qapi/error.h"
>>> =C2=A0 #include "hw/qdev.h"
>>> +#include "hw/s390x/ap-bridge.h"
>>> =C2=A0 #include "hw/s390x/ap-device.h"
>>> +APDevice *s390_get_ap(void)
>>
>> How about ap_get_device(void)?
>=20
> Yes, keep same conventions.

Apropos convention, this function is exported.
So I think the s390 prefix is important.

Pierre


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
