Received: from eggs.gnu.org ([2001:4830:134:3::10]:58539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyFJc-0005pN-Iz
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 06:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyFJa-0004U1-RG
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 06:15:56 -0400
Date: Wed, 12 Apr 2017 12:15:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170412101542.GD4955@noname.str.redhat.com>
References: <1488288927-4607-1-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488288927-4607-1-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: simplify img_convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@gmail.com, ct@flyingcircus.io, mreitz@redhat.com, famz@redhat.com, eblake@redhat.com

Am 28.02.2017 um 14:35 hat Peter Lieven geschrieben:
> img_convert has been around before there was an ImgConvertState or
> a block backend, but it has never been modified to directly use
> these structs. Change this by parsing parameters directly into
> the ImgConvertState and directly use BlockBackend where possible.
> Futhermore variable initalization has been reworked and sorted.
> 
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  qemu-img.c | 197 +++++++++++++++++++++++++------------------------------------
>  1 file changed, 81 insertions(+), 116 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index caa76a7..f271167 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1488,7 +1488,7 @@ typedef struct ImgConvertState {
>      int min_sparse;
>      size_t cluster_sectors;
>      size_t buf_sectors;
> -    int num_coroutines;
> +    long num_coroutines;
>      int running_coroutines;
>      Coroutine *co[MAX_COROUTINES];
>      int64_t wait_sector_num[MAX_COROUTINES];
> @@ -1882,39 +1882,33 @@ static int convert_do_copy(ImgConvertState *s)
>  
>  static int img_convert(int argc, char **argv)
>  {
> -    int c, bs_n, bs_i, compress, cluster_sectors, skip_create;
> -    int64_t ret = 0;
> -    int progress = 0, flags, src_flags;
> -    bool writethrough, src_writethrough;
> -    const char *fmt, *out_fmt, *cache, *src_cache, *out_baseimg, *out_filename;
> +    int c, bs_i;
> +    int flags, src_flags = 0;
> +    const char *fmt = NULL, *out_fmt = "raw", *cache = "unsafe",
> +               *src_cache = BDRV_DEFAULT_CACHE, *out_baseimg = NULL,
> +               *out_filename;
>      BlockDriver *drv, *proto_drv;
> -    BlockBackend **blk = NULL, *out_blk = NULL;
> -    BlockDriverState **bs = NULL, *out_bs = NULL;
> -    int64_t total_sectors;
> -    int64_t *bs_sectors = NULL;
> -    size_t bufsectors = IO_BUF_SIZE / BDRV_SECTOR_SIZE;
>      BlockDriverInfo bdi;
> +    BlockDriverState *out_bs;
>      QemuOpts *opts = NULL;
>      QemuOptsList *create_opts = NULL;
>      const char *out_baseimg_param;
> -    char *options = NULL;
>      const char *snapshot_name = NULL;
> -    int min_sparse = 8; /* Need at least 4k of zeros for sparse detection */
> -    bool quiet = false;
> +    char *options = NULL;
>      Error *local_err = NULL;
>      QemuOpts *sn_opts = NULL;
> -    ImgConvertState state;
> -    bool image_opts = false;
> -    bool wr_in_order = true;
> -    long num_coroutines = 8;
> +    bool writethrough, src_writethrough, quiet = false, image_opts = false,
> +         compress = false, skip_create = false, progress = false;

compress is never set, but tested. Should probably be completely
replaced by s.compressed.

> [...]
> +    /* Initialize before goto out */
> +    if (quiet) {
> +        progress = false;
> +    }
> +    qemu_progress_init(progress, 1.0);
>      qemu_progress_print(0, 100);
>  
> -    blk = g_new0(BlockBackend *, bs_n);
> -    bs = g_new0(BlockDriverState *, bs_n);
> -    bs_sectors = g_new(int64_t, bs_n);
> +    s.src = g_new0(BlockBackend *, s.src_num);
> +    s.src_sectors = g_new(int64_t, s.src_num);
>  
> -    total_sectors = 0;
> -    for (bs_i = 0; bs_i < bs_n; bs_i++) {
> -        blk[bs_i] = img_open(image_opts, argv[optind + bs_i],
> -                             fmt, src_flags, src_writethrough, quiet);
> -        if (!blk[bs_i]) {
> +    for (bs_i = 0; bs_i < s.src_num; bs_i++) {
> +        s.src[bs_i] = img_open(image_opts, argv[optind + bs_i],
> +                                fmt, src_flags, src_writethrough, quiet);

Indentation is off.

The rest looks okay.

Kevin
