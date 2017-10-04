Received: from eggs.gnu.org ([2001:4830:134:3::10]:47096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dzgrB-0004zw-Aj
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dzgrA-0004N2-H6
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:24:49 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1488286469-9381-29-git-send-email-kwolf@redhat.com>
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
	<1488286469-9381-29-git-send-email-kwolf@redhat.com>
Date: Wed, 04 Oct 2017 12:24:05 +0200
Message-ID: <w51y3or9poa.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 28/44] block: Fix pending
 requests check in bdrv_append()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, qemu-stable@nongnu.org

On Tue 28 Feb 2017 01:54:13 PM CET, Kevin Wolf wrote:
> bdrv_append() cares about isolation of the node that it modifies, but
> not about activity in some subtree below it. Instead of using the
> recursive bdrv_requests_pending(), directly check bs->in_flight, which
> considers only the node in question.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block.c b/block.c
> index 9e538a5..5189c7c 100644
> --- a/block.c
> +++ b/block.c
> @@ -2897,8 +2897,8 @@ static void change_parent_backing_link(BlockDriverState *from,
>   */
>  void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top)
>  {
> -    assert(!bdrv_requests_pending(bs_top));
> -    assert(!bdrv_requests_pending(bs_new));
> +    assert(!atomic_read(&bs_top->in_flight));
> +    assert(!atomic_read(&bs_new->in_flight));
>  
>      bdrv_ref(bs_top);

I don't know if there's still any maintenance on the v2.8.x branch, but
I can make v2.8.1.1 crash easily because of this failing assertion.
Applying this patch fixes the issue.

I can provide more details if needed.

Regards,

Berto
