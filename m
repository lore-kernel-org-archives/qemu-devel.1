Received: from eggs.gnu.org ([2001:4830:134:3::10]:40359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>)
	id 1fLrlE-000164-LZ
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>)
	id 1fLrl9-0006gr-Qn
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:02:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>)
	id 1fLrl9-0006fm-KW
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:02:31 -0400
Date: Thu, 24 May 2018 17:02:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Message-ID: <20180524150212.GB14124@kroah.com>
References: <152715298769.397287.11782572103987618822.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152715298769.397287.11782572103987618822.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v2] block: fix QEMU crash with scsi-hd and
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, stable@vger.kernel.org

On Thu, May 24, 2018 at 11:09:47AM +0200, Greg Kurz wrote:
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
> changes while we have in-flight requests. This patch hence adds
> a drained section to bdrv_detach_child(), so that we're sure
> all requests have been drained when blk->root is freed.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - drain I/O requests when detaching the BDS (Stefan, Paolo)
> ---
>  block.c |    4 ++++
>  1 file changed, 4 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
