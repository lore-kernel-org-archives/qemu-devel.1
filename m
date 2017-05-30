Received: from eggs.gnu.org ([2001:4830:134:3::10]:55810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dFoM8-0006jp-16
	for qemu-devel@nongnu.org; Tue, 30 May 2017 17:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dFoM4-0006nJ-Si
	for qemu-devel@nongnu.org; Tue, 30 May 2017 17:07:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dFoM4-0006n2-Jz
	for qemu-devel@nongnu.org; Tue, 30 May 2017 17:07:04 -0400
References: <20170526142858.19931-1-maxime.coquelin@redhat.com>
	<20170526142858.19931-4-maxime.coquelin@redhat.com>
	<20170530210905-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <1432592b-f0e2-fbf1-0479-03ba7e584b17@redhat.com>
Date: Tue, 30 May 2017 23:06:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170530210905-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/6] vhost: extend ring information
 update for IOTLB to all rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com

Hi Michael,

On 05/30/2017 08:12 PM, Michael S. Tsirkin wrote:
> On Fri, May 26, 2017 at 04:28:55PM +0200, Maxime Coquelin wrote:
>> Vhost-kernel backend need
> 
> needs
> 
>> to receive IOTLB entry for used ring
>> information early, which is done by triggering a miss event on
>> its address.
>>
>> This patch extends this behaviour to all rings information, to be
>> compatible with vhost-user backend design.
> 
> Why does vhost-user need it though?

For vhost-user, this simplifies the backend design because generally,
the backend sends IOTLB miss requests from processing threads through
the slave channel, and receives resulting IOTLB updates in vhost-user
protocol thread.

The only exception is for these rings info, where IOTLB miss requests
are sent from vhost-user protocol thread (in the SET_VRING_ENABLE
request handler), so the resulting IOTLB update is only handled by
the backend when the rings are enabled, which is too late.

It could be possible to overcome this issue, but I think it would
make the design more complex or less efficient. I see several options:

1. Change the IOTLB miss request so that the master sends the IOTLB
update as reply, instead of the reply-ack. It would mean that IOTLB
updates/invalidations would be sent either via the master channel or
the slave channel. On QEMU side, it means diverging from kernel backend
implementation. On backend side, it means having possibly multiple
threads writing to the IOTLB cache.

2. In vhost-user protocol thread, when handling SET_VRING_ENABLE, send
IOTLB miss request without setting the reply-ack flag, and poll the
vhost-user socket to read the resulting IOTLB update. The problem is
that other requests could be pending in the socket's buffer, and so it
would end-up nesting multiple requests handling.

3. Don't interpret rings info in the vhost-user protocol thread, but
only in the processing threads. The advantage is that it would address
the remark you made on patch 6 that invalidates are not affecting ring
info. The downside being the overhead induced by checking whether the
ring info are valid every time it is being used. I haven't prototyped
this solution, but I expected the performance regression to be a
blocker.

4. In SET_VRING_ENABLE, don't enable the ring if needed entries are not 
in IOTLB cache. Just send the IOTLB misses without reply-ack flag and 
postpone enable when handling IOTLB updates. It will be a little more 
complex solution than current one, but it may be the less impacting 
compared to the other 3 options.


Thinking again, maybe trying solution would be worth the effort, and 
could be extended also to disable the rings when receiving invalidates
that affect rings info.

What do you think?

> 
>>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>> ---
>> v2:
>>   - Revert back to existing behaviour, i.e. only send IOTLB updates
>> at ring enablement time, not at ring address setting time (mst).
>>   - Extend IOTLB misses to all ring addresses, not only used ring.
>>
>>   hw/virtio/vhost.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 6eddb09..7867034 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -1552,11 +1552,15 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
>>       if (vhost_dev_has_iommu(hdev)) {
>>           hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
>>   
>> -        /* Update used ring information for IOTLB to work correctly,
>> -         * vhost-kernel code requires for this.*/
>> +        /*
>> +         * Update rings information for IOTLB to work correctly,
>> +         * vhost-kernel and vhost-user codes require for this.
> 
> Better just say "Update ring info for vhost iotlb."
> 
> The rest isn't really informative.

Ok.

> 
> 
> 
>> +         */
>>           for (i = 0; i < hdev->nvqs; ++i) {
>>               struct vhost_virtqueue *vq = hdev->vqs + i;
>>               vhost_device_iotlb_miss(hdev, vq->used_phys, true);
>> +            vhost_device_iotlb_miss(hdev, vq->desc_phys, true);
>> +            vhost_device_iotlb_miss(hdev, vq->avail_phys, true);
> 
> So I don't remember why does vhost in kernel want miss on used
> at start time.
> 
> Jason, could you comment on this please?
> 
> 
> 
>>           }
>>       }
>>       return 0;
>> -- 
>> 2.9.4

Thanks,
Maxime
