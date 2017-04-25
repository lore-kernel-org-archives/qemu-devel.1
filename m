Received: from eggs.gnu.org ([2001:4830:134:3::10]:44324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d32Cf-0008Sz-Da
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d32CZ-0005Yw-Nl
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:16:33 -0400
Date: Tue, 25 Apr 2017 17:16:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170425151610.GC4615@noname.redhat.com>
References: <20170410150542.30376-1-famz@redhat.com>
	<20170410150542.30376-11-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170410150542.30376-11-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.9 v3 10/10] block: Fix bdrv_co_flush
 early return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 10.04.2017 um 17:05 hat Fam Zheng geschrieben:
> bdrv_inc_in_flight and bdrv_dec_in_flight are mandatory for
> BDRV_POLL_WHILE to work, even for the shortcut case where flush is
> unnecessary. Move the if block to below bdrv_dec_in_flight, and BTW fix
> the variable declaration position.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/io.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 00e45ca..bae6947 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2278,16 +2278,17 @@ static void coroutine_fn bdrv_flush_co_entry(void *opaque)
>  
>  int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
>  {
> -    int ret;
> -
> -    if (!bs || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs) ||
> -        bdrv_is_sg(bs)) {
> -        return 0;
> -    }
> +    int current_gen;
> +    int ret = 0;
>  
>      bdrv_inc_in_flight(bs);

As Coverity points out, we're now using bs...

> -    int current_gen = bs->write_gen;
> +    if (!bs || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs) ||

...before doing the NULL check.

I'm not sure if we even need to have a NULL check here, but we would have
to check all callers to make sure that it's unnecessary. Before commit
29cdb251, it only checked bs->drv and I don't see how that commit
introduced a NULL caller, but maybe one was added later.

In any case, bdrv_co_flush() needs a fix, either remove the NULL check
or do it first.

> +        bdrv_is_sg(bs)) {
> +        goto early_exit;
> +    }

Kevin
