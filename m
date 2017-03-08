Received: from eggs.gnu.org ([2001:4830:134:3::10]:54837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clS7c-0006Q5-IG
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 22:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clS7Z-00061Y-De
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 22:18:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1clS7Z-00061C-3i
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 22:18:37 -0500
References: <1488876478-6889-1-git-send-email-jasowang@redhat.com>
	<20170307111618.43ffbd13.cornelia.huck@de.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cb84b888-4917-162d-31a5-f708f4783444@redhat.com>
Date: Wed, 8 Mar 2017 11:18:27 +0800
MIME-Version: 1.0
In-Reply-To: <20170307111618.43ffbd13.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio: destroy region cache during reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, peterx@redhat.com



On 2017=E5=B9=B403=E6=9C=8807=E6=97=A5 18:16, Cornelia Huck wrote:
> On Tue,  7 Mar 2017 16:47:58 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> We don't destroy region cache during reset which can make the maps
>> of previous driver leaked to a buggy or malicious driver that don't
>> set vring address before starting to use the device. Fix this by
>> destroy the region cache during reset and validate it before trying to
>> use them. While at it, also validate address_space_cache_init() during
>> virtio_init_region_cache() to make sure we have a correct region
>> cache.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   hw/virtio/virtio.c | 88 ++++++++++++++++++++++++++++++++++++++++++++=
++--------
>>   1 file changed, 76 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 09f4cf4..90324f6 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -131,6 +131,7 @@ static void virtio_init_region_cache(VirtIODevice =
*vdev, int n)
>>       VRingMemoryRegionCaches *new;
>>       hwaddr addr, size;
>>       int event_size;
>> +    int64_t len;
>>
>>       event_size =3D virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_E=
VENT_IDX) ? 2 : 0;
>>
>> @@ -140,21 +141,41 @@ static void virtio_init_region_cache(VirtIODevic=
e *vdev, int n)
>>       }
>>       new =3D g_new0(VRingMemoryRegionCaches, 1);
>>       size =3D virtio_queue_get_desc_size(vdev, n);
>> -    address_space_cache_init(&new->desc, vdev->dma_as,
>> -                             addr, size, false);
>> +    len =3D address_space_cache_init(&new->desc, vdev->dma_as,
>> +                                   addr, size, false);
>> +    if (len < size) {
>> +        virtio_error(vdev, "Cannot map desc");
>> +        goto err_desc;
>> +    }
>>
>>       size =3D virtio_queue_get_used_size(vdev, n) + event_size;
>> -    address_space_cache_init(&new->used, vdev->dma_as,
>> -                             vq->vring.used, size, true);
>> +    len =3D address_space_cache_init(&new->used, vdev->dma_as,
>> +                                   vq->vring.used, size, true);
>> +    if (len < size) {
>> +        virtio_error(vdev, "Cannot map used");
>> +        goto err_used;
>> +    }
>>
>>       size =3D virtio_queue_get_avail_size(vdev, n) + event_size;
>> -    address_space_cache_init(&new->avail, vdev->dma_as,
>> -                             vq->vring.avail, size, false);
>> +    len =3D address_space_cache_init(&new->avail, vdev->dma_as,
>> +                                   vq->vring.avail, size, false);
>> +    if (len < size) {
>> +        virtio_error(vdev, "Cannot map avail");
>> +        goto err_avail;
>> +    }
>>
>>       atomic_rcu_set(&vq->vring.caches, new);
>>       if (old) {
>>           call_rcu(old, virtio_free_region_cache, rcu);
>>       }
>> +    return;
>> +
>> +err_avail:
>> +    address_space_cache_destroy(&new->used);
>> +err_used:
>> +    address_space_cache_destroy(&new->desc);
>> +err_desc:
>> +    g_free(new);
>>   }
> I think it would be more readable if you moved adding this check (which
> is a good idea) into a separate patch.

Ok.

