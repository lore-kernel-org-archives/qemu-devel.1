Received: from eggs.gnu.org ([2001:4830:134:3::10]:43217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1em5ax-0006Pr-MI
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 17:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1em5at-0003mz-4v
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 17:32:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1em5as-0003mh-Us
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 17:32:03 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E24339BB57
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 22:31:51 +0000 (UTC)
References: <20180213142102.14450-1-stefanha@redhat.com>
	<20180213142102.14450-2-stefanha@redhat.com>
	<73eb771d-ddcd-42e6-5895-23e6024ccc80@redhat.com>
	<20180214140647.GC7545@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8894e9fa-8e3d-ecfe-07f4-61a465f4bf57@redhat.com>
Date: Wed, 14 Feb 2018 16:31:45 -0600
MIME-Version: 1.0
In-Reply-To: <20180214140647.GC7545@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] block: extract AIO_WAIT_WHILE()
 from BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On 02/14/2018 08:06 AM, Stefan Hajnoczi wrote:
> On Tue, Feb 13, 2018 at 10:01:06AM -0600, Eric Blake wrote:
>> Trying to understand here:
>>
>>
>>> +#define AIO_WAIT_WHILE(wait, ctx, cond) ({                  \
>>> +    bool waited_ = false;                                   \
>>> +    bool busy_ = true;                                      \
>>> +    AioWait *wait_ = (wait);                                \
>>> +    AioContext *ctx_ = (ctx);                               \
>>> +    if (aio_context_in_iothread(ctx_)) {                    \
>>> +        while ((cond) || busy_) {                           \
>>> +            busy_ = aio_poll(ctx_, (cond));                 \
>>> +            waited_ |= !!(cond) | busy_;                    \
>>> +        }                                                   \
>>
>> If we are in an iothread already, we never dereference wait,
> 
> No, the name and documentation for aio_context_in_iothread() is
> misleading.  It actually means "does this AioContext belong to the
> current thread?", which is more general than just the IOThread case.
> 
> aio_context_in_iothread() returns true when:
> 1. We are the IOThread that owns ctx. <-- the case you thought of
> 2. We are the main loop and ctx == qemu_get_aio_context().
>     ^--- the sneaky case that BDRV_POLL_WHILE() has always relied on

Thanks, that helps.


>>> +    AIO_WAIT_WHILE(bdrv_get_aio_wait(bs_),                 \
>>> +                   bdrv_get_aio_context(bs_),              \
>>> +                   cond); })
>>
>> ...we can pass NULL as the wait parameter, which will crash.
> 
> It won't crash since if (aio_context_in_iothread(ctx_)) will take the true
> case when bs_ == NULL.

Okay, you've solved that one.

> 
>>> +++ b/block/io.c
>>
>>>    void bdrv_wakeup(BlockDriverState *bs)
>>>    {
>>> -    /* The barrier (or an atomic op) is in the caller.  */
>>> -    if (atomic_read(&bs->wakeup)) {
>>> -        aio_bh_schedule_oneshot(qemu_get_aio_context(), dummy_bh_cb, NULL);
>>> -    }
>>> +    aio_wait_kick(bdrv_get_aio_wait(bs));
>>
>> this is another case where passing NULL...
> 
> bdrv_wakeup() is only called when bs != NULL.

And looks like we're safe, there, as well.

> 
> I hope this explains things!  The main issue that raised these questions
> was that aio_context_in_iothread() has a misleading name.  Shall we
> rename it?

Maybe, but that's a separate patch.  What name would we bikeshed, maybe 
aio_context_correct_thread() (we are the correct thread if we are the 
iothread that owns ctx, or if we are the main thread and have properly 
acquired ctx) or aio_context_use_okay() (we can only use the ctx if we 
own it [native iothread] or have acquired it [main loop])

> 
> I'm having a hard time picking a new name because it must not be
> confused with AioContext acquire/release, which doesn't influence the
> "native" AioContext that the current thread has an affinity with.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
