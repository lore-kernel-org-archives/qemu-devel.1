Received: from eggs.gnu.org ([2001:4830:134:3::10]:33958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ddIvP-0001A1-4V
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ddIvN-0000JT-Mn
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:24:39 -0400
Date: Thu, 3 Aug 2017 12:24:29 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170803162429.GG22129@localhost.localdomain>
References: <20170803150301.10177-1-kwolf@redhat.com>
	<20170803150301.10177-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170803150301.10177-4-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 3/5] block: Set
 BDRV_O_ALLOW_RDWR during rw reopen
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

On Thu, Aug 03, 2017 at 05:02:59PM +0200, Kevin Wolf wrote:
> Reopening an image should be consistent with opening it, so we should
> set BDRV_O_ALLOW_RDWR for any image that is reopened read-write like in
> bdrv_open_inherit().
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block.c b/block.c
> index 2711c3dd3b..3615a6809e 100644
> --- a/block.c
> +++ b/block.c
> @@ -2729,8 +2729,11 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
>      bdrv_join_options(bs, options, old_options);
>      QDECREF(old_options);
>  
> -    /* bdrv_open() masks this flag out */
> +    /* bdrv_open_inherit() sets and clears some additional flags internally */
>      flags &= ~BDRV_O_PROTOCOL;
> +    if (flags & BDRV_O_RDWR) {
> +        flags |= BDRV_O_ALLOW_RDWR;
> +    }
>  
>      QLIST_FOREACH(child, &bs->children, next) {
>          QDict *new_child_options;
> -- 
> 2.13.3
> 
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>
