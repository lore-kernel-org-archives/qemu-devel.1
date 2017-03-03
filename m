Received: from eggs.gnu.org ([2001:4830:134:3::10]:56615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cjjga-0005he-95
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 04:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cjjgX-0003g9-5L
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 04:39:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cjjgW-0003fp-V9
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 04:39:37 -0500
References: <1488531088-12483-1-git-send-email-jasowang@redhat.com>
	<20170303101517.20dd05f9.cornelia.huck@de.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b84a57c6-e03c-1309-adef-797f506536b3@redhat.com>
Date: Fri, 3 Mar 2017 17:39:27 +0800
MIME-Version: 1.0
In-Reply-To: <20170303101517.20dd05f9.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio: unbreak 1.0 device load with
 region cache
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



On 2017=E5=B9=B403=E6=9C=8803=E6=97=A5 17:15, Cornelia Huck wrote:
> On Fri,  3 Mar 2017 16:51:28 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> Current code depends on virtio_queue_update_rings() to setup address
>> space cache. But this does not work for 1.0 device since we can't infe=
r
>> avail and used. Fixing this by calling virtio_init_region_cache()
>> after subsections load which can guarantee avail and used are correct.
>>
>> Fixes: 97cd965c0701 ("virtio: use VRingMemoryRegionCaches for avail
>>                        and used rings")
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   hw/virtio/virtio.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 23483c7..faa45cb 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -2059,6 +2059,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f,=
 int version_id)
>>
>>       rcu_read_lock();
>>       for (i =3D 0; i < num; i++) {
>> +        virtio_init_region_cache(vdev, i);
>>           if (vdev->vq[i].vring.desc) {
>>               uint16_t nheads;
>>               nheads =3D vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].l=
ast_avail_idx;
> "virtio: add missing region cache init in virtio_load()" should take
> care of that (but has not been pulled yet, it seems).
>
>

Somehow miss this patch. Yes, it should.

Thanks
