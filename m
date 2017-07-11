Received: from eggs.gnu.org ([2001:4830:134:3::10]:55886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUwtn-0005lD-Qf
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUwtm-0005zW-Rq
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:16:27 -0400
Date: Tue, 11 Jul 2017 17:16:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170711151617.GK4335@noname.str.redhat.com>
References: <20170701153906.16588-1-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170701153906.16588-1-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v2] block: fix leaks in bdrv_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, Max Reitz <mreitz@redhat.com>

Am 01.07.2017 um 17:39 hat Manos Pitsidianakis geschrieben:
> bdrv_open_driver() is called in two places, bdrv_new_open_driver() and
> bdrv_open_common(). In the latter, failure cleanup in is in its caller,
> bdrv_open_inherit(), which unrefs the bs->file of the failed driver open if it
> exists.
> 
> Let's move the bs->file cleanup to bdrv_open_driver() to take care of all
> callers and do not set bs->drv to NULL unless the driver's open function
> failed. When bs is destroyed by removing its last reference, bdrv_close()
> checks bs->drv to perform the needed cleanups and also call the driver's close
> function.
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
> 
> v2:
>  move bdrv_unref_child(bs, bs->file) to bdrv_open_driver
>  do not set bs->drv to NULL if open succeeds 
> 
>  block.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 694396281b..df2a46990c 100644
> --- a/block.c
> +++ b/block.c
> @@ -1091,6 +1091,7 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
>  {
>      Error *local_err = NULL;
>      int ret;
> +    bool open_failed;
>  
>      bdrv_assign_node_name(bs, node_name, &local_err);
>      if (local_err) {
> @@ -1111,7 +1112,9 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
>          ret = 0;
>      }
>  
> -    if (ret < 0) {
> +    open_failed = ret < 0;
> +
> +    if (open_failed) {
>          if (local_err) {
>              error_propagate(errp, local_err);
>          } else if (bs->filename[0]) {
> @@ -1142,10 +1145,15 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
>      return 0;
>  
>  free_and_fail:
> -    /* FIXME Close bs first if already opened*/
> -    g_free(bs->opaque);
> -    bs->opaque = NULL;
> -    bs->drv = NULL;
> +    if (open_failed) {
> +        g_free(bs->opaque);
> +        bs->opaque = NULL;
> +        bs->drv = NULL;
> +    }
> +    if (bs->file != NULL) {
> +        bdrv_unref_child(bs, bs->file);
> +        bs->file = NULL;
> +    }

Is this bdrv_unref_child() safe if we leave bs->drv set? Format drivers
expect that if an image is opened, it also has a valid bs->file.

For example, if I add ret = -1 after refresh_total_sectors() (because I
couldn't find an easier way to make it fail intentionally), I get an
ugly heap corruption crash instead of a nice error message with this
patch.

Kevin
