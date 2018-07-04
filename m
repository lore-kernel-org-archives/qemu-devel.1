Received: from eggs.gnu.org ([2001:4830:134:3::10]:39831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fagh2-0007hY-MO
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1faggx-0000wO-LB
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:15:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39914 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1faggx-0000vz-AJ
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:15:27 -0400
Date: Wed, 4 Jul 2018 14:15:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180704141523.377cb66d.cohuck@redhat.com>
In-Reply-To: <CADGSJ23+sZiMCx=n=DytZ=TT2z7i0sMhrmnPuFYtuZhSc=qA+Q@mail.gmail.com>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
	<20180702161404.GA2339@rkaganb.sw.ru>
	<449f1449-ddf6-cd95-976c-14d04d8d503a@oracle.com>
	<20180703095825.GC30904@rkaganb.sw.ru>
	<20180703142817.GA3088@vbusired-vm>
	<20180703165200.180c93bb.cohuck@redhat.com>
	<CADGSJ23+sZiMCx=n=DytZ=TT2z7i0sMhrmnPuFYtuZhSc=qA+Q@mail.gmail.com>
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

On Tue, 3 Jul 2018 16:31:03 -0700
Siwei Liu <loseweigh@gmail.com> wrote:

> On Tue, Jul 3, 2018 at 7:52 AM, Cornelia Huck <cohuck@redhat.com> wrote:
> > From my point of view, there are several concerns:
> > - This approach assumes a homogeneous pairing (same transport), and
> >   even more, it assumes that this transport is pci.  
> 
> Not really.
> 
> There could be some other place to define a generic (transport
> independent) virtio feature, whereas the data (group ID) can be stored
> in transport specific way. That generic virtio feature and the way to
> specify target transport to group with is yet to be defined. I don't
> see this patch is in conflict with that direction.

Sorry, but I really do not see how this is not pci-specific.

- One of your components is a bridge. A transport does not necessarily
  have that concept, at least not in a way meaningful for this approach
  to work.
- Even if we can introduce transport-specific ways for other
  transports, the bridge concept still means that the pairing cannot be
  cross-transport.

I think we should be clear what we want from a generic
(transport-agnostic) virtio feature first. Probably some way to relay
an identifier of the to-be-paired device (transport-specific +
information what the transport is?)

> > - It won't work for zPCI (although zPCI is really strange) -- this
> >   means it will be completely unusable on s390x.  
> I still need more information about this use case. First off, does
> zPCI support all the hot plug semantics or functionality the same way
> as PCI? Or there has to be some platform or firmeware support like
> ACPI hotplug? Does QEMU have all the pieces ready for s390 zPCI
> hotplug?

zPCI is a strange beast, so first a pointer to a writeup I did:
https://virtualpenguins.blogspot.de/2018/02/notes-on-pci-on-s390x.html

It does support hotplug, within the s390 architectural context, but
that should be fine for our needs here.

My concern comes from the 'no topology' issue. We build a fake topology
in QEMU (to use the generic pci infrastructure), but the guest does not
see any of this. It issues an instruction and gets a list of functions.
This means any bridge information is not accessible to the guest.

> 
> Does the s390x use case in your mind concerns with VFIO migraition, or
> replacement of a PT device with backup virtio-ccw path? Or something
> else?

Migration with vfio is the case most likely to be relevant. I'm mostly
concerned with not needlessly closing doors, though.

> 
> As the assumption of SR-IOV migration is that, hotplug is used as an
> inidicator for datapath switch - which maps to moving MAC address or
> VLAN filter around between PV and VF. I am not sure how that maps to
> s390x and zPCI with regard to host coordination.

If we can move MAC addresses or VLAN filters on Linux/QEMU/libvirt in
general, there's no inherent reason why we shouldn't be able to do so
on s390 as well. What matters more is probably which pci network cards
are supported (currently Mellanox AFAIK, not sure if there are others).

> 
> -Siwei
> 
> > - It is too focused on a narrow use case. How is it supposed to be
> >   extended?
> >
> > What I would prefer:
> > - Implement a pairing id support that does not rely on a certain
> >   transport, but leverages virtio (which is in the game anyway). We'd
> >   get at least the "virtio-net device paired with vfio" use case, which
> >   is what is currently implemented in the Linux kernel.
> > - Think about a more generic way to relay configuration metadata to the
> >   host.
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >  
