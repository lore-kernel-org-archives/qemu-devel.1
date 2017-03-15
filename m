Received: from eggs.gnu.org ([2001:4830:134:3::10]:33566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1coGwU-0003av-Hq
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 17:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1coGwR-0001f5-EH
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 17:58:50 -0400
Received: from mail.kernel.org ([198.145.29.136]:38606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1coGwR-0001es-4L
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 17:58:47 -0400
Date: Wed, 15 Mar 2017 14:58:42 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170315115841.0b5e2a1c@bahia.lab.toulouse-stg.fr.ibm.com>
Message-ID: <alpine.DEB.2.10.1703151458090.14378@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1703131650550.21520@sstabellini-ThinkPad-X260>
	<1489449360-14411-1-git-send-email-sstabellini@kernel.org>
	<1489449360-14411-7-git-send-email-sstabellini@kernel.org>
	<20170315115841.0b5e2a1c@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 7/9] xen/9pfs: implement
 in/out_iov_from_pdu and vmarshal/vunmarshal
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
> On Mon, 13 Mar 2017 16:55:58 -0700
> Stefano Stabellini <sstabellini@kernel.org> wrote:
> 
> > Implement xen_9pfs_init_in/out_iov_from_pdu and
> > xen_9pfs_pdu_vmarshal/vunmarshall by creating new sg pointing to the
> > data on the ring.
> > 
> > This is safe as we only handle one request per ring at any given time.
> > 
> > Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> > CC: anthony.perard@citrix.com
> > CC: jgross@suse.com
> > CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > CC: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/9pfs/xen-9p-backend.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 89 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> > index 741dd31..d72a749 100644
> > --- a/hw/9pfs/xen-9p-backend.c
> > +++ b/hw/9pfs/xen-9p-backend.c
> > @@ -48,12 +48,77 @@ typedef struct Xen9pfsDev {
> >      struct Xen9pfsRing *rings;
> >  } Xen9pfsDev;
> >  
> > +static void xen_9pfs_in_sg(struct Xen9pfsRing *ring,
> 
> Coding style for structured types.

OK


> > +                           struct iovec *in_sg,
> > +                           int *num,
> > +                           uint32_t idx,
> > +                           uint32_t size)
> > +{
> > +    RING_IDX cons, prod, masked_prod, masked_cons;
> > +
> > +    cons = ring->intf->in_cons;
> > +    prod = ring->intf->in_prod;
> > +    xen_rmb();
> > +    masked_prod = xen_9pfs_mask(prod, XEN_9PFS_RING_SIZE);
> > +    masked_cons = xen_9pfs_mask(cons, XEN_9PFS_RING_SIZE);
> > +
> > +    if (masked_prod < masked_cons) {
> > +        in_sg[0].iov_base = ring->ring.in + masked_prod;
> > +        in_sg[0].iov_len = masked_cons - masked_prod;
> > +        *num = 1;
> > +    } else {
> > +        in_sg[0].iov_base = ring->ring.in + masked_prod;
> > +        in_sg[0].iov_len = XEN_9PFS_RING_SIZE - masked_prod;
> > +        in_sg[1].iov_base = ring->ring.in;
> > +        in_sg[1].iov_len = masked_cons;
> > +        *num = 2;
> > +    }
> > +}
> > +
> > +static void xen_9pfs_out_sg(struct Xen9pfsRing *ring,
> 
> Coding style for structured types.

OK

> > +                            struct iovec *out_sg,
> > +                            int *num,
> > +                            uint32_t idx)
> > +{
> > +    RING_IDX cons, prod, masked_prod, masked_cons;
> > +
> > +    cons = ring->intf->out_cons;
> > +    prod = ring->intf->out_prod;
> > +    xen_rmb();
> > +    masked_prod = xen_9pfs_mask(prod, XEN_9PFS_RING_SIZE);
> > +    masked_cons = xen_9pfs_mask(cons, XEN_9PFS_RING_SIZE);
> > +
> > +    if (masked_cons < masked_prod) {
> > +        out_sg[0].iov_base = ring->ring.out + masked_cons;
> > +        out_sg[0].iov_len = ring->out_size;
> > +        *num = 1;
> > +    } else {
> > +        if (ring->out_size > (XEN_9PFS_RING_SIZE - masked_cons)) {
> > +            out_sg[0].iov_base = ring->ring.out + masked_cons;
> > +            out_sg[0].iov_len = XEN_9PFS_RING_SIZE - masked_cons;
> > +            out_sg[1].iov_base = ring->ring.out;
> > +            out_sg[1].iov_len = ring->out_size - (XEN_9PFS_RING_SIZE - masked_cons);
> > +            *num = 2;
> > +        } else {
> > +            out_sg[0].iov_base = ring->ring.out + masked_cons;
> > +            out_sg[0].iov_len = ring->out_size;
> > +            *num = 1;
> > +        }
> > +    }
> > +}
> > +
> >  static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
> >                                       size_t offset,
> >                                       const char *fmt,
> >                                       va_list ap)
> >  {
> > -    return 0;
> > +    struct Xen9pfsDev *xen_9pfs = container_of(pdu->s, struct Xen9pfsDev, state);
> 
> Coding style for structured types.

OK 


> > +    struct iovec in_sg[2];
> > +    int num;
> > +
> > +    xen_9pfs_in_sg(&xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings],
> > +                   in_sg, &num, pdu->idx, ROUND_UP(offset + 128, 512));
> > +    return v9fs_iov_vmarshal(in_sg, num, offset, 0, fmt, ap);
> >  }
> >  
> >  static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
> > @@ -61,13 +126,27 @@ static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
> >                                         const char *fmt,
> >                                         va_list ap)
> >  {
> > -    return 0;
> > +    struct Xen9pfsDev *xen_9pfs = container_of(pdu->s, struct Xen9pfsDev, state);
> 
> Coding style for structured types.

OK


> > +    struct iovec out_sg[2];
> > +    int num;
> > +
> > +    xen_9pfs_out_sg(&xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings],
> > +                    out_sg, &num, pdu->idx);
> > +    return v9fs_iov_vunmarshal(out_sg, num, offset, 0, fmt, ap);
> >  }
> >  
> >  static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
> >                                             struct iovec **piov,
> >                                             unsigned int *pniov)
> >  {
> > +    struct Xen9pfsDev *xen_9pfs = container_of(pdu->s, struct Xen9pfsDev, state);
> > +    struct Xen9pfsRing *ring = &xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings];
> 
> Coding style for structured types.

OK


> > +    struct iovec *sg = g_malloc0(sizeof(*sg)*2);
> > +    int num;
> > +
> > +    xen_9pfs_out_sg(ring, sg, &num, pdu->idx);
> > +    *piov = sg;
> > +    *pniov = num;
> >  }
> >  
> >  static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
> > @@ -75,6 +154,14 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
> >                                            unsigned int *pniov,
> >                                            size_t size)
> >  {
> > +    struct Xen9pfsDev *xen_9pfs = container_of(pdu->s, struct Xen9pfsDev, state);
> > +    struct Xen9pfsRing *ring = &xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings];
> 
> Coding style for structured types.

OK :-)


> > +    struct iovec *sg = g_malloc0(sizeof(*sg)*2);
> > +    int num;
> > +
> > +    xen_9pfs_in_sg(ring, sg, &num, pdu->idx, size);
> > +    *piov = sg;
> > +    *pniov = num;
> >  }
> >  
> >  static void xen_9pfs_push_and_notify(V9fsPDU *pdu)
> 
> 
