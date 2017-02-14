Received: from eggs.gnu.org ([2001:4830:134:3::10]:40624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdmDC-0007II-U1
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 18:08:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdmDB-000610-9r
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 18:08:42 -0500
References: <1487091579-67092-1-git-send-email-vsementsov@virtuozzo.com>
	<1487091579-67092-21-git-send-email-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <cb9fc49a-1c59-a374-2248-b2e168025895@redhat.com>
Date: Tue, 14 Feb 2017 18:08:32 -0500
MIME-Version: 1.0
In-Reply-To: <1487091579-67092-21-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/25] qcow2-refcount: rename
 inc_refcounts() and make it public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org



On 02/14/2017 11:59 AM, Vladimir Sementsov-Ogievskiy wrote:
> This is needed for the following patch, which will introduce refcounts
> checking for qcow2 bitmaps.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2-refcount.c | 53 ++++++++++++++++++++++++++------------------------
>  block/qcow2.h          |  4 ++++
>  2 files changed, 32 insertions(+), 25 deletions(-)
> 
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index cbfb3fe..14a736d 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -1309,11 +1309,10 @@ static int realloc_refcount_array(BDRVQcow2State *s, void **array,
>   *
>   * Modifies the number of errors in res.
>   */
> -static int inc_refcounts(BlockDriverState *bs,
> -                         BdrvCheckResult *res,
> -                         void **refcount_table,
> -                         int64_t *refcount_table_size,
> -                         int64_t offset, int64_t size)
> +int qcow2_inc_refcounts_imrt(BlockDriverState *bs, BdrvCheckResult *res,
> +                             void **refcount_table,
> +                             int64_t *refcount_table_size,
> +                             int64_t offset, int64_t size)
>  {
>      BDRVQcow2State *s = bs->opaque;
>      uint64_t start, last, cluster_offset, k, refcount;
> @@ -1406,8 +1405,9 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
>              nb_csectors = ((l2_entry >> s->csize_shift) &
>                             s->csize_mask) + 1;
>              l2_entry &= s->cluster_offset_mask;
> -            ret = inc_refcounts(bs, res, refcount_table, refcount_table_size,
> -                                l2_entry & ~511, nb_csectors * 512);
> +            ret = qcow2_inc_refcounts_imrt(bs, res,
> +                                           refcount_table, refcount_table_size,
> +                                           l2_entry & ~511, nb_csectors * 512);
>              if (ret < 0) {
>                  goto fail;
>              }
> @@ -1445,8 +1445,9 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
>              }
>  
>              /* Mark cluster as used */
> -            ret = inc_refcounts(bs, res, refcount_table, refcount_table_size,
> -                                offset, s->cluster_size);
> +            ret = qcow2_inc_refcounts_imrt(bs, res,
> +                                           refcount_table, refcount_table_size,
> +                                           offset, s->cluster_size);
>              if (ret < 0) {
>                  goto fail;
>              }
> @@ -1498,8 +1499,8 @@ static int check_refcounts_l1(BlockDriverState *bs,
>      l1_size2 = l1_size * sizeof(uint64_t);
>  
>      /* Mark L1 table as used */
> -    ret = inc_refcounts(bs, res, refcount_table, refcount_table_size,
> -                        l1_table_offset, l1_size2);
> +    ret = qcow2_inc_refcounts_imrt(bs, res, refcount_table, refcount_table_size,
> +                                   l1_table_offset, l1_size2);
>      if (ret < 0) {
>          goto fail;
>      }
> @@ -1528,8 +1529,9 @@ static int check_refcounts_l1(BlockDriverState *bs,
>          if (l2_offset) {
>              /* Mark L2 table as used */
>              l2_offset &= L1E_OFFSET_MASK;
> -            ret = inc_refcounts(bs, res, refcount_table, refcount_table_size,
> -                                l2_offset, s->cluster_size);
> +            ret = qcow2_inc_refcounts_imrt(bs, res,
> +                                           refcount_table, refcount_table_size,
> +                                           l2_offset, s->cluster_size);
>              if (ret < 0) {
>                  goto fail;
>              }
> @@ -1744,14 +1746,15 @@ static int check_refblocks(BlockDriverState *bs, BdrvCheckResult *res,
>                  }
>  
>                  res->corruptions_fixed++;
> -                ret = inc_refcounts(bs, res, refcount_table, nb_clusters,
> -                                    offset, s->cluster_size);
> +                ret = qcow2_inc_refcounts_imrt(bs, res,
> +                                               refcount_table, nb_clusters,
> +                                               offset, s->cluster_size);
>                  if (ret < 0) {
>                      return ret;
>                  }
>                  /* No need to check whether the refcount is now greater than 1:
>                   * This area was just allocated and zeroed, so it can only be
> -                 * exactly 1 after inc_refcounts() */
> +                 * exactly 1 after qcow2_inc_refcounts_imrt() */
>                  continue;
>  
>  resize_fail:
> @@ -1766,8 +1769,8 @@ resize_fail:
>          }
>  
>          if (offset != 0) {
> -            ret = inc_refcounts(bs, res, refcount_table, nb_clusters,
> -                                offset, s->cluster_size);
> +            ret = qcow2_inc_refcounts_imrt(bs, res, refcount_table, nb_clusters,
> +                                           offset, s->cluster_size);
>              if (ret < 0) {
>                  return ret;
>              }
> @@ -1807,8 +1810,8 @@ static int calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>      }
>  
>      /* header */
> -    ret = inc_refcounts(bs, res, refcount_table, nb_clusters,
> -                        0, s->cluster_size);
> +    ret = qcow2_inc_refcounts_imrt(bs, res, refcount_table, nb_clusters,
> +                                   0, s->cluster_size);
>      if (ret < 0) {
>          return ret;
>      }
> @@ -1829,16 +1832,16 @@ static int calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>              return ret;
>          }
>      }
> -    ret = inc_refcounts(bs, res, refcount_table, nb_clusters,
> -                        s->snapshots_offset, s->snapshots_size);
> +    ret = qcow2_inc_refcounts_imrt(bs, res, refcount_table, nb_clusters,
> +                                   s->snapshots_offset, s->snapshots_size);
>      if (ret < 0) {
>          return ret;
>      }
>  
>      /* refcount data */
> -    ret = inc_refcounts(bs, res, refcount_table, nb_clusters,
> -                        s->refcount_table_offset,
> -                        s->refcount_table_size * sizeof(uint64_t));
> +    ret = qcow2_inc_refcounts_imrt(bs, res, refcount_table, nb_clusters,
> +                                   s->refcount_table_offset,
> +                                   s->refcount_table_size * sizeof(uint64_t));
>      if (ret < 0) {
>          return ret;
>      }
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 749710d..0a3708d 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -543,6 +543,10 @@ int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
>                                   int64_t size);
>  int qcow2_pre_write_overlap_check(BlockDriverState *bs, int ign, int64_t offset,
>                                    int64_t size);
> +int qcow2_inc_refcounts_imrt(BlockDriverState *bs, BdrvCheckResult *res,
> +                             void **refcount_table,
> +                             int64_t *refcount_table_size,
> +                             int64_t offset, int64_t size);
>  
>  int qcow2_change_refcount_order(BlockDriverState *bs, int refcount_order,
>                                  BlockDriverAmendStatusCB *status_cb,
> 

Mechanically safe of course. Max and Kevin will be the experts for the
implications in qcow2-land. (And Max already gave his blessings!)


Reviewed-by: John Snow <jsnow@redhat.com>
