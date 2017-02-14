Received: from eggs.gnu.org ([2001:4830:134:3::10]:36807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdls4-0003ka-QS
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 17:46:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdls3-0005Iq-Db
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 17:46:52 -0500
References: <1487091579-67092-1-git-send-email-vsementsov@virtuozzo.com>
	<1487091579-67092-19-git-send-email-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <64ada22d-7705-0766-ce95-c7ac0943e287@redhat.com>
Date: Tue, 14 Feb 2017 17:46:44 -0500
MIME-Version: 1.0
In-Reply-To: <1487091579-67092-19-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/25] qmp: add
 x-debug-block-dirty-bitmap-sha256
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com
Cc: kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org



On 02/14/2017 11:59 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/dirty-bitmap.c         |  5 +++++
>  blockdev.c                   | 29 +++++++++++++++++++++++++++++
>  include/block/dirty-bitmap.h |  2 ++
>  include/qemu/hbitmap.h       |  8 ++++++++
>  qapi/block-core.json         | 27 +++++++++++++++++++++++++++
>  tests/Makefile.include       |  2 +-
>  util/hbitmap.c               | 11 +++++++++++
>  7 files changed, 83 insertions(+), 1 deletion(-)
> 
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 9208844..b684d8b 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -588,3 +588,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
>      return bitmap == NULL ? QLIST_FIRST(&bs->dirty_bitmaps) :
>                              QLIST_NEXT(bitmap, list);
>  }
> +
> +char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp)
> +{
> +    return hbitmap_sha256(bitmap->bitmap, errp);
> +}
> diff --git a/blockdev.c b/blockdev.c
> index e32ac69..c41b791 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2820,6 +2820,35 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
>      aio_context_release(aio_context);
>  }
>  
> +BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
> +                                                              const char *name,
> +                                                              Error **errp)
> +{
> +    AioContext *aio_context;
> +    BdrvDirtyBitmap *bitmap;
> +    BlockDriverState *bs;
> +    BlockDirtyBitmapSha256 *ret = NULL;
> +    char *sha256;
> +
> +    bitmap = block_dirty_bitmap_lookup(node, name, &bs, &aio_context, errp);
> +    if (!bitmap || !bs) {
> +        return NULL;
> +    }
> +
> +    sha256 = bdrv_dirty_bitmap_sha256(bitmap, errp);
> +    if (sha256 == NULL) {
> +        goto out;
> +    }
> +
> +    ret = g_new(BlockDirtyBitmapSha256, 1);
> +    ret->sha256 = sha256;
> +
> +out:
> +    aio_context_release(aio_context);
> +
> +    return ret;
> +}
> +
>  void hmp_drive_del(Monitor *mon, const QDict *qdict)
>  {
>      const char *id = qdict_get_str(qdict, "id");
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index d71edc4..b022b34 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -86,4 +86,6 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
>  
>  bool bdrv_has_persistent_bitmaps(BlockDriverState *bs);
>  
> +char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp);
> +
>  #endif
> diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
> index b52304a..d3a74a2 100644
> --- a/include/qemu/hbitmap.h
> +++ b/include/qemu/hbitmap.h
> @@ -253,6 +253,14 @@ void hbitmap_deserialize_ones(HBitmap *hb, uint64_t start, uint64_t count,
>  void hbitmap_deserialize_finish(HBitmap *hb);
>  
>  /**
> + * hbitmap_sha256:
> + * @bitmap: HBitmap to operate on.
> + *
> + * Returns SHA256 hash of the last level.
> + */
> +char *hbitmap_sha256(const HBitmap *bitmap, Error **errp);
> +
> +/**
>   * hbitmap_free:
>   * @hb: HBitmap to operate on.
>   *
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 09dcf4e..d6f1734 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1642,6 +1642,33 @@
>    'data': 'BlockDirtyBitmap' }
>  
>  ##
> +# @BlockDirtyBitmapSha256:
> +#
> +# SHA256 hash of dirty bitmap data
> +#
> +# @sha256: ASCII representation of SHA256 bitmap hash
> +#
> +# Since: 2.9
> +##
> +  { 'struct': 'BlockDirtyBitmapSha256',
> +    'data': {'sha256': 'str'} }
> +
> +##
> +# @x-debug-block-dirty-bitmap-sha256:
> +#
> +# Get bitmap SHA256
> +#
> +# Returns: BlockDirtyBitmapSha256 on success
> +#          If @node is not a valid block device, DeviceNotFound
> +#          If @name is not found or if hashing has failed, GenericError with an
> +#          explanation
> +#
> +# Since: 2.9
> +##
> +  { 'command': 'x-debug-block-dirty-bitmap-sha256',
> +    'data': 'BlockDirtyBitmap', 'returns': 'BlockDirtyBitmapSha256' }
> +
> +##
>  # @blockdev-mirror:
>  #
>  # Start mirroring a block device's writes to a new destination.
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index ad35a64..d0809fe 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -519,7 +519,7 @@ tests/test-blockjob$(EXESUF): tests/test-blockjob.o $(test-block-obj-y) $(test-u
>  tests/test-blockjob-txn$(EXESUF): tests/test-blockjob-txn.o $(test-block-obj-y) $(test-util-obj-y)
>  tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj-y)
>  tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
> -tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y)
> +tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(test-crypto-obj-y)
>  tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
>  tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o page_cache.o $(test-util-obj-y)
>  tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o
> diff --git a/util/hbitmap.c b/util/hbitmap.c
> index 0c1591a..21535cc 100644
> --- a/util/hbitmap.c
> +++ b/util/hbitmap.c
> @@ -13,6 +13,7 @@
>  #include "qemu/hbitmap.h"
>  #include "qemu/host-utils.h"
>  #include "trace.h"
> +#include "crypto/hash.h"
>  
>  /* HBitmaps provides an array of bits.  The bits are stored as usual in an
>   * array of unsigned longs, but HBitmap is also optimized to provide fast
> @@ -727,3 +728,13 @@ void hbitmap_free_meta(HBitmap *hb)
>      hbitmap_free(hb->meta);
>      hb->meta = NULL;
>  }
> +
> +char *hbitmap_sha256(const HBitmap *bitmap, Error **errp)
> +{
> +    size_t size = bitmap->sizes[HBITMAP_LEVELS - 1] * sizeof(unsigned long);
> +    char *data = (char *)bitmap->levels[HBITMAP_LEVELS - 1];
> +    char *hash = NULL;
> +    qcrypto_hash_digest(QCRYPTO_HASH_ALG_SHA256, data, size, &hash, errp);
> +
> +    return hash;
> +}
> 

I've been fine with this ability as a testing implement since you began
writing this series, but what I wonder is if there is some way that we
can disable this comment for non-testing builds in some kind of formal way.

The x-prefix is a good hint that we don't want people using this, but it
would be nice if we could actually further hide this interface from
prying eyes.

Markus, do you have any thoughts on the matter?

Regardless, I am fine with this as-is, so:

Reviewed-by: John Snow <jsnow@redhat.com>
