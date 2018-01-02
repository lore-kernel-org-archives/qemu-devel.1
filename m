Received: from eggs.gnu.org ([2001:4830:134:3::10]:49105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eWULI-0007er-86
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eWULH-0005dF-05
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:43:28 -0500
Date: Tue, 2 Jan 2018 16:43:16 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180102214316.GC26116@localhost.localdomain>
References: <20171207203036.14993-1-eblake@redhat.com>
	<20171207203036.14993-7-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171207203036.14993-7-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v6 06/20] iscsi: Switch
 iscsi_allocmap_update() to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com, famz@redhat.com, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Dec 07, 2017 at 02:30:22PM -0600, Eric Blake wrote:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Convert all uses of
> the allocmap (no semantic change).  Callers that already had bytes
> available are simpler, and callers that now scale to bytes will be
> easier to switch to byte-based in the future.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> ---
> v3-v5: no change
> v2: rebase to count/bytes rename

Looks like this one will need a rebase, I get conflicts on master (and when
trying to naively rebase your repo's master on qemu master).

> ---
>  block/iscsi.c | 90 +++++++++++++++++++++++++++++------------------------------
>  1 file changed, 44 insertions(+), 46 deletions(-)
> 
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 8f903d8370..4896d50d6e 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -455,24 +455,22 @@ static int iscsi_allocmap_init(IscsiLun *iscsilun, int open_flags)
>  }
> 
>  static void
> -iscsi_allocmap_update(IscsiLun *iscsilun, int64_t sector_num,
> -                      int nb_sectors, bool allocated, bool valid)
> +iscsi_allocmap_update(IscsiLun *iscsilun, int64_t offset,
> +                      int64_t bytes, bool allocated, bool valid)
>  {
>      int64_t cl_num_expanded, nb_cls_expanded, cl_num_shrunk, nb_cls_shrunk;
> -    int cluster_sectors = iscsilun->cluster_size >> BDRV_SECTOR_BITS;
> 
>      if (iscsilun->allocmap == NULL) {
>          return;
>      }
>      /* expand to entirely contain all affected clusters */
> -    assert(cluster_sectors);
> -    cl_num_expanded = sector_num / cluster_sectors;
> -    nb_cls_expanded = DIV_ROUND_UP(sector_num + nb_sectors,
> -                                   cluster_sectors) - cl_num_expanded;
> +    assert(iscsilun->cluster_size);
> +    cl_num_expanded = offset / iscsilun->cluster_size;
> +    nb_cls_expanded = DIV_ROUND_UP(offset + bytes, iscsilun->cluster_size)
> +        - cl_num_expanded;
>      /* shrink to touch only completely contained clusters */
> -    cl_num_shrunk = DIV_ROUND_UP(sector_num, cluster_sectors);
> -    nb_cls_shrunk = (sector_num + nb_sectors) / cluster_sectors
> -                      - cl_num_shrunk;
> +    cl_num_shrunk = DIV_ROUND_UP(offset, iscsilun->cluster_size);
> +    nb_cls_shrunk = (offset + bytes) / iscsilun->cluster_size - cl_num_shrunk;
>      if (allocated) {
>          bitmap_set(iscsilun->allocmap, cl_num_expanded, nb_cls_expanded);
>      } else {
> @@ -495,26 +493,26 @@ iscsi_allocmap_update(IscsiLun *iscsilun, int64_t sector_num,
>  }
> 
>  static void
> -iscsi_allocmap_set_allocated(IscsiLun *iscsilun, int64_t sector_num,
> -                             int nb_sectors)
> +iscsi_allocmap_set_allocated(IscsiLun *iscsilun, int64_t offset,
> +                             int64_t bytes)
>  {
> -    iscsi_allocmap_update(iscsilun, sector_num, nb_sectors, true, true);
> +    iscsi_allocmap_update(iscsilun, offset, bytes, true, true);
>  }
> 
>  static void
> -iscsi_allocmap_set_unallocated(IscsiLun *iscsilun, int64_t sector_num,
> -                               int nb_sectors)
> +iscsi_allocmap_set_unallocated(IscsiLun *iscsilun, int64_t offset,
> +                               int64_t bytes)
>  {
>      /* Note: if cache.direct=on the fifth argument to iscsi_allocmap_update
>       * is ignored, so this will in effect be an iscsi_allocmap_set_invalid.
>       */
> -    iscsi_allocmap_update(iscsilun, sector_num, nb_sectors, false, true);
> +    iscsi_allocmap_update(iscsilun, offset, bytes, false, true);
>  }
> 
> -static void iscsi_allocmap_set_invalid(IscsiLun *iscsilun, int64_t sector_num,
> -                                       int nb_sectors)
> +static void iscsi_allocmap_set_invalid(IscsiLun *iscsilun, int64_t offset,
> +                                       int64_t bytes)
>  {
> -    iscsi_allocmap_update(iscsilun, sector_num, nb_sectors, false, false);
> +    iscsi_allocmap_update(iscsilun, offset, bytes, false, false);
>  }
> 
>  static void iscsi_allocmap_invalidate(IscsiLun *iscsilun)
> @@ -528,34 +526,30 @@ static void iscsi_allocmap_invalidate(IscsiLun *iscsilun)
>  }
> 
>  static inline bool
> -iscsi_allocmap_is_allocated(IscsiLun *iscsilun, int64_t sector_num,
> -                            int nb_sectors)
> +iscsi_allocmap_is_allocated(IscsiLun *iscsilun, int64_t offset,
> +                            int64_t bytes)
>  {
>      unsigned long size;
>      if (iscsilun->allocmap == NULL) {
>          return true;
>      }
>      assert(iscsilun->cluster_size);
> -    size = DIV_ROUND_UP(sector_num + nb_sectors,
> -                        iscsilun->cluster_size >> BDRV_SECTOR_BITS);
> +    size = DIV_ROUND_UP(offset + bytes, iscsilun->cluster_size);
>      return !(find_next_bit(iscsilun->allocmap, size,
> -                           sector_num * BDRV_SECTOR_SIZE /
> -                           iscsilun->cluster_size) == size);
> +                           offset / iscsilun->cluster_size) == size);
>  }
> 
>  static inline bool iscsi_allocmap_is_valid(IscsiLun *iscsilun,
> -                                           int64_t sector_num, int nb_sectors)
> +                                           int64_t offset, int64_t bytes)
>  {
>      unsigned long size;
>      if (iscsilun->allocmap_valid == NULL) {
>          return false;
>      }
>      assert(iscsilun->cluster_size);
> -    size = DIV_ROUND_UP(sector_num + nb_sectors,
> -                        iscsilun->cluster_size >> BDRV_SECTOR_BITS);
> +    size = DIV_ROUND_UP(offset + bytes, iscsilun->cluster_size);
>      return (find_next_zero_bit(iscsilun->allocmap_valid, size,
> -                               sector_num * BDRV_SECTOR_SIZE /
> -                               iscsilun->cluster_size) == size);
> +                               offset / iscsilun->cluster_size) == size);
>  }
> 
>  static int coroutine_fn
> @@ -637,12 +631,14 @@ retry:
>      }
> 
>      if (iTask.status != SCSI_STATUS_GOOD) {
> -        iscsi_allocmap_set_invalid(iscsilun, sector_num, nb_sectors);
> +        iscsi_allocmap_set_invalid(iscsilun, sector_num * BDRV_SECTOR_SIZE,
> +                                   nb_sectors * BDRV_SECTOR_SIZE);
>          r = iTask.err_code;
>          goto out_unlock;
>      }
> 
> -    iscsi_allocmap_set_allocated(iscsilun, sector_num, nb_sectors);
> +    iscsi_allocmap_set_allocated(iscsilun, sector_num * BDRV_SECTOR_SIZE,
> +                                 nb_sectors * BDRV_SECTOR_SIZE);
> 
>  out_unlock:
>      qemu_mutex_unlock(&iscsilun->mutex);
> @@ -737,9 +733,11 @@ retry:
>      }
> 
>      if (ret & BDRV_BLOCK_ZERO) {
> -        iscsi_allocmap_set_unallocated(iscsilun, sector_num, *pnum);
> +        iscsi_allocmap_set_unallocated(iscsilun, sector_num * BDRV_SECTOR_SIZE,
> +                                       *pnum * BDRV_SECTOR_SIZE);
>      } else {
> -        iscsi_allocmap_set_allocated(iscsilun, sector_num, *pnum);
> +        iscsi_allocmap_set_allocated(iscsilun, sector_num * BDRV_SECTOR_SIZE,
> +                                     *pnum * BDRV_SECTOR_SIZE);
>      }
> 
>      if (*pnum > nb_sectors) {
> @@ -777,15 +775,19 @@ static int coroutine_fn iscsi_co_readv(BlockDriverState *bs,
>      /* if cache.direct is off and we have a valid entry in our allocation map
>       * we can skip checking the block status and directly return zeroes if
>       * the request falls within an unallocated area */
> -    if (iscsi_allocmap_is_valid(iscsilun, sector_num, nb_sectors) &&
> -        !iscsi_allocmap_is_allocated(iscsilun, sector_num, nb_sectors)) {
> +    if (iscsi_allocmap_is_valid(iscsilun, sector_num * BDRV_SECTOR_SIZE,
> +                                nb_sectors * BDRV_SECTOR_SIZE) &&
> +        !iscsi_allocmap_is_allocated(iscsilun, sector_num * BDRV_SECTOR_SIZE,
> +                                     nb_sectors * BDRV_SECTOR_SIZE)) {
>              qemu_iovec_memset(iov, 0, 0x00, iov->size);
>              return 0;
>      }
> 
>      if (nb_sectors >= ISCSI_CHECKALLOC_THRES &&
> -        !iscsi_allocmap_is_valid(iscsilun, sector_num, nb_sectors) &&
> -        !iscsi_allocmap_is_allocated(iscsilun, sector_num, nb_sectors)) {
> +        !iscsi_allocmap_is_valid(iscsilun, sector_num * BDRV_SECTOR_SIZE,
> +                                 nb_sectors * BDRV_SECTOR_SIZE) &&
> +        !iscsi_allocmap_is_allocated(iscsilun, sector_num * BDRV_SECTOR_SIZE,
> +                                     nb_sectors * BDRV_SECTOR_SIZE)) {
>          int pnum;
>          BlockDriverState *file;
>          /* check the block status from the beginning of the cluster
> @@ -1154,8 +1156,7 @@ retry:
>          goto out_unlock;
>      }
> 
> -    iscsi_allocmap_set_invalid(iscsilun, offset >> BDRV_SECTOR_BITS,
> -                               bytes >> BDRV_SECTOR_BITS);
> +    iscsi_allocmap_set_invalid(iscsilun, offset, bytes);
> 
>  out_unlock:
>      qemu_mutex_unlock(&iscsilun->mutex);
> @@ -1253,18 +1254,15 @@ retry:
>      }
> 
>      if (iTask.status != SCSI_STATUS_GOOD) {
> -        iscsi_allocmap_set_invalid(iscsilun, offset >> BDRV_SECTOR_BITS,
> -                                   bytes >> BDRV_SECTOR_BITS);
> +        iscsi_allocmap_set_invalid(iscsilun, offset, bytes);
>          r = iTask.err_code;
>          goto out_unlock;
>      }
> 
>      if (flags & BDRV_REQ_MAY_UNMAP) {
> -        iscsi_allocmap_set_invalid(iscsilun, offset >> BDRV_SECTOR_BITS,
> -                                   bytes >> BDRV_SECTOR_BITS);
> +        iscsi_allocmap_set_invalid(iscsilun, offset, bytes);
>      } else {
> -        iscsi_allocmap_set_allocated(iscsilun, offset >> BDRV_SECTOR_BITS,
> -                                     bytes >> BDRV_SECTOR_BITS);
> +        iscsi_allocmap_set_allocated(iscsilun, offset, bytes);
>      }
> 
>  out_unlock:
> -- 
> 2.14.3
> 
> 
