Received: from eggs.gnu.org ([2001:4830:134:3::10]:40298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dQ00X-0007ME-Q3
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 19:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dQ00U-0001CX-Hw
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 19:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dQ00U-0001CE-7c
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 19:34:54 -0400
Date: Tue, 27 Jun 2017 16:34:51 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170627085418.38a58b9e@bahia.lab.toulouse-stg.fr.ibm.com>
Message-ID: <alpine.DEB.2.10.1706271510090.24648@sstabellini-ThinkPad-X260>
References: <149820029273.7187.14110849422638329192.stgit@bahia.lan>
	<149820032558.7187.9574922678907797880.stgit@bahia.lan>
	<alpine.DEB.2.10.1706261553370.12819@sstabellini-ThinkPad-X260>
	<20170627085418.38a58b9e@bahia.lab.toulouse-stg.fr.ibm.com>
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

On Tue, 27 Jun 2017, Greg Kurz wrote:
> On Mon, 26 Jun 2017 16:22:23 -0700 (PDT)
> Stefano Stabellini <sstabellini@kernel.org> wrote:
> 
> > On Fri, 23 Jun 2017, Greg Kurz wrote:
> > > The 9P protocol is transport agnostic: if the guest misconfigured the
> > > buffers, the best we can do is to set the broken flag on the device.
> > > 
> > > Since virtio_pdu_vmarshal() may be called by several active PDUs, we
> > > check if the transport isn't broken already to avoid printing extra
> > > error messages.
> > > 
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > > v4: - update changelog and add comment to explain why we check vdev->broken
> > >       in virtio_pdu_vmarshal()
> > >     - dropped uneeded vdev->broken check in virtio_pdu_vunmarshal()
> > > ---
> > >  hw/9pfs/9p.c               |    2 +-
> > >  hw/9pfs/9p.h               |    2 +-
> > >  hw/9pfs/virtio-9p-device.c |   48 +++++++++++++++++++++++++++++++++++++++-----
> > >  hw/9pfs/xen-9p-backend.c   |    3 ++-
> > >  4 files changed, 47 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > > index a0ae98f7ca6f..8e5cac71eb60 100644
> > > --- a/hw/9pfs/9p.c
> > > +++ b/hw/9pfs/9p.c
> > > @@ -1664,7 +1664,7 @@ static void v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
> > >      unsigned int niov;
> > >  
> > >      if (is_write) {
> > > -        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov);
> > > +        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov, size + skip);
> > >      } else {
> > >          pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, size + skip);
> > >      }
> > > diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> > > index aac1b0b2ce3d..d1cfeaf10e4f 100644
> > > --- a/hw/9pfs/9p.h
> > > +++ b/hw/9pfs/9p.h
> > > @@ -363,7 +363,7 @@ struct V9fsTransport {
> > >      void        (*init_in_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
> > >                                          unsigned int *pniov, size_t size);
> > >      void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
> > > -                                         unsigned int *pniov);
> > > +                                         unsigned int *pniov, size_t size);
> > >      void        (*push_and_notify)(V9fsPDU *pdu);
> > >  };
> > >  
> > > diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> > > index 1a68c1622d3a..ed9e4817a26c 100644
> > > --- a/hw/9pfs/virtio-9p-device.c
> > > +++ b/hw/9pfs/virtio-9p-device.c
> > > @@ -146,8 +146,22 @@ static ssize_t virtio_pdu_vmarshal(V9fsPDU *pdu, size_t offset,
> > >      V9fsState *s = pdu->s;
> > >      V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
> > >      VirtQueueElement *elem = v->elems[pdu->idx];
> > > -
> > > -    return v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt, ap);
> > > +    int ret;  
> > 
> > I think ret should be ssize_t
> > 
> 
> Yes, you're right. I'll change that.
> 
> > 
> > > +    ret = v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt, ap);
> > > +    if (ret < 0) {
> > > +        VirtIODevice *vdev = VIRTIO_DEVICE(v);
> > > +
> > > +        /* Any active PDU may try to send something back to the client without
> > > +         * knowing if the transport is broken or not. This could result in
> > > +         * MAX_REQ - 1 (ie, 127) extra error messages being printed.
> > > +         */
> > > +        if (!vdev->broken) {
> > > +            virtio_error(vdev, "Failed to encode VirtFS reply type %d",
> > > +                         pdu->id + 1);
> > > +        }
> > > +    }
> > > +    return ret;
> > >  }
> > >  
> > >  static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
> > > @@ -156,28 +170,52 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
> > >      V9fsState *s = pdu->s;
> > >      V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
> > >      VirtQueueElement *elem = v->elems[pdu->idx];
> > > +    int ret;  
> > 
> > same here
> > 
> 
> Ditto.
> 
> > 
> > > -    return v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1, fmt, ap);
> > > +    ret = v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1, fmt, ap);
> > > +    if (ret < 0) {
> > > +        VirtIODevice *vdev = VIRTIO_DEVICE(v);
> > > +
> > > +        virtio_error(vdev, "Failed to decode VirtFS request type %d", pdu->id);
> > > +    }
> > > +    return ret;
> > >  }
> > >  
> > > -/* The size parameter is used by other transports. Do not drop it. */
> > >  static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
> > >                                          unsigned int *pniov, size_t size)
> > >  {
> > >      V9fsState *s = pdu->s;
> > >      V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
> > >      VirtQueueElement *elem = v->elems[pdu->idx];
> > > +    size_t buf_size = iov_size(elem->in_sg, elem->in_num);
> > > +
> > > +    if (buf_size < size) {
> > > +        VirtIODevice *vdev = VIRTIO_DEVICE(v);
> > > +
> > > +        virtio_error(vdev,
> > > +                     "VirtFS reply type %d needs %zu bytes, buffer has %zu",
> > > +                     pdu->id + 1, size, buf_size);
> > > +    }
> > >  
> > >      *piov = elem->in_sg;
> > >      *pniov = elem->in_num;
> > >  }
> > >  
> > >  static void virtio_init_out_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
> > > -                                         unsigned int *pniov)
> > > +                                         unsigned int *pniov, size_t size)
> > >  {
> > >      V9fsState *s = pdu->s;
> > >      V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
> > >      VirtQueueElement *elem = v->elems[pdu->idx];
> > > +    size_t buf_size = iov_size(elem->out_sg, elem->out_num);
> > > +
> > > +    if (buf_size < size) {
> > > +        VirtIODevice *vdev = VIRTIO_DEVICE(v);
> > > +
> > > +        virtio_error(vdev,
> > > +                     "VirtFS request type %d needs %zu bytes, buffer has %zu",
> > > +                     pdu->id, size, buf_size);
> > > +    }
> > >  
> > >      *piov = elem->out_sg;
> > >      *pniov = elem->out_num;
> > > diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> > > index 922cc967be63..a82cf817fe45 100644
> > > --- a/hw/9pfs/xen-9p-backend.c
> > > +++ b/hw/9pfs/xen-9p-backend.c
> > > @@ -147,7 +147,8 @@ static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
> > >  
> > >  static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
> > >                                             struct iovec **piov,
> > > -                                           unsigned int *pniov)
> > > +                                           unsigned int *pniov,
> > > +                                           size_t size)
> > >  {
> > >      Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
> > >      Xen9pfsRing *ring = &xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings];  
> > 
> > Maybe you could include the same changes you made for xen, see below
> > 
> 
> Sure, I'd be glad to do so. I just have one concern. In the virtio case, we call
> virtio_error() which does two things: print an error message AND set the device
> broken flag (no more I/O until device is reset). Is there something similar with
> the xen transport ?

