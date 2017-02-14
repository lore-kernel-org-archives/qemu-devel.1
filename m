Received: from eggs.gnu.org ([2001:4830:134:3::10]:44656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdW1p-0002LF-7Z
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 00:51:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdW1o-0007D4-0A
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 00:51:53 -0500
Date: Tue, 14 Feb 2017 13:51:42 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170214055142.GB6428@lemon.lan>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-7-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487006583-24350-7-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 06/41] block: Involve block drivers in
 permission granting
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
> +int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
> +                            Error **errp)
> +{
> +    int ret;
> +
> +    ret = bdrv_child_check_perm(c, perm, shared, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    bdrv_child_set_perm(c, perm, shared);

This has an issue of TOCTOU, which means image locking cannot fit in easily.
Maybe squash them into one callback (.bdrv_try_set_perm) that can return error?

> +
>      return 0;
>  }
>  
> @@ -1322,6 +1445,7 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
>              child->role->drained_end(child);
>          }
>          QLIST_REMOVE(child, next_parent);
> +        bdrv_update_perm(old_bs);
>      }
>  
>      child->bs = new_bs;
> @@ -1331,6 +1455,7 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
>          if (new_bs->quiesce_counter && child->role->drained_begin) {
>              child->role->drained_begin(child);
>          }
> +        bdrv_update_perm(new_bs);
>      }
>  }
>  
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index f36b064..8578e17 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -320,6 +320,45 @@ struct BlockDriver {
>      void (*bdrv_del_child)(BlockDriverState *parent, BdrvChild *child,
>                             Error **errp);
>  
> +    /**
> +     * Checks whether the requested set of cumulative permissions in @perm
> +     * can be granted for accessing @bs and whether no other users are using
> +     * permissions other than those given in @shared (both arguments take
> +     * BLK_PERM_* bitmasks).
> +     *
> +     * If both conditions are met, 0 is returned. Otherwise, -errno is returned
> +     * and errp is set to an error describing the conflict.
> +     */
> +    int (*bdrv_check_perm)(BlockDriverState *bs, uint64_t perm,
> +                           uint64_t shared, Error **errp);
> +
> +    /**
> +     * Called to inform the driver that the set of cumulative set of used
> +     * permissions for @bs has changed to @perm, and the set of sharable
> +     * permission to @shared. The driver can use this to propagate changes to
> +     * its children (i.e. request permissions only if a parent actually needs
> +     * them).
> +     *
> +     * If permissions are added to @perm or dropped from @shared, callers must
> +     * use bdrv_check_perm() first to ensure that this operation is valid.
> +     * Dropping from @perm or adding to @shared is always allowed without a
> +     * previous check.
> +     */
> +    void (*bdrv_set_perm)(BlockDriverState *bs, uint64_t perm, uint64_t shared);
> +
> +    /**
> +     * Returns in @nperm and @nshared the permissions that the driver for @bs
> +     * needs on its child @c, based on the cumulative permissions requested by
> +     * the parents in @parent_perm and @parent_shared.
> +     *
> +     * If @c is NULL, return the permissions for attaching a new child for the
> +     * given @role.
> +     */
> +     void (*bdrv_child_perm)(BlockDriverState* bs, BdrvChild *c,
> +                             const BdrvChildRole *role,
> +                             uint64_t parent_perm, uint64_t parent_shared,
> +                             uint64_t *nperm, uint64_t *nshared);
> +
>      QLIST_ENTRY(BlockDriver) list;
>  };
>  
> @@ -832,6 +871,13 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
>                                    void *opaque, Error **errp);
>  void bdrv_root_unref_child(BdrvChild *child);
>  
> +int bdrv_child_check_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
> +                          Error **errp);
> +void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared);
> +int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
> +                            Error **errp);
> +
> +
>  const char *bdrv_get_parent_name(const BlockDriverState *bs);
>  void blk_dev_change_media_cb(BlockBackend *blk, bool load);
>  bool blk_dev_has_removable_media(BlockBackend *blk);
> -- 
> 1.8.3.1
> 
