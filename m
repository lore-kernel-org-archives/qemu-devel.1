Received: from eggs.gnu.org ([2001:4830:134:3::10]:57443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVAHU-0006EK-FO
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 02:10:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVAHT-00051B-2K
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 02:10:36 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181206151304.8388-1-kwolf@redhat.com>
	<20181206151304.8388-3-kwolf@redhat.com>
Date: Fri, 07 Dec 2018 08:10:25 +0100
In-Reply-To: <20181206151304.8388-3-kwolf@redhat.com> (Kevin Wolf's message of
	"Thu, 6 Dec 2018 16:13:02 +0100")
Message-ID: <87o99x3j8e.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/4] vmdk: Implement .bdrv_co_create
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

This is a reasonably careful review of the QAPI-related parts, but more
of an eye-over for the remainder.

Kevin Wolf <kwolf@redhat.com> writes:

> From: Fam Zheng <famz@redhat.com>
>
> This makes VMDK support blockdev-create. The implementation reuses the
> image creation code in vmdk_co_create_opts which now acceptes a callback
> pointer to "retrieve" BlockBackend pointers from the caller. This way we
> separate the logic between file/extent acquisition and initialization.
>
> The QAPI command parameters are mostly the same as the old create_opts
> except the dropped legacy @compat6 switch, which is redundant with
> @hwversion.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json  |  70 +++++++
>  qapi/qapi-schema.json |   1 +
>  block/vmdk.c          | 452 ++++++++++++++++++++++++++++++------------
>  3 files changed, 396 insertions(+), 127 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index d4fe710836..4778f88dd8 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4021,6 +4021,75 @@
>              'size':             'size',
>              '*cluster-size' :   'size' } }
>  
> +##
> +# @BlockdevVmdkSubformat:
> +#
> +# Subformat options for VMDK images
> +#
> +# @monolithicSparse:     Single file image with sparse cluster allocation
> +#
> +# @monolithicFlat:       Single flat data image and a descriptor file
> +#
> +# @twoGbMaxExtentSparse: Data is split into 2GB (per virtual LBA) sparse extent
> +#                        files, in addition to a descriptor file
> +#
> +# @twoGbMaxExtentFlat:   Data is split into 2GB (per virtual LBA) flat extent
> +#                        files, in addition to a descriptor file
> +#
> +# @streamOptimized:      Single file image sparse cluster allocation, optimized
> +#                        for streaming over network.
> +#
> +# Since: 4.0
> +##
> +{ 'enum': 'BlockdevVmdkSubformat',
> +  'data': [ 'monolithicSparse', 'monolithicFlat', 'twoGbMaxExtentSparse',
> +            'twoGbMaxExtentFlat', 'streamOptimized'] }

Don't conform to the QAPI rules on names "to match VMDK spec spellings"
(see qapi-schema.json below).  We discussed this in review of v1.

PRO: matches the VMDK spec (whatever that's worth), keeps the code
simple.

CON: the non-conforming names become part of the stable QMP interface,
in the argument of command blockdev-create.

I don't like the CON, but I'm willing to tolerate it in the name of
simplicity.

> +
> +##
> +# @BlockdevVmdkAdapterType:
> +#
> +# Adapter type info for VMDK images
> +#
> +# Since: 4.0
> +##
> +{ 'enum': 'BlockdevVmdkAdapterType',
> +  'data': [ 'ide', 'buslogic', 'lsilogic', 'legacyesx'] }

May I have hyphens in the composite nouns?  Hmm, might be the way they
are to match VMDK spec spellings or for backward compatibility.  I guess
we'll see below.

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

monolithicFlat

> +#               twoGbMaxExtent* formats, the number of entries required is
> +#               calculated as extent_number = virtual_size / 2GB.

Is it okay to supply more entries than required, or do I have to supply
exactly the right number?

> +# @subformat    The subformat of the VMDK image. Default: "monolithicsparse".

monolithicSparse

> +# @backing-file The path of backing file. Default: no backing file is used.
> +# @adapter-type The adapter type used to fill in the descriptor. Default: ide.
> +# @hwversion    Hardware version. The meaningful options are "4" or "6".
> +#               Defaulted to "4".

Default: "4"

> +# @zeroed-grain Whether to enable zeroed-grain feature for sparse subformats.
> +#               Default: false.
> +#
> +# Since: 4.0
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

@zeroed-grain is undocumented.

> +
> +
>  ##
>  # @SheepdogRedundancyType:
>  #
> @@ -4215,6 +4284,7 @@
>        'ssh':            'BlockdevCreateOptionsSsh',
>        'vdi':            'BlockdevCreateOptionsVdi',
>        'vhdx':           'BlockdevCreateOptionsVhdx',
> +      'vmdk':           'BlockdevCreateOptionsVmdk',
>        'vpc':            'BlockdevCreateOptionsVpc'
>    } }
>  
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 65b6dc2f6f..78e8bcd561 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -66,6 +66,7 @@
>          'ACPISlotType',         # DIMM, visible through query-acpi-ospm-status
>          'CpuInfoMIPS',          # PC, visible through query-cpu
>          'CpuInfoTricore',       # PC, visible through query-cpu
> +        'BlockdevVmdkSubformat',# all members, to match VMDK spec spellings
>          'QapiErrorClass',       # all members, visible through errors
>          'UuidInfo',             # UUID, visible through query-uuid
>          'X86CPURegister32',     # all members, visible indirectly through qom-get
> diff --git a/block/vmdk.c b/block/vmdk.c
> index 32fc2c84b3..16f86457d7 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -1932,33 +1932,56 @@ static int filename_decompose(const char *filename, char *path, char *prefix,
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
> +{
> +    char *basename = g_path_get_basename(filename);

I like a blank line between declarations and statements.

> +    g_string_append_printf(desc, extent_line_fmt,
> +                           DIV_ROUND_UP(size, BDRV_SECTOR_SIZE), basename);
> +
> +    g_free(basename);
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
>  {
> -    int idx = 0;
> -    BlockBackend *new_blk = NULL;
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
> @@ -1982,71 +2005,35 @@ static int coroutine_fn vmdk_co_create_opts(const char *filename, QemuOpts *opts
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
> -    }
> -    if (strcmp(hw_version, "undefined") == 0) {
> -        g_free(hw_version);
> -        hw_version = g_strdup("4");
> +        hw_version = "6";
>      }
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

Old code recognizes "legacyESX".  New code recognizes "legacyesx".  Bug
or feature?

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
[...]
