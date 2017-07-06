Received: from eggs.gnu.org ([2001:4830:134:3::10]:38029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dT9xF-0004cO-BY
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dT9xE-0004km-5H
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:48:37 -0400
Date: Thu, 6 Jul 2017 18:48:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170706164820.GN5975@noname.redhat.com>
References: <20170705210842.960-1-eblake@redhat.com>
	<20170705210842.960-21-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170705210842.960-21-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 20/21] block: Minimize raw use of
 bds->total_sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 05.07.2017 um 23:08 hat Eric Blake geschrieben:
> bdrv_is_allocated_above() was relying on intermediate->total_sectors,
> which is a field that can have stale contents depending on the value
> of intermediate->has_variable_length.  An audit shows that we are safe
> (we were first calling through bdrv_co_get_block_status() which in
> turn calls bdrv_nb_sectors() and therefore just refreshed the current
> length), but it's nicer to favor our accessor functions to avoid having
> to repeat such an audit, even if it means refresh_total_sectors() is
> called more frequently.
> 
> Suggested-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> Reviewed-by: Jeff Cody <jcody@redhat.com>
> 
> ---
> v3-v4: no change
> v2: new patch
> ---
>  block/io.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index cb40069..fb8d1c7 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1952,6 +1952,7 @@ int bdrv_is_allocated_above(BlockDriverState *top,
>      intermediate = top;
>      while (intermediate && intermediate != base) {
>          int64_t pnum_inter;
> +        int64_t size_inter;
>          int psectors_inter;
> 
>          ret = bdrv_is_allocated(intermediate, sector_num * BDRV_SECTOR_SIZE,
> @@ -1969,13 +1970,14 @@ int bdrv_is_allocated_above(BlockDriverState *top,
> 
>          /*
>           * [sector_num, nb_sectors] is unallocated on top but intermediate
> -         * might have
> -         *
> -         * [sector_num+x, nr_sectors] allocated.
> +         * might have [sector_num+x, nb_sectors-x] allocated.
>           */

I tried to figure out what this comment wants to tell us, and neither
the original version nor your changed one seemed to make a lot of sense
to me. The only case that I can see that actually needs the following
block is a case like this:

    (. = unallocated, # = allocated)

    top             ....####
    intermediate    ........

Our initial request was for 8 sectors, but when going to the
intermediate node, we need to reduce this to 4 sectors, otherwise we
would return unallocated for sectors 5 to 8 even though they are
allocated in top.

That's kind of the opposite of what the comment says, though...

> +        size_inter = bdrv_nb_sectors(intermediate);
> +        if (size_inter < 0) {
> +            return size_inter;
> +        }
>          if (n > psectors_inter &&
> -            (intermediate == top ||
> -             sector_num + psectors_inter < intermediate->total_sectors)) {
> +            (intermediate == top || sector_num + psectors_inter < size_inter)) {
>              n = psectors_inter;
>          }

The actual code change looks good.

Kevin
