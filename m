Received: from eggs.gnu.org ([2001:4830:134:3::10]:56709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fUuCL-0005qO-Ej
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fUuCI-0008ES-6g
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:27:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38250 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fUuCI-0008Dx-13
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:27:54 -0400
Date: Mon, 18 Jun 2018 15:27:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180618152747.5b5ab22c.cohuck@redhat.com>
In-Reply-To: <20180615152926-mutt-send-email-mst@kernel.org>
References: <20180611202207-mutt-send-email-mst@kernel.org>
	<dc8b1669-b8b6-fb59-94e2-6e4de6b96572@redhat.com>
	<20180612051432-mutt-send-email-mst@kernel.org>
	<23fc4aa4-ec41-d6e2-3354-10cbfc13b7ec@intel.com>
	<20180612142557-mutt-send-email-mst@kernel.org>
	<b9c88515-cf41-2a9a-078e-9c9e5adbbf14@intel.com>
	<CADGSJ213f8tJpNXuOhv8qRew-Y5VZAwA+srNMrLZYnKdVGLdAA@mail.gmail.com>
	<20180614120231.0a72bd5f.cohuck@redhat.com>
	<20180615052743-mutt-send-email-mst@kernel.org>
	<20180615113242.799974f6.cohuck@redhat.com>
	<20180615152926-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Siwei Liu <loseweigh@gmail.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org

On Fri, 15 Jun 2018 15:31:43 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jun 15, 2018 at 11:32:42AM +0200, Cornelia Huck wrote:
> > On Fri, 15 Jun 2018 05:34:24 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Thu, Jun 14, 2018 at 12:02:31PM +0200, Cornelia Huck wrote:  
> >   
> > > > > > I am not all that familiar with how Qemu manages network devices. If we can
> > > > > > do all the
> > > > > > required management of the primary/standby devices within Qemu, that is
> > > > > > definitely a better
> > > > > > approach without upper layer involvement.      
> > > > > 
> > > > > Right. I would imagine in the extreme case the upper layer doesn't
> > > > > have to be involved at all if QEMU manages all hot plug/unplug logic.
> > > > > The management tool can supply passthrough device and virtio with the
> > > > > same group UUID, QEMU auto-manages the presence of the primary, and
> > > > > hot plug the device as needed before or after the migration.    
> > > > 
> > > > I do not really see how you can manage that kind of stuff in QEMU only.    
> > > 
> > > So right now failover is limited to pci passthrough devices only.
> > > The idea is to realize the vfio device but not expose it
> > > to guest. Have a separate command to expose it to guest.
> > > Hotunplug would also hide it from guest but not unrealize it.  
> > 
> > So, this would not be real hot(un)plug, but 'hide it from the guest',
> > right? The concept of "we have it realized in QEMU, but the guest can't
> > discover and use it" should be translatable to non-pci as well (at
> > least for ccw).
> >   
> > > 
> > > This will help ensure that e.g. on migration failure we can
> > > re-expose the device without risk of running out of resources.  
> > 
> > Makes sense.
> > 
> > Should that 'hidden' state be visible/settable from outside as well
> > (e.g. via a property)? I guess yes, so that management software has a
> > chance to see whether a device is visible.  
> 
> Might be handy for debug, but note that since QEMU manages this
> state it's transient: can change at any time, so it's kind
> of hard for management to rely on it.

Might be another reason to have this controlled by management software;
being able to find out easily why a device is not visible to the guest
seems to be a useful thing.

Anyway, let's defer this discussion until it is clear how we actually
want to handle the whole setup.

> 
> > Settable may be useful if we
> > find another use case for hiding realized devices.  
