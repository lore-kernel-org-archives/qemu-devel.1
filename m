Received: from eggs.gnu.org ([209.51.188.92]:33746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gvzhT-0004L8-DJ
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:20:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gvzhO-0001vL-OA
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:20:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gvzhL-0001qg-Uh
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:20:12 -0500
References: <1550118402-4057-1-git-send-email-wexu@redhat.com>
	<1550118402-4057-9-git-send-email-wexu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <91bf74af-5e22-c6fc-eae5-16b03b1493a1@redhat.com>
Date: Tue, 19 Feb 2019 15:19:58 +0800
MIME-Version: 1.0
In-Reply-To: <1550118402-4057-9-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 08/11] virtio: event suppression support
 for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, qemu-devel@nongnu.org
Cc: mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com


On 2019/2/14 =E4=B8=8B=E5=8D=8812:26, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
>
> Difference between 'avail_wrap_counter' and 'last_avail_wrap_counter':
> For Tx(guest transmitting), they are the same after each pop of a desc.
>
> For Rx(guest receiving), they are also the same when there are enough
> descriptors to carry the payload for a packet(e.g. usually 16 descs are
> needed for a 64k packet in typical iperf tcp connection with tso enable=
d),
> however, when the ring is running out of descriptors while there are
> still a few free ones, e.g. 6 descriptors are available which is not
> enough to carry an entire packet which needs 16 descriptors, in this
> case the 'avail_wrap_counter' should be set as the first one pending
> being handled by guest driver in order to get a notification, and the
> 'last_avail_wrap_counter' should stay unchanged to the head of availabl=
e
> descriptors, like below:
>
> Mark meaning:
>      | | -- available
>      |*| -- used
>
> A Snapshot of the queue:
>                                        last_avail_idx =3D 253
>                                        last_avail_wrap_counter =3D 1
>                                               |
>      +---------------------------------------------+
>   0  | | | |*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*| | | | 255
>      +---------------------------------------------+
>             |
>    shadow_avail_idx =3D 3
>    avail_wrap_counter =3D 0


Well this might not be the good place to describe the difference between=20
shadow_avail_idx and last_avail_idx. And the comments above their=20
definition looks good enough?

 =C2=A0=C2=A0=C2=A0 /* Next head to pop */
 =C2=A0=C2=A0=C2=A0 uint16_t last_avail_idx;

 =C2=A0=C2=A0=C2=A0 /* Last avail_idx read from VQ. */
 =C2=A0=C2=A0=C2=A0 uint16_t shadow_avail_idx;

Instead, how or why need event suppress is not mentioned ...



>
> Signed-off-by: Wei Xu <wexu@redhat.com>
> ---
>   hw/virtio/virtio.c | 137 ++++++++++++++++++++++++++++++++++++++++++++=
+++++----
>   1 file changed, 128 insertions(+), 9 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 7e276b4..8cfc7b6 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -234,6 +234,34 @@ static void vring_desc_read(VirtIODevice *vdev, VR=
ingDesc *desc,
>       virtio_tswap16s(vdev, &desc->next);
>   }
>  =20
> +static void vring_packed_event_read(VirtIODevice *vdev,
> +                            MemoryRegionCache *cache, VRingPackedDescE=
vent *e)
> +{
> +    address_space_read_cached(cache, 0, e, sizeof(*e));
> +    virtio_tswap16s(vdev, &e->off_wrap);
> +    virtio_tswap16s(vdev, &e->flags);
> +}
> +
> +static void vring_packed_off_wrap_write(VirtIODevice *vdev,
> +                            MemoryRegionCache *cache, uint16_t off_wra=
p)
> +{
> +    virtio_tswap16s(vdev, &off_wrap);
> +    address_space_write_cached(cache, offsetof(VRingPackedDescEvent, o=
ff_wrap),
> +                            &off_wrap, sizeof(off_wrap));
> +    address_space_cache_invalidate(cache,
> +                offsetof(VRingPackedDescEvent, off_wrap), sizeof(off_w=
rap));
> +}
> +
> +static void vring_packed_flags_write(VirtIODevice *vdev,
> +                            MemoryRegionCache *cache, uint16_t flags)
> +{
> +    virtio_tswap16s(vdev, &flags);
> +    address_space_write_cached(cache, offsetof(VRingPackedDescEvent, f=
lags),
> +                            &flags, sizeof(flags));
> +    address_space_cache_invalidate(cache,
> +                        offsetof(VRingPackedDescEvent, flags), sizeof(=
flags));
> +}
> +
>   static VRingMemoryRegionCaches *vring_get_region_caches(struct VirtQu=
eue *vq)
>   {
>       VRingMemoryRegionCaches *caches =3D atomic_rcu_read(&vq->vring.ca=
ches);
> @@ -340,14 +368,8 @@ static inline void vring_set_avail_event(VirtQueue=
 *vq, uint16_t val)
>       address_space_cache_invalidate(&caches->used, pa, sizeof(val));
>   }
>  =20
> -void virtio_queue_set_notification(VirtQueue *vq, int enable)
> +static void virtio_queue_set_notification_split(VirtQueue *vq, int ena=
ble)
>   {
> -    vq->notification =3D enable;
> -
> -    if (!vq->vring.desc) {
> -        return;
> -    }
> -
>       rcu_read_lock();
>       if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
>           vring_set_avail_event(vq, vring_avail_idx(vq));
> @@ -363,6 +385,57 @@ void virtio_queue_set_notification(VirtQueue *vq, =
int enable)
>       rcu_read_unlock();
>   }
>  =20
> +static void virtio_queue_set_notification_packed(VirtQueue *vq, int en=
able)
> +{
> +    VRingPackedDescEvent e;
> +    VRingMemoryRegionCaches *caches;
> +
> +    rcu_read_lock();
> +    caches  =3D vring_get_region_caches(vq);
> +    vring_packed_event_read(vq->vdev, &caches->used, &e);
> +
> +    if (!enable) {
> +        if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)=
) {
> +            /* no need to write device area since this is outdated. */


We should advertise off and wrap in this case as well, otherwise we may=20
get notifications earlier than expected.


> +            goto out;
> +        }
> +
> +        e.flags =3D VRING_PACKED_EVENT_FLAG_DISABLE;
> +        goto update;
> +    }
> +
> +    e.flags =3D VRING_PACKED_EVENT_FLAG_ENABLE;


