Received: from eggs.gnu.org ([209.51.188.92]:36915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1giyao-0002i1-SM
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1giyan-00063f-Ve
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:31:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57910
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1giyan-0005rK-Q6
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:31:37 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0E9SHhV089036
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 04:31:17 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q0n6spsg8-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 04:31:16 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Mon, 14 Jan 2019 09:31:15 -0000
Reply-To: pmorel@linux.ibm.com
References: <1546969050-8884-1-git-send-email-pmorel@linux.ibm.com>
	<1546969050-8884-2-git-send-email-pmorel@linux.ibm.com>
	<be2d1126-45a9-ace2-bf85-18f255815572@redhat.com>
	<e5c4fa66-b83d-7f98-4f05-ccf26375a3ac@redhat.com>
	<3f286f5b-9403-4a4d-5af0-1c0297c0b97e@linux.ibm.com>
	<879a92e3-cfd9-b26f-a45a-ab8c20c5ffaa@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 14 Jan 2019 10:31:08 +0100
MIME-Version: 1.0
In-Reply-To: <879a92e3-cfd9-b26f-a45a-ab8c20c5ffaa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <b4aa7dfd-2322-d650-7cab-10224a7cebe7@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7] s390x/pci: add common function
 measurement block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, walling@linux.ibm.com
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, rth@twiddle.net, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com, thuth@redhat.com

On 14/01/2019 10:23, David Hildenbrand wrote:
> On 14.01.19 10:18, Pierre Morel wrote:
>> On 09/01/2019 12:43, David Hildenbrand wrote:
>>> On 09.01.19 12:29, David Hildenbrand wrote:
>>>> On 08.01.19 18:37, Pierre Morel wrote:
>>>>> From: Yi Min Zhao <zyimin@linux.ibm.com>
>>>>>
>>>>> Common function measurement block is used to report zPCI internal
>>>>> counters of successful pcilg/stg/stb and rpcit instructions to
>>>>> a memory location provided by the program.
>>>>>
>>>>> This patch introduces a new ZpciFmb structure and schedules a timer
>>>>> callback to copy the zPCI measures to the FMB in the guest memory
>>>>> at an interval time set to 4s.
>>>>>
>>>>> An error while attemping to update the FMB, would generate an error
>>>>> event to the guest.
>>>>>
>>>>> The pcilg/stg/stb and rpcit interception handlers increase the
>>>>> related counter on a successful call.
>>>>> The guest shall pass a null FMBA (FMB address) in the FIB (Function
>>>>> Information Block) when it issues a Modify PCI Function Control
>>>>> instruction to switch off FMB and stop the corresponding timer.
>>>>>
>>>>> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
>>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>>> ---
>>>>>    hw/s390x/s390-pci-bus.c  |   4 +-
>>>>>    hw/s390x/s390-pci-bus.h  |  29 +++++++++++
>>>>>    hw/s390x/s390-pci-inst.c | 133 +++++++++++++++++++++++++++++++++=
++++++++++++--
>>>>>    hw/s390x/s390-pci-inst.h |   1 +
>>>>>    4 files changed, 163 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>>>> index 060ff06..f0d34dd 100644
>>>>> --- a/hw/s390x/s390-pci-bus.c
>>>>> +++ b/hw/s390x/s390-pci-bus.c
>>>>> @@ -989,6 +989,7 @@ static void s390_pcihost_hot_unplug(HotplugHand=
ler *hotplug_dev,
>>>>>        bus =3D pci_get_bus(pci_dev);
>>>>>        devfn =3D pci_dev->devfn;
>>>>>        object_unparent(OBJECT(pci_dev));
>>>>> +    fmb_timer_free(pbdev);
>>>>
>>>> I still think this is the wrong place. it has nothing to do with
>>>> hotplug/unplug. This belongs into unrealize/finalize.
>>>>
>>>>
>>>
>>> ... but I see the issue. It boils down to the bad design of zPCI. The
>>> PCI device has no clue about the pbdev. So this has to stay here beca=
use
>>> in unrealize of pbdev it would be wrong and into unrealize of pci_dev=
,
>>> we can't move it.
>>>
>>
>> OK, thanks.
>> So is it a ack from you?
>=20
> Acked-by: David Hildenbrand <david@redhat.com>
>=20
> :)
>=20

:)
thanks
Pierre

>>
>> regards,
>> Pierre
>>
>=20
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
