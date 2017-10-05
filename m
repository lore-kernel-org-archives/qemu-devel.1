Received: from eggs.gnu.org ([2001:4830:134:3::10]:40573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e07FI-0001tO-7m
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e07FG-0000W7-WF
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:35:28 -0400
Date: Thu, 5 Oct 2017 10:35:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171005143509.GF10969@stefanha-x1.localdomain>
References: <20171004014347.25099-1-eblake@redhat.com>
	<20171004014347.25099-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004014347.25099-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] block: Uniform handling of 0-length
 bdrv_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue, Oct 03, 2017 at 08:43:44PM -0500, Eric Blake wrote:
> Handle a 0-length block status request up front, with a uniform
> return value claiming the area is not allocated.
> 
> Most callers don't pass a length of 0 to bdrv_get_block_status()
> and friends; but it definitely happens with a 0-length read when
> copy-on-read is enabled.  While we could audit all callers to
> ensure that they never make a 0-length request, and then assert
> that fact, it was just as easy to fix things to always report
> success (as long as the callers are careful to not go into an
> infinite loop).  However, we had inconsistent behavior on whether
> the status is reported as allocated or defers to the backing
> layer, depending on what callbacks the driver implements, and
> possibly wasting quite a few CPU cycles to get to that answer.
> Consistently reporting unallocated up front doesn't really hurt
> anything, and makes it easier both for callers (0-length requests
> now have well-defined behavior) and for drivers (drivers don't
> have to deal with 0-length requests).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v2: new patch
> ---
>  block/io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index e0f904583f..1f5baac41d 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1773,9 +1773,9 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
>          return total_sectors;
>      }
> 
> -    if (sector_num >= total_sectors) {
> +    if (sector_num >= total_sectors || !nb_sectors) {
>          *pnum = 0;
> -        return BDRV_BLOCK_EOF;
> +        return sector_num >= total_sectors ? BDRV_BLOCK_EOF : 0;
>      }

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

If you respin, please consider using a separate if statement to make the
code clearer:

  if (!nb_sectors) {
      *pnum = 0;
      return 0;
  }
  if (sector_num >= total_sectors) {
      *pnum = 0;
      return BDRV_BLOCK_EOF;
  }
