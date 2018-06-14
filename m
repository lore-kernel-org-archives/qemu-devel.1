Received: from eggs.gnu.org ([2001:4830:134:3::10]:57190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fTP5Y-0007bg-EK
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:02:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fTP5S-0001D0-5Z
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:02:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58242 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fTP5R-0001Cp-Qe
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:02:38 -0400
Date: Thu, 14 Jun 2018 12:02:31 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180614120231.0a72bd5f.cohuck@redhat.com>
In-Reply-To: <CADGSJ213f8tJpNXuOhv8qRew-Y5VZAwA+srNMrLZYnKdVGLdAA@mail.gmail.com>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<20180611202207-mutt-send-email-mst@kernel.org>
	<dc8b1669-b8b6-fb59-94e2-6e4de6b96572@redhat.com>
	<20180612051432-mutt-send-email-mst@kernel.org>
	<23fc4aa4-ec41-d6e2-3354-10cbfc13b7ec@intel.com>
	<20180612142557-mutt-send-email-mst@kernel.org>
	<b9c88515-cf41-2a9a-078e-9c9e5adbbf14@intel.com>
	<CADGSJ213f8tJpNXuOhv8qRew-Y5VZAwA+srNMrLZYnKdVGLdAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Siwei Liu <loseweigh@gmail.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, "Michael S.
	Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org

I've been pointed to this discussion (which I had missed previously)
and I'm getting a headache. Let me first summarize how I understand how
this feature is supposed to work, then I'll respond to some individual
points.

The basic idea is to enable guests to migrate seamlessly, while still
making it possible for them to use a passed-through device for more
performance etc. The means to do so is to hook a virtio-net device
together with a network device passed through via vfio. The
vfio-handled device is there for performance, the virtio device for
migratability. We have a new virtio feature bit for that which needs to
be negotiated for that 'combined' device to be available. We have to
consider two cases:

- Older guests that do not support the new feature bit. We presume that
  those guests will be confused if they get two network devices with
  the same MAC, so the idea is to not show them the vfio-handled device
  at all.
- Guests that negotiate the feature bit. We only know positively that
  they (a) know the feature bit and (b) are prepared to handle the
  consequences of negotiating it after they set the FEATURES_OK bit.
  This is therefore the earliest point in time that the vfio-handled
  device should be visible or usable for the guest.

On Wed, 13 Jun 2018 18:02:01 -0700
Siwei Liu <loseweigh@gmail.com> wrote:

> On Tue, Jun 12, 2018 at 5:08 PM, Samudrala, Sridhar
> <sridhar.samudrala@intel.com> wrote:
> > On 6/12/2018 4:34 AM, Michael S. Tsirkin wrote: =20
> >>
> >> On Mon, Jun 11, 2018 at 10:02:45PM -0700, Samudrala, Sridhar wrote: =20
> >>>
> >>> On 6/11/2018 7:17 PM, Michael S. Tsirkin wrote: =20
> >>>>
> >>>> On Tue, Jun 12, 2018 at 09:54:44AM +0800, Jason Wang wrote: =20
> >>>>>
> >>>>> On 2018=E5=B9=B406=E6=9C=8812=E6=97=A5 01:26, Michael S. Tsirkin wr=
ote: =20
> >>>>>>
> >>>>>> On Mon, May 07, 2018 at 04:09:54PM -0700, Sridhar Samudrala wrote:=
 =20
> >>>>>>>
> >>>>>>> This feature bit can be used by hypervisor to indicate virtio_net
> >>>>>>> device to
> >>>>>>> act as a standby for another device with the same MAC address.
> >>>>>>>
> >>>>>>> I tested this with a small change to the patch to mark the STANDBY
> >>>>>>> feature 'true'
> >>>>>>> by default as i am using libvirt to start the VMs.
> >>>>>>> Is there a way to pass the newly added feature bit 'standby' to q=
emu
> >>>>>>> via libvirt
> >>>>>>> XML file?
> >>>>>>>
> >>>>>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com> =20
> >>>>>>
> >>>>>> So I do not think we can commit to this interface: we
> >>>>>> really need to control visibility of the primary device. =20
> >>>>>
> >>>>> The problem is legacy guest won't use primary device at all if we do
> >>>>> this. =20
> >>>>
> >>>> And that's by design - I think it's the only way to ensure the
> >>>> legacy guest isn't confused. =20
> >>>
> >>> Yes. I think so. But i am not sure if Qemu is the right place to cont=
rol
> >>> the visibility
> >>> of the primary device. The primary device may not be specified as an
> >>> argument to Qemu. It
> >>> may be plugged in later.
> >>> The cloud service provider is providing a feature that enables low
> >>> latency datapath and live
> >>> migration capability.
> >>> A tenant can use this feature only if he is running a VM that has
> >>> virtio-net with failover support. =20

So, do you know from the outset that there will be such a coupled
device? I.e., is it a property of the VM definition?

Can there be a 'prepared' virtio-net device that presents the STANDBY
feature even if there currently is no vfio-handled device available --
but making it possible to simply hotplug that device later?

Should it be possible to add a virtio/vfio pair later on?

> >>
> >> Well live migration is there already. The new feature is low latency
> >> data path. =20
> >
> >
> > we get live migration with just virtio.  But I meant live migration wit=
h VF
> > as
> > primary device.
> > =20
> >>
> >> And it's the guest that needs failover support not the VM. =20
> >
> >
> > Isn't guest and VM synonymous?

I think we need to be really careful to not mix up the two: The VM
contains the definitions, but it is up to the guest how it uses them.

> >
> > =20
> >>
> >> =20
> >>> I think Qemu should check if guest virtio-net supports this feature a=
nd
> >>> provide a mechanism for
> >>> an upper layer indicating if the STANDBY feature is successfully
> >>> negotiated or not.
> >>> The upper layer can then decide if it should hot plug a VF with the s=
ame
> >>> MAC and manage the 2 links.
> >>> If VF is successfully hot plugged, virtio-net link should be disabled=
. =20
> >>
> >> Did you even talk to upper layer management about it?
> >> Just list the steps they need to do and you will see
> >> that's a lot of machinery to manage by the upper layer.
> >>
> >> What do we gain in flexibility? As far as I can see the
> >> only gain is some resources saved for legacy VMs.
> >>
> >> That's not a lot as tenant of the upper layer probably already has
> >> at least a hunch that it's a new guest otherwise
> >> why bother specifying the feature at all - you
> >> save even more resources without it.
> >> =20
> >
> > I am not all that familiar with how Qemu manages network devices. If we=
 can
> > do all the
> > required management of the primary/standby devices within Qemu, that is
> > definitely a better
> > approach without upper layer involvement. =20
>=20
> Right. I would imagine in the extreme case the upper layer doesn't
> have to be involved at all if QEMU manages all hot plug/unplug logic.
> The management tool can supply passthrough device and virtio with the
> same group UUID, QEMU auto-manages the presence of the primary, and
> hot plug the device as needed before or after the migration.

I do not really see how you can manage that kind of stuff in QEMU only.
Have you talked to some libvirt folks? (And I'm not sure what you refer
to with 'group UUID'?)

Also, I think you need to make a distinction between hotplugging a
device and making it visible to the guest. What does 'hotplugging' mean
here? Adding it to the VM definition? Would it be enough to have the
vfio-based device not operational until the virtio feature bit has been
negotiated?

What happens if the guest does not use the vfio-based device after it
has been made available? Will you still disable the virtio-net link?
(All that link handling definitely sounds like a task for libvirt or
the like.)

Regarding hot(un)plugging during migration, I think you also need to
keep in mind that different architectures/busses have different
semantics there. Something that works if there's an unplug handshake may
not work on a platform with surprise removal.

Have you considered guest agents? All of this is punching through
several layers, and I'm not sure if that is a good idea.
