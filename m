Received: from eggs.gnu.org ([2001:4830:134:3::10]:51160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gBwwR-0002Io-Qe
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gBwwH-0007pO-AR
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:05:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gBwwG-0007oh-Mg
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:05:17 -0400
Date: Mon, 15 Oct 2018 15:04:47 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20181015070447.GA27871@wei-ubt>
References: <1539266915-15216-1-git-send-email-wexu@redhat.com>
	<1539266915-15216-6-git-send-email-wexu@redhat.com>
	<a9e70b0b-1955-6c8f-4c61-9c6dabef8353@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9e70b0b-1955-6c8f-4c61-9c6dabef8353@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [[RFC v3 05/12] virtio: init and desc empty check
 for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, tiwei.bie@intel.com, jfreimann@redhat.com, maxime.coquelin@redhat.com

On Mon, Oct 15, 2018 at 11:18:05AM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B410=E6=9C=8811=E6=97=A5 22:08, wexu@redhat.com wrote:
> >From: Wei Xu <wexu@redhat.com>
> >
> >Basic initialization and helpers for packed ring.
> >
> >Signed-off-by: Wei Xu <wexu@redhat.com>
> >---
> >  hw/virtio/virtio.c | 57 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++++-
> >  1 file changed, 56 insertions(+), 1 deletion(-)
> >
> >diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >index 9185efb..86f88da 100644
> >--- a/hw/virtio/virtio.c
> >+++ b/hw/virtio/virtio.c
> >@@ -24,6 +24,9 @@
> >  #include "hw/virtio/virtio-access.h"
> >  #include "sysemu/dma.h"
> >+#define AVAIL_DESC_PACKED(b) ((b) << 7)
> >+#define USED_DESC_PACKED(b)  ((b) << 15)
> >+
> >  /*
> >   * The alignment to use between consumer and producer parts of vring=
.
> >   * x86 pagesize again. This is the default, used by transports like =
PCI
> >@@ -372,6 +375,23 @@ int virtio_queue_ready(VirtQueue *vq)
> >      return vq->vring.avail !=3D 0;
> >  }
> >+static void vring_packed_desc_read_flags(VirtIODevice *vdev,
> >+                    VRingPackedDesc *desc, MemoryRegionCache *cache, =
int i)
> >+{
> >+    address_space_read_cached(cache,
> >+              i * sizeof(VRingPackedDesc) + offsetof(VRingPackedDesc,=
 flags),
> >+              &desc->flags, sizeof(desc->flags));
> >+}
> >+
> >+static inline bool is_desc_avail(struct VRingPackedDesc *desc, bool w=
c)
> >+{
>=20
> I think it's better use wrap_counter instead of wc here (unless you wan=
t to
> use wc everywhere which is a even worse idea).

It was to avoid a new line for a parameter since this is a mini function,
I will take it back.

Wei

>=20
> Thanks
>=20
> >+    bool avail, used;
> >+
> >+    avail =3D !!(desc->flags & AVAIL_DESC_PACKED(1));
> >+    used =3D !!(desc->flags & USED_DESC_PACKED(1));
> >+    return (avail !=3D used) && (avail =3D=3D wc);
> >+}
> >+
> >  /* Fetch avail_idx from VQ memory only when we really need to know i=
f
> >   * guest has added some buffers.
> >   * Called within rcu_read_lock().  */
> >@@ -392,7 +412,7 @@ static int virtio_queue_empty_rcu(VirtQueue *vq)
> >      return vring_avail_idx(vq) =3D=3D vq->last_avail_idx;
> >  }
> >-int virtio_queue_empty(VirtQueue *vq)
> >+static int virtio_queue_split_empty(VirtQueue *vq)
> >  {
> >      bool empty;
> >@@ -414,6 +434,41 @@ int virtio_queue_empty(VirtQueue *vq)
> >      return empty;
> >  }
> >+static int virtio_queue_packed_empty_rcu(VirtQueue *vq)
> >+{
> >+    struct VRingPackedDesc desc;
> >+    VRingMemoryRegionCaches *cache;
> >+
> >+    if (unlikely(!vq->vring.desc)) {
> >+        return 1;
> >+    }
> >+
> >+    cache =3D vring_get_region_caches(vq);
> >+    vring_packed_desc_read_flags(vq->vdev, &desc, &cache->desc,
> >+                                vq->last_avail_idx);
> >+
> >+    return !is_desc_avail(&desc, vq->avail_wrap_counter);
> >+}
> >+
> >+static int virtio_queue_packed_empty(VirtQueue *vq)
> >+{
> >+    bool empty;
> >+
> >+    rcu_read_lock();
> >+    empty =3D virtio_queue_packed_empty_rcu(vq);
> >+    rcu_read_unlock();
> >+    return empty;
> >+}
> >+
> >+int virtio_queue_empty(VirtQueue *vq)
> >+{
> >+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> >+        return virtio_queue_packed_empty(vq);
> >+    } else {
> >+        return virtio_queue_split_empty(vq);
> >+    }
> >+}
> >+
> >  static void virtqueue_unmap_sg(VirtQueue *vq, const VirtQueueElement=
 *elem,
> >                                 unsigned int len)
> >  {
>=20
