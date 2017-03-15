Received: from eggs.gnu.org ([2001:4830:134:3::10]:35402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1coH0q-0005BN-Jp
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 18:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1coH0n-0003ru-Fk
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 18:03:20 -0400
Received: from mail.kernel.org ([198.145.29.136]:39384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1coH0n-0003rL-65
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 18:03:17 -0400
Date: Wed, 15 Mar 2017 15:03:12 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170315125341.09f9c53e@bahia.lab.toulouse-stg.fr.ibm.com>
Message-ID: <alpine.DEB.2.10.1703151500080.14378@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1703131650550.21520@sstabellini-ThinkPad-X260>
	<1489449360-14411-1-git-send-email-sstabellini@kernel.org>
	<1489449360-14411-6-git-send-email-sstabellini@kernel.org>
	<20170315125341.09f9c53e@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 6/9] xen/9pfs: receive requests from the
 frontend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com, qemu-devel@nongnu.org, Stefano Stabellini <stefano@aporeto.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, anthony.perard@citrix.com, xen-devel@lists.xenproject.org

On Wed, 15 Mar 2017, Greg Kurz wrote:
> On Mon, 13 Mar 2017 16:55:57 -0700
> Stefano Stabellini <sstabellini@kernel.org> wrote:
> 
> > Upon receiving an event channel notification from the frontend, schedule
> > the bottom half. From the bottom half, read one request from the ring,
> > create a pdu and call pdu_submit to handle it.
> > 
> > For now, only handle one request per ring at a time.
> > 
> > Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> > CC: anthony.perard@citrix.com
> > CC: jgross@suse.com
> > CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > CC: Greg Kurz <groug@kaod.org>
> > ---
> 
> Oops, one more remark I forgot in my the previous mail. See below.
> 
> >  hw/9pfs/xen-9p-backend.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> > 
> > diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> > index 0e4a133..741dd31 100644
> > --- a/hw/9pfs/xen-9p-backend.c
> > +++ b/hw/9pfs/xen-9p-backend.c
> > @@ -94,12 +94,59 @@ static int xen_9pfs_init(struct XenDevice *xendev)
> >      return 0;
> >  }
> >  
> > +static int xen_9pfs_receive(struct Xen9pfsRing *ring)
> > +{
> > +    struct xen_9pfs_header h;
> > +    RING_IDX cons, prod, masked_prod, masked_cons;
> > +    V9fsPDU *pdu;
> > +
> > +    if (ring->inprogress) {
> > +        return 0;
> > +    }
> > +
> > +    cons = ring->intf->out_cons;
> > +    prod = ring->intf->out_prod;
> > +    xen_rmb();
> > +
> > +    if (xen_9pfs_queued(prod, cons, XEN_9PFS_RING_SIZE) < sizeof(h)) {
> > +        return 0;
> > +    }
> > +    ring->inprogress = true;
> > +
> > +    masked_prod = xen_9pfs_mask(prod, XEN_9PFS_RING_SIZE);
> > +    masked_cons = xen_9pfs_mask(cons, XEN_9PFS_RING_SIZE);
> > +
> > +    xen_9pfs_read_packet(ring->ring.out, masked_prod, &masked_cons,
> > +                         XEN_9PFS_RING_SIZE, (uint8_t*) &h, sizeof(h));
> > +
> > +    pdu = pdu_alloc(&ring->priv->state);
> > +    pdu->size = h.size;
> 
> 9P uses little-endian, so this should be:
> 
>     pdu->size = le32_to_cpu(h.size);
> 
> > +    pdu->id = h.id;
> > +    pdu->tag = h.tag;
> 
> and:
> 
>     pdu->tag = le16_to_cpu(h.tag);
> 
> > +    ring->out_size = h.size;
> > +    ring->out_cons = cons + h.size;
> 
> Same here.

OK, thanks. Xen doesn't support big endian today, but they don't hurt.


> > +
> > +    qemu_co_queue_init(&pdu->complete);
> > +    pdu_submit(pdu);
> > +
> > +    return 0;
> > +}
> > +
> >  static void xen_9pfs_bh(void *opaque)
> >  {
> > +    struct Xen9pfsRing *ring = opaque;
> > +    xen_9pfs_receive(ring);
> >  }
> >  
> >  static void xen_9pfs_evtchn_event(void *opaque)
> >  {
> > +    struct Xen9pfsRing *ring = opaque;
> > +    evtchn_port_t port;
> > +
> > +    port = xenevtchn_pending(ring->evtchndev);
> > +    xenevtchn_unmask(ring->evtchndev, port);
> > +
> > +    qemu_bh_schedule(ring->bh);
> >  }
> >  
> >  static int xen_9pfs_free(struct XenDevice *xendev)
> 
> 
