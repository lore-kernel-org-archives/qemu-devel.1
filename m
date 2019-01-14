Received: from eggs.gnu.org ([209.51.188.92]:53337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gj8Po-0006cZ-8j
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 15:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gj8Pn-0006kN-5m
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 15:00:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gj8Pm-0006ju-Pw
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 15:00:55 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0EJxMQV036689
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 15:00:52 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q10px0vkp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 15:00:52 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Mon, 14 Jan 2019 20:00:50 -0000
References: <20190110210358.24035-1-david@redhat.com>
	<4988f58e-4bc5-c622-53b7-cfda758304e1@redhat.com>
	<20190111103828.058ccc6c.cohuck@redhat.com>
	<c30709c1-9348-e4c9-22bb-95d6183163f3@linux.ibm.com>
	<20190114184431.56795d44.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Mon, 14 Jan 2019 15:00:43 -0500
MIME-Version: 1.0
In-Reply-To: <20190114184431.56795d44.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <beff9759-d95f-4ba6-d049-aada148e162d@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1] s390x/pci: Send correct
 event on hotplug.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 1/14/19 12:44 PM, Cornelia Huck wrote:
> [restored cc:s]
> 
> On Mon, 14 Jan 2019 11:06:19 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 11/01/2019 10:38, Cornelia Huck wrote:
>>> On Fri, 11 Jan 2019 08:16:41 +0100
>>> David Hildenbrand <david@redhat.com> wrote:
>>>   
>>>> On 10.01.19 22:03, David Hildenbrand wrote:  
>>>>> Comit 2c28c490571f ("s390x/pci: let pci devices start in configured mode")
>>>>> changed the initial state of zPCI devices from ZPCI_FS_STANDBY to
>>>>> ZPCI_FS_DISABLED (a.k.a. configured). However we still only send a
>>>>> HP_EVENT_RESERVED_TO_STANDBY event to the guest, indicating a wrong
>>>>> state.
>>>>>
>>>>> Let's send a HP_EVENT_TO_CONFIGURED event instead, to match the actual
>>>>> state the device is in.
>>>>>
>>>>> This fixes hotplugged devices having to be enabled explicitly in the
>>>>> guest e.g. via echo 1 > /sys/bus/pci/slots/00000000/power.
>>>>>
>>>>> Fixes: 2c28c490571f ("s390x/pci: let pci devices start in configured mode")
>>>>> Report-by: Cornelia Huck <cohuck@redhat.com>  
>>>
>>> Cool, works for me as well.
>>>
>>> Tested-by: Cornelia Huck <cohuck@redhat.com>
>>>
>>> Do we want to cc:stable? Probably not, as it's more annoying than
>>> critical, and pci hotplug does not seem to be much used on s390x.
>>>   
>>>>
>>>> If this patch is the right thing to do, then
>>>>
>>>> 1. s/Report-by/Reported-by/
>>>> 2. Dropping the "." from the subject
>>>>
>>>> (yes, it was late)  
>>>
>>> :) Can do while applying.
>>>   
>>>>
>>>> I wonder if we should do both events sequentially, but as I don't have
>>>> access to the architecture I have to rely on that this works :)  
>>>
>>> Yep, let's wait for feedback from folks with architecture access.
>>>   
>>
>> Works fine on the architecture too.
>>
>> Seems the logical thing to do for me.
>>
>> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
> 
> Thanks for checking.
> 
> I'd like to queue this, but I'd like an ack from Collin as well.
> 

Would you mind adding a comment somewhere that states something like
"we can safely bypass the standby state when PCI hotplugging for a guest" 
just to be clear that QEMU is a bit different from how we handle it on the LPAR
level?

That comment would more-or-less clarify why we set the ZPCI_FS_<STATE> directly
to disabled instead of to standby when hotplugging (which, AFAIU, is the order 
how things occur at the LPAR level)

Otherwise,

Reviewed-by: Collin Walling <walling@linux.ibm.com>

>>
>>
>>>>  
>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>> ---
>>>>>   hw/s390x/s390-pci-bus.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>>>> index 15759b6514..7f911b216a 100644
>>>>> --- a/hw/s390x/s390-pci-bus.c
>>>>> +++ b/hw/s390x/s390-pci-bus.c
>>>>> @@ -899,7 +899,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>>>           }
>>>>>   
>>>>>           if (dev->hotplugged) {
>>>>> -            s390_pci_generate_plug_event(HP_EVENT_RESERVED_TO_STANDBY,
>>>>> +            s390_pci_generate_plug_event(HP_EVENT_TO_CONFIGURED ,
>>>>>                                            pbdev->fh, pbdev->fid);
>>>>>           }
>>>>>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
>>>>>      
>>>>
>>>>  
>>>
>>>   
>>
>>
> 
> 


-- 
Respectfully,
- Collin Walling
