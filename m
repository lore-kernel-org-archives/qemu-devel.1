Received: from eggs.gnu.org ([2001:4830:134:3::10]:39826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnySm-0000lJ-ND
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 22:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnySj-0005qJ-G7
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 22:14:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cnySj-0005po-9y
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 22:14:53 -0400
References: <1489460502-6686-1-git-send-email-jasowang@redhat.com>
	<1489460502-6686-3-git-send-email-jasowang@redhat.com>
	<20170314102918.3dce0075.cornelia.huck@de.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fc240730-be1d-4b95-0106-48caf5ebc533@redhat.com>
Date: Wed, 15 Mar 2017 10:14:48 +0800
MIME-Version: 1.0
In-Reply-To: <20170314102918.3dce0075.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V3 2/3] virtio: destroy region cache during
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



On 2017=E5=B9=B403=E6=9C=8814=E6=97=A5 17:29, Cornelia Huck wrote:
> On Tue, 14 Mar 2017 11:01:41 +0800
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
>> Changes from V2:
>> - introduce a helper and assert caches !=3D NULL
>> Changes from v1:
>> - switch to use rcu in virtio_virtqueue_region_cache()
>> - use unlikely() when needed
>> ---
>>   hw/virtio/virtio.c | 46 ++++++++++++++++++++++++++++++--------------=
--
>>   1 file changed, 30 insertions(+), 16 deletions(-)
>>
>> @@ -249,11 +255,10 @@ static inline void vring_used_idx_set(VirtQueue =
*vq, uint16_t val)
>>   /* Called within rcu_read_lock().  */
>>   static inline void vring_used_flags_set_bit(VirtQueue *vq, int mask)
>>   {
>> -    VRingMemoryRegionCaches *caches =3D atomic_rcu_read(&vq->vring.ca=
ches);
>> +    VRingMemoryRegionCaches *caches =3D vring_get_region_caches(vq);
>>       VirtIODevice *vdev =3D vq->vdev;
>>       hwaddr pa =3D offsetof(VRingUsed, flags);
>>       uint16_t flags =3D virtio_lduw_phys_cached(vq->vdev, &caches->us=
ed, pa);
>> -
> Unrelated whitespace change.

Right. If no more comments from any others. I think Michael can probably=20
fix this during merge.

Thanks

>
>>       virtio_stw_phys_cached(vdev, &caches->used, pa, flags | mask);
>>       address_space_cache_invalidate(&caches->used, pa, sizeof(flags))=
;
>>   }
> Other than that:
>
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>
>
