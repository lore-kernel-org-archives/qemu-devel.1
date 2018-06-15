Received: from eggs.gnu.org ([2001:4830:134:3::10]:56529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1fTdzH-0007BF-UM
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 21:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1fTdzF-0005aR-T9
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 21:57:16 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:37999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <loseweigh@gmail.com>) id 1fTdzF-0005ZY-LO
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 21:57:13 -0400
Received: by mail-it0-x244.google.com with SMTP id v83-v6so871428itc.3
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 18:57:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180614120231.0a72bd5f.cohuck@redhat.com>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<20180611202207-mutt-send-email-mst@kernel.org>
	<dc8b1669-b8b6-fb59-94e2-6e4de6b96572@redhat.com>
	<20180612051432-mutt-send-email-mst@kernel.org>
	<23fc4aa4-ec41-d6e2-3354-10cbfc13b7ec@intel.com>
	<20180612142557-mutt-send-email-mst@kernel.org>
	<b9c88515-cf41-2a9a-078e-9c9e5adbbf14@intel.com>
	<CADGSJ213f8tJpNXuOhv8qRew-Y5VZAwA+srNMrLZYnKdVGLdAA@mail.gmail.com>
	<20180614120231.0a72bd5f.cohuck@redhat.com>
From: Siwei Liu <loseweigh@gmail.com>
Date: Thu, 14 Jun 2018 18:57:11 -0700
Message-ID: <CADGSJ23WnTmVKHezm3t0V6M2sWeHaOUoTjdXkmrvbO0EF83hMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org

Thank you for sharing your thoughts, Cornelia. With questions below, I
think you raised really good points, some of which I don't have answer
yet and would also like to explore here.

First off, I don't want to push the discussion to the extreme at this
point, or sell anything about having QEMU manage everything
automatically. Don't get me wrong, it's not there yet. Let's don't
assume we are tied to a specific or concerte solution. I think the key
for our discussion might be to define or refine the boundary between
VM and guest,  e.g. what each layer is expected to control and manage
exactly.

In my view, there might be possibly 3 different options to represent
the failover device conceipt to QEMU and libvirt (or any upper layer
software):

a. Seperate device: in this model, virtio and passthough remains
separate devices just as today. QEMU exposes the standby feature bit
for virtio, and publish status/event around the negotiation process of
this feature bit for libvirt to react upon. Since Libvirt has the
pairing relationship itself, maybe through MAC address or something
else, it can control the presence of primary by hot plugging or
unplugging the passthrough device, although it has to work tightly
with virtio's feature negotation process. Not just for migration but
also various corner scenarios (driver/feature ok, device reset,
reboot, legacy guest etc) along virtio's feature negotiation.

b. Coupled device: in this model, virtio and passthough devices are
weakly coupled using some group ID, i.e. QEMU match the passthough
device for a standby virtio instance by comparing the group ID value
present behind each device's bridge. Libvirt provides QEMU the group
ID for both type of devices, and only deals with hot plug for
migration, by checking some migration status exposed (e.g. the feature
negotiation status on the virtio device) by QEMU. QEMU manages the
visibility of the primary in guest along virtio's feature negotiation
process.

c. Fully combined device: in this model, virtio and passthough devices
are viewed as a single VM interface altogther. QEMU not just controls
the visibility of the primary in guest, but can also manage the
exposure of the passthrough for migratability. It can be like that
libvirt supplies the group ID to QEMU. Or libvirt does not even have
to provide group ID for grouping the two devices, if just one single
combined device is exposed by QEMU. In either case, QEMU manages all
aspect of such internal construct, including virtio feature
negotiation, presence of the primary, and live migration.

It looks like to me that, in your opinion, you seem to prefer go with
(a). While I'm actually okay with either (b) or (c). Do I understand
your point correctly?

The reason that I feel that (a) might not be ideal, just as Michael
alluded to (quoting below), is that as management stack, it really
doesn't need to care about the detailed process of feature negotiation
(if we view the guest presence of the primary as part of feature
negotiation at an extended level not just virtio). All it needs to be
done is to hand in the required devices to QEMU and that's all. Why do
we need to addd various hooks, events for whichever happens internally
within the guest?

