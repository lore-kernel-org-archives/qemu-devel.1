Received: from eggs.gnu.org ([2001:4830:134:3::10]:36010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dis95-00064x-Rc
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 21:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dis91-0005PX-TQ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 21:01:47 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dis91-0005NW-Hm
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 21:01:43 -0400
Received: by mail-pg0-x242.google.com with SMTP id i12so1966175pgr.1
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 18:01:42 -0700 (PDT)
References: <20170818133118.8650-1-stefanha@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5f53b40e-bcf1-94f1-d92e-41b3325701b4@ozlabs.ru>
Date: Sat, 19 Aug 2017 11:01:35 +1000
MIME-Version: 1.0
In-Reply-To: <20170818133118.8650-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qcow2: allocate cluster_cache/cluster_data
 on demand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On 18/08/17 23:31, Stefan Hajnoczi wrote:
> Most qcow2 files are uncompressed so it is wasteful to allocate (32 + 1)
> * cluster_size + 512 bytes upfront.  Allocate s->cluster_cache and
> s->cluster_data when the first read operation is performance on a
> compressed cluster.
> 
> The buffers are freed in .bdrv_close().  .bdrv_open() no longer has any
> code paths that can allocate these buffers, so remove the free functions
> in the error code path.
> 
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Alexey: Does this improve your memory profiling results?

Yes, it does:

was:
12.81% (1,023,193,088B)
now:
05.36% (393,893,888B)


Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>

>  block/qcow2-cluster.c | 17 +++++++++++++++++
>  block/qcow2.c         | 12 ------------
>  2 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index f06c08f64c..c47600a44e 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1516,6 +1516,23 @@ int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
>          nb_csectors = ((cluster_offset >> s->csize_shift) & s->csize_mask) + 1;
>          sector_offset = coffset & 511;
>          csize = nb_csectors * 512 - sector_offset;
> +
> +        /* Allocate buffers on first decompress operation, most images are
> +         * uncompressed and the memory overhead can be avoided.  The buffers
> +         * are freed in .bdrv_close().
> +         */
> +        if (!s->cluster_data) {
> +            /* one more sector for decompressed data alignment */
> +            s->cluster_data = qemu_try_blockalign(bs->file->bs,
> +                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size + 512);
> +            if (!s->cluster_data) {
> +                return -EIO;
> +            }
> +        }
> +        if (!s->cluster_cache) {
> +            s->cluster_cache = g_malloc(s->cluster_size);
> +        }
> +
>          BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
>          ret = bdrv_read(bs->file, coffset >> 9, s->cluster_data,
>                          nb_csectors);
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 40ba26c111..0ac201910a 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1360,16 +1360,6 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
>          goto fail;
>      }
>  
> -    s->cluster_cache = g_malloc(s->cluster_size);
> -    /* one more sector for decompressed data alignment */
> -    s->cluster_data = qemu_try_blockalign(bs->file->bs, QCOW_MAX_CRYPT_CLUSTERS
> -                                                    * s->cluster_size + 512);
> -    if (s->cluster_data == NULL) {
> -        error_setg(errp, "Could not allocate temporary cluster buffer");
> -        ret = -ENOMEM;
> -        goto fail;
> -    }
> -
>      s->cluster_cache_offset = -1;
>      s->flags = flags;
>  
> @@ -1507,8 +1497,6 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
>      if (s->refcount_block_cache) {
>          qcow2_cache_destroy(bs, s->refcount_block_cache);
>      }
> -    g_free(s->cluster_cache);
> -    qemu_vfree(s->cluster_data);
>      qcrypto_block_free(s->crypto);
>      qapi_free_QCryptoBlockOpenOptions(s->crypto_opts);
>      return ret;
> 


-- 
Alexey
