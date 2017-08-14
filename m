Received: from eggs.gnu.org ([2001:4830:134:3::10]:41650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhFxq-0004zr-CR
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhFxp-0004EP-4w
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:03:30 -0400
Date: Mon, 14 Aug 2017 22:03:15 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170814140315.GA9457@lemon>
References: <CAATJJ0Jgyak9c=wYknret5y=yjfzcjiVw3221wX=SB2+am8H4A@mail.gmail.com>
	<20170811120435.GB23309@lemon.lan>
	<20170811123716.GD4162@localhost.localdomain>
	<CAATJJ0+R-S8F4FhYUXCRjPrduK4szwFMrj+LTUFPuyPzmauuNw@mail.gmail.com>
	<20170811164854.GG4162@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170811164854.GG4162@localhost.localdomain>
Subject: Re: [Qemu-devel] migration issue with qemu 2.10-rc2: QEMU command
 'nbd-server-add': Block node is read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Fri, 08/11 18:48, Kevin Wolf wrote:
> The patch below implements what I was thinking of, and it seems to fix
> this problem. However, you'll immediately run into the next one, which
> is a message like 'Conflicts with use by ide0-hd0 as 'root', which does
> not allow 'write' on #block172'.
> 
> The reason for this is that since commit 4417ab7adf1,
> bdrv_invalidate_cache() not only activates the image, but also is the
> signal for guest device BlockBackends that migration has completed and
> they should now request exclusive access to the image.
> 
> As the NBD server shows, this assumption is wrong. Images can be
> activated even before migration completes. Maybe this really needs to
> be done in a VM state change handler.
> 
> We can't simply revert commit 4417ab7adf1 because for image file
> locking, it is important that we drop locks for inactive images, so
> BdrvChildRole.activate/inactivate will probably stay. Maybe only one
> bool blk->disable_perm isn't enough, we might need a different one for
> devices before migration completed, or at least a counter.

I'll make your diff a formal patch and add a VM state change handler for 2.10.

I'm not very confident with a counter because it's not obviour to me that
inactivate/activate pairs are always balanced.

> 
> I'll be on vacation starting tomorrow, so someone else needs to tackle
> this. Fam, I think you are relatively familiar with the op blockers?
> 
> Kevin
> 
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 82a78bf439..b68b6fb535 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1045,11 +1045,22 @@ NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off_t size,
>                            bool writethrough, BlockBackend *on_eject_blk,
>                            Error **errp)
>  {
> +    AioContext  *ctx;
>      BlockBackend *blk;
>      NBDExport *exp = g_malloc0(sizeof(NBDExport));
>      uint64_t perm;
>      int ret;
>  
> +    /*
> +     * NBD exports are used for non-shared storage migration.  Make sure
> +     * that BDRV_O_INACTIVE is cleared and the image is ready for write
> +     * access since the export could be available before migration handover.
> +     */
> +    ctx = bdrv_get_aio_context(bs);
> +    aio_context_acquire(ctx);
> +    bdrv_invalidate_cache(bs, NULL);
> +    aio_context_release(ctx);
> +
>      /* Don't allow resize while the NBD server is running, otherwise we don't
>       * care what happens with the node. */
>      perm = BLK_PERM_CONSISTENT_READ;
> @@ -1087,15 +1098,6 @@ NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off_t size,
>          exp->eject_notifier.notify = nbd_eject_notifier;
>          blk_add_remove_bs_notifier(on_eject_blk, &exp->eject_notifier);
>      }
> -
> -    /*
> -     * NBD exports are used for non-shared storage migration.  Make sure
> -     * that BDRV_O_INACTIVE is cleared and the image is ready for write
> -     * access since the export could be available before migration handover.
> -     */
> -    aio_context_acquire(exp->ctx);
> -    blk_invalidate_cache(blk, NULL);
> -    aio_context_release(exp->ctx);
>      return exp;
>  
>  fail:

Fam
