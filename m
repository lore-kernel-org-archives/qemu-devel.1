Received: from eggs.gnu.org ([2001:4830:134:3::10]:60318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQXT0-0002ZG-6N
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQXSz-0005r6-BM
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:18:34 -0400
Date: Thu, 29 Jun 2017 13:18:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170629111824.GC4618@noname.redhat.com>
References: <20170629060300.29869-1-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170629060300.29869-1-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH] block: fix bs->file leak in
 bdrv_new_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

Am 29.06.2017 um 08:03 hat Manos Pitsidianakis geschrieben:
> bdrv_open_driver() is called in two places, bdrv_new_open_driver() and
> bdrv_open_common(). In the latter, failure cleanup in is in its caller,
> bdrv_open_inherit(), which unrefs the bs->file of the failed driver open
> if it exists. Let's check for this in bdrv_new_open_driver() as well.
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block.c b/block.c
> index 694396281b..aeacd520e0 100644
> --- a/block.c
> +++ b/block.c
> @@ -1165,6 +1165,9 @@ BlockDriverState *bdrv_new_open_driver(BlockDriver *drv, const char *node_name,
>  
>      ret = bdrv_open_driver(bs, drv, node_name, bs->options, flags, errp);
>      if (ret < 0) {
> +        if (bs->file != NULL) {
> +            bdrv_unref_child(bs, bs->file);
> +        }
>          QDECREF(bs->explicit_options);
>          QDECREF(bs->options);
>          bdrv_unref(bs);

I think we should set bs->file = NULL here to remove the dangling
pointer. I think it is never accessed anyway because of the
bs->drv = NULL in the error path of bdrv_open_driver(), but better safe
than sorry.

But what would you think about avoiding the code duplication and just
moving the bdrv_unref_child() call from bdrv_open_inherit() down to
bdrv_open_driver(), so that bdrv_new_open_driver() is automatically
covered?

And later we can maybe move it into the individual .bdrv_open
implementations where it really belongs (whoever creates something is
responsible for cleaning it up in error cases).

Kevin
