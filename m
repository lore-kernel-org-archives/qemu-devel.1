Received: from eggs.gnu.org ([2001:4830:134:3::10]:38220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNmN4-00030k-Su
	for qemu-devel@nongnu.org; Tue, 29 May 2018 17:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNmN2-0007iX-AG
	for qemu-devel@nongnu.org; Tue, 29 May 2018 17:41:34 -0400
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:52282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fNmN2-0007em-3G
	for qemu-devel@nongnu.org; Tue, 29 May 2018 17:41:32 -0400
Received: from player735.ha.ovh.net (unknown [10.109.108.46])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 4F68E184FB
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 23:41:30 +0200 (CEST)
Date: Tue, 29 May 2018 23:41:22 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180529234122.7cbebcc8@bahia.lan>
In-Reply-To: <20180529201917.GL4756@localhost.localdomain>
References: <152750903916.663961.9369851345277129751.stgit@bahia.lan>
	<20180529201917.GL4756@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] block: fix QEMU crash with scsi-hd and
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org, qemu-block@nongnu.org

On Tue, 29 May 2018 22:19:17 +0200
Kevin Wolf <kwolf@redhat.com> wrote:

> Am 28.05.2018 um 14:03 hat Greg Kurz geschrieben:
> > Removing a drive with drive_del while it is being used to run an I/O
> > intensive workload can cause QEMU to crash.
> > 
> > An AIO flush can yield at some point:
> > 
> > blk_aio_flush_entry()
> >  blk_co_flush(blk)
> >   bdrv_co_flush(blk->root->bs)
> >    ...
> >     qemu_coroutine_yield()
> > 
> > and let the HMP command to run, free blk->root and give control
> > back to the AIO flush:
> > 
> >     hmp_drive_del()
> >      blk_remove_bs()
> >       bdrv_root_unref_child(blk->root)
> >        child_bs = blk->root->bs
> >        bdrv_detach_child(blk->root)
> >         bdrv_replace_child(blk->root, NULL)
> >          blk->root->bs = NULL
> >         g_free(blk->root) <============== blk->root becomes stale
> >        bdrv_unref(child_bs)
> >         bdrv_delete(child_bs)
> >          bdrv_close()
> >           bdrv_drained_begin()
> >            bdrv_do_drained_begin()
> >             bdrv_drain_recurse()
> >              aio_poll()
> >               ...
> >               qemu_coroutine_switch()
> > 
> > and the AIO flush completion ends up dereferencing blk->root:
> > 
> >   blk_aio_complete()
> >    scsi_aio_complete()
> >     blk_get_aio_context(blk)
> >      bs = blk_bs(blk)
> >  ie, bs = blk->root ? blk->root->bs : NULL
> >             ^^^^^
> >             stale
> > 
> > The problem is that we should avoid making block driver graph
> > changes while we have in-flight requests. Let's drain all I/O
> > for this BB before calling bdrv_root_unref_child().
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>  
> 
> Hmm... It sounded convincing, but 'make check-tests/test-replication'
> fails now. The good news is that with the drain fixes, for which I sent
> v2 today, it passes, so instead of staging it in my block branch, I'll
> put it at the end of my branch for the drain fixes.
> 
> Might take a bit longer than planned until it's in master, sorry.
> 
> Kevin

Works for me :)

Thanks !

--
Greg