No, there isn't anything like that yet. The backend is also missing the
implementation of "disconnect", I think it is the right time to
introduce it. I made enough changes that I think they deserve their own
patch, but I would be happy if you carried it in your series.

---
xen-9pfs: disconnect if buffers are misconfigured 

Implement xen_9pfs_disconnect by unbinding the event channels. On
xen_9pfs_free, call disconnect if any event channels haven't been
disconnected.

If the frontend misconfigured the buffers set the backend to "Closing"
and disconnect it. Misconfigurations include requesting a read of more
bytes than available on the ring buffer, or claiming to be writing more
data than available on the ring buffer.

Signed-off-by: Stefano Stabellini <stefano@aporeto.com>

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index a82cf81..8db4703 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -54,6 +54,8 @@ typedef struct Xen9pfsDev {
     Xen9pfsRing *rings;
 } Xen9pfsDev;
 
+static void xen_9pfs_disconnect(struct XenDevice *xendev);
+
 static void xen_9pfs_in_sg(Xen9pfsRing *ring,
                            struct iovec *in_sg,
                            int *num,
@@ -125,10 +127,19 @@ static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
     Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
     struct iovec in_sg[2];
     int num;
+    ssize_t ret;
 
     xen_9pfs_in_sg(&xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings],
                    in_sg, &num, pdu->idx, ROUND_UP(offset + 128, 512));
