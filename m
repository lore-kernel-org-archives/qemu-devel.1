Received: from eggs.gnu.org ([2001:4830:134:3::10]:40274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRE8z-0007TQ-6u
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRE8v-0002xA-4o
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:57:17 -0400
References: <20180517081527.14410-1-david@redhat.com>
	<451cd080-12ab-42bd-0150-e1dbf0abd859@redhat.com>
	<20180601141341.2d0f7ee0@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2072bd49-adc5-77e2-ef02-d2580911a50f@redhat.com>
Date: Fri, 8 Jun 2018 11:57:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180601141341.2d0f7ee0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 00/14] MemoryDevice: use
 multi stage hotplug handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 01.06.2018 14:13, Igor Mammedov wrote:
> On Fri, 25 May 2018 14:43:39 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 17.05.2018 10:15, David Hildenbrand wrote:
>>> We can have devices that need certain other resources that are e.g.
>>> system resources managed by the machine. We need a clean way to assig=
n
>>> these resources (without violating layers as brought up by Igor).
>>>
>>> One example is virtio-mem/virtio-pmem. Both device types need to be
>>> assigned some region in guest physical address space. This device mem=
ory
>>> belongs to the machine and is managed by it. However, virito devices =
are
>>> hotplugged using the hotplug handler their proxy device implements. S=
o we
>>> could trigger e.g. a PCI hotplug handler for virtio-pci or a CSS/CCW
>>> hotplug handler for virtio-ccw. But definetly not the machine.
>>>
>>> Now, we can route other devices through the machine hotplug handler, =
to
>>> properly assign/unassign resources - like a portion in guest physical
>>> address space.
>=20
> To sum up review:
> Some comments apply to several patches even though I commented only onc=
e.
>=20
> I'd suggest to restructure and split series into several:
>   * unplug cleanups 08/14 & co
>   * generic _preplug refactoring so we won't have to go back to that qu=
estion again

Looking into the details, I don't think this is possible and should be
done for address asignment. It can be done for the node. Here is the
reason why:

In pre_plug(), we acccess a device before it has been realized. This is
okay, as long as we are using "direct properties" like the "node", that
won't be touched during realize.

However, for address detection we need access to the memory region. This
is a "derived property", as it is based on the "memdev" property.

While we can easily verify the validity of "memdev" in the pc_dimm
pre_plug handler (instead of doing that in pc_dimm_realize()), we cannot
access the memory region itself before the device has been realized
using get_memory_region() in all cases.

While this works for PC_DIMM (pc_dimm_get_memory_region() is only based
on dimm->hostmem, which we can verify as stated), we cannot do the same
thing for NVDIMM, because nvdimm_get_memory_region() relies on "realize"
already being called and setting up "nvdimm->nvdimm_mr".

In short: we should call device functions only after realize(),
therefore address assignment is not possible during pre_plug.

--=20

Thanks,

David / dhildenb
