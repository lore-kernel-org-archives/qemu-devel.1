Received: from eggs.gnu.org ([2001:4830:134:3::10]:34303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXODW-0003iy-27
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXODQ-0001ux-VA
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:55:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33758 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fXODQ-0001ul-JW
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:55:20 -0400
Date: Mon, 25 Jun 2018 11:55:12 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180625115512.2f29844e.cohuck@redhat.com>
In-Reply-To: <20180622214259-mutt-send-email-mst@kernel.org>
References: <CADGSJ208NRp=bjhSkzF2K5Ft94TwdRs73WfSp4h-_vXvEKwgiQ@mail.gmail.com>
	<20180619125453.2d2dfb2d.cohuck@redhat.com>
	<20180619233001-mutt-send-email-mst@kernel.org>
	<20180620115359.1a3bf6fb.cohuck@redhat.com>
	<20180620170904-mutt-send-email-mst@kernel.org>
	<20180620180619.6b4ee52d.cohuck@redhat.com>
	<20180620224535-mutt-send-email-mst@kernel.org>
	<20180621165913.7e3f4faa.cohuck@redhat.com>
	<20180621211712-mutt-send-email-mst@kernel.org>
	<20180622170955.298900c1.cohuck@redhat.com>
	<20180622214259-mutt-send-email-mst@kernel.org>
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
Cc: Siwei Liu <loseweigh@gmail.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, vijay.balakrishna@oracle.com

On Fri, 22 Jun 2018 22:05:50 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jun 22, 2018 at 05:09:55PM +0200, Cornelia Huck wrote:
> > On Thu, 21 Jun 2018 21:20:13 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Thu, Jun 21, 2018 at 04:59:13PM +0200, Cornelia Huck wrote:  
> > > > OK, so what about the following:
> > > > 
> > > > - introduce a new feature bit, VIRTIO_NET_F_STANDBY_UUID that indicates
> > > >   that we have a new uuid field in the virtio-net config space
> > > > - in QEMU, add a property for virtio-net that allows to specify a uuid,
> > > >   offer VIRTIO_NET_F_STANDBY_UUID if set
> > > > - when configuring, set the property to the group UUID of the vfio-pci
> > > >   device
> > > > - in the guest, use the uuid from the virtio-net device's config space
> > > >   if applicable; else, fall back to matching by MAC as done today
> > > > 
> > > > That should work for all virtio transports.    
> > > 
> > > True. I'm a bit unhappy that it's virtio net specific though
> > > since down the road I expect we'll have a very similar feature
> > > for scsi (and maybe others).
> > > 
> > > But we do not have a way to have fields that are portable
> > > both across devices and transports, and I think it would
> > > be a useful addition. How would this work though? Any idea?  
> > 
> > Can we introduce some kind of device-independent config space area?
> > Pushing back the device-specific config space by a certain value if the
> > appropriate feature is negotiated and use that for things like the uuid?  
> 
> So config moves back and forth?
> Reminds me of the msi vector mess we had with pci.

Yes, that would be a bit unfortunate.

> I'd rather have every transport add a new config.

You mean via different mechanisms?

> 
> > But regardless of that, I'm not sure whether extending this approach to
> > other device types is the way to go. Tying together two different
> > devices is creating complicated situations at least in the hypervisor
> > (even if it's fairly straightforward in the guest). [I have not come
> > around again to look at the "how to handle visibility in QEMU"
> > questions due to lack of cycles, sorry about that.]
> > 
> > So, what's the goal of this approach? Only to allow migration with
> > vfio-pci, or also to plug in a faster device and use it instead of an
> > already attached paravirtualized device?  
> 
> These are two sides of the same coin, I think the second approach
> is closer to what we are doing here.

Thinking about it, do we need any knob to keep the vfio device
invisible if the virtio device is not present? IOW, how does the
hypervisor know that the vfio device is supposed to be paired with a
virtio device? It seems we need an explicit tie-in.

> 
> > What about migration of vfio devices that are not easily replaced by a
> > paravirtualized device? I'm thinking of vfio-ccw, where our main (and
> > currently only) supported device is dasd (disks) -- which can do a lot
> > of specialized things that virtio-blk does not support (and should not
> > or even cannot support).  
> 
> But maybe virtio-scsi can?

I don't think so. Dasds have some channel commands that don't map
easily to scsi commands.

> 
> > Would it be more helpful to focus on generic
> > migration support for vfio instead of going about it device by device?
> > 
> > This network device approach already seems far along, so it makes sense
> > to continue with it. But I'm not sure whether we want to spend time and
> > energy on that for other device types rather than working on a general
> > solution for vfio migration.  
> 
> I'm inclined to say finalizing this feature would be a good first step
> and will teach us how we can move forward.

I'm not opposed to figuring out this one, but I'm not sure whether we
want to extend it to more device types.

Are people looking into generic migration support? I have it on my
things-to-look-at list (figuring out what needs to be device specific
and what can be generic, figuring out how we can support vfio-ccw,
etc.).
