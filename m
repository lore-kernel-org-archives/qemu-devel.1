Received: from eggs.gnu.org ([2001:4830:134:3::10]:58710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVLmK-0004cH-7d
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVLmJ-00056h-8E
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:54:56 -0400
References: <20180619183457.371081-1-vsementsov@virtuozzo.com>
	<20180619183457.371081-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa8426e8-2f3b-6d7f-50e3-90304ca69fbf@redhat.com>
Date: Tue, 19 Jun 2018 13:54:48 -0500
MIME-Version: 1.0
In-Reply-To: <20180619183457.371081-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/7] block/qcow2-refcount: fix out-of-file
 L1 entries to be zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com

On 06/19/2018 01:34 PM, Vladimir Sementsov-Ogievskiy wrote:
> Zero out corrupted L1 table entry, which reference L2 table out of
> underlying file.
> Zero L1 table entry means that "the L2 table and all clusters described
> by this L2 table are unallocated."
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/qcow2-refcount.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index d993252fb6..3c9e2da39e 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -1641,6 +1641,29 @@ static int fix_l2_entry_to_zero(BlockDriverState *bs, BdrvCheckResult *res,
>       return ret;
>   }
>   
> +/* Zero out L1 entry
> + *
> + * Returns: -errno if overlap check failed
> + *          0 if write failed

If the write failed, wouldn't there be an errno value worth returning?

> + *          1 on success
> + */
> +static int fix_l1_entry_to_zero(BlockDriverState *bs, BdrvCheckResult *res,
> +                                BdrvCheckMode fix, int64_t l1_offset,
> +                                int l1_index, bool active,
> +                                const char *fmt, ...)
> +{
> +    int ret;
> +    int ign = active ? QCOW2_OL_ACTIVE_L2 : QCOW2_OL_INACTIVE_L2;
> +    va_list args;
> +
> +    va_start(args, fmt);
> +    ret = fix_table_entry(bs, res, fix, "L1", l1_offset, l1_index, 0, ign,
> +                          fmt, args);
> +    va_end(args);
> +
> +    return ret;
> +}
> +
>   /*
>    * Increases the refcount in the given refcount table for the all clusters
>    * referenced in the L2 table. While doing so, performs some checks on L2
> @@ -1837,6 +1860,20 @@ static int check_refcounts_l1(BlockDriverState *bs,
>           if (l2_offset) {
>               /* Mark L2 table as used */
>               l2_offset &= L1E_OFFSET_MASK;
> +            if (l2_offset >= bdrv_getlength(bs->file->bs)) {

Again, bdrv_getlength() can fail; you want to make sure that you check 
for failures before using it in comparisons.

> +                ret = fix_l1_entry_to_zero(
> +                        bs, res, fix, l1_table_offset, i, active,
> +                        "l2 table offset out of file: offset 0x%" PRIx64,
> +                        l2_offset);
> +                if (ret < 0) {
> +                    /* Something is seriously wrong, so abort checking
> +                     * this L1 table */
> +                    goto fail;
> +                }
> +
> +                continue;
> +            }
> +
>               ret = qcow2_inc_refcounts_imrt(bs, res,
>                                              refcount_table, refcount_table_size,
>                                              l2_offset, s->cluster_size);
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
