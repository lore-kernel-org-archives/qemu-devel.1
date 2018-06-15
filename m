Received: from eggs.gnu.org ([2001:4830:134:3::10]:54635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fTeZM-0007e6-82
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fTeZI-0007dx-Pi
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:34:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50152 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fTeZI-0007bQ-Id
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:34:28 -0400
Date: Fri, 15 Jun 2018 05:34:24 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180615052743-mutt-send-email-mst@kernel.org>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<20180611202207-mutt-send-email-mst@kernel.org>
	<dc8b1669-b8b6-fb59-94e2-6e4de6b96572@redhat.com>
	<20180612051432-mutt-send-email-mst@kernel.org>
	<23fc4aa4-ec41-d6e2-3354-10cbfc13b7ec@intel.com>
	<20180612142557-mutt-send-email-mst@kernel.org>
	<b9c88515-cf41-2a9a-078e-9c9e5adbbf14@intel.com>
	<CADGSJ213f8tJpNXuOhv8qRew-Y5VZAwA+srNMrLZYnKdVGLdAA@mail.gmail.com>
	<20180614120231.0a72bd5f.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614120231.0a72bd5f.cohuck@redhat.com>
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
Cc: Siwei Liu <loseweigh@gmail.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org

On Thu, Jun 14, 2018 at 12:02:31PM +0200, Cornelia Huck wrote:
> So, do you know from the outset that there will be such a coupled
> device? I.e., is it a property of the VM definition?
> 
> Can there be a 'prepared' virtio-net device that presents the STANDBY
> feature even if there currently is no vfio-handled device available --
> but making it possible to simply hotplug that device later?
> Should it be possible to add a virtio/vfio pair later on?

Yes, that's the plan, more or less.

> > >>> I think Qemu should check if guest virtio-net supports this feature and
> > >>> provide a mechanism for
> > >>> an upper layer indicating if the STANDBY feature is successfully
> > >>> negotiated or not.
> > >>> The upper layer can then decide if it should hot plug a VF with the same
> > >>> MAC and manage the 2 links.
> > >>> If VF is successfully hot plugged, virtio-net link should be disabled.  

BTW I see no reason to do this last part. The role of the
standby device is to be always there.

> > >>
> > >> Did you even talk to upper layer management about it?
> > >> Just list the steps they need to do and you will see
> > >> that's a lot of machinery to manage by the upper layer.
> > >>
> > >> What do we gain in flexibility? As far as I can see the
> > >> only gain is some resources saved for legacy VMs.
> > >>
> > >> That's not a lot as tenant of the upper layer probably already has
> > >> at least a hunch that it's a new guest otherwise
> > >> why bother specifying the feature at all - you
> > >> save even more resources without it.
> > >>  
> > >
> > > I am not all that familiar with how Qemu manages network devices. If we can
> > > do all the
> > > required management of the primary/standby devices within Qemu, that is
> > > definitely a better
> > > approach without upper layer involvement.  
> > 
> > Right. I would imagine in the extreme case the upper layer doesn't
> > have to be involved at all if QEMU manages all hot plug/unplug logic.
> > The management tool can supply passthrough device and virtio with the
> > same group UUID, QEMU auto-manages the presence of the primary, and
> > hot plug the device as needed before or after the migration.
> 
> I do not really see how you can manage that kind of stuff in QEMU only.

So right now failover is limited to pci passthrough devices only.
The idea is to realize the vfio device but not expose it
to guest. Have a separate command to expose it to guest.
Hotunplug would also hide it from guest but not unrealize it.

This will help ensure that e.g. on migration failure we can
re-expose the device without risk of running out of resources.
-- 
MST
