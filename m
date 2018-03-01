Received: from eggs.gnu.org ([2001:4830:134:3::10]:39599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1erEIb-0004v4-5N
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 21:50:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1erEIZ-0004DV-Ek
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 21:50:25 -0500
Date: Thu, 1 Mar 2018 10:50:04 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180301025004.GJ21336@lemon.usersys.redhat.com>
References: <20180122220806.22154-1-mreitz@redhat.com>
	<20180122220806.22154-6-mreitz@redhat.com>
	<20180227074413.GB21035@lemon.usersys.redhat.com>
	<2c81d46d-434d-d9bb-86b4-9a644bf0284a@redhat.com>
	<9ce789eb-89b9-4a16-087e-977673d2c717@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ce789eb-89b9-4a16-087e-977673d2c717@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 05/16] block/mirror: Convert to
 coroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, 02/28 18:07, Max Reitz wrote:
> On 2018-02-28 15:13, Max Reitz wrote:
> > On 2018-02-27 08:44, Fam Zheng wrote:
> >> On Mon, 01/22 23:07, Max Reitz wrote:
> >>> @@ -101,7 +105,7 @@ static BlockErrorAction mirror_error_action(MirrorBlockJob *s, bool read,
> >>>      }
> >>>  }
> >>>  
> >>> -static void mirror_iteration_done(MirrorOp *op, int ret)
> >>> +static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret)
> >>>  {
> >>>      MirrorBlockJob *s = op->s;
> >>>      struct iovec *iov;
> >>
> >> I think we want s/qemu_coroutine_enter/aio_co_wake/ in mirror_iteration_done().
> >> As an AIO callback before, this didn't matter, but now we are in an terminating
> >> coroutine, so it is pointless to defer the termination, or even risky in that we
> >> are in a aio_context_acquire/release section, but have already decremented
> >> s->in_flight, which is fishy.
> > 
> > I guess I'll still do the replacement, regardless of whether the next
> > patch overwrites it again...
> 
> Maybe I don't.  Doing this breaks iotest 041 because the
> assert(data.done) in bdrv_co_yield_to_drain() fails.
> 
> Not sure why that is, but under the circumstance I guess it's best to
> just pretend this never happened, continue to use qemu_coroutine_enter()
> and just replace it in the next patch.
> 
> As for in_flight: What is the issue there?  We mostly need that to know
> how many I/O requests are actually running, that is, how much buffer
> space is used, how many I/O is done concurrently, etc. (and later we
> need the in-flight information so that we don't access the target in
> overlapping areas concurrently).  But it doesn't seem to be about how
> many coroutines there are.
> 
> So as long as the s->in_flight decrement is done in the same critical
> section as the op is deleted, we should be good...?

I don't have a specific problem in my mind but is just generally concerned about
the "if (s->in_flight == 0)" checks around mirror_exit.

Fam
