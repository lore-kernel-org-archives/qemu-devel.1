Received: from eggs.gnu.org ([2001:4830:134:3::10]:37709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=B6TO=ID=linuxfoundation.org=gregkh@kernel.org>)
	id 1fIyYY-0001MX-AG
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=B6TO=ID=linuxfoundation.org=gregkh@kernel.org>)
	id 1fIyYU-0007NP-9h
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <SRS0=B6TO=ID=linuxfoundation.org=gregkh@kernel.org>)
	id 1fIyYU-0007N4-1t
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:41:30 -0400
Date: Wed, 16 May 2018 17:41:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Message-ID: <20180516154110.GE23725@kroah.com>
References: <152646971421.34839.18198173866060880395.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152646971421.34839.18198173866060880395.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] block: fix QEMU crash with scsi-hd and
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, stable@vger.kernel.org

On Wed, May 16, 2018 at 01:21:54PM +0200, Greg Kurz wrote:
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
> The solution to this user-after-free situation is is to clear
> blk->root before calling bdrv_unref() in bdrv_detach_child(),
> and let blk_get_aio_context() fall back to the main loop context
> since the BDS has been removed.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> 


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
