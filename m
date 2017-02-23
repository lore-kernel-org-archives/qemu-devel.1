Received: from eggs.gnu.org ([2001:4830:134:3::10]:40229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgsdu-0005R0-AZ
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgsdt-0007zy-HF
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:37:06 -0500
Date: Thu, 23 Feb 2017 20:36:57 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170223123657.GG14175@lemon.lan>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-17-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487689130-30373-17-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/54] block: Default .bdrv_child_perm()
 for filter drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

On Tue, 02/21 15:58, Kevin Wolf wrote:
> Most filters need permissions related to read and write for their
> children, but only if the node has a parent that wants to use the same
> operation on the filter. The same is true for resize.

I cannot parse this paragraph, especially the 'but only if' part..

> 
> This adds a default implementation that simply forwards all necessary
> permissions to all children of the node and leaves the other permissions
> unchanged.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                   | 24 ++++++++++++++++++++++++
>  include/block/block_int.h |  8 ++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/block.c b/block.c
> index 2a86781..523cbd3 100644
> --- a/block.c
> +++ b/block.c
> @@ -1531,6 +1531,30 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
>      return 0;
>  }
>  
> +#define DEFAULT_PERM_PASSTHROUGH (BLK_PERM_CONSISTENT_READ \
> +                                 | BLK_PERM_WRITE \
> +                                 | BLK_PERM_WRITE_UNCHANGED \
> +                                 | BLK_PERM_RESIZE)
> +#define DEFAULT_PERM_UNCHANGED (BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHROUGH)
> +
> +void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
> +                               const BdrvChildRole *role,
> +                               uint64_t perm, uint64_t shared,
> +                               uint64_t *nperm, uint64_t *nshared)
> +{
> +    if (c == NULL) {
> +        *nperm = 0;
> +        *nshared = BLK_PERM_ALL;
> +        return;
> +    }
> +
> +    *nperm = (perm & DEFAULT_PERM_PASSTHROUGH) |
> +             (c->perm & DEFAULT_PERM_UNCHANGED);
> +    *nshared = (shared & DEFAULT_PERM_PASSTHROUGH) |
> +               (c->shared_perm & DEFAULT_PERM_UNCHANGED);
> +}
> +
> +
>  static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
>  {
>      BlockDriverState *old_bs = child->bs;
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index cef2b6e..17f4c2d 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -872,6 +872,14 @@ void bdrv_child_abort_perm_update(BdrvChild *c);
>  int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
>                              Error **errp);
>  
> +/* Default implementation for BlockDriver.bdrv_child_perm() that can be used by
> + * block filters: Forward CONSISTENT_READ, WRITE, WRITE_UNCHANGED and RESIZE to
> + * all children */
> +void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
> +                               const BdrvChildRole *role,
> +                               uint64_t perm, uint64_t shared,
> +                               uint64_t *nperm, uint64_t *nshared);
> +
>  
>  const char *bdrv_get_parent_name(const BlockDriverState *bs);
>  void blk_dev_change_media_cb(BlockBackend *blk, bool load);
> -- 
> 1.8.3.1
> 
