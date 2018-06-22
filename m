Received: from eggs.gnu.org ([2001:4830:134:3::10]:52681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fWBmf-0005La-Im
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 22:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fWBmc-0008G4-Bc
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 22:26:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1fWBmc-0008FI-2J
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 22:26:42 -0400
Date: Thu, 21 Jun 2018 21:25:31 -0500
From: Venu Busireddy <venu.busireddy@oracle.com>
Message-ID: <20180622022531.GA9732@vbusired-vm>
References: <20180615134815.6613620e.cohuck@redhat.com>
	<CADGSJ208NRp=bjhSkzF2K5Ft94TwdRs73WfSp4h-_vXvEKwgiQ@mail.gmail.com>
	<20180619125453.2d2dfb2d.cohuck@redhat.com>
	<20180619233001-mutt-send-email-mst@kernel.org>
	<20180620115359.1a3bf6fb.cohuck@redhat.com>
	<20180620170904-mutt-send-email-mst@kernel.org>
	<20180620180619.6b4ee52d.cohuck@redhat.com>
	<20180620224535-mutt-send-email-mst@kernel.org>
	<20180621165913.7e3f4faa.cohuck@redhat.com>
	<CADGSJ22B39JiS14L0yCYQ720-fZcwyUt1wCX1YO-6Y9FhmDKZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGSJ22B39JiS14L0yCYQ720-fZcwyUt1wCX1YO-6Y9FhmDKZg@mail.gmail.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Siwei Liu <loseweigh@gmail.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, vijay.balakrishna@oracle.com

On 2018-06-21 18:21:55 -0700, Siwei Liu wrote:
> On Thu, Jun 21, 2018 at 7:59 AM, Cornelia Huck <cohuck@redhat.com> wrote:
> > On Wed, 20 Jun 2018 22:48:58 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >
> >> On Wed, Jun 20, 2018 at 06:06:19PM +0200, Cornelia Huck wrote:
> >> > In any case, I'm not sure anymore why we'd want the extra uuid.
> >>
> >> It's mostly so we can have e.g. multiple devices with same MAC
> >> (which some people seem to want in order to then use
> >> then with different containers).
> >>
> >> But it is also handy for when you assign a PF, since then you
> >> can't set the MAC.
> >>
> >
> > OK, so what about the following:
> >
> > - introduce a new feature bit, VIRTIO_NET_F_STANDBY_UUID that indicates
> >   that we have a new uuid field in the virtio-net config space
> > - in QEMU, add a property for virtio-net that allows to specify a uuid,
> >   offer VIRTIO_NET_F_STANDBY_UUID if set
> > - when configuring, set the property to the group UUID of the vfio-pci
> >   device
> 
> If feature negotiation fails on VIRTIO_NET_F_STANDBY_UUID, is it safe
> to still expose UUID in the config space on virtio-pci?

Why is it not safe? When we expose VIRTIO_NET_F_STANDBY_UUID, it is up
to the driver to decide if it wants to use it or not. If it does not
want to use the feature, it would also imply that the driver will not
be interested in the UUID value in the config space. So, the UUID will
be some piece of data that simply sits around; nobody cares for it.

> I'm not even sure if it's sane to expose group UUID on the PCI bridge
> where the corresponding vfio-pci device attached to for a guest which
> doesn't support the feature (legacy).

Unfortunately, you don't know beforehand if the guest will be a legacy
guest that doesn't support the feature. As is the case with the UUID in
the virtio-pci device's config space, the UUID in the bridge's config
space will/should be ignored by the legacy guest.

Venu

> > - in the guest, use the uuid from the virtio-net device's config space
> >   if applicable; else, fall back to matching by MAC as done today
> >
> > That should work for all virtio transports.
