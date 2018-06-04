Received: from eggs.gnu.org ([2001:4830:134:3::10]:48525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fPmLF-0005aG-So
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fPmLB-00052z-U9
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:03:57 -0400
References: <20180517081527.14410-1-david@redhat.com>
	<451cd080-12ab-42bd-0150-e1dbf0abd859@redhat.com>
	<20180601141341.2d0f7ee0@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d440ee15-e126-337b-f365-7a887409cd0f@redhat.com>
Date: Mon, 4 Jun 2018 12:03:38 +0200
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

Thanks to the review! I'll look into the details and comment where I
disagree (or where we need a third opinion).

> Some comments apply to several patches even though I commented only onc=
e.
>=20
> I'd suggest to restructure and split series into several:
>   * unplug cleanups 08/14 & co
>   * generic _preplug refactoring so we won't have to go back to that qu=
estion again
>   * extending memory_device interface 11/14 + actual user for the sake =
of which
>     interface is actually extended (virtio-mem)
>=20
> Also more descriptive commit messages describing why change is done,
> current ones look like "Lets do something for some vague reason" to
> unaware reviewers, having virtio-mem along with new extensions to
> memory_device would be useful here as it could have cross reference
> to parts that would need it.

I'll try to be more verbose.

>=20
> Try to keep patches smaller and doing one thing, we can always squash
> them later if it would be better.

I can try to split them up even further where it makes sense. Please
note that including virtio-mem in the same series won't be happening,
but I'll soon share a virtio-mem protoype where we reviewers can then
see the interfaces in action. (or maybe virtio-pmem is the faster one)

(sending everything in one series will not make reviewers happy due to
the high amount of code, trust me :) )

>=20
> I'm sorry if some comments were a bit too much or insisting on things
> but I'm trying to keep hotplug infrastructure simple so that later
> when someone else comes with related patches, I could easily read it
> without studying it from ground up.

Nothing wrong about that, we can talk about the things where I disagree.

>=20
> PS:
> (I'm not a fan of idea to marry virtio device with its own bus plug log=
ic
> into bus-less machine hotplug, but I don't have a better suggestion or
> time to explore alternatives, so lets do it but keep things manageable)

If it's stupid but it works, it's not stupid ;) No honestly, you
challenged if it would even be possible and I think we found a way to
make this fit in nicely.


--=20

Thanks,

David / dhildenb
