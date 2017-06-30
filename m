Received: from eggs.gnu.org ([2001:4830:134:3::10]:36758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dQjmF-0005dR-ID
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dQjmE-0005uW-0y
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:27:15 -0400
References: <20170606162652.112122-1-vsementsov@virtuozzo.com>
	<20170606162652.112122-2-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <50f19b1d-9736-b8b3-5616-67c3393336f3@redhat.com>
Date: Thu, 29 Jun 2017 20:27:04 -0400
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
Cc: kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org, Eric Blake <eblake@redhat.com>



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
> +#
> +# Allocation relations between format file and underlying protocol file.
> +# All fields are in bytes.
> +#

I guess this is a relation in the sense that the format differentiates
between used-unused and the protocol differentiates between
data-zero-trim which gives us the 2D matrix, showing a relation between
"two" files.

I find the use of the word "file" here a bit of a misdirection, though,
as qcow2 (or any other format) in this sense is not a file but rather a
schema used for interpreting data, and the file itself belongs solely to
the protocol.

I might suggest phrasing this as ...

"Allocation information of an underlying protocol file, as partitioned
by a format driver's utilization of said allocations."

Maybe that's too wordy. Eric?

> +# There are two types of the format file portions: 'used' and 'unused'. It's up
> +# to the format how to interpret these types. For now the only format supporting
"format file" seems misleading for similar reasons to my objection
above, which is that the format doesn't have a file, exactly. It's an
abstract schema.

"It's up to the format how to interpret these types" is also a bit too
vague to help inform readers what the types mean, IMO.

Here's an attempt:

"Allocations may be considered either used or unused by the format
driver interpreting those allocations. It is at the discretion of the
format driver (e.g. qcow2) which regions of its backing storage are
considered in-use or not."

I'm trying to clarify that it is not up to the qcow2 driver what "used"
or "unused" *means* but rather that only the qcow2 driver itself can
know which segments are used or unused, as these are semantic
distinctions that belong to the format driver layer. Does that make sense?

That's the spirit of my suggestion.

> +# the feature is Qcow2 and for this case 'used' are clusters with positive
> +# refcount and unused a clusters with zero refcount. Described portions include
> +# all format file allocations, not only virtual disk data (metadata, internal
> +# snapshots, etc. are included).
> +#

"For now, the only format driver supporting this feature is Qcow2 which
is a cluster based format. Clusters considered in-use by qcow2 are those
with a non-zero refcount in the format metadata. All other clusters, if
present, are considered unused."

(Your original description is actually pretty clear.)

I might add some further examples to illustrate the abstraction boundary
we're targeting:

"Examples of unused allocations for the Qcow2 format are leaked
clusters, pre-allocated clusters, and recently freed clusters."

> +# For the underlying file there are native block-status types of the portions:

How about "underlying protocol file" or "underlying storage protocol" or
something that uses the word "protocol" to make it very clear about when
we're talking about a format (qcow2) and when we're talking about the
storage/protocol file itself (raw posix)

> +#  - data: allocated data

ACK. My favorite kind of data. Easy to understand for idiots like me.

> +#  - zero: read-as-zero holes

This is not *necessarily* a hole, at the discretion of the protocol.
Depending on how we've backed the qcow2 we might not actually know how
the zeroes are stored, or if they are stored. All we know is that the
storage protocol here knows that this data happens to be zero.

I find the usage of "hole" here to be misleading, as it suggests
naturally either filesystem sparse allocations (which is correct,
incidentally) but also qcow2 holes, which doesn't have anything to do
with zeroes, necessarily.

> +#  - discarded: not allocated

This might be OK; I don't have a better suggestion. "not allocated" is
again protocol-dependent, but I can't think of a better way to phrase
this, actually...

> +# 4th additional type is 'overrun', which is for the format file portions beyond
> +# the end of the underlying file.
> +#
"Which is data referenced by the format driver located beyond EOF of the
protocol file."

The key thing I am trying to illustrate in the phrase is that the format
file specifies or alludes to the existence of data that is beyond the
EOF for the protocol file.

I think -- though I cannot prove -- that this is almost certainly a
special case of read-as-zero. If that is the case, perhaps we could
mention as much.

An example here would be really illustrative:

"For example, a partially allocated cluster at the end of a QCOW2 file,
where Qcow2 generally operates on complete clusters."

> +# So, the fields are:
> +#
> +# @used-data: used by the format file and backed by data in the underlying file
> +#
> +# @used-zero: used by the format file and backed by a hole in the underlying
> +#             file
> +#

Maybe "backed by zeroes in the underlying file; which may be a
filesystem hole for e.g. POSIX files."

> +# @used-discarded: used by the format file but actually unallocated in the
> +#                  underlying file
> +#

Which would almost certainly be an error, right? Mentioning as much
might be good.

> +# @used-overrun: used by the format file beyond the end of the underlying file
> +#

Which may or may not be an error, depending on how the protocol file
(for the format driver?) handles reads to areas out of bounds.

> +# @unused-data: allocated data in the underlying file not used by the format
> +#
> +# @unused-zero: holes in the underlying file not used by the format file
> +#
> +# @unused-discarded: unallocated areas in the underlying file not used by the
> +#                    format file
> +#
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

All of my suggestions here are purely on phrasings. The mechanics of
this patch are now clear to me and I think it is useful information to
have in qemu.

Thanks for putting up with my questions!
