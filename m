Received: from eggs.gnu.org ([2001:4830:134:3::10]:36811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUVYB-0000wt-Nm
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:32:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUVYA-0004Cm-9h
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:32:03 -0500
Date: Fri, 20 Jan 2017 17:31:51 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170120093151.GD29561@lemon>
References: <20170119205134.50112-1-farman@linux.vnet.ibm.com>
	<20170119205134.50112-4-farman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170119205134.50112-4-farman@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] block: get max_transfer limit for
 char (scsi-generic) devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

On Thu, 01/19 21:51, Eric Farman wrote:
> Commit 6f607174 introduced a routine to get the maximum number
> of bytes for a single I/O transfer for block devices, however
> scsi generic devices are character devices, not block.  Add
> a condition for this, such that scsi generic devices can view
> the same data.
> 
> Some tweaking of data is required, because the block and sg
> ioctls return values in different scales (sectors versus
> bytes).  So adjust hdev_get_max_transfer_length such that it
> always returns a value in bytes.
> 
> Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
> ---
>  block/file-posix.c    | 10 ++++++----
>  include/block/block.h |  1 +
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 2115155..94068ca 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -657,9 +657,11 @@ static int hdev_get_max_transfer_length(BlockDriverState *bs, int fd)
>      int max_sectors = 0;
>      short max_sectors_short = 0;
>      if (bs->sg && ioctl(fd, BLKSECTGET, &max_sectors) == 0) {
> +        /* sg returns a value in bytes */
>          return max_sectors;

The variable name is now misleading, maybe use "bytes" instead?

>      } else if (!bs->sg && ioctl(fd, BLKSECTGET, &max_sectors_short) == 0) {
> -        return max_sectors_short;
> +        /* block returns a value in sectors */
> +        return max_sectors_short << BDRV_SECTOR_BITS;
>      } else {
>          return -errno;
>      }
> @@ -674,10 +676,10 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
>      struct stat st;
>  
>      if (!fstat(s->fd, &st)) {
> -        if (S_ISBLK(st.st_mode)) {
> +        if (S_ISBLK(st.st_mode) || S_ISCHR(st.st_mode)) {
>              int ret = hdev_get_max_transfer_length(bs, s->fd);
> -            if (ret > 0 && ret <= BDRV_REQUEST_MAX_SECTORS) {
> -                bs->bl.max_transfer = pow2floor(ret << BDRV_SECTOR_BITS);
> +            if (ret > 0 && ret <= BDRV_REQUEST_MAX_BYTES) {
> +                bs->bl.max_transfer = pow2floor(ret);
>              }
>          }
>      }
> diff --git a/include/block/block.h b/include/block/block.h
> index 8b0dcda..4e81f20 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -116,6 +116,7 @@ typedef struct HDGeometry {
>  
>  #define BDRV_REQUEST_MAX_SECTORS MIN(SIZE_MAX >> BDRV_SECTOR_BITS, \
>                                       INT_MAX >> BDRV_SECTOR_BITS)
> +#define BDRV_REQUEST_MAX_BYTES (BDRV_REQUEST_MAX_SECTORS << BDRV_SECTOR_BITS)
>  
>  /*
>   * Allocation status flags
> -- 
> 2.8.4
> 
> 
