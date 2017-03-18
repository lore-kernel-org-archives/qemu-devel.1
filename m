Received: from eggs.gnu.org ([2001:4830:134:3::10]:56768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1cp2uF-00072u-7S
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 21:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1cp2uA-0002d2-8t
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 21:11:43 -0400
Received: from mail-ua0-f169.google.com ([209.85.217.169]:36109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1cp2uA-0002cl-2J
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 21:11:38 -0400
Received: by mail-ua0-f169.google.com with SMTP id 72so53041527uaf.3
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 18:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20170315092940.1367-1-stefanha@redhat.com>
	<20170315092940.1367-3-stefanha@redhat.com>
In-Reply-To: <20170315092940.1367-3-stefanha@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Sat, 18 Mar 2017 01:11:27 +0000
Message-ID: <CAMRbyytw8OM4erh08ksudgUXN4rgxGG0g7or-_0Lgx0jJ=qqKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC v2 2/8] raw-format: add bdrv_measure() support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>

On Wed, Mar 15, 2017 at 11:29 AM Stefan Hajnoczi <stefanha@redhat.com>
wrote:

> Maximum size calculation is trivial for the raw format: it's just the
> requested image size (because there is no metadata).
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/raw-format.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/block/raw-format.c b/block/raw-format.c
> index 86fbc65..cc88540 100644
> --- a/block/raw-format.c
> +++ b/block/raw-format.c
> @@ -312,6 +312,27 @@ static int64_t raw_getlength(BlockDriverState *bs)
>      return s->size;
>  }
>
> +static void raw_measure(QemuOpts *opts, BlockDriverState *in_bs,
> +                        BlockMeasureInfo *info,
> +                        Error **errp)
> +{
> +    if (in_bs) {
> +        int64_t ssize = bdrv_getlength(in_bs);
> +        if (ssize < 0) {
> +            error_setg_errno(errp, -ssize, "Unable to get image size");
> +            return;
> +        }
> +        info->required_bytes = ssize;
> +    } else {
> +        info->required_bytes =
> +            ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
> +                     BDRV_SECTOR_SIZE);
> +    }
> +
> +    /* Unallocated sectors count towards the file size in raw images */
> +    info->fully_allocated_bytes = info->required_bytes;
> +}
> +
>  static int raw_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
>  {
>      return bdrv_get_info(bs->file->bs, bdi);
> @@ -477,6 +498,7 @@ BlockDriver bdrv_raw = {
>      .bdrv_truncate        = &raw_truncate,
>      .bdrv_getlength       = &raw_getlength,
>      .has_variable_length  = true,
> +    .bdrv_measure         = &raw_measure,
>      .bdrv_get_info        = &raw_get_info,
>      .bdrv_refresh_limits  = &raw_refresh_limits,
>      .bdrv_probe_blocksizes = &raw_probe_blocksizes,
> --
> 2.9.3
>
>
Looks good.

Nir
