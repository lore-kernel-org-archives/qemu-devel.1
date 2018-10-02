Received: from eggs.gnu.org ([2001:4830:134:3::10]:46875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g7Ln5-0005M2-Ie
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g7Lab-0002ip-Jb
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:23:58 -0400
Date: Tue, 2 Oct 2018 16:23:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181002162345.7b0197bc@redhat.com>
In-Reply-To: <518ce438-7d6b-6f36-8bac-d834b21fb8bc@redhat.com>
References: <20180926094219.20322-1-david@redhat.com>
	<20180926094219.20322-19-david@redhat.com>
	<20180927150141.60a6488a@redhat.com>
	<dc5d7b2d-5b51-2c0b-aac7-ebf04a4e7859@redhat.com>
	<20181001152443.2cca5c5e@redhat.com>
	<518ce438-7d6b-6f36-8bac-d834b21fb8bc@redhat.com>
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

On Tue, 2 Oct 2018 11:49:09 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 01/10/2018 15:24, Igor Mammedov wrote:
> > On Fri, 28 Sep 2018 14:21:33 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> On 27/09/2018 15:01, Igor Mammedov wrote:  
> >>> On Wed, 26 Sep 2018 11:42:13 +0200
> >>> David Hildenbrand <david@redhat.com> wrote:
> >>>     
> >>>> The unplug and unplug_request handlers are special: They are not
> >>>> executed when unrealizing a device, but rather trigger the removal of a
> >>>> device from device_del() via object_unparent() - to effectively
> >>>> unrealize a device.
> >>>>
> >>>> If such a device has a child bus and another device attached to
> >>>> that bus (e.g. how virtio devices are created with their proxy device),
> >>>> we will not get a call to the unplug handler. As we want to support
> >>>> hotplug handlers (and especially also some unplug logic to undo resource
> >>>> assignment) for such devices, we cannot simply call the unplug handler
> >>>> when unrealizing - it has a different semantic ("trigger removal").
> >>>>
> >>>> To handle this scenario, we need a do_unplug handler, that will be
> >>>> executed for all devices with a hotplug handler.    
> >>> could you clarify what would be call flow for unplug in this case
> >>> starting from 'device_del'?    
> >>
> >> Let's work it through for virtio-pmem:
> >>
> >> qemu-system-x86_64 -machine pc -m 8G,maxmem=20G \
> >>   [...] \
> >>   -object memory-backend-file,id=mem1,share,mem-path=/dev/zero,size=4G \
> >>   -device virtio-pmem-pci,id=vp1,memdev=mem1 -monitor stdio
> >>
> >> info qtree gives us:
> >>
> >>    bus: pci.0
> >>       type PCI
> >>       dev: virtio-pmem-pci, id "vp1"
> >> 	[...]
> >>         bus: virtio-bus
> >>           type virtio-pci-bus
> >>           dev: virtio-pmem, id ""
> >>             memaddr = 9663676416 (0x240000000)
> >>             memdev = "/objects/mem1"
> >> 	    [...]
> >>
> >> "device_del vp1":
> >>
> >> qmp_device_del(vp1)->qdev_unplug(vp1)->hotplug_handler_unplug_request(vp1)
> >>
> >> piix4_device_unplug_request_cb(vp1)->acpi_pcihp_device_unplug_cb(vp1)
> >>  
> >> -> Guest has to process the request and respond    
> >>
> >> acpi_pcihp_eject_slot(vp1)->object_unparent(vp1)  
> > that's one of the possible call flows, unplug could also originate
> > from shpc or native pci-e hot-plug.
> > PCI unplug hasn't ever been factored out from old PCI device/bus code,
> > so PCIDevice::unrealize takes care of parent resource teardown.
> > (well, there wasn't any reason to factor it out till we started
> > talking about hybrid devices).
> > We probably should do the same refactoring like it was done for
> > pc-dimm/cpu unplug
> > (see qdev_get_hotplug_handler()+hotplug_handler_unplug() usage)
> >   
> >> Now, this triggers the unplug of the device hierarchy:
> >>
> >> object_unparent(vp1)->device_unparent(vp1)>device_set_realized(vp1, 0)
> >>  
> >> ->bus_set_realized(virtio-bus, 0)->device_set_realized(virtio-pmem, 0)    
> >>
> >> This is the place where this hooks is comes into play:
> >>  
> >> ->hotplug_handler_do_unplug(virtio-pmem)->machine    
> >> handler->virtio_pmem_do_unplug(virtio-pmem)
> >>
> >> Followed by object_unparent(virtio-bus)->bus_unparent(virtio-bus)
> >> Followed by object_unparent(virtio-pmem)->device_unparent(virtio-pmem)
> >>
> >>
> >> At this place, the hierarchy is gone. Hotplug succeeded and the
> >> virtio-pmem device (memory device) has been properly unplugged.  
> > I'm concerned that both plug and unplug flows are implicit
> > and handled as if it were separate devices without enforcing
> > a particular ordering of (un)plug handlers.
> > It would work right now but it looks rather fragile to me.  
> 
> In my ideal world, the plug+unplug handlers would only perform checks
> and essentially trigger an object_unparent(). (either directly or by
> some guest action).
that's not the purpose of hotplug handlers, it's purpose to setup/teardown
wiring of a device to a controller and/or owner of resources
i.e. where it needs to be connected to.

In case of unplug, object_unparent() is a minimum action that might
take a place to remove a device from parent's scope and destroy
it if there is no references left, however there might be more
things to do before that could happen.

> Inside object_unparent(), the call flow of unrealize steps is defined.
> By moving the "real unplug" part into "do_unplug" and therefor
> essentially calling it when unrealizing, we could generalize this for
> all unplug handlers.
> I think, order of realization and therefore the order of hotplug handler
> calls is strictly defined already. Same applies to unrealization if we
> would factor the essential parts out into e.g. "do_unplug". That order
> is strictly encoded in device_set_realized() and bus_set_realized().

I don't see any benefits in adding do_unplug() in this case,
it would essentially replace hotplug_handler_unplug() in event origin
point with object_unparent() and renaming unplug() to do_unplug().

As result object_unparent() will start do more than unparenting and
destroying the device and a point where unplug originates becomes
poorly documented/lost for a reader among other object_unparent() calls.

hotplug handlers are controller businesses and not the device one so
hiding (generalizing) it inside of device.realize() doesn't look
the right this to do, I'd rather keep these things separate as much
as possible.
 
> > If I remember right, the suggested and partially implemented idea
> > in one of your previous series was to override default hotplug
> > handler with a machine one for plugged in device [1][2].
> > However impl. wasn't exactly what I've suggested since it matches
> > all memory-devices.
> > 
> > 1) qdev: let machine hotplug handler to override bus hotplug handler
> > 2) pc: route all memory devices through  the machine hotplug handler
> > 
> > So lets reiterate, we have TYPE_VIRTIO_PMEM and TYPE_VIRTIO_PMEM_PCI
> > the former implements TYPE_MEMORY_DEVICE interface and the later is
> > a wrapper PCI/whatnot device shim.
> > So when you plug that composite device you'd get 2 independent
> > plug hooks called, which makes it unrelable/broken design.  
> 
> Can you elaborate why this is broken? I don't consider the
> realize/unrealize order broken, and that is where we plug into. But yes,
> we logically plug a device hierarchy and therefore get a separate
> hotplug handler calls.