-    return v9fs_iov_vmarshal(in_sg, num, offset, 0, fmt, ap);
+    
+    ret = v9fs_iov_vmarshal(in_sg, num, offset, 0, fmt, ap);
+    if (ret < 0) {
+        xen_pv_printf(&xen_9pfs->xendev, 0,
+                      "Failed to encode VirtFS request type %d\n", pdu->id + 1);
+        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
+        xen_9pfs_disconnect(&xen_9pfs->xendev);
+    }
+    return ret;
 }
 
 static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
@@ -139,10 +150,19 @@ static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
     Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
     struct iovec out_sg[2];
     int num;
+    ssize_t ret;
 
     xen_9pfs_out_sg(&xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings],
                     out_sg, &num, pdu->idx);
-    return v9fs_iov_vunmarshal(out_sg, num, offset, 0, fmt, ap);
+    
+    ret = v9fs_iov_vunmarshal(out_sg, num, offset, 0, fmt, ap);
+    if (ret < 0) {
+        xen_pv_printf(&xen_9pfs->xendev, 0,
+                      "Failed to decode VirtFS request type %d\n", pdu->id);
+        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
+        xen_9pfs_disconnect(&xen_9pfs->xendev);
+    }
+    return ret;
 }
 
 static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
@@ -170,11 +190,22 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
     Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
     Xen9pfsRing *ring = &xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings];
     int num;
+    size_t buf_size;
 
     g_free(ring->sg);
 
     ring->sg = g_malloc0(sizeof(*ring->sg) * 2);
     xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
+
+    buf_size = iov_size(ring->sg, num);
+    if (buf_size  < size) {
+        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
+                "needs %zu bytes, buffer has %zu\n", pdu->id, size,
+                buf_size);
+        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
+        xen_9pfs_disconnect(&xen_9pfs->xendev);
+    }
+
     *piov = ring->sg;
     *pniov = num;
 }
