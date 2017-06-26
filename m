Received: from eggs.gnu.org ([2001:4830:134:3::10]:43495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dPdKu-000686-OQ
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 19:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dPdKr-00087V-HU
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 19:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dPdKr-000871-6Y
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 19:22:25 -0400
Date: Mon, 26 Jun 2017 16:22:23 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <149820032558.7187.9574922678907797880.stgit@bahia.lan>
Message-ID: <alpine.DEB.2.10.1706261553370.12819@sstabellini-ThinkPad-X260>
References: <149820029273.7187.14110849422638329192.stgit@bahia.lan>
	<149820032558.7187.9574922678907797880.stgit@bahia.lan>
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
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, 23 Jun 2017, Greg Kurz wrote:
> The 9P protocol is transport agnostic: if the guest misconfigured the
> buffers, the best we can do is to set the broken flag on the device.
> 
> Since virtio_pdu_vmarshal() may be called by several active PDUs, we
> check if the transport isn't broken already to avoid printing extra
> error messages.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v4: - update changelog and add comment to explain why we check vdev->broken
>       in virtio_pdu_vmarshal()
>     - dropped uneeded vdev->broken check in virtio_pdu_vunmarshal()
> ---
>  hw/9pfs/9p.c               |    2 +-
>  hw/9pfs/9p.h               |    2 +-
>  hw/9pfs/virtio-9p-device.c |   48 +++++++++++++++++++++++++++++++++++++++-----
>  hw/9pfs/xen-9p-backend.c   |    3 ++-
>  4 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index a0ae98f7ca6f..8e5cac71eb60 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1664,7 +1664,7 @@ static void v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
>      unsigned int niov;
>  
>      if (is_write) {
> -        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov);
> +        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov, size + skip);
>      } else {
>          pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, size + skip);
>      }
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index aac1b0b2ce3d..d1cfeaf10e4f 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -363,7 +363,7 @@ struct V9fsTransport {
>      void        (*init_in_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
>                                          unsigned int *pniov, size_t size);
>      void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
> -                                         unsigned int *pniov);
> +                                         unsigned int *pniov, size_t size);
>      void        (*push_and_notify)(V9fsPDU *pdu);
>  };
>  
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 1a68c1622d3a..ed9e4817a26c 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -146,8 +146,22 @@ static ssize_t virtio_pdu_vmarshal(V9fsPDU *pdu, size_t offset,
>      V9fsState *s = pdu->s;
>      V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
>      VirtQueueElement *elem = v->elems[pdu->idx];
> -
> -    return v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt, ap);
> +    int ret;

I think ret should be ssize_t


> +    ret = v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt, ap);
> +    if (ret < 0) {
> +        VirtIODevice *vdev = VIRTIO_DEVICE(v);
> +
> +        /* Any active PDU may try to send something back to the client without
> +         * knowing if the transport is broken or not. This could result in
> +         * MAX_REQ - 1 (ie, 127) extra error messages being printed.
> +         */
> +        if (!vdev->broken) {
> +            virtio_error(vdev, "Failed to encode VirtFS reply type %d",
> +                         pdu->id + 1);
> +        }
> +    }
> +    return ret;
>  }
>  
>  static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
> @@ -156,28 +170,52 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
>      V9fsState *s = pdu->s;
>      V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
>      VirtQueueElement *elem = v->elems[pdu->idx];
> +    int ret;

same here


> -    return v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1, fmt, ap);
> +    ret = v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1, fmt, ap);
> +    if (ret < 0) {
> +        VirtIODevice *vdev = VIRTIO_DEVICE(v);
> +
> +        virtio_error(vdev, "Failed to decode VirtFS request type %d", pdu->id);
> +    }
> +    return ret;
>  }
>  
> -/* The size parameter is used by other transports. Do not drop it. */
>  static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
>                                          unsigned int *pniov, size_t size)
>  {
>      V9fsState *s = pdu->s;
>      V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
>      VirtQueueElement *elem = v->elems[pdu->idx];
> +    size_t buf_size = iov_size(elem->in_sg, elem->in_num);
> +
> +    if (buf_size < size) {
> +        VirtIODevice *vdev = VIRTIO_DEVICE(v);
> +
> +        virtio_error(vdev,
> +                     "VirtFS reply type %d needs %zu bytes, buffer has %zu",
> +                     pdu->id + 1, size, buf_size);
> +    }
>  
>      *piov = elem->in_sg;
>      *pniov = elem->in_num;
>  }
>  
>  static void virtio_init_out_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
> -                                         unsigned int *pniov)
> +                                         unsigned int *pniov, size_t size)
>  {
>      V9fsState *s = pdu->s;
>      V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
>      VirtQueueElement *elem = v->elems[pdu->idx];
> +    size_t buf_size = iov_size(elem->out_sg, elem->out_num);
> +
> +    if (buf_size < size) {
> +        VirtIODevice *vdev = VIRTIO_DEVICE(v);
> +
> +        virtio_error(vdev,
> +                     "VirtFS request type %d needs %zu bytes, buffer has %zu",
> +                     pdu->id, size, buf_size);
> +    }
>  
>      *piov = elem->out_sg;
>      *pniov = elem->out_num;
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index 922cc967be63..a82cf817fe45 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -147,7 +147,8 @@ static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
>  
>  static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
>                                             struct iovec **piov,
> -                                           unsigned int *pniov)
> +                                           unsigned int *pniov,
> +                                           size_t size)
>  {
>      Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
>      Xen9pfsRing *ring = &xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings];

Maybe you could include the same changes you made for xen, see below


diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index a82cf81..83a2bfe 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -125,10 +125,17 @@ static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
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
+                      "Failed to encode VirtFS request type %d", pdu->id + 1);
+    }
+    return ret;
 }
 
 static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
@@ -139,10 +146,17 @@ static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
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
+                      "Failed to decode VirtFS request type %d", pdu->id);
+    }
+    return ret;
 }
 
 static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
@@ -153,11 +167,20 @@ static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
     Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
     Xen9pfsRing *ring = &xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings];
     int num;
+    size_t buf_size;
 
     g_free(ring->sg);
 
     ring->sg = g_malloc0(sizeof(*ring->sg) * 2);
     xen_9pfs_out_sg(ring, ring->sg, &num, pdu->idx);
+
+    buf_size = iov_size(ring->sg, num);
+    if (buf_size  < size) {
+        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
+                "needs %zu bytes, buffer has %zu", pdu->id, size,
+                buf_size);
+    }
+
     *piov = ring->sg;
     *pniov = num;
 }
@@ -170,11 +193,20 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
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
+                "needs %zu bytes, buffer has %zu", pdu->id, size,
+                buf_size);
+    }
+
     *piov = ring->sg;
     *pniov = num;
 }
