Received: from eggs.gnu.org ([2001:4830:134:3::10]:56958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fBJoa-0001Rv-T6
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fBJoW-0003eg-Rr
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:46:28 -0400
References: <20180420123456.22196-1-david@redhat.com>
	<20180423143147.6b4df2ac@redhat.com>
	<459116211.21924603.1524497545197.JavaMail.zimbra@redhat.com>
	<20180424160011.47475594@redhat.com>
	<a048d777-38e5-a44a-c401-a5509ca29e37@redhat.com>
	<20180425141535.5000bcb8@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <50c25d28-4cac-1e68-c149-e7a5ba8b0f40@redhat.com>
Date: Wed, 25 Apr 2018 14:46:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180425141535.5000bcb8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/3] pc-dimm: factor out MemoryDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>


>>>> For first phase we are using 'virtio-pmem' as cold added devices. AF=
AIU
>>>> 'VirtioDeviceClass' being parent class and 'hotplug/unplug' methods =
implemented=20
>>>> for virtio-pmem device. So, pci bus hotplug/unplug should call the c=
orresponding
>>>> functions? =20
>>> the problem is with trying to use PCI bus based device with bus-less
>>> infrastructure used by (pc|nv)dimms. =20
>>
>> I can understand your reasoning, but for me these are some QEMU intern=
al details
>> that should not stop the virtio-(p)mem train from rolling.
> If it's quickly hacked up prototypes to play with than it's fine
> as far as they are not being merged into QEMU.
> If one plans to merge it, then code should be adapted to
> whatever QEMU internal requirements are.

At one point we will have to decide if we want to develop good software
(which tolerates layer violations if there is a good excuse) or build
the perfect internal architecture. And we all know the latter is not the
case right now and never will be.

So yes, I will be looking into ways to make this work "nicer"
internally, but quite frankly, it has very little priority.

>=20
>> In my world, device hotplug is composed of the following steps
>>
>> 1. Resource allocation
>> 2. Attaching the device to a bus (making it accessible by the guest)
>> 3. Notifying the guest
>>
>> I would e.g. also call ACPI sort of a bus structure. Now, the machine =
hotplug
>> handler currently does parts of 1. and then hands of to ACPI to do 2 a=
nd 3.
> it's not a bus, it's concrete device implementing GPE logic,
> on x86 it does the job on notifier #3 in case of hotplug.
>=20
>> virtio-mem and virtio-pmem do 1. partially in the realize function and=
 then
>> let 2. and 3. be handled by the proxy device specific hotplug handlers=
.
>>
>> Mean people might say that the machine should not call the ACPI code b=
ut there
>> should be a ACPI hotplug handler. So we would end up with the same res=
ult.
> it should be fine for parent to manage its children but not other way a=
round

A virtio-bus (e.g. CCW) also "belongs" to the machine. But we won't
start to pass all device starting from the machine downwards to the
concrete implementation.

(but I get your point)

>=20
>=20
>> But anyhow, the resource allocation (getting an address and getting pl=
ugged) will
>> be done in the first step out of the virtio-(p)mem realize function:
>>
>> static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
>> {
>>    ...
>>    /* try to get a mapping in guest address space */
>>     vm->phys_addr =3D memory_device_get_free_addr(MACHINE(qdev_get_mac=
hine))...
> this should be a property, and if it's not set then realize should erro=
r out

It is a property but if it is 0 we do auto-detection right now (like DIMM=
)

>=20
>>     if (local_err) {
>>         goto out;
>>     }
>>     ...
>>
>>     /* register the memory region */
>>     memory_device_plug_region(MACHINE(qdev_get_machine()), vm->mr,
>>                               vm->phys_addr);
>>    ...
>> }
>>
>> So this happens before any hotplug handler is called. Everything works
>> just fine. What you don't like about this is the qdev_get_machine(). I
>> also don't like it but in the short term I don't see any problem with
>> it. It is resource allocation and not a "device plug" in the typical f=
orm.
>=20
> It's not qdev_get_machine() that's issue, it's layer violation,
> where child device is allocating and mapping resources of one of its pa=
rents.