@@ -218,7 +249,7 @@ static int xen_9pfs_init(struct XenDevice *xendev)
 static int xen_9pfs_receive(Xen9pfsRing *ring)
 {
     P9MsgHeader h;
-    RING_IDX cons, prod, masked_prod, masked_cons;
+    RING_IDX cons, prod, masked_prod, masked_cons, queued;
     V9fsPDU *pdu;
 
     if (ring->inprogress) {
@@ -229,8 +260,8 @@ static int xen_9pfs_receive(Xen9pfsRing *ring)
     prod = ring->intf->out_prod;
     xen_rmb();
 
-    if (xen_9pfs_queued(prod, cons, XEN_FLEX_RING_SIZE(ring->ring_order)) <
-        sizeof(h)) {
+    queued = xen_9pfs_queued(prod, cons, XEN_FLEX_RING_SIZE(ring->ring_order));
+    if (queued < sizeof(h)) {
         return 0;
     }
     ring->inprogress = true;
@@ -247,6 +278,15 @@ static int xen_9pfs_receive(Xen9pfsRing *ring)
     ring->out_size = le32_to_cpu(h.size_le);
     ring->out_cons = cons + le32_to_cpu(h.size_le);
 
+    if (queued < ring->out_size) {
+        xen_pv_printf(&ring->priv->xendev, 0, "Xen 9pfs request type %d"
+                "needs %u bytes, buffer has %u\n", pdu->id, ring->out_size,
+                queued);
+        xen_be_set_state(&ring->priv->xendev, XenbusStateClosing);
+        xen_9pfs_disconnect(&ring->priv->xendev);
+        return -EINVAL;
+    }
+
     pdu_submit(pdu, &h);
 
     return 0;
@@ -269,15 +309,30 @@ static void xen_9pfs_evtchn_event(void *opaque)
     qemu_bh_schedule(ring->bh);
 }
 
-static int xen_9pfs_free(struct XenDevice *xendev)
+static void xen_9pfs_disconnect(struct XenDevice *xendev)
 {
+    Xen9pfsDev *xen_9pdev = container_of(xendev, Xen9pfsDev, xendev);
     int i;
+
+    for (i = 0; i < xen_9pdev->num_rings; i++) {
+        if (xen_9pdev->rings[i].evtchndev != NULL) {
+            qemu_set_fd_handler(xenevtchn_fd(xen_9pdev->rings[i].evtchndev),
+                    NULL, NULL, NULL);
+            xenevtchn_unbind(xen_9pdev->rings[i].evtchndev,
+                             xen_9pdev->rings[i].local_port);
+            xen_9pdev->rings[i].evtchndev = NULL;
+        }
+    }
+}
+
+static int xen_9pfs_free(struct XenDevice *xendev)
+{
     Xen9pfsDev *xen_9pdev = container_of(xendev, Xen9pfsDev, xendev);
+    int i;
 
-    g_free(xen_9pdev->id);
-    g_free(xen_9pdev->tag);
-    g_free(xen_9pdev->path);
-    g_free(xen_9pdev->security_model);
+    if (xen_9pdev->rings[0].evtchndev != NULL) {
+        xen_9pfs_disconnect(xendev);
+    }
 
     for (i = 0; i < xen_9pdev->num_rings; i++) {
         if (xen_9pdev->rings[i].data != NULL) {
@@ -290,16 +345,15 @@ static int xen_9pfs_free(struct XenDevice *xendev)
                     xen_9pdev->rings[i].intf,
                     1);
         }
-        if (xen_9pdev->rings[i].evtchndev > 0) {
-            qemu_set_fd_handler(xenevtchn_fd(xen_9pdev->rings[i].evtchndev),
-                    NULL, NULL, NULL);
-            xenevtchn_unbind(xen_9pdev->rings[i].evtchndev,
-                             xen_9pdev->rings[i].local_port);
-        }
         if (xen_9pdev->rings[i].bh != NULL) {
             qemu_bh_delete(xen_9pdev->rings[i].bh);
         }
     }
+
+    g_free(xen_9pdev->id);
+    g_free(xen_9pdev->tag);
+    g_free(xen_9pdev->path);
+    g_free(xen_9pdev->security_model);
     g_free(xen_9pdev->rings);
     return 0;
 }
@@ -423,11 +477,6 @@ static void xen_9pfs_alloc(struct XenDevice *xendev)
     xenstore_write_be_int(xendev, "max-ring-page-order", MAX_RING_ORDER);
 }
 
-static void xen_9pfs_disconnect(struct XenDevice *xendev)
-{
-    /* Dynamic hotplug of PV filesystems at runtime is not supported. */
-}
-
 struct XenDevOps xen_9pfs_ops = {
     .size       = sizeof(Xen9pfsDev),
     .flags      = DEVOPS_FLAG_NEED_GNTDEV,
