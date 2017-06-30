Received: from eggs.gnu.org ([2001:4830:134:3::10]:53735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dR3YX-0005Gm-Fu
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 17:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dR3YW-0005ie-Kk
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 17:34:25 -0400
Date: Fri, 30 Jun 2017 17:34:13 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170630213413.GB26034@localhost.localdomain>
References: <20170627192458.15519-1-eblake@redhat.com>
	<20170627192458.15519-20-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170627192458.15519-20-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 19/20] block: Minimize raw
 use of bds->total_sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Jun 27, 2017 at 02:24:57PM -0500, Eric Blake wrote:
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
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
> v2: new patch
> ---
>  block/io.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 0545180..5bbf153 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1924,6 +1924,7 @@ int bdrv_is_allocated_above(BlockDriverState *top,
>      intermediate = top;
>      while (intermediate && intermediate != base) {
>          int64_t pnum_inter;
> +        int64_t size_inter;
>          int psectors_inter;
> 
>          ret = bdrv_is_allocated(intermediate, sector_num * BDRV_SECTOR_SIZE,
> @@ -1941,13 +1942,14 @@ int bdrv_is_allocated_above(BlockDriverState *top,
> 
>          /*
>           * [sector_num, nb_sectors] is unallocated on top but intermediate
> -         * might have
> -         *
> -         * [sector_num+x, nr_sectors] allocated.
> +         * might have [sector_num+x, nb_sectors-x] allocated.
>           */
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
> 
> -- 
> 2.9.4
> 
> 
