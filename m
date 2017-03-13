Received: from eggs.gnu.org ([2001:4830:134:3::10]:55572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cnPIM-0002f4-Uq
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cnPIJ-0004AD-Rt
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:41:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33368
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cnPIJ-00049k-Lo
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:41:47 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2DCcVdL009799
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 08:41:46 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 294ea2rrwb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 08:41:46 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 13 Mar 2017 12:41:44 -0000
References: <20170307131650.90167-1-pasic@linux.vnet.ibm.com>
	<0bccd267-1c59-09f1-3098-7a74759d00dd@redhat.com>
	<669f36ca-990f-229b-c2b1-f583826574f4@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 13 Mar 2017 13:41:42 +0100
MIME-Version: 1.0
In-Reply-To: <669f36ca-990f-229b-c2b1-f583826574f4@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <c2610d87-6f9a-22b8-5236-961458a29dfd@linux.vnet.ibm.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-stable@nongnu.org



On 03/10/2017 10:08 PM, Halil Pasic wrote:
> 
> 
> On 03/10/2017 05:47 PM, Paolo Bonzini wrote:
>>
>> On 07/03/2017 14:16, Halil Pasic wrote:
>>> The commits 03de2f527 "virtio-blk: do not use vring in dataplane"  and
>>> 9ffe337c08 "virtio-blk: always use dataplane path if ioeventfd is active"
>>> changed how notifications are done for virtio-blk substantially. Due to a
>>> race condition, interrupts are lost when irqfd behind the guest notifier
>>> is torn down after notify_guest_bh was scheduled but before it actually
>>> runs.
>>>
>>> Let's fix this by forcing guest notifications before cleaning up the
>>> irqfd's. Let's also add some explanatory comments.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>> Reported-by: Michael A. Tebolt <miket@us.ibm.com>
>>> Tested-by: Michael A. Tebolt <miket@us.ibm.com>
>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>
>>> This patch withstood the test case which discovered the problem
>>> for several days (as reported by Michale Tebolt).
>>>
>>> v1 --> v2:
>>> * Fixed typo pointed out by Connie
>>> * Added Tested-by
>> Hi Halil,
>>
>> I found a similar issue in NBD.  Can you check if this patch fixes
>> the virtio-blk issue too?
>>
>> Thanks,
>> Paolo
>>
>> ------ 8< ------------
>>
>> diff --git a/block.c b/block.c
>> index f293ccb..e159251 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -4272,8 +4272,15 @@ void bdrv_attach_aio_context(BlockDriverState *bs,
>>
>>  void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
>>  {
>> +    AioContext *ctx;
>> +
>>      bdrv_drain(bs); /* ensure there are no in-flight requests */
>>
>> +    ctx = bdrv_get_aio_context(bs);
>> +    while (aio_poll(ctx, false)) {
>> +        /* wait for all bottom halves to execute */
>> +    }
>> +
>>      bdrv_detach_aio_context(bs);
>>
>>      /* This function executes in the old AioContext so acquire the new one in
>>
>>
> 
> So far so good! I will let it spin over the weekend but I think it's unlikely
> something will turn up.
> 
> I was wondering, would it make sense to push this logic into bdrv_drain?
> (Along the lines: this looks much like tying up loose ends drain has left.
> But I'm not sure about it.)
> 

I think it's safe to say that this fixes the virtio-blk issue too. Are you
going to send a proper patch with this (or an equivalent) change?

Halil
