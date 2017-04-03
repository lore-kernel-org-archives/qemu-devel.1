Received: from eggs.gnu.org ([2001:4830:134:3::10]:33280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv7W0-0006ey-4R
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv7Vw-0006hk-5Y
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:19:48 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170403160936.28293-1-mreitz@redhat.com>
	<20170403160936.28293-10-mreitz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f0a15731-1561-6d4d-c4f5-55c6a66b23a3@amsat.org>
Date: Mon, 3 Apr 2017 16:19:39 -0300
MIME-Version: 1.0
In-Reply-To: <20170403160936.28293-10-mreitz@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 09/16] block/qcow2: Generalize
 preallocate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Hi Max,

On 04/03/2017 01:09 PM, Max Reitz wrote:
> This patch adds two new parameters to the preallocate() function so we
> will be able to use it not just for preallocating a new image but also
> for preallocated image growth.
>
> The offset parameter allows the caller to specify a virtual offset from
> which to start preallocating. For newly created images this is always 0,
> but for preallocating growth this will be the old image length.
>
> The new_length parameter specifies the supposed new length of the image
> (basically the "end offset" for preallocation). During image truncation,
> bdrv_getlength() will return the old image length so we cannot rely on
> its return value then.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 9fd220ec34..163d51ec65 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2034,17 +2034,23 @@ static int qcow2_change_backing_file(BlockDriverState *bs,
>      return qcow2_update_header(bs);
>  }
>
> -static int preallocate(BlockDriverState *bs)
> +/**
> + * Preallocates metadata structures for data clusters between @offset (in the
> + * guest disk) and @new_length (which is thus generally the new guest disk
> + * size).
> + *
> + * Returns: 0 on success, -errno on failure.
> + */
> +static int preallocate(BlockDriverState *bs, int64_t offset, int64_t new_length)
>  {
>      uint64_t bytes;
> -    uint64_t offset;
>      uint64_t host_offset = 0;
>      unsigned int cur_bytes;
>      int ret;
>      QCowL2Meta *meta;
>
> -    bytes = bdrv_getlength(bs);
> -    offset = 0;

why use `int64_t`? is it ok to have a negative offset?
preallocate a negative length sound weird... even `bytes` is unsigned.

> +    assert(offset <= new_length);
> +    bytes = new_length - offset;
>
>      while (bytes) {
>          cur_bytes = MIN(bytes, INT_MAX);
> @@ -2314,7 +2320,7 @@ static int qcow2_create2(const char *filename, int64_t total_size,
>      if (prealloc != PREALLOC_MODE_OFF) {
>          BDRVQcow2State *s = blk_bs(blk)->opaque;
>          qemu_co_mutex_lock(&s->lock);
> -        ret = preallocate(blk_bs(blk));
> +        ret = preallocate(blk_bs(blk), 0, total_size);
>          qemu_co_mutex_unlock(&s->lock);
>          if (ret < 0) {
>              error_setg_errno(errp, -ret, "Could not preallocate metadata");
>
