Received: from eggs.gnu.org ([2001:4830:134:3::10]:48459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdWB2-0005A6-1o
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 01:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdWB0-00031g-Ry
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 01:01:24 -0500
Date: Tue, 14 Feb 2017 14:01:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170214060112.GC6428@lemon.lan>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-10-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487006583-24350-10-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 09/41] block: Default
 .bdrv_child_perm() for format drivers
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

On Mon, 02/13 18:22, Kevin Wolf wrote:
> Almost all format drivers have the same characteristics as far as
> permissions are concerned: They have one or more children for storing
> their own data and, more importantly, metadata (can be written to and
> grow even without external write requests, must be protected against
> other writers and present consistent data) and optionally a backing file
> (this is just data, so like for a filter, it only depends on what the
> parent nodes need).
> 
> This provides a default implementation that can be shared by most of
> our format drivers.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                   | 37 +++++++++++++++++++++++++++++++++++++
>  include/block/block_int.h |  8 ++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/block.c b/block.c
> index 290768d..8e99bb5 100644
> --- a/block.c
> +++ b/block.c
> @@ -1459,6 +1459,43 @@ void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
>                 (c->shared_perm & DEFAULT_PERM_UNCHANGED);
>  }
>  
> +void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
> +                               const BdrvChildRole *role,
> +                               uint64_t perm, uint64_t shared,
> +                               uint64_t *nperm, uint64_t *nshared)
> +{
> +    bool backing = (role == &child_backing);
> +    assert(role == &child_backing || role == &child_file);
> +
> +    if (!backing) {
> +        /* Apart from the modifications below, the same permissions are
> +         * forwarded and left alone as for filters */
> +        bdrv_filter_default_perms(bs, c, role, perm, shared, &perm, &shared);
> +
> +        /* Format drivers may touch metadata even if the guest doesn't write */
> +        if (!bdrv_is_read_only(bs)) {
> +            perm |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
> +        }
> +
> +        /* bs->file always needs to be consistent because of the metadata. We
> +         * can never allow other users to resize or write to it. */
> +        perm |= BLK_PERM_CONSISTENT_READ;
> +        shared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
> +    } else {
> +        /* We want consistent read from backing files if the parent needs it.
> +         * No other operations are performed on backing files. */
> +        perm &= BLK_PERM_CONSISTENT_READ;

Do you mean "perm &= ~BLK_PERM_CONSISTENT_READ"?

> +
> +        /* If the parent can deal with changing data, we're okay with a
> +         * writable backing file. */
> +        shared &= BLK_PERM_WRITE;
> +        shared |= BLK_PERM_CONSISTENT_READ | BLK_PERM_GRAPH_MOD |
> +                  BLK_PERM_WRITE_UNCHANGED;
> +    }
> +
> +    *nperm = perm;
> +    *nshared = shared;
> +}
>  
>  static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
>  {
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 2d74f92..46f51a6 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -885,6 +885,14 @@ void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
>                                 uint64_t perm, uint64_t shared,
>                                 uint64_t *nperm, uint64_t *nshared);
>  
> +/* Default implementation for BlockDriver.bdrv_child_perm() that can be used by
> + * (non-raw) image formats: Like above for bs->backing, but for bs->file it
> + * requires WRITE | RESIZE for read-write images, always requires
> + * CONSISTENT_READ and doesn't share WRITE. */
> +void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
> +                               const BdrvChildRole *role,
> +                               uint64_t perm, uint64_t shared,
> +                               uint64_t *nperm, uint64_t *nshared);
>  
>  const char *bdrv_get_parent_name(const BlockDriverState *bs);
>  void blk_dev_change_media_cb(BlockBackend *blk, bool load);
> -- 
> 1.8.3.1
> 
