Received: from eggs.gnu.org ([2001:4830:134:3::10]:53668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dL9WF-0004R0-7K
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dL9WE-0007mM-Dh
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:43:39 -0400
Date: Wed, 14 Jun 2017 16:43:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170614144324.GA4785@noname.redhat.com>
References: <20170522135704.842-1-stefanha@redhat.com>
	<20170522135704.842-4-stefanha@redhat.com>
	<add32dd6-f842-9d66-0f7f-6e0e2b7c8100@virtuozzo.com>
	<99f414f1-7a0f-b659-be81-d6f38fd04ff4@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99f414f1-7a0f-b659-be81-d6f38fd04ff4@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/4] migration: avoid recursive
 AioContext locking in save_vmstate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org

Am 14.06.2017 um 15:15 hat Pavel Butsykin geschrieben:
> On 14.06.2017 13:10, Pavel Butsykin wrote:
> >
> >On 22.05.2017 16:57, Stefan Hajnoczi wrote:
> >>AioContext was designed to allow nested acquire/release calls.  It uses
> >>a recursive mutex so callers don't need to worry about nesting...or so
> >>we thought.
> >>
> >>BDRV_POLL_WHILE() is used to wait for block I/O requests.  It releases
> >>the AioContext temporarily around aio_poll().  This gives IOThreads a
> >>chance to acquire the AioContext to process I/O completions.
> >>
> >>It turns out that recursive locking and BDRV_POLL_WHILE() don't mix.
> >>BDRV_POLL_WHILE() only releases the AioContext once, so the IOThread
> >>will not be able to acquire the AioContext if it was acquired
> >>multiple times.
> >>
> >>Instead of trying to release AioContext n times in BDRV_POLL_WHILE(),
> >>this patch simply avoids nested locking in save_vmstate().  It's the
> >>simplest fix and we should step back to consider the big picture with
> >>all the recent changes to block layer threading.
> >>
> >>This patch is the final fix to solve 'savevm' hanging with -object
> >>iothread.
> >
> >The same I see in external_snapshot_prepare():
> >[...]
> >and at the moment BDRV_POLL_WHILE(bs, flush_co.ret == NOT_DONE),
> >we have at least two locks.. So here is another deadlock.
> 
> Sorry, here different kind of deadlock. In external_snapshot case, the
> deadlock can happen only if state->old_bs->aio_context == my_iothread->ctx,
> because in this case the aio_co_enter() always calls aio_co_schedule():

Can you please write qemu-iotests case for any deadlock case that we're
seeing? Stefan, we could also use one for the bug fixed in this series.

Kevin
