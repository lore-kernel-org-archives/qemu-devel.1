Received: from eggs.gnu.org ([2001:4830:134:3::10]:54902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fcZ0w-0006wf-TP
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fcZ0t-0006Cd-Mw
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:27:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52154 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fcZ0t-0006CB-GF
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:27:47 -0400
Date: Mon, 9 Jul 2018 18:27:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180709182738.46f18c72.cohuck@redhat.com>
In-Reply-To: <CADGSJ22OMemcj6r1GiEHx4RvJSv8DmYGPhTx76WrfdNqdCx-gA@mail.gmail.com>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
	<20180702161404.GA2339@rkaganb.sw.ru>
	<449f1449-ddf6-cd95-976c-14d04d8d503a@oracle.com>
	<20180703095825.GC30904@rkaganb.sw.ru>
	<20180703142817.GA3088@vbusired-vm>
	<20180703165200.180c93bb.cohuck@redhat.com>
	<CADGSJ23+sZiMCx=n=DytZ=TT2z7i0sMhrmnPuFYtuZhSc=qA+Q@mail.gmail.com>
	<20180704141523.377cb66d.cohuck@redhat.com>
	<CADGSJ206U4x0UNTEKu0Lt9K9qA025ajtmnj6ym4PDz4Q-c8RKA@mail.gmail.com>
	<20180706155406.0587733c.cohuck@redhat.com>
	<CADGSJ22OMemcj6r1GiEHx4RvJSv8DmYGPhTx76WrfdNqdCx-gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Siwei Liu <loseweigh@gmail.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>, Roman Kagan <rkagan@virtuozzo.com>, si-wei liu <si-wei.liu@oracle.com>, "Michael S .
	Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Fri, 6 Jul 2018 16:37:10 -0700
Siwei Liu <loseweigh@gmail.com> wrote:

> On Fri, Jul 6, 2018 at 6:54 AM, Cornelia Huck <cohuck@redhat.com> wrote:
> > On Thu, 5 Jul 2018 17:49:10 -0700
> > Siwei Liu <loseweigh@gmail.com> wrote:
> >  
> >> On Wed, Jul 4, 2018 at 5:15 AM, Cornelia Huck <cohuck@redhat.com> wrote:  
> >> > On Tue, 3 Jul 2018 16:31:03 -0700
> >> > Siwei Liu <loseweigh@gmail.com> wrote:
> >> >  
> >> >> On Tue, Jul 3, 2018 at 7:52 AM, Cornelia Huck <cohuck@redhat.com> wrote:  
> >> >> > From my point of view, there are several concerns:
> >> >> > - This approach assumes a homogeneous pairing (same transport), and
> >> >> >   even more, it assumes that this transport is pci.  
> >> >>
> >> >> Not really.
> >> >>
> >> >> There could be some other place to define a generic (transport
> >> >> independent) virtio feature, whereas the data (group ID) can be stored
> >> >> in transport specific way. That generic virtio feature and the way to
> >> >> specify target transport to group with is yet to be defined. I don't
> >> >> see this patch is in conflict with that direction.  
> >> >
> >> > Sorry, but I really do not see how this is not pci-specific.
> >> >
> >> > - One of your components is a bridge. A transport does not necessarily
> >> >   have that concept, at least not in a way meaningful for this approach
> >> >   to work.  
> >>
> >> Assuming we have a transport agnostic high-level virtio feature to
> >> indicate that the target type for the to-be-paired device is PCI, then
> >> we have to use the data stored in a PC bridge to pair the device. It
> >> does not associate transport of virtio itself with the type of target
> >> device, right. The introduction of PCI bridge is just for storing the
> >> group ID data for the PCI passthrough device case, while one may
> >> define and introduce other means to retrieve the info if target device
> >> type is not PCI e.g. a special instruction to get group ID on s390x
> >> zPCI.  
> >
> > Well, zPCI *is* PCI, just a very quirky one. I'm not sure how upper
> > layers are supposed to distinguish that.
> >
> > Is there really no existing PCI identifier that (a) the host admin
> > already knows and (b) the guest can retrieve easily?  
> 
> Not sure if zPCI should be categorized as real PCI due to lack of
> topology. Some other virtual PCI or para-virtual PCI buses behave like
> PCI but not a full blown one. Those are not regarded as (native) PCI
> emulation either.

I'm actually close to giving up on zPCI... it is very odd, not
publically documented, and I see disk passthrough via vfio-ccw as the
more interesting case anyway.

> 
> Can s390x guest use UID and FID described in the blog post you wrote
> to identify zPCI device? I am thinking if we can define other grouping
> mechanism than the 64bit long group ID (formerly 128 bit UUID). The
> high-level indirection not just specifies target transport, but maybe
> grouping mechanism also.

Not sure if this could work with how they are architected
(semantics-wise)... no public documentation is available, so I'll
assume we can't use them for another purpose.

> 
> >  
> >>  
> >> > - Even if we can introduce transport-specific ways for other
> >> >   transports, the bridge concept still means that the pairing cannot be
> >> >   cross-transport.  
> >>
> >> Sorry, I did not get this. A bridge is PCI specific concept indeed,
> >> but the virtio iteself can be of other transport. Why it matters? I
> >> guess a higher-level feature is needed to define the target transport
> >> for the to-be-paired device. The group ID info can reside on the
> >> transport specific area on virtio itself though. E.g. for virtio-pci,
> >> get it on the vendor specific capability in the PCI configuration
> >> space.
> >> For virtio-ccw, you may come up with CCW specific way to get the group
> >> ID data. Is this not what you had in mind?  
> >
> > No, my idea was it to add it as a field in the virtio-net config space,
> > making it transport-agnostic. (And making this a typed value, depending
> > on the vfio device we want to pair the virtio device with.)
> >
> > If we want to extend that to other device types, we can add the field
> > in their config space; but I'd rather prefer a more generic "host
> > relays config metainformation" approach.
> >  
> >>  
> >> >
> >> > I think we should be clear what we want from a generic
> >> > (transport-agnostic) virtio feature first. Probably some way to relay
> >> > an identifier of the to-be-paired device (transport-specific +
> >> > information what the transport is?)
> >> >  
> >> Are we talking about the transport of the virtio itself or the target
> >> device? Note the virtio feature must always be retrieved using
> >> transport specific way, although the semantics of the feauture can be
> >> transport independent/agnostic. Once a virtio driver instace gets to
> >> the point to read feature bits from the device, the transport of that
> >> virtio device is determined and cannot be changed later.  
> >
> > No, I don't want to introduce a new, per-transport mechanism, but
> > rather put it into the config space.  
> 
> OK.
> 
> I think the common understanding is that config space shouldn't be per
> device type. MST's suggestion in the other mail to carve some space
> from the device config space for generic use seems viable to me.
> 
> >  
> >>
> >>  
> >> >> > - It won't work for zPCI (although zPCI is really strange) -- this
> >> >> >   means it will be completely unusable on s390x.  
> >> >> I still need more information about this use case. First off, does
> >> >> zPCI support all the hot plug semantics or functionality the same way
> >> >> as PCI? Or there has to be some platform or firmeware support like
> >> >> ACPI hotplug? Does QEMU have all the pieces ready for s390 zPCI
> >> >> hotplug?  
> >> >
> >> > zPCI is a strange beast, so first a pointer to a writeup I did:
> >> > https://virtualpenguins.blogspot.de/2018/02/notes-on-pci-on-s390x.html
> >> >
> >> > It does support hotplug, within the s390 architectural context, but
> >> > that should be fine for our needs here.
> >> >
> >> > My concern comes from the 'no topology' issue. We build a fake topology
> >> > in QEMU (to use the generic pci infrastructure), but the guest does not
> >> > see any of this. It issues an instruction and gets a list of functions.
> >> > This means any bridge information is not accessible to the guest.  
> >>
> >> That is the reason why I prefer leaving it to specific transport
> >> (zPCI) to define its own means to present and retrieve the group ID
> >> information. The high-level feature bit just provides the indirection
> >> to the target transport (for the to-be-paired device), while seperate
> >> transport can have a way of its own to present/retrieve the group ID
> >> data.
> >>
> >> I don't know where to present that group ID data on s390 zPCI though
> >> to be honest. But I doubt we can come up with a very general
> >> transport-agnostic way to present the data for both (and pontentially
> >> ALL) bus architectures.  
> >
> > I don't want to establish zPCI as a different transport than 'normal'
> > PCI; that would just make life difficult for everyone. The 'put it into
> > virtio config space' approach would mean a second feature bit, but
> > should just work.  
> 
> Sorry, but we still need an ID to match the VFIO passthrough device. I
> don't see how putting the info into virtio config space can address
> the problem.

As said, it is probably better to just give up on zPCI and focus on
'normal' PCI setups. I think we could handle dasd-via-vfio-ccw without
a paired device, and PCI is probably not the prime use case on s390x.
If any IBM folks (with access to documentation etc.) have an opinion,
they should speak up.
