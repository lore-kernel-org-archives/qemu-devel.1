Received: from eggs.gnu.org ([2001:4830:134:3::10]:50566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGmLh-0001ug-GK
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:42:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGmLg-00050D-Kw
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:42:57 -0500
Date: Mon, 20 Nov 2017 08:42:40 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171120134240.GH5399@localhost.localdomain>
References: <cover.1511145863.git.jcody@redhat.com>
	<5bec37564f83e39e216d2ebcf7a380b0c7704e0e.1511145863.git.jcody@redhat.com>
	<20171120112826.GC4516@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120112826.GC4516@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/5] coroutine: abort if we
 try to enter coroutine scheduled for another ctx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

On Mon, Nov 20, 2017 at 11:28:26AM +0000, Stefan Hajnoczi wrote:
> On Sun, Nov 19, 2017 at 09:46:43PM -0500, Jeff Cody wrote:
> > diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
> > index cb98892..931cdc9 100644
> > --- a/include/qemu/coroutine_int.h
> > +++ b/include/qemu/coroutine_int.h
> > @@ -53,6 +53,9 @@ struct Coroutine {
> >  
> >      /* Only used when the coroutine has yielded.  */
> >      AioContext *ctx;
> > +
> > +    int scheduled;
> 
> s/int/bool/
> 

OK.

> > diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> > index d6095c1..2edab63 100644
> > --- a/util/qemu-coroutine.c
> > +++ b/util/qemu-coroutine.c
> > @@ -109,6 +109,15 @@ void qemu_aio_coroutine_enter(AioContext *ctx, Coroutine *co)
> >  
> >      trace_qemu_aio_coroutine_enter(ctx, self, co, co->entry_arg);
> >  
> > +    /* if the Coroutine has already been scheduled, entering it again will
> > +     * cause us to enter it twice, potentially even after the coroutine has
> > +     * been deleted */
> > +    if (co->scheduled == 1) {
> > +        fprintf(stderr, "Cannot enter a co-routine that has already "
> > +                        "been scheduled to run in a different AioContext\n");
> 
> This error message is too specific, the AioContext doesn't have to be
> different from the current one:
> 
> block/blkdebug.c:        aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
> 
> If something calls qemu_aio_coroutine_enter() on the coroutine it might
> be from the same AioContext - but still an error condition worth failing
> loudly on.
> 

Good point.


> I suggest simplifying the error message:
> 
>   fprintf(stderr, "Cannot enter a co-routine that has already "
>                   "been scheduled\n");

OK. I'll also change the wording here to what you have above, as well:

  void aio_co_schedule(AioContext *ctx, Coroutine *co)
  {
       trace_aio_co_schedule(ctx, co);
  +    if (co->scheduled == 1) {
  +        fprintf(stderr,
  +                "Cannot schedule a co-routine that is already scheduled\n");
  +        abort();
  +    }
  +    co->scheduled = 1;
       QSLIST_INSERT_HEAD_ATOMIC(&ctx->scheduled_coroutines,
                                 co, co_scheduled_next);


Jeff
