Received: from eggs.gnu.org ([2001:4830:134:3::10]:36396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gXoZw-0005UL-Jp
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:36:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gXoZt-0007OO-6A
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:36:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33408
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gXoZs-0007AS-Nv
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:36:32 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBEETEKS105335
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 09:36:13 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pccs6w8kq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 09:36:13 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Fri, 14 Dec 2018 14:36:12 -0000
References: <1544718402-8703-1-git-send-email-akrowiak@linux.ibm.com>
	<20181214130953.53d3dd4d@oc2783563651>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Fri, 14 Dec 2018 09:36:08 -0500
MIME-Version: 1.0
In-Reply-To: <20181214130953.53d3dd4d@oc2783563651>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <facee25d-f7cd-33e1-0c15-66c9bfc05efe@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] qdev/core: Can not replug device on bus
 that allows one device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: qemu-devel@nongnu.org, mammedo@redhat.com

On 12/14/18 7:09 AM, Halil Pasic wrote:
> On Thu, 13 Dec 2018 11:26:42 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> If the maximum number of devices allowed on a bus is 1 and a device
>> which is plugged into the bus is subsequently unplugged, attempting to replug
>> the device fails with error "Bus 'xxx' does not support hotplugging".
>> The "error" is detected in the qbus_is_full(BusState *bus) function
>> (qdev_monitor.c) because bus->max_index >= bus_class->max_dev. The
>> root of the problem is that the bus->max_index is not decremented when a device
>> is unplugged from the bus. This patch fixes that problem.
>>
> 
> As Pierre has pointed out, the commit message is stale and inaccurate.
> Subject could be better as well. I mean the problem is not limited to
> buses that allow only one device. Each bus that can get full looses
> capacity with every plug/unplug op pair. With that fixed:
> 
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

I'll make the changes recommended by you and Pierre.

> 
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   hw/core/qdev.c         | 3 +++
>>   include/hw/qdev-core.h | 1 +
>>   qdev-monitor.c         | 2 +-
>>   3 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index 6b3cc55b27c2..956923f33520 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -59,6 +59,8 @@ static void bus_remove_child(BusState *bus, DeviceState *child)
>>               snprintf(name, sizeof(name), "child[%d]", kid->index);
>>               QTAILQ_REMOVE(&bus->children, kid, sibling);
>>   
>> +            bus->num_children--;
>> +
>>               /* This gives back ownership of kid->child back to us.  */
>>               object_property_del(OBJECT(bus), name, NULL);
>>               object_unref(OBJECT(kid->child));
>> @@ -73,6 +75,7 @@ static void bus_add_child(BusState *bus, DeviceState *child)
>>       char name[32];
>>       BusChild *kid = g_malloc0(sizeof(*kid));
>>   
>> +    bus->num_children++;
>>       kid->index = bus->max_index++;
>>       kid->child = child;
>>       object_ref(OBJECT(kid->child));
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index a24d0dd566e3..521f0a947ead 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -206,6 +206,7 @@ struct BusState {
>>       HotplugHandler *hotplug_handler;
>>       int max_index;
>>       bool realized;
>> +    int num_children;
>>       QTAILQ_HEAD(ChildrenHead, BusChild) children;
>>       QLIST_ENTRY(BusState) sibling;
>>   };
>> diff --git a/qdev-monitor.c b/qdev-monitor.c
>> index 07147c63bf8b..45a8ba49644c 100644
>> --- a/qdev-monitor.c
>> +++ b/qdev-monitor.c
>> @@ -414,7 +414,7 @@ static DeviceState *qbus_find_dev(BusState *bus, char *elem)
>>   static inline bool qbus_is_full(BusState *bus)
>>   {
>>       BusClass *bus_class = BUS_GET_CLASS(bus);
>> -    return bus_class->max_dev && bus->max_index >= bus_class->max_dev;
>> +    return bus_class->max_dev && bus->num_children >= bus_class->max_dev;
>>   }
>>   
>>   /*
> 
