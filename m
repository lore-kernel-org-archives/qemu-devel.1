Received: from eggs.gnu.org ([209.51.188.92]:42678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gk9qw-0002VF-Rj
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gk9qr-00062a-6z
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:45:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45654
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gk9qp-0005pU-8F
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:45:03 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0HFi4M2078657
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 10:44:59 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q2vbh0tjb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 10:44:59 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Thu, 17 Jan 2019 15:44:58 -0000
References: <1546969050-8884-1-git-send-email-pmorel@linux.ibm.com>
	<1546969050-8884-2-git-send-email-pmorel@linux.ibm.com>
	<be2d1126-45a9-ace2-bf85-18f255815572@redhat.com>
	<e5c4fa66-b83d-7f98-4f05-ccf26375a3ac@redhat.com>
	<3f286f5b-9403-4a4d-5af0-1c0297c0b97e@linux.ibm.com>
	<879a92e3-cfd9-b26f-a45a-ab8c20c5ffaa@redhat.com>
	<20190114104436.46ab183c.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Thu, 17 Jan 2019 10:44:54 -0500
MIME-Version: 1.0
In-Reply-To: <20190114104436.46ab183c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b2cf21a6-e27c-8422-81c0-e82000e0510d@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v7] s390x/pci: add common
 function measurement block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: pmorel@linux.ibm.com, qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, thuth@redhat.com, rth@twiddle.net

On 1/14/19 4:44 AM, Cornelia Huck wrote:
> On Mon, 14 Jan 2019 10:23:58 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 14.01.19 10:18, Pierre Morel wrote:
>>> On 09/01/2019 12:43, David Hildenbrand wrote:
>>>> On 09.01.19 12:29, David Hildenbrand wrote:
>>>>> On 08.01.19 18:37, Pierre Morel wrote:
>>>>>> From: Yi Min Zhao <zyimin@linux.ibm.com>
>>>>>>
>>>>>> Common function measurement block is used to report zPCI internal
>>>>>> counters of successful pcilg/stg/stb and rpcit instructions to
>>>>>> a memory location provided by the program.
>>>>>>
>>>>>> This patch introduces a new ZpciFmb structure and schedules a timer
>>>>>> callback to copy the zPCI measures to the FMB in the guest memory
>>>>>> at an interval time set to 4s.
>>>>>>
>>>>>> An error while attemping to update the FMB, would generate an error
>>>>>> event to the guest.
>>>>>>
>>>>>> The pcilg/stg/stb and rpcit interception handlers increase the
>>>>>> related counter on a successful call.
>>>>>> The guest shall pass a null FMBA (FMB address) in the FIB (Function
>>>>>> Information Block) when it issues a Modify PCI Function Control
>>>>>> instruction to switch off FMB and stop the corresponding timer.
>>>>>>
>>>>>> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
>>>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>>>> ---
>>>>>>    hw/s390x/s390-pci-bus.c  |   4 +-
>>>>>>    hw/s390x/s390-pci-bus.h  |  29 +++++++++++
>>>>>>    hw/s390x/s390-pci-inst.c | 133 +++++++++++++++++++++++++++++++++++++++++++++--
>>>>>>    hw/s390x/s390-pci-inst.h |   1 +
>>>>>>    4 files changed, 163 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>>>>> index 060ff06..f0d34dd 100644
>>>>>> --- a/hw/s390x/s390-pci-bus.c
>>>>>> +++ b/hw/s390x/s390-pci-bus.c
>>>>>> @@ -989,6 +989,7 @@ static void s390_pcihost_hot_unplug(HotplugHandler *hotplug_dev,
>>>>>>        bus = pci_get_bus(pci_dev);
>>>>>>        devfn = pci_dev->devfn;
>>>>>>        object_unparent(OBJECT(pci_dev));
>>>>>> +    fmb_timer_free(pbdev);
>>>>>
>>>>> I still think this is the wrong place. it has nothing to do with
>>>>> hotplug/unplug. This belongs into unrealize/finalize.
>>>>>
>>>>>   
>>>>
>>>> ... but I see the issue. It boils down to the bad design of zPCI. The
>>>> PCI device has no clue about the pbdev. So this has to stay here because
>>>> in unrealize of pbdev it would be wrong and into unrealize of pci_dev,
>>>> we can't move it.
>>>>   
>>>
>>> OK, thanks.
>>> So is it a ack from you?
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>>
>> :)
> 
> Great!
> 
> Still waiting for an ack from Collin (nudge, nudge :) before applying
> this.
> 

Whoops, thought I already acked this one -- sorry!

I give this my full Reviewed-by: Collin Walling <walling@linux.ibm.com>
