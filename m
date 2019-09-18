Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0C9C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 20:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E21620665
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 20:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E21620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAh02-00020a-Na
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 16:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iAgur-0004ro-ST
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 16:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iAguo-0007mz-Dy
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 16:51:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35328)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iAguh-0007kM-Bl; Wed, 18 Sep 2019 16:50:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD9273086208;
 Wed, 18 Sep 2019 20:50:58 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50EF7600C8;
 Wed, 18 Sep 2019 20:50:54 +0000 (UTC)
Message-ID: <24b871b4722d4ccecfc3ce1293adc937fede38f1.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Wed, 18 Sep 2019 23:50:53 +0300
In-Reply-To: <20190918095144.955-5-mreitz@redhat.com>
References: <20190918095144.955-1-mreitz@redhat.com>
 <20190918095144.955-5-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 18 Sep 2019 20:50:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/8] block: Add @exact parameter to
 bdrv_co_truncate()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-09-18 at 11:51 +0200, Max Reitz wrote:
> We have two drivers (iscsi and file-posix) that (in some cases) return
> success from their .bdrv_co_truncate() implementation if the block
> device is larger than the requested offset, but cannot be shrunk.  Some
> callers do not want that behavior, so this patch adds a new parameter
> that they can use to turn off that behavior.
> 
> This patch just adds the parameter and lets the block/io.c and
> block/block-backend.c functions pass it around.  All other callers
> always pass false and none of the implementations evaluate it, so that
> this patch does not change existing behavior.  Future patches take care
> of that.
> 
> Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/block.h          |  6 +++---
>  include/block/block_int.h      | 17 ++++++++++++++++-
>  include/sysemu/block-backend.h |  4 ++--
>  block/block-backend.c          |  6 +++---
>  block/commit.c                 |  5 +++--
>  block/crypto.c                 |  8 ++++----
>  block/file-posix.c             |  3 ++-
>  block/file-win32.c             |  3 ++-
>  block/gluster.c                |  1 +
>  block/io.c                     | 20 +++++++++++++-------
>  block/iscsi.c                  |  3 ++-
>  block/mirror.c                 |  4 ++--
>  block/nfs.c                    |  2 +-
>  block/parallels.c              |  6 +++---
>  block/qcow.c                   |  4 ++--
>  block/qcow2-refcount.c         |  2 +-
>  block/qcow2.c                  | 22 ++++++++++++----------
>  block/qed.c                    |  3 ++-
>  block/raw-format.c             |  5 +++--
>  block/rbd.c                    |  1 +
>  block/sheepdog.c               |  5 +++--
>  block/ssh.c                    |  3 ++-
>  block/vdi.c                    |  2 +-
>  block/vhdx-log.c               |  4 ++--
>  block/vhdx.c                   |  7 ++++---
>  block/vmdk.c                   |  8 ++++----
>  block/vpc.c                    |  2 +-
>  blockdev.c                     |  2 +-
>  qemu-img.c                     |  2 +-
>  qemu-io-cmds.c                 |  2 +-
>  tests/test-block-iothread.c    |  8 ++++----
>  31 files changed, 102 insertions(+), 68 deletions(-)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index 37c9de7446..2f905ae4b7 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -346,10 +346,10 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
>      const char *backing_file);
>  void bdrv_refresh_filename(BlockDriverState *bs);
>  
> -int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
> +int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
>                                    PreallocMode prealloc, Error **errp);
> -int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
> -                  Error **errp);
> +int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
> +                  PreallocMode prealloc, Error **errp);
>  
>  int64_t bdrv_nb_sectors(BlockDriverState *bs);
>  int64_t bdrv_getlength(BlockDriverState *bs);
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 0422acdf1c..197cc6e7c3 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -334,8 +334,23 @@ struct BlockDriver {
>       * bdrv_parse_filename.
>       */
>      const char *protocol_name;
> +
> +    /*
> +     * Truncate @bs to @offset bytes using the given @prealloc mode
> +     * when growing.  Modes other than PREALLOC_MODE_OFF should be
> +     * rejected when shrinking @bs.
> +     *
> +     * If @exact is true, @bs must be resized to exactly @offset.
> +     * Otherwise, it is sufficient for @bs (if it is a host block
> +     * device and thus there is no way to resize it) to be at least
> +     * @offset bytes in length.
> +     *
> +     * If @exact is true and this function fails but would succeed
> +     * with @exact = false, it should return -ENOTSUP.
> +     */
Thanks for adding a documentation here!
One minor nitpick:
I would write

Otherwise, it is sufficient for @bs (for example if it is a host block
device and thus there is no way to resize it) to be at least @offset bytes in length.


>      int coroutine_fn (*bdrv_co_truncate)(BlockDriverState *bs, int64_t offset,
> -                                         PreallocMode prealloc, Error **errp);
> +                                         bool exact, PreallocMode prealloc,
> +                                         Error **errp);
>  
>      int64_t (*bdrv_getlength)(BlockDriverState *bs);
>      bool has_variable_length;
> diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
> index 368d53af77..841804c3cb 100644
> --- a/include/sysemu/block-backend.h
> +++ b/include/sysemu/block-backend.h
> @@ -233,8 +233,8 @@ int coroutine_fn blk_co_pwrite_zeroes(BlockBackend *blk, int64_t offset,
>                                        int bytes, BdrvRequestFlags flags);
>  int blk_pwrite_compressed(BlockBackend *blk, int64_t offset, const void *buf,
>                            int bytes);
> -int blk_truncate(BlockBackend *blk, int64_t offset, PreallocMode prealloc,
> -                 Error **errp);
> +int blk_truncate(BlockBackend *blk, int64_t offset, bool exact,
> +                 PreallocMode prealloc, Error **errp);
>  int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes);
>  int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
>                       int64_t pos, int size);
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 1c605d5444..e6d8240f40 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -2060,15 +2060,15 @@ int blk_pwrite_compressed(BlockBackend *blk, int64_t offset, const void *buf,
>                     BDRV_REQ_WRITE_COMPRESSED);
>  }
>  
> -int blk_truncate(BlockBackend *blk, int64_t offset, PreallocMode prealloc,
> -                 Error **errp)
> +int blk_truncate(BlockBackend *blk, int64_t offset, bool exact,
> +                 PreallocMode prealloc, Error **errp)
>  {
>      if (!blk_is_available(blk)) {
>          error_setg(errp, "No medium inserted");
>          return -ENOMEDIUM;
>      }
>  
> -    return bdrv_truncate(blk->root, offset, prealloc, errp);
> +    return bdrv_truncate(blk->root, offset, exact, prealloc, errp);
>  }
>  
>  static void blk_pdiscard_entry(void *opaque)
> diff --git a/block/commit.c b/block/commit.c
> index bc8454463d..23c90b3b91 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -155,7 +155,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>      }
>  
>      if (base_len < len) {
> -        ret = blk_truncate(s->base, len, PREALLOC_MODE_OFF, NULL);
> +        ret = blk_truncate(s->base, len, false, PREALLOC_MODE_OFF, NULL);
>          if (ret) {
>              goto out;
>          }
> @@ -471,7 +471,8 @@ int bdrv_commit(BlockDriverState *bs)
>       * grow the backing file image if possible.  If not possible,
>       * we must return an error */
>      if (length > backing_length) {
> -        ret = blk_truncate(backing, length, PREALLOC_MODE_OFF, &local_err);
> +        ret = blk_truncate(backing, length, false, PREALLOC_MODE_OFF,
> +                           &local_err);
>          if (ret < 0) {
>              error_report_err(local_err);
>              goto ro_cleanup;
> diff --git a/block/crypto.c b/block/crypto.c
> index 7eb698774e..e5a1a2cdf3 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -113,8 +113,8 @@ static ssize_t block_crypto_init_func(QCryptoBlock *block,
>       * available to the guest, so we must take account of that
>       * which will be used by the crypto header
>       */
> -    return blk_truncate(data->blk, data->size + headerlen, data->prealloc,
> -                        errp);
> +    return blk_truncate(data->blk, data->size + headerlen, false,
> +                        data->prealloc, errp);
>  }
>  
>  
> @@ -297,7 +297,7 @@ static int block_crypto_co_create_generic(BlockDriverState *bs,
>  }
>  
>  static int coroutine_fn
> -block_crypto_co_truncate(BlockDriverState *bs, int64_t offset,
> +block_crypto_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
>                           PreallocMode prealloc, Error **errp)
>  {
>      BlockCrypto *crypto = bs->opaque;
> @@ -311,7 +311,7 @@ block_crypto_co_truncate(BlockDriverState *bs, int64_t offset,
>  
>      offset += payload_offset;
>  
> -    return bdrv_co_truncate(bs->file, offset, prealloc, errp);
> +    return bdrv_co_truncate(bs->file, offset, false, prealloc, errp);
>  }
>  
>  static void block_crypto_close(BlockDriverState *bs)
> diff --git a/block/file-posix.c b/block/file-posix.c
> index f12c06de2d..d8755c5fac 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2014,7 +2014,8 @@ raw_regular_truncate(BlockDriverState *bs, int fd, int64_t offset,
>  }
>  
>  static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
> -                                        PreallocMode prealloc, Error **errp)
> +                                        bool exact, PreallocMode prealloc,
> +                                        Error **errp)
>  {
>      BDRVRawState *s = bs->opaque;
>      struct stat st;
> diff --git a/block/file-win32.c b/block/file-win32.c
> index 41f55dfece..77e8ff7b68 100644
> --- a/block/file-win32.c
> +++ b/block/file-win32.c
> @@ -468,7 +468,8 @@ static void raw_close(BlockDriverState *bs)
>  }
>  
>  static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
> -                                        PreallocMode prealloc, Error **errp)
> +                                        bool exact, PreallocMode prealloc,
> +                                        Error **errp)
>  {
>      BDRVRawState *s = bs->opaque;
>      LONG low, high;
> diff --git a/block/gluster.c b/block/gluster.c
> index 64028b2cba..4fa4a77a47 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -1225,6 +1225,7 @@ static coroutine_fn int qemu_gluster_co_rw(BlockDriverState *bs,
>  
>  static coroutine_fn int qemu_gluster_co_truncate(BlockDriverState *bs,
>                                                   int64_t offset,
> +                                                 bool exact,
>                                                   PreallocMode prealloc,
>                                                   Error **errp)
>  {
> diff --git a/block/io.c b/block/io.c
> index 723655c792..5b02642b98 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -3243,8 +3243,12 @@ static void bdrv_parent_cb_resize(BlockDriverState *bs)
>  
>  /**
>   * Truncate file to 'offset' bytes (needed only for file protocols)
> + *
> + * If 'exact' is true, the file must be resized to exactly the given
> + * 'offset'.  Otherwise, it is sufficient for the node to be at least
> + * 'offset' bytes in length.
>   */
> -int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
> +int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
>                                    PreallocMode prealloc, Error **errp)
>  {
>      BlockDriverState *bs = child->bs;
> @@ -3300,9 +3304,9 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
>      }
>  
>      if (drv->bdrv_co_truncate) {
> -        ret = drv->bdrv_co_truncate(bs, offset, prealloc, errp);
> +        ret = drv->bdrv_co_truncate(bs, offset, exact, prealloc, errp);
>      } else if (bs->file && drv->is_filter) {
> -        ret = bdrv_co_truncate(bs->file, offset, prealloc, errp);
> +        ret = bdrv_co_truncate(bs->file, offset, exact, prealloc, errp);
>      } else {
>          error_setg(errp, "Image format driver does not support resize");
>          ret = -ENOTSUP;
> @@ -3333,6 +3337,7 @@ out:
>  typedef struct TruncateCo {
>      BdrvChild *child;
>      int64_t offset;
> +    bool exact;
>      PreallocMode prealloc;
>      Error **errp;
>      int ret;
> @@ -3341,18 +3346,19 @@ typedef struct TruncateCo {
>  static void coroutine_fn bdrv_truncate_co_entry(void *opaque)
>  {
>      TruncateCo *tco = opaque;
> -    tco->ret = bdrv_co_truncate(tco->child, tco->offset, tco->prealloc,
> -                                tco->errp);
> +    tco->ret = bdrv_co_truncate(tco->child, tco->offset, tco->exact,
> +                                tco->prealloc, tco->errp);
>      aio_wait_kick();
>  }
>  
> -int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
> -                  Error **errp)
> +int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
> +                  PreallocMode prealloc, Error **errp)
>  {
>      Coroutine *co;
>      TruncateCo tco = {
>          .child      = child,
>          .offset     = offset,
> +        .exact      = exact,
>          .prealloc   = prealloc,
>          .errp       = errp,
>          .ret        = NOT_DONE,
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 506bf5f875..a90426270a 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -2122,7 +2122,8 @@ static void iscsi_reopen_commit(BDRVReopenState *reopen_state)
>  }
>  
>  static int coroutine_fn iscsi_co_truncate(BlockDriverState *bs, int64_t offset,
> -                                          PreallocMode prealloc, Error **errp)
> +                                          bool exact, PreallocMode prealloc,
> +                                          Error **errp)
>  {
>      IscsiLun *iscsilun = bs->opaque;
>      Error *local_err = NULL;
> diff --git a/block/mirror.c b/block/mirror.c
> index fe984efb90..2cfd035571 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -873,8 +873,8 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
>          }
>  
>          if (s->bdev_length > base_length) {
> -            ret = blk_truncate(s->target, s->bdev_length, PREALLOC_MODE_OFF,
> -                               NULL);
> +            ret = blk_truncate(s->target, s->bdev_length, false,
> +                               PREALLOC_MODE_OFF, NULL);
>              if (ret < 0) {
>                  goto immediate_exit;
>              }
> diff --git a/block/nfs.c b/block/nfs.c
> index f39acfdb28..ba8b41775a 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -750,7 +750,7 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
>  }
>  
>  static int coroutine_fn
> -nfs_file_co_truncate(BlockDriverState *bs, int64_t offset,
> +nfs_file_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
>                       PreallocMode prealloc, Error **errp)
>  {
>      NFSClient *client = bs->opaque;
> diff --git a/block/parallels.c b/block/parallels.c
> index 905cac35c6..a1a92c97a4 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -203,7 +203,7 @@ static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>          } else {
>              ret = bdrv_truncate(bs->file,
>                                  (s->data_end + space) << BDRV_SECTOR_BITS,
> -                                PREALLOC_MODE_OFF, NULL);
> +                                false, PREALLOC_MODE_OFF, NULL);
>          }
>          if (ret < 0) {
>              return ret;
> @@ -487,7 +487,7 @@ static int coroutine_fn parallels_co_check(BlockDriverState *bs,
>          res->leaks += count;
>          if (fix & BDRV_FIX_LEAKS) {
>              Error *local_err = NULL;
> -            ret = bdrv_truncate(bs->file, res->image_end_offset,
> +            ret = bdrv_truncate(bs->file, res->image_end_offset, false,
>                                  PREALLOC_MODE_OFF, &local_err);
>              if (ret < 0) {
>                  error_report_err(local_err);
> @@ -880,7 +880,7 @@ static void parallels_close(BlockDriverState *bs)
>      if ((bs->open_flags & BDRV_O_RDWR) && !(bs->open_flags & BDRV_O_INACTIVE)) {
>          s->header->inuse = 0;
>          parallels_update_header(bs);
> -        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS,
> +        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, false,
>                        PREALLOC_MODE_OFF, NULL);
>      }
>  
> diff --git a/block/qcow.c b/block/qcow.c
> index 17705015ca..fce8989868 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -480,7 +480,7 @@ static int get_cluster_offset(BlockDriverState *bs,
>                      return -E2BIG;
>                  }
>                  ret = bdrv_truncate(bs->file, cluster_offset + s->cluster_size,
> -                                    PREALLOC_MODE_OFF, NULL);
> +                                    false, PREALLOC_MODE_OFF, NULL);
>                  if (ret < 0) {
>                      return ret;
>                  }
> @@ -1033,7 +1033,7 @@ static int qcow_make_empty(BlockDriverState *bs)
>      if (bdrv_pwrite_sync(bs->file, s->l1_table_offset, s->l1_table,
>              l1_length) < 0)
>          return -1;
> -    ret = bdrv_truncate(bs->file, s->l1_table_offset + l1_length,
> +    ret = bdrv_truncate(bs->file, s->l1_table_offset + l1_length, false,
>                          PREALLOC_MODE_OFF, NULL);
>      if (ret < 0)
>          return ret;
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index ef965d7895..7b70d8683a 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -2016,7 +2016,7 @@ static int check_refblocks(BlockDriverState *bs, BdrvCheckResult *res,
>                      goto resize_fail;
>                  }
>  
> -                ret = bdrv_truncate(bs->file, offset + s->cluster_size,
> +                ret = bdrv_truncate(bs->file, offset + s->cluster_size, false,
>                                      PREALLOC_MODE_OFF, &local_err);
>                  if (ret < 0) {
>                      error_report_err(local_err);
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 4978ccc7be..157b9b75d9 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2869,8 +2869,8 @@ static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t offset,
>          if (mode == PREALLOC_MODE_METADATA) {
>              mode = PREALLOC_MODE_OFF;
>          }
> -        ret = bdrv_co_truncate(s->data_file, host_offset + cur_bytes, mode,
> -                               errp);
> +        ret = bdrv_co_truncate(s->data_file, host_offset + cur_bytes, false,
> +                               mode, errp);
>          if (ret < 0) {
>              return ret;
>          }
> @@ -3284,7 +3284,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
>      }
>  
>      /* Okay, now that we have a valid image, let's give it the right size */
> -    ret = blk_truncate(blk, qcow2_opts->size, qcow2_opts->preallocation, errp);
> +    ret = blk_truncate(blk, qcow2_opts->size, false, qcow2_opts->preallocation,
> +                       errp);
>      if (ret < 0) {
>          error_prepend(errp, "Could not resize image: ");
>          goto out;
> @@ -3732,7 +3733,8 @@ fail:
>  }
>  
>  static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
> -                                          PreallocMode prealloc, Error **errp)
> +                                          bool exact, PreallocMode prealloc,
> +                                          Error **errp)
>  {
>      BDRVQcow2State *s = bs->opaque;
>      uint64_t old_length;
> @@ -3821,7 +3823,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>              Error *local_err = NULL;
>  
>              bdrv_co_truncate(bs->file, (last_cluster + 1) * s->cluster_size,
> -                             PREALLOC_MODE_OFF, &local_err);
> +                             false, PREALLOC_MODE_OFF, &local_err);
>              if (local_err) {
>                  warn_reportf_err(local_err,
>                                   "Failed to truncate the tail of the image: ");
> @@ -3838,7 +3840,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>      switch (prealloc) {
>      case PREALLOC_MODE_OFF:
>          if (has_data_file(bs)) {
> -            ret = bdrv_co_truncate(s->data_file, offset, prealloc, errp);
> +            ret = bdrv_co_truncate(s->data_file, offset, false, prealloc, errp);
>              if (ret < 0) {
>                  goto fail;
>              }
> @@ -3923,7 +3925,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>          /* Allocate the data area */
>          new_file_size = allocation_start +
>                          nb_new_data_clusters * s->cluster_size;
> -        ret = bdrv_co_truncate(bs->file, new_file_size, prealloc, errp);
> +        ret = bdrv_co_truncate(bs->file, new_file_size, false, prealloc, errp);
>          if (ret < 0) {
>              error_prepend(errp, "Failed to resize underlying file: ");
>              qcow2_free_clusters(bs, allocation_start,
> @@ -4026,7 +4028,7 @@ qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
>          if (len < 0) {
>              return len;
>          }
> -        return bdrv_co_truncate(bs->file, len, PREALLOC_MODE_OFF, NULL);
> +        return bdrv_co_truncate(bs->file, len, false, PREALLOC_MODE_OFF, NULL);
>      }
>  
>      if (offset_into_cluster(s, offset)) {
> @@ -4263,7 +4265,7 @@ static int make_completely_empty(BlockDriverState *bs)
>          goto fail;
>      }
>  
> -    ret = bdrv_truncate(bs->file, (3 + l1_clusters) * s->cluster_size,
> +    ret = bdrv_truncate(bs->file, (3 + l1_clusters) * s->cluster_size, false,
>                          PREALLOC_MODE_OFF, &local_err);
>      if (ret < 0) {
>          error_report_err(local_err);
> @@ -5042,7 +5044,7 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>              return ret;
>          }
>  
> -        ret = blk_truncate(blk, new_size, PREALLOC_MODE_OFF, errp);
> +        ret = blk_truncate(blk, new_size, false, PREALLOC_MODE_OFF, errp);
>          blk_unref(blk);
>          if (ret < 0) {
>              return ret;
> diff --git a/block/qed.c b/block/qed.c
> index 0d8fd507aa..7c2a65af40 100644
> --- a/block/qed.c
> +++ b/block/qed.c
> @@ -674,7 +674,7 @@ static int coroutine_fn bdrv_qed_co_create(BlockdevCreateOptions *opts,
>      l1_size = header.cluster_size * header.table_size;
>  
>      /* File must start empty and grow, check truncate is supported */
> -    ret = blk_truncate(blk, 0, PREALLOC_MODE_OFF, errp);
> +    ret = blk_truncate(blk, 0, false, PREALLOC_MODE_OFF, errp);
>      if (ret < 0) {
>          goto out;
>      }
> @@ -1461,6 +1461,7 @@ static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
>  
>  static int coroutine_fn bdrv_qed_co_truncate(BlockDriverState *bs,
>                                               int64_t offset,
> +                                             bool exact,
>                                               PreallocMode prealloc,
>                                               Error **errp)
>  {
> diff --git a/block/raw-format.c b/block/raw-format.c
> index 42c28cc29a..57d84d0bae 100644
> --- a/block/raw-format.c
> +++ b/block/raw-format.c
> @@ -370,7 +370,8 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
>  }
>  
>  static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
> -                                        PreallocMode prealloc, Error **errp)
> +                                        bool exact, PreallocMode prealloc,
> +                                        Error **errp)
>  {
>      BDRVRawState *s = bs->opaque;
>  
> @@ -386,7 +387,7 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
>  
>      s->size = offset;
>      offset += s->offset;
> -    return bdrv_co_truncate(bs->file, offset, prealloc, errp);
> +    return bdrv_co_truncate(bs->file, offset, false, prealloc, errp);
>  }
>  
>  static void raw_eject(BlockDriverState *bs, bool eject_flag)
> diff --git a/block/rbd.c b/block/rbd.c
> index 057af43d48..cdccf01d68 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -1086,6 +1086,7 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
>  
>  static int coroutine_fn qemu_rbd_co_truncate(BlockDriverState *bs,
>                                               int64_t offset,
> +                                             bool exact,
>                                               PreallocMode prealloc,
>                                               Error **errp)
>  {
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index 773dfc6ab1..cfa84338a2 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -2285,7 +2285,8 @@ static int64_t sd_getlength(BlockDriverState *bs)
>  }
>  
>  static int coroutine_fn sd_co_truncate(BlockDriverState *bs, int64_t offset,
> -                                       PreallocMode prealloc, Error **errp)
> +                                       bool exact, PreallocMode prealloc,
> +                                       Error **errp)
>  {
>      BDRVSheepdogState *s = bs->opaque;
>      int ret, fd;
> @@ -2601,7 +2602,7 @@ static coroutine_fn int sd_co_writev(BlockDriverState *bs, int64_t sector_num,
>  
>      assert(!flags);
>      if (offset > s->inode.vdi_size) {
> -        ret = sd_co_truncate(bs, offset, PREALLOC_MODE_OFF, NULL);
> +        ret = sd_co_truncate(bs, offset, false, PREALLOC_MODE_OFF, NULL);
>          if (ret < 0) {
>              return ret;
>          }
> diff --git a/block/ssh.c b/block/ssh.c
> index 84d01e892b..b4375cf7d2 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c
> @@ -1295,7 +1295,8 @@ static int64_t ssh_getlength(BlockDriverState *bs)
>  }
>  
>  static int coroutine_fn ssh_co_truncate(BlockDriverState *bs, int64_t offset,
> -                                        PreallocMode prealloc, Error **errp)
> +                                        bool exact, PreallocMode prealloc,
> +                                        Error **errp)
>  {
>      BDRVSSHState *s = bs->opaque;
>  
> diff --git a/block/vdi.c b/block/vdi.c
> index 806ba7f53c..0142da7233 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -874,7 +874,7 @@ static int coroutine_fn vdi_co_do_create(BlockdevCreateOptions *create_options,
>      }
>  
>      if (image_type == VDI_TYPE_STATIC) {
> -        ret = blk_truncate(blk, offset + blocks * block_size,
> +        ret = blk_truncate(blk, offset + blocks * block_size, false,
>                             PREALLOC_MODE_OFF, errp);
>          if (ret < 0) {
>              error_prepend(errp, "Failed to statically allocate file");
> diff --git a/block/vhdx-log.c b/block/vhdx-log.c
> index fdd3a7adc3..13a49c2a33 100644
> --- a/block/vhdx-log.c
> +++ b/block/vhdx-log.c
> @@ -557,8 +557,8 @@ static int vhdx_log_flush(BlockDriverState *bs, BDRVVHDXState *s,
>                      ret = -EINVAL;
>                      goto exit;
>                  }
> -                ret = bdrv_truncate(bs->file, new_file_size, PREALLOC_MODE_OFF,
> -                                    NULL);
> +                ret = bdrv_truncate(bs->file, new_file_size, false,
> +                                    PREALLOC_MODE_OFF, NULL);
>                  if (ret < 0) {
>                      goto exit;
>                  }
> diff --git a/block/vhdx.c b/block/vhdx.c
> index 6a09d0a55c..8ae14d97f9 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -1180,7 +1180,7 @@ static int vhdx_allocate_block(BlockDriverState *bs, BDRVVHDXState *s,
>          return -EINVAL;
>      }
>  
> -    return bdrv_truncate(bs->file, *new_offset + s->block_size,
> +    return bdrv_truncate(bs->file, *new_offset + s->block_size, false,
>                           PREALLOC_MODE_OFF, NULL);
>  }
>  
> @@ -1619,12 +1619,13 @@ static int vhdx_create_bat(BlockBackend *blk, BDRVVHDXState *s,
>      if (type == VHDX_TYPE_DYNAMIC) {
>          /* All zeroes, so we can just extend the file - the end of the BAT
>           * is the furthest thing we have written yet */
> -        ret = blk_truncate(blk, data_file_offset, PREALLOC_MODE_OFF, errp);
> +        ret = blk_truncate(blk, data_file_offset, false, PREALLOC_MODE_OFF,
> +                           errp);
>          if (ret < 0) {
>              goto exit;
>          }
>      } else if (type == VHDX_TYPE_FIXED) {
> -        ret = blk_truncate(blk, data_file_offset + image_size,
> +        ret = blk_truncate(blk, data_file_offset + image_size, false,
>                             PREALLOC_MODE_OFF, errp);
>          if (ret < 0) {
>              goto exit;
> diff --git a/block/vmdk.c b/block/vmdk.c
> index fed3b50c8a..20e909d997 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -2076,7 +2076,7 @@ vmdk_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
>                  return length;
>              }
>              length = QEMU_ALIGN_UP(length, BDRV_SECTOR_SIZE);
> -            ret = bdrv_truncate(s->extents[i].file, length,
> +            ret = bdrv_truncate(s->extents[i].file, length, false,
>                                  PREALLOC_MODE_OFF, NULL);
>              if (ret < 0) {
>                  return ret;
> @@ -2118,7 +2118,7 @@ static int vmdk_init_extent(BlockBackend *blk,
>      int gd_buf_size;
>  
>      if (flat) {
> -        ret = blk_truncate(blk, filesize, PREALLOC_MODE_OFF, errp);
> +        ret = blk_truncate(blk, filesize, false, PREALLOC_MODE_OFF, errp);
>          goto exit;
>      }
>      magic = cpu_to_be32(VMDK4_MAGIC);
> @@ -2181,7 +2181,7 @@ static int vmdk_init_extent(BlockBackend *blk,
>          goto exit;
>      }
>  
> -    ret = blk_truncate(blk, le64_to_cpu(header.grain_offset) << 9,
> +    ret = blk_truncate(blk, le64_to_cpu(header.grain_offset) << 9, false,
>                         PREALLOC_MODE_OFF, errp);
>      if (ret < 0) {
>          goto exit;
> @@ -2523,7 +2523,7 @@ static int coroutine_fn vmdk_co_do_create(int64_t size,
>      /* bdrv_pwrite write padding zeros to align to sector, we don't need that
>       * for description file */
>      if (desc_offset == 0) {
> -        ret = blk_truncate(blk, desc_len, PREALLOC_MODE_OFF, errp);
> +        ret = blk_truncate(blk, desc_len, false, PREALLOC_MODE_OFF, errp);
>          if (ret < 0) {
>              goto exit;
>          }
> diff --git a/block/vpc.c b/block/vpc.c
> index 5cd3890780..a65550298e 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -898,7 +898,7 @@ static int create_fixed_disk(BlockBackend *blk, uint8_t *buf,
>      /* Add footer to total size */
>      total_size += HEADER_SIZE;
>  
> -    ret = blk_truncate(blk, total_size, PREALLOC_MODE_OFF, errp);
> +    ret = blk_truncate(blk, total_size, false, PREALLOC_MODE_OFF, errp);
>      if (ret < 0) {
>          return ret;
>      }
> diff --git a/blockdev.c b/blockdev.c
> index fbef6845c8..6b04eca2a4 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3225,7 +3225,7 @@ void qmp_block_resize(bool has_device, const char *device,
>      }
>  
>      bdrv_drained_begin(bs);
> -    ret = blk_truncate(blk, size, PREALLOC_MODE_OFF, errp);
> +    ret = blk_truncate(blk, size, false, PREALLOC_MODE_OFF, errp);
>      bdrv_drained_end(bs);
>  
>  out:
> diff --git a/qemu-img.c b/qemu-img.c
> index 384c6f38bc..f8694f4f72 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3823,7 +3823,7 @@ static int img_resize(int argc, char **argv)
>          }
>      }
>  
> -    ret = blk_truncate(blk, total_size, prealloc, &err);
> +    ret = blk_truncate(blk, total_size, false, prealloc, &err);
>      if (ret < 0) {
>          error_report_err(err);
>          goto out;
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 349256a5fe..5e9017c979 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -1710,7 +1710,7 @@ static int truncate_f(BlockBackend *blk, int argc, char **argv)
>          return offset;
>      }
>  
> -    ret = blk_truncate(blk, offset, PREALLOC_MODE_OFF, &local_err);
> +    ret = blk_truncate(blk, offset, false, PREALLOC_MODE_OFF, &local_err);
>      if (ret < 0) {
>          error_report_err(local_err);
>          return ret;
> diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
> index cfe30bab21..0c861809f0 100644
> --- a/tests/test-block-iothread.c
> +++ b/tests/test-block-iothread.c
> @@ -45,7 +45,7 @@ static int coroutine_fn bdrv_test_co_pdiscard(BlockDriverState *bs,
>  }
>  
>  static int coroutine_fn
> -bdrv_test_co_truncate(BlockDriverState *bs, int64_t offset,
> +bdrv_test_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
>                        PreallocMode prealloc, Error **errp)
>  {
>      return 0;
> @@ -185,18 +185,18 @@ static void test_sync_op_truncate(BdrvChild *c)
>      int ret;
>  
>      /* Normal success path */
> -    ret = bdrv_truncate(c, 65536, PREALLOC_MODE_OFF, NULL);
> +    ret = bdrv_truncate(c, 65536, false, PREALLOC_MODE_OFF, NULL);
>      g_assert_cmpint(ret, ==, 0);
>  
>      /* Early error: Negative offset */
> -    ret = bdrv_truncate(c, -2, PREALLOC_MODE_OFF, NULL);
> +    ret = bdrv_truncate(c, -2, false, PREALLOC_MODE_OFF, NULL);
>      g_assert_cmpint(ret, ==, -EINVAL);
>  
>      /* Error: Read-only image */
>      c->bs->read_only = true;
>      c->bs->open_flags &= ~BDRV_O_RDWR;
>  
> -    ret = bdrv_truncate(c, 65536, PREALLOC_MODE_OFF, NULL);
> +    ret = bdrv_truncate(c, 65536, false, PREALLOC_MODE_OFF, NULL);
>      g_assert_cmpint(ret, ==, -EACCES);
>  
>      c->bs->read_only = false;

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



