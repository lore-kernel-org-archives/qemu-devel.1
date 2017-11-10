Received: from eggs.gnu.org ([2001:4830:134:3::10]:49549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eD9CD-0002wH-Qf
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eD9CC-0002id-Ju
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:18:09 -0500
Date: Fri, 10 Nov 2017 14:17:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171110131752.GD5466@localhost.localdomain>
References: <20171109204315.27072-1-mreitz@redhat.com>
	<20171110024557.GB4849@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171110024557.GB4849@lemon>
Subject: Re: [Qemu-devel] [PATCH for-2.11] block: Keep strong reference when
 draining all BDS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Am 10.11.2017 um 03:45 hat Fam Zheng geschrieben:
> On Thu, 11/09 21:43, Max Reitz wrote:
> > Draining a BDS may lead to graph modifications, which in turn may result
> > in it and other BDS being stripped of their current references.  If
> > bdrv_drain_all_begin() and bdrv_drain_all_end() do not keep strong
> > references themselves, the BDS they are trying to drain (or undrain) may
> > disappear right under their feet -- or, more specifically, under the
> > feet of BDRV_POLL_WHILE() in bdrv_drain_recurse().
> > 
> > This fixes an occasional hang of iotest 194.
> > 
> > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > ---
> >  block/io.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 44 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/io.c b/block/io.c
> > index 3d5ef2cabe..a0a2833e8e 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -340,7 +340,10 @@ void bdrv_drain_all_begin(void)
> >      bool waited = true;
> >      BlockDriverState *bs;
> >      BdrvNextIterator it;
> > -    GSList *aio_ctxs = NULL, *ctx;
> > +    GSList *aio_ctxs = NULL, *ctx, *bs_list = NULL, *bs_list_entry;
> > +
> > +    /* Must be called from the main loop */
> > +    assert(qemu_get_current_aio_context() == qemu_get_aio_context());
> >  
> >      block_job_pause_all();
> >  
> > @@ -355,6 +358,12 @@ void bdrv_drain_all_begin(void)
> >          if (!g_slist_find(aio_ctxs, aio_context)) {
> >              aio_ctxs = g_slist_prepend(aio_ctxs, aio_context);
> >          }
> > +
> > +        /* Keep a strong reference to all root BDS and copy them into
> > +         * an own list because draining them may lead to graph
> > +         * modifications. */
> > +        bdrv_ref(bs);
> > +        bs_list = g_slist_prepend(bs_list, bs);
> >      }
> >  
> >      /* Note that completion of an asynchronous I/O operation can trigger any
> > @@ -370,7 +379,11 @@ void bdrv_drain_all_begin(void)
> >              AioContext *aio_context = ctx->data;
> >  
> >              aio_context_acquire(aio_context);
> > -            for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
> > +            for (bs_list_entry = bs_list; bs_list_entry;
> > +                 bs_list_entry = bs_list_entry->next)
> > +            {
> > +                bs = bs_list_entry->data;
> > +
> >                  if (aio_context == bdrv_get_aio_context(bs)) {
> >                      waited |= bdrv_drain_recurse(bs, true);
> >                  }
> > @@ -379,24 +392,52 @@ void bdrv_drain_all_begin(void)
> >          }
> >      }
> >  
> > +    for (bs_list_entry = bs_list; bs_list_entry;
> > +         bs_list_entry = bs_list_entry->next)
> > +    {
> > +        bdrv_unref(bs_list_entry->data);
> > +    }
> > +
> >      g_slist_free(aio_ctxs);
> > +    g_slist_free(bs_list);
> >  }
> >  
> >  void bdrv_drain_all_end(void)
> >  {
> >      BlockDriverState *bs;
> >      BdrvNextIterator it;
> > +    GSList *bs_list = NULL, *bs_list_entry;
> > +
> > +    /* Must be called from the main loop */
> > +    assert(qemu_get_current_aio_context() == qemu_get_aio_context());
> >  
> > +    /* Keep a strong reference to all root BDS and copy them into an
> > +     * own list because draining them may lead to graph modifications.
> > +     */
> >      for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
> > -        AioContext *aio_context = bdrv_get_aio_context(bs);
> > +        bdrv_ref(bs);
> > +        bs_list = g_slist_prepend(bs_list, bs);
> > +    }
> > +
> > +    for (bs_list_entry = bs_list; bs_list_entry;
> > +         bs_list_entry = bs_list_entry->next)
> > +    {
> > +        AioContext *aio_context;
> > +
> > +        bs = bs_list_entry->data;
> > +        aio_context = bdrv_get_aio_context(bs);
> >  
> >          aio_context_acquire(aio_context);
> >          aio_enable_external(aio_context);
> >          bdrv_parent_drained_end(bs);
> >          bdrv_drain_recurse(bs, false);
> >          aio_context_release(aio_context);
> > +
> > +        bdrv_unref(bs);
> >      }
> >  
> > +    g_slist_free(bs_list);
> > +
> >      block_job_resume_all();
> >  }
> 
> It is better to put the references into BdrvNextIterator and introduce
> bdrv_next_iterator_destroy() to free them? You'll need to touch all callers
> because it is not C++, but it secures all of rest, which seems vulnerable in the
> same pattern, for example the aio_poll() in iothread_stop_all().

You could automatically free the references when bdrv_next() returns
NULL. Then you need an explicit bdrv_next_iterator_destroy() only for
callers that stop iterating halfway through the list.

Do you actually need to keep references to all BDSes in the whole list
while using the iterator or would it be enough to just keep a reference
to the current one?

Kevin
