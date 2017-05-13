Received: from eggs.gnu.org ([2001:4830:134:3::10]:54910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d9KWb-0000rJ-Ek
	for qemu-devel@nongnu.org; Fri, 12 May 2017 20:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d9KWY-0008D2-Bu
	for qemu-devel@nongnu.org; Fri, 12 May 2017 20:03:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1d9KWY-0008Ax-2N
	for qemu-devel@nongnu.org; Fri, 12 May 2017 20:03:06 -0400
Date: Sat, 13 May 2017 03:02:59 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170513025938-mutt-send-email-mst@kernel.org>
References: <20170511123246.31308-1-maxime.coquelin@redhat.com>
	<20170511123246.31308-7-maxime.coquelin@redhat.com>
	<20170511203345-mutt-send-email-mst@kernel.org>
	<62516ce5-9d4c-d021-c4ab-a767c7f07b31@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62516ce5-9d4c-d021-c4ab-a767c7f07b31@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/6] spec/vhost-user spec: Add IOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com

On Fri, May 12, 2017 at 04:21:58PM +0200, Maxime Coquelin wrote:
> 
> 
> On 05/11/2017 08:25 PM, Michael S. Tsirkin wrote:
> > On Thu, May 11, 2017 at 02:32:46PM +0200, Maxime Coquelin wrote:
> > > This patch specifies and implements the master/slave communication
> > > to support device IOTLB in slave.
> > > 
> > > The vhost_iotlb_msg structure introduced for kernel backends is
> > > re-used, making the design close between the two backends.
> > > 
> > > An exception is the use of the secondary channel to enable the
> > > slave to send IOTLB miss requests to the master.
> > > 
> > > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > ---
> > >   docs/specs/vhost-user.txt | 75 +++++++++++++++++++++++++++++++++++++++++++++++
> > >   hw/virtio/vhost-user.c    | 31 ++++++++++++++++++++
> > >   2 files changed, 106 insertions(+)
> > > 
> > > diff --git a/docs/specs/vhost-user.txt b/docs/specs/vhost-user.txt
> > > index 5fa7016..4a1f0c3 100644
> > > --- a/docs/specs/vhost-user.txt
> > > +++ b/docs/specs/vhost-user.txt
> > > @@ -97,6 +97,23 @@ Depending on the request type, payload can be:
> > >      log offset: offset from start of supplied file descriptor
> > >          where logging starts (i.e. where guest address 0 would be logged)
> > > + * An IOTLB message
> > > +   ---------------------------------------------------------
> > > +   | iova | size | user address | permissions flags | type |
> > > +   ---------------------------------------------------------
> > > +
> > > +   IOVA: a 64-bit guest I/O virtual address
> > 
> > guest -> VM
> 
> Ok.
> 
> > 
> > > +   Size: a 64-bit size
> > 
> > How do you specify "all memory"? give special meaning to size 0?
> 
> Good point, it does not support all memory currently.
> It is not vhost-user specific, but general to the vhost implementation.

But iommu needs it to support passthrough.

> 
> > > +   User address: a 64-bit user address
> > > +   Permissions flags: a 8-bit bit field:
> > > +    - Bit 0: Read access
> > > +    - Bit 1: Write access
> > 
> > Can both bits be set? Can none?
> 
> Both. I will change it by listing values directly:
>  - 0 : No access
>  - 1 : Read
>  - 2 : Write
>  - 3 : Read Write
> 
> > > +   Type: a 8-bit IOTLB message type:
> > > +    - 1: IOTLB miss
> > > +    - 2: IOTLB update
> > > +    - 3: IOTLB invalidate
> > > +    - 4: IOTLB access fail
> > > +
> > >   In QEMU the vhost-user message is implemented with the following struct:
> > >   typedef struct VhostUserMsg {
> > > @@ -109,6 +126,7 @@ typedef struct VhostUserMsg {
> > >           struct vhost_vring_addr addr;
> > >           VhostUserMemory memory;
> > >           VhostUserLog log;
> > > +        struct vhost_iotlb_msg iotlb;
> > >       };
> > >   } QEMU_PACKED VhostUserMsg;
> > > @@ -253,6 +271,31 @@ Once the source has finished migration, rings will be stopped by
> > >   the source. No further update must be done before rings are
> > >   restarted.
> > > +IOMMU support
> > > +-------------
> > > +
> > > +When the VIRTIO_F_IOMMU_PLATFORM feature has been negotiated, the master has
> > > +to send IOTLB entries update & invalidation by sending VHOST_USER_IOTLB_MSG
> > > +requests to the slave with a struct vhost_iotlb_msg payload.
> > 
> > Always? This seems a bit strange since iommu can be enabled/disabled
> > dynamically.
> Ok, what about:
> 
> When the VIRTIO_F_IOMMU_PLATFORM feature has been negotiated and iommu
> is enbaled, the master sends IOTLB entries update & invalidation via
> VHOST_USER_IOTLB_MSG requests to the slave with a struct vhost_iotlb_msg
> payload.
> 
> 
> > Closing channel seems like a wrong thing to do for this.
> 
> Sorry, I'm not sure to get your comment.

