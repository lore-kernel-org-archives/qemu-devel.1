Received: from eggs.gnu.org ([2001:4830:134:3::10]:58449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dqJ84-0000BK-Hk
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dqJ83-0001xU-P4
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:15:28 -0400
Date: Fri, 8 Sep 2017 15:15:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170908131518.GI3283@localhost.localdomain>
References: <20170830210542.2153-1-eblake@redhat.com>
	<20170830210542.2153-15-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830210542.2153-15-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 14/18] qcow2: Switch qcow2_measure() to
 byte-based iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 30.08.2017 um 23:05 hat Eric Blake geschrieben:
> This is new code, but it is easier to read if it makes passes over
> the image using bytes rather than sectors (and will get easier in
> the future when bdrv_get_block_status is converted to byte-based).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> 
> ---
> v6: separate bug fix to earlier patch
> v5: new patch
> ---
>  block/qcow2.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 40ba26c111..57e3c5e7d5 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3666,20 +3666,19 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
>               */
>              required = virtual_size;
>          } else {
> -            int cluster_sectors = cluster_size / BDRV_SECTOR_SIZE;
> -            int64_t sector_num;
> +            int64_t offset;
>              int pnum = 0;
> 
> -            for (sector_num = 0;
> -                 sector_num < ssize / BDRV_SECTOR_SIZE;
> -                 sector_num += pnum) {
> -                int nb_sectors = MIN(ssize / BDRV_SECTOR_SIZE - sector_num,
> -                                     BDRV_REQUEST_MAX_SECTORS);
> +            for (offset = 0; offset < ssize;
> +                 offset += pnum * BDRV_SECTOR_SIZE) {
> +                int nb_sectors = MIN(ssize - offset,
> +                                     INT_MAX) / BDRV_SECTOR_SIZE;

Shouldn't this be BDRV_REQUEST_MAX_BYTES? (Which is close to INT_MAX,
but rounded down to sector alignment.)

Kevin
