Received: from eggs.gnu.org ([2001:4830:134:3::10]:57626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dQJ7C-0002fU-OX
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dQJ78-00083l-Rq
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dQJ78-00083b-IF
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:59:02 -0400
Date: Wed, 28 Jun 2017 12:59:00 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170628215429.34bd52ac@bahia.lab.toulouse-stg.fr.ibm.com>
Message-ID: <alpine.DEB.2.10.1706281258520.2919@sstabellini-ThinkPad-X260>
References: <149820029273.7187.14110849422638329192.stgit@bahia.lan>
	<149820032558.7187.9574922678907797880.stgit@bahia.lan>
	<alpine.DEB.2.10.1706261553370.12819@sstabellini-ThinkPad-X260>
	<20170627085418.38a58b9e@bahia.lab.toulouse-stg.fr.ibm.com>
	<alpine.DEB.2.10.1706271510090.24648@sstabellini-ThinkPad-X260>
	<20170628132257.18124fc8@bahia.lab.toulouse-stg.fr.ibm.com>
	<alpine.DEB.2.10.1706281139470.2919@sstabellini-ThinkPad-X260>
	<20170628215429.34bd52ac@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v4 3/4] virtio-9p: break device if buffers
 are misconfigured
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, 28 Jun 2017, Greg Kurz wrote:
> On Wed, 28 Jun 2017 11:54:28 -0700 (PDT)
> Stefano Stabellini <sstabellini@kernel.org> wrote:
> [...]
> > > > @@ -125,10 +127,19 @@ static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
> > > >      Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
> > > >      struct iovec in_sg[2];
> > > >      int num;
> > > > +    ssize_t ret;
> > > >  
> > > >      xen_9pfs_in_sg(&xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings],
> > > >                     in_sg, &num, pdu->idx, ROUND_UP(offset + 128, 512));
> > > > -    return v9fs_iov_vmarshal(in_sg, num, offset, 0, fmt, ap);
> > > > +    
> > > > +    ret = v9fs_iov_vmarshal(in_sg, num, offset, 0, fmt, ap);
> > > > +    if (ret < 0) {
> > > > +        xen_pv_printf(&xen_9pfs->xendev, 0,
> > > > +                      "Failed to encode VirtFS request type %d\n", pdu->id + 1);
> > > > +        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);  
> > > 
> > > Shouldn't the state be set in xen_9pfs_disconnect() ?  
> > 
> > No, because xen_9pfs_disconnect is also used as a callback from
> > hw/xen/xen_backend.c, which also sets the state to XenbusStateClosing,
> > see xen_be_disconnect.
> > 
> 
> Oh ok, I see.
> 
> > 
> > > > +        xen_9pfs_disconnect(&xen_9pfs->xendev);
> > > > +    }
> > > > +    return ret;
> > > >  }
> > > >  
> > > >  static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
> > > > @@ -139,10 +150,19 @@ static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
> > > >      Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
> > > >      struct iovec out_sg[2];
> > > >      int num;
> > > > +    ssize_t ret;
> > > >  
> > > >      xen_9pfs_out_sg(&xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings],
> > > >                      out_sg, &num, pdu->idx);
> > > > -    return v9fs_iov_vunmarshal(out_sg, num, offset, 0, fmt, ap);
> > > > +    
> > > > +    ret = v9fs_iov_vunmarshal(out_sg, num, offset, 0, fmt, ap);
> > > > +    if (ret < 0) {
> > > > +        xen_pv_printf(&xen_9pfs->xendev, 0,
> > > > +                      "Failed to decode VirtFS request type %d\n", pdu->id);
> > > > +        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
> > > > +        xen_9pfs_disconnect(&xen_9pfs->xendev);  
> > > 
> > > Same here
> > >   
> > > > +    }
> > > > +    return ret;
> > > >  }
> > > >  
> > > >  static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
> > > > @@ -170,11 +190,22 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
> > > >      Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
> > > >      Xen9pfsRing *ring = &xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings];
> > > >      int num;
> > > > +    size_t buf_size;
> > > >  
> > > >      g_free(ring->sg);
> > > >  
> > > >      ring->sg = g_malloc0(sizeof(*ring->sg) * 2);
> > > >      xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
> > > > +
> > > > +    buf_size = iov_size(ring->sg, num);
> > > > +    if (buf_size  < size) {
> > > > +        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
> > > > +                "needs %zu bytes, buffer has %zu\n", pdu->id, size,
> > > > +                buf_size);
> > > > +        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
> > > > +        xen_9pfs_disconnect(&xen_9pfs->xendev);
> > > > +    }
> > > > +
> > > >      *piov = ring->sg;
> > > >      *pniov = num;
> > > >  }
> > > > @@ -218,7 +249,7 @@ static int xen_9pfs_init(struct XenDevice *xendev)
> > > >  static int xen_9pfs_receive(Xen9pfsRing *ring)
> > > >  {
> > > >      P9MsgHeader h;
> > > > -    RING_IDX cons, prod, masked_prod, masked_cons;
> > > > +    RING_IDX cons, prod, masked_prod, masked_cons, queued;
> > > >      V9fsPDU *pdu;
> > > >  
> > > >      if (ring->inprogress) {
> > > > @@ -229,8 +260,8 @@ static int xen_9pfs_receive(Xen9pfsRing *ring)
> > > >      prod = ring->intf->out_prod;
> > > >      xen_rmb();
> > > >  
> > > > -    if (xen_9pfs_queued(prod, cons, XEN_FLEX_RING_SIZE(ring->ring_order)) <
> > > > -        sizeof(h)) {
> > > > +    queued = xen_9pfs_queued(prod, cons, XEN_FLEX_RING_SIZE(ring->ring_order));
> > > > +    if (queued < sizeof(h)) {
> > > >          return 0;  
> > > 
> > > Shouldn't this return an error as well ?  
> > 
> > Well spotted! But I am actually thinking that I shouldn't be returning
> > errors at all now from xen_9pfs_receive. The function xen_9pfs_receive
> > is always called to check for updates. It can be called even when there
> > are no updates available. In those cases, there isn't enough data on the
> > ring to proceed. I think it is correct to return 0 here.
> > 
> > The more difficult case is below. What if the data is only partially
> > written to the ring? The check (queued < ring->out_size) would fail. I
> > think we should return 0 (not an error) there too, because the other end
> > could be in the middle of writing. But obviously we shouldn't proceed
> > either.
> > 
> 
> Makes sense.
> 
> > 
> > > >      }
> > > >      ring->inprogress = true;
> > > > @@ -247,6 +278,15 @@ static int xen_9pfs_receive(Xen9pfsRing *ring)
> > > >      ring->out_size = le32_to_cpu(h.size_le);
> > > >      ring->out_cons = cons + le32_to_cpu(h.size_le);
> > > >  
> > > > +    if (queued < ring->out_size) {
> > > > +        xen_pv_printf(&ring->priv->xendev, 0, "Xen 9pfs request type %d"
> > > > +                "needs %u bytes, buffer has %u\n", pdu->id, ring->out_size,
> > > > +                queued);
> > > > +        xen_be_set_state(&ring->priv->xendev, XenbusStateClosing);
> > > > +        xen_9pfs_disconnect(&ring->priv->xendev);
> > > > +        return -EINVAL;
> > > > +    }  
> > 
> > So I think this should just be
> > 
> >     if (queued < ring->out_size) {
> >         return 0;
> >     }
> 
> Ok, I'll change it in your patch.

Thank you!


> > 
> > 
> > > >      pdu_submit(pdu, &h);
> > > >  
> > > >      return 0;
> > > > @@ -269,15 +309,30 @@ static void xen_9pfs_evtchn_event(void *opaque)
> > > >      qemu_bh_schedule(ring->bh);
> > > >  }
> > > >  
> > > > -static int xen_9pfs_free(struct XenDevice *xendev)
> > > > +static void xen_9pfs_disconnect(struct XenDevice *xendev)
> > > >  {
> > > > +    Xen9pfsDev *xen_9pdev = container_of(xendev, Xen9pfsDev, xendev);
> > > >      int i;
> > > > +
> > > > +    for (i = 0; i < xen_9pdev->num_rings; i++) {
> > > > +        if (xen_9pdev->rings[i].evtchndev != NULL) {
> > > > +            qemu_set_fd_handler(xenevtchn_fd(xen_9pdev->rings[i].evtchndev),
> > > > +                    NULL, NULL, NULL);
> > > > +            xenevtchn_unbind(xen_9pdev->rings[i].evtchndev,
> > > > +                             xen_9pdev->rings[i].local_port);
> > > > +            xen_9pdev->rings[i].evtchndev = NULL;
> > > > +        }
> > > > +    }
> > > > +}
> > > > +
> > > > +static int xen_9pfs_free(struct XenDevice *xendev)
> > > > +{
> > > >      Xen9pfsDev *xen_9pdev = container_of(xendev, Xen9pfsDev, xendev);
> > > > +    int i;
> > > >  
> > > > -    g_free(xen_9pdev->id);
> > > > -    g_free(xen_9pdev->tag);
> > > > -    g_free(xen_9pdev->path);
> > > > -    g_free(xen_9pdev->security_model);
> > > > +    if (xen_9pdev->rings[0].evtchndev != NULL) {
> > > > +        xen_9pfs_disconnect(xendev);
> > > > +    }
> > > >  
> > > >      for (i = 0; i < xen_9pdev->num_rings; i++) {
> > > >          if (xen_9pdev->rings[i].data != NULL) {
> > > > @@ -290,16 +345,15 @@ static int xen_9pfs_free(struct XenDevice *xendev)
> > > >                      xen_9pdev->rings[i].intf,
> > > >                      1);
> > > >          }
> > > > -        if (xen_9pdev->rings[i].evtchndev > 0) {
> > > > -            qemu_set_fd_handler(xenevtchn_fd(xen_9pdev->rings[i].evtchndev),
> > > > -                    NULL, NULL, NULL);
> > > > -            xenevtchn_unbind(xen_9pdev->rings[i].evtchndev,
> > > > -                             xen_9pdev->rings[i].local_port);
> > > > -        }
> > > >          if (xen_9pdev->rings[i].bh != NULL) {
> > > >              qemu_bh_delete(xen_9pdev->rings[i].bh);
> > > >          }
> > > >      }
> > > > +
> > > > +    g_free(xen_9pdev->id);
> > > > +    g_free(xen_9pdev->tag);
> > > > +    g_free(xen_9pdev->path);
> > > > +    g_free(xen_9pdev->security_model);
> > > >      g_free(xen_9pdev->rings);
> > > >      return 0;
> > > >  }
> > > > @@ -423,11 +477,6 @@ static void xen_9pfs_alloc(struct XenDevice *xendev)
> > > >      xenstore_write_be_int(xendev, "max-ring-page-order", MAX_RING_ORDER);
> > > >  }
> > > >  
> > > > -static void xen_9pfs_disconnect(struct XenDevice *xendev)
> > > > -{
> > > > -    /* Dynamic hotplug of PV filesystems at runtime is not supported. */
> > > > -}
> > > > -
> > > >  struct XenDevOps xen_9pfs_ops = {
> > > >      .size       = sizeof(Xen9pfsDev),
> > > >      .flags      = DEVOPS_FLAG_NEED_GNTDEV,  
> 
> 
