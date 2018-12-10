Received: from eggs.gnu.org ([2001:4830:134:3::10]:46029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gWKdu-00017V-Ny
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 07:26:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gWKdq-00033m-IO
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 07:26:34 -0500
Date: Mon, 10 Dec 2018 13:25:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181210122517.GD5000@localhost.localdomain>
References: <20181205122326.26625-1-dplotnikov@virtuozzo.com>
	<20181207122647.GE5119@linux.fritz.box>
	<01597daf-b1b8-d506-85c1-b58af758f367@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01597daf-b1b8-d506-85c1-b58af758f367@virtuozzo.com>
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

Am 10.12.2018 um 13:14 hat Denis Plotnikov geschrieben:
> >> @@ -491,9 +506,17 @@ int64_t aio_compute_timeout(AioContext *ctx);
> >>    */
> >>   static inline void aio_disable_external(AioContext *ctx)
> >>   {
> >> +    aio_context_acquire(ctx);
> >>       atomic_inc(&ctx->external_disable_cnt);
> >> +    aio_context_release(ctx);
> >>   }
> > 
> > This acquire/release pair looks rather useless?
> 
> I'm not sure that I understand everything correctly...
> but can a thread (context) try to disable external in another context?

Yes, that can happen. For example, think of bdrv_drain_all().

Kevin
