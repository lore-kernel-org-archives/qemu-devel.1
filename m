Received: from eggs.gnu.org ([2001:4830:134:3::10]:42963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb5yz-0007Fh-IV
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb5yv-0004OP-9Q
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:15:45 -0400
Date: Thu, 5 Jul 2018 17:15:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180705151531.GM3309@localhost.localdomain>
References: <1530787950-25306-1-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530787950-25306-1-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH V3] qemu-img: align result of
 is_allocated_sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 05.07.2018 um 12:52 hat Peter Lieven geschrieben:
> We currently don't enforce that the sparse segments we detect during convert are
> aligned. This leads to unnecessary and costly read-modify-write cycles either
> internally in Qemu or in the background on the storage device as nearly all
> modern filesystems or hardware have a 4k alignment internally.
> 
> The number of RMW cycles when converting an example image [1] to a raw device that
> has 4k sector size is about 4600 4k read requests to perform a total of about 15000
> write requests. With this path the additional 4600 read requests are eliminated.
> 
> [1] https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-amd64-disk1.vmdk
> 
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
> V2->V3: - ensure that s.alignment is a power of 2
>         - correctly handle n < alignment in is_allocated_sectors if
>           sector_num % alignment > 0.
> V1->V2: - take the current sector offset into account [Max]
>         - try to figure out the target alignment [Max]
> 
>  qemu-img.c | 46 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index e1a506f..db91b9e 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1105,8 +1105,11 @@ static int64_t find_nonzero(const uint8_t *buf, int64_t n)
>   *
>   * 'pnum' is set to the number of sectors (including and immediately following
>   * the first one) that are known to be in the same allocated/unallocated state.
> + * The function will try to align 'pnum' to the number of sectors specified
> + * in 'alignment' to avoid unnecassary RMW cycles on modern hardware.
>   */
> -static int is_allocated_sectors(const uint8_t *buf, int n, int *pnum)
> +static int is_allocated_sectors(const uint8_t *buf, int n, int *pnum,
> +                                int64_t sector_num, int alignment)
>  {
>      bool is_zero;
>      int i;
> @@ -1115,14 +1118,26 @@ static int is_allocated_sectors(const uint8_t *buf, int n, int *pnum)
>          *pnum = 0;
>          return 0;
>      }
> -    is_zero = buffer_is_zero(buf, 512);
> -    for(i = 1; i < n; i++) {
> -        buf += 512;
> -        if (is_zero != buffer_is_zero(buf, 512)) {
> +
> +    if (n % alignment) {
> +        alignment = 1;
> +    }

So if n is unaligned, we keep the result unaligned, too. Makes sense,
because otherwise we'd just split the request in two, but still get the
same result.

Worth mentioning in the function comment, though?

> +
> +    if (sector_num % alignment) {
> +        n = ROUND_UP(sector_num, alignment) - sector_num;
> +        alignment = 1;
> +    }

So if the start is unaligned, only check until the next alignment
boundary.

This one isn't obvious to me. Doesn't it result in the same scenario
where a request is needlessly split in two? Wouldn't it be better to
first check the unaligned head and then continue with the rest of n if
that results in an aligned end offset?

Actually, should the order of both checks be reversed, because an
unaligned n with an unaligned sector_num could actually result in an
aligned end offset?

> +    n /= alignment;
> +
> +    is_zero = buffer_is_zero(buf, BDRV_SECTOR_SIZE * alignment);
> +    for (i = 1; i < n; i++) {
> +        buf += BDRV_SECTOR_SIZE * alignment;
> +        if (is_zero != buffer_is_zero(buf, BDRV_SECTOR_SIZE * alignment)) {
>              break;
>          }
>      }
> -    *pnum = i;
> +    *pnum = i * alignment;
>      return !is_zero;
>  }

Kevin