Here and the above goto could be eliminated by:

if (even idx) {

...

} else if (enable) {

...

} else {

...

}


Thanks


> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
> +        uint16_t off_wrap =3D vq->shadow_avail_idx | vq->avail_wrap_co=
unter << 15;
> +
> +        vring_packed_off_wrap_write(vq->vdev, &caches->used, off_wrap)=
;
> +        /* Make sure off_wrap is wrote before flags */
> +        smp_wmb();
> +
> +        e.flags =3D VRING_PACKED_EVENT_FLAG_DESC;
> +    }
> +
> +update:
> +    vring_packed_flags_write(vq->vdev, &caches->used, e.flags);
> +out:
> +    rcu_read_unlock();
> +}
> +
> +void virtio_queue_set_notification(VirtQueue *vq, int enable)
> +{
> +    vq->notification =3D enable;
> +
> +    if (!vq->vring.desc) {
> +        return;
> +    }
> +
> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> +        virtio_queue_set_notification_packed(vq, enable);
> +    } else {
> +        virtio_queue_set_notification_split(vq, enable);
> +    }
> +}
> +
>   int virtio_queue_ready(VirtQueue *vq)
>   {
>       return vq->vring.avail !=3D 0;
> @@ -2117,8 +2190,7 @@ static void virtio_set_isr(VirtIODevice *vdev, in=
t value)
>       }
>   }
>  =20
> -/* Called within rcu_read_lock().  */
> -static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
> +static bool virtio_split_should_notify(VirtIODevice *vdev, VirtQueue *=
vq)
>   {
>       uint16_t old, new;
>       bool v;
> @@ -2141,6 +2213,53 @@ static bool virtio_should_notify(VirtIODevice *v=
dev, VirtQueue *vq)
>       return !v || vring_need_event(vring_get_used_event(vq), new, old)=
;
>   }
>  =20
> +static bool vring_packed_need_event(VirtQueue *vq, bool wrap,
> +                            uint16_t off_wrap, uint16_t new, uint16_t =
old)
> +{
> +    int off =3D off_wrap & ~(1 << 15);
> +
> +    if (wrap !=3D off_wrap >> 15) {
> +        off -=3D vq->vring.num;
> +    }
> +
> +    return vring_need_event(off, new, old);
> +}
> +
> +static bool virtio_packed_should_notify(VirtIODevice *vdev, VirtQueue =
*vq)
> +{
> +    VRingPackedDescEvent e;
> +    uint16_t old, new;
> +    bool v;
> +    VRingMemoryRegionCaches *caches;
> +
> +    caches  =3D vring_get_region_caches(vq);
> +    vring_packed_event_read(vdev, &caches->avail, &e);
> +
> +    old =3D vq->signalled_used;
> +    new =3D vq->signalled_used =3D vq->used_idx;
> +    v =3D vq->signalled_used_valid;
> +    vq->signalled_used_valid =3D true;
> +
> +    if (e.flags =3D=3D VRING_PACKED_EVENT_FLAG_DISABLE) {
> +        return false;
> +    } else if (e.flags =3D=3D VRING_PACKED_EVENT_FLAG_ENABLE) {
> +        return true;
> +    }
> +
> +    return !v || vring_packed_need_event(vq,
> +        vq->used_wrap_counter, e.off_wrap, new, old);
> +}
> +
> +/* Called within rcu_read_lock().  */
> +static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> +        return virtio_packed_should_notify(vdev, vq);
> +    } else {
> +        return virtio_split_should_notify(vdev, vq);
> +    }
> +}
> +
>   void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
>   {
>       bool should_notify;
