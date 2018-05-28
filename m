Received: from eggs.gnu.org ([2001:4830:134:3::10]:54133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNGLV-0002mC-51
	for qemu-devel@nongnu.org; Mon, 28 May 2018 07:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNGLQ-00026L-BA
	for qemu-devel@nongnu.org; Mon, 28 May 2018 07:29:49 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:50393)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fNGLQ-00021Y-1p
	for qemu-devel@nongnu.org; Mon, 28 May 2018 07:29:44 -0400
Received: from player731.ha.ovh.net (unknown [10.109.120.14])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 3624D13964F
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 13:29:35 +0200 (CEST)
Date: Mon, 28 May 2018 13:29:28 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180528132928.0a623a38@bahia.lan>
In-Reply-To: <20180525140246.GD5562@localhost.localdomain>
References: <152720243501.517758.270483838608061631.stgit@bahia.lan>
	<20180525083715.GC5562@localhost.localdomain>
	<20180525135303.365775c8@bahia.lan>
	<20180525140246.GD5562@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] block: fix QEMU crash with scsi-hd and
 drive_del
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org

On Fri, 25 May 2018 16:02:46 +0200
Kevin Wolf <kwolf@redhat.com> wrote:

> Am 25.05.2018 um 13:53 hat Greg Kurz geschrieben:
> > On Fri, 25 May 2018 10:37:15 +0200
> > Kevin Wolf <kwolf@redhat.com> wrote:
> >   
> > > Am 25.05.2018 um 00:53 hat Greg Kurz geschrieben:  
> > > > Removing a drive with drive_del while it is being used to run an I/O
> > > > intensive workload can cause QEMU to crash.
> > > > 
> > > > An AIO flush can yield at some point:
> > > > 
> > > > blk_aio_flush_entry()
> > > >  blk_co_flush(blk)
> > > >   bdrv_co_flush(blk->root->bs)
> > > >    ...
> > > >     qemu_coroutine_yield()
> > > > 
> > > > and let the HMP command to run, free blk->root and give control
> > > > back to the AIO flush:
> > > > 
> > > >     hmp_drive_del()
> > > >      blk_remove_bs()
> > > >       bdrv_root_unref_child(blk->root)
> > > >        child_bs = blk->root->bs
> > > >        bdrv_detach_child(blk->root)
> > > >         bdrv_replace_child(blk->root, NULL)
> > > >          blk->root->bs = NULL
> > > >         g_free(blk->root) <============== blk->root becomes stale
> > > >        bdrv_unref(child_bs)
> > > >         bdrv_delete(child_bs)
> > > >          bdrv_close()
> > > >           bdrv_drained_begin()
> > > >            bdrv_do_drained_begin()
> > > >             bdrv_drain_recurse()
> > > >              aio_poll()
> > > >               ...
> > > >               qemu_coroutine_switch()
> > > > 
> > > > and the AIO flush completion ends up dereferencing blk->root:
> > > > 
> > > >   blk_aio_complete()
> > > >    scsi_aio_complete()
> > > >     blk_get_aio_context(blk)
> > > >      bs = blk_bs(blk)
> > > >  ie, bs = blk->root ? blk->root->bs : NULL
> > > >             ^^^^^
> > > >             stale
> > > > 
> > > > The problem is that we should avoid making block driver graph
> > > > changes while we have in-flight requests. This patch hence adds
> > > > a drained section to bdrv_detach_child(), so that we're sure
> > > > all requests have been drained before blk->root becomes stale.
> > > > 
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---
> > > > v3: - start drained section before modifying the graph (Stefan)
> > > > 
> > > > v2: - drain I/O requests when detaching the BDS (Stefan, Paolo)
> > > > ---
> > > >  block.c |    4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git a/block.c b/block.c
> > > > index 501b64c8193f..715c1b56c1e2 100644
> > > > --- a/block.c
> > > > +++ b/block.c
> > > > @@ -2127,12 +2127,16 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
> > > >  
> > > >  static void bdrv_detach_child(BdrvChild *child)
> > > >  {
> > > > +    BlockDriverState *child_bs = child->bs;
> > > > +
> > > > +    bdrv_drained_begin(child_bs);
> > > >      if (child->next.le_prev) {
> > > >          QLIST_REMOVE(child, next);
> > > >          child->next.le_prev = NULL;
> > > >      }
> > > >  
> > > >      bdrv_replace_child(child, NULL);
> > > > +    bdrv_drained_end(child_bs);
> > > >  
> > > >      g_free(child->name);
> > > >      g_free(child);    
> > > 
> > > I wonder if the better fix would be calling blk_drain() in
> > > blk_remove_bs() (which would also better be blk_drained_begin/end...).
> > >   
> > 
> > Hmm... would blk_drain() in blk_remove_bs() ensure we don't have
> > any new activity until the BDS and BB are actually dissociated ?
> > 
> > ie, something like the following ?
> > 
> > +    blk_drain(blk);
> >      bdrv_root_unref_child(blk->root);
> >      blk->root = NULL;  
> 
> I think that should be enough, as long as we hold the AioContext lock.
> In theory, callers should hold it, but I'm not sure if it's always true.

Most users of blk_remove_bs() do explicitely call aio_context_acquire(),
but not all... especially blk_unref()->blk_delete(), which has itself
a lot of users, but...

> If we're in a drain_begin/end section (rather than just after a drain),
> that might be less important because AioContext events are disabled
> then.
> 

... blk_remove_bs() already calls bdrv_drained_begin()/bdrv_drained_end()
to ensure I/O completion before removing throttle timers. It seems to
indicate that the AIO context is always acquired before calling this
function, correct ?

> Well, actually, if they didn't hold it, any drain would crash, at least
> when there still is some activity.
> 
> > because we can't do anything like:
> > 
> > +    bdrv_drained_begin(blk_bs(blk));
> >      bdrv_root_unref_child(blk->root);
> > +    bdrv_drained_begin(blk_bs(blk));
> >      blk->root = NULL;
> > 
> > since g_free(blk->root) gets called from under bdrv_root_unref_child()
> > at some point.  
> 
> If that's the problem, I guess we could do something like this (even
> though it's a bit ugly):
> 
>     bs = blk_bs(blk);
>     bdrv_ref(bs);
>     bdrv_drained_begin(bs);
>     bdrv_root_unref_child(blk->root)
>     bdrv_drained_end(bs)
>     bdrv_unref(bs)
> 
> This assumes that we're in the main thread, but that should always be
> the case for blk_remove_bs().
> 

Again, this is true for most users, but I'm not sure in the case this
is called from blk_unref()->blk_delete(). This being said, we already
have bdrv_root_unref_child()->bdrv_unref(), ie, it is already assumed
that this is called from the mainloop, isn't it ?

> > > Doing the proposed change in bdrv_detach_child() should fix the problem
> > > that you're seeing, but at first sight it promises that callers don't
> > > have to care about shutting down their activity on the child node first.
> > > This isn't necessarily correct if the parent may still issue a new
> > > request (e.g. in response to the completion of an old one). What really
> > > needs to be drained is the parent's use of the child, not the activity
> > > of the child.
> > >   
> > 
> > I was thinking of:
> > 
> >  void bdrv_root_unref_child(BdrvChild *child)
> >  {
> >      BlockDriverState *child_bs;
> >  
> >      child_bs = child->bs;
> > +    bdrv_drained_begin(child_bs);
> >      bdrv_detach_child(child);
> > +    bdrv_drained_end(child_bs);
> >      bdrv_unref(child_bs);
> >  }
> > 
> > but both Paolo and Stefan suggested to move it to bdrv_detach_child().
> > 
> > Is this what you're suggesting ?  
> 
> No, the change in blk_remove_bs() is what I meant. If we can't do that,
> I'd agree that bdrv_detach_child() is the second best thing.
> 

Unless I got it wrong, it seems that we can either call blk_drain()
or add a drained section with the bdrv_ref()/unref() dance you
suggested above. I guess the former is nicer.

> > > Another minor problem with your approach: If a child node is used by
> > > more than one parent, this patch would unnecessarily quiesce those other
> > > parents and wait for the completion of their requests.
> > >   
> > 
> > Oh... I hadn't realized. Blame my limited knowledge of the block layer :)  
> 
> I just realised that the way blk_drain* are implemented, you'll do this
> either way, so disregard this point for now...
> 

Ok.

> Kevin

Thanks,

--
Greg
