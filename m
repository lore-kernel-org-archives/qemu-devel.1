Received: from eggs.gnu.org ([2001:4830:134:3::10]:56708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cjt7a-0003ok-4L
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cjt7W-0000ro-MH
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:44:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cjt7W-0000qM-C6
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:44:06 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v23JhvCM067155
	for <qemu-devel@nongnu.org>; Fri, 3 Mar 2017 14:44:04 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28xs8eym93-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 14:44:04 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 3 Mar 2017 19:44:01 -0000
References: <20170302130422.81380-1-pasic@linux.vnet.ibm.com>
	<20170302154935.7b8ec875.cornelia.huck@de.ibm.com>
	<b12c69aa-67ee-ffbc-cd89-716c24889167@redhat.com>
	<9a67d492-5bda-4b2a-0732-4034176d0d28@linux.vnet.ibm.com>
	<7b6ff676-bf57-d9ab-def7-fe894f821f03@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 3 Mar 2017 20:43:58 +0100
MIME-Version: 1.0
In-Reply-To: <7b6ff676-bf57-d9ab-def7-fe894f821f03@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <42da742f-a4fa-b592-904e-5e6f07bfe990@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio-blk: fix race on guest notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>



On 03/02/2017 05:21 PM, Paolo Bonzini wrote:
> 
> 
> On 02/03/2017 16:55, Halil Pasic wrote:
>>>>>      blk_set_aio_context(s->conf->conf.blk, qemu_get_aio_context());
>> I'm wondering if synchronization is needed for batch_notify_vqs. I think
>> the set_bit can be from the iothread, but the notify_guest_bh below is main
>> event loop. Is it OK like this (could we miss bits set in other thread)?
>> Does blk_set_aio_context include a barrier?
> 
> Another good question---yes, it does (via bdrv_set_aio_context's call to
> aio_context_acquire).
> 
> But it's something to remember for when I get round to removing
> aio_context_acquire!

Uh, this is complicated. I'm not out of questions, but I fear taking to
much of your precious time. I will ask again nevertheless, but please
just cut the conversation with -EBUSY if it gets to expensive.

What I understand is the batch_notify_vqs is effectively protected
by blk_get_aio_context(s->conf.conf.blk)->lock which might or might not
be the same as qemu_get_aio_context()->lock. If it ain't the same
that means we are running with iothread. Now let us have a look
at the drain. IFAIU in

#define BDRV_POLL_WHILE(bs, cond) ({                       \
    bool waited_ = false;                                  \
    BlockDriverState *bs_ = (bs);                          \
    AioContext *ctx_ = bdrv_get_aio_context(bs_);          \
    if (aio_context_in_iothread(ctx_)) {                   \
        while ((cond)) {                                   \
            aio_poll(ctx_, true);                          \
            waited_ = true;                                \
        }                                                  \
    } else {                                               \
        assert(qemu_get_current_aio_context() ==           \
               qemu_get_aio_context());                    \
        /* Ask bdrv_dec_in_flight to wake up the main      \
         * QEMU AioContext.  Extra I/O threads never take  \
         * other I/O threads' AioContexts (see for example \
         * block_job_defer_to_main_loop for how to do it). \
         */                                                \
        assert(!bs_->wakeup);                              \
        bs_->wakeup = true;                                \
        while ((cond)) {                                   \
            aio_context_release(ctx_);                     \
            aio_poll(qemu_get_aio_context(), true);        \
            aio_context_acquire(ctx_);                     \
            waited_ = true;                                \
        }                                                  \
        bs_->wakeup = false;                               \
    }                                                      \
    waited_; })

where it's interesting (me running with 2 iothreads one assigned to my
block device) we are gonna take  the "else" branch , a will end up
releasing the ctx belonging to the iothread and then acquire it again,
and basically wait till the requests are done.

Since is virtio_blk_rw_complete acquiring-releasing the same ctx this
makes a lot of sense. If we would not release the ctx we would end up
with a deadlock.


What I do not understand entirely are the atomic_read/write on
bs->in_flight which tells us when are we done waiting. In

static void blk_aio_complete(BlkAioEmAIOCB *acb)
{
    if (acb->has_returned) {
        bdrv_dec_in_flight(acb->common.bs);
        acb->common.cb(acb->common.opaque, acb->rwco.ret);
        qemu_aio_unref(acb);
    }
}

the atomic decrements is before the callback, that is
virtio_blk_rw_complete called. My guess here is, that this does not
matter, because we are holding the ctx anyway, so it is ensured that we
will not observe 0 until the last virtio_blk_rw_complete completed (mutex
is recursive). But then I do not understand what is the point acquiring
the mutex in virtio_blk_rw_complete?

TL;DR

Is patch b9e413dd required for the correctness of this patch?

What is the role of the aio_context_acquire/release introduced by
b9e413dd in virtio_blk_rw_complete?

Regards,
Halil
