Received: from eggs.gnu.org ([2001:4830:134:3::10]:35795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gBxr1-0000lo-8T
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gBxqy-0003lU-2K
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:03:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gBxqx-0003ka-Nl
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:03:51 -0400
References: <1539266915-15216-1-git-send-email-wexu@redhat.com>
	<1539266915-15216-3-git-send-email-wexu@redhat.com>
	<9c90bc11-2f65-2604-47bc-52b82fbea6fd@redhat.com>
	<20181015072631.GC27871@wei-ubt>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ebc840e2-d877-e6f1-a0d3-f2aaa5818228@redhat.com>
Date: Mon, 15 Oct 2018 16:03:39 +0800
MIME-Version: 1.0
In-Reply-To: <20181015072631.GC27871@wei-ubt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [[RFC v3 02/12] virtio: redefine structure &
 memory cache for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Xu <wexu@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com



On 2018=E5=B9=B410=E6=9C=8815=E6=97=A5 15:26, Wei Xu wrote:
> On Mon, Oct 15, 2018 at 11:03:52AM +0800, Jason Wang wrote:
>>
>> On 2018=E5=B9=B410=E6=9C=8811=E6=97=A5 22:08, wexu@redhat.com wrote:
>>> From: Wei Xu <wexu@redhat.com>
>>>
>>> Redefine packed ring structure according to qemu nomenclature,
>>> also supported data(event index, wrap counter, etc) are introduced.
>>>
>>> Signed-off-by: Wei Xu <wexu@redhat.com>
>>> ---
>>>   hw/virtio/virtio.c | 26 ++++++++++++++++++++++++--
>>>   1 file changed, 24 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>> index 94f5c8e..500eecf 100644
>>> --- a/hw/virtio/virtio.c
>>> +++ b/hw/virtio/virtio.c
>>> @@ -39,6 +39,13 @@ typedef struct VRingDesc
>>>       uint16_t next;
>>>   } VRingDesc;
>>> +typedef struct VRingPackedDesc {
>>> +    uint64_t addr;
>>> +    uint32_t len;
>>> +    uint16_t id;
>>> +    uint16_t flags;
>>> +} VRingPackedDesc;
>>> +
>>>   typedef struct VRingAvail
>>>   {
>>>       uint16_t flags;
>>> @@ -62,8 +69,14 @@ typedef struct VRingUsed
>>>   typedef struct VRingMemoryRegionCaches {
>>>       struct rcu_head rcu;
>>>       MemoryRegionCache desc;
>>> -    MemoryRegionCache avail;
>>> -    MemoryRegionCache used;
>>> +    union {
>>> +        MemoryRegionCache avail;
>>> +        MemoryRegionCache driver;
>>> +    };
>> Can we reuse avail and used?
> Sure.
>
>>> +    union {
>>> +        MemoryRegionCache used;
>>> +        MemoryRegionCache device;
>>> +    };
>>>   } VRingMemoryRegionCaches;
>>>   typedef struct VRing
>>> @@ -77,6 +90,11 @@ typedef struct VRing
>>>       VRingMemoryRegionCaches *caches;
>>>   } VRing;
>>> +typedef struct VRingPackedDescEvent {
>>> +    uint16_t off_wrap;
>>> +    uint16_t flags;
>>> +} VRingPackedDescEvent ;
>>> +
>>>   struct VirtQueue
>>>   {
>>>       VRing vring;
>>> @@ -87,6 +105,10 @@ struct VirtQueue
>>>       /* Last avail_idx read from VQ. */
>>>       uint16_t shadow_avail_idx;
>>> +    uint16_t event_idx;
>> Need a comment to explain this field.
> Yes, it is the unified name for interrupt which is what I want to see
> if we can reuse 'shadow' and 'used' index in current code, for Tx
> queue, it should be the 'used' index after finished sending the last
> desc. For Rx queue, it should be the 'shadow' index when no enough
> descriptors which might be a few descriptors ahead of the 'used' index,
> there are a few indexes already so this makes code a bit redundant.

If I understand your meaning correctly, you can refer vhost codes:

https://github.com/jasowang/net/commit/9b7b0d75d88d980a3c8954db0aa754b124=
facd0e

It maintains both last_wrap_counter and avail_wrap_counter/avail_idx.=20
avail_wrap_counter/avail_idx is guaranteed to be increased=20
monotonically, this is useful when we need to move avail index backwards.

Besides this, for qemu, I think you need a better name e.g=20
last_avail_idx here.

Thanks

>
> Will see if I can remove this in next version, any comments?
>
> Wei
>
>
>> Thanks
>>
>>> +    bool event_wrap_counter;
>>> +    bool avail_wrap_counter;
>>> +
>>>       uint16_t used_idx;
>>>       /* Last used index value we have signalled on */
>>