1st:

consider we have a composite device A that contains B explicitly
manged by A (un)realizefn(). Now if we use your model of independent
callbacks we have only following fixed plug flow possible:
   a>realize()
      ::device_set_realized()
         a:realizefn()
             b->realize()
               ::device_set_realized()
                   b:realizefn()
                   hotplug_handler_plug(b) => b_hotplug_callback
             ...
         hotplug_handler_plug(a) => a_hotplug_callback

that limits composite device wiring to external components to
the only possible order
  1st: b_hotplug_callback() + 2nd: a_hotplug_callback
and other way around for unplug()

That however might not be order we need to do wiring/teardown though,
depending on composite device and controllers it might be necessary to
call callbacks in opposite order or mix both into one to do the wiring
correctly. And to do that we would need drop (move) b_hotplug_callback()
into a_hotplug_callback(), i.e. make it the way I've originally suggested.

hotplug callback call flow might be different in child_bus case
(well, it's different in current code) and it might change in future
(ex: I'm looking into dropping hotplug_handler_post_plug() and
moving hotplug_handler_plug() to a later point to address the same
issue as commits 25e89788/8449bcf94 but without post_plug callback).

It's more robust for devices do not depend heavily on specific order
and define its plug sequence explicitly outside of device core.
This way it won't break apart when device core code is amended. 

2nd:
from user point of view (and API) when composite device is created
we are dealing with 1 device (even if it's composed of many others internally,
it's not an external user business). The same should apply to hotplug
handlers. i.e. wire that device using whatever controllers are necessary
but do not jump through layers inside of device from external code
which hotplug handlers are.

> > My next question would be why TYPE_VIRTIO_PMEM_PCI can't implement 
> > TYPE_MEMORY_DEVICE interface and TYPE_VIRTIO_PMEM be a simple VIRTIO
> > device without any hotplug hooks (so shim device would proxy all
> > memory-device logic to its child)?
> > /huh, then you don't need get_device_id() as well/  
> 
> I had the same idea while going through different options. Then we would
> have to forward all calls directly to the child. We cannot reuse
> TYPE_MEMORY_DEVICE, so we would either need a new interface or define
> the functions we want manually for each such device.
for all I care parent device could alias out its memory-device api to a child
or just outright access/call child internal APIs/members to do the job
(that's what virtio devices often do), but that's the price to pay for
ability to change type of the end device.

> > That way using [2] and [1 - modulo it should match only concrete type]
> > machine would be able to override hotplug handlers for TYPE_VIRTIO_PMEM_PCI
> > and explicitly call machine + pci hotplug handlers in necessary order.
> > 
> > flow would look like:
> >   [acpi|shcp|native pci-e eject]->  
> >        hotplug_ctrl = qdev_get_hotplug_handler(dev);
> >        hotplug_handler_unplug(hotplug_ctrl, dev, &local_err); ->
> >             machine_unplug()
> >                machine_virtio_pci_pmem_cb(): 
> >                   // we now that's device has 2 stage hotplug handlers,
> >                   // so we can arrange hotplug sequence in necessary order
> >                   hotplug_ctrl2 = qdev_get_bus_hotplug_handler(dev);
> > 
> >                   //then do unplug in whatever order that's correct,
> >                   // I'd assume tear down/stop PCI device first, flushing
> >                   // command virtio command queues and that unplug memory itself.
> >                   hotplug_handler_unplug(hotplug_ctrl2, dev, &local_err);
> >                   memory_device_unplug()
> > 
> > Similar logic applies to device_add/device_del paths, with a difference that
> > origin point would be monitor/qmp.  
> 
> Let's see. User calls device_del(). That triggers an unplug_request. For
> virtio-pmem, there is nothing to do.
virtio-pmem is not a concrete device though, it's just internal thingy
inside of concrete device, the actual virtio-pmem-pci device is associated
with a pci controller that notifies guest about unplug request using
whatever hotplug method was configured for the controller (shpc/native pci-e/acpi).

> eject hook is called by the guest. For now we do an object_unparent.
> This would now be wrong. We would have to call a proper hotplug handler
> chain (I guess that's the refactoring you mentioned above).
it works for typical pci devices but it won't work for composite
ones that need access to controllers/resources not provided by
it's direct parent. At minimum it should be object_unparent() wrapped
into unplug() callback  callback set for the pci bus if we'd look for shallow
conversion. But I haven't looked in details...

> > Point is to have a single explicit callback chain that applies to a concrete
> > device type. That way if ever change an ordering of calling plug callbacks
> > in qdev core, the expected for a device callback sequence would still
> > remain in place ensuring that device (un)plugged as expected.  
> 
> I haven't tested yet if this will work, but I can give it a try. I
> learned that in QEMU things often seem easier than they actually are :)
> 
> > 
> > Also it should be easier to trace for a reader, than 2 disjoint callbacks of
> > composite device (which only know to author of that device and then only
> > till he/she remembers how that thing works).  
> 
> In my view it makes things slightly more complicated, because you have
> to follow a hotplug handler chain that plugs devices via proxy devices.
> (e.g. passing through TYPE_MEMORY_DEVICE calls to a child, and therefore
> essentially hotplugging the child), instead of only watching out for
> which device get's hotplugged and finding exactly one hotplug handler.
> Of course, for a device hierarchy, multiple devices get logically
> hotplugged.
it's child only from internal point of view (in virtio design it's
virtio interface to share logic between different transports),
users don't really care about it.
It's job of proxy to forward data between external/internal world,
unfortunately adds more boilerplate but that's how virtio has been
designed.
As for following explicitly defined hotplug handlers chain,
it's explict and relevant parts are close to each other so it's easier
to understand what's going on, than trying to figure out implicit
callbacks sequence and how they are related.

 
