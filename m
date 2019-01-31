Received: from eggs.gnu.org ([209.51.188.92]:39726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gpJc3-0002Ws-A1
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gpJc2-0000Xe-4y
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:11:07 -0500
References: <20190130155733.32742-1-david@redhat.com>
	<20190130155733.32742-5-david@redhat.com>
	<189454f3-61d4-cfff-5449-ae6510fd963a@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <70c1a757-3854-8d9d-0494-a01b0565e00c@redhat.com>
Date: Thu, 31 Jan 2019 22:11:01 +0100
MIME-Version: 1.0
In-Reply-To: <189454f3-61d4-cfff-5449-ae6510fd963a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/6] s390x/pci: Introduce unplug
 requests and split unplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 31.01.19 21:40, Collin Walling wrote:
> On 1/30/19 10:57 AM, David Hildenbrand wrote:
>> PCI on s390x is really weird and how it was modeled in QEMU might not have
>> been the right choice. Anyhow, right now it is the case that:
>> - Hotplugging a PCI device will silently create a zPCI device
>>    (if none is provided)
>> - Hotunplugging a zPCI device will unplug the PCI device (if any)
>> - Hotunplugging a PCI device will unplug also the zPCI device
>> As far as I can see, we can no longer change this behavior. But we
>> should fix it.
>>
>> Both device types are handled via a single hotplug handler call. This
>> is problematic for various reasons:
>> 1. Unplugging via the zPCI device allows to unplug devices that are not
>>     hot removable. (check performed in qdev_unplug()) - bad.
>> 2. Hotplug handler chains are not possible for the unplug case. In the
>>     future, the machine might want to override hotplug handlers, to
>>     process device specific stuff and to then branch off to the actual
>>     hotplug handler. We need separate hotplug handler calls for both the
>>     PCI and zPCI device to make this work reliably. All other PCI
>>     implementations are already prepared to handle this correctly, only
>>     s390x is missing.
>>
>> Therefore, introduce the unplug_request handler and properly perform
>> unplug checks by redirecting to the separate unplug_request handlers.
>> When finally unplugging, perform two separate hotplug_handler_unplug()
>> calls, first for the PCI device, followed by the zPCI device. This now
>> nicely splits unplugging paths for both devices.
>>
>> The redirect part is a little hairy, as the user is allowed to trigger
>> unplug either via the PCI or the zPCI device. So redirect always to the
>> PCI unplug request handler first and remember if that check has been
>> performed in the zPCI device. Redirect then to the zPCI device unplug
>> request handler to perform the magic. Remembering that we already
>> checked the PCI device breaks the redirect loop.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
> 
> Thanks for clearing up some of the areas I was having troubles following
> during the last post. I think this looks a lot better than what we had
> before. Patches 4, 5, and 6 make the code a lot easier to understand
> what is going on here.
> 
> I assume you were able to squeeze in an easy test? At least making sure
> we can still hot unplug a device from a guest successfully?

I only tested under TCG, but I did quite some tests
- Plug/unplug a device
- Disable slot in guest, unplug device
- Plug bridges, try to unplug
- Create hierarchy of bridges (statically and dynamically)
- Plug devices to bridge hierarchies ...

Thanks!

> 
>  From the code perspective:
> 
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> 


-- 

Thanks,

David / dhildenb
