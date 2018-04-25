Received: from eggs.gnu.org ([2001:4830:134:3::10]:47628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fBJL1-0003uE-UG
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fBJKy-0002Xv-OM
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:15:55 -0400
Date: Wed, 25 Apr 2018 14:15:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180425141535.5000bcb8@redhat.com>
In-Reply-To: <a048d777-38e5-a44a-c401-a5509ca29e37@redhat.com>
References: <20180420123456.22196-1-david@redhat.com>
	<20180423143147.6b4df2ac@redhat.com>
	<459116211.21924603.1524497545197.JavaMail.zimbra@redhat.com>
	<20180424160011.47475594@redhat.com>
	<a048d777-38e5-a44a-c401-a5509ca29e37@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] pc-dimm: factor out MemoryDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On Tue, 24 Apr 2018 17:42:44 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 24.04.2018 16:00, Igor Mammedov wrote:
> > On Mon, 23 Apr 2018 11:32:25 -0400 (EDT)
> > Pankaj Gupta <pagupta@redhat.com> wrote:
> >   
> >> Hi Igor,
> >>  
> >>>     
> >>>> Right now we can only map PCDIMM/NVDIMM into guest address space. In the
> >>>> future, we might want to do the same for virtio devices - e.g.
> >>>> virtio-pmem or virtio-mem. Especially, they should be able to live side
> >>>> by side to each other.
> >>>>
> >>>> E.g. the virto based memory devices regions will not be exposed via ACPI
> >>>> and friends. They will be detected just like other virtio devices and
> >>>> indicate the applicable memory region. This makes it possible to also use
> >>>> them on architectures without memory device detection support (e.g. s390x).
> >>>>
> >>>> Let's factor out the memory device code into a MemoryDevice interface.    
> >>> A couple of high level questions as relevant code is not here:
> >>>
> >>>   1. what would hotplug/unplug call chain look like in case of virtio-pmem
> >>>   device
> >>>      (reason I'm asking is that pmem being PCI device would trigger
> >>>       PCI bus hotplug controller and then it somehow should piggyback
> >>>       to Machine provided hotplug handlers, so I wonder what kind of
> >>>       havoc it would cause on hotplug infrastructure)    
> >>
> >> For first phase we are using 'virtio-pmem' as cold added devices. AFAIU
> >> 'VirtioDeviceClass' being parent class and 'hotplug/unplug' methods implemented 
> >> for virtio-pmem device. So, pci bus hotplug/unplug should call the corresponding
> >> functions?  
> > the problem is with trying to use PCI bus based device with bus-less
> > infrastructure used by (pc|nv)dimms.  
> 
> I can understand your reasoning, but for me these are some QEMU internal details
> that should not stop the virtio-(p)mem train from rolling.
If it's quickly hacked up prototypes to play with than it's fine
as far as they are not being merged into QEMU.
If one plans to merge it, then code should be adapted to
whatever QEMU internal requirements are.

> In my world, device hotplug is composed of the following steps
> 
> 1. Resource allocation
> 2. Attaching the device to a bus (making it accessible by the guest)
> 3. Notifying the guest
> 
> I would e.g. also call ACPI sort of a bus structure. Now, the machine hotplug
> handler currently does parts of 1. and then hands of to ACPI to do 2 and 3.
it's not a bus, it's concrete device implementing GPE logic,
on x86 it does the job on notifier #3 in case of hotplug.

> virtio-mem and virtio-pmem do 1. partially in the realize function and then
> let 2. and 3. be handled by the proxy device specific hotplug handlers.
> 
> Mean people might say that the machine should not call the ACPI code but there
> should be a ACPI hotplug handler. So we would end up with the same result.
it should be fine for parent to manage its children but not other way around


> But anyhow, the resource allocation (getting an address and getting plugged) will
> be done in the first step out of the virtio-(p)mem realize function:
> 
> static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
> {
>    ...
>    /* try to get a mapping in guest address space */
>     vm->phys_addr = memory_device_get_free_addr(MACHINE(qdev_get_machine))...
this should be a property, and if it's not set then realize should error out

>     if (local_err) {
>         goto out;
>     }
>     ...
> 
>     /* register the memory region */
>     memory_device_plug_region(MACHINE(qdev_get_machine()), vm->mr,
>                               vm->phys_addr);
>    ...
> }
> 
> So this happens before any hotplug handler is called. Everything works
> just fine. What you don't like about this is the qdev_get_machine(). I
> also don't like it but in the short term I don't see any problem with
> it. It is resource allocation and not a "device plug" in the typical form.

It's not qdev_get_machine() that's issue, it's layer violation,
where child device is allocating and mapping resources of one of its parents.

that's been an issue and show stopper for patches in the past,
and that's probably not going to change in this case either.

 
> > The important point which we should not to break here while trying to glue
> > PCI hotplug handler with machine hotplug handler is:  
> 
> I could later on imagine something like a 2 step approach.
> 
> 1. resource allocation handler by a machine for MemoryDevices
> - assigns address, registers memory region
> 2. hotplug handler (ACPI, PCI, CCW ...)
> - assigns bus specific stuff, attaches device, notifies guest
>
> Importantly the device is not visible to the guest until 2.
So far it's about how QEMU models and manages wiring process,
that's why pre_plug/plug handlers were introduced, to allow
resource owner to attach devices that's plugged into it.

i.e. PCI devices are managed by PCI subsystem and DIMM
devices are managed by board where they are mapped into
reserved address space by board code that owns it.

Allowing random device to manage board resources directly
isn't really acceptable (even as temporary solution).

In case of virtio-pmem it might be much cleaner to use
mapping mechanism provided by PCI sybsytem than trying
to bridge bus and buss-less device wiring as from device
modeling point of view (aside from providing RAM to guest)
it's 2 quite different devices.

i.e. if you think new device is RAM, which is governed by
-m option, then model it as bus-less device like dimm and
plug it directly into board, if its plugged in to a bus
it's that bus owner responsibility to allocate/manage
address space or bridge it to parent device.

(btw: virtio-pmem looks sort of like ivshmem, maybe they
can share some code on qemu side)

> Of course, we could also take care of pre-plug things as you mentioned.
> 
> > 
> > container MachineState::device_memory is owned by machine and
> > it's up to machine plug handler (container's owner) to map device's mr
> > into its address space.
> > (i.e. nor device's realize nor PCI bus hotplug handler should do it)  
> 
> I agree, but I think these are internal details.
it's internal details that we choose not to violate in QEMU
and were working towards that direction, getting rid of places
that do it wrongly.

> > Not sure about virtio-mem but if it would use device_memory container,
> > it should use machine's plug handler.
> > 
> > I don't have out head ideas how to glue it cleanly, may be
> > MachineState::device_memory is just not right thing to use
> > for such devices.  
> 
> I strongly disagree. From the user point of view it should not matter what
> was added/plugged. There is just one guest physical memory and maxmem is
> defined for one QEMU instance. Exposing such details to the user should
> definitely be avoided.
qemu user have to be exposed to details as he already adds
 -device virtio-pmem,....
to CLI, maxmem accounting is a separate matter and probably
shouldn't be mixed with device model and how it's mapped into
guest's address space.
