Received: from eggs.gnu.org ([209.51.188.92]:59121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLPRL-0003M8-Rp
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLPRK-00033y-PU
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:52:43 -0400
Date: Tue, 30 Apr 2019 11:52:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190430095234.GA5607@linux.fritz.box>
References: <cover.1556562150.git.berto@igalia.com>
	<08ed89d9905a7143201743ec8003058a083c7b72.1556562150.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08ed89d9905a7143201743ec8003058a083c7b72.1556562150.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] vvfat: Replace bdrv_{read,
 write}() with bdrv_{pread, pwrite}()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

Am 29.04.2019 um 20:42 hat Alberto Garcia geschrieben:
> There's only a couple of bdrv_read() and bdrv_write() calls left in
> the vvfat code, and they can be trivially replaced with the byte-based
> bdrv_pread() and bdrv_pwrite().
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/vvfat.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 5f66787890..35c7e2761f 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1494,8 +1494,8 @@ static int vvfat_read(BlockDriverState *bs, int64_t sector_num,
>                  DLOG(fprintf(stderr, "sectors %" PRId64 "+%" PRId64
>                               " allocated\n", sector_num,
>                               n >> BDRV_SECTOR_BITS));
> -                if (bdrv_read(s->qcow, sector_num, buf + i * 0x200,
> -                              n >> BDRV_SECTOR_BITS)) {
> +                if (bdrv_pread(s->qcow, sector_num * BDRV_SECTOR_SIZE,
> +                               buf + i * 0x200, n)) {

bdrv_pread() returns a positive number of bytes in the success case, so
this error check is wrong. (No real reason why it couldn't return 0, but
we would have to check and possibly update all callers, so we never did
that.)

>                      return -1;
>                  }
>                  i += (n >> BDRV_SECTOR_BITS) - 1;
> @@ -1983,7 +1983,8 @@ static uint32_t get_cluster_count_for_direntry(BDRVVVFATState* s,
>                          if (res) {
>                              return -1;
>                          }
> -                        res = bdrv_write(s->qcow, offset, s->cluster_buffer, 1);
> +                        res = bdrv_pwrite(s->qcow, offset * BDRV_SECTOR_SIZE,
> +                                          s->cluster_buffer, BDRV_SECTOR_SIZE);
>                          if (res) {

Same here, this needs to be res < 0 now.

>                              return -2;
>                          }
> @@ -3050,7 +3051,8 @@ DLOG(checkpoint());
>       * Use qcow backend. Commit later.
>       */
>  DLOG(fprintf(stderr, "Write to qcow backend: %d + %d\n", (int)sector_num, nb_sectors));
> -    ret = bdrv_write(s->qcow, sector_num, buf, nb_sectors);
> +    ret = bdrv_pwrite(s->qcow, sector_num * BDRV_SECTOR_SIZE, buf,
> +                      nb_sectors * BDRV_SECTOR_SIZE);
>      if (ret < 0) {

This one is already correct.

>          fprintf(stderr, "Error writing to qcow backend\n");
>          return ret;

Kevin
