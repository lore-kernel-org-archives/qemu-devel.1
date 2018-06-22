Received: from eggs.gnu.org ([2001:4830:134:3::10]:36677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWTd3-0000YV-8L
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWTcz-0002Su-9b
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:30:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43436 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fWTcz-0002Se-44
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:29:57 -0400
Date: Sat, 23 Jun 2018 00:29:54 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180623002628-mutt-send-email-mst@kernel.org>
References: <20180619233001-mutt-send-email-mst@kernel.org>
	<20180620115359.1a3bf6fb.cohuck@redhat.com>
	<20180620170904-mutt-send-email-mst@kernel.org>
	<20180620180619.6b4ee52d.cohuck@redhat.com>
	<20180620224535-mutt-send-email-mst@kernel.org>
	<20180621165913.7e3f4faa.cohuck@redhat.com>
	<CADGSJ22B39JiS14L0yCYQ720-fZcwyUt1wCX1YO-6Y9FhmDKZg@mail.gmail.com>
	<20180622053141-mutt-send-email-mst@kernel.org>
	<CADGSJ23SBEFJCD50K-F-Gt86Q1-i_6iHTmSSjdXDzNnnpWZ_oQ@mail.gmail.com>
	<CADGSJ22nLcz_XaJNzUUdpjQaJY8b5wZs=ohm=B7c2qf2K7_yGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGSJ22nLcz_XaJNzUUdpjQaJY8b5wZs=ohm=B7c2qf2K7_yGA@mail.gmail.com>
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
Cc: Cornelia Huck <cohuck@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, vijay.balakrishna@oracle.com

On Fri, Jun 22, 2018 at 01:03:04PM -0700, Siwei Liu wrote:
> On Fri, Jun 22, 2018 at 1:00 PM, Siwei Liu <loseweigh@gmail.com> wrote:
> > On Thu, Jun 21, 2018 at 7:32 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> On Thu, Jun 21, 2018 at 06:21:55PM -0700, Siwei Liu wrote:
> >>> On Thu, Jun 21, 2018 at 7:59 AM, Cornelia Huck <cohuck@redhat.com> wrote:
> >>> > On Wed, 20 Jun 2018 22:48:58 +0300
> >>> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >>> >
> >>> >> On Wed, Jun 20, 2018 at 06:06:19PM +0200, Cornelia Huck wrote:
> >>> >> > In any case, I'm not sure anymore why we'd want the extra uuid.
> >>> >>
> >>> >> It's mostly so we can have e.g. multiple devices with same MAC
> >>> >> (which some people seem to want in order to then use
> >>> >> then with different containers).
> >>> >>
> >>> >> But it is also handy for when you assign a PF, since then you
> >>> >> can't set the MAC.
> >>> >>
> >>> >
> >>> > OK, so what about the following:
> >>> >
> >>> > - introduce a new feature bit, VIRTIO_NET_F_STANDBY_UUID that indicates
> >>> >   that we have a new uuid field in the virtio-net config space
> >>> > - in QEMU, add a property for virtio-net that allows to specify a uuid,
> >>> >   offer VIRTIO_NET_F_STANDBY_UUID if set
> >>> > - when configuring, set the property to the group UUID of the vfio-pci
> >>> >   device
> >>>
> >>> If feature negotiation fails on VIRTIO_NET_F_STANDBY_UUID, is it safe
> >>> to still expose UUID in the config space on virtio-pci?
> >>
> >>
> >> Yes but guest is not supposed to read it.
> >>
> >>> I'm not even sure if it's sane to expose group UUID on the PCI bridge
> >>> where the corresponding vfio-pci device attached to for a guest which
> >>> doesn't support the feature (legacy).
> >>>
> >>> -Siwei
> >>
> >> Yes but you won't add the primary behind such a bridge.
> >
> > I assume the UUID feature is a new one besides the exiting
> > VIRTIO_NET_F_STANDBY feature, where I think the current proposal is,
> > if UUID feature is present and supported by guest, we'll do pairing
> > based on UUID; if UUID feature present
>                                  ^^^^^^^  is NOT present

Let's go back for a bit.

What is wrong with matching by mac?

1. Does not allow multiple NICs with same mac
2. Requires MAC to be programmed by host in the PT device
   (which is often possible with VFs but isn't possible with all PT
   devices)

Both issues are up to host: if host needs them it needs the UUID
feature, if not MAC matching is sufficient.


> > or not supported by guest,
> > we'll still plug in the VF (if guest supports the _F_STANDBY feature)
> > but the pairing will be fallback to using MAC address. Are you saying
> > you don't even want to plug in the primary when the UUID feature is
> > not supported by guest? Does the feature negotiation UUID have to
> > depend on STANDBY being set, or the other way around? I thought that
> > just the absence of STANDBY will prevent primary to get exposed to the
> > guest.
> >
> > -Siwei
> >
> >>
> >>>
> >>> > - in the guest, use the uuid from the virtio-net device's config space
> >>> >   if applicable; else, fall back to matching by MAC as done today
