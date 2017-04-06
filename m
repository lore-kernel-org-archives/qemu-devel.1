Received: from eggs.gnu.org ([2001:4830:134:3::10]:52695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cw8WI-0003kH-VU
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cw8WH-00076B-L7
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:36:19 -0400
Date: Thu, 6 Apr 2017 16:36:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170406143607.GH4341@noname.redhat.com>
References: <20170406142527.25835-1-famz@redhat.com>
	<20170406142527.25835-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170406142527.25835-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/5] block: Fix unpaired
 aio_disable_external in external snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 06.04.2017 um 16:25 hat Fam Zheng geschrieben:
> bdrv_replace_child_noperm tries to hand over the quiesce_counter state
> from old bs to the new one, but if they are not on the same aio context
> this causes unbalance.
> 
> Fix this by forcing callers to move the aio context first, and assert
> it.
> 
> Reported-by: Ed Swierk <eswierk@skyportsystems.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block.c    | 3 +++
>  blockdev.c | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 927ba89..8893ac1 100644
> --- a/block.c
> +++ b/block.c
> @@ -1752,6 +1752,9 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
>  {
>      BlockDriverState *old_bs = child->bs;
>  
> +    if (old_bs && new_bs) {
> +        assert(bdrv_get_aio_context(old_bs) == bdrv_get_aio_context(new_bs));
> +    }
>      if (old_bs) {
>          if (old_bs->quiesce_counter && child->role->drained_end) {
>              child->role->drained_end(child);

Can we move this to a separate patch and also add this hunk for
asserting the same thing for newly attached child nodes:

@@ -1852,6 +1855,7 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
     bdrv_get_cumulative_perm(parent_bs, &perm, &shared_perm);
 
     assert(parent_bs->drv);
+    assert(bdrv_get_aio_context(parent_bs) == bdrv_get_aio_context(child_bs));
     parent_bs->drv->bdrv_child_perm(parent_bs, NULL, child_role,
                                     perm, shared_perm, &perm, &shared_perm);

Kevin
