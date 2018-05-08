Received: from eggs.gnu.org ([2001:4830:134:3::10]:37432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG4d4-0006uR-3j
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG4d3-0004JK-8m
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:34:14 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:36998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fG4d3-0004JA-3e
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:34:13 -0400
Received: by mail-ot0-x243.google.com with SMTP id 77-v6so36554105otd.4
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 08:34:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180213170529.10858-14-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
	<20180213170529.10858-14-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 16:33:51 +0100
Message-ID: <CAFEAcA-Ggc+gwd2yBh+azTLd3i9LpjqqnSvsz2p1Ddx7CVD22w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 13/55] sheepdog: Make sd_prealloc() take a
 BDS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 13 February 2018 at 17:04, Kevin Wolf <kwolf@redhat.com> wrote:
> From: Max Reitz <mreitz@redhat.com>
>
> We want to use this function in sd_truncate() later on, so taking a
> filename is not exactly ideal.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/sheepdog.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index af125a2c8d..cc1d37b3da 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -1826,10 +1826,10 @@ static int do_sd_create(BDRVSheepdogState *s, uint32_t *vdi_id, int snapshot,
>      return 0;
>  }
>
> -static int sd_prealloc(const char *filename, Error **errp)
> +static int sd_prealloc(BlockDriverState *bs, Error **errp)
>  {
>      BlockBackend *blk = NULL;
> -    BDRVSheepdogState *base = NULL;
> +    BDRVSheepdogState *base = bs->opaque;
>      unsigned long buf_size;
>      uint32_t idx, max_idx;
>      uint32_t object_size;
> @@ -1837,10 +1837,11 @@ static int sd_prealloc(const char *filename, Error **errp)
>      void *buf = NULL;
>      int ret;
>
> -    blk = blk_new_open(filename, NULL, NULL,
> -                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL, errp);
> -    if (blk == NULL) {
> -        ret = -EIO;
> +    blk = blk_new(BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE | BLK_PERM_RESIZE,
> +                  BLK_PERM_ALL);
> +
> +    ret = blk_insert_bs(blk, bs, errp);
> +    if (ret < 0) {
>          goto out_with_err_set;
>      }

Hi. Coverity (CID 1390636) points out that there's now a useless
NULL check of a definitely-not-NULL pointer in the 'out_with_err_set'
code, because this change has removed the code path which could get
there with blk == NULL. The "if (blk)" check could be removed to
make the blk_unref() unconditional, I think.

thanks
-- PMM
