Received: from eggs.gnu.org ([2001:4830:134:3::10]:45430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnbnl-0002WP-1d
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 22:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnbng-0002jG-5t
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 22:03:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cnbnf-0002ib-U8
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 22:03:00 -0400
References: <1489386583-11564-1-git-send-email-jasowang@redhat.com>
	<20170313105515.75981fb9.cornelia.huck@de.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <99e8bc56-f679-778c-8ff9-f2be84c62618@redhat.com>
Date: Tue, 14 Mar 2017 10:02:53 +0800
MIME-Version: 1.0
In-Reply-To: <20170313105515.75981fb9.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2 1/3] virtio: guard against NULL pfn
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



On 2017=E5=B9=B403=E6=9C=8813=E6=97=A5 17:55, Cornelia Huck wrote:
> On Mon, 13 Mar 2017 14:29:41 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> To avoid access stale memory region cache after reset, this patch
>> check the existence of virtqueue pfn for all exported virtqueue access
>> helpers before trying to use them.
>>
>> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   hw/virtio/virtio.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index efce4b3..76cc81b 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -322,6 +322,10 @@ static int virtio_queue_empty_rcu(VirtQueue *vq)
>>           return 0;
>>       }
>>
>> +    if (unlikely(!vq->vring.avail)) {
>> +        return 0;
> Shouldn't that rather return !0 (denoting a non-existing queue as
> empty)?

Yes.

>
>> +    }
>> +
>>       return vring_avail_idx(vq) =3D=3D vq->last_avail_idx;
>>   }
>>
>> @@ -333,6 +337,10 @@ int virtio_queue_empty(VirtQueue *vq)
>>           return 0;
>>       }
>>
>> +    if (unlikely(!vq->vring.avail)) {
>> +        return 0;
> Likewise.
>
>> +    }
>> +
>>       rcu_read_lock();
>>       empty =3D vring_avail_idx(vq) =3D=3D vq->last_avail_idx;
>>       rcu_read_unlock();
>> @@ -431,6 +439,10 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueu=
eElement *elem,
>>           return;
>>       }
>>
>> +    if (unlikely(!vq->vring.used)) {
>> +        return;
>> +    }
>> +
>>       idx =3D (idx + vq->used_idx) % vq->vring.num;
>>
>>       uelem.id =3D elem->index;
>> @@ -448,6 +460,10 @@ void virtqueue_flush(VirtQueue *vq, unsigned int =
count)
>>           return;
>>       }
>>
>> +    if (unlikely(!vq->vring.used)) {
>> +        return;
>> +    }
>> +
>>       /* Make sure buffer is written before we update index. */
>>       smp_wmb();
>>       trace_virtqueue_flush(vq, count);
>> @@ -546,6 +562,11 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, uns=
igned int *in_bytes,
>>       int64_t len =3D 0;
>>       int rc;
>>
>> +    if (unlikely(!vq->vring.desc)) {
>> +        *in_bytes =3D *out_bytes =3D 0;
> I think you need to check for in_bytes and out_bytes being !NULL first.

Right, will fix this in v2.

Thanks

>
>> +        return;
>> +    }
>> +
>>       rcu_read_lock();
>>       idx =3D vq->last_avail_idx;
>>       total_bufs =3D in_total =3D out_total =3D 0;
>
