Received: from eggs.gnu.org ([2001:4830:134:3::10]:47774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNl5e-00078m-Iw
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNl5d-0007XL-LC
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:19:30 -0400
Date: Tue, 29 May 2018 22:19:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180529201917.GL4756@localhost.localdomain>
References: <152750903916.663961.9369851345277129751.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152750903916.663961.9369851345277129751.stgit@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org, qemu-block@nongnu.org

Am 28.05.2018 um 14:03 hat Greg Kurz geschrieben:
> Removing a drive with drive_del while it is being used to run an I/O
> intensive workload can cause QEMU to crash.
> 
> An AIO flush can yield at some point:
> 
> blk_aio_flush_entry()
>  blk_co_flush(blk)
>   bdrv_co_flush(blk->root->bs)
>    ...
>     qemu_coroutine_yield()
> 
> and let the HMP command to run, free blk->root and give control
> back to the AIO flush:
> 
>     hmp_drive_del()
>      blk_remove_bs()
>       bdrv_root_unref_child(blk->root)
>        child_bs = blk->root->bs
>        bdrv_detach_child(blk->root)
>         bdrv_replace_child(blk->root, NULL)
>          blk->root->bs = NULL
>         g_free(blk->root) <============== blk->root becomes stale
>        bdrv_unref(child_bs)
>         bdrv_delete(child_bs)
>          bdrv_close()
>           bdrv_drained_begin()
>            bdrv_do_drained_begin()
>             bdrv_drain_recurse()
>              aio_poll()
>               ...
>               qemu_coroutine_switch()
> 
> and the AIO flush completion ends up dereferencing blk->root:
> 
>   blk_aio_complete()
>    scsi_aio_complete()
>     blk_get_aio_context(blk)
>      bs = blk_bs(blk)
>  ie, bs = blk->root ? blk->root->bs : NULL
>             ^^^^^
>             stale
> 
> The problem is that we should avoid making block driver graph
> changes while we have in-flight requests. Let's drain all I/O
> for this BB before calling bdrv_root_unref_child().
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Hmm... It sounded convincing, but 'make check-tests/test-replication'
fails now. The good news is that with the drain fixes, for which I sent
v2 today, it passes, so instead of staging it in my block branch, I'll
put it at the end of my branch for the drain fixes.

Might take a bit longer than planned until it's in master, sorry.

Kevin