>>   /* virt queue functions */
>> @@ -190,6 +211,10 @@ static inline uint16_t vring_avail_flags(VirtQueu=
e *vq)
>>   {
>>       VRingMemoryRegionCaches *caches =3D atomic_rcu_read(&vq->vring.c=
aches);
>>       hwaddr pa =3D offsetof(VRingAvail, flags);
>> +    if (!caches) {
>> +        virtio_error(vq->vdev, "Cannot map avail flags");
> I'm not sure that virtio_error is the right thing here; ending up in
> this function with !caches indicates an error in our logic.

Probably not, this can be triggered by buggy guest.

> An assert
> might be better (and I hope we can sort out all of those errors exposed
> by the introduction of region caches for 2.9...)

I thought we should avoid assert as much as possible in this case. But=20
if you and maintainer want an assert, it's also fine.

>
>> +        return 0;
>> +    }
>>       return virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
>>   }
>>
>> @@ -198,6 +223,10 @@ static inline uint16_t vring_avail_idx(VirtQueue =
*vq)
>>   {
>>       VRingMemoryRegionCaches *caches =3D atomic_rcu_read(&vq->vring.c=
aches);
>>       hwaddr pa =3D offsetof(VRingAvail, idx);
>> +    if (!caches) {
>> +        virtio_error(vq->vdev, "Cannot map avail idx");
>> +        return vq->shadow_avail_idx;
>> +    }
>>       vq->shadow_avail_idx =3D virtio_lduw_phys_cached(vq->vdev, &cach=
es->avail, pa);
>>       return vq->shadow_avail_idx;
>>   }
>> @@ -207,6 +236,10 @@ static inline uint16_t vring_avail_ring(VirtQueue=
 *vq, int i)
