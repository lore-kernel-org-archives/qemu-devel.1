Received: from eggs.gnu.org ([2001:4830:134:3::10]:34600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fLt35-0007pn-E9
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fLt2z-00023T-Eh
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:25:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:22859)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fLt2z-00022Y-49
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:25:01 -0400
Date: Fri, 25 May 2018 00:25:19 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180524162519.GA24120@debian>
References: <20180524103336.21233-1-tiwei.bie@intel.com>
	<20180524103336.21233-5-tiwei.bie@intel.com>
	<20180524184438-mutt-send-email-mst@kernel.org>
	<20180524160549.GA15321@debian>
	<20180524191330-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180524191330-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org

On Thu, May 24, 2018 at 07:15:24PM +0300, Michael S. Tsirkin wrote:
> On Fri, May 25, 2018 at 12:05:50AM +0800, Tiwei Bie wrote:
> > On Thu, May 24, 2018 at 06:49:47PM +0300, Michael S. Tsirkin wrote:
> > > On Thu, May 24, 2018 at 06:33:34PM +0800, Tiwei Bie wrote:
> > > > This patch introduces VHOST_USER_PROTOCOL_F_HOST_NOTIFIER.
> > > > With this feature negotiated, vhost-user backend can register
> > > > memory region based host notifiers. And it will allow the guest
> > > > driver in the VM to notify the hardware accelerator at the
> > > > vhost-user backend directly.
> > > > 
> > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > 
> > > So maybe we don't need a new VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD?
> > > Let's check VHOST_USER_PROTOCOL_F_HOST_NOTIFIER instead?
> > 
> > Yeah. I think it would be the best choice!
> > 
> > If this feature (HOST NOTIFIER) is negotiated, it means
> > the QEMU is able to safely receive (the expected number
> > of) file descriptors.
> > 
> > > 
> > > > ---
> > [...]
> > > > +typedef struct VhostUserHostNotifier {
> > > > +    MemoryRegion mr;
> > > > +    void *addr;
> > > > +    bool set;
> > > > +} VhostUserHostNotifier;
> > > >  
> > > >  typedef struct VhostUserState {
> > > >      CharBackend *chr;
> > > > +    VhostUserHostNotifier notifier[VIRTIO_QUEUE_MAX];
> > > >  } VhostUserState;
> > > 
> > > So this notifier is per-queue. Can't we maintain it in
> > > NetVhostUserState then?
> > 
> > This notifier is per virtio-queue. But NetVhostUserState
> > is per net-queue-pair.
> > 
> > And ideally, I think this structure shouldn't be visible
> > to net/vhost-user, vhost-user-scsi, vhost-user-crypto, etc.
> > 
> > Best regards,
> > Tiwei Bie
> 
> I wonder whether we can create a new per vq structure.

Maybe something like:

typedef struct VhostUserStatePerVQ {
    VhostUserHostNotifier notifier;
} VhostUserStatePerVQ;

typedef struct VhostUserState {
    CharBackend *chr;
    VhostUserStatePerVQ queue[VIRTIO_QUEUE_MAX];
} VhostUserState;

Best regards,
Tiwei Bie
