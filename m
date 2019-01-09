Received: from eggs.gnu.org ([209.51.188.92]:57773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1ghFu1-0001C3-CI
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:36:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1ghFtz-0006YR-Gy
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:36:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38890
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1ghFtz-0006Wm-A6
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:36:19 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x09FY2e4042860
	for <qemu-devel@nongnu.org>; Wed, 9 Jan 2019 10:36:18 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2pwh80gm9y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 10:36:18 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Wed, 9 Jan 2019 15:36:17 -0000
References: <1545062250-7573-1-git-send-email-akrowiak@linux.ibm.com>
	<112a03e6-3d6c-1c14-10ab-c9cea09ad388@linux.ibm.com>
	<20190108173113.3c2d830c.cohuck@redhat.com>
	<20190108175021.003deab9@oc2783563651>
	<20190108180615.7e48cf13.cohuck@redhat.com>
	<4876194e-1a87-1491-a8b3-eed5b0a9afe6@linux.ibm.com>
	<20190109111419.426ec6d7.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Wed, 9 Jan 2019 10:36:11 -0500
MIME-Version: 1.0
In-Reply-To: <20190109111419.426ec6d7.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a59d5b64-0fb3-4b70-96ff-b1a0c037c6ac@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] qdev/core: fix qbus_is_full()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, imammedo@redhat.com, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Maydell <peter.maydell@linaro.org>

On 1/9/19 5:14 AM, Cornelia Huck wrote:
> On Tue, 8 Jan 2019 15:34:37 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> On 1/8/19 12:06 PM, Cornelia Huck wrote:
>>> On Tue, 8 Jan 2019 17:50:21 +0100
>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>    
>>>> On Tue, 8 Jan 2019 17:31:13 +0100
>>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>>>   
>>>>> On Tue, 8 Jan 2019 11:08:56 -0500
>>>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>>>       
>>>>>> On 12/17/18 10:57 AM, Tony Krowiak wrote:
>>>>>>> The qbus_is_full(BusState *bus) function (qdev_monitor.c) compares the max_index
>>>>>>> value of the BusState structure with the max_dev value of the BusClass structure
>>>>>>> to determine whether the maximum number of children has been reached for the
>>>>>>> bus. The problem is, the max_index field of the BusState structure does not
>>>>>>> necessarily reflect the number of devices that have been plugged into
>>>>>>> the bus.
>>>>>>>
>>>>>>> Whenever a child device is plugged into the bus, the bus's max_index value is
>>>>>>> assigned to the child device and then incremented. If the child is subsequently
>>>>>>> unplugged, the value of the max_index does not change and no longer reflects the
>>>>>>> number of children.
>>>>>>>
>>>>>>> When the bus's max_index value reaches the maximum number of devices
>>>>>>> allowed for the bus (i.e., the max_dev field in the BusClass structure),
>>>>>>> attempts to plug another device will be rejected claiming that the bus is
>>>>>>> full -- even if the bus is actually empty.
>>>>>>>
>>>>>>> To resolve the problem, a new 'num_children' field is being added to the
>>>>>>> BusState structure to keep track of the number of children plugged into the
>>>>>>> bus. It will be incremented when a child is plugged, and decremented when a
>>>>>>> child is unplugged.
>>>>>>>
>>>>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>>>> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
>>>>>>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>>>>>>> ---
>>>>>>>     hw/core/qdev.c         | 3 +++
>>>>>>>     include/hw/qdev-core.h | 1 +
>>>>>>>     qdev-monitor.c         | 2 +-
>>>>>>>     3 files changed, 5 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> Ping ...
>>>>>> I could not determine who the maintainer is for the three files
>>>>>> listed above. I checked the MAINTAINERS file and the prologue of each
>>>>>> individual file. Can someone please tell me who is responsible
>>>>>> for merging these changes? Any additional review comments?
>>>>>>       
>>>>>>>
>>>>>>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>>>>>>> index 6b3cc55b27c2..956923f33520 100644
>>>>>>> --- a/hw/core/qdev.c
>>>>>>> +++ b/hw/core/qdev.c
>>>>>>> @@ -59,6 +59,8 @@ static void bus_remove_child(BusState *bus, DeviceState *child)
>>>>>>>                 snprintf(name, sizeof(name), "child[%d]", kid->index);
>>>>>>>                 QTAILQ_REMOVE(&bus->children, kid, sibling);
>>>>>>>     
>>>>>>> +            bus->num_children--;
>>>>>>> +
>>>>>>>                 /* This gives back ownership of kid->child back to us.  */
>>>>>>>                 object_property_del(OBJECT(bus), name, NULL);
>>>>>>>                 object_unref(OBJECT(kid->child));
>>>>>>> @@ -73,6 +75,7 @@ static void bus_add_child(BusState *bus, DeviceState *child)
>>>>>>>         char name[32];
>>>>>>>         BusChild *kid = g_malloc0(sizeof(*kid));
>>>>>>>     
>>>>>>> +    bus->num_children++;
>>>>>>>         kid->index = bus->max_index++;
>>>>>
>>>>> Hm... I'm wondering what happens for insane numbers of hotplugging
>>>>> operations here?
>>>>>
>>>>> (Preexisting problem for busses without limit, but busses with a limit
>>>>> could now run into that as well.)
>>>>>       
>>>>
>>>> How does this patch change things? I mean bus->num_children gets
>>>> decremented on unplug.
>>>
>>> We don't stop anymore if max_index >= max_dev, which means that we can
>>> now trigger that even if max_dev != 0.
>>
>> I guess I am missing your point. If max_dev == 0, then there is nothing
>> stopping an insane number of hot plug operations; either before this
>> patch, or with this patch. With the patch, once the number of children
>> hot plugged reaches max_dev, the qbus_is_full function will return false
>> and no more children can be plugged. If a child device is unplugged,
>> the num_children - which counts the number of children attached to the
>> bus - will be decremented, so it always reflects the number of children
>> added to the bus. Besides, checking max_index against max_dev
>> is erroneous, because max_index is incremented every time a child device
>> is plugged and is never decremented. It really operates as more of a
>> uinique identifier than a counter and is also used to create a unique
>> property name when the child device is linked to the bus as a property
>> (see bus_add_child function in hw/core/qdev.c).
> 
> Checking num_children against max_dev is the right thing to do, no
> argument here.
> 
> However, max_index continues to be incremented even if devices have
> been unplugged again. That means it can overflow, as it is never bound
> by the max_dev constraint.
> 
> This has been a problem before for busses with an unrestricted number of
> devices before, but with your patch, the problem is now triggerable for
> all busses.
> 
> Not a problem with your patch, but we might want to look into making
> max_index overflow/wraparound save.

