Received: from eggs.gnu.org ([2001:4830:134:3::10]:33625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cr75Z-0002FZ-U2
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cr75Z-0003ZL-1E
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:03:57 -0400
Date: Thu, 23 Mar 2017 19:03:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170323180346.GE5344@noname.redhat.com>
References: <20170308191434.2413-1-mreitz@redhat.com>
	<20170308191544.3025-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170308191544.3025-2-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 4/4] block: Add some
 bdrv_truncate() error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Am 08.03.2017 um 20:15 hat Max Reitz geschrieben:
> Add missing error messages for the drivers I am comfortable to do this
> in.
> 
> Since one of these changes touches a mis-indented block in
> block/file-posix.c, this patch fixes that coding style issue along the
> way.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 17585fbb89..53b0bd61a7 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2550,6 +2550,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
>      new_l1_size = size_to_l1(s, offset);
>      ret = qcow2_grow_l1_table(bs, new_l1_size, true);
>      if (ret < 0) {
> +        error_setg(errp, "Failed to grow the L1 table");

Let's not throw away error codes, error_setg_errno() is your friend.

>          return ret;
>      }
>  
> @@ -2558,6 +2559,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
>      ret = bdrv_pwrite_sync(bs->file, offsetof(QCowHeader, size),
>                             &offset, sizeof(uint64_t));
>      if (ret < 0) {
> +        error_setg(errp, "Failed to update the image size");

Here, too.

>          return ret;
>      }
>  
> diff --git a/block/qed.c b/block/qed.c
> index fa2aeee471..eb346d645b 100644
> --- a/block/qed.c
> +++ b/block/qed.c
> @@ -1526,11 +1526,12 @@ static int bdrv_qed_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
>  
>      if (!qed_is_image_size_valid(offset, s->header.cluster_size,
>                                   s->header.table_size)) {
> +        error_setg(errp, "Invalid image size specified");
>          return -EINVAL;
>      }
>  
> -    /* Shrinking is currently not supported */
>      if ((uint64_t)offset < s->header.image_size) {
> +        error_setg(errp, "Shrinking images is currently not supported");
>          return -ENOTSUP;
>      }
>  
> @@ -1539,6 +1540,7 @@ static int bdrv_qed_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
>      ret = qed_write_header_sync(s);
>      if (ret < 0) {
>          s->header.image_size = old_image_size;
> +        error_setg(errp, "Failed to update the image size");

As well as here.

>      }
>      return ret;
>  }

Kevin
