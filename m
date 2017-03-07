Received: from eggs.gnu.org ([2001:4830:134:3::10]:44188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clCer-0002l4-Cj
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clCeq-0000oo-HZ
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:47:57 -0500
Date: Tue, 7 Mar 2017 11:47:48 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170307104748.GG5871@noname.str.redhat.com>
References: <20170306195255.15806-1-mreitz@redhat.com>
	<20170306195407.16415-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170306195407.16415-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/3] block: Add errp to b{lk,
 drv}_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 06.03.2017 um 20:54 hat Max Reitz geschrieben:
> For one thing, this allows us to drop the error message generation from
> qemu-img.c and blockdev.c and instead have it unified in
> bdrv_truncate().
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

>  block/commit.c                 |  5 +++--
>  block/mirror.c                 |  2 +-

These still pass NULL after the series. Fixing it would require to add a
way to complete jobs with an Error object, but maybe we should do this
sooner or later anyway. Not necessarily part of this series, though.

>  block/vhdx.c                   |  6 +++---
>  block/vpc.c                    |  2 +-

vpc can easily be fixed to pass the actual errp from vpc_create() to the
blk_truncate() call. In vhdx.c, the blk_truncate() call is a bit more
deeply nested, but it doesn't seem completely unreasonable there either.

> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -1569,7 +1569,7 @@ static int truncate_f(BlockBackend *blk, int argc, char **argv)
>          return 0;
>      }
>  
> -    ret = blk_truncate(blk, offset);
> +    ret = blk_truncate(blk, offset, NULL);
>      if (ret < 0) {
>          printf("truncate: %s\n", strerror(-ret));
>          return 0;

Come on, using NULL immediately before a printf()? Doing the right thing
here is trivial.

Kevin
