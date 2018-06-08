Received: from eggs.gnu.org ([2001:4830:134:3::10]:44462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRChO-0000Uc-5G
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRChK-0000Fa-6m
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:24:42 -0400
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-3-david@redhat.com>
	<20180608093406.30c878ec@bahia.lan>
	<4f518685-fcdb-7c3a-35d3-5a26374e0604@redhat.com>
	<20180608094657.4043502f@bahia.lan>
	<20180608082058.GQ3344@umbus.fritz.box>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9425c563-5e5e-9695-19bb-7d266828ea58@redhat.com>
Date: Fri, 8 Jun 2018 10:24:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180608082058.GQ3344@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/8] spapr: no need to verify the node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 08.06.2018 10:20, David Gibson wrote:
> On Fri, Jun 08, 2018 at 09:46:57AM +0200, Greg Kurz wrote:
>> On Fri, 8 Jun 2018 09:42:48 +0200
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>> On 08.06.2018 09:34, Greg Kurz wrote:
>>>> On Thu,  7 Jun 2018 18:52:12 +0200
>>>> David Hildenbrand <david@redhat.com> wrote:
>>>>   
>>>>> The node property can always be queried and the value has already been
>>>>> verified in pc_dimm_realize().
>>>>>
>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>> ---
>>>>>  hw/ppc/spapr.c | 9 +--------
>>>>>  1 file changed, 1 insertion(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>>> index 2375cbee12..d038f3243e 100644
>>>>> --- a/hw/ppc/spapr.c
>>>>> +++ b/hw/ppc/spapr.c
>>>>> @@ -3578,14 +3578,7 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
>>>>>              error_setg(errp, "Memory hotplug not supported for this machine");
>>>>>              return;
>>>>>          }
>>>>> -        node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP, errp);
>>>>> -        if (*errp) {  
>>>>
>>>> Good riddance :)
>>>>   
>>>>> -            return;
>>>>> -        }
>>>>> -        if (node < 0 || node >= MAX_NODES) {
>>>>> -            error_setg(errp, "Invaild node %d", node);
>>>>> -            return;
>>>>> -        }
>>>>> +        node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP, NULL);  
>>>>
>>>> Maybe pass &error_abort ?  
>>>
>>> I'm using the same access scheme as in hw/acpi/memory_hotplug.c
>>>
>>> ("error ignored" vs. "error leads to an abort") - but this will actually
>>> never fail. But I can use error_abort here, does not matter.
>>>
>>
>> Heh, /me paranoid but this is David's call and he acked that already
>> so I guess it's okay.
> 
> Actually, I missed this - error_abort is preferable.  That's general
> the right choice for things that shouldn't ever fail.  This way if
> they *do* fail we get a clear error immediately.

error_abort it is :)

> 
>> Reviewed-by: Greg Kurz <groug@kaod.org>
> 
> 


-- 

Thanks,

David / dhildenb
