Received: from eggs.gnu.org ([2001:4830:134:3::10]:41206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gK1n6-00031g-IS
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 08:53:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gK1n3-0006cH-DF
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 08:53:12 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181101182738.70462-6-vsementsov@virtuozzo.com>
References: <20181101182738.70462-1-vsementsov@virtuozzo.com>
	<20181101182738.70462-6-vsementsov@virtuozzo.com>
Date: Tue, 06 Nov 2018 14:53:05 +0100
Message-ID: <w51a7mme2im.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 5/7] qcow2: use byte-based
 read in qcow2_decompress_cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com

On Thu 01 Nov 2018 07:27:36 PM CET, Vladimir Sementsov-Ogievskiy wrote:

> diff --git a/block/qcow2.c b/block/qcow2.c
> index e9d24b801e..950b9f7ec6 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3956,14 +3956,15 @@ fail:
>  int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
>  {
>      BDRVQcow2State *s = bs->opaque;
> -    int ret, csize, nb_csectors, sector_offset;
> +    int ret, csize, nb_csectors;
>      uint64_t coffset;
> +    struct iovec iov;
> +    QEMUIOVector local_qiov;
>  
>      coffset = cluster_offset & s->cluster_offset_mask;
>      if (s->cluster_cache_offset != coffset) {
>          nb_csectors = ((cluster_offset >> s->csize_shift) & s->csize_mask) + 1;
> -        sector_offset = coffset & 511;
> -        csize = nb_csectors * 512 - sector_offset;
> +        csize = nb_csectors * 512 - (coffset & 511);
>  
>          /* Allocate buffers on first decompress operation, most images are
>           * uncompressed and the memory overhead can be avoided.  The buffers
> @@ -3981,14 +3982,17 @@ int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
>              s->cluster_cache = g_malloc(s->cluster_size);
>          }
>  
> +        iov.iov_base = s->cluster_data;
> +        iov.iov_len = csize;
> +        qemu_iovec_init_external(&local_qiov, &iov, 1);
> +
>          BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
> -        ret = bdrv_read(bs->file, coffset >> 9, s->cluster_data,
> -                        nb_csectors);
> +        ret = bdrv_co_preadv(bs->file, coffset, csize, &local_qiov,
> 0);

I think you should annotate the function with coroutine_fn or use
bdrv_pread() instead.

Berto
