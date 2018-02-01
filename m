Received: from eggs.gnu.org ([2001:4830:134:3::10]:60606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehGf8-0002wJ-7Q
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:20:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehGey-0002Ha-Qc
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:20:30 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <87883f3d-9098-2233-b643-c310c9ae2d23@redhat.com>
References: <1517494591-39369-1-git-send-email-anton.nefedov@virtuozzo.com>
	<3ad2256a-01cd-6c9b-9a34-663aa077f26f@redhat.com>
	<87883f3d-9098-2233-b643-c310c9ae2d23@redhat.com>
Date: Thu, 01 Feb 2018 16:19:38 +0100
Message-ID: <w514ln068l1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: fix write with zero
 flag set and iovector provided
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

On Thu 01 Feb 2018 03:40:51 PM CET, Eric Blake wrote:
>>> --- a/block/io.c
>>> +++ b/block/io.c
>>> @@ -1701,7 +1701,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
>>>       */
>>>      tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_WRITE);
>>>  
>>> -    if (!qiov) {
>>> +    if (flags & BDRV_REQ_ZERO_WRITE) {
>>>          ret = bdrv_co_do_zero_pwritev(child, offset, bytes, flags, &req);
>> 
>> So now, the flag rules, but we assert that !qiov (so it would only break
>> a caller that passed the flag but used qiov, which you argued shouldn't
>> exist).
>
> Sorry, I hit send too soon.  I'm asking if we should have
> assert(!qiov) right before calling bdrv_co_do_zero_pwritev (it would
> break a caller that passed the flag and qiov, but you were arguing
> that such callers previously misbehaved, so we don't want such
> callers).

Those callers do exist as a matter of fact: bdrv_rw_co_entry() always
passes a qiov to bdrv_co_pwritev() regardless of the flags (the request
size is actually taken from the very qiov).

bdrv_pwrite_zeroes() is one example:

$ qemu-img create -f qcow2 base.img 100M
$ qemu-img create -f qcow2 -b base.img active.img
$ qemu-io -c 'write -z 0 128k' -f qcow2 active.img 
$ qemu-img amend -o compat=0.10 active.img 

It even uses an iovec with iov_base = NULL but iov_len != 0, which looks
like an abuse of the data structure.

Berto
