Received: from eggs.gnu.org ([2001:4830:134:3::10]:33227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1evV2r-0003SQ-Sw
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1evV2q-0005KY-9H
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:31:49 -0400
Date: Mon, 12 Mar 2018 17:31:40 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180312213140.GG12302@localhost.localdomain>
References: <20180309214611.19122-1-kwolf@redhat.com>
	<20180309214611.19122-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309214611.19122-4-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/7] qcow: Support .bdrv_co_create
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

On Fri, Mar 09, 2018 at 10:46:07PM +0100, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to qcow, which
> enables image creation over QMP.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  21 +++++-
>  block/qcow.c         | 196 ++++++++++++++++++++++++++++++++++-----------------
>  2 files changed, 150 insertions(+), 67 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index d38058eeab..c81677c434 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3497,6 +3497,25 @@
>              '*cluster-size':    'size' } }
>  
>  ##
> +# @BlockdevCreateOptionsQcow:
> +#
> +# Driver specific image creation options for qcow.
> +#
> +# @file             Node to create the image format on
> +# @size             Size of the virtual disk in bytes
> +# @backing-file     File name of the backing file if a backing file
> +#                   should be used
> +# @encrypt          Encryption options if the image should be encrypted
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'BlockdevCreateOptionsQcow',
> +  'data': { 'file':             'BlockdevRef',
> +            'size':             'size',
> +            '*backing-file':    'str',
> +            '*encrypt':         'QCryptoBlockCreateOptions' } }
> +
> +##
>  # @BlockdevQcow2Version:
>  #
>  # @v2:  The original QCOW2 format as introduced in qemu 0.10 (version 2)
> @@ -3681,8 +3700,8 @@
>        'null-co':        'BlockdevCreateNotSupported',
>        'nvme':           'BlockdevCreateNotSupported',
>        'parallels':      'BlockdevCreateOptionsParallels',
> +      'qcow':           'BlockdevCreateOptionsQcow',
>        'qcow2':          'BlockdevCreateOptionsQcow2',
> -      'qcow':           'BlockdevCreateNotSupported',
>        'qed':            'BlockdevCreateNotSupported',
>        'quorum':         'BlockdevCreateNotSupported',
>        'raw':            'BlockdevCreateNotSupported',
> diff --git a/block/qcow.c b/block/qcow.c
> index 47a18d9a3a..2e3770ca63 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -33,6 +33,8 @@
>  #include <zlib.h>
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qstring.h"
> +#include "qapi/qobject-input-visitor.h"
> +#include "qapi/qapi-visit-block-core.h"
>  #include "crypto/block.h"
>  #include "migration/blocker.h"
>  #include "block/crypto.h"
> @@ -86,6 +88,8 @@ typedef struct BDRVQcowState {
>      Error *migration_blocker;
>  } BDRVQcowState;
>  
> +static QemuOptsList qcow_create_opts;
> +
>  static int decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset);
>  
>  static int qcow_probe(const uint8_t *buf, int buf_size, const char *filename)
> @@ -810,62 +814,50 @@ static void qcow_close(BlockDriverState *bs)
>      error_free(s->migration_blocker);
>  }
>  
> -static int coroutine_fn qcow_co_create_opts(const char *filename, QemuOpts *opts,
> -                                            Error **errp)
> +static int coroutine_fn qcow_co_create(BlockdevCreateOptions *opts,
> +                                       Error **errp)
>  {
> +    BlockdevCreateOptionsQcow *qcow_opts;
>      int header_size, backing_filename_len, l1_size, shift, i;
>      QCowHeader header;
>      uint8_t *tmp;
>      int64_t total_size = 0;
> -    char *backing_file = NULL;
> -    Error *local_err = NULL;
>      int ret;
> +    BlockDriverState *bs;
>      BlockBackend *qcow_blk;
> -    char *encryptfmt = NULL;
> -    QDict *options;
> -    QDict *encryptopts = NULL;
> -    QCryptoBlockCreateOptions *crypto_opts = NULL;
>      QCryptoBlock *crypto = NULL;
>  
> -    /* Read out options */
> -    total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
> -                          BDRV_SECTOR_SIZE);
> +    assert(opts->driver == BLOCKDEV_DRIVER_QCOW);
> +    qcow_opts = &opts->u.qcow;
> +
> +    /* Sanity checks */
> +    total_size = qcow_opts->size;
>      if (total_size == 0) {
>          error_setg(errp, "Image size is too small, cannot be zero length");
> -        ret = -EINVAL;
> -        goto cleanup;
> +        return -EINVAL;
>      }
>  
> -    backing_file = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
> -    encryptfmt = qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT_FORMAT);
> -    if (encryptfmt) {
> -        if (qemu_opt_get(opts, BLOCK_OPT_ENCRYPT)) {
> -            error_setg(errp, "Options " BLOCK_OPT_ENCRYPT " and "
> -                       BLOCK_OPT_ENCRYPT_FORMAT " are mutually exclusive");
> -            ret = -EINVAL;
> -            goto cleanup;
> -        }
> -    } else if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
> -        encryptfmt = g_strdup("aes");
> +    if (qcow_opts->has_encrypt &&
> +        qcow_opts->encrypt->format != Q_CRYPTO_BLOCK_FORMAT_QCOW)
> +    {
> +        error_setg(errp, "Unsupported encryption format");
> +        return -EINVAL;
>      }
>  
> -    ret = bdrv_create_file(filename, opts, &local_err);
> -    if (ret < 0) {
> -        error_propagate(errp, local_err);
> -        goto cleanup;
> +    /* Create BlockBackend to write to the image */
> +    bs = bdrv_open_blockdev_ref(qcow_opts->file, errp);
> +    if (bs == NULL) {
> +        return -EIO;
>      }
>  
> -    qcow_blk = blk_new_open(filename, NULL, NULL,
> -                            BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
> -                            &local_err);
> -    if (qcow_blk == NULL) {
> -        error_propagate(errp, local_err);
> -        ret = -EIO;
> -        goto cleanup;
> +    qcow_blk = blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
> +    ret = blk_insert_bs(qcow_blk, bs, errp);
> +    if (ret < 0) {
> +        goto exit;
>      }
> -
>      blk_set_allow_write_beyond_eof(qcow_blk, true);
>  
> +    /* Create image format */
>      ret = blk_truncate(qcow_blk, 0, PREALLOC_MODE_OFF, errp);
>      if (ret < 0) {
>          goto exit;
> @@ -877,16 +869,15 @@ static int coroutine_fn qcow_co_create_opts(const char *filename, QemuOpts *opts
>      header.size = cpu_to_be64(total_size);
>      header_size = sizeof(header);
>      backing_filename_len = 0;
> -    if (backing_file) {
> -        if (strcmp(backing_file, "fat:")) {
> +    if (qcow_opts->has_backing_file) {
> +        if (strcmp(qcow_opts->backing_file, "fat:")) {
>              header.backing_file_offset = cpu_to_be64(header_size);
> -            backing_filename_len = strlen(backing_file);
> +            backing_filename_len = strlen(qcow_opts->backing_file);
>              header.backing_file_size = cpu_to_be32(backing_filename_len);
>              header_size += backing_filename_len;
>          } else {
>              /* special backing file for vvfat */
> -            g_free(backing_file);
> -            backing_file = NULL;
> +            qcow_opts->has_backing_file = false;
>          }
>          header.cluster_bits = 9; /* 512 byte cluster to avoid copying
>                                      unmodified sectors */
> @@ -901,26 +892,10 @@ static int coroutine_fn qcow_co_create_opts(const char *filename, QemuOpts *opts
>  
>      header.l1_table_offset = cpu_to_be64(header_size);
>  
> -    options = qemu_opts_to_qdict(opts, NULL);
> -    qdict_extract_subqdict(options, &encryptopts, "encrypt.");
> -    QDECREF(options);
> -    if (encryptfmt) {
> -        if (!g_str_equal(encryptfmt, "aes")) {
> -            error_setg(errp, "Unknown encryption format '%s', expected 'aes'",
> -                       encryptfmt);
> -            ret = -EINVAL;
> -            goto exit;
> -        }
> +    if (qcow_opts->has_encrypt) {
>          header.crypt_method = cpu_to_be32(QCOW_CRYPT_AES);
>  
> -        crypto_opts = block_crypto_create_opts_init(
> -            Q_CRYPTO_BLOCK_FORMAT_QCOW, encryptopts, errp);
> -        if (!crypto_opts) {
> -            ret = -EINVAL;
> -            goto exit;
> -        }
> -
> -        crypto = qcrypto_block_create(crypto_opts, "encrypt.",
> +        crypto = qcrypto_block_create(qcow_opts->encrypt, "encrypt.",
>                                        NULL, NULL, NULL, errp);
>          if (!crypto) {
>              ret = -EINVAL;
> @@ -936,9 +911,9 @@ static int coroutine_fn qcow_co_create_opts(const char *filename, QemuOpts *opts
>          goto exit;
>      }
>  
> -    if (backing_file) {
> +    if (qcow_opts->has_backing_file) {
>          ret = blk_pwrite(qcow_blk, sizeof(header),
> -                         backing_file, backing_filename_len, 0);
> +                         qcow_opts->backing_file, backing_filename_len, 0);
>          if (ret != backing_filename_len) {
>              goto exit;
>          }
> @@ -959,12 +934,100 @@ static int coroutine_fn qcow_co_create_opts(const char *filename, QemuOpts *opts
>      ret = 0;
>  exit:
>      blk_unref(qcow_blk);
> -cleanup:
> -    QDECREF(encryptopts);
> -    g_free(encryptfmt);
>      qcrypto_block_free(crypto);
> -    qapi_free_QCryptoBlockCreateOptions(crypto_opts);
> -    g_free(backing_file);
> +    return ret;
> +}
> +
> +static int coroutine_fn qcow_co_create_opts(const char *filename,
> +                                            QemuOpts *opts, Error **errp)
> +{
> +    BlockdevCreateOptions *create_options = NULL;
> +    BlockDriverState *bs = NULL;
> +    QDict *qdict = NULL;
> +    QObject *qobj;
> +    Visitor *v;
> +    const char *val;
> +    Error *local_err = NULL;
> +    int ret;
> +
> +    static const QDictRenames opt_renames[] = {
> +        { BLOCK_OPT_BACKING_FILE,       "backing-file" },
> +        { BLOCK_OPT_ENCRYPT,            BLOCK_OPT_ENCRYPT_FORMAT },
> +        { NULL, NULL },
> +    };
> +
> +    /* Parse options and convert legacy syntax */
> +    qdict = qemu_opts_to_qdict_filtered(opts, NULL, &qcow_create_opts, true);
> +
> +    val = qdict_get_try_str(qdict, BLOCK_OPT_ENCRYPT);
> +    if (val && !strcmp(val, "on")) {
> +        qdict_put_str(qdict, BLOCK_OPT_ENCRYPT, "qcow");
> +    } else if (val && !strcmp(val, "off")) {
> +        qdict_del(qdict, BLOCK_OPT_ENCRYPT);
> +    }
> +
> +    val = qdict_get_try_str(qdict, BLOCK_OPT_ENCRYPT_FORMAT);
> +    if (val && !strcmp(val, "aes")) {
> +        qdict_put_str(qdict, BLOCK_OPT_ENCRYPT_FORMAT, "qcow");
> +    }
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
> +    qdict_put_str(qdict, "driver", "qcow");
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
> +    assert(create_options->driver == BLOCKDEV_DRIVER_QCOW);
> +    create_options->u.qcow.size =
> +        ROUND_UP(create_options->u.qcow.size, BDRV_SECTOR_SIZE);
> +
> +    /* Create the qcow image (format layer) */
> +    ret = qcow_co_create(create_options, errp);
> +    if (ret < 0) {
> +        goto fail;
> +    }
> +
> +    ret = 0;
> +fail:
> +    QDECREF(qdict);
> +    bdrv_unref(bs);
> +    qapi_free_BlockdevCreateOptions(create_options);
>      return ret;
>  }
>  
> @@ -1128,6 +1191,7 @@ static BlockDriver bdrv_qcow = {
>      .bdrv_close		= qcow_close,
>      .bdrv_child_perm        = bdrv_format_default_perms,
>      .bdrv_reopen_prepare    = qcow_reopen_prepare,
> +    .bdrv_co_create         = qcow_co_create,
>      .bdrv_co_create_opts    = qcow_co_create_opts,
>      .bdrv_has_zero_init     = bdrv_has_zero_init_1,
>      .supports_backing       = true,
> -- 
> 2.13.6
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>
