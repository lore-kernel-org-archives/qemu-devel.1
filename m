Received: from eggs.gnu.org ([2001:4830:134:3::10]:58814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g6yC0-0000WA-Fu
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 09:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g6yBx-0007Jh-PW
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 09:24:56 -0400
Date: Mon, 1 Oct 2018 15:24:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181001152443.2cca5c5e@redhat.com>
In-Reply-To: <dc5d7b2d-5b51-2c0b-aac7-ebf04a4e7859@redhat.com>
References: <20180926094219.20322-1-david@redhat.com>
	<20180926094219.20322-19-david@redhat.com>
	<20180927150141.60a6488a@redhat.com>
	<dc5d7b2d-5b51-2c0b-aac7-ebf04a4e7859@redhat.com>
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

On Fri, 28 Sep 2018 14:21:33 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 27/09/2018 15:01, Igor Mammedov wrote:
> > On Wed, 26 Sep 2018 11:42:13 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> The unplug and unplug_request handlers are special: They are not
> >> executed when unrealizing a device, but rather trigger the removal of a
> >> device from device_del() via object_unparent() - to effectively
> >> unrealize a device.
> >>
> >> If such a device has a child bus and another device attached to
> >> that bus (e.g. how virtio devices are created with their proxy device),
> >> we will not get a call to the unplug handler. As we want to support
> >> hotplug handlers (and especially also some unplug logic to undo resource
> >> assignment) for such devices, we cannot simply call the unplug handler
> >> when unrealizing - it has a different semantic ("trigger removal").
> >>
> >> To handle this scenario, we need a do_unplug handler, that will be
> >> executed for all devices with a hotplug handler.  
> > could you clarify what would be call flow for unplug in this case
> > starting from 'device_del'?  
> 
> Let's work it through for virtio-pmem:
> 
> qemu-system-x86_64 -machine pc -m 8G,maxmem=20G \
>   [...] \
>   -object memory-backend-file,id=mem1,share,mem-path=/dev/zero,size=4G \
>   -device virtio-pmem-pci,id=vp1,memdev=mem1 -monitor stdio
> 
> info qtree gives us:
> 
>    bus: pci.0
>       type PCI
>       dev: virtio-pmem-pci, id "vp1"
> 	[...]
>         bus: virtio-bus
>           type virtio-pci-bus
>           dev: virtio-pmem, id ""
>             memaddr = 9663676416 (0x240000000)
>             memdev = "/objects/mem1"
> 	    [...]
> 
> "device_del vp1":
> 
> qmp_device_del(vp1)->qdev_unplug(vp1)->hotplug_handler_unplug_request(vp1)
> 
> piix4_device_unplug_request_cb(vp1)->acpi_pcihp_device_unplug_cb(vp1)
> 
> -> Guest has to process the request and respond  
> 
> acpi_pcihp_eject_slot(vp1)->object_unparent(vp1)
that's one of the possible call flows, unplug could also originate
from shpc or native pci-e hot-plug.
PCI unplug hasn't ever been factored out from old PCI device/bus code,
so PCIDevice::unrealize takes care of parent resource teardown.
(well, there wasn't any reason to factor it out till we started
talking about hybrid devices).
We probably should do the same refactoring like it was done for
pc-dimm/cpu unplug
(see qdev_get_hotplug_handler()+hotplug_handler_unplug() usage)

> Now, this triggers the unplug of the device hierarchy:
> 
> object_unparent(vp1)->device_unparent(vp1)>device_set_realized(vp1, 0)
> 
> ->bus_set_realized(virtio-bus, 0)->device_set_realized(virtio-pmem, 0)  
> 
> This is the place where this hooks is comes into play:
> 
> ->hotplug_handler_do_unplug(virtio-pmem)->machine  
> handler->virtio_pmem_do_unplug(virtio-pmem)
> 
> Followed by object_unparent(virtio-bus)->bus_unparent(virtio-bus)
> Followed by object_unparent(virtio-pmem)->device_unparent(virtio-pmem)
> 
> 
> At this place, the hierarchy is gone. Hotplug succeeded and the
> virtio-pmem device (memory device) has been properly unplugged.
I'm concerned that both plug and unplug flows are implicit
and handled as if it were separate devices without enforcing
a particular ordering of (un)plug handlers.
It would work right now but it looks rather fragile to me.

If I remember right, the suggested and partially implemented idea
in one of your previous series was to override default hotplug
handler with a machine one for plugged in device [1][2].
However impl. wasn't exactly what I've suggested since it matches
all memory-devices.

1) qdev: let machine hotplug handler to override bus hotplug handler
2) pc: route all memory devices through  the machine hotplug handler

So lets reiterate, we have TYPE_VIRTIO_PMEM and TYPE_VIRTIO_PMEM_PCI
the former implements TYPE_MEMORY_DEVICE interface and the later is
a wrapper PCI/whatnot device shim.
So when you plug that composite device you'd get 2 independent
plug hooks called, which makes it unrelable/broken design.

My next question would be why TYPE_VIRTIO_PMEM_PCI can't implement 
TYPE_MEMORY_DEVICE interface and TYPE_VIRTIO_PMEM be a simple VIRTIO
device without any hotplug hooks (so shim device would proxy all
memory-device logic to its child)?
/huh, then you don't need get_device_id() as well/

That way using [2] and [1 - modulo it should match only concrete type]
machine would be able to override hotplug handlers for TYPE_VIRTIO_PMEM_PCI
and explicitly call machine + pci hotplug handlers in necessary order.

flow would look like:
  [acpi|shcp|native pci-e eject]->  
       hotplug_ctrl = qdev_get_hotplug_handler(dev);
       hotplug_handler_unplug(hotplug_ctrl, dev, &local_err); ->
            machine_unplug()
               machine_virtio_pci_pmem_cb(): 
                  // we now that's device has 2 stage hotplug handlers,
                  // so we can arrange hotplug sequence in necessary order
                  hotplug_ctrl2 = qdev_get_bus_hotplug_handler(dev);

                  //then do unplug in whatever order that's correct,
                  // I'd assume tear down/stop PCI device first, flushing
                  // command virtio command queues and that unplug memory itself.
                  hotplug_handler_unplug(hotplug_ctrl2, dev, &local_err);
                  memory_device_unplug()

Similar logic applies to device_add/device_del paths, with a difference that
origin point would be monitor/qmp.

Point is to have a single explicit callback chain that applies to a concrete
device type. That way if ever change an ordering of calling plug callbacks
in qdev core, the expected for a device callback sequence would still
remain in place ensuring that device (un)plugged as expected.

Also it should be easier to trace for a reader, than 2 disjoint callbacks of
composite device (which only know to author of that device and then only
till he/she remembers how that thing works).
