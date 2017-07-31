Received: from eggs.gnu.org ([2001:4830:134:3::10]:35856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dcBps-0000WR-Ok
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dcBpo-0001yy-QV
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:38:20 -0400
Date: Mon, 31 Jul 2017 10:38:09 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170731143809.GC22129@localhost.localdomain>
References: <20170731125111.28052-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170731125111.28052-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] block/qapi: Remove redundat NULL
 check to silence Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org

On Mon, Jul 31, 2017 at 02:51:11PM +0200, Kevin Wolf wrote:
> When skipping implicit nodes in bdrv_block_device_info(), we know that
> bs0 is always non-NULL; initially, because it's taken from a BdrvChild

Not to mention, we deference bs0 in the chunk of code right above this, so
we'd segfault anyway if the initial value was NULL.

> and a BdrvChild never has a NULL bs, and after the first iteration
> because implicit nodes always have a backing file.
> 
> Remove the NULL check and add an assertion that the implicit node does
> indeed have a backing file.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>


Reviewed-by: Jeff Cody <jcody@redhat.com>



> ---
>  block/qapi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/qapi.c b/block/qapi.c
> index d2b18ee9df..5f1a71f5d2 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -145,8 +145,9 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>  
>          /* Skip automatically inserted nodes that the user isn't aware of for
>           * query-block (blk != NULL), but not for query-named-block-nodes */
> -        while (blk && bs0 && bs0->drv && bs0->implicit) {
> +        while (blk && bs0->drv && bs0->implicit) {
>              bs0 = backing_bs(bs0);
> +            assert(bs0);
>          }
>      }
>  
> -- 
> 2.13.3
> 
> 
