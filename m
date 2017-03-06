Received: from eggs.gnu.org ([2001:4830:134:3::10]:58937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ckvYd-0001av-5H
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ckvYc-0004i2-5z
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:32:23 -0500
Date: Mon, 6 Mar 2017 17:32:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170306163212.GE5750@noname.redhat.com>
References: <20170303133816.30303-1-famz@redhat.com>
	<20170303133816.30303-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170303133816.30303-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] block: Don't use error_abort in
 blk_new_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 03.03.2017 um 14:38 hat Fam Zheng geschrieben:
> We have an errp and bdrv_root_attach_child can fail permission check,
> error_abort is not the best choice here.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/block-backend.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index daa7908..4eab68f 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -213,7 +213,11 @@ BlockBackend *blk_new_open(const char *filename, const char *reference,
>      }
>  
>      blk->root = bdrv_root_attach_child(bs, "root", &child_root,
> -                                       perm, BLK_PERM_ALL, blk, &error_abort);
> +                                       perm, BLK_PERM_ALL, blk, errp);
> +    if (!blk->root) {
> +        blk_unref(blk);
> +        return NULL;
> +    }

Shouldn't we bdrv_unref(bs), too?

Kevin
