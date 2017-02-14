Received: from eggs.gnu.org ([2001:4830:134:3::10]:48362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdX48-00063O-Qg
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 01:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdX47-00047J-UM
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 01:58:20 -0500
Date: Tue, 14 Feb 2017 14:58:11 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170214065811.GD6428@lemon.lan>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-17-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487006583-24350-17-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 16/41] block: Add error parameter to
 blk_insert_bs()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

On Mon, 02/13 18:22, Kevin Wolf wrote:
> Mow that blk_insert_bs() requests the BlockBackend permissions for the

Now? :)

> node it attaches to, it can fail. Instead of aborting, pass the errors
> to the callers.
> 

[snip]

> @@ -332,11 +348,17 @@ int bdrv_commit(BlockDriverState *bs)
>  
>      /* FIXME Use real permissions */
>      src = blk_new(0, BLK_PERM_ALL);
> -    blk_insert_bs(src, bs);
> -
> -    /* FIXME Use real permissions */
>      backing = blk_new(0, BLK_PERM_ALL);
> -    blk_insert_bs(backing, bs->backing->bs);
> +
> +    ret = blk_insert_bs(src, bs, NULL);
> +    if (ret < 0) {
> +        goto ro_cleanup;
> +    }
> +
> +    ret = blk_insert_bs(backing, bs->backing->bs, NULL);

Some code in this function uses local_err + error_report_err while this and some
others use NULL as errp. It's better to consistently use local_err, something
for another day.

> +    if (ret < 0) {
> +        goto ro_cleanup;
> +    }
>  
>      length = blk_getlength(src);
>      if (length < 0) {
