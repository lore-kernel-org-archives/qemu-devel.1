Received: from eggs.gnu.org ([2001:4830:134:3::10]:54555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ddIpj-0005gY-Up
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ddIpi-00011f-Tf
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:18:47 -0400
Date: Thu, 3 Aug 2017 12:18:38 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170803161838.GE22129@localhost.localdomain>
References: <20170803150301.10177-1-kwolf@redhat.com>
	<20170803150301.10177-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170803150301.10177-2-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 1/5] block: Fix order
 in bdrv_replace_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

On Thu, Aug 03, 2017 at 05:02:57PM +0200, Kevin Wolf wrote:
> Commit 8ee03995 refactored the code incorrectly and broke the release of
> permissions on the old BDS. Instead of changing the permissions to the
> new required values after removing the old BDS from the list of
> children, it only re-obtains the permissions it already had.
> 
> Change the order of operations so that the old BDS is removed again
> before calculating the new required permissions.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block.c b/block.c
> index ce9cce7b3c..ab908cdc50 100644
> --- a/block.c
> +++ b/block.c
> @@ -1933,6 +1933,8 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
>      BlockDriverState *old_bs = child->bs;
>      uint64_t perm, shared_perm;
>  
> +    bdrv_replace_child_noperm(child, new_bs);
> +
>      if (old_bs) {
>          /* Update permissions for old node. This is guaranteed to succeed
>           * because we're just taking a parent away, so we're loosening
> @@ -1942,8 +1944,6 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
>          bdrv_set_perm(old_bs, perm, shared_perm);
>      }
>  
> -    bdrv_replace_child_noperm(child, new_bs);
> -
>      if (new_bs) {
>          bdrv_get_cumulative_perm(new_bs, &perm, &shared_perm);
>          bdrv_set_perm(new_bs, perm, shared_perm);
> -- 
> 2.13.3
> 
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>
