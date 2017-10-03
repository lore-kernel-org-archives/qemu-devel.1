Received: from eggs.gnu.org ([2001:4830:134:3::10]:47839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dzJYw-0004wp-QX
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dzJYt-0002GH-Jr
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:32:26 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:10062 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dzJYt-00028M-2x
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:32:23 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-15-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a61ffd73-f52e-320b-3947-8e7bb7e25b81@virtuozzo.com>
Date: Tue, 3 Oct 2017 12:32:14 +0300
MIME-Version: 1.0
In-Reply-To: <20170913160333.23622-15-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 14/23] qemu-img: Speed up compare on
 pre-allocated larger file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

13.09.2017 19:03, Eric Blake wrote:
> Compare the following images with all-zero contents:
> $ truncate --size 1M A
> $ qemu-img create -f qcow2 -o preallocation=off B 1G
> $ qemu-img create -f qcow2 -o preallocation=metadata C 1G
>
> On my machine, the difference is noticeable for pre-patch speeds,
> with more than an order of magnitude in difference caused by the
> choice of preallocation in the qcow2 file:
>
> $ time ./qemu-img compare -f raw -F qcow2 A B
> Warning: Image size mismatch!
> Images are identical.
>
> real	0m0.014s
> user	0m0.007s
> sys	0m0.007s
>
> $ time ./qemu-img compare -f raw -F qcow2 A C
> Warning: Image size mismatch!
> Images are identical.
>
> real	0m0.341s
> user	0m0.144s
> sys	0m0.188s
>
> Why? Because bdrv_is_allocated() returns false for image B but
> true for image C, throwing away the fact that both images know
> via lseek(SEEK_HOLE) that the entire image still reads as zero.
>  From there, qemu-img ends up calling bdrv_pread() for every byte
> of the tail, instead of quickly looking for the next allocation.
> The solution: use block_status instead of is_allocated, giving:
>
> $ time ./qemu-img compare -f raw -F qcow2 A C
> Warning: Image size mismatch!
> Images are identical.
>
> real	0m0.014s
> user	0m0.011s
> sys	0m0.003s
>
> which is on par with the speeds for no pre-allocation.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v3: new patch
> ---
>   qemu-img.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/qemu-img.c b/qemu-img.c
> index f8423e9b3f..f5ab29d176 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1477,11 +1477,11 @@ static int img_compare(int argc, char **argv)
>           while (sector_num < progress_base) {
>               int64_t count;
>
> -            ret = bdrv_is_allocated_above(blk_bs(blk_over), NULL,
> +            ret = bdrv_block_status_above(blk_bs(blk_over), NULL,
>                                             sector_num * BDRV_SECTOR_SIZE,
>                                             (progress_base - sector_num) *
>                                             BDRV_SECTOR_SIZE,
> -                                          &count);
> +                                          &count, NULL);
>               if (ret < 0) {
>                   ret = 3;
>                   error_report("Sector allocation test failed for %s",
> @@ -1489,11 +1489,11 @@ static int img_compare(int argc, char **argv)
>                   goto out;
>
>               }
> -            /* TODO relax this once bdrv_is_allocated_above does not enforce
> +            /* TODO relax this once bdrv_block_status_above does not enforce
>                * sector alignment */
>               assert(QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
>               nb_sectors = count >> BDRV_SECTOR_BITS;
> -            if (ret) {
> +            if (ret & BDRV_BLOCK_ALLOCATED && !(ret & BDRV_BLOCK_ZERO)) {
>                   nb_sectors = MIN(nb_sectors, IO_BUF_SIZE >> BDRV_SECTOR_BITS);
>                   ret = check_empty_sectors(blk_over, sector_num, nb_sectors,
>                                             filename_over, buf1, quiet);

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir
