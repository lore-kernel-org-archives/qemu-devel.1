Received: from eggs.gnu.org ([2001:4830:134:3::10]:44092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmfgO-00006K-B8
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 08:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmfgI-00049z-3M
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 08:31:52 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170829120836.16091-1-berto@igalia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9c225c3c-e21c-48ad-ac36-e472c6dec84a@amsat.org>
Date: Tue, 29 Aug 2017 09:31:35 -0300
MIME-Version: 1.0
In-Reply-To: <20170829120836.16091-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] misc: Remove unused Error variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Hi Alberto,

On 08/29/2017 09:08 AM, Alberto Garcia wrote:
> There's a few cases which we're passing an Error pointer to a function
> only to discard it immediately afterwards without checking it. In
> these cases we can simply remove the variable and pass NULL instead.

How did you notice?

> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   block/qcow.c  | 12 +++---------
>   block/qcow2.c |  8 ++------
>   dump.c        |  4 +---
>   3 files changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/block/qcow.c b/block/qcow.c
> index c08cdc4a7b..63904a26ee 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -454,13 +454,11 @@ static uint64_t get_cluster_offset(BlockDriverState *bs,
>                       start_sect = (offset & ~(s->cluster_size - 1)) >> 9;
>                       for(i = 0; i < s->cluster_sectors; i++) {
>                           if (i < n_start || i >= n_end) {
> -                            Error *err = NULL;
>                               memset(s->cluster_data, 0x00, 512);
>                               if (qcrypto_block_encrypt(s->crypto, start_sect + i,
>                                                         s->cluster_data,
>                                                         BDRV_SECTOR_SIZE,
> -                                                      &err) < 0) {
> -                                error_free(err);
> +                                                      NULL) < 0) {
>                                   errno = EIO;
>                                   return -1;
>                               }
> @@ -572,7 +570,6 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
>       QEMUIOVector hd_qiov;
>       uint8_t *buf;
>       void *orig_buf;
> -    Error *err = NULL;
>   
>       if (qiov->niov > 1) {
>           buf = orig_buf = qemu_try_blockalign(bs, qiov->size);
> @@ -637,7 +634,7 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
>               if (bs->encrypted) {
>                   assert(s->crypto);
>                   if (qcrypto_block_decrypt(s->crypto, sector_num, buf,
> -                                          n * BDRV_SECTOR_SIZE, &err) < 0) {
> +                                          n * BDRV_SECTOR_SIZE, NULL) < 0) {
>                       goto fail;
>                   }
>               }
> @@ -660,7 +657,6 @@ done:
>       return ret;
>   
>   fail:
> -    error_free(err);
>       ret = -EIO;
>       goto done;
>   }
> @@ -709,11 +705,9 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
>               break;
>           }
>           if (bs->encrypted) {
> -            Error *err = NULL;
>               assert(s->crypto);
>               if (qcrypto_block_encrypt(s->crypto, sector_num, buf,
> -                                      n * BDRV_SECTOR_SIZE, &err) < 0) {
> -                error_free(err);
> +                                      n * BDRV_SECTOR_SIZE, NULL) < 0) {
>                   ret = -EIO;
>                   break;
>               }
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 40ba26c111..fbfffadc76 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1820,15 +1820,13 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
>                   assert(s->crypto);
>                   assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
>                   assert((cur_bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
> -                Error *err = NULL;
>                   if (qcrypto_block_decrypt(s->crypto,
>                                             (s->crypt_physical_offset ?
>                                              cluster_offset + offset_in_cluster :
>                                              offset) >> BDRV_SECTOR_BITS,
>                                             cluster_data,
>                                             cur_bytes,
> -                                          &err) < 0) {
> -                    error_free(err);
> +                                          NULL) < 0) {
>                       ret = -EIO;
>                       goto fail;
>                   }
> @@ -1942,7 +1940,6 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
>           qemu_iovec_concat(&hd_qiov, qiov, bytes_done, cur_bytes);
>   
>           if (bs->encrypted) {
> -            Error *err = NULL;
>               assert(s->crypto);
>               if (!cluster_data) {
>                   cluster_data = qemu_try_blockalign(bs->file->bs,
> @@ -1963,8 +1960,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
>                                          cluster_offset + offset_in_cluster :
>                                          offset) >> BDRV_SECTOR_BITS,
>                                         cluster_data,
> -                                      cur_bytes, &err) < 0) {
> -                error_free(err);
> +                                      cur_bytes, NULL) < 0) {
>                   ret = -EIO;
>                   goto fail;
>               }
> diff --git a/dump.c b/dump.c
> index d9090a24cc..a79773d0f7 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -1695,10 +1695,8 @@ static void dump_process(DumpState *s, Error **errp)
>   
>   static void *dump_thread(void *data)
>   {
> -    Error *err = NULL;
>       DumpState *s = (DumpState *)data;
> -    dump_process(s, &err);
> -    error_free(err);
> +    dump_process(s, NULL);
>       return NULL;
>   }
>   
> 
