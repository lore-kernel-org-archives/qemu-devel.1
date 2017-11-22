Received: from eggs.gnu.org ([2001:4830:134:3::10]:38027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHadM-0002Fq-OF
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 14:24:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHadJ-0003ji-BR
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 14:24:32 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:41325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eHadJ-0003jV-4j
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 14:24:29 -0500
Received: by mail-wm0-f67.google.com with SMTP id b189so12517356wmd.0
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 11:24:29 -0800 (PST)
References: <1511364808-30171-1-git-send-email-deepa.srinivasan@oracle.com>
	<215448fd-8dbf-882a-35af-7778a6c4ab38@redhat.com>
	<20171122180640.GD10954@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d883af5c-7e59-6acc-c475-04c30b16de61@redhat.com>
Date: Wed, 22 Nov 2017 20:24:25 +0100
MIME-Version: 1.0
In-Reply-To: <20171122180640.GD10954@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Fix qemu crash when
 using scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: mark.kanda@oracle.com, qemu-block@nongnu.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, qemu-devel@nongnu.org, mreitz@redhat.com, Deepa Srinivasan <deepa.srinivasan@oracle.com>, stefanha@redhat.com

On 22/11/2017 19:06, Kevin Wolf wrote:
> Am 22.11.2017 um 17:34 hat Paolo Bonzini geschrieben:
>> On 22/11/2017 16:33, Deepa Srinivasan wrote:
>>> Starting qemu with the following arguments causes qemu to segfault:
>>> ... -device lsi,id=lsi0 -drive file=iscsi:<...>,format=raw,if=none,node-name=
>>> iscsi1 -device scsi-block,bus=lsi0.0,id=<...>,drive=iscsi1
>>>
>>> This patch fixes blk_aio_ioctl() so it does not pass stack addresses to
>>> blk_aio_ioctl_entry() which may be invoked after blk_aio_ioctl() returns. More
>>> details about the bug follow.
>>>
>>> blk_aio_ioctl() invokes blk_aio_prwv() with blk_aio_ioctl_entry as the
>>> coroutine parameter. blk_aio_prwv() ultimately calls aio_co_enter().
>>>
>>> When blk_aio_ioctl() is executed from within a coroutine context (e.g.
>>> iscsi_bh_cb()), aio_co_enter() adds the coroutine (blk_aio_ioctl_entry) to
>>> the current coroutine's wakeup queue. blk_aio_ioctl() then returns.
>>>
>>> When blk_aio_ioctl_entry() executes later, it accesses an invalid pointer:
>>> ....
>>>     BlkRwCo *rwco = &acb->rwco;
>>>
>>>     rwco->ret = blk_co_ioctl(rwco->blk, rwco->offset,
>>>                              rwco->qiov->iov[0].iov_base);  <--- qiov is
>>>                                                                  invalid here
>>> ...
>>>
>>> In the case when blk_aio_ioctl() is called from a non-coroutine context,
>>> blk_aio_ioctl_entry() executes immediately. But if bdrv_co_ioctl() calls
>>> qemu_coroutine_yield(), blk_aio_ioctl() will return. When the coroutine
>>> execution is complete, control returns to blk_aio_ioctl_entry() after the call
>>> to blk_co_ioctl(). There is no invalid reference after this point, but the
>>> function is still holding on to invalid pointers.
>>>
>>> The fix is to allocate memory for the QEMUIOVector and struct iovec as part of
>>> the request struct which the IO buffer is part of. The memory for this struct is
>>> guaranteed to be valid till the AIO is completed.
>>>
>>> Signed-off-by: Deepa Srinivasan <deepa.srinivasan@oracle.com>
>>> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>> Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
>>> ---
>>>  block/block-backend.c          | 13 ++-----------
>>>  hw/block/virtio-blk.c          |  9 ++++++++-
>>>  hw/scsi/scsi-disk.c            | 10 +++++++++-
>>>  hw/scsi/scsi-generic.c         |  9 ++++++++-
>>>  include/sysemu/block-backend.h |  2 +-
>>>  5 files changed, 28 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/block/block-backend.c b/block/block-backend.c
>>> index baef8e7..c275827 100644
>>> --- a/block/block-backend.c
>>> +++ b/block/block-backend.c
>>> @@ -1472,19 +1472,10 @@ static void blk_aio_ioctl_entry(void *opaque)
>>>      blk_aio_complete(acb);
>>>  }
>>>  
>>> -BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void *buf,
>>> +BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, QEMUIOVector *qiov,
>>>                            BlockCompletionFunc *cb, void *opaque)
>>
>> I think this is not the best way to fix the bug, because it adds extra
>> unnecessary code in the callers.
>>
>> Perhaps you can change BlkRwCo's "qiov" field to "void *buf" and the
>> same for blk_aio_prwv's "qiov" argument?
>>
>> Then the QEMUIOVector is not needed at all, and blk_co_ioctl can just
>> use rwco->buf.
> 
> But the same struct is used for read and write requests that do use an
> actual QEMUIOVector and not just a linear buffer.

Then let's call it "void *opaque", or make it a union (but I think
that's overkill).

The QEMUIOVector pointer is opaque as far as blk_aio_prwv is concerned,
and it is only created by blk_aio_ioctl for blk_aio_ioctl_entry to
extract buf:

    rwco->ret = blk_co_ioctl(rwco->blk, rwco->offset,
                             rwco->qiov->iov[0].iov_base);

Exposing the fake QEMUIOVector to the callers of blk_aio_ioctl is much
uglier than using a void* for what is effectively a multi-type pointer.

Paolo
