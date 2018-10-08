Received: from eggs.gnu.org ([2001:4830:134:3::10]:50628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g9WHE-0002AQ-RM
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g9WH5-0001ea-64
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:12:49 -0400
Date: Mon, 8 Oct 2018 16:12:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181008161229.5c6bce14@redhat.com>
In-Reply-To: <aa176072-87b1-9e13-6770-97dfc354a1ed@redhat.com>
References: <20180926094219.20322-1-david@redhat.com>
	<20180926094219.20322-19-david@redhat.com>
	<20180927150141.60a6488a@redhat.com>
	<dc5d7b2d-5b51-2c0b-aac7-ebf04a4e7859@redhat.com>
	<20181001152443.2cca5c5e@redhat.com>
	<85d59b49-25d7-6485-843c-838324cbc52e@redhat.com>
	<20181008141904.17b601d3@redhat.com>
	<aa176072-87b1-9e13-6770-97dfc354a1ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: David Hildenbrand <david@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-devel@nongnu.org, "Dr . David Alan
	Gilbert" <dgilbert@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Mon, 8 Oct 2018 14:41:50 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 08/10/2018 14:19, Igor Mammedov wrote:
> > On Mon, 8 Oct 2018 13:47:53 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >>> That way using [2] and [1 - modulo it should match only concrete type]
> >>> machine would be able to override hotplug handlers for TYPE_VIRTIO_PMEM_PCI
> >>> and explicitly call machine + pci hotplug handlers in necessary order.
> >>>
> >>> flow would look like:
> >>>   [acpi|shcp|native pci-e eject]->  
> >>>        hotplug_ctrl = qdev_get_hotplug_handler(dev);
> >>>        hotplug_handler_unplug(hotplug_ctrl, dev, &local_err); ->
> >>>             machine_unplug()
> >>>                machine_virtio_pci_pmem_cb(): 
> >>>                   // we now that's device has 2 stage hotplug handlers,
> >>>                   // so we can arrange hotplug sequence in necessary order
> >>>                   hotplug_ctrl2 = qdev_get_bus_hotplug_handler(dev);
> >>>
> >>>                   //then do unplug in whatever order that's correct,
> >>>                   // I'd assume tear down/stop PCI device first, flushing
> >>>                   // command virtio command queues and that unplug memory itself.
> >>>                   hotplug_handler_unplug(hotplug_ctrl2, dev, &local_err);
> >>>                   memory_device_unplug()
> >>>     
> >>
> >> Looking into the details, this order is not possible. The unplug will
> >> essentially do a device_unparent() leading to the whole hierarchy
> >> getting destroyed. The memory_device part always has to come first.  
> > 
> > Question here is if there are anything that should be handled first on
> > virtio level before memory_device/pmem part is called?
> > If there isn't it might be fine to swap the order of unplug sequence.
> >   
> 
> Was asking myself the same thing, but as we are effectively holding the
> iothread lock and the guest triggered the unplug, I guess it is fine to
> unregister the memory region at this point.
It looks the same to me but I'm not familiar with virtio or PCI.
I'd ask Michael if it's safe thing to do.