What happens when guest disables the IOMMU?

> > > For update events,
> > > +the iotlb payload has to be filled with the update message type (2), the I/O
> > > +virtual address, the size, the user virtual address, and the permissions
> > > +flags. For invalidation events, the iotlb payload has to be filled with the
> > > +invalidation message type (3), the I/O virtual address and the size. On
> > > +success, the slave is expected to reply with a zero payload, non-zero
> > > +otherwise.
> > > +
> > > +When the VHOST_USER_PROTOCOL_F_SLAVE_REQ is supported by the slave, and the
> > > +master initiated the slave to master communication channel using the
> > > +VHOST_USER_SET_SLAVE_REQ_FD request, the slave can send IOTLB miss and access
> > > +failure events by sending VHOST_USER_SLAVE_IOTLB_MSG requests to the master
> > > +with a struct vhost_iotlb_msg payload. For miss events, the iotlb payload has
> > > +to be filled with the miss message type (1), the I/O virtual address and the
> > > +permissions flags. For access failure event, the iotlb payload has to be
> > > +filled with the access failure message type (4), the I/O virtual address and
> > > +the permissions flags. For synchronization purpose, the slave may rely on the
> > > +reply-ack feature, so the master may send a reply when operation is completed
> > > +if the reply-ack feature is negotiated and slaves requests a reply.
> > > +
> > >   Slave communication
> > >   -------------------
> > > @@ -514,6 +557,38 @@ Master message types
> > >         If VHOST_USER_PROTOCOL_F_REPLY_ACK is negotiated, slave must respond
> > >         with zero for success, non-zero otherwise.
> > > + * VHOST_USER_IOTLB_MSG
> > > +
> > > +      Id: 22
> > > +      Equivalent ioctl: N/A (equivalent to VHOST_IOTLB_MSG message type)
> > > +      Master payload: struct vhost_iotlb_msg
> > > +      Slave payload: u64
> > > +
> > > +      Send IOTLB messages with struct vhost_iotlb_msg as payload.
> > > +      Master sends such requests to update and invalidate entries in the device
> > > +      IOTLB. The slave has to acknowledge the request with sending zero as u64
> > > +      payload for success, non-zero otherwise.
> > > +      This request should be send only when VIRTIO_F_IOMMU_PLATFORM feature
> > > +      has been successfully negotiated.
> > > +
> > > +Slave message types
> > > +-------------------
> > > +
> > > + * VHOST_USER_SLAVE_IOTLB_MSG
> > > +
> > > +      Id: 1
> > > +      Equivalent ioctl: N/A (equivalent to VHOST_IOTLB_MSG message type)
> > > +      Slave payload: struct vhost_iotlb_msg
> > > +      Master payload: N/A
> > > +
> > > +      Send IOTLB messages with struct vhost_iotlb_msg as payload.
> > > +      Slave sends such requests to notify of an IOTLB miss, or an IOTLB
> > > +      access failure. If VHOST_USER_PROTOCOL_F_REPLY_ACK is negotiated,
> > > +      and slave set the VHOST_USER_NEED_REPLY flag, master must respond with
> > > +      zero when operation is successfully completed, or non-zero otherwise.
> > > +      This request should be send only when VIRTIO_F_IOMMU_PLATFORM feature
> > > +      has been successfully negotiated.
> > > +
> > 
> > Are there limitations on number of messages in flight?
> 
> I didn't think about this, I would say the maximum number of messages in
> flight is dependent on the socket buffer size (which is kept to default
> in this series).
> 
> You question highlights a bug in by DPDK prototype, as the MISS request
> can be sent by multiple threads, and I didn't protected this with a lock
> to prevent concurrent read on the socket when waiting for the REPLY_ACK.
> 
> Thanks,
> Maxime

A way to make it work without a lock might possibly be valuable.
Can be done on top.

-- 
MST
