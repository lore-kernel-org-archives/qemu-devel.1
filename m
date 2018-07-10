Received: from eggs.gnu.org ([2001:4830:134:3::10]:59457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcrl4-0001v5-3v
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcrl3-00058G-16
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:28:42 -0400
Date: Tue, 10 Jul 2018 14:28:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180710122832.GF5852@localhost.localdomain>
References: <1530963723-14380-1-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530963723-14380-1-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH V4] qemu-img: align result of
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

Am 07.07.2018 um 13:42 hat Peter Lieven geschrieben:
> We currently don't enforce that the sparse segments we detect during convert are
> aligned. This leads to unnecessary and costly read-modify-write cycles either
> internally in Qemu or in the background on the storage device as nearly all
> modern filesystems or hardware have a 4k alignment internally.
> 
> This patch modifies is_allocated_sectors so that its *pnum result will always
> end at an alignment boundary. This way all requests will end at an alignment
> boundary. The start of all requests will also be aligned as long as the results
> of get_block_status do not lead to an unaligned offset.
> 
> The number of RMW cycles when converting an example image [1] to a raw device that
> has 4k sector size is about 4600 4k read requests to perform a total of about 15000
> write requests. With this path the additional 4600 read requests are eliminated while
> the number of total write requests stays constant.
> 
> [1] https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-amd64-disk1.vmdk
> 
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
> V3->V4: - only focus on the end offset in is_allocated_sectors [Kevin]
> V2->V3: - ensure that s.alignment is a power of 2
>         - correctly handle n < alignment in is_allocated_sectors if
>           sector_num % alignment > 0.
> V1->V2: - take the current sector offset into account [Max]
>         - try to figure out the target alignment [Max]
> 
>  qemu-img.c | 44 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index e1a506f..20e3236 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1105,11 +1105,15 @@ static int64_t find_nonzero(const uint8_t *buf, int64_t n)
>   *
>   * 'pnum' is set to the number of sectors (including and immediately following
>   * the first one) that are known to be in the same allocated/unallocated state.
> + * The function will try to align the end offset to alignment boundaries so
> + * that the request will at least end aligned and consequtive requests will
> + * also start at an aligned offset.
>   */
> -static int is_allocated_sectors(const uint8_t *buf, int n, int *pnum)
> +static int is_allocated_sectors(const uint8_t *buf, int n, int *pnum,
> +                                int64_t sector_num, int alignment)
>  {
>      bool is_zero;
> -    int i;
> +    int i, tail;
>  
>      if (n <= 0) {
>          *pnum = 0;
> @@ -1122,6 +1126,23 @@ static int is_allocated_sectors(const uint8_t *buf, int n, int *pnum)
>              break;
>          }
>      }
> +
> +    tail = (sector_num + i) & (alignment - 1);
> +    if (tail) {
> +        if (is_zero && i == tail) {

Should this be i <= tail for the case where sector_num is unaligned?

For example:

    Bytes 0     - 1024:     zero
    Bytes 1024  - 4096:     non-zero

    /* Check from 512 to 4096, alignment 2048 */
    is_allocated_sectors(buf, 7, &pnum, 1, 4)

    -> is_zero = true
    -> i = 1
    -> tail = (sector_num + i) & (alignment - 1)
            = (1 + 1) & (4 - 1)
            = 2
            != i

> +            /* treat unallocated areas which only consist
> +             * of a small tail as allocated. */
> +            is_zero = 0;

(This should be false rather than 0, is_zero is a bool)

> +        }
> +        if (!is_zero) {
> +            /* align up end offset of allocated areas. */
> +            i += alignment - tail;
> +            i = MIN(i, n);
> +        } else {
> +            /* align down end offset of zero areas. */
> +            i -= tail;

So our example above will end up in this branch and we get:

    i = i - tail
      = 1 - 2
      = -1

I'm not sure what callers will do with a negative *pnum, but I expect it
won't be anything good.

Kevin
