Received: from eggs.gnu.org ([2001:4830:134:3::10]:43034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEWsS-0000YW-1k
	for qemu-devel@nongnu.org; Fri, 04 May 2018 05:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEWsO-0004th-So
	for qemu-devel@nongnu.org; Fri, 04 May 2018 05:19:44 -0400
References: <20180503154936.18946-1-david@redhat.com>
	<20180504104907.2c0aebf4@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c7873a84-fa46-0a5d-1091-b2bb5688a1b6@redhat.com>
Date: Fri, 4 May 2018 11:19:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180504104907.2c0aebf4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 0/8] MemoryDevice: introduce and use
 ResourceHandler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 04.05.2018 10:49, Igor Mammedov wrote:
> On Thu,  3 May 2018 17:49:28 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> Hotplug handlers usually have the following tasks:
>> 1. Allocate some resources for a new device
>> 2. Make the new device visible for the guest
>> 3. Notify the guest about the new device
>>
>> Hotplug handlers have right now one limitation: They handle their own
>> context and only care about resources they manage.
>>
>> We can have devices that need certain other resources that are e.g.
>> system resources managed by the machine. We need a clean way to assign
>> these resources (without violating layers as brought up by Igor).
>>
>> One example is virtio-mem/virtio-pmem. Both device types need to be
>> assigned some region in guest physical address space. This device memo=
ry
>> belongs to the machine and is managed by it. However, virito devices a=
re
>> hotplugged using the hotplug handler their proxy device implements. So=
 we
>> could trigger e.g. a PCI hotplug handler for virtio-pci or a CSS/CCW
>> hotplug handler for virtio-ccw. But definetly not the machine.
>>
>> So let's generalize the task of "assigning" resources and use it direc=
tly
>> for memory devices. We now have a clean way to support any kind of mem=
ory
>> device - independent of the underlying device type. Right now, only on=
e
>> resource handler per device can be supported (in addition to the exist=
ing
>> hotplug handler).
> So far I've just skimmed through series and still don't get clear
> picture if new interface is really needed.
> I'd like very much to see patches for how virtio-[p]mem in CCW and PCI
> case would utilize this.

Sure, I think you've seen the problematic parts in the latest
virtio-pmem prototype
(https://www.spinics.net/lists/linux-mm/msg151081.html).

There, we do the assignment from the realize function, which you
described as layer violation. I will ask Pankaj to rebase his work on
this series.

Until then, I can point you at the current QEMU side prototype of
virtio-mem. I won't be posting these as patches as there are still many
things to sort out and clean up. The prototype currently works on x86
and s390x.

You can find the latest prototype on github, including patches of this
series at https://github.com/davidhildenbrand/qemu/tree/virtio-mem

Interesting patches are:
- "s390x: inititalize memory region for memory devices"
-- Provide a region for memory devices just like x86
- "virtio-mem: paravirtualized memory"
-- Prototype of virtio-mem.
- "virtio-ccw: add proxy for virtio-mem"
-- CCW proxy device for virtio-mem (using the CSS/CCW hotplug handler)
- "virtio-mem: paravirtualized memory"
-- PCI proxy device for virtio-mem (using PCI hotplug handler)

Note how virtio-mem implements the MemoryDevice interface and how
resource assignments happens without any layer violations (and no
modifications to any hotplug handler).

--=20

Thanks,

David / dhildenb
