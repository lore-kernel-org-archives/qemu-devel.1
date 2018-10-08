Received: from eggs.gnu.org ([2001:4830:134:3::10]:45657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9V1F-0005tF-7I
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9UrH-0000DJ-1g
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:42:02 -0400
References: <20180926094219.20322-1-david@redhat.com>
	<20180926094219.20322-19-david@redhat.com>
	<20180927150141.60a6488a@redhat.com>
	<dc5d7b2d-5b51-2c0b-aac7-ebf04a4e7859@redhat.com>
	<20181001152443.2cca5c5e@redhat.com>
	<85d59b49-25d7-6485-843c-838324cbc52e@redhat.com>
	<20181008141904.17b601d3@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <aa176072-87b1-9e13-6770-97dfc354a1ed@redhat.com>
Date: Mon, 8 Oct 2018 14:41:50 +0200
MIME-Version: 1.0
In-Reply-To: <20181008141904.17b601d3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 18/24] qdev: hotplug: provide do_unplug
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

On 08/10/2018 14:19, Igor Mammedov wrote:
> On Mon, 8 Oct 2018 13:47:53 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>>> That way using [2] and [1 - modulo it should match only concrete type]
>>> machine would be able to override hotplug handlers for TYPE_VIRTIO_PMEM_PCI
>>> and explicitly call machine + pci hotplug handlers in necessary order.
>>>
>>> flow would look like:
>>>   [acpi|shcp|native pci-e eject]->  
>>>        hotplug_ctrl = qdev_get_hotplug_handler(dev);
>>>        hotplug_handler_unplug(hotplug_ctrl, dev, &local_err); ->
>>>             machine_unplug()
>>>                machine_virtio_pci_pmem_cb(): 
>>>                   // we now that's device has 2 stage hotplug handlers,
>>>                   // so we can arrange hotplug sequence in necessary order
>>>                   hotplug_ctrl2 = qdev_get_bus_hotplug_handler(dev);
>>>
>>>                   //then do unplug in whatever order that's correct,
>>>                   // I'd assume tear down/stop PCI device first, flushing
>>>                   // command virtio command queues and that unplug memory itself.
>>>                   hotplug_handler_unplug(hotplug_ctrl2, dev, &local_err);
>>>                   memory_device_unplug()
>>>   
>>
>> Looking into the details, this order is not possible. The unplug will
>> essentially do a device_unparent() leading to the whole hierarchy
>> getting destroyed. The memory_device part always has to come first.
> 
> Question here is if there are anything that should be handled first on
> virtio level before memory_device/pmem part is called?
> If there isn't it might be fine to swap the order of unplug sequence.
> 

Was asking myself the same thing, but as we are effectively holding the
iothread lock and the guest triggered the unplug, I guess it is fine to
unregister the memory region at this point.

-- 

Thanks,

David / dhildenb
