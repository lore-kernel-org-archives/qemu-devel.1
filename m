Received: from eggs.gnu.org ([2001:4830:134:3::10]:50258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fIzgE-0006um-LX
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fIzgA-0004Lr-Kb
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:53:34 -0400
Received: from 7.mo1.mail-out.ovh.net ([87.98.158.110]:43122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fIzgA-0004L5-E4
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:53:30 -0400
Received: from player696.ha.ovh.net (unknown [10.109.122.86])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 6F1C8F7857
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 18:53:28 +0200 (CEST)
Date: Wed, 16 May 2018 18:53:22 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180516185322.17556153@bahia.lan>
In-Reply-To: <152646971421.34839.18198173866060880395.stgit@bahia.lan>
References: <152646971421.34839.18198173866060880395.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

Heh, of course I meant qemu-stable@nongnu.org ;)

On Wed, 16 May 2018 13:21:54 +0200
Greg Kurz <groug@kaod.org> wrote:

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
> The use-after-free condition is easy to reproduce with a stress-ng
> run in the guest:
> 
> -device virtio-scsi-pci,id=scsi1 \
> -drive file=/home/greg/images/scratch.qcow2,format=qcow2,if=none,id=drive1 \
> -device scsi-hd,bus=scsi1.0,drive=drive1,id=scsi-hd1
> 
> # stress-ng --hdd 0 --aggressive
> 
> and doing drive_del from the QEMU monitor while stress-ng is still running:
> 
> (qemu) drive_del drive1
> 
> The crash is less easy to hit though, as it depends on the bs field
> of the stale blk->root to have a non-NULL value that eventually breaks
> something when it gets dereferenced. The following patch simulates
> that, and allows to validate the fix:
> 
>  --- a/block.c
>  +++ b/block.c
>  @@ -2127,6 +2127,8 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
> 
>  static void bdrv_detach_child(BdrvChild *child)
>  {
> +    BlockDriverState *bs = child->bs;
> +
>      if (child->next.le_prev) {
>          QLIST_REMOVE(child, next);
>          child->next.le_prev = NULL;
>  @@ -2135,7 +2137,15 @@ static void bdrv_detach_child(BdrvChild *child)
>      bdrv_replace_child(child, NULL);
> 
>      g_free(child->name);
> -    g_free(child);
> +    /* Poison the BdrvChild instead of freeing it, in order to break blk_bs()
> +     * if the blk still has a pointer to this BdrvChild in blk->root.
> +     */
> +    if (atomic_read(&bs->in_flight)) {
> +        child->bs = (BlockDriverState *) -1;
> +        fprintf(stderr, "\nPoisonned BdrvChild %p\n", child);
> +    } else {
> +        g_free(child);
> +    }
>  }
> 
>  void bdrv_root_unref_child(BdrvChild *child)
> ---
>  block/block-backend.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 681b240b1268..ed9434e236b9 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -756,6 +756,7 @@ void blk_remove_bs(BlockBackend *blk)
>  {
>      ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
>      BlockDriverState *bs;
> +    BdrvChild *root;
>  
>      notifier_list_notify(&blk->remove_bs_notifiers, blk);
>      if (tgm->throttle_state) {
> @@ -768,8 +769,9 @@ void blk_remove_bs(BlockBackend *blk)
>  
>      blk_update_root_state(blk);
>  
> -    bdrv_root_unref_child(blk->root);
> +    root = blk->root;
>      blk->root = NULL;
> +    bdrv_root_unref_child(root);
>  }
>  
>  /*
> 
> 
