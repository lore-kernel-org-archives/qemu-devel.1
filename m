Received: from eggs.gnu.org ([2001:4830:134:3::10]:53572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX3Zm-0000vr-9s
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 07:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX3Zl-0001rl-Fb
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 07:25:18 -0500
Date: Wed, 12 Dec 2018 13:24:57 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181212122457.GB5415@linux.fritz.box>
References: <20181205122326.26625-1-dplotnikov@virtuozzo.com>
	<20181207122647.GE5119@linux.fritz.box>
	<bb51b8f9-a3a4-90e6-2f69-57e90ccd623a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb51b8f9-a3a4-90e6-2f69-57e90ccd623a@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] blk: postpone request execution on a
 context protected with "drained section"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: "keith.busch@intel.com" <keith.busch@intel.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Denis Lunev <den@virtuozzo.com>, "famz@redhat.com" <famz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Am 11.12.2018 um 17:55 hat Denis Plotnikov geschrieben:
> > Why involve the AioContext at all? This could all be kept at the
> > BlockBackend level without extending the layering violation that
> > aio_disable_external() is.
> > 
> > BlockBackends get notified when their root node is drained, so hooking
> > things up there should be as easy, if not even easier than in
> > AioContext.
> 
> Just want to make sure that I understood correctly what you meant by 
> "BlockBackends get notified". Did you mean that bdrv_drain_end calls
> child's role callback blk_root_drained_end by calling 
> bdrv_parent_drained_end?

Yes, blk_root_drained_begin/end calls are all you need. Specifically,
their adjustments to blk->quiesce_counter that are already there, and in
the 'if (--blk->quiesce_counter == 0)' block of blk_root_drained_end()
we can resume the queued requests.

> In case if it's so, it won't work if resume postponed requests in 
> blk_root_drained_end since we can't know if external is disabled for the 
> context because the counter showing that is decreased only after roles' 
> drained callbacks are finished at bdrv_do_drained_end.
> Please correct me if I'm wrong.

You don't need to know about the AioContext state, this is the whole
point. blk->quiesce_counter is what tells you whether to postpone
requests.

> Looking at the patch again, I think that it might be useful to keep the 
> requests in the structure that limits their execution and also protects 
> the access (context acquire/release) although it's indeed the layering 
> violation but at least we can store the parts related at the same place
> and later on move somewhere else alongside the request restrictor.

You can keep everything you need in BlockBackend (and that's also where
your code is that really postpones request).

Kevin