Quite simple: introduce a function at the machine where the child can
"request" to get an address and "request" to plug/unplug a region.

Or what would be wrong about that?

>=20
> that's been an issue and show stopper for patches in the past,
> and that's probably not going to change in this case either.
>=20

I can see that, but again, for me these are internal details.

> =20
>>> The important point which we should not to break here while trying to=
 glue
>>> PCI hotplug handler with machine hotplug handler is: =20
>>
>> I could later on imagine something like a 2 step approach.
>>
>> 1. resource allocation handler by a machine for MemoryDevices
>> - assigns address, registers memory region
>> 2. hotplug handler (ACPI, PCI, CCW ...)
>> - assigns bus specific stuff, attaches device, notifies guest
>>
>> Importantly the device is not visible to the guest until 2.
> So far it's about how QEMU models and manages wiring process,
> that's why pre_plug/plug handlers were introduced, to allow
> resource owner to attach devices that's plugged into it.
>=20
> i.e. PCI devices are managed by PCI subsystem and DIMM
> devices are managed by board where they are mapped into
> reserved address space by board code that owns it.
>=20
> Allowing random device to manage board resources directly
> isn't really acceptable (even as temporary solution).

I agree to "random" devices. This should not be the design principle.

>=20
> In case of virtio-pmem it might be much cleaner to use
> mapping mechanism provided by PCI sybsytem than trying
> to bridge bus and buss-less device wiring as from device
> modeling point of view (aside from providing RAM to guest)
> it's 2 quite different devices.

And again: Please don't forget virtio-ccw. We _don't_ want to glue
virtio device specifics to the underlying proxy here.

>=20
> i.e. if you think new device is RAM, which is governed by
> -m option, then model it as bus-less device like dimm and
> plug it directly into board, if its plugged in to a bus
> it's that bus owner responsibility to allocate/manage
> address space or bridge it to parent device.
>=20
> (btw: virtio-pmem looks sort of like ivshmem, maybe they
> can share some code on qemu side)
>=20
>> Of course, we could also take care of pre-plug things as you mentioned=
.
>>
>>>
>>> container MachineState::device_memory is owned by machine and
>>> it's up to machine plug handler (container's owner) to map device's m=
r
>>> into its address space.
>>> (i.e. nor device's realize nor PCI bus hotplug handler should do it) =
=20
>>
>> I agree, but I think these are internal details.
> it's internal details that we choose not to violate in QEMU
> and were working towards that direction, getting rid of places
> that do it wrongly.

Yes, and I'll try my best to avoid it.

>=20
>>> Not sure about virtio-mem but if it would use device_memory container=
,
>>> it should use machine's plug handler.
>>>
>>> I don't have out head ideas how to glue it cleanly, may be
>>> MachineState::device_memory is just not right thing to use
>>> for such devices. =20
>>
>> I strongly disagree. From the user point of view it should not matter =
what
>> was added/plugged. There is just one guest physical memory and maxmem =
is
>> defined for one QEMU instance. Exposing such details to the user shoul=
d
>> definitely be avoided.
> qemu user have to be exposed to details as he already adds
>  -device virtio-pmem,....
> to CLI, maxmem accounting is a separate matter and probably
> shouldn't be mixed with device model and how it's mapped into
> guest's address space.

I can't follow. Please step back and have a look at how it works on the
qemu command line:

1. You specify a maxmem option
2. You plug DIMM/NVDIMM/virtio-mem/virtio-pmem

Some machines (e.g. s390x) use maxmem to setup the maximum possible
guest address space in KVM.

Just because DIMM/NVDIMM was the first user does not mean that it is the
only valid user. That is also the reason why it is named
"query-memory-devices" and not "query-dimm-devices". The abstraction is
there for a reason.

--=20

Thanks,

David / dhildenb
