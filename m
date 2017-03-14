Received: from eggs.gnu.org ([2001:4830:134:3::10]:47376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnby6-0005Y9-6D
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 22:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnby3-0006Q3-2b
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 22:13:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cnby2-0006PF-TL
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 22:13:43 -0400
References: <1489386583-11564-1-git-send-email-jasowang@redhat.com>
	<1489386583-11564-2-git-send-email-jasowang@redhat.com>
	<20170313110523.549e4a99.cornelia.huck@de.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0c1a620f-90e2-1f2b-8615-ed17b88b1272@redhat.com>
Date: Tue, 14 Mar 2017 10:13:37 +0800
MIME-Version: 1.0
In-Reply-To: <20170313110523.549e4a99.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2 2/3] virtio: destroy region cache during
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com



On 2017=E5=B9=B403=E6=9C=8813=E6=97=A5 18:05, Cornelia Huck wrote:
> On Mon, 13 Mar 2017 14:29:42 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> We don't destroy region cache during reset which can make the maps
>> of previous driver leaked to a buggy or malicious driver that don't
>> set vring address before starting to use the device. Fix this by
>> destroy the region cache during reset and validate it before trying to
>> see them.
>>
>> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>> Changes from v1:
>> - switch to use rcu in virtio_virtqueue_region_cache()
>> - use unlikely() when needed
>> ---
>>   hw/virtio/virtio.c | 60 ++++++++++++++++++++++++++++++++++++++++++++=
+++-------
>>   1 file changed, 53 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 76cc81b..f086452 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -190,6 +190,10 @@ static inline uint16_t vring_avail_flags(VirtQueu=
e *vq)
>>   {
>>       VRingMemoryRegionCaches *caches =3D atomic_rcu_read(&vq->vring.c=
aches);
>>       hwaddr pa =3D offsetof(VRingAvail, flags);
>> +    if (unlikely(!caches)) {
>> +        virtio_error(vq->vdev, "Cannot map avail flags");
>> +        return 0;
> I'm still not 100% convinced of those checks; but they don't do any
> harm.

Right, consider we've already had patch 1, I think it should be fine to=20
use assert here.

>
>> +    }
>>       return virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
>>   }
>>
> (...)
>
>> +static void virtio_virtqueue_reset_region_cache(struct VirtQueue *vq)
>> +{
>> +    VRingMemoryRegionCaches *caches;
>> +
>> +    caches =3D atomic_read(&vq->vring.caches);
>> +    atomic_set(&vq->vring.caches, NULL);
> Needs atomic_rcu_set(), I think.

Any atomic write should be fine here, but I agree atomic_rcu_set() is=20
better. Will use it in next version.

Thanks

>
>> +    if (caches) {
>> +        call_rcu(caches, virtio_free_region_cache, rcu);
>> +    }
>> +}
>> +
>>   void virtio_reset(void *opaque)
>>   {
>>       VirtIODevice *vdev =3D opaque;
>
