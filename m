Received: from eggs.gnu.org ([2001:4830:134:3::10]:46619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSihr-0000uy-L0
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSihq-0003oO-LK
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:42:55 -0400
Date: Wed, 5 Jul 2017 13:42:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170705114244.GA5297@noname.redhat.com>
References: <20170627192458.15519-1-eblake@redhat.com>
	<20170627192458.15519-8-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170627192458.15519-8-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/20] mirror: Switch MirrorBlockJob to
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 27.06.2017 um 21:24 hat Eric Blake geschrieben:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Continue by converting an
> internal structure (no semantic change), and all references to the
> buffer size.
> 
> [checkpatch has a false positive on use of MIN() in this patch]
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>

I wouldn't mind an assertion that granularity is a multiple of
BDRV_SECTOR_SIZE, along with a comment that explains that this is
required so that we avoid rounding problems when dealing with the bitmap
functions.

blockdev_mirror_common() does already check this, but it feels like it's
a bit far away from where the actual problem would happen in the mirror
job code.

> @@ -768,17 +765,17 @@ static void coroutine_fn mirror_run(void *opaque)
>       * the destination do COW.  Instead, we copy sectors around the
>       * dirty data if needed.  We need a bitmap to do that.
>       */
> +    s->target_cluster_size = BDRV_SECTOR_SIZE;
>      bdrv_get_backing_filename(target_bs, backing_filename,
>                                sizeof(backing_filename));
>      if (!bdrv_get_info(target_bs, &bdi) && bdi.cluster_size) {
> -        target_cluster_size = bdi.cluster_size;
> +        s->target_cluster_size = bdi.cluster_size;
>      }

Why have the unrelated bdrv_get_backing_filename() between the two
assignments of s->target_cluster_size? Or actually, wouldn't it be
even easier to read with an else branch?

    if (!bdrv_get_info(target_bs, &bdi) && bdi.cluster_size) {
        s->target_cluster_size = bdi.cluster_size;
    } else {
        s->target_cluster_size = BDRV_SECTOR_SIZE;
    }

None of these comments are critical, so anyway:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
