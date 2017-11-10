Received: from eggs.gnu.org ([2001:4830:134:3::10]:54143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eD9aF-0001yO-HT
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:43:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eD9a9-0005xL-Uj
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:42:59 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171109171210.GD25162@stefanha-x1.localdomain>
References: <1508816031-82709-1-git-send-email-sochin.jiang@huawei.com>
	<20171109171210.GD25162@stefanha-x1.localdomain>
Date: Fri, 10 Nov 2017 14:42:36 +0100
Message-ID: <w51wp2ytflf.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] throttle: fix a qemu crash
 problem when calling blk_delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, sochin jiang <sochin.jiang@huawei.com>
Cc: kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, lina.lulina@huawei.com, lizhengui@huawei.com, qemu-block@nongnu.org, subo7@huawei.com, eric.fangyi@huawei.com, zhangshuai13@huawei.com, qemu-devel@nongnu.org

On Thu 09 Nov 2017 06:12:10 PM CET, Stefan Hajnoczi wrote:
>> diff --git a/block/block-backend.c b/block/block-backend.c
>> index 45d9101..39c7cca 100644
>> --- a/block/block-backend.c
>> +++ b/block/block-backend.c
>> @@ -341,7 +341,7 @@ static void blk_delete(BlockBackend *blk)
>>      assert(!blk->name);
>>      assert(!blk->dev);
>>      if (blk->public.throttle_group_member.throttle_state) {
>> -        blk_io_limits_disable(blk);
>> +        throttle_group_unregister_tgm(&blk->public.throttle_group_member);
>
> The following assertions fail without the drain when there are pending
> requests:
>
>   void throttle_group_unregister_tgm(ThrottleGroupMember *tgm)
>   {
>       ThrottleState *ts = tgm->throttle_state;
>       ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
>       ThrottleGroupMember *token;
>       int i;
>
>       if (!ts) {
>           /* Discard already unregistered tgm */
>           return;
>       }
>
>       assert(tgm->pending_reqs[0] == 0 && tgm->pending_reqs[1] == 0);
>       assert(qemu_co_queue_empty(&tgm->throttled_reqs[0]));
>       assert(qemu_co_queue_empty(&tgm->throttled_reqs[1]));
>
> A safer approach is making blk_io_limits_disable(blk) skip the
> draining when blk_bs(blk) == NULL.  That is the only case where we are
> 100% sure that there are no pending requests.

I think so too.

And as I said in a previous e-mail I don't know if we should have a
valid blk->public.throttle_group_member.throttle_state with no timers at
all. I'd rather attach the default AioContext while the BDS is removed.

I'll try to prepare a patch with all of this together.

Berto
