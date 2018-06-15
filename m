Received: from eggs.gnu.org ([2001:4830:134:3::10]:51359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fTnDM-0004lw-B7
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fTnDJ-0007ga-6y
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:48:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39640 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fTnDJ-0007gP-0L
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:48:21 -0400
Date: Fri, 15 Jun 2018 13:48:15 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180615134815.6613620e.cohuck@redhat.com>
In-Reply-To: <CADGSJ23WnTmVKHezm3t0V6M2sWeHaOUoTjdXkmrvbO0EF83hMg@mail.gmail.com>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<20180611202207-mutt-send-email-mst@kernel.org>
	<dc8b1669-b8b6-fb59-94e2-6e4de6b96572@redhat.com>
	<20180612051432-mutt-send-email-mst@kernel.org>
	<23fc4aa4-ec41-d6e2-3354-10cbfc13b7ec@intel.com>
	<20180612142557-mutt-send-email-mst@kernel.org>
	<b9c88515-cf41-2a9a-078e-9c9e5adbbf14@intel.com>
	<CADGSJ213f8tJpNXuOhv8qRew-Y5VZAwA+srNMrLZYnKdVGLdAA@mail.gmail.com>
	<20180614120231.0a72bd5f.cohuck@redhat.com>
	<CADGSJ23WnTmVKHezm3t0V6M2sWeHaOUoTjdXkmrvbO0EF83hMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, "Michael S.
	Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org

On Thu, 14 Jun 2018 18:57:11 -0700
Siwei Liu <loseweigh@gmail.com> wrote:

> Thank you for sharing your thoughts, Cornelia. With questions below, I
> think you raised really good points, some of which I don't have answer
> yet and would also like to explore here.
> 
> First off, I don't want to push the discussion to the extreme at this
> point, or sell anything about having QEMU manage everything
> automatically. Don't get me wrong, it's not there yet. Let's don't
> assume we are tied to a specific or concerte solution. I think the key
> for our discussion might be to define or refine the boundary between
> VM and guest,  e.g. what each layer is expected to control and manage
> exactly.
> 
> In my view, there might be possibly 3 different options to represent
> the failover device conceipt to QEMU and libvirt (or any upper layer
> software):
> 
> a. Seperate device: in this model, virtio and passthough remains
> separate devices just as today. QEMU exposes the standby feature bit
> for virtio, and publish status/event around the negotiation process of
> this feature bit for libvirt to react upon. Since Libvirt has the
> pairing relationship itself, maybe through MAC address or something
> else, it can control the presence of primary by hot plugging or
> unplugging the passthrough device, although it has to work tightly
> with virtio's feature negotation process. Not just for migration but
> also various corner scenarios (driver/feature ok, device reset,
> reboot, legacy guest etc) along virtio's feature negotiation.

Yes, that one has obvious tie-ins to virtio's modus operandi.

> 
> b. Coupled device: in this model, virtio and passthough devices are
> weakly coupled using some group ID, i.e. QEMU match the passthough
> device for a standby virtio instance by comparing the group ID value
> present behind each device's bridge. Libvirt provides QEMU the group
> ID for both type of devices, and only deals with hot plug for
> migration, by checking some migration status exposed (e.g. the feature
> negotiation status on the virtio device) by QEMU. QEMU manages the
> visibility of the primary in guest along virtio's feature negotiation
> process.

I'm a bit confused here. What, exactly, ties the two devices together?
If libvirt already has the knowledge that it should manage the two as a
couple, why do we need the group id (or something else for other
architectures)? (Maybe I'm simply missing something because I'm not
that familiar with pci.)

> 
> c. Fully combined device: in this model, virtio and passthough devices
> are viewed as a single VM interface altogther. QEMU not just controls
> the visibility of the primary in guest, but can also manage the
> exposure of the passthrough for migratability. It can be like that
> libvirt supplies the group ID to QEMU. Or libvirt does not even have
> to provide group ID for grouping the two devices, if just one single
> combined device is exposed by QEMU. In either case, QEMU manages all
> aspect of such internal construct, including virtio feature
> negotiation, presence of the primary, and live migration.

Same question as above.

> 
> It looks like to me that, in your opinion, you seem to prefer go with
> (a). While I'm actually okay with either (b) or (c). Do I understand
> your point correctly?

I'm not yet preferring anything, as I'm still trying to understand how
this works :) I hope we can arrive at a model that covers the use case
and that is also flexible enough to be extended to other platforms.

> 
> The reason that I feel that (a) might not be ideal, just as Michael
> alluded to (quoting below), is that as management stack, it really
> doesn't need to care about the detailed process of feature negotiation
> (if we view the guest presence of the primary as part of feature
> negotiation at an extended level not just virtio). All it needs to be
> done is to hand in the required devices to QEMU and that's all. Why do
> we need to addd various hooks, events for whichever happens internally
> within the guest?
> 
> ''
> Primary device is added with a special "primary-failover" flag.
> A virtual machine is then initialized with just a standby virtio
> device. Primary is not yet added.
> 
> Later QEMU detects that guest driver device set DRIVER_OK.
> It then exposes the primary device to the guest, and triggers
> a device addition event (hot-plug event) for it.
> 
> If QEMU detects guest driver removal, it initiates a hot-unplug sequence
> to remove the primary driver.  In particular, if QEMU detects guest
> re-initialization (e.g. by detecting guest reset) it immediately removes
> the primary device.
> ''
> 
> and,
> 
> ''
> management just wants to give the primary to guest and later take it back,
> it really does not care about the details of the process,
> so I don't see what does pushing it up the stack buy you.
> 
> So I don't think it *needs* to be done in libvirt. It probably can if you
> add a bunch of hooks so it knows whenever vm reboots, driver binds and
> unbinds from device, and can check that backup flag was set.
> If you are pushing for a setup like that please get a buy-in
> from libvirt maintainers or better write a patch.
> ''

This actually seems to mean the opposite to me: We need to know what
the guest is doing and when, as it directly drives what we need to do
with the devices. If we switch to a visibility vs a hotplug model (see
the other mail), we might be able to handle that part within qemu.
However, I don't see how you get around needing libvirt to actually set
this up in the first place and to handle migration per se.
