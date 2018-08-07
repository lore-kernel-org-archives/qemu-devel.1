Received: from eggs.gnu.org ([2001:4830:134:3::10]:40959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fn2hf-0006LP-7G
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fn2he-0006v8-F3
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:11:15 -0400
Date: Tue, 7 Aug 2018 22:11:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180807141031.GA12064@lemon.usersys.redhat.com>
References: <20180807091655.32472-1-famz@redhat.com>
	<20180807091655.32472-3-famz@redhat.com>
	<3ca9cf3e-6b95-76f4-e729-8abdc9a2c0b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ca9cf3e-6b95-76f4-e729-8abdc9a2c0b8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] aio: Do aio_notify_accept only
 during blocking aio_poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, lersek@redhat.com, qemu-block@nongnu.org

On Tue, 08/07 12:15, Paolo Bonzini wrote:
> On 07/08/2018 11:16, Fam Zheng wrote:
> >     main thread                     IO Thread
> >     ===============================================================
> >     bdrv_drained_begin()
> >       aio_disable_external(ctx)
> >                                     aio_poll(ctx, true)
> >                                       ctx->notify_me += 2
> >                                       ppoll() /* blocked */
> >     ...
> >     bdrv_drained_end()
> >       ...
> >         aio_notify()

[2]            ^^^^^

> >     ...
> >     bdrv_set_aio_context()
> >       aio_poll(ctx, false)
> > [1]     aio_notify_accept(ctx)
> >                                       /* Hang! */
> 
> Should ppoll() rather be after [1]?  Otherwise the new commit message
> and patches look great.

Good point. They race and I think aio_notify_accept() is indeed done before
ppoll() starts its waiting. I will finish testing and send v3.

Fam

> 
> > aio_notify() only injects an event when ctx->notify_me is set,
> > correspondingly aio_notify_accept() is only useful when ctx->notify_me
> > _was_ set.
> 
> Very good point.
> 
> (Please Cc qemu-stable on the second patch too).
> 
> Paolo
