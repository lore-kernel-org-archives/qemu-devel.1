Received: from eggs.gnu.org ([2001:4830:134:3::10]:46810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1g03rh-0008AJ-Vj
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1g03rd-0000ps-0x
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:03:25 -0400
References: <20180629124052.331406-1-dplotnikov@virtuozzo.com>
	<20180629124052.331406-3-dplotnikov@virtuozzo.com>
	<20180910124136.GF4901@dhcp-200-186.str.redhat.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <81346e2a-5ce2-50d3-791e-3cab5e2464d9@virtuozzo.com>
Date: Wed, 12 Sep 2018 15:03:07 +0300
MIME-Version: 1.0
In-Reply-To: <20180910124136.GF4901@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v0 2/2] block: postpone the coroutine
 executing if the BDS's is drained
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, famz@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org



On 10.09.2018 15:41, Kevin Wolf wrote:
> Am 29.06.2018 um 14:40 hat Denis Plotnikov geschrieben:
>> Fixes the problem of ide request appearing when the BDS is in
>> the "drained section".
>>
>> Without the patch the request can come and be processed by the main
>> event loop, as the ide requests are processed by the main event loop
>> and the main event loop doesn't stop when its context is in the
>> "drained section".
>> The request execution is postponed until the end of "drained section".
>>
>> The patch doesn't modify ide specific code, as well as any other
>> device code. Instead, it modifies the infrastructure of asynchronous
>> Block Backend requests, in favor of postponing the requests arisen
>> when in "drained section" to remove the possibility of request appearing
>> for all the infrastructure clients.
>>
>> This approach doesn't make vCPU processing the request wait untill
>> the end of request processing.
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> 
> I generally agree with the idea that requests should be queued during a
> drained section. However, I think there are a few fundamental problems
> with the implementation in this series:
> 
> 1) aio_disable_external() is already a layering violation and we'd like
>     to get rid of it (by replacing it with a BlockDevOps callback from
>     BlockBackend to the devices), so adding more functionality there
>     feels like a step in the wrong direction.
> 
> 2) Only blk_aio_* are fixed, while we also have synchronous public
>     interfaces (blk_pread/pwrite) as well as coroutine-based ones
>     (blk_co_*). They need to be postponed as well.
Good point! Thanks!
> 
>     blk_co_preadv/pwritev() are the common point in the call chain for
>     all of these variants, so this is where the fix needs to live.
Using the common point might be a good idea, but in case aio requests we 
also have to mane completions which out of the scope of 
blk_co_p(read|write)v:

static void blk_aio_write_entry(void *opaque) {
     ...
     rwco->ret = blk_co_pwritev(...);

     blk_aio_complete(acb);
     ...
}

This makes the difference.
I would suggest adding waiting until "drained_end" is done on the 
synchronous read/write at blk_prw
 
                               >
> 3) Within a drained section, you want requests from other users to be
>     blocked, but not your own ones (essentially you want exclusive
>     access). We don't have blk_drained_begin/end() yet, so this is not
>     something to implement right now, but let's keep this requirement in
>     mind and choose a design that allows this.
There is an idea to distinguish the requests that should be done without 
respect to "drained section" by using a flag in BdrvRequestFlags. The 
requests with a flag set should be processed anyway.
> 
> I believe the whole logic should be kept local to BlockBackend, and
> blk_root_drained_begin/end() should be the functions that start queuing
> requests or let queued requests resume.
> 
> As we are already in coroutine context in blk_co_preadv/pwritev(), after
> checking that blk->quiesce_counter > 0, we can enter the coroutine
> object into a list and yield. blk_root_drained_end() calls aio_co_wake()
> for each of the queued coroutines. This should be all that we need to
> manage.
In my understanding by using brdv_drained_begin/end we want to protect a 
certain BlockDriverState from external access but not the whole 
BlockBackend which may involve using a number of BlockDriverState-s.
I though it because we could possibly change a backing file for some 
BlockDriverState. And for the time of changing we need to prevent 
external access to it but keep the io going.
By using blk_root_drained_begin/end() we put to "drained section" all 
the BlockDriverState-s linked to that root.
Does it have to be so?

Denis

> 
> Kevin
> 

-- 
Best,
Denis
