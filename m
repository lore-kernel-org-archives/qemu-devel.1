Received: from eggs.gnu.org ([2001:4830:134:3::10]:42883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dPdIY-0004xI-3a
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 19:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dPdIW-00075q-S7
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 19:20:02 -0400
References: <20170606162652.112122-1-vsementsov@virtuozzo.com>
	<20170606162652.112122-2-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <33cfc00b-1f19-6938-44a2-e2e08ea150e1@redhat.com>
Date: Mon, 26 Jun 2017 19:19:53 -0400
MIME-Version: 1.0
In-Reply-To: <20170606162652.112122-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 1/3] block: add
 bdrv_get_format_alloc_stat format interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org



On 06/06/2017 12:26 PM, Vladimir Sementsov-Ogievskiy wrote:
> The function should collect statistics, about used/unused by top-level
> format driver space (in its .file) and allocation status
> (data/zero/discarded/after-eof) of corresponding areas in this .file.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c                   | 16 ++++++++++++++
>  include/block/block.h     |  3 +++
>  include/block/block_int.h |  2 ++
>  qapi/block-core.json      | 55 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 76 insertions(+)
> 
> diff --git a/block.c b/block.c
> index 50ba264143..7d720ae0c2 100644
> --- a/block.c
> +++ b/block.c
> @@ -3407,6 +3407,22 @@ int64_t bdrv_get_allocated_file_size(BlockDriverState *bs)
>  }
>  
>  /**
> + * Collect format allocation info. See BlockFormatAllocInfo definition in
> + * qapi/block-core.json.
> + */
> +int bdrv_get_format_alloc_stat(BlockDriverState *bs, BlockFormatAllocInfo *bfai)
> +{
> +    BlockDriver *drv = bs->drv;
> +    if (!drv) {
> +        return -ENOMEDIUM;
> +    }
> +    if (drv->bdrv_get_format_alloc_stat) {
> +        return drv->bdrv_get_format_alloc_stat(bs, bfai);
> +    }
> +    return -ENOTSUP;
> +}
> +
> +/**
>   * Return number of sectors on success, -errno on error.
>   */
>  int64_t bdrv_nb_sectors(BlockDriverState *bs)
> diff --git a/include/block/block.h b/include/block/block.h
> index 9b355e92d8..646376a772 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -335,6 +335,9 @@ typedef enum {
>  
>  int bdrv_check(BlockDriverState *bs, BdrvCheckResult *res, BdrvCheckMode fix);
>  
> +int bdrv_get_format_alloc_stat(BlockDriverState *bs,
> +                               BlockFormatAllocInfo *bfai);
> +
>  /* The units of offset and total_work_size may be chosen arbitrarily by the
>   * block driver; total_work_size may change during the course of the amendment
>   * operation */
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 8d3724cce6..458c715e99 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -208,6 +208,8 @@ struct BlockDriver {
>      int64_t (*bdrv_getlength)(BlockDriverState *bs);
>      bool has_variable_length;
>      int64_t (*bdrv_get_allocated_file_size)(BlockDriverState *bs);
> +    int (*bdrv_get_format_alloc_stat)(BlockDriverState *bs,
> +                                      BlockFormatAllocInfo *bfai);
>  
>      int coroutine_fn (*bdrv_co_pwritev_compressed)(BlockDriverState *bs,
>          uint64_t offset, uint64_t bytes, QEMUIOVector *qiov);
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index ea0b3e8b13..fd7b52bd69 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -139,6 +139,61 @@
>             '*format-specific': 'ImageInfoSpecific' } }
>  
>  ##
> +# @BlockFormatAllocInfo:
> +#

I apologize in advance, but I don't understand this patch very well. Let
me ask some questions to get patch review rolling again, since you've
been waiting a bit.

> +#
> +# Allocation relations between format file and underlying protocol file.
> +# All fields are in bytes.
> +#

The format file in this case would be ... what, the virtual file
represented by the qcow2? and the underlying protocol file is the raw
file that is the qcow2 itself?

> +# There are two types of the format file portions: 'used' and 'unused'. It's up
> +# to the format how to interpret these types. For now the only format supporting
> +# the feature is Qcow2 and for this case 'used' are clusters with positive
> +# refcount and unused a clusters with zero refcount. Described portions include
> +# all format file allocations, not only virtual disk data (metadata, internal
> +# snapshots, etc. are included).

I guess the semantic differentiation between "used" and "unused" is left
to the individual fields, below.

> +#
> +# For the underlying file there are native block-status types of the portions:
> +#  - data: allocated data
> +#  - zero: read-as-zero holes
> +#  - discarded: not allocated
> +# 4th additional type is 'overrun', which is for the format file portions beyond
> +# the end of the underlying file.
> +#
> +# So, the fields are:
> +#
> +# @used-data: used by the format file and backed by data in the underlying file
> +#

I assume this is "defined and addressable data".

> +# @used-zero: used by the format file and backed by a hole in the underlying
> +#             file
> +#

By a hole? Can you give me an example? Do you mean like a filesystem
hole ala falloc()?

> +# @used-discarded: used by the format file but actually unallocated in the
> +#                  underlying file
> +#

In what case do we have used data that is discarded/undefined, but not
zero? Shouldn't discarded data be zero...?

> +# @used-overrun: used by the format file beyond the end of the underlying file
> +#

When does this occur?

> +# @unused-data: allocated data in the underlying file not used by the format
> +#

I assume this is an allocation gap in qcow2. Unused, but non-zero. Right?

> +# @unused-zero: holes in the underlying file not used by the format file
> +#

I assume this is similar to the above -- Unused, but zero.

> +# @unused-discarded: unallocated areas in the underlying file not used by the
> +#                    format file
> +#

Again I am unsure of what discarded but non-zero might mean.

> +# Note: sum of 6 fields {used,unused}-{data,zero,discarded} is equal to the
> +#       length of the underlying file.
> +#
> +# Since: 2.10
> +#
> +##
> +{ 'struct': 'BlockFormatAllocInfo',
> +  'data': {'used-data':        'uint64',
> +           'used-zero':        'uint64',
> +           'used-discarded':   'uint64',
> +           'used-overrun':     'uint64',
> +           'unused-data':      'uint64',
> +           'unused-zero':      'uint64',
> +           'unused-discarded': 'uint64' } }
> +
> +##
>  # @ImageCheck:
>  #
>  # Information about a QEMU image file check
> 

Sorry for the dumb questions.

--John
