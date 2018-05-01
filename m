Received: from eggs.gnu.org ([2001:4830:134:3::10]:36349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fDe6A-00060R-25
	for qemu-devel@nongnu.org; Tue, 01 May 2018 18:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fDe67-0001lQ-Ce
	for qemu-devel@nongnu.org; Tue, 01 May 2018 18:50:13 -0400
References: <20180421165423.30759-1-mreitz@redhat.com>
	<20180421165423.30759-3-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f6ef067c-29d1-0f82-695f-81965b462573@redhat.com>
Date: Tue, 1 May 2018 18:49:55 -0400
MIME-Version: 1.0
In-Reply-To: <20180421165423.30759-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/7] block: Add Error
 parameter to bdrv_amend_options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org



On 04/21/2018 12:54 PM, Max Reitz wrote:
> Looking at the qcow2 code that is riddled with error_report() calls,
> this is really how it should have been from the start.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/block.h      |  3 +-
>  include/block/block_int.h  |  3 +-
>  block.c                    |  8 ++++--
>  block/qcow2.c              | 72 ++++++++++++++++++++++++++++++----------------
>  qemu-img.c                 |  4 +--
>  tests/qemu-iotests/060.out |  4 +--
>  tests/qemu-iotests/061.out |  7 -----
>  tests/qemu-iotests/080.out |  4 +--
>  tests/qemu-iotests/112.out |  3 --
>  9 files changed, 64 insertions(+), 44 deletions(-)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index cdec3639a3..ba9cfec384 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -336,7 +336,8 @@ int bdrv_check(BlockDriverState *bs, BdrvCheckResult *res, BdrvCheckMode fix);
>  typedef void BlockDriverAmendStatusCB(BlockDriverState *bs, int64_t offset,
>                                        int64_t total_work_size, void *opaque);
>  int bdrv_amend_options(BlockDriverState *bs_new, QemuOpts *opts,
> -                       BlockDriverAmendStatusCB *status_cb, void *cb_opaque);
> +                       BlockDriverAmendStatusCB *status_cb, void *cb_opaque,
> +                       Error **errp);
>  
>  /* external snapshots */
>  bool bdrv_recurse_is_first_non_filter(BlockDriverState *bs,
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index c4dd1d4bb8..d913ed1ea1 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -324,7 +324,8 @@ struct BlockDriver {
>  
>      int (*bdrv_amend_options)(BlockDriverState *bs, QemuOpts *opts,
>                                BlockDriverAmendStatusCB *status_cb,
> -                              void *cb_opaque);
> +                              void *cb_opaque,
> +                              Error **errp);
>  
>      void (*bdrv_debug_event)(BlockDriverState *bs, BlkdebugEvent event);
>  
> diff --git a/block.c b/block.c
> index a2caadf0a0..fefe1109eb 100644
> --- a/block.c
> +++ b/block.c
> @@ -4996,15 +4996,19 @@ void bdrv_remove_aio_context_notifier(BlockDriverState *bs,
>  }
>  
>  int bdrv_amend_options(BlockDriverState *bs, QemuOpts *opts,
> -                       BlockDriverAmendStatusCB *status_cb, void *cb_opaque)
> +                       BlockDriverAmendStatusCB *status_cb, void *cb_opaque,
> +                       Error **errp)
>  {
>      if (!bs->drv) {
> +        error_setg(errp, "Node is ejected");
>          return -ENOMEDIUM;
>      }
>      if (!bs->drv->bdrv_amend_options) {
> +        error_setg(errp, "Block driver '%s' does not support option amendment",
> +                   bs->drv->format_name);
>          return -ENOTSUP;
>      }
> -    return bs->drv->bdrv_amend_options(bs, opts, status_cb, cb_opaque);
> +    return bs->drv->bdrv_amend_options(bs, opts, status_cb, cb_opaque, errp);
>  }
>  
>  /* This function will be called by the bdrv_recurse_is_first_non_filter method
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 091088e09e..eb86ba0a2a 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -4049,7 +4049,8 @@ static int qcow2_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
>   * have to be removed.
>   */
>  static int qcow2_downgrade(BlockDriverState *bs, int target_version,
> -                           BlockDriverAmendStatusCB *status_cb, void *cb_opaque)
> +                           BlockDriverAmendStatusCB *status_cb, void *cb_opaque,
> +                           Error **errp)
>  {
>      BDRVQcow2State *s = bs->opaque;
>      int current_version = s->qcow_version;
> @@ -4058,13 +4059,17 @@ static int qcow2_downgrade(BlockDriverState *bs, int target_version,
>      if (target_version == current_version) {
>          return 0;
>      } else if (target_version > current_version) {
> +        error_setg(errp, "Cannot downgrade an image from version %i to %i",
> +                   current_version, target_version);
>          return -EINVAL;
>      } else if (target_version != 2) {
> +        error_setg(errp, "Cannot downgrade an image to version %i (only "
> +                   "target version 2 is supported)", target_version);
>          return -EINVAL;
>      }
>  
>      if (s->refcount_order != 4) {
> -        error_report("compat=0.10 requires refcount_bits=16");
> +        error_setg(errp, "compat=0.10 requires refcount_bits=16");
>          return -ENOTSUP;
>      }
>  
> @@ -4072,6 +4077,8 @@ static int qcow2_downgrade(BlockDriverState *bs, int target_version,
>      if (s->incompatible_features & QCOW2_INCOMPAT_DIRTY) {
>          ret = qcow2_mark_clean(bs);
>          if (ret < 0) {
> +            error_setg(errp, "Failed to make the image clean: %s",
> +                       strerror(-ret));
>              return ret;
>          }
>      }
> @@ -4081,6 +4088,8 @@ static int qcow2_downgrade(BlockDriverState *bs, int target_version,
>       * best thing to do anyway */
>  
>      if (s->incompatible_features) {
> +        error_setg(errp, "Cannot downgrade an image with incompatible features "
> +                   "%#" PRIx64 " set", s->incompatible_features);
>          return -ENOTSUP;
>      }
>  
> @@ -4094,6 +4103,8 @@ static int qcow2_downgrade(BlockDriverState *bs, int target_version,
>  
>      ret = qcow2_expand_zero_clusters(bs, status_cb, cb_opaque);
>      if (ret < 0) {
> +        error_setg(errp, "Failed to turn zero into data clusters: %s",
> +                   strerror(-ret));
>          return ret;
>      }
>  
> @@ -4101,6 +4112,8 @@ static int qcow2_downgrade(BlockDriverState *bs, int target_version,
>      ret = qcow2_update_header(bs);
>      if (ret < 0) {
>          s->qcow_version = current_version;
> +        error_setg(errp, "Failed to update the image header: %s",
> +                   strerror(-ret));
>          return ret;
>      }
>      return 0;
> @@ -4178,7 +4191,8 @@ static void qcow2_amend_helper_cb(BlockDriverState *bs,
>  
>  static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>                                 BlockDriverAmendStatusCB *status_cb,
> -                               void *cb_opaque)
> +                               void *cb_opaque,
> +                               Error **errp)
>  {
>      BDRVQcow2State *s = bs->opaque;
>      int old_version = s->qcow_version, new_version = old_version;
> @@ -4190,7 +4204,6 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>      bool encrypt;
>      int encformat;
>      int refcount_bits = s->refcount_bits;
> -    Error *local_err = NULL;
>      int ret;
>      QemuOptDesc *desc = opts->list->desc;
>      Qcow2AmendHelperCBInfo helper_cb_info;
> @@ -4211,11 +4224,11 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>              } else if (!strcmp(compat, "1.1")) {
>                  new_version = 3;
>              } else {
> -                error_report("Unknown compatibility level %s", compat);
> +                error_setg(errp, "Unknown compatibility level %s", compat);
>                  return -EINVAL;
>              }
>          } else if (!strcmp(desc->name, BLOCK_OPT_PREALLOC)) {
> -            error_report("Cannot change preallocation mode");
> +            error_setg(errp, "Cannot change preallocation mode");
>              return -ENOTSUP;
>          } else if (!strcmp(desc->name, BLOCK_OPT_SIZE)) {
>              new_size = qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 0);
> @@ -4228,7 +4241,8 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>                                          !!s->crypto);
>  
>              if (encrypt != !!s->crypto) {
> -                error_report("Changing the encryption flag is not supported");
> +                error_setg(errp,
> +                           "Changing the encryption flag is not supported");
>                  return -ENOTSUP;
>              }
>          } else if (!strcmp(desc->name, BLOCK_OPT_ENCRYPT_FORMAT)) {
> @@ -4236,17 +4250,19 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>                  qemu_opt_get(opts, BLOCK_OPT_ENCRYPT_FORMAT));
>  
>              if (encformat != s->crypt_method_header) {
> -                error_report("Changing the encryption format is not supported");
> +                error_setg(errp,
> +                           "Changing the encryption format is not supported");
>                  return -ENOTSUP;
>              }
>          } else if (g_str_has_prefix(desc->name, "encrypt.")) {
> -            error_report("Changing the encryption parameters is not supported");
> +            error_setg(errp,
> +                       "Changing the encryption parameters is not supported");
>              return -ENOTSUP;
>          } else if (!strcmp(desc->name, BLOCK_OPT_CLUSTER_SIZE)) {
>              cluster_size = qemu_opt_get_size(opts, BLOCK_OPT_CLUSTER_SIZE,
>                                               cluster_size);
>              if (cluster_size != s->cluster_size) {
> -                error_report("Changing the cluster size is not supported");
> +                error_setg(errp, "Changing the cluster size is not supported");
>                  return -ENOTSUP;
>              }
>          } else if (!strcmp(desc->name, BLOCK_OPT_LAZY_REFCOUNTS)) {
> @@ -4259,8 +4275,8 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>              if (refcount_bits <= 0 || refcount_bits > 64 ||
>                  !is_power_of_2(refcount_bits))
>              {
> -                error_report("Refcount width must be a power of two and may "
> -                             "not exceed 64 bits");
> +                error_setg(errp, "Refcount width must be a power of two and "
> +                           "may not exceed 64 bits");
>                  return -EINVAL;
>              }
>          } else {
> @@ -4285,6 +4301,8 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>          ret = qcow2_update_header(bs);
>          if (ret < 0) {
>              s->qcow_version = old_version;
> +            error_setg(errp, "Failed to update the image header: %s",
> +                       strerror(-ret));
>              return ret;
>          }
>      }
> @@ -4293,18 +4311,17 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>          int refcount_order = ctz32(refcount_bits);
>  
>          if (new_version < 3 && refcount_bits != 16) {
> -            error_report("Different refcount widths than 16 bits require "
> -                         "compatibility level 1.1 or above (use compat=1.1 or "
> -                         "greater)");
> +            error_setg(errp, "Different refcount widths than 16 bits require "
> +                       "compatibility level 1.1 or above (use compat=1.1 or "
> +                       "greater)");
>              return -EINVAL;
>          }
>  
>          helper_cb_info.current_operation = QCOW2_CHANGING_REFCOUNT_ORDER;
>          ret = qcow2_change_refcount_order(bs, refcount_order,
>                                            &qcow2_amend_helper_cb,
> -                                          &helper_cb_info, &local_err);
> +                                          &helper_cb_info, errp);
>          if (ret < 0) {
> -            error_report_err(local_err);
>              return ret;
>          }
>      }
> @@ -4314,6 +4331,8 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>                      backing_file ?: s->image_backing_file,
>                      backing_format ?: s->image_backing_format);
>          if (ret < 0) {
> +            error_setg(errp, "Failed to change the backing file: %s",
> +                       strerror(-ret));
>              return ret;
>          }
>      }
> @@ -4321,14 +4340,17 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>      if (s->use_lazy_refcounts != lazy_refcounts) {
>          if (lazy_refcounts) {
>              if (new_version < 3) {
> -                error_report("Lazy refcounts only supported with compatibility "
> -                             "level 1.1 and above (use compat=1.1 or greater)");
> +                error_setg(errp, "Lazy refcounts only supported with "
> +                           "compatibility level 1.1 and above (use compat=1.1 "
> +                           "or greater)");
>                  return -EINVAL;
>              }
>              s->compatible_features |= QCOW2_COMPAT_LAZY_REFCOUNTS;
>              ret = qcow2_update_header(bs);
>              if (ret < 0) {
>                  s->compatible_features &= ~QCOW2_COMPAT_LAZY_REFCOUNTS;
> +                error_setg(errp, "Failed to update the image header: %s",
> +                           strerror(-ret));
>                  return ret;
>              }
>              s->use_lazy_refcounts = true;
> @@ -4336,6 +4358,8 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>              /* make image clean first */
>              ret = qcow2_mark_clean(bs);
>              if (ret < 0) {
> +                error_setg(errp, "Failed to make the image clean: %s",
> +                           strerror(-ret));
>                  return ret;
>              }
>              /* now disallow lazy refcounts */
> @@ -4343,6 +4367,8 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>              ret = qcow2_update_header(bs);
>              if (ret < 0) {
>                  s->compatible_features |= QCOW2_COMPAT_LAZY_REFCOUNTS;
> +                error_setg(errp, "Failed to update the image header: %s",
> +                           strerror(-ret));
>                  return ret;
>              }
>              s->use_lazy_refcounts = false;
> @@ -4351,17 +4377,15 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>  
>      if (new_size) {
>          BlockBackend *blk = blk_new(BLK_PERM_RESIZE, BLK_PERM_ALL);
> -        ret = blk_insert_bs(blk, bs, &local_err);
> +        ret = blk_insert_bs(blk, bs, errp);
>          if (ret < 0) {
> -            error_report_err(local_err);
>              blk_unref(blk);
>              return ret;
>          }
>  
> -        ret = blk_truncate(blk, new_size, PREALLOC_MODE_OFF, &local_err);
> +        ret = blk_truncate(blk, new_size, PREALLOC_MODE_OFF, errp);
>          blk_unref(blk);
>          if (ret < 0) {
> -            error_report_err(local_err);
>              return ret;
>          }
>      }
> @@ -4370,7 +4394,7 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>      if (new_version < old_version) {
>          helper_cb_info.current_operation = QCOW2_DOWNGRADING;
>          ret = qcow2_downgrade(bs, new_version, &qcow2_amend_helper_cb,
> -                              &helper_cb_info);
> +                              &helper_cb_info, errp);
>          if (ret < 0) {
>              return ret;
>          }
> diff --git a/qemu-img.c b/qemu-img.c
> index f60b22769e..375fe852e0 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3730,10 +3730,10 @@ static int img_amend(int argc, char **argv)
>  
>      /* In case the driver does not call amend_status_cb() */
>      qemu_progress_print(0.f, 0);
> -    ret = bdrv_amend_options(bs, opts, &amend_status_cb, NULL);
> +    ret = bdrv_amend_options(bs, opts, &amend_status_cb, NULL, &err);
>      qemu_progress_print(100.f, 0);
>      if (ret < 0) {
> -        error_report("Error while amending options: %s", strerror(-ret));
> +        error_report_err(err);
>          goto out;
>      }
>  
> diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
> index 25d5c3938b..5f4264cff6 100644
> --- a/tests/qemu-iotests/060.out
> +++ b/tests/qemu-iotests/060.out
> @@ -129,7 +129,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>  wrote 65536/65536 bytes at offset 0
>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  qcow2: Marking image as corrupt: L2 table offset 0x42a00 unaligned (L1 index: 0); further corruption events will be suppressed
> -qemu-img: Error while amending options: Input/output error
> +qemu-img: Failed to turn zero into data clusters: Input/output error
>  
>  === Testing unaligned L2 entry ===
>  
> @@ -145,7 +145,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>  wrote 65536/65536 bytes at offset 0
>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  qcow2: Marking image as corrupt: Cluster allocation offset 0x52a00 unaligned (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
> -qemu-img: Error while amending options: Input/output error
> +qemu-img: Failed to turn zero into data clusters: Input/output error
>  
>  === Testing unaligned reftable entry ===
>  
> diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
> index e857ef9a7d..183f7dd690 100644
> --- a/tests/qemu-iotests/061.out
> +++ b/tests/qemu-iotests/061.out
> @@ -358,18 +358,12 @@ No errors were found on the image.
>  
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>  qemu-img: Lazy refcounts only supported with compatibility level 1.1 and above (use compat=1.1 or greater)
> -qemu-img: Error while amending options: Invalid argument
>  qemu-img: Lazy refcounts only supported with compatibility level 1.1 and above (use compat=1.1 or greater)
> -qemu-img: Error while amending options: Invalid argument
>  qemu-img: Unknown compatibility level 0.42
> -qemu-img: Error while amending options: Invalid argument
>  qemu-img: Invalid parameter 'foo'
>  qemu-img: Changing the cluster size is not supported
> -qemu-img: Error while amending options: Operation not supported
>  qemu-img: Changing the encryption flag is not supported
> -qemu-img: Error while amending options: Operation not supported
>  qemu-img: Cannot change preallocation mode
> -qemu-img: Error while amending options: Operation not supported
>  
>  === Testing correct handling of unset value ===
>  
> @@ -377,7 +371,6 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>  Should work:
>  Should not work:
>  qemu-img: Changing the cluster size is not supported
> -qemu-img: Error while amending options: Operation not supported
>  
>  === Testing zero expansion on inactive clusters ===
>  
> diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
> index 4e0f7f7b92..281c7e0d1d 100644
> --- a/tests/qemu-iotests/080.out
> +++ b/tests/qemu-iotests/080.out
> @@ -65,7 +65,7 @@ wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  qemu-img: Failed to load snapshot: Snapshot L1 table offset invalid
>  qemu-img: Snapshot L1 table offset invalid
> -qemu-img: Error while amending options: Invalid argument
> +qemu-img: Failed to turn zero into data clusters: Invalid argument
>  Failed to flush the refcount block cache: Invalid argument
>  write failed: Invalid argument
>  qemu-img: Snapshot L1 table offset invalid
> @@ -88,7 +88,7 @@ wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  qemu-img: Failed to load snapshot: Snapshot L1 table too large
>  qemu-img: Snapshot L1 table too large
> -qemu-img: Error while amending options: File too large
> +qemu-img: Failed to turn zero into data clusters: File too large
>  Failed to flush the refcount block cache: File too large
>  write failed: File too large
>  qemu-img: Snapshot L1 table too large
> diff --git a/tests/qemu-iotests/112.out b/tests/qemu-iotests/112.out
> index 86f041075d..a23aa1be75 100644
> --- a/tests/qemu-iotests/112.out
> +++ b/tests/qemu-iotests/112.out
> @@ -99,13 +99,11 @@ refcount bits: 64
>  === Amend to compat=0.10 ===
>  
>  qemu-img: compat=0.10 requires refcount_bits=16
> -qemu-img: Error while amending options: Operation not supported
>  refcount bits: 64
>  No errors were found on the image.
>  refcount bits: 16
>  refcount bits: 16
>  qemu-img: Different refcount widths than 16 bits require compatibility level 1.1 or above (use compat=1.1 or greater)
> -qemu-img: Error while amending options: Invalid argument
>  refcount bits: 16
>  
>  === Amend with snapshot ===
> @@ -113,7 +111,6 @@ refcount bits: 16
>  wrote 16777216/16777216 bytes at offset 0
>  16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  qemu-img: Cannot decrease refcount entry width to 1 bits: Cluster at offset 0x50000 has a refcount of 2
> -qemu-img: Error while amending options: Invalid argument
>  No errors were found on the image.
>  refcount bits: 16
>  No errors were found on the image.
> 

1,2: Reviewed-by: John Snow <jsnow@redhat.com>

[I'll get to the rest.]
