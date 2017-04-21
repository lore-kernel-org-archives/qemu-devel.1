Received: from eggs.gnu.org ([2001:4830:134:3::10]:56732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d1U5i-0007Os-BL
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d1U5h-0004Zy-EL
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:38:58 -0400
Date: Fri, 21 Apr 2017 10:38:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170421083846.GC4318@noname.redhat.com>
References: <20170421035606.448-1-famz@redhat.com>
	<20170421035606.448-4-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170421035606.448-4-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v14 03/20] block: Respect
 "force-shared-write" in perm propagating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 21.04.2017 um 05:55 hat Fam Zheng geschrieben:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/block.c b/block.c
> index f5c4e97..6acf618 100644
> --- a/block.c
> +++ b/block.c
> @@ -1422,6 +1422,21 @@ static int bdrv_child_check_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
>  static void bdrv_child_abort_perm_update(BdrvChild *c);
>  static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared);
>  
> +static void bdrv_child_perm(BlockDriverState *bs, BdrvChild *c,
> +                            const BdrvChildRole *role,
> +                            uint64_t parent_perm, uint64_t parent_shared,
> +                            uint64_t *nperm, uint64_t *nshared)
> +{
> +    if (bs->drv && bs->drv->bdrv_child_perm) {
> +        bs->drv->bdrv_child_perm(bs, c, role,
> +                                 parent_perm, parent_shared,
> +                                 nperm, nshared);
> +    }
> +    if (bs->force_shared_write) {

As discussed on IRC, this should be c->bs->force_shared_write, so that
the option set for a given node refers to all BdrvChild objects pointing
to that node, not to all children of the node.

This means that if you configure this manually and you just want to get
rid of the file locking, setting force-shared-write = true for the
file-posix node is enough (without the change you would have to set it
for all parents of the file-posix node).

> +        *nshared |= BLK_PERM_WRITE;
> +    }
> +}

Kevin