I see your point. It does beg the question, what are the chances that
max_index reaches INT_MAX? In the interest of making this code more
bullet proof, I suppose it is something that should be dealt with.

A search reveals that max_index is used in only two places: It is used
to set the index for a child of the bus (i.e., bus_add_child function in
hw/core/qdev.c); and prior to this patch, to determine if max_dev has
been exceeded (i.e., qbus_is_full function in qdev_monitor.c). From
what I can see, the bus child index is used only to generate a property
name of the format "child[%d]" so the child can be linked as a property
of the bus (see bus_add_child and bus_remove_child functions in
hw/core/qdev.c). Wraparound of the max_index would most likely result in
generating a duplicate property name for the child.

I propose two possible solutions:

1. When max_index reaches INT_MAX, do not allow any additional children
    to be added to the bus.

2. Set a max_dev value of INT_MAX for the BusClass instance if the value
    is not set (in the bus_class_init function in hw/core/bus.c).

3. Instead of generating the property name from the BusChild index
    value, generate a UUID string. Since the index field of the BusChild
    appears to be used only to generate the child's name, maybe change
    the index field to a UUID field or a name field.

> 
>>
>>>    
>>>>
>>>> Regards,
>>>> Halil
>>>>   
>>>>>>>         kid->child = child;
>>>>>>>         object_ref(OBJECT(kid->child));
>>>>>>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>>>>>>> index a24d0dd566e3..521f0a947ead 100644
>>>>>>> --- a/include/hw/qdev-core.h
>>>>>>> +++ b/include/hw/qdev-core.h
>>>>>>> @@ -206,6 +206,7 @@ struct BusState {
>>>>>>>         HotplugHandler *hotplug_handler;
>>>>>>>         int max_index;
>>>>>>>         bool realized;
>>>>>>> +    int num_children;
>>>>>>>         QTAILQ_HEAD(ChildrenHead, BusChild) children;
>>>>>>>         QLIST_ENTRY(BusState) sibling;
>>>>>>>     };
>>>>>>> diff --git a/qdev-monitor.c b/qdev-monitor.c
>>>>>>> index 07147c63bf8b..45a8ba49644c 100644
>>>>>>> --- a/qdev-monitor.c
>>>>>>> +++ b/qdev-monitor.c
>>>>>>> @@ -414,7 +414,7 @@ static DeviceState *qbus_find_dev(BusState *bus, char *elem)
>>>>>>>     static inline bool qbus_is_full(BusState *bus)
>>>>>>>     {
>>>>>>>         BusClass *bus_class = BUS_GET_CLASS(bus);
>>>>>>> -    return bus_class->max_dev && bus->max_index >= bus_class->max_dev;
>>>>>>> +    return bus_class->max_dev && bus->num_children >= bus_class->max_dev;
>>>>>>>     }
>>>>>>>     
>>>>>>>     /*
>>>>>>>         
>>>>>
>>>>> The approach the patch takes looks sane to me.
>>>>>       
>>>>   
>>>    
>>
> 
