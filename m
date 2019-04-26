Received: from eggs.gnu.org ([209.51.188.92]:33833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hK1Q9-0003u7-25
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hK1Q8-0005j4-39
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:01:45 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190404112953.4058-1-berto@igalia.com>
References: <20190404112953.4058-1-berto@igalia.com>
Date: Fri, 26 Apr 2019 16:01:42 +0200
Message-ID: <w51y33wg915.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-4.1] block: Assert that
 drv->bdrv_child_perm is set in bdrv_child_perm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

ping

On Thu 04 Apr 2019 01:29:53 PM CEST, Alberto Garcia wrote:
> There is no need to check for this because all block drivers that have
> children implement bdrv_child_perm and all callers already ensure that
> bs->drv is set.
>
> Furthermore, if this check would fail then the callers would end up
> with uninitialized values for nperm and nshared.
>
> This patch replaces the check with an assertion.
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/block.c b/block.c
> index 3050854528..5f92565692 100644
> --- a/block.c
> +++ b/block.c
> @@ -1742,11 +1742,10 @@ static void bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_bs,
>                              uint64_t parent_perm, uint64_t parent_shared,
>                              uint64_t *nperm, uint64_t *nshared)
>  {
> -    if (bs->drv && bs->drv->bdrv_child_perm) {
> -        bs->drv->bdrv_child_perm(bs, c, role, reopen_queue,
> -                                 parent_perm, parent_shared,
> -                                 nperm, nshared);
> -    }
> +    assert(bs->drv && bs->drv->bdrv_child_perm);
> +    bs->drv->bdrv_child_perm(bs, c, role, reopen_queue,
> +                             parent_perm, parent_shared,
> +                             nperm, nshared);
>      /* TODO Take force_share from reopen_queue */
>      if (child_bs && child_bs->force_share) {
>          *nshared = BLK_PERM_ALL;
> -- 
> 2.11.0
