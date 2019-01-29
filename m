Received: from [209.51.188.92] (port=52395 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1goV6A-0007nw-JW
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:15:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1goV5w-0007r6-WD
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:14:42 -0500
References: <20190121134249.16615-1-david@redhat.com>
	<20190121134249.16615-2-david@redhat.com>
	<7f7d8582-b6d2-b120-c768-8cc8350b416c@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <86377327-ab6d-df3a-b914-688206273bd5@redhat.com>
Date: Tue, 29 Jan 2019 16:14:20 +0100
MIME-Version: 1.0
In-Reply-To: <7f7d8582-b6d2-b120-c768-8cc8350b416c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] s390x/pci: Introduce unplug
 requests and split unplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pmorel@linux.ibm.com, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 29.01.19 14:31, Pierre Morel wrote:
> On 21/01/2019 14:42, David Hildenbrand wrote:
>> PCI on s390x is really weird and how it was modeled in QEMU might not have
>> been the right choice. Anyhow, right now it is the case that:
>> - Hotplugging a PCI device will silently create a zPCI device
>>    (if none is provided)
>> - Hotunplugging a zPCI device will unplug the PCI device (if any)
>> - Hotunplugging a PCI device will unplug also the zPCI device
>> As far as I can see, we can no longer change this behavior. But we
>> should fix it.
> 
> hum, is it really a problem per se?

Yes, because this is not the way it is usually done in QEMU :/

> 
>>
>> Both device types are handled via a single hotplug handler call. This
>> is problematic for various reasons:
>> 1. Unplugging via the zPCI device allows to unplug PCI bridges as
>>     checks are not performed - bad.
> 
> bad
> 
>> 2. Unplugging via the zPCI device allows to unplug devices that are not
>>     hot removable. (check performed in qdev_unplug()) - bad.
> 
> bad
> 
>> 3. Hotplug handler chains are not possible for the unplug case. In the
>>     future, the machine might want to override hotplug handlers, to
>>     process device specific stuff and to then branch off to the actual
>>     hotplug handler. We need separate hotplug handler calls for both the
>>     PCI and zPCI device to make this work reliably. All other PCI
>>     implementations are already prepared to handle this correctly, only
>>     s390x is missing.
> 
> ok
> 
>>
>> Therefore, introduce the unplug_request handler and properly perform
>> unplug checks by redirecting to the separate unplug_request handlers.
>> When finally unplugging, perform two separate hotplug_handler_unplug()
>> calls, first for the PCI device, followed by the zPCI device. This now
>> nicely splits unplugging paths for both devices.
> 
> hum, PCI device handle the backend, host side, while zPCI handle the 
> front end, guest side.
> So unplugging PCI first will deny the guest any possibility to smoothly 
> relinquish a device.
> 
> 
> Is it possible the other way around?

Maybe, but it does not really matter. We unplug both devices
synchronously, without the guest recognizing the order. We always have
the unplug request first that notifies the guest. When we get an ACK
from the guest, we can unpplug both devices in any order.

(and if we want to change the order, we should do it in a separate
patch, this patch does not change the order, just refactors the code)

Thanks!

> 
> Regards,
> Pierre
> 


-- 

Thanks,

David / dhildenb
