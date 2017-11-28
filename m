Received: from eggs.gnu.org ([2001:4830:134:3::10]:43258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eJiTO-0002N9-0X
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eJiTI-0001pV-Co
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:11:01 -0500
Date: Tue, 28 Nov 2017 11:10:40 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171128161040.GE25110@localhost.localdomain>
References: <20171128154350.21504-1-kwolf@redhat.com>
	<20171128154350.21504-5-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171128154350.21504-5-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 4/4] block: Expect graph changes
 in bdrv_parent_drained_begin/end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

On Tue, Nov 28, 2017 at 04:43:50PM +0100, Kevin Wolf wrote:
> The .drained_begin/end callbacks can (directly or indirectly via
> aio_poll()) cause block nodes to be removed or the current BdrvChild to
> point to a different child node.
> 
> Use QLIST_FOREACH_SAFE() to make sure we don't access invalid
> BlockDriverStates or accidentally continue iterating the parents of the
> new child node instead of the node we actually came from.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/io.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 4fdf93a014..6773926fc1 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -42,9 +42,9 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
>  
>  void bdrv_parent_drained_begin(BlockDriverState *bs)
>  {
> -    BdrvChild *c;
> +    BdrvChild *c, *next;
>  
> -    QLIST_FOREACH(c, &bs->parents, next_parent) {
> +    QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
>          if (c->role->drained_begin) {
>              c->role->drained_begin(c);
>          }
> @@ -53,9 +53,9 @@ void bdrv_parent_drained_begin(BlockDriverState *bs)
>  
>  void bdrv_parent_drained_end(BlockDriverState *bs)
>  {
> -    BdrvChild *c;
> +    BdrvChild *c, *next;
>  
> -    QLIST_FOREACH(c, &bs->parents, next_parent) {
> +    QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
>          if (c->role->drained_end) {
>              c->role->drained_end(c);
>          }
> -- 
> 2.13.6
> 
Reviewed-by: Jeff Cody <jcody@redhat.com>
