Received: from eggs.gnu.org ([209.51.188.92]:38849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gk6at-0003tt-BT
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:16:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gk6ar-0002tz-CG
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:16:23 -0500
References: <20190116113523.9213-1-david@redhat.com>
	<20190116113523.9213-4-david@redhat.com>
	<20190116184122.GA27437@kermit-br-ibm-com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ed230124-b4bd-8939-14c0-df8d9f66d60e@redhat.com>
Date: Thu, 17 Jan 2019 13:16:02 +0100
MIME-Version: 1.0
In-Reply-To: <20190116184122.GA27437@kermit-br-ibm-com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH RFC 03/10] qdev: Provide
 qdev_get_bus_hotplug_handler()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>

On 16.01.19 19:41, Murilo Opsfelder Araujo wrote:
> Hi, David.
> 
> On Wed, Jan 16, 2019 at 12:35:16PM +0100, David Hildenbrand wrote:
>> Let's use a wrapper instead of looking it up manually. This function can
>> than be reused when we explicitly want to have the bus hotplug handler
>> (e.g. when the bus hotplug handler was overwritten by the machine
>> hotplug handler).
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/core/qdev.c         | 10 +++++++++-
>>  include/hw/qdev-core.h |  1 +
>>  2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index 7ad45c0bd6..e2207d77a4 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -233,12 +233,20 @@ HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
>>      return NULL;
>>  }
>>
>> +HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev)
>> +{
>> +    if (dev->parent_bus) {
>> +        return dev->parent_bus->hotplug_handler;
>> +    }
>> +    return NULL;
>> +}
>> +
>>  HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
>>  {
>>      HotplugHandler *hotplug_ctrl = qdev_get_machine_hotplug_handler(dev);
>>
>>      if (hotplug_ctrl == NULL && dev->parent_bus) {
> 
> Perhaps we don't need to check dev->parent_bus here since
> qdev_get_bus_hotplug_handler() is already checking it.

This function will also be called from other places (see patch #9), thanks!


-- 

Thanks,

David / dhildenb
