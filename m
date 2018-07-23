Received: from eggs.gnu.org ([2001:4830:134:3::10]:57271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhbCg-0005za-GN
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhbCf-00078B-CP
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:48:46 -0400
Date: Mon, 23 Jul 2018 15:48:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180723134835.GD8817@localhost.localdomain>
References: <152750903916.663961.9369851345277129751.stgit@bahia.lan>
	<20180529201917.GL4756@localhost.localdomain>
	<153194807266.31213.16487908209652714185@sif>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153194807266.31213.16487908209652714185@sif>
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH v4] block: fix QEMU crash
 with scsi-hd and drive_del
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-block@nongnu.org, qemu-stable@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 18.07.2018 um 23:07 hat Michael Roth geschrieben:
> Quoting Kevin Wolf (2018-05-29 15:19:17)
> > Am 28.05.2018 um 14:03 hat Greg Kurz geschrieben:
> > > Removing a drive with drive_del while it is being used to run an I/O
> > > intensive workload can cause QEMU to crash.
> > > 
> > > An AIO flush can yield at some point:
> > > 
> > > blk_aio_flush_entry()
> > >  blk_co_flush(blk)
> > >   bdrv_co_flush(blk->root->bs)
> > >    ...
> > >     qemu_coroutine_yield()
> > > 
> > > and let the HMP command to run, free blk->root and give control
> > > back to the AIO flush:
> > > 
> > >     hmp_drive_del()
> > >      blk_remove_bs()
> > >       bdrv_root_unref_child(blk->root)
> > >        child_bs = blk->root->bs
> > >        bdrv_detach_child(blk->root)
> > >         bdrv_replace_child(blk->root, NULL)
> > >          blk->root->bs = NULL
> > >         g_free(blk->root) <============== blk->root becomes stale
> > >        bdrv_unref(child_bs)
> > >         bdrv_delete(child_bs)
> > >          bdrv_close()
> > >           bdrv_drained_begin()
> > >            bdrv_do_drained_begin()
> > >             bdrv_drain_recurse()
> > >              aio_poll()
> > >               ...
> > >               qemu_coroutine_switch()
> > > 
> > > and the AIO flush completion ends up dereferencing blk->root:
> > > 
> > >   blk_aio_complete()
> > >    scsi_aio_complete()
> > >     blk_get_aio_context(blk)
> > >      bs = blk_bs(blk)
> > >  ie, bs = blk->root ? blk->root->bs : NULL
> > >             ^^^^^
> > >             stale
> > > 
> > > The problem is that we should avoid making block driver graph
> > > changes while we have in-flight requests. Let's drain all I/O
> > > for this BB before calling bdrv_root_unref_child().
> > > 
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > 
> > Hmm... It sounded convincing, but 'make check-tests/test-replication'
> > fails now. The good news is that with the drain fixes, for which I sent
> > v2 today, it passes, so instead of staging it in my block branch, I'll
> > put it at the end of my branch for the drain fixes.
> > 
> > Might take a bit longer than planned until it's in master, sorry.
> 
> I'm getting the below test-replication failure/trace trying to backport
> this patch for 2.12.1 (using this tree:
> https://github.com/mdroth/qemu/commits/stable-2.12-staging-f45280cbf)
> 
> Is this the same issue you saw, and if so, are the drain fixes
> appropriate for 2.12.x? Are there other prereqs/follow-ups you're
> aware of that would also be needed?

I'm not completely sure any more, but yes, I think this might have been
the one. My rework of the bdrv_drain_*() functions fixed quite a few
bugs, including this one, but the work done since 2.12 is two rather
long and quite intrusive series, so I'm not sure if backporting them for
2.12.1 is a good idea.

Kevin
