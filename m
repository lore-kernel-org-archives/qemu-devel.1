Received: from eggs.gnu.org ([2001:4830:134:3::10]:32844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1fbEvy-00061D-CH
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 20:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1fbEvw-0006aP-Q2
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 20:49:14 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:38738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <loseweigh@gmail.com>) id 1fbEvw-0006Zq-Ig
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 20:49:12 -0400
Received: by mail-io0-x243.google.com with SMTP id v26-v6so9400041iog.5
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 17:49:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180704141523.377cb66d.cohuck@redhat.com>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
	<20180702161404.GA2339@rkaganb.sw.ru>
	<449f1449-ddf6-cd95-976c-14d04d8d503a@oracle.com>
	<20180703095825.GC30904@rkaganb.sw.ru>
	<20180703142817.GA3088@vbusired-vm>
	<20180703165200.180c93bb.cohuck@redhat.com>
	<CADGSJ23+sZiMCx=n=DytZ=TT2z7i0sMhrmnPuFYtuZhSc=qA+Q@mail.gmail.com>
	<20180704141523.377cb66d.cohuck@redhat.com>
From: Siwei Liu <loseweigh@gmail.com>
Date: Thu, 5 Jul 2018 17:49:10 -0700
Message-ID: <CADGSJ206U4x0UNTEKu0Lt9K9qA025ajtmnj6ym4PDz4Q-c8RKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v3 0/3] Use of unique
 identifier for pairing virtio and passthrough devices...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>, Roman Kagan <rkagan@virtuozzo.com>, si-wei liu <si-wei.liu@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Wed, Jul 4, 2018 at 5:15 AM, Cornelia Huck <cohuck@redhat.com> wrote:
> On Tue, 3 Jul 2018 16:31:03 -0700
> Siwei Liu <loseweigh@gmail.com> wrote:
>
>> On Tue, Jul 3, 2018 at 7:52 AM, Cornelia Huck <cohuck@redhat.com> wrote:
>> > From my point of view, there are several concerns:
>> > - This approach assumes a homogeneous pairing (same transport), and
>> >   even more, it assumes that this transport is pci.
>>
>> Not really.
>>
>> There could be some other place to define a generic (transport
>> independent) virtio feature, whereas the data (group ID) can be stored
>> in transport specific way. That generic virtio feature and the way to
>> specify target transport to group with is yet to be defined. I don't
>> see this patch is in conflict with that direction.
>
> Sorry, but I really do not see how this is not pci-specific.
>
> - One of your components is a bridge. A transport does not necessarily
>   have that concept, at least not in a way meaningful for this approach
>   to work.

Assuming we have a transport agnostic high-level virtio feature to
indicate that the target type for the to-be-paired device is PCI, then
we have to use the data stored in a PC bridge to pair the device. It
does not associate transport of virtio itself with the type of target
device, right. The introduction of PCI bridge is just for storing the
group ID data for the PCI passthrough device case, while one may
define and introduce other means to retrieve the info if target device
type is not PCI e.g. a special instruction to get group ID on s390x
zPCI.

> - Even if we can introduce transport-specific ways for other
>   transports, the bridge concept still means that the pairing cannot be
>   cross-transport.

Sorry, I did not get this. A bridge is PCI specific concept indeed,
but the virtio iteself can be of other transport. Why it matters? I
guess a higher-level feature is needed to define the target transport
for the to-be-paired device. The group ID info can reside on the
transport specific area on virtio itself though. E.g. for virtio-pci,
get it on the vendor specific capability in the PCI configuration
space.
For virtio-ccw, you may come up with CCW specific way to get the group
ID data. Is this not what you had in mind?

>
> I think we should be clear what we want from a generic
> (transport-agnostic) virtio feature first. Probably some way to relay
> an identifier of the to-be-paired device (transport-specific +
> information what the transport is?)
>
Are we talking about the transport of the virtio itself or the target
device? Note the virtio feature must always be retrieved using
transport specific way, although the semantics of the feauture can be
transport independent/agnostic. Once a virtio driver instace gets to
the point to read feature bits from the device, the transport of that
virtio device is determined and cannot be changed later.


>> > - It won't work for zPCI (although zPCI is really strange) -- this
>> >   means it will be completely unusable on s390x.
>> I still need more information about this use case. First off, does
>> zPCI support all the hot plug semantics or functionality the same way
>> as PCI? Or there has to be some platform or firmeware support like
>> ACPI hotplug? Does QEMU have all the pieces ready for s390 zPCI
>> hotplug?
>
> zPCI is a strange beast, so first a pointer to a writeup I did:
> https://virtualpenguins.blogspot.de/2018/02/notes-on-pci-on-s390x.html
>
> It does support hotplug, within the s390 architectural context, but
> that should be fine for our needs here.
>
> My concern comes from the 'no topology' issue. We build a fake topology
> in QEMU (to use the generic pci infrastructure), but the guest does not
> see any of this. It issues an instruction and gets a list of functions.
> This means any bridge information is not accessible to the guest.

That is the reason why I prefer leaving it to specific transport
(zPCI) to define its own means to present and retrieve the group ID
information. The high-level feature bit just provides the indirection
to the target transport (for the to-be-paired device), while seperate
transport can have a way of its own to present/retrieve the group ID
data.

I don't know where to present that group ID data on s390 zPCI though
to be honest. But I doubt we can come up with a very general
transport-agnostic way to present the data for both (and pontentially
ALL) bus architectures.

-Siwei

>
>>
>> Does the s390x use case in your mind concerns with VFIO migraition, or
>> replacement of a PT device with backup virtio-ccw path? Or something
>> else?
>
> Migration with vfio is the case most likely to be relevant. I'm mostly
> concerned with not needlessly closing doors, though.
>
>>
>> As the assumption of SR-IOV migration is that, hotplug is used as an
>> inidicator for datapath switch - which maps to moving MAC address or
>> VLAN filter around between PV and VF. I am not sure how that maps to
>> s390x and zPCI with regard to host coordination.
>
> If we can move MAC addresses or VLAN filters on Linux/QEMU/libvirt in
> general, there's no inherent reason why we shouldn't be able to do so
> on s390 as well. What matters more is probably which pci network cards
> are supported (currently Mellanox AFAIK, not sure if there are others).
>
>>
>> -Siwei
>>
>> > - It is too focused on a narrow use case. How is it supposed to be
>> >   extended?
>> >
>> > What I would prefer:
>> > - Implement a pairing id support that does not rely on a certain
>> >   transport, but leverages virtio (which is in the game anyway). We'd
>> >   get at least the "virtio-net device paired with vfio" use case, which
>> >   is what is currently implemented in the Linux kernel.
>> > - Think about a more generic way to relay configuration metadata to the
>> >   host.
>> >
>> > ---------------------------------------------------------------------
>> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>> >
>
