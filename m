Received: from eggs.gnu.org ([2001:4830:134:3::10]:33451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1evTGX-0001jG-Js
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 15:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1evTGW-0006tE-4Y
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 15:37:49 -0400
Date: Mon, 12 Mar 2018 15:37:25 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180312193725.GA30596@localhost.localdomain>
References: <20180309214611.19122-1-kwolf@redhat.com>
	<20180309214611.19122-7-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309214611.19122-7-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/7] vhdx: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, den@openvz.org, eblake@redhat.com, qemu-devel@nongnu.org

On Fri, Mar 09, 2018 at 10:46:10PM +0100, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to vhdx, which
> enables image creation over QMP.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  37 ++++++++++-
>  block/vhdx.c         | 174 ++++++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 167 insertions(+), 44 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 2eba0eef7e..3a65909c47 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3699,6 +3699,41 @@
>              '*static':          'bool' } }
>  
>  ##
> +# @BlockdevVhdxSubformat:
> +#
> +# @dynamic: Growing image file
> +# @fixed:   Preallocated fixed-size imge file

s/imge/image

> +#
> +# Since: 2.12
> +##
> +{ 'enum': 'BlockdevVhdxSubformat',
> +  'data': [ 'dynamic', 'fixed' ] }
> +
> +##
> +# @BlockdevCreateOptionsVhdx:
> +#
> +# Driver specific image creation options for vhdx.
> +#
> +# @file             Node to create the image format on
> +# @size             Size of the virtual disk in bytes
> +# @log-size         Log size in bytes (default: 1 MB)
> +# @block-size       Block size in bytes (default: 1 MB)
> +# @subformat        vhdx subformat (default: dynamic)
> +# @block-state-zero Force use of payload blocks of type 'ZERO'. Non-standard,
> +#                   but default.  Do not set to 'off' when using 'qemu-img
> +#                   convert' with subformat=dynamic.
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'BlockdevCreateOptionsVhdx',
> +  'data': { 'file':                 'BlockdevRef',
> +            'size':                 'size',
> +            '*log-size':            'size',
> +            '*block-size':          'size',
> +            '*subformat':           'BlockdevVhdxSubformat',
> +            '*block-state-zero':    'bool' } }
> +
> +##
>  # @BlockdevCreateNotSupported:
>  #
>  # This is used for all drivers that don't support creating images.
> @@ -3753,7 +3788,7 @@
>        'ssh':            'BlockdevCreateOptionsSsh',
>        'throttle':       'BlockdevCreateNotSupported',
>        'vdi':            'BlockdevCreateOptionsVdi',
> -      'vhdx':           'BlockdevCreateNotSupported',
> +      'vhdx':           'BlockdevCreateOptionsVhdx',
>        'vmdk':           'BlockdevCreateNotSupported',
>        'vpc':            'BlockdevCreateNotSupported',
>        'vvfat':          'BlockdevCreateNotSupported',
> diff --git a/block/vhdx.c b/block/vhdx.c
> index d82350d07c..0ce972381f 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -26,6 +26,9 @@
>  #include "block/vhdx.h"
>  #include "migration/blocker.h"
>  #include "qemu/uuid.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/qobject-input-visitor.h"
> +#include "qapi/qapi-visit-block-core.h"
>  
>  /* Options for VHDX creation */
>  
> @@ -39,6 +42,8 @@ typedef enum VHDXImageType {
>      VHDX_TYPE_DIFFERENCING,   /* Currently unsupported */
>  } VHDXImageType;
>  
> +static QemuOptsList vhdx_create_opts;
> +
>  /* Several metadata and region table data entries are identified by
>   * guids in  a MS-specific GUID format. */
>  
> @@ -1792,54 +1797,63 @@ exit:
>   *    .---- ~ ----------- ~ ------------ ~ ---------------- ~ -----------.
>   *   1MB
>   */
> -static int coroutine_fn vhdx_co_create_opts(const char *filename, QemuOpts *opts,
> -                                            Error **errp)
> +static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
> +                                       Error **errp)
>  {
> +    BlockdevCreateOptionsVhdx *vhdx_opts;
> +    BlockBackend *blk = NULL;
> +    BlockDriverState *bs = NULL;
> +
>      int ret = 0;
> -    uint64_t image_size = (uint64_t) 2 * GiB;
> -    uint32_t log_size   = 1 * MiB;
> -    uint32_t block_size = 0;
> +    uint64_t image_size;
> +    uint32_t log_size;
> +    uint32_t block_size;
>      uint64_t signature;
>      uint64_t metadata_offset;
>      bool use_zero_blocks = false;
>  
>      gunichar2 *creator = NULL;
>      glong creator_items;
> -    BlockBackend *blk;
> -    char *type = NULL;
>      VHDXImageType image_type;
> -    Error *local_err = NULL;
>  
> -    image_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
> -                          BDRV_SECTOR_SIZE);
> -    log_size = qemu_opt_get_size_del(opts, VHDX_BLOCK_OPT_LOG_SIZE, 0);
> -    block_size = qemu_opt_get_size_del(opts, VHDX_BLOCK_OPT_BLOCK_SIZE, 0);
> -    type = qemu_opt_get_del(opts, BLOCK_OPT_SUBFMT);
> -    use_zero_blocks = qemu_opt_get_bool_del(opts, VHDX_BLOCK_OPT_ZERO, true);
> +    assert(opts->driver == BLOCKDEV_DRIVER_VHDX);
> +    vhdx_opts = &opts->u.vhdx;
> +
> +    /* Validate options and set default values */
> +
> +    image_size = vhdx_opts->size;
> +    block_size = vhdx_opts->block_size;
> +
> +    if (!vhdx_opts->has_log_size) {
> +        log_size = DEFAULT_LOG_SIZE;
> +    } else {
> +        log_size = vhdx_opts->log_size;
> +    }
> +
> +    if (!vhdx_opts->has_block_state_zero) {
> +        use_zero_blocks = true;
> +    } else {
> +        use_zero_blocks = vhdx_opts->block_state_zero;
> +    }
>  
>      if (image_size > VHDX_MAX_IMAGE_SIZE) {
>          error_setg_errno(errp, EINVAL, "Image size too large; max of 64TB");
> -        ret = -EINVAL;
> -        goto exit;
> +        return -EINVAL;
>      }
>  
> -    if (type == NULL) {
> -        type = g_strdup("dynamic");
> +    if (!vhdx_opts->has_subformat) {
> +        vhdx_opts->subformat = BLOCKDEV_VHDX_SUBFORMAT_DYNAMIC;
>      }
>  
> -    if (!strcmp(type, "dynamic")) {
> +    switch (vhdx_opts->subformat) {
> +    case BLOCKDEV_VHDX_SUBFORMAT_DYNAMIC:
>          image_type = VHDX_TYPE_DYNAMIC;
> -    } else if (!strcmp(type, "fixed")) {
> +        break;
> +    case BLOCKDEV_VHDX_SUBFORMAT_FIXED:
>          image_type = VHDX_TYPE_FIXED;
> -    } else if (!strcmp(type, "differencing")) {
> -        error_setg_errno(errp, ENOTSUP,
> -                         "Differencing files not yet supported");

Just a comment, a minor change will be we no longer recognize that there is
a difference format, but will have a generic error.  I think that is fine.

> -        ret = -ENOTSUP;
> -        goto exit;
> -    } else {
> -        error_setg(errp, "Invalid subformat '%s'", type);
> -        ret = -EINVAL;
> -        goto exit;
> +        break;
> +    default:
> +        g_assert_not_reached();
>      }
>  
>      /* These are pretty arbitrary, and mainly designed to keep the BAT
> @@ -1865,21 +1879,17 @@ static int coroutine_fn vhdx_co_create_opts(const char *filename, QemuOpts *opts
>      block_size = block_size > VHDX_BLOCK_SIZE_MAX ? VHDX_BLOCK_SIZE_MAX :
>                                                      block_size;
>  
> -    ret = bdrv_create_file(filename, opts, &local_err);
> -    if (ret < 0) {
> -        error_propagate(errp, local_err);
> -        goto exit;
> +    /* Create BlockBackend to write to the image */
> +    bs = bdrv_open_blockdev_ref(vhdx_opts->file, errp);
> +    if (bs == NULL) {
> +        return -EIO;
>      }
>  
> -    blk = blk_new_open(filename, NULL, NULL,
> -                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
> -                       &local_err);
> -    if (blk == NULL) {
> -        error_propagate(errp, local_err);
> -        ret = -EIO;
> -        goto exit;
> +    blk = blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
> +    ret = blk_insert_bs(blk, bs, errp);
> +    if (ret < 0) {
> +        goto delete_and_exit;
>      }
> -
>      blk_set_allow_write_beyond_eof(blk, true);
>  
>      /* Create (A) */
> @@ -1931,12 +1941,89 @@ static int coroutine_fn vhdx_co_create_opts(const char *filename, QemuOpts *opts
>  
>  delete_and_exit:
>      blk_unref(blk);
> -exit:
> -    g_free(type);
> +    bdrv_unref(bs);
>      g_free(creator);
>      return ret;
>  }
>  
> +static int coroutine_fn vhdx_co_create_opts(const char *filename,
> +                                            QemuOpts *opts,
> +                                            Error **errp)
> +{
> +    BlockdevCreateOptions *create_options = NULL;
> +    QDict *qdict = NULL;
> +    QObject *qobj;
> +    Visitor *v;
> +    BlockDriverState *bs = NULL;
> +    Error *local_err = NULL;
> +    int ret;
> +
> +    static const QDictRenames opt_renames[] = {
> +        { VHDX_BLOCK_OPT_LOG_SIZE,      "log-size" },
> +        { VHDX_BLOCK_OPT_BLOCK_SIZE,    "block-size" },
> +        { VHDX_BLOCK_OPT_ZERO,          "block-state-zero" },
> +        { NULL, NULL },
> +    };
> +
> +    /* Parse options and convert legacy syntax */
> +    qdict = qemu_opts_to_qdict_filtered(opts, NULL, &vhdx_create_opts, true);
> +
> +    if (!qdict_rename_keys(qdict, opt_renames, errp)) {
> +        ret = -EINVAL;
> +        goto fail;
> +    }
> +
> +    /* Create and open the file (protocol layer) */
> +    ret = bdrv_create_file(filename, opts, &local_err);
> +    if (ret < 0) {
> +        error_propagate(errp, local_err);
> +        goto fail;
> +    }
> +
> +    bs = bdrv_open(filename, NULL, NULL,
> +                   BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL, errp);
> +    if (bs == NULL) {
> +        ret = -EIO;
> +        goto fail;
> +    }
> +
> +    /* Now get the QAPI type BlockdevCreateOptions */
> +    qdict_put_str(qdict, "driver", "vhdx");
> +    qdict_put_str(qdict, "file", bs->node_name);
> +
> +    qobj = qdict_crumple(qdict, errp);
> +    QDECREF(qdict);
> +    qdict = qobject_to_qdict(qobj);
> +    if (qdict == NULL) {
> +        ret = -EINVAL;
> +        goto fail;
> +    }
> +
> +    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
> +    visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
> +    visit_free(v);
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        ret = -EINVAL;
> +        goto fail;
> +    }
> +
> +    /* Silently round up size */
> +    assert(create_options->driver == BLOCKDEV_DRIVER_VHDX);
> +    create_options->u.vhdx.size =
> +        ROUND_UP(create_options->u.vhdx.size, BDRV_SECTOR_SIZE);
> +
> +    /* Create the vhdx image (format layer) */
> +    ret = vhdx_co_create(create_options, errp);
> +
> +fail:
> +    QDECREF(qdict);
> +    bdrv_unref(bs);
> +    qapi_free_BlockdevCreateOptions(create_options);
> +    return ret;
> +}
> +
>  /* If opened r/w, the VHDX driver will automatically replay the log,
>   * if one is present, inside the vhdx_open() call.
>   *
> @@ -2005,6 +2092,7 @@ static BlockDriver bdrv_vhdx = {
>      .bdrv_child_perm        = bdrv_format_default_perms,
>      .bdrv_co_readv          = vhdx_co_readv,
>      .bdrv_co_writev         = vhdx_co_writev,
> +    .bdrv_co_create         = vhdx_co_create,
>      .bdrv_co_create_opts    = vhdx_co_create_opts,
>      .bdrv_get_info          = vhdx_get_info,
>      .bdrv_co_check          = vhdx_co_check,
> -- 
> 2.13.6
> 

VHDX image files created look correct, so aside from the minor typo:

Reviewed-by: Jeff Cody <jcody@redhat.com>