''
Primary device is added with a special "primary-failover" flag.
A virtual machine is then initialized with just a standby virtio
device. Primary is not yet added.

Later QEMU detects that guest driver device set DRIVER_OK.
It then exposes the primary device to the guest, and triggers
a device addition event (hot-plug event) for it.

If QEMU detects guest driver removal, it initiates a hot-unplug sequence
to remove the primary driver.  In particular, if QEMU detects guest
re-initialization (e.g. by detecting guest reset) it immediately removes
the primary device.
''

and,

''
management just wants to give the primary to guest and later take it back,
it really does not care about the details of the process,
so I don't see what does pushing it up the stack buy you.

So I don't think it *needs* to be done in libvirt. It probably can if you
add a bunch of hooks so it knows whenever vm reboots, driver binds and
unbinds from device, and can check that backup flag was set.
If you are pushing for a setup like that please get a buy-in
from libvirt maintainers or better write a patch.
''

Let me know if my clarifications sound clear to you now.


Thanks,
-Siwei


On Thu, Jun 14, 2018 at 3:02 AM, Cornelia Huck <cohuck@redhat.com> wrote:
> I've been pointed to this discussion (which I had missed previously)
> and I'm getting a headache. Let me first summarize how I understand how
> this feature is supposed to work, then I'll respond to some individual
> points.
>
> The basic idea is to enable guests to migrate seamlessly, while still
> making it possible for them to use a passed-through device for more
> performance etc. The means to do so is to hook a virtio-net device
> together with a network device passed through via vfio. The
> vfio-handled device is there for performance, the virtio device for
> migratability. We have a new virtio feature bit for that which needs to
> be negotiated for that 'combined' device to be available. We have to
> consider two cases:
>
> - Older guests that do not support the new feature bit. We presume that
>   those guests will be confused if they get two network devices with
>   the same MAC, so the idea is to not show them the vfio-handled device
>   at all.
> - Guests that negotiate the feature bit. We only know positively that
>   they (a) know the feature bit and (b) are prepared to handle the
>   consequences of negotiating it after they set the FEATURES_OK bit.
>   This is therefore the earliest point in time that the vfio-handled
>   device should be visible or usable for the guest.
>
> On Wed, 13 Jun 2018 18:02:01 -0700
> Siwei Liu <loseweigh@gmail.com> wrote:
>
>> On Tue, Jun 12, 2018 at 5:08 PM, Samudrala, Sridhar
>> <sridhar.samudrala@intel.com> wrote:
>> > On 6/12/2018 4:34 AM, Michael S. Tsirkin wrote:
>> >>
>> >> On Mon, Jun 11, 2018 at 10:02:45PM -0700, Samudrala, Sridhar wrote:
>> >>>
>> >>> On 6/11/2018 7:17 PM, Michael S. Tsirkin wrote:
>> >>>>
>> >>>> On Tue, Jun 12, 2018 at 09:54:44AM +0800, Jason Wang wrote:
>> >>>>>
>> >>>>> On 2018=E5=B9=B406=E6=9C=8812=E6=97=A5 01:26, Michael S. Tsirkin w=
rote:
>> >>>>>>
>> >>>>>> On Mon, May 07, 2018 at 04:09:54PM -0700, Sridhar Samudrala wrote=
:
>> >>>>>>>
>> >>>>>>> This feature bit can be used by hypervisor to indicate virtio_ne=
t
>> >>>>>>> device to
>> >>>>>>> act as a standby for another device with the same MAC address.
>> >>>>>>>
>> >>>>>>> I tested this with a small change to the patch to mark the STAND=
BY
>> >>>>>>> feature 'true'
>> >>>>>>> by default as i am using libvirt to start the VMs.
>> >>>>>>> Is there a way to pass the newly added feature bit 'standby' to =
qemu
>> >>>>>>> via libvirt
>> >>>>>>> XML file?
>> >>>>>>>
>> >>>>>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> >>>>>>
>> >>>>>> So I do not think we can commit to this interface: we
>> >>>>>> really need to control visibility of the primary device.
>> >>>>>
>> >>>>> The problem is legacy guest won't use primary device at all if we =
do
>> >>>>> this.
>> >>>>
>> >>>> And that's by design - I think it's the only way to ensure the
>> >>>> legacy guest isn't confused.
>> >>>
>> >>> Yes. I think so. But i am not sure if Qemu is the right place to con=
trol
>> >>> the visibility
>> >>> of the primary device. The primary device may not be specified as an
>> >>> argument to Qemu. It
>> >>> may be plugged in later.
>> >>> The cloud service provider is providing a feature that enables low
>> >>> latency datapath and live
>> >>> migration capability.
>> >>> A tenant can use this feature only if he is running a VM that has
>> >>> virtio-net with failover support.
>
> So, do you know from the outset that there will be such a coupled
> device? I.e., is it a property of the VM definition?
>
> Can there be a 'prepared' virtio-net device that presents the STANDBY
> feature even if there currently is no vfio-handled device available --
> but making it possible to simply hotplug that device later?
>
> Should it be possible to add a virtio/vfio pair later on?
>
>> >>
>> >> Well live migration is there already. The new feature is low latency
>> >> data path.
>> >
>> >
>> > we get live migration with just virtio.  But I meant live migration wi=
th VF
>> > as
>> > primary device.
>> >
>> >>
>> >> And it's the guest that needs failover support not the VM.
>> >
>> >
>> > Isn't guest and VM synonymous?
>
> I think we need to be really careful to not mix up the two: The VM
> contains the definitions, but it is up to the guest how it uses them.
>
>> >
>> >
>> >>
>> >>
>> >>> I think Qemu should check if guest virtio-net supports this feature =
and
>> >>> provide a mechanism for
>> >>> an upper layer indicating if the STANDBY feature is successfully
>> >>> negotiated or not.
>> >>> The upper layer can then decide if it should hot plug a VF with the =
same
>> >>> MAC and manage the 2 links.
>> >>> If VF is successfully hot plugged, virtio-net link should be disable=
d.
>> >>
>> >> Did you even talk to upper layer management about it?
>> >> Just list the steps they need to do and you will see
>> >> that's a lot of machinery to manage by the upper layer.
>> >>
>> >> What do we gain in flexibility? As far as I can see the
>> >> only gain is some resources saved for legacy VMs.
>> >>
>> >> That's not a lot as tenant of the upper layer probably already has
>> >> at least a hunch that it's a new guest otherwise
>> >> why bother specifying the feature at all - you
>> >> save even more resources without it.
>> >>
>> >
>> > I am not all that familiar with how Qemu manages network devices. If w=
e can
>> > do all the
>> > required management of the primary/standby devices within Qemu, that i=
s
>> > definitely a better
>> > approach without upper layer involvement.
>>
>> Right. I would imagine in the extreme case the upper layer doesn't
>> have to be involved at all if QEMU manages all hot plug/unplug logic.
>> The management tool can supply passthrough device and virtio with the
>> same group UUID, QEMU auto-manages the presence of the primary, and
>> hot plug the device as needed before or after the migration.
>
> I do not really see how you can manage that kind of stuff in QEMU only.
> Have you talked to some libvirt folks? (And I'm not sure what you refer
> to with 'group UUID'?)
>
> Also, I think you need to make a distinction between hotplugging a
> device and making it visible to the guest. What does 'hotplugging' mean
> here? Adding it to the VM definition? Would it be enough to have the
> vfio-based device not operational until the virtio feature bit has been
> negotiated?
>
> What happens if the guest does not use the vfio-based device after it
> has been made available? Will you still disable the virtio-net link?
> (All that link handling definitely sounds like a task for libvirt or
> the like.)
>
> Regarding hot(un)plugging during migration, I think you also need to
> keep in mind that different architectures/busses have different
> semantics there. Something that works if there's an unplug handshake may
> not work on a platform with surprise removal.
>
> Have you considered guest agents? All of this is punching through
> several layers, and I'm not sure if that is a good idea.