>>   {
>>       VRingMemoryRegionCaches *caches =3D atomic_rcu_read(&vq->vring.c=
aches);
>>       hwaddr pa =3D offsetof(VRingAvail, ring[i]);
>> +    if (!caches) {
>> +        virtio_error(vq->vdev, "Cannot map avail ring");
>> +        return 0;
>> +    }
>>       return virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
>>   }
>>
>> @@ -222,6 +255,10 @@ static inline void vring_used_write(VirtQueue *vq=
, VRingUsedElem *uelem,
>>   {
>>       VRingMemoryRegionCaches *caches =3D atomic_rcu_read(&vq->vring.c=
aches);
>>       hwaddr pa =3D offsetof(VRingUsed, ring[i]);
>> +    if (!caches) {
>> +        virtio_error(vq->vdev, "Cannot map used ring");
>> +        return;
>> +    }
>>       virtio_tswap32s(vq->vdev, &uelem->id);
>>       virtio_tswap32s(vq->vdev, &uelem->len);
>>       address_space_write_cached(&caches->used, pa, uelem, sizeof(VRin=
gUsedElem));
>> @@ -233,6 +270,10 @@ static uint16_t vring_used_idx(VirtQueue *vq)
>>   {
>>       VRingMemoryRegionCaches *caches =3D atomic_rcu_read(&vq->vring.c=
aches);
>>       hwaddr pa =3D offsetof(VRingUsed, idx);
>> +    if (!caches) {
>> +        virtio_error(vq->vdev, "Cannot map used ring");
>> +        return 0;
>> +    }
>>       return virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
>>   }
>>
>> @@ -241,6 +282,10 @@ static inline void vring_used_idx_set(VirtQueue *=
vq, uint16_t val)
>>   {
>>       VRingMemoryRegionCaches *caches =3D atomic_rcu_read(&vq->vring.c=
aches);
>>       hwaddr pa =3D offsetof(VRingUsed, idx);
>> +    if (!caches) {
>> +        virtio_error(vq->vdev, "Cannot map used idx");
>> +        return;
>> +    }
>>       virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
>>       address_space_cache_invalidate(&caches->used, pa, sizeof(val));
>>       vq->used_idx =3D val;
>> @@ -254,6 +299,10 @@ static inline void vring_used_flags_set_bit(VirtQ=
ueue *vq, int mask)
>>       hwaddr pa =3D offsetof(VRingUsed, flags);
>>       uint16_t flags =3D virtio_lduw_phys_cached(vq->vdev, &caches->us=
ed, pa);
>>
>> +    if (!caches) {
>> +        virtio_error(vq->vdev, "Cannot map used flags");
> Regardless of whether using virtio_error here is fine: caches was
> already dereferenced above...
>
>> +        return;
>> +    }
>>       virtio_stw_phys_cached(vdev, &caches->used, pa, flags | mask);
>>       address_space_cache_invalidate(&caches->used, pa, sizeof(flags))=
;
>>   }
>> @@ -266,6 +315,10 @@ static inline void vring_used_flags_unset_bit(Vir=
tQueue *vq, int mask)
>>       hwaddr pa =3D offsetof(VRingUsed, flags);
>>       uint16_t flags =3D virtio_lduw_phys_cached(vq->vdev, &caches->us=
ed, pa);
>>
>> +    if (!caches) {
>> +        virtio_error(vq->vdev, "Cannot map used flags");
> dito
>
>> +        return;
>> +    }
>>       virtio_stw_phys_cached(vdev, &caches->used, pa, flags & ~mask);
>>       address_space_cache_invalidate(&caches->used, pa, sizeof(flags))=
;
>>   }
>> @@ -280,6 +333,10 @@ static inline void vring_set_avail_event(VirtQueu=
e *vq, uint16_t val)
>>       }
>>
>>       caches =3D atomic_rcu_read(&vq->vring.caches);
>> +    if (!caches) {
>> +        virtio_error(vq->vdev, "Cannot map avail event");
>> +        return;
>> +    }
>>       pa =3D offsetof(VRingUsed, ring[vq->vring.num]);
>>       virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
>>       address_space_cache_invalidate(&caches->used, pa, sizeof(val));
>> @@ -552,7 +609,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsi=
gned int *in_bytes,
>>
>>       max =3D vq->vring.num;
>>       caches =3D atomic_rcu_read(&vq->vring.caches);
>> -    if (caches->desc.len < max * sizeof(VRingDesc)) {
>> +    if (!caches || caches->desc.len < max * sizeof(VRingDesc)) {
>>           virtio_error(vdev, "Cannot map descriptor ring");
>>           goto err;
>>       }
>> @@ -819,7 +876,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
>>       i =3D head;
>>
>>       caches =3D atomic_rcu_read(&vq->vring.caches);
>> -    if (caches->desc.len < max * sizeof(VRingDesc)) {
>> +    if (!caches || caches->desc.len < max * sizeof(VRingDesc)) {
>>           virtio_error(vdev, "Cannot map descriptor ring");
>>           goto done;
>>       }
>> @@ -1117,6 +1174,15 @@ static enum virtio_device_endian virtio_current=
_cpu_endian(void)
>>       }
>>   }
>>
>> +static void virtio_virtqueue_reset_region_cache(struct VirtQueue *vq)
>> +{
>> +    VRingMemoryRegionCaches *caches;
>> +
>> +    caches =3D atomic_read(&vq->vring.caches);
>> +    atomic_set(&vq->vring.caches, NULL);
>> +    virtio_free_region_cache(caches);
> Shouldn't this use rcu to free it? Unconditionally setting caches to
> NULL feels wrong...

Right, will switch to use rcu.

>> +}
>> +
>>   void virtio_reset(void *opaque)
>>   {
>>       VirtIODevice *vdev =3D opaque;
>> @@ -1157,6 +1223,7 @@ void virtio_reset(void *opaque)
>>           vdev->vq[i].notification =3D true;
>>           vdev->vq[i].vring.num =3D vdev->vq[i].vring.num_default;
>>           vdev->vq[i].inuse =3D 0;
>> +        virtio_virtqueue_reset_region_cache(&vdev->vq[i]);
> ...especially as you call it in a reset context here.
>
>>       }
>>   }
>>
>> @@ -2451,13 +2518,10 @@ static void virtio_device_free_virtqueues(Virt=
IODevice *vdev)
>>       }
>>
>>       for (i =3D 0; i < VIRTIO_QUEUE_MAX; i++) {
>> -        VRingMemoryRegionCaches *caches;
>>           if (vdev->vq[i].vring.num =3D=3D 0) {
>>               break;
>>           }
>> -        caches =3D atomic_read(&vdev->vq[i].vring.caches);
>> -        atomic_set(&vdev->vq[i].vring.caches, NULL);
>> -        virtio_free_region_cache(caches);
>> +        virtio_virtqueue_reset_region_cache(&vdev->vq[i]);
> OTOH, immediate destruction may still be called for during device
> finalization.
>

Right but to avoid code duplication, use rcu unconditionally should be=20
no harm here.

Thanks

>>       }
>>       g_free(vdev->vq);
>>   }
