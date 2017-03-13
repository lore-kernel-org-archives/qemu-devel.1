Received: from eggs.gnu.org ([2001:4830:134:3::10]:45034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnT9m-0002Rx-3f
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnT9h-00080G-8N
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:49:14 -0400
References: <20170307131650.90167-1-pasic@linux.vnet.ibm.com>
	<0bccd267-1c59-09f1-3098-7a74759d00dd@redhat.com>
	<669f36ca-990f-229b-c2b1-f583826574f4@linux.vnet.ibm.com>
	<c2610d87-6f9a-22b8-5236-961458a29dfd@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3697ff5f-2f30-c921-b74a-307f4aab60ad@redhat.com>
Date: Mon, 13 Mar 2017 17:49:05 +0100
MIME-Version: 1.0
In-Reply-To: <c2610d87-6f9a-22b8-5236-961458a29dfd@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] virtio-blk: fix race on guest
 notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-stable@nongnu.org



On 13/03/2017 13:41, Halil Pasic wrote:
> 
> 
> On 03/10/2017 10:08 PM, Halil Pasic wrote:
>>
>>
>> On 03/10/2017 05:47 PM, Paolo Bonzini wrote:
>>>
>>> On 07/03/2017 14:16, Halil Pasic wrote:
>>>> The commits 03de2f527 "virtio-blk: do not use vring in dataplane"  and
>>>> 9ffe337c08 "virtio-blk: always use dataplane path if ioeventfd is active"
>>>> changed how notifications are done for virtio-blk substantially. Due to a
>>>> race condition, interrupts are lost when irqfd behind the guest notifier
>>>> is torn down after notify_guest_bh was scheduled but before it actually
>>>> runs.
>>>>
>>>> Let's fix this by forcing guest notifications before cleaning up the
>>>> irqfd's. Let's also add some explanatory comments.
>>>>
>>>> Cc: qemu-stable@nongnu.org
>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>> Reported-by: Michael A. Tebolt <miket@us.ibm.com>
>>>> Tested-by: Michael A. Tebolt <miket@us.ibm.com>
>>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>>> ---
>>>>
>>>> This patch withstood the test case which discovered the problem
>>>> for several days (as reported by Michale Tebolt).
>>>>
>>>> v1 --> v2:
>>>> * Fixed typo pointed out by Connie
>>>> * Added Tested-by
>>> Hi Halil,
>>>
>>> I found a similar issue in NBD.  Can you check if this patch fixes
>>> the virtio-blk issue too?
>>>
>>> Thanks,
>>> Paolo
>>>
>>> ------ 8< ------------
>>>
>>> diff --git a/block.c b/block.c
>>> index f293ccb..e159251 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -4272,8 +4272,15 @@ void bdrv_attach_aio_context(BlockDriverState *bs,
>>>
>>>  void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
>>>  {
>>> +    AioContext *ctx;
>>> +
>>>      bdrv_drain(bs); /* ensure there are no in-flight requests */
>>>
>>> +    ctx = bdrv_get_aio_context(bs);
>>> +    while (aio_poll(ctx, false)) {
>>> +        /* wait for all bottom halves to execute */
>>> +    }
>>> +
>>>      bdrv_detach_aio_context(bs);
>>>
>>>      /* This function executes in the old AioContext so acquire the new one in
>>>
>>>
>>
>> So far so good! I will let it spin over the weekend but I think it's unlikely
>> something will turn up.
>>
>> I was wondering, would it make sense to push this logic into bdrv_drain?
>> (Along the lines: this looks much like tying up loose ends drain has left.
>> But I'm not sure about it.)
>>
> 
> I think it's safe to say that this fixes the virtio-blk issue too. Are you
> going to send a proper patch with this (or an equivalent) change?

Yes, I am, thanks!

Paolo
