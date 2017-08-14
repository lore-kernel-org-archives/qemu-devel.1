Received: from eggs.gnu.org ([2001:4830:134:3::10]:53880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhGhp-0002KK-Px
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhGho-00057g-Ja
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:51:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170729164104.29537-1-vsementsov@virtuozzo.com>
	<20170729164104.29537-2-vsementsov@virtuozzo.com>
Date: Mon, 14 Aug 2017 16:50:52 +0200
In-Reply-To: <20170729164104.29537-2-vsementsov@virtuozzo.com> (Vladimir
	Sementsov-Ogievskiy's message of "Sat, 29 Jul 2017 19:41:02 +0300")
Message-ID: <87lgmmqk37.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 1/3] block: add
 bdrv_get_format_alloc_stat format interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, Eric Blake <eblake@redhat.com>

Cc: Eric Blake for additional schema review expertise.

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> The function should collect statistics, about used/unused by top-level
> format driver space (in its .file) and allocation status
> (data/zero/discarded/after-eof) of corresponding areas in this .file.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c                   | 16 +++++++++++
>  include/block/block.h     |  3 ++
>  include/block/block_int.h |  2 ++
>  qapi/block-core.json      | 72 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 93 insertions(+)
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

I'd prefer 

   /**
    * Collect format allocation info.
    * See BlockFormatAllocInfo definition in qapi/block-core.json.
    */

Admittedly a matter of taste.

> +int bdrv_get_format_alloc_stat(BlockDriverState *bs, BlockFormatAllocInfo *bfai)

bdrv_get_format_alloc_info(), please, for symmetry with
BlockFormatAllocInfo.

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
> index ea0b3e8b13..93f6995381 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -139,6 +139,78 @@
>             '*format-specific': 'ImageInfoSpecific' } }
>  
>  ##
> +# @BlockFormatAllocInfo:
> +#
> +#

Just one blank like, please.

> +# Allocation information of an underlying protocol file, as partitioned by a
> +# format driver's utilization of said allocations.
> +# All fields are in bytes.
> +#
> +# Regions of the underlying protocol file may be considered used or unused by
> +# the format driver interpreting these regions. It is at the discretion of the
> +# format driver (e.g. qcow2) which regions of its backing storage are considered

Long line.  Please wrap your comment lines around column 70 for legibility.

> +# in-use or not.
> +#
> +# For now, the only format driver supporting this feature is Qcow2 which is a

"is QCow2, which"

> +# cluster based format. Clusters considered in-use by qcow2 are those with a
> +# non-zero refcount in the format metadata. All other clusters, if present, are
> +# considered unused. Examples of unused allocations for the Qcow2 format are
> +# leaked clusters, pre-allocated clusters, and recently freed clusters.
> +#
> +# Note: the whole underlying protocol file is described as well as all format
> +# file allocations, not only virtual disk data (metadata, internal snapshots,
> +# etc. are included).

I'm not sure I get this note.

> +#
> +# For the underlying protocol file there are native block-status types of the
> +# regions:

Comma after "protocol file"?  The sentence doesn't feel right to me even
with the comma, though.  What's a "native block-status type"?

> +#  - data: allocated data
> +#  - zero: reported as zero (for example, this type corresponds to holes for
> +#          POSIX files on sparce file-system)
> +#  - discarded: not allocated
> +# 4th additional type is 'overrun', is data referenced by the format driver
> +# located beyond EOF of the underlying protocol file. For example, a partially
> +# allocated cluster at the end of a QCOW2 file, where Qcow2 generally operates
> +# on complete clusters.

Explaining three of four types in a list, and the fourth in the
paragraph following the list feels awkward.  Turn it into a fourth list
item?

> +#
> +# So, the fields are:
> +#
> +# @used-data: used by the format file and backed by data in the underlying
> +#             protocol file
> +#
> +# @used-zero: used by the format file and backed by zeroes in the underlying
> +#             protocol file; which may be a filesystem hole for POSIX files.
> +#
> +# @used-discarded: used by the format file but actually unallocated in the
> +#                  underlying protocol file

Are discarded clusters normal or some kind of problem?

> +#
> +# @used-overrun: used by the format file beyond the end of the underlying
> +#                protocol file

Are overruns normal or some kind of problem?

> +#
> +# @unused-data: allocated data in the underlying protocol file not used by the
> +#               format file
> +#
> +# @unused-zero: reported-as-zero regions in the underlying protocol file not
> +#               used by the format file
> +#
> +# @unused-discarded: unallocated areas in the underlying protocol file not used
> +#                    by the format file
> +#
> +# Note: sum of 6 fields {used,unused}-{data,zero,discarded} is equal to the
> +#       length of the underlying protocol file.
> +#
> +# Since: 2.11
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

Please use 'size' for byte counts.  See also "[RFC PATCH 00/56] qapi:
Use 'size' for byte counts & offsets".

> +
> +##
>  # @ImageCheck:
>  #
>  # Information about a QEMU image file check
