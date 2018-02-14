Received: from eggs.gnu.org ([2001:4830:134:3::10]:51693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elvd5-00074p-2W
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elvd3-00045r-Lz
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:53:39 -0500
Date: Wed, 14 Feb 2018 12:53:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180214115312.GA4766@localhost.localdomain>
References: <20180213202701.15858-1-eblake@redhat.com>
	<20180213202701.15858-9-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213202701.15858-9-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 08/21] iscsi: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>

Am 13.02.2018 um 21:26 hat Eric Blake geschrieben:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the iscsi driver accordingly.  In this case,
> it is handy to teach iscsi_co_block_status() to handle a NULL map
> and file parameter, even though the block layer passes non-NULL
> values, because we also call the function directly.  For now, there
> are no optimizations done based on the want_zero flag.
> 
> We can also make the simplification of asserting that the block
> layer passed in aligned values.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> 
> ---
> v8: rebase to master
> v7: rebase to master
> v6: no change
> v5: assert rather than check for alignment
> v4: rebase to interface tweaks
> v3: no change
> v2: rebase to mapping parameter
> ---
>  block/iscsi.c | 67 ++++++++++++++++++++++++++++-------------------------------
>  1 file changed, 32 insertions(+), 35 deletions(-)
> 
> diff --git a/block/iscsi.c b/block/iscsi.c
> index d2b0466775c..4842519fdad 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -653,36 +653,36 @@ out_unlock:
> 
> 
> 
> -static int64_t coroutine_fn iscsi_co_get_block_status(BlockDriverState *bs,
> -                                                  int64_t sector_num,
> -                                                  int nb_sectors, int *pnum,
> -                                                  BlockDriverState **file)
> +static int coroutine_fn iscsi_co_block_status(BlockDriverState *bs,
> +                                              bool want_zero, int64_t offset,
> +                                              int64_t bytes, int64_t *pnum,
> +                                              int64_t *map,
> +                                              BlockDriverState **file)
>  {
>      IscsiLun *iscsilun = bs->opaque;
>      struct scsi_get_lba_status *lbas = NULL;
>      struct scsi_lba_status_descriptor *lbasd = NULL;
>      struct IscsiTask iTask;
>      uint64_t lba;
> -    int64_t ret;
> +    int ret;
> 
>      iscsi_co_init_iscsitask(iscsilun, &iTask);
> 
> -    if (!is_sector_request_lun_aligned(sector_num, nb_sectors, iscsilun)) {
> -        ret = -EINVAL;
> -        goto out;
> -    }
> +    assert(QEMU_IS_ALIGNED(offset | bytes, iscsilun->block_size));
> 
>      /* default to all sectors allocated */
> -    ret = BDRV_BLOCK_DATA;
> -    ret |= (sector_num << BDRV_SECTOR_BITS) | BDRV_BLOCK_OFFSET_VALID;
> -    *pnum = nb_sectors;
> +    ret = BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
> +    if (map) {
> +        *map = offset;
> +    }

Can map ever be NULL? You didn't have that check in other drivers.

> +    *pnum = bytes;
> 
>      /* LUN does not support logical block provisioning */
>      if (!iscsilun->lbpme) {
>          goto out;
>      }
> 
> -    lba = sector_qemu2lun(sector_num, iscsilun);
> +    lba = offset / iscsilun->block_size;
> 
>      qemu_mutex_lock(&iscsilun->mutex);
>  retry:
> @@ -727,12 +727,12 @@ retry:
> 
>      lbasd = &lbas->descriptors[0];
> 
> -    if (sector_qemu2lun(sector_num, iscsilun) != lbasd->lba) {
> +    if (lba != lbasd->lba) {
>          ret = -EIO;
>          goto out_unlock;
>      }
> 
> -    *pnum = sector_lun2qemu(lbasd->num_blocks, iscsilun);
> +    *pnum = lbasd->num_blocks * iscsilun->block_size;
> 
>      if (lbasd->provisioning == SCSI_PROVISIONING_TYPE_DEALLOCATED ||
>          lbasd->provisioning == SCSI_PROVISIONING_TYPE_ANCHORED) {
> @@ -743,15 +743,13 @@ retry:
>      }
> 
>      if (ret & BDRV_BLOCK_ZERO) {
> -        iscsi_allocmap_set_unallocated(iscsilun, sector_num * BDRV_SECTOR_SIZE,
> -                                       *pnum * BDRV_SECTOR_SIZE);
> +        iscsi_allocmap_set_unallocated(iscsilun, offset, *pnum);
>      } else {
> -        iscsi_allocmap_set_allocated(iscsilun, sector_num * BDRV_SECTOR_SIZE,
> -                                     *pnum * BDRV_SECTOR_SIZE);
> +        iscsi_allocmap_set_allocated(iscsilun, offset, *pnum);
>      }
> 
> -    if (*pnum > nb_sectors) {
> -        *pnum = nb_sectors;
> +    if (*pnum > bytes) {
> +        *pnum = bytes;
>      }
>  out_unlock:
>      qemu_mutex_unlock(&iscsilun->mutex);
> @@ -760,7 +758,7 @@ out:
>      if (iTask.task != NULL) {
>          scsi_free_scsi_task(iTask.task);
>      }
> -    if (ret > 0 && ret & BDRV_BLOCK_OFFSET_VALID) {
> +    if (ret > 0 && ret & BDRV_BLOCK_OFFSET_VALID && file) {
>          *file = bs;
>      }

Can file ever be NULL?

>      return ret;
> @@ -800,25 +798,24 @@ static int coroutine_fn iscsi_co_readv(BlockDriverState *bs,
>                                   nb_sectors * BDRV_SECTOR_SIZE) &&

No iscsi_co_preadv() yet... :-(

>          !iscsi_allocmap_is_allocated(iscsilun, sector_num * BDRV_SECTOR_SIZE,
>                                       nb_sectors * BDRV_SECTOR_SIZE)) {
> -        int pnum;
> -        BlockDriverState *file;
> +        int64_t pnum;
>          /* check the block status from the beginning of the cluster
>           * containing the start sector */
> -        int cluster_sectors = iscsilun->cluster_size >> BDRV_SECTOR_BITS;
> -        int head;
> -        int64_t ret;
> +        int64_t head;
> +        int ret;
> 
> -        assert(cluster_sectors);
> -        head = sector_num % cluster_sectors;
> -        ret = iscsi_co_get_block_status(bs, sector_num - head,
> -                                        BDRV_REQUEST_MAX_SECTORS, &pnum,
> -                                        &file);
> +        assert(iscsilun->cluster_size);
> +        head = (sector_num * BDRV_SECTOR_SIZE) % iscsilun->cluster_size;
> +        ret = iscsi_co_block_status(bs, false,
> +                                    sector_num * BDRV_SECTOR_SIZE - head,
> +                                    BDRV_REQUEST_MAX_BYTES, &pnum, NULL, NULL);

It doesn't make a difference with your current implementation because it
ignores want_zero, but consistent with your approach that
want_zero=false returns just that everyhting is allocated for drivers
without support for backing files, I think you want want_zero=true here.

>          if (ret < 0) {
>              return ret;
>          }
>          /* if the whole request falls into an unallocated area we can avoid
>           * reading and directly return zeroes instead */
> -        if (ret & BDRV_BLOCK_ZERO && pnum >= nb_sectors + head) {
> +        if (ret & BDRV_BLOCK_ZERO &&
> +            pnum >= nb_sectors * BDRV_SECTOR_SIZE + head) {
>              qemu_iovec_memset(iov, 0, 0x00, iov->size);
>              return 0;
>          }

Kevin
