Received: from eggs.gnu.org ([2001:4830:134:3::10]:33966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ejb7n-0006yl-D0
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:35:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ejb7m-0006mg-2w
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:35:43 -0500
Date: Thu, 8 Feb 2018 09:35:17 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180208013517.GB24289@lemon.usersys.redhat.com>
References: <20180207163622.29935-1-pbonzini@redhat.com>
	<20180207163622.29935-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207163622.29935-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] scsi: add block job opblockers for
 scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org

On Wed, 02/07 17:36, Paolo Bonzini wrote:
> scsi-block bypasses the dirty bitmaps and pre-write notifiers, so it
> cannot be the source of a block job.  The gist of the fix is to add
> op-blockers to the BlockBackend, and remove them at "unrealize" time,
> but things are a little more complex because quit closes the BlockBackend
> without going through unrealize.
> 
> So use Notifiers: the remove_bs notifier is called by bdrv_close_all, and
> the insert_bs notifier might not be really necessary but make things a
> little more symmetric.
> 
> Suggested-by: Karen Noel <knoel@redhat.com>

:)

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>

Though I have one comment below.

> ---
>  block/block-backend.c          |  9 ++++++
>  hw/scsi/scsi-disk.c            | 62 ++++++++++++++++++++++++++++++++++++++++++
>  include/sysemu/block-backend.h |  1 +
>  3 files changed, 72 insertions(+)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index baef8e7abc..1759639a4a 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -1747,6 +1747,15 @@ bool blk_op_is_blocked(BlockBackend *blk, BlockOpType op, Error **errp)
>      return bdrv_op_is_blocked(bs, op, errp);
>  }
>  
> +void blk_op_block(BlockBackend *blk, BlockOpType op, Error *reason)
> +{
> +    BlockDriverState *bs = blk_bs(blk);
> +
> +    if (bs) {
> +        bdrv_op_block(bs, op, reason);
> +    }
> +}
> +
>  void blk_op_unblock(BlockBackend *blk, BlockOpType op, Error *reason)
>  {
>      BlockDriverState *bs = blk_bs(blk);
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 49d2559d93..023673cb04 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2578,9 +2578,39 @@ static int get_device_type(SCSIDiskState *s)
>      return 0;
>  }
>  
> +typedef struct SCSIBlockState {
> +    SCSIDiskState sd;
> +    Error *mirror_source;
> +    Error *backup_source;
> +    Error *commit_source;
> +    Notifier insert_bs;
> +    Notifier remove_bs;
> +} SCSIBlockState;
> +
> +static void scsi_block_insert_bs(Notifier *n, void *opaque)
> +{
> +    SCSIBlockState *sb = container_of(n, SCSIBlockState, insert_bs);
> +    SCSIDiskState *s = &sb->sd;
> +
> +    blk_op_block(s->qdev.conf.blk, BLOCK_OP_TYPE_MIRROR_SOURCE, sb->mirror_source);
> +    blk_op_block(s->qdev.conf.blk, BLOCK_OP_TYPE_COMMIT_SOURCE, sb->commit_source);
> +    blk_op_block(s->qdev.conf.blk, BLOCK_OP_TYPE_BACKUP_SOURCE, sb->backup_source);
> +}
> +
> +static void scsi_block_remove_bs(Notifier *n, void *opaque)
> +{
> +    SCSIBlockState *sb = container_of(n, SCSIBlockState, remove_bs);
> +    SCSIDiskState *s = &sb->sd;
> +
> +    blk_op_unblock(s->qdev.conf.blk, BLOCK_OP_TYPE_MIRROR_SOURCE, sb->mirror_source);
> +    blk_op_unblock(s->qdev.conf.blk, BLOCK_OP_TYPE_COMMIT_SOURCE, sb->commit_source);
> +    blk_op_unblock(s->qdev.conf.blk, BLOCK_OP_TYPE_BACKUP_SOURCE, sb->backup_source);
> +}
> +
>  static void scsi_block_realize(SCSIDevice *dev, Error **errp)
>  {
>      SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
> +    SCSIBlockState *sb = DO_UPCAST(SCSIBlockState, sd, s);
>      int sg_version;
>      int rc;
>  
> @@ -2626,6 +2656,36 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
>  
>      scsi_realize(&s->qdev, errp);
>      scsi_generic_read_device_identification(&s->qdev);
> +
> +    /* For op blockers, due to lack of support for dirty bitmaps.  */
> +    error_setg(&sb->mirror_source,
> +               "scsi-block does not support acting as a mirroring source");
> +    error_setg(&sb->commit_source,
> +               "scsi-block does not support acting as an active commit source");

An alternative way would be adding BLOCK_OP_TYPE_DIRTY_BITMAP. The error message
will not be as nice but it can be useful for another (blockjob) operation that
requires dirty bitmap support, or another device that doesn't support dirty
bitmaps. Though there isn't one for now.

> +
> +    /* For op blockers, due to lack of support for write notifiers.  */
> +    error_setg(&sb->backup_source,
> +               "scsi-block does not support acting as a backup source");
> +
> +    sb->insert_bs.notify = scsi_block_insert_bs;
> +    blk_add_insert_bs_notifier(s->qdev.conf.blk, &sb->insert_bs);
> +    sb->remove_bs.notify = scsi_block_remove_bs;
> +    blk_add_remove_bs_notifier(s->qdev.conf.blk, &sb->remove_bs);
> +
> +    scsi_block_insert_bs(&sb->insert_bs, s->qdev.conf.blk);
> +}
> +
> +static void scsi_block_unrealize(SCSIDevice *dev, Error **errp)
> +{
> +    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
> +    SCSIBlockState *sb = DO_UPCAST(SCSIBlockState, sd, s);
> +
> +    notifier_remove(&sb->insert_bs);
> +    notifier_remove(&sb->remove_bs);
> +    scsi_block_remove_bs(&sb->insert_bs, s->qdev.conf.blk);
> +    error_free(sb->mirror_source);
> +    error_free(sb->commit_source);
> +    error_free(sb->backup_source);
>  }
>  
>  typedef struct SCSIBlockReq {
> @@ -3017,6 +3077,7 @@ static void scsi_block_class_initfn(ObjectClass *klass, void *data)
>      SCSIDiskClass *sdc = SCSI_DISK_BASE_CLASS(klass);
>  
>      sc->realize      = scsi_block_realize;
> +    sc->unrealize    = scsi_block_unrealize;
>      sc->alloc_req    = scsi_block_new_request;
>      sc->parse_cdb    = scsi_block_parse_cdb;
>      sdc->dma_readv   = scsi_block_dma_readv;
> @@ -3031,6 +3092,7 @@ static const TypeInfo scsi_block_info = {
>      .name          = "scsi-block",
>      .parent        = TYPE_SCSI_DISK_BASE,
>      .class_init    = scsi_block_class_initfn,
> +    .instance_size = sizeof(SCSIBlockState),
>  };
>  #endif
>  
> diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
> index c4e52a5fa3..a48a49ca79 100644
> --- a/include/sysemu/block-backend.h
> +++ b/include/sysemu/block-backend.h
> @@ -182,6 +182,7 @@ void blk_set_guest_block_size(BlockBackend *blk, int align);
>  void *blk_try_blockalign(BlockBackend *blk, size_t size);
>  void *blk_blockalign(BlockBackend *blk, size_t size);
>  bool blk_op_is_blocked(BlockBackend *blk, BlockOpType op, Error **errp);
> +void blk_op_block(BlockBackend *blk, BlockOpType op, Error *reason);
>  void blk_op_unblock(BlockBackend *blk, BlockOpType op, Error *reason);
>  void blk_op_block_all(BlockBackend *blk, Error *reason);
>  void blk_op_unblock_all(BlockBackend *blk, Error *reason);
> -- 
> 2.14.3
> 
> 

Fam
