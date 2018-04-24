Received: from eggs.gnu.org ([2001:4830:134:3::10]:53466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fB05i-0004tE-8F
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fB05g-0000OJ-Ph
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:42:50 -0400
References: <20180420123456.22196-1-david@redhat.com>
	<20180423143147.6b4df2ac@redhat.com>
	<459116211.21924603.1524497545197.JavaMail.zimbra@redhat.com>
	<20180424160011.47475594@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a048d777-38e5-a44a-c401-a5509ca29e37@redhat.com>
Date: Tue, 24 Apr 2018 17:42:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180424160011.47475594@redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>, Pankaj Gupta <pagupta@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On 24.04.2018 16:00, Igor Mammedov wrote:
> On Mon, 23 Apr 2018 11:32:25 -0400 (EDT)
> Pankaj Gupta <pagupta@redhat.com> wrote:
>=20
>> Hi Igor,
>>
>>>  =20
>>>> Right now we can only map PCDIMM/NVDIMM into guest address space. In=
 the
>>>> future, we might want to do the same for virtio devices - e.g.
>>>> virtio-pmem or virtio-mem. Especially, they should be able to live s=
ide
>>>> by side to each other.
>>>>
>>>> E.g. the virto based memory devices regions will not be exposed via =
ACPI
>>>> and friends. They will be detected just like other virtio devices an=
d
>>>> indicate the applicable memory region. This makes it possible to als=
o use
>>>> them on architectures without memory device detection support (e.g. =
s390x).
>>>>
>>>> Let's factor out the memory device code into a MemoryDevice interfac=
e. =20
>>> A couple of high level questions as relevant code is not here:
>>>
>>>   1. what would hotplug/unplug call chain look like in case of virtio=
-pmem
>>>   device
>>>      (reason I'm asking is that pmem being PCI device would trigger
>>>       PCI bus hotplug controller and then it somehow should piggyback
>>>       to Machine provided hotplug handlers, so I wonder what kind of
>>>       havoc it would cause on hotplug infrastructure) =20
>>
>> For first phase we are using 'virtio-pmem' as cold added devices. AFAI=
U
>> 'VirtioDeviceClass' being parent class and 'hotplug/unplug' methods im=
plemented=20
>> for virtio-pmem device. So, pci bus hotplug/unplug should call the cor=
responding
>> functions?
> the problem is with trying to use PCI bus based device with bus-less
> infrastructure used by (pc|nv)dimms.

I can understand your reasoning, but for me these are some QEMU internal =
details
that should not stop the virtio-(p)mem train from rolling.

In my world, device hotplug is composed of the following steps

1. Resource allocation
2. Attaching the device to a bus (making it accessible by the guest)
3. Notifying the guest

I would e.g. also call ACPI sort of a bus structure. Now, the machine hot=
plug
handler currently does parts of 1. and then hands of to ACPI to do 2 and =
3.

virtio-mem and virtio-pmem do 1. partially in the realize function and th=
en
let 2. and 3. be handled by the proxy device specific hotplug handlers.

Mean people might say that the machine should not call the ACPI code but =
there
should be a ACPI hotplug handler. So we would end up with the same result=
.

But anyhow, the resource allocation (getting an address and getting plugg=
ed) will
be done in the first step out of the virtio-(p)mem realize function:

static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
{
   ...
   /* try to get a mapping in guest address space */
    vm->phys_addr =3D memory_device_get_free_addr(MACHINE(qdev_get_machin=
e))...
    if (local_err) {
        goto out;
    }
    ...

    /* register the memory region */
    memory_device_plug_region(MACHINE(qdev_get_machine()), vm->mr,
                              vm->phys_addr);
   ...
}

So this happens before any hotplug handler is called. Everything works
just fine. What you don't like about this is the qdev_get_machine(). I
also don't like it but in the short term I don't see any problem with
it. It is resource allocation and not a "device plug" in the typical form=
.

>=20
> The important point which we should not to break here while trying to g=
lue
> PCI hotplug handler with machine hotplug handler is:

I could later on imagine something like a 2 step approach.

1. resource allocation handler by a machine for MemoryDevices
- assigns address, registers memory region
2. hotplug handler (ACPI, PCI, CCW ...)
- assigns bus specific stuff, attaches device, notifies guest

Importantly the device is not visible to the guest until 2.
Of course, we could also take care of pre-plug things as you mentioned.

>=20
> container MachineState::device_memory is owned by machine and
> it's up to machine plug handler (container's owner) to map device's mr
> into its address space.
> (i.e. nor device's realize nor PCI bus hotplug handler should do it)

I agree, but I think these are internal details.

>=20
> Not sure about virtio-mem but if it would use device_memory container,
> it should use machine's plug handler.
>=20
> I don't have out head ideas how to glue it cleanly, may be
> MachineState::device_memory is just not right thing to use
> for such devices.

I strongly disagree. From the user point of view it should not matter wha=
t
was added/plugged. There is just one guest physical memory and maxmem is
defined for one QEMU instance. Exposing such details to the user should
definitely be avoided.

--=20

Thanks,

David / dhildenb
