Received: from eggs.gnu.org ([2001:4830:134:3::10]:46942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9U17-00035p-Nf
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 07:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9U14-0002Ml-Fe
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 07:48:05 -0400
References: <20180926094219.20322-1-david@redhat.com>
	<20180926094219.20322-19-david@redhat.com>
	<20180927150141.60a6488a@redhat.com>
	<dc5d7b2d-5b51-2c0b-aac7-ebf04a4e7859@redhat.com>
	<20181001152443.2cca5c5e@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <85d59b49-25d7-6485-843c-838324cbc52e@redhat.com>
Date: Mon, 8 Oct 2018 13:47:53 +0200
MIME-Version: 1.0
In-Reply-To: <20181001152443.2cca5c5e@redhat.com>
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

> That way using [2] and [1 - modulo it should match only concrete type]
> machine would be able to override hotplug handlers for TYPE_VIRTIO_PMEM_PCI
> and explicitly call machine + pci hotplug handlers in necessary order.
> 
> flow would look like:
>   [acpi|shcp|native pci-e eject]->  
>        hotplug_ctrl = qdev_get_hotplug_handler(dev);
>        hotplug_handler_unplug(hotplug_ctrl, dev, &local_err); ->
>             machine_unplug()
>                machine_virtio_pci_pmem_cb(): 
>                   // we now that's device has 2 stage hotplug handlers,
>                   // so we can arrange hotplug sequence in necessary order
>                   hotplug_ctrl2 = qdev_get_bus_hotplug_handler(dev);
> 
>                   //then do unplug in whatever order that's correct,
>                   // I'd assume tear down/stop PCI device first, flushing
>                   // command virtio command queues and that unplug memory itself.
>                   hotplug_handler_unplug(hotplug_ctrl2, dev, &local_err);
>                   memory_device_unplug()
> 

Looking into the details, this order is not possible. The unplug will
essentially do a device_unparent() leading to the whole hierarchy
getting destroyed. The memory_device part always has to come first.


> Similar logic applies to device_add/device_del paths, with a difference that
> origin point would be monitor/qmp.
> 
> Point is to have a single explicit callback chain that applies to a concrete
> device type. That way if ever change an ordering of calling plug callbacks
> in qdev core, the expected for a device callback sequence would still
> remain in place ensuring that device (un)plugged as expected.
> 
> Also it should be easier to trace for a reader, than 2 disjoint callbacks of
> composite device (which only know to author of that device and then only
> till he/she remembers how that thing works).
> 


-- 

Thanks,

David / dhildenb
