Received: from eggs.gnu.org ([2001:4830:134:3::10]:43614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d020Q-0004GO-Rf
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 04:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d020P-0003ii-Uk
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 04:27:30 -0400
Date: Mon, 17 Apr 2017 16:27:19 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170417082719.GC13582@lemon.lan>
References: <20170414080206.2301-1-famz@redhat.com>
	<CAJSP0QVbYRW0VD_1zUqU0T6V48wr_g3co8Dxs_ndpfA70d4TkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QVbYRW0VD_1zUqU0T6V48wr_g3co8Dxs_ndpfA70d4TkQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.9-rc5 v2] block: Drain
 BH in bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, 04/14 09:51, Stefan Hajnoczi wrote:
> On Fri, Apr 14, 2017 at 9:02 AM, Fam Zheng <famz@redhat.com> wrote:
> > @@ -398,11 +399,15 @@ void bdrv_drain_all(void);
> >           */                                                \
> >          assert(!bs_->wakeup);                              \
> >          bs_->wakeup = true;                                \
> > -        while ((cond)) {                                   \
> > -            aio_context_release(ctx_);                     \
> > -            aio_poll(qemu_get_aio_context(), true);        \
> > -            aio_context_acquire(ctx_);                     \
> > -            waited_ = true;                                \
> > +        while (busy_) {                                    \
> > +            if ((cond)) {                                  \
> > +                waited_ = busy_ = true;                    \
> > +                aio_context_release(ctx_);                 \
> > +                aio_poll(qemu_get_aio_context(), true);    \
> > +                aio_context_acquire(ctx_);                 \
> > +            } else {                                       \
> > +                busy_ = aio_poll(ctx_, false);             \
> > +            }                                              \
> 
> Wait, I'm confused.  The current thread is not in the BDS AioContext.
> We're not allowed to call aio_poll(ctx_, false).
> 
> Did you mean aio_poll(qemu_get_aio_context(), false) in order to
> process defer to main loop BHs?

At this point it's even unclear to me what should be the plan for 2.9.  v1 IMO
was the least intrusive, but didn't cover bdrv_drain_all_begin. v2 has this
controversial "aio_poll(ctx_, false)", however its alternative,
"aio_poll(qemu_get_aio_context(), false)", "introduces" another crash that is
not seen otherwise.

What should we do now?

Fam
