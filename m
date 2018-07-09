Received: from eggs.gnu.org ([2001:4830:134:3::10]:53597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fcYuP-0005Ia-DQ
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fcYuM-00042D-6L
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:21:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51844 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fcYuM-00041f-0S
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:21:02 -0400
Date: Mon, 9 Jul 2018 18:20:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180709182057.0ab1f6a2.cohuck@redhat.com>
In-Reply-To: <20180706175547-mutt-send-email-mst@kernel.org>
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
	<20180706175547-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Siwei Liu <loseweigh@gmail.com>, Venu Busireddy <venu.busireddy@oracle.com>, Roman Kagan <rkagan@virtuozzo.com>, si-wei liu <si-wei.liu@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Fri, 6 Jul 2018 18:07:00 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jul 06, 2018 at 03:54:06PM +0200, Cornelia Huck wrote:
> > On Thu, 5 Jul 2018 17:49:10 -0700
> > Siwei Liu <loseweigh@gmail.com> wrote:
> >  =20
> > > On Wed, Jul 4, 2018 at 5:15 AM, Cornelia Huck <cohuck@redhat.com> wro=
te: =20
> > > > On Tue, 3 Jul 2018 16:31:03 -0700
> > > > Siwei Liu <loseweigh@gmail.com> wrote:
> > > >   =20
> > > >> On Tue, Jul 3, 2018 at 7:52 AM, Cornelia Huck <cohuck@redhat.com> =
wrote:   =20
> > > >> > From my point of view, there are several concerns:
> > > >> > - This approach assumes a homogeneous pairing (same transport), =
and
> > > >> >   even more, it assumes that this transport is pci.   =20
> > > >>
> > > >> Not really.
> > > >>
> > > >> There could be some other place to define a generic (transport
> > > >> independent) virtio feature, whereas the data (group ID) can be st=
ored
> > > >> in transport specific way. That generic virtio feature and the way=
 to
> > > >> specify target transport to group with is yet to be defined. I don=
't
> > > >> see this patch is in conflict with that direction.   =20
> > > >
> > > > Sorry, but I really do not see how this is not pci-specific.
> > > >
> > > > - One of your components is a bridge. A transport does not necessar=
ily
> > > >   have that concept, at least not in a way meaningful for this appr=
oach
> > > >   to work.   =20
> > >=20
> > > Assuming we have a transport agnostic high-level virtio feature to
> > > indicate that the target type for the to-be-paired device is PCI, then
> > > we have to use the data stored in a PC bridge to pair the device. It
> > > does not associate transport of virtio itself with the type of target
> > > device, right. The introduction of PCI bridge is just for storing the
> > > group ID data for the PCI passthrough device case, while one may
> > > define and introduce other means to retrieve the info if target device
> > > type is not PCI e.g. a special instruction to get group ID on s390x
> > > zPCI. =20
> >=20
> > Well, zPCI *is* PCI, just a very quirky one. I'm not sure how upper
> > layers are supposed to distinguish that.
> >=20
> > Is there really no existing PCI identifier that (a) the host admin
> > already knows and (b) the guest can retrieve easily? =20
>=20
> There is e.g. PCI Express serial number. However given that
> one use of the feature is for live migration, we really
> shouldn't use any ID from a real card.

With any "vfio vs. live migration" setup, we basically have two
different cases:
- Both source and target use the same physical device (device shared
  between logical partitions, device accessible from two different
  machines).
- We are dealing with two different devices that can be configured to
  look/act the same.

I have been mostly thinking about the first case, but the serial number
probably won't work with the second case.

>=20
> > >  =20
> > > > - Even if we can introduce transport-specific ways for other
> > > >   transports, the bridge concept still means that the pairing canno=
t be
> > > >   cross-transport.   =20
> > >=20
> > > Sorry, I did not get this. A bridge is PCI specific concept indeed,
> > > but the virtio iteself can be of other transport. Why it matters? I
> > > guess a higher-level feature is needed to define the target transport
> > > for the to-be-paired device. The group ID info can reside on the
> > > transport specific area on virtio itself though. E.g. for virtio-pci,
> > > get it on the vendor specific capability in the PCI configuration
> > > space.
> > > For virtio-ccw, you may come up with CCW specific way to get the group
> > > ID data. Is this not what you had in mind? =20
> >=20
> > No, my idea was it to add it as a field in the virtio-net config space,
> > making it transport-agnostic. (And making this a typed value, depending
> > on the vfio device we want to pair the virtio device with.)
> >=20
> > If we want to extend that to other device types, we can add the field
> > in their config space; but I'd rather prefer a more generic "host
> > relays config metainformation" approach.
> >  =20
> > >  =20
> > > >
> > > > I think we should be clear what we want from a generic
> > > > (transport-agnostic) virtio feature first. Probably some way to rel=
ay
> > > > an identifier of the to-be-paired device (transport-specific +
> > > > information what the transport is?)
> > > >   =20
> > > Are we talking about the transport of the virtio itself or the target
> > > device? Note the virtio feature must always be retrieved using
> > > transport specific way, although the semantics of the feauture can be
> > > transport independent/agnostic. Once a virtio driver instace gets to
> > > the point to read feature bits from the device, the transport of that
> > > virtio device is determined and cannot be changed later. =20
> >=20
> > No, I don't want to introduce a new, per-transport mechanism, but
> > rather put it into the config space. =20
> > >=20
> > >  =20
> > > >> > - It won't work for zPCI (although zPCI is really strange) -- th=
is
> > > >> >   means it will be completely unusable on s390x.   =20
> > > >> I still need more information about this use case. First off, does
> > > >> zPCI support all the hot plug semantics or functionality the same =
way
> > > >> as PCI? Or there has to be some platform or firmeware support like
> > > >> ACPI hotplug? Does QEMU have all the pieces ready for s390 zPCI
> > > >> hotplug?   =20
> > > >
> > > > zPCI is a strange beast, so first a pointer to a writeup I did:
> > > > https://virtualpenguins.blogspot.de/2018/02/notes-on-pci-on-s390x.h=
tml
> > > >
> > > > It does support hotplug, within the s390 architectural context, but
> > > > that should be fine for our needs here.
> > > >
> > > > My concern comes from the 'no topology' issue. We build a fake topo=
logy
> > > > in QEMU (to use the generic pci infrastructure), but the guest does=
 not
> > > > see any of this. It issues an instruction and gets a list of functi=
ons.
> > > > This means any bridge information is not accessible to the guest.  =
 =20
> > >=20
> > > That is the reason why I prefer leaving it to specific transport
> > > (zPCI) to define its own means to present and retrieve the group ID
> > > information. The high-level feature bit just provides the indirection
> > > to the target transport (for the to-be-paired device), while seperate
> > > transport can have a way of its own to present/retrieve the group ID
> > > data.
> > >=20
> > > I don't know where to present that group ID data on s390 zPCI though
> > > to be honest. But I doubt we can come up with a very general
> > > transport-agnostic way to present the data for both (and pontentially
> > > ALL) bus architectures. =20
> >=20
> > I don't want to establish zPCI as a different transport than 'normal'
> > PCI; that would just make life difficult for everyone. The 'put it into
> > virtio config space' approach would mean a second feature bit, but
> > should just work. =20
>=20
> So how about that. Each transport will gain a new field
> which is offset within config space of a generic config.
> Each field within that will be guarded by a feature bit.
>=20
> E.g. add CCW_CMD_READ_CONF_OFFSET.
>=20
> Is this better than a separate new generic config space?

=46rom a ccw view, it would amount to the same (i.e., a new command is
needed in any case). Currently, I'm actually not quite sure how much
more designing of this does make sense (I'll reply elsewhere in this
thread).
