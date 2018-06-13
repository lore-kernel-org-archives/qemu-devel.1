Received: from eggs.gnu.org ([2001:4830:134:3::10]:37967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSzxf-0003g0-Iv
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSzxd-0006kv-4m
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:12:55 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180515153634.5868-1-famz@redhat.com>
	<20180515153634.5868-3-famz@redhat.com>
Date: Wed, 13 Jun 2018 09:12:40 +0200
In-Reply-To: <20180515153634.5868-3-famz@redhat.com> (Fam Zheng's message of
	"Tue, 15 May 2018 23:36:32 +0800")
Message-ID: <874li7kvmf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/4] vmdk: Implement .bdrv_co_create
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

Still only looking at QAPI-related aspects.

Fam Zheng <famz@redhat.com> writes:

> This makes VMDK support x-blockdev-create. The implementation reuses the
> image creation code in vmdk_co_create_opts which now acceptes a callback
> pointer to "retrieve" BlockBackend pointers from the caller. This way we
> separate the logic between file/extent acquisition and initialization.
>
> The QAPI command parameters are mostly the same as the old create_opts
> except the dropped legacy @compat6 switch, which is redundant with
> @hwversion.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/vmdk.c          | 461 ++++++++++++++++++++++++++++++++++++--------------
>  qapi/block-core.json  |  67 +++++++-
>  qapi/qapi-schema.json |   1 +
>  3 files changed, 399 insertions(+), 130 deletions(-)
>
> diff --git a/block/vmdk.c b/block/vmdk.c
> index 083942f806..ae121b36e0 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -1905,38 +1905,68 @@ static int filename_decompose(const char *filename, char *path, char *prefix,
>      return VMDK_OK;
>  }
>  
> -static int coroutine_fn vmdk_co_create_opts(const char *filename, QemuOpts *opts,
> -                                            Error **errp)
> +/*
> + * idx == 0: get or create the descriptor file (also the image file if in a
> + *           non-split format.
> + * idx >= 1: get the n-th extent if in a split subformat
> + */
> +typedef BlockBackend *(*vmdk_create_extent_fn)(int64_t size,
> +                                               int idx,
> +                                               bool flat,
> +                                               bool split,
> +                                               bool compress,
> +                                               bool zeroed_grain,
> +                                               void *opaque,
> +                                               Error **errp);
> +
> +static void vmdk_desc_add_extent(GString *desc,
> +                                 const char *extent_line_fmt,
> +                                 int64_t size, const char *filename)
>  {
> -    int idx = 0;
> -    BlockBackend *new_blk = NULL;
> +    char *desc_line = g_malloc0(BUF_SIZE);
> +    const char *basename = strrchr(filename, '/');
> +    if (!basename) {
> +        basename = filename;
> +    } else {
> +        basename += 1;
> +    }

g_path_get_basename()?

> +    snprintf(desc_line, BUF_SIZE, extent_line_fmt,
> +             DIV_ROUND_UP(size, BDRV_SECTOR_SIZE),
> +             basename);
> +    g_string_append(desc, desc_line);
> +    g_free(desc_line);

g_string_append_printf()?

> +}
> +
> +static int coroutine_fn vmdk_co_do_create(int64_t size,
> +                                          BlockdevVmdkSubformat subformat,
> +                                          BlockdevVmdkAdapterType adapter_type,
> +                                          const char *backing_file,
> +                                          const char *hw_version,
> +                                          bool compat6,
> +                                          bool zeroed_grain,
> +                                          vmdk_create_extent_fn extent_fn,
> +                                          void *opaque,
> +                                          Error **errp)
> +{
> +    int extent_idx;
> +    BlockBackend *blk = NULL;
>      Error *local_err = NULL;
>      char *desc = NULL;
> -    int64_t total_size = 0, filesize;
> -    char *adapter_type = NULL;
> -    char *backing_file = NULL;
> -    char *hw_version = NULL;
> -    char *fmt = NULL;
>      int ret = 0;
>      bool flat, split, compress;
>      GString *ext_desc_lines;
> -    char *path = g_malloc0(PATH_MAX);
> -    char *prefix = g_malloc0(PATH_MAX);
> -    char *postfix = g_malloc0(PATH_MAX);
> -    char *desc_line = g_malloc0(BUF_SIZE);
> -    char *ext_filename = g_malloc0(PATH_MAX);
> -    char *desc_filename = g_malloc0(PATH_MAX);
>      const int64_t split_size = 0x80000000;  /* VMDK has constant split size */
> -    const char *desc_extent_line;
> +    int64_t extent_size;
> +    int64_t created_size = 0;
> +    const char *extent_line_fmt;
>      char *parent_desc_line = g_malloc0(BUF_SIZE);
>      uint32_t parent_cid = 0xffffffff;
>      uint32_t number_heads = 16;
> -    bool zeroed_grain = false;
>      uint32_t desc_offset = 0, desc_len;
>      const char desc_template[] =
>          "# Disk DescriptorFile\n"
>          "version=1\n"
> -        "CID=%" PRIx32 "\n"
> +        "CID=%08" PRIx32 "\n"

Didn't you want to back out this one?

>          "parentCID=%" PRIx32 "\n"
>          "createType=\"%s\"\n"
>          "%s"
> @@ -1955,71 +1985,35 @@ static int coroutine_fn vmdk_co_create_opts(const char *filename, QemuOpts *opts
>  
>      ext_desc_lines = g_string_new(NULL);
>  
> -    if (filename_decompose(filename, path, prefix, postfix, PATH_MAX, errp)) {
> -        ret = -EINVAL;
> -        goto exit;
> -    }
>      /* Read out options */
> -    total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
> -                          BDRV_SECTOR_SIZE);
> -    adapter_type = qemu_opt_get_del(opts, BLOCK_OPT_ADAPTER_TYPE);
> -    backing_file = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
> -    hw_version = qemu_opt_get_del(opts, BLOCK_OPT_HWVERSION);
> -    if (qemu_opt_get_bool_del(opts, BLOCK_OPT_COMPAT6, false)) {
> -        if (strcmp(hw_version, "undefined")) {
> +    if (compat6) {
> +        if (hw_version) {
>              error_setg(errp,
>                         "compat6 cannot be enabled with hwversion set");
>              ret = -EINVAL;
>              goto exit;
>          }
> -        g_free(hw_version);
> -        hw_version = g_strdup("6");
> +        hw_version = "6";
>      }
> -    if (strcmp(hw_version, "undefined") == 0) {
> -        g_free(hw_version);
> -        hw_version = g_strdup("4");
> -    }
> -    fmt = qemu_opt_get_del(opts, BLOCK_OPT_SUBFMT);
> -    if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ZEROED_GRAIN, false)) {
> -        zeroed_grain = true;
> +    if (!hw_version) {
> +        hw_version = "4";
>      }
>  
> -    if (!adapter_type) {
> -        adapter_type = g_strdup("ide");
> -    } else if (strcmp(adapter_type, "ide") &&
> -               strcmp(adapter_type, "buslogic") &&
> -               strcmp(adapter_type, "lsilogic") &&
> -               strcmp(adapter_type, "legacyESX")) {
> -        error_setg(errp, "Unknown adapter type: '%s'", adapter_type);
> -        ret = -EINVAL;
> -        goto exit;
> -    }
> -    if (strcmp(adapter_type, "ide") != 0) {
> +    if (adapter_type != BLOCKDEV_VMDK_ADAPTER_TYPE_IDE) {
>          /* that's the number of heads with which vmware operates when
>             creating, exporting, etc. vmdk files with a non-ide adapter type */
>          number_heads = 255;
>      }
> -    if (!fmt) {
> -        /* Default format to monolithicSparse */
> -        fmt = g_strdup("monolithicSparse");
> -    } else if (strcmp(fmt, "monolithicFlat") &&
> -               strcmp(fmt, "monolithicSparse") &&
> -               strcmp(fmt, "twoGbMaxExtentSparse") &&
> -               strcmp(fmt, "twoGbMaxExtentFlat") &&
> -               strcmp(fmt, "streamOptimized")) {
> -        error_setg(errp, "Unknown subformat: '%s'", fmt);
> -        ret = -EINVAL;
> -        goto exit;
> -    }
> -    split = !(strcmp(fmt, "twoGbMaxExtentFlat") &&
> -              strcmp(fmt, "twoGbMaxExtentSparse"));
> -    flat = !(strcmp(fmt, "monolithicFlat") &&
> -             strcmp(fmt, "twoGbMaxExtentFlat"));
> -    compress = !strcmp(fmt, "streamOptimized");
> +    split = (subformat == BLOCKDEV_VMDK_SUBFORMAT_TWOGBMAXEXTENTFLAT) ||
> +            (subformat == BLOCKDEV_VMDK_SUBFORMAT_TWOGBMAXEXTENTSPARSE);
> +    flat = (subformat == BLOCKDEV_VMDK_SUBFORMAT_MONOLITHICFLAT) ||
> +           (subformat == BLOCKDEV_VMDK_SUBFORMAT_TWOGBMAXEXTENTFLAT);
> +    compress = subformat == BLOCKDEV_VMDK_SUBFORMAT_STREAMOPTIMIZED;
> +
>      if (flat) {
> -        desc_extent_line = "RW %" PRId64 " FLAT \"%s\" 0\n";
> +        extent_line_fmt = "RW %" PRId64 " FLAT \"%s\" 0\n";
>      } else {
> -        desc_extent_line = "RW %" PRId64 " SPARSE \"%s\"\n";
> +        extent_line_fmt = "RW %" PRId64 " SPARSE \"%s\"\n";
>      }
>      if (flat && backing_file) {
>          error_setg(errp, "Flat image can't have backing file");
> @@ -2031,10 +2025,34 @@ static int coroutine_fn vmdk_co_create_opts(const char *filename, QemuOpts *opts
>          ret = -ENOTSUP;
>          goto exit;
>      }
> +
> +    /* Create extents */
> +    if (split) {
> +        extent_size = split_size;
> +    } else {
> +        extent_size = size;
> +    }
> +    if (!split && !flat) {
> +        created_size = extent_size;
> +    } else {
> +        created_size = 0;
> +    }
> +    /* Get the descriptor file BDS */
> +    blk = extent_fn(created_size, 0, flat, split, compress, zeroed_grain,
> +                    opaque, errp);
> +    if (!blk) {
> +        ret = -EIO;
> +        goto exit;
> +    }
> +    if (!split && !flat) {
> +        vmdk_desc_add_extent(ext_desc_lines, extent_line_fmt, created_size,
> +                             blk_bs(blk)->filename);
> +    }
> +
>      if (backing_file) {
> -        BlockBackend *blk;
> +        BlockBackend *backing;
>          char *full_backing = g_new0(char, PATH_MAX);
> -        bdrv_get_full_backing_filename_from_filename(filename, backing_file,
> +        bdrv_get_full_backing_filename_from_filename(blk_bs(blk)->filename, backing_file,
>                                                       full_backing, PATH_MAX,
>                                                       &local_err);
>          if (local_err) {
> @@ -2044,93 +2062,66 @@ static int coroutine_fn vmdk_co_create_opts(const char *filename, QemuOpts *opts
>              goto exit;
>          }
>  
> -        blk = blk_new_open(full_backing, NULL, NULL,
> -                           BDRV_O_NO_BACKING, errp);
> +        backing = blk_new_open(full_backing, NULL, NULL,
> +                               BDRV_O_NO_BACKING, errp);
>          g_free(full_backing);
> -        if (blk == NULL) {
> +        if (backing == NULL) {
>              ret = -EIO;
>              goto exit;
>          }
> -        if (strcmp(blk_bs(blk)->drv->format_name, "vmdk")) {
> -            blk_unref(blk);
> +        if (strcmp(blk_bs(backing)->drv->format_name, "vmdk")) {
> +            error_setg(errp, "Invalid backing file format: %s. Must be vmdk",
> +                       blk_bs(backing)->drv->format_name);
> +            blk_unref(backing);
>              ret = -EINVAL;
>              goto exit;
>          }
> -        ret = vmdk_read_cid(blk_bs(blk), 0, &parent_cid);
> -        blk_unref(blk);
> +        ret = vmdk_read_cid(blk_bs(backing), 0, &parent_cid);
> +        blk_unref(backing);
>          if (ret) {
> +            error_setg(errp, "Failed to read parent CID");
>              goto exit;
>          }
>          snprintf(parent_desc_line, BUF_SIZE,
>                  "parentFileNameHint=\"%s\"", backing_file);
>      }
> -
> -    /* Create extents */
> -    filesize = total_size;
> -    while (filesize > 0) {
> -        int64_t size = filesize;
> -
> -        if (split && size > split_size) {
> -            size = split_size;
> -        }
> -        if (split) {
> -            snprintf(desc_filename, PATH_MAX, "%s-%c%03d%s",
> -                    prefix, flat ? 'f' : 's', ++idx, postfix);
> -        } else if (flat) {
> -            snprintf(desc_filename, PATH_MAX, "%s-flat%s", prefix, postfix);
> -        } else {
> -            snprintf(desc_filename, PATH_MAX, "%s%s", prefix, postfix);
> -        }
> -        snprintf(ext_filename, PATH_MAX, "%s%s", path, desc_filename);
> -
> -        if (vmdk_create_extent(ext_filename, size,
> -                               flat, compress, zeroed_grain, NULL, opts, errp)) {
> +    extent_idx = 1;
> +    while (created_size < size) {
> +        BlockBackend *extent_blk;
> +        int64_t cur_size = MIN(size - created_size, extent_size);
> +        extent_blk = extent_fn(cur_size, extent_idx, flat, split, compress,
> +                               zeroed_grain, opaque, errp);
> +        if (!extent_blk) {
>              ret = -EINVAL;
>              goto exit;
>          }
> -        filesize -= size;
> -
> -        /* Format description line */
> -        snprintf(desc_line, BUF_SIZE,
> -                    desc_extent_line, size / BDRV_SECTOR_SIZE, desc_filename);
> -        g_string_append(ext_desc_lines, desc_line);
> +        vmdk_desc_add_extent(ext_desc_lines, extent_line_fmt, cur_size,
> +                             blk_bs(extent_blk)->filename);
> +        created_size += cur_size;
> +        extent_idx++;
> +        blk_unref(extent_blk);
>      }
>      /* generate descriptor file */
>      desc = g_strdup_printf(desc_template,
>                             g_random_int(),
>                             parent_cid,
> -                           fmt,
> +                           qapi_enum_lookup(&BlockdevVmdkSubformat_lookup,
> +                                            subformat),

Please use BlockdevVmdkSubformat_str(subformat).

>                             parent_desc_line,
>                             ext_desc_lines->str,
>                             hw_version,
> -                           total_size /
> +                           size /
>                                 (int64_t)(63 * number_heads * BDRV_SECTOR_SIZE),
>                             number_heads,
> -                           adapter_type);
> +                           qapi_enum_lookup(&BlockdevVmdkAdapterType_lookup,
> +                                            adapter_type));

BlockdevVmdkAdapterType_str(adapter_type)

>      desc_len = strlen(desc);
>      /* the descriptor offset = 0x200 */
>      if (!split && !flat) {
>          desc_offset = 0x200;
> -    } else {
> -        ret = bdrv_create_file(filename, opts, &local_err);
> -        if (ret < 0) {
> -            error_propagate(errp, local_err);
> -            goto exit;
> -        }
>      }
>  
> -    new_blk = blk_new_open(filename, NULL, NULL,
> -                           BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
> -                           &local_err);
> -    if (new_blk == NULL) {
> -        error_propagate(errp, local_err);
> -        ret = -EIO;
> -        goto exit;
> -    }
> -
> -    blk_set_allow_write_beyond_eof(new_blk, true);
> -
> -    ret = blk_pwrite(new_blk, desc_offset, desc, desc_len, 0);
> +    ret = blk_pwrite(blk, desc_offset, desc, desc_len, 0);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret, "Could not write description");
>          goto exit;
> @@ -2138,12 +2129,146 @@ static int coroutine_fn vmdk_co_create_opts(const char *filename, QemuOpts *opts
>      /* bdrv_pwrite write padding zeros to align to sector, we don't need that
>       * for description file */
>      if (desc_offset == 0) {
> -        ret = blk_truncate(new_blk, desc_len, PREALLOC_MODE_OFF, errp);
> +        ret = blk_truncate(blk, desc_len, PREALLOC_MODE_OFF, errp);
>      }
>  exit:
> -    if (new_blk) {
> -        blk_unref(new_blk);
> +    if (blk) {
> +        blk_unref(blk);
>      }
> +    g_free(desc);
> +    g_free(parent_desc_line);
> +    g_string_free(ext_desc_lines, true);
> +    return ret;
> +}
> +
> +typedef struct {
> +    char *path;
> +    char *prefix;
> +    char *postfix;
> +    QemuOpts *opts;
> +} VMDKCreateOptsData;
> +
> +static BlockBackend *vmdk_co_create_opts_cb(int64_t size, int idx,
> +                                            bool flat, bool split, bool compress,
> +                                            bool zeroed_grain, void *opaque,
> +                                            Error **errp)
> +{
> +    BlockBackend *blk = NULL;
> +    BlockDriverState *bs = NULL;
> +    VMDKCreateOptsData *data = opaque;
> +    char *ext_filename = NULL;
> +    char *rel_filename = NULL;
> +
> +    if (idx == 0) {
> +        rel_filename = g_strdup_printf("%s%s", data->prefix, data->postfix);
> +    } else if (split) {
> +        rel_filename = g_strdup_printf("%s-%c%03d%s",
> +                                       data->prefix,
> +                                       flat ? 'f' : 's', idx, data->postfix);
> +    } else {
> +        assert(idx == 1);
> +        rel_filename = g_strdup_printf("%s-flat%s", data->prefix, data->postfix);
> +    }
> +
> +    ext_filename = g_strdup_printf("%s%s", data->path, rel_filename);
> +    g_free(rel_filename);
> +
> +    if (vmdk_create_extent(ext_filename, size,
> +                           flat, compress, zeroed_grain, &blk, data->opts,
> +                           errp)) {
> +        goto exit;
> +    }
> +    bdrv_unref(bs);
> +exit:
> +    g_free(ext_filename);
> +    return blk;
> +}
> +
> +static int coroutine_fn vmdk_co_create_opts(const char *filename, QemuOpts *opts,
> +                                            Error **errp)
> +{
> +    Error *local_err = NULL;
> +    char *desc = NULL;
> +    int64_t total_size = 0;
> +    char *adapter_type = NULL;
> +    BlockdevVmdkAdapterType adapter_type_enum;
> +    char *backing_file = NULL;
> +    char *hw_version = NULL;
> +    char *fmt = NULL;
> +    BlockdevVmdkSubformat subformat;
> +    int ret = 0;
> +    char *path = g_malloc0(PATH_MAX);
> +    char *prefix = g_malloc0(PATH_MAX);
> +    char *postfix = g_malloc0(PATH_MAX);
> +    char *desc_line = g_malloc0(BUF_SIZE);
> +    char *ext_filename = g_malloc0(PATH_MAX);
> +    char *desc_filename = g_malloc0(PATH_MAX);
> +    char *parent_desc_line = g_malloc0(BUF_SIZE);
> +    bool zeroed_grain;
> +    bool compat6;
> +    int i;
> +    VMDKCreateOptsData data;
> +
> +    if (filename_decompose(filename, path, prefix, postfix, PATH_MAX, errp)) {
> +        ret = -EINVAL;
> +        goto exit;
> +    }
> +    /* Read out options */
> +    total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
> +                          BDRV_SECTOR_SIZE);
> +    adapter_type = qemu_opt_get_del(opts, BLOCK_OPT_ADAPTER_TYPE);
> +    backing_file = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
> +    hw_version = qemu_opt_get_del(opts, BLOCK_OPT_HWVERSION);
> +    compat6 = qemu_opt_get_bool_del(opts, BLOCK_OPT_COMPAT6, false);
> +    if (strcmp(hw_version, "undefined") == 0) {
> +        g_free(hw_version);
> +        hw_version = g_strdup("4");
> +    }
> +    fmt = qemu_opt_get_del(opts, BLOCK_OPT_SUBFMT);
> +    zeroed_grain = qemu_opt_get_bool_del(opts, BLOCK_OPT_ZEROED_GRAIN, false);
> +
> +    if (adapter_type) {
> +        for (i = 0; i < strlen(adapter_type); ++i) {
> +            adapter_type[i] = qemu_tolower(adapter_type[i]);
> +        }
> +        adapter_type_enum = qapi_enum_parse(&BlockdevVmdkAdapterType_lookup,
> +                                            adapter_type,
> +                                            BLOCKDEV_VMDK_ADAPTER_TYPE_IDE,
> +                                            &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            ret = -EINVAL;
> +            goto exit;
> +        }
> +    } else {
> +        adapter_type_enum = BLOCKDEV_VMDK_ADAPTER_TYPE_IDE;
> +    }
> +
> +    if (!fmt) {
> +        /* Default format to monolithicSparse */
> +        subformat = BLOCKDEV_VMDK_SUBFORMAT_MONOLITHICSPARSE;
> +    } else {
> +        subformat = qapi_enum_parse(&BlockdevVmdkSubformat_lookup,
> +                                    fmt,
> +                                    BLOCKDEV_VMDK_SUBFORMAT_MONOLITHICSPARSE,
> +                                    &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            ret = -EINVAL;
> +            goto exit;
> +        }
> +    }
> +    data = (VMDKCreateOptsData){
> +        .prefix = prefix,
> +        .postfix = postfix,
> +        .path = path,
> +        .opts = opts,
> +    };
> +    ret = vmdk_co_do_create(total_size, subformat, adapter_type_enum,
> +                            backing_file, hw_version, compat6, zeroed_grain,
> +                            vmdk_co_create_opts_cb, &data, errp);
> +
> +exit:
>      g_free(adapter_type);
>      g_free(backing_file);
>      g_free(hw_version);
> @@ -2156,7 +2281,84 @@ exit:
>      g_free(ext_filename);
>      g_free(desc_filename);
>      g_free(parent_desc_line);
> -    g_string_free(ext_desc_lines, true);
> +    return ret;
> +}
> +
> +static BlockBackend *vmdk_co_create_cb(int64_t size, int idx,
> +                                       bool flat, bool split, bool compress,
> +                                       bool zeroed_grain, void *opaque,
> +                                       Error **errp)
> +{
> +    int ret;
> +    BlockDriverState *bs;
> +    BlockBackend *blk;
> +    BlockdevCreateOptionsVmdk *opts = opaque;
> +
> +    if (idx == 0) {
> +        bs = bdrv_open_blockdev_ref(opts->file, errp);
> +    } else {
> +        int i;
> +        BlockdevRefList *list = opts->extents;
> +        for (i = 1; i < idx; i++) {
> +            if (!list || !list->next) {
> +                error_setg(errp, "Extent [%d] not specified", i);
> +                return NULL;
> +            }
> +            list = list->next;
> +        }
> +        if (!list) {
> +            error_setg(errp, "Extent [%d] not specified", idx - 1);
> +            return NULL;
> +        }
> +        bs = bdrv_open_blockdev_ref(list->value, errp);
> +    }
> +    if (!bs) {
> +        return NULL;
> +    }
> +    blk = blk_new(BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE | BLK_PERM_RESIZE,
> +                  BLK_PERM_ALL);
> +    if (blk_insert_bs(blk, bs, errp)) {
> +        bdrv_unref(bs);
> +        return NULL;
> +    }
> +    blk_set_allow_write_beyond_eof(blk, true);
> +    bdrv_unref(bs);
> +
> +    ret = vmdk_init_extent(blk, size, flat, compress, zeroed_grain, errp);
> +    if (ret) {
> +        blk_unref(blk);
> +        blk = NULL;
> +    }
> +    return blk;
> +}
> +
> +static int coroutine_fn vmdk_co_create(BlockdevCreateOptions *create_options,
> +                                       Error **errp)
> +{
> +    int ret;
> +    BlockdevCreateOptionsVmdk *opts;
> +
> +    opts = &create_options->u.vmdk;
> +
> +    /* Validate options */
> +    if (!QEMU_IS_ALIGNED(opts->size, BDRV_SECTOR_SIZE)) {
> +        error_setg(errp, "Image size must be a multiple of 512 bytes");
> +        ret = -EINVAL;
> +        goto out;
> +    }
> +
> +    ret = vmdk_co_do_create(opts->size,
> +                            opts->subformat,
> +                            opts->adapter_type,
> +                            opts->backing_file,
> +                            opts->hwversion,
> +                            false,
> +                            opts->zeroed_grain,
> +                            vmdk_co_create_cb,
> +                            opts, errp);
> +    return ret;
> +
> +out:
>      return ret;
>  }
>  
> @@ -2424,6 +2626,7 @@ static BlockDriver bdrv_vmdk = {
>      .bdrv_co_pwrite_zeroes        = vmdk_co_pwrite_zeroes,
>      .bdrv_close                   = vmdk_close,
>      .bdrv_co_create_opts          = vmdk_co_create_opts,
> +    .bdrv_co_create               = vmdk_co_create,
>      .bdrv_co_flush_to_disk        = vmdk_co_flush,
>      .bdrv_co_block_status         = vmdk_co_block_status,
>      .bdrv_get_allocated_file_size = vmdk_get_allocated_file_size,
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 21c3470234..dfd7d22f06 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3860,6 +3860,71 @@
>              'size':             'size',
>              '*cluster-size' :   'size' } }
>  
> +##
> +# @BlockdevVmdkSubformat:
> +#
> +# Subformat options for VMDK images
> +#
> +# @monolithicSparse: Single file image with sparse cluster allocation
> +# @monolithicFlat: Single flat data image and a descriptor file
> +# @twoGbMaxExtentSparse: Data is split into 2GB (per virtual LBA) sparse extent
> +#                        files, in addition to a descriptor file
> +# @twoGbMaxExtentFlat: Data is split into 2GB (per virtual LBA) flat extent
> +#                        files, in addition to a descriptor file
> +# @streamOptimized: Single file image sparse cluster allocation, optimized for
> +#                   streaming over network.
> +#
> +# Since: 2.13
> +##
> +{ 'enum': 'BlockdevVmdkSubformat',
> +  'data': [ 'monolithicSparse', 'monolithicFlat', 'twoGbMaxExtentSparse',
> +            'twoGbMaxExtentFlat', 'streamOptimized'] }
> +
> +##
> +# @BlockdevVmdkAdapterType:
> +#
> +# Adapter type info for VMDK images
> +#
> +# Since: 2.13
> +##
> +{ 'enum': 'BlockdevVmdkAdapterType',
> +  'data': [ 'ide', 'buslogic', 'lsilogic', 'legacyesx'] }
> +
> +##
> +# @BlockdevCreateOptionsVmdk:
> +#
> +# Driver specific image creation options for VMDK.
> +#
> +# @file         Where to store the new image file. This refers to the image
> +#               file for monolithcSparse and streamOptimized format, or the
> +#               descriptor file for other formats.
> +# @size         Size of the virtual disk in bytes
> +# @extents      Where to store the data extents. Required for monolithcflat,
> +#               twoGbMaxExtentSparse and twoGbMaxExtentFlat formats. For
> +#               monolithicflat, only one entry is required; for
> +#               twoGbMaxExtent* formats, the number of entries required is
> +#               calculated as extent_number = virtual_size / 2GB.
> +# @subformat    The subformat of the VMDK image. Default: "monolithicsparse".
> +# @backing-file The path of backing file. Default: no backing file is used.
> +# @adapter-type The adapter type used to fill in the descriptor. Default: ide.
> +# @hwversion    Hardware version. The meaningful options are "4" or "6".
> +#               Defaulted to "4".
> +# @zeroed-grain Whether to enable zeroed-grain feature for sparse subformats.
> +#               Default: false.
> +#
> +# Since: 2.13
> +##
> +{ 'struct': 'BlockdevCreateOptionsVmdk',
> +  'data': { 'file':             'BlockdevRef',
> +            'size':             'size',
> +            '*extents':          ['BlockdevRef'],
> +            '*subformat':       'BlockdevVmdkSubformat',
> +            '*backing-file':    'str',
> +            '*adapter-type':    'BlockdevVmdkAdapterType',
> +            '*hwversion':       'str',
> +            '*zeroed-grain':    'bool' } }
> +
> +
>  ##
>  # @SheepdogRedundancyType:
>  #
> @@ -4083,7 +4148,7 @@
>        'throttle':       'BlockdevCreateNotSupported',
>        'vdi':            'BlockdevCreateOptionsVdi',
>        'vhdx':           'BlockdevCreateOptionsVhdx',
> -      'vmdk':           'BlockdevCreateNotSupported',
> +      'vmdk':           'BlockdevCreateOptionsVmdk',
>        'vpc':            'BlockdevCreateOptionsVpc',
>        'vvfat':          'BlockdevCreateNotSupported',
>        'vxhs':           'BlockdevCreateNotSupported'
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 25bce78352..ff1a4d5fdc 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -66,6 +66,7 @@
>          'ACPISlotType',         # DIMM, visible through query-acpi-ospm-status
>          'CpuInfoMIPS',          # PC, visible through query-cpu
>          'CpuInfoTricore',       # PC, visible through query-cpu
> +        'BlockdevVmdkSubformat',# all members, to be compliant as VMDK spec spells

Suggest "to match VMDK spec spellings"

>          'QapiErrorClass',       # all members, visible through errors
>          'UuidInfo',             # UUID, visible through query-uuid
>          'X86CPURegister32',     # all members, visible indirectly through qom-get

Looks almost ready now.
