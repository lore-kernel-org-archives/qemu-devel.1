Received: from eggs.gnu.org ([2001:4830:134:3::10]:60626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLstn-0000Qi-BA
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLsti-0004wf-AH
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:15:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35440 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLsth-0004wL-Pu
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:15:26 -0400
Date: Thu, 24 May 2018 19:15:24 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180524191330-mutt-send-email-mst@kernel.org>
References: <20180524103336.21233-1-tiwei.bie@intel.com>
	<20180524103336.21233-5-tiwei.bie@intel.com>
	<20180524184438-mutt-send-email-mst@kernel.org>
	<20180524160549.GA15321@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524160549.GA15321@debian>
Subject: Re: [Qemu-devel] [PATCH 4/6] vhost-user: support registering
 external host notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org

On Fri, May 25, 2018 at 12:05:50AM +0800, Tiwei Bie wrote:
> On Thu, May 24, 2018 at 06:49:47PM +0300, Michael S. Tsirkin wrote:
> > On Thu, May 24, 2018 at 06:33:34PM +0800, Tiwei Bie wrote:
> > > This patch introduces VHOST_USER_PROTOCOL_F_HOST_NOTIFIER.
> > > With this feature negotiated, vhost-user backend can register
> > > memory region based host notifiers. And it will allow the guest
> > > driver in the VM to notify the hardware accelerator at the
> > > vhost-user backend directly.
> > > 
> > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > 
> > So maybe we don't need a new VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD?
> > Let's check VHOST_USER_PROTOCOL_F_HOST_NOTIFIER instead?
> 
> Yeah. I think it would be the best choice!
> 
> If this feature (HOST NOTIFIER) is negotiated, it means
> the QEMU is able to safely receive (the expected number
> of) file descriptors.
> 
> > 
> > > ---
> [...]
> > > +typedef struct VhostUserHostNotifier {
> > > +    MemoryRegion mr;
> > > +    void *addr;
> > > +    bool set;
> > > +} VhostUserHostNotifier;
> > >  
> > >  typedef struct VhostUserState {
> > >      CharBackend *chr;
> > > +    VhostUserHostNotifier notifier[VIRTIO_QUEUE_MAX];
> > >  } VhostUserState;
> > 
> > So this notifier is per-queue. Can't we maintain it in
> > NetVhostUserState then?
> 
> This notifier is per virtio-queue. But NetVhostUserState
> is per net-queue-pair.
> 
> And ideally, I think this structure shouldn't be visible
> to net/vhost-user, vhost-user-scsi, vhost-user-crypto, etc.
> 
> Best regards,
> Tiwei Bie

I wonder whether we can create a new per vq structure.

-- 
MST
