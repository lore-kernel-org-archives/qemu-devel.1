Received: from eggs.gnu.org ([2001:4830:134:3::10]:42840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1fVMwJ-000727-4k
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1fVMwH-0002xz-9w
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:09:19 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:33377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <loseweigh@gmail.com>) id 1fVMwH-0002xS-0F
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:09:17 -0400
Received: by mail-it0-x243.google.com with SMTP id k17-v6so15712402ita.0
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 13:09:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619125453.2d2dfb2d.cohuck@redhat.com>
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
	<20180615134815.6613620e.cohuck@redhat.com>
	<CADGSJ208NRp=bjhSkzF2K5Ft94TwdRs73WfSp4h-_vXvEKwgiQ@mail.gmail.com>
	<20180619125453.2d2dfb2d.cohuck@redhat.com>
From: Siwei Liu <loseweigh@gmail.com>
Date: Tue, 19 Jun 2018 13:09:14 -0700
Message-ID: <CADGSJ20wrF418-WVev6OjaeShZWE488uxRwgaZmsjOHZr8jyOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, vijay.balakrishna@oracle.com

On Tue, Jun 19, 2018 at 3:54 AM, Cornelia Huck <cohuck@redhat.com> wrote:
> On Fri, 15 Jun 2018 10:06:07 -0700
> Siwei Liu <loseweigh@gmail.com> wrote:
>
>> On Fri, Jun 15, 2018 at 4:48 AM, Cornelia Huck <cohuck@redhat.com> wrote:
>> > On Thu, 14 Jun 2018 18:57:11 -0700
>> > Siwei Liu <loseweigh@gmail.com> wrote:
>> >
>> >> Thank you for sharing your thoughts, Cornelia. With questions below, I
>> >> think you raised really good points, some of which I don't have answer
>> >> yet and would also like to explore here.
>> >>
>> >> First off, I don't want to push the discussion to the extreme at this
>> >> point, or sell anything about having QEMU manage everything
>> >> automatically. Don't get me wrong, it's not there yet. Let's don't
>> >> assume we are tied to a specific or concerte solution. I think the key
>> >> for our discussion might be to define or refine the boundary between
>> >> VM and guest,  e.g. what each layer is expected to control and manage
>> >> exactly.
>> >>
>> >> In my view, there might be possibly 3 different options to represent
>> >> the failover device conceipt to QEMU and libvirt (or any upper layer
>> >> software):
>> >>
>> >> a. Seperate device: in this model, virtio and passthough remains
>> >> separate devices just as today. QEMU exposes the standby feature bit
>> >> for virtio, and publish status/event around the negotiation process of
>> >> this feature bit for libvirt to react upon. Since Libvirt has the
>> >> pairing relationship itself, maybe through MAC address or something
>> >> else, it can control the presence of primary by hot plugging or
>> >> unplugging the passthrough device, although it has to work tightly
>> >> with virtio's feature negotation process. Not just for migration but
>> >> also various corner scenarios (driver/feature ok, device reset,
>> >> reboot, legacy guest etc) along virtio's feature negotiation.
>> >
>> > Yes, that one has obvious tie-ins to virtio's modus operandi.
>> >
>> >>
>> >> b. Coupled device: in this model, virtio and passthough devices are
>> >> weakly coupled using some group ID, i.e. QEMU match the passthough
>> >> device for a standby virtio instance by comparing the group ID value
>> >> present behind each device's bridge. Libvirt provides QEMU the group
>> >> ID for both type of devices, and only deals with hot plug for
>> >> migration, by checking some migration status exposed (e.g. the feature
>> >> negotiation status on the virtio device) by QEMU. QEMU manages the
>> >> visibility of the primary in guest along virtio's feature negotiation
>> >> process.
>> >
>> > I'm a bit confused here. What, exactly, ties the two devices together?
>>
>> The group UUID. Since QEMU VFIO dvice does not have insight of MAC
>> address (which it doesn't have to), the association between VFIO
>> passthrough and standby must be specificed for QEMU to understand the
>> relationship with this model. Note, standby feature is no longer
>> required to be exposed under this model.
>
> Isn't that a bit limiting, though?
>
> With this model, you can probably tie a vfio-pci device and a
> virtio-net-pci device together. But this will fail if you have
> different transports: Consider tying together a vfio-pci device and a
> virtio-net-ccw device on s390, for example. The standby feature bit is
> on the virtio-net level and should not have any dependency on the
> transport used.

Probably we'd limit the support for grouping to virtio-net-pci device
and vfio-pci device only. For virtio-net-pci, as you might see with
Venu's patch, we store the group UUID on the config space of
virtio-pci, which is only applicable to PCI transport.

If virtio-net-ccw needs to support the same, I think similar grouping
interface should be defined on the VirtIO CCW transport. I think the
current implementation of the Linux failover driver assumes that it's
SR-IOV VF with same MAC address which the virtio-net-pci needs to pair
with, and that the PV path is on same PF without needing to update
network of the port-MAC association change. If we need to extend the
grouping mechanism to virtio-net-ccw, it has to pass such failover
mode to virtio driver specifically through some other option I guess.

>
>>
>> > If libvirt already has the knowledge that it should manage the two as a
>> > couple, why do we need the group id (or something else for other
>> > architectures)? (Maybe I'm simply missing something because I'm not
>> > that familiar with pci.)
>>
>> The idea is to have QEMU control the visibility and enumeration order
>> of the passthrough VFIO for the failover scenario. Hotplug can be one
>> way to achieve it, and perhaps there's other way around also. The
>> group ID is not just for QEMU to couple devices, it's also helpful to
>> guest too as grouping using MAC address is just not safe.
>
> Sorry about dragging mainframes into this, but this will only work for
> homogenous device coupling, not for heterogenous. Consider my vfio-pci
> + virtio-net-ccw example again: The guest cannot find out that the two
> belong together by checking some group ID, it has to either use the MAC
> or some needs-to-be-architectured property.
>
> Alternatively, we could propose that mechanism as pci-only, which means
> we can rely on mechanisms that won't necessarily work on non-pci
> transports. (FWIW, I don't see a use case for using vfio-ccw to pass
> through a network card anytime in the near future, due to the nature of
> network cards currently in use on s390.)

Yes, let's do this just for PCI transport (homogenous) for now.

>
>>
>> >
>> >>
>> >> c. Fully combined device: in this model, virtio and passthough devices
>> >> are viewed as a single VM interface altogther. QEMU not just controls
>> >> the visibility of the primary in guest, but can also manage the
>> >> exposure of the passthrough for migratability. It can be like that
>> >> libvirt supplies the group ID to QEMU. Or libvirt does not even have
>> >> to provide group ID for grouping the two devices, if just one single
>> >> combined device is exposed by QEMU. In either case, QEMU manages all
>> >> aspect of such internal construct, including virtio feature
>> >> negotiation, presence of the primary, and live migration.
>> >
>> > Same question as above.
>> >
>> >>
>> >> It looks like to me that, in your opinion, you seem to prefer go with
>> >> (a). While I'm actually okay with either (b) or (c). Do I understand
>> >> your point correctly?
>> >
>> > I'm not yet preferring anything, as I'm still trying to understand how
>> > this works :) I hope we can arrive at a model that covers the use case
>> > and that is also flexible enough to be extended to other platforms.
>> >
>> >>
>> >> The reason that I feel that (a) might not be ideal, just as Michael
>> >> alluded to (quoting below), is that as management stack, it really
>> >> doesn't need to care about the detailed process of feature negotiation
>> >> (if we view the guest presence of the primary as part of feature
>> >> negotiation at an extended level not just virtio). All it needs to be
>> >> done is to hand in the required devices to QEMU and that's all. Why do
>> >> we need to addd various hooks, events for whichever happens internally
>> >> within the guest?
>> >>
>> >> ''
>> >> Primary device is added with a special "primary-failover" flag.
>> >> A virtual machine is then initialized with just a standby virtio
>> >> device. Primary is not yet added.
>> >>
>> >> Later QEMU detects that guest driver device set DRIVER_OK.
>> >> It then exposes the primary device to the guest, and triggers
>> >> a device addition event (hot-plug event) for it.
>> >>
>> >> If QEMU detects guest driver removal, it initiates a hot-unplug sequence
>> >> to remove the primary driver.  In particular, if QEMU detects guest
>> >> re-initialization (e.g. by detecting guest reset) it immediately removes
>> >> the primary device.
>> >> ''
>> >>
>> >> and,
>> >>
>> >> ''
>> >> management just wants to give the primary to guest and later take it back,
>> >> it really does not care about the details of the process,
>> >> so I don't see what does pushing it up the stack buy you.
>> >>
>> >> So I don't think it *needs* to be done in libvirt. It probably can if you
>> >> add a bunch of hooks so it knows whenever vm reboots, driver binds and
>> >> unbinds from device, and can check that backup flag was set.
>> >> If you are pushing for a setup like that please get a buy-in
>> >> from libvirt maintainers or better write a patch.
>> >> ''
>> >
>> > This actually seems to mean the opposite to me: We need to know what
>> > the guest is doing and when, as it directly drives what we need to do
>> > with the devices. If we switch to a visibility vs a hotplug model (see
>> > the other mail), we might be able to handle that part within qemu.
>>
>> In the model of (b), I think it essentially turns hotplug to one of
>> mechanisms for QEMU to control the visibility. The libvirt can still
>> manage the hotplug of individual devices during live migration or in
>> normal situation to hot add/remove devices. Though the visibility of
>> the VFIO is under the controll of QEMU, and it's possible that the hot
>> add/remove request does not involve actual hot plug activity in guest
>> at all.
>
> That depends on how you model visibility, I guess. You'll probably want
> to stop traffic flowing through one or the other of the cards; would
> link down or similar be enough for the virtio device?

I'm not sure if it is a good idea. The guest user will see two devices
with same MAC but one of them is down. Do you expect user to use it or
not? And since the guest is going to be migrated, we need to unplug a
broken VF from guest before migrating, why do we bother plugging in
this useless VF at the first place?


Thanks,
-Siwei
>
>>
>> In the model of (c), the hotplug semantics of the combined device
>> would mean differently - it would end up with devices plugged in or
>> out altogther. To make this work, we either have to build a brand new
>> bond-like QEMU device consist of virtio and VFIO internally, or need
>> to have some abstraction in place for libvirt to manipulate the
>> combined device (and prohibit libvirt from operating on individual
>> internal device directly). Note with this model the group ID doesn't
>> even need to get exposed to libvirt, just imagine libvirt to supply
>> all options required to configure two regular virtio-net and VFIO
>> devices for a single device object, and QEMU will deal with the
>> device's visibility and enumeration, such when to hot plug VFIO device
>> in to or out from the guest.
>>
>> It might be complicated to implement (c) though.
>
> I think (c) would be even more complicated for heterogenous setups.
