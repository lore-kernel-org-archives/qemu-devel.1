Received: from eggs.gnu.org ([2001:4830:134:3::10]:40778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBGQq-0000qm-Jo
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBGQp-0008Q2-S9
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:05:12 -0400
MIME-Version: 1.0
In-Reply-To: <e6d9417e-87bb-a88f-4f55-0a72aae0a212@redhat.com>
References: <20170517170941.25850-1-stefanha@redhat.com>
	<20170517170941.25850-3-stefanha@redhat.com>
	<e6d9417e-87bb-a88f-4f55-0a72aae0a212@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 18 May 2017 09:05:09 +0100
Message-ID: <CAJSP0QXeia2HTyVArSFbNQH18hHToRKLiZj1KGPLq3G2KfL4GQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/3] block: use
 BDRV_POLL_WHILE() in bdrv_rw_vmstate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu block <qemu-block@nongnu.org>

On Wed, May 17, 2017 at 9:16 PM, Eric Blake <eblake@redhat.com> wrote:
> On 05/17/2017 12:09 PM, Stefan Hajnoczi wrote:
>> diff --git a/block/io.c b/block/io.c
>> index cc56e90..f0041cd 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -2031,9 +2031,7 @@ bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
>>          Coroutine *co = qemu_coroutine_create(bdrv_co_rw_vmstate_entry, &data);
>>
>>          bdrv_coroutine_enter(bs, co);
>> -        while (data.ret == -EINPROGRESS) {
>> -            aio_poll(bdrv_get_aio_context(bs), true);
>> -        }
>> +        BDRV_POLL_WHILE(bs, data.ret == -EINPROGRESS);
>>          return data.ret;
>>      }
>
> Do we have other culprits (not necessarily for vmsave, but for other
> situations), where we should be using BDRV_POLL_WHILE in separate
> patches? For example, a quick grep show that at least hw/9pfs/9p.c makes
> a direct call to aio_poll(,true) in a while loop.

virtio-9p doesn't use IOThread (dataplane) so it is not affected.  It
also doesn't use BlockDriverState so it cannot use BDRV_POLL_WHILE().

I did grep for other aio_poll() callers and didn't spot any obvious
cases that need to be fixed.  They tend to run in situations where
this deadlock cannot occur.

Stefan
