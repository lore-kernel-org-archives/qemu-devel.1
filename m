Received: from eggs.gnu.org ([2001:4830:134:3::10]:39606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gBy7r-0006wQ-1G
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gBy7k-00085t-F0
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:21:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gBy7k-00085X-6f
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:21:12 -0400
Date: Mon, 15 Oct 2018 16:20:50 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20181015082050.GG27871@wei-ubt>
References: <1539266915-15216-1-git-send-email-wexu@redhat.com>
	<1539266915-15216-9-git-send-email-wexu@redhat.com>
	<f9b19079-65fa-4d21-63ba-00f79095bc4f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9b19079-65fa-4d21-63ba-00f79095bc4f@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [[RFC v3 08/12] virtio: event suppression support
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

On Mon, Oct 15, 2018 at 02:59:48PM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B410=E6=9C=8811=E6=97=A5 22:08, wexu@redhat.com wrote:
> >From: Wei Xu <wexu@redhat.com>
> >
> >Signed-off-by: Wei Xu <wexu@redhat.com>
> >---
> >  hw/virtio/virtio.c | 126 +++++++++++++++++++++++++++++++++++++++++++=
++++++++--
> >  1 file changed, 123 insertions(+), 3 deletions(-)
> >
> >diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >index d12a7e3..1d25776 100644
> >--- a/hw/virtio/virtio.c
> >+++ b/hw/virtio/virtio.c
> >@@ -241,6 +241,30 @@ static void vring_desc_read(VirtIODevice *vdev, V=
RingDesc *desc,
> >      virtio_tswap16s(vdev, &desc->next);
> >  }
> >+static void vring_packed_event_read(VirtIODevice *vdev,
> >+                            MemoryRegionCache *cache, VRingPackedDesc=
Event *e)
> >+{
> >+    address_space_read_cached(cache, 0, e, sizeof(*e));
> >+    virtio_tswap16s(vdev, &e->off_wrap);
> >+    virtio_tswap16s(vdev, &e->flags);
> >+}
> >+
> >+static void vring_packed_off_wrap_write(VirtIODevice *vdev,
> >+                            MemoryRegionCache *cache, uint16_t off_wr=
ap)
> >+{
> >+    virtio_tswap16s(vdev, &off_wrap);
> >+    address_space_write_cached(cache, 0, &off_wrap, sizeof(off_wrap))=
;
> >+    address_space_cache_invalidate(cache, 0, sizeof(off_wrap));
> >+}
> >+
> >+static void vring_packed_flags_write(VirtIODevice *vdev,
> >+                            MemoryRegionCache *cache, uint16_t flags)
> >+{
> >+    virtio_tswap16s(vdev, &flags);
> >+    address_space_write_cached(cache, sizeof(uint16_t), &flags, sizeo=
f(flags));
> >+    address_space_cache_invalidate(cache, sizeof(uint16_t), sizeof(fl=
ags));
> >+}
> >+
> >  static VRingMemoryRegionCaches *vring_get_region_caches(struct VirtQ=
ueue *vq)
> >  {
> >      VRingMemoryRegionCaches *caches =3D atomic_rcu_read(&vq->vring.c=
aches);
> >@@ -347,7 +371,7 @@ static inline void vring_set_avail_event(VirtQueue=
 *vq, uint16_t val)
> >      address_space_cache_invalidate(&caches->used, pa, sizeof(val));
> >  }
> >-void virtio_queue_set_notification(VirtQueue *vq, int enable)
> >+static void virtio_queue_set_notification_split(VirtQueue *vq, int en=
able)
> >  {
> >      vq->notification =3D enable;
> >@@ -370,6 +394,51 @@ void virtio_queue_set_notification(VirtQueue *vq,=
 int enable)
> >      rcu_read_unlock();
> >  }
> >+static void virtio_queue_set_notification_packed(VirtQueue *vq, int e=
nable)
> >+{
> >+    VRingPackedDescEvent e;
> >+    VRingMemoryRegionCaches *caches;
> >+
> >+    rcu_read_lock();
> >+    caches  =3D vring_get_region_caches(vq);
> >+    vring_packed_event_read(vq->vdev, &caches->device, &e);
> >+
> >+    if (!enable) {
> >+        e.flags =3D RING_EVENT_FLAGS_DISABLE;
> >+        goto out;
> >+    }
> >+
> >+    e.flags =3D RING_EVENT_FLAGS_ENABLE;
> >+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
> >+        uint16_t off_wrap =3D vq->event_idx | vq->event_wrap_counter =
<< 15;
>=20
> Btw, why not just use shadow_avail_idx here?

It is nice to do that but an issue here is that it is 'shadow_avail_idx' =
for
Rx but 'used_idx' for Tx when setting up for a kick, haven't figured out =
a
clear fix because it helps easier migration part work, any idea?

Wei

>=20
> Thanks
>=20
> >+
> >+        vring_packed_off_wrap_write(vq->vdev, &caches->device, off_wr=
ap);
> >+        /* Make sure off_wrap is wrote before flags */
> >+        smp_wmb();
> >+
> >+        e.flags =3D RING_EVENT_FLAGS_DESC;
> >+    }
> >+
> >+out:
> >+    vring_packed_flags_write(vq->vdev, &caches->device, e.flags);
> >+    rcu_read_unlock();
> >+}
> >+
> >+void virtio_queue_set_notification(VirtQueue *vq, int enable)
> >+{
> >+    vq->notification =3D enable;
> >+
> >+    if (!vq->vring.desc) {
> >+        return;
> >+    }
> >+
> >+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> >+        virtio_queue_set_notification_packed(vq, enable);
> >+    } else {
> >+        virtio_queue_set_notification_split(vq, enable);
> >+    }
> >+}
> >+
> >  int virtio_queue_ready(VirtQueue *vq)
> >  {
> >      return vq->vring.avail !=3D 0;
> >@@ -2103,8 +2172,7 @@ static void virtio_set_isr(VirtIODevice *vdev, i=
nt value)
> >      }
> >  }
> >-/* Called within rcu_read_lock().  */
> >-static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
> >+static bool virtio_split_should_notify(VirtIODevice *vdev, VirtQueue =
*vq)
> >  {
> >      uint16_t old, new;
> >      bool v;
> >@@ -2127,6 +2195,58 @@ static bool virtio_should_notify(VirtIODevice *=
vdev, VirtQueue *vq)
> >      return !v || vring_need_event(vring_get_used_event(vq), new, old=
);
> >  }
> >+static bool vring_packed_need_event(VirtQueue *vq, uint16_t off_wrap,
> >+                                    uint16_t new, uint16_t old)
> >+{
> >+    bool wrap =3D vq->event_wrap_counter;
> >+    int off =3D off_wrap & ~(1 << 15);
> >+
> >+    if (new < old) {
> >+        new +=3D vq->vring.num;
> >+        wrap ^=3D 1;
> >+    }
> >+
> >+    if (wrap !=3D off_wrap >> 15) {
> >+        off +=3D vq->vring.num;
> >+    }
> >+
> >+    return vring_need_event(off, new, old);
> >+}
> >+
> >+static bool virtio_packed_should_notify(VirtIODevice *vdev, VirtQueue=
 *vq)
> >+{
> >+    VRingPackedDescEvent e;
> >+    uint16_t old, new;
> >+    bool v;
> >+    VRingMemoryRegionCaches *caches;
> >+
> >+    caches  =3D vring_get_region_caches(vq);
> >+    vring_packed_event_read(vdev, &caches->driver, &e);
> >+
> >+    old =3D vq->signalled_used;
> >+    new =3D vq->signalled_used =3D vq->used_idx;
> >+    v =3D vq->signalled_used_valid;
> >+    vq->signalled_used_valid =3D true;
> >+
> >+    if (e.flags =3D=3D RING_EVENT_FLAGS_DISABLE) {
> >+        return false;
> >+    } else if (e.flags =3D=3D RING_EVENT_FLAGS_ENABLE) {
> >+        return true;
> >+    }
> >+
> >+    return !v || vring_packed_need_event(vq, e.off_wrap, new, old);
> >+}
> >+
> >+/* Called within rcu_read_lock().  */
> >+static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
> >+{
> >+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >+        return virtio_packed_should_notify(vdev, vq);
> >+    } else {
> >+        return virtio_split_should_notify(vdev, vq);
> >+    }
> >+}
> >+
> >  void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
> >  {
> >      bool should_notify;
>=20
