Received: from eggs.gnu.org ([2001:4830:134:3::10]:46488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUX3h-0005O9-Vy
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUX3e-0006Bd-18
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:40:58 -0400
Date: Mon, 10 Jul 2017 13:40:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170710114048.GC5772@noname.redhat.com>
References: <1496857819-12466-1-git-send-email-kwolf@redhat.com>
	<1496857819-12466-6-git-send-email-kwolf@redhat.com>
	<CAFEAcA-zObhNAR7iuQZ0MH7-ng86m2XEik8bie3o4THEbLwcVA@mail.gmail.com>
	<20170613164628.GG4383@noname.redhat.com>
	<CAFEAcA-GcwUz0UMJE-chqewQ3X6=ZD6NygywF6w-3J7sG7QzbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-GcwUz0UMJE-chqewQ3X6=ZD6NygywF6w-3J7sG7QzbA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 5/8] commit: Fix use after free in completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Am 09.07.2017 um 19:09 hat Peter Maydell geschrieben:
> On 13 June 2017 at 17:46, Kevin Wolf <kwolf@redhat.com> wrote:
> > Am 13.06.2017 um 18:12 hat Peter Maydell geschrieben:
> >> On 7 June 2017 at 18:50, Kevin Wolf <kwolf@redhat.com> wrote:
> >> > diff --git a/block/commit.c b/block/commit.c
> >> > index a3028b2..af6fa68 100644
> >> > --- a/block/commit.c
> >> > +++ b/block/commit.c
> >> > @@ -89,6 +89,10 @@ static void commit_complete(BlockJob *job, void *opaque)
> >> >      int ret = data->ret;
> >> >      bool remove_commit_top_bs = false;
> >> >
> >> > +    /* Make sure overlay_bs and top stay around until bdrv_set_backing_hd() */
> >> > +    bdrv_ref(top);
> >> > +    bdrv_ref(overlay_bs);
> >> > +
> >> >      /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
> >> >       * the normal backing chain can be restored. */
> >> >      blk_unref(s->base);
> >>
> >> Hi -- coverity complains about this change, because bdrv_ref()
> >> assumes that its argument is not NULL, but later on in commit_complete()
> >> we have a check
> >>     "if (overlay_bs && ...)"
> >> which assumes its argument might be NULL. (CID 1376205)
> >>
> >> Which is correct?
> >
> > I saw the Coverity report and am looking into it. It's not completely
> > clear to me yet which is correct, but I suspect it can be NULL.
> 
> Just a nudge on this one -- I don't think there's been a patch sent
> to the list for this check-after-use ?
> 
> (It's one of just 7 coverity issues left which haven't had at least
> a patch sent to the list now...)

As far as I can tell, this can't currently be triggered. I intended to
fix it with some work on the commit block job that I need to do anyway,
and which would potentially enable a way to trigger it. But it turned
out that this is a bit more complicated than I thought.

So maybe I'd better just post a very small patch that silences Coverity
(without making a practical difference) until I can finish the real
thing.

Kevin
