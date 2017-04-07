Received: from eggs.gnu.org ([2001:4830:134:3::10]:50201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwO11-0005d9-Cx
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 03:09:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwO10-0001ij-DC
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 03:09:03 -0400
Date: Fri, 7 Apr 2017 15:08:41 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170407070552.GE4618@lemon>
References: <1491484536-22776-1-git-send-email-lidongchen@tencent.com>
	<1491484536-22776-3-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491484536-22776-3-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] migration/block: use blk_pwrite_zeroes
 for each zero cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jemmy858585@gmail.com
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, Lidong Chen <lidongchen@tencent.com>

On Thu, 04/06 21:15, jemmy858585@gmail.com wrote:
> From: Lidong Chen <lidongchen@tencent.com>
> 
> BLOCK_SIZE is (1 << 20), qcow2 cluster size is 65536 by default,
> this maybe cause the qcow2 file size is bigger after migration.
> This patch check each cluster, use blk_pwrite_zeroes for each
> zero cluster.
> 
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---
>  migration/block.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/block.c b/migration/block.c
> index 7734ff7..1fce9b9 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -885,6 +885,10 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
>      int64_t total_sectors = 0;
>      int nr_sectors;
>      int ret;
> +    int i;
> +    int cluster_size;
> +    int64_t addr_offset;
> +    uint8_t *buf_offset;
>  
>      do {
>          addr = qemu_get_be64(f);
> @@ -934,8 +938,34 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
>              } else {
>                  buf = g_malloc(BLOCK_SIZE);
>                  qemu_get_buffer(f, buf, BLOCK_SIZE);
> -                ret = blk_pwrite(blk, addr * BDRV_SECTOR_SIZE, buf,
> -                                 nr_sectors * BDRV_SECTOR_SIZE, 0);
> +
> +                cluster_size = bdrv_get_cluster_size(blk_bs(blk));
> +
> +                if (cluster_size > 0) {
> +                    for (i = 0; i < BLOCK_SIZE / cluster_size; i++) {

Should we check that cluster_size < BLOCK_SIZE and (BLOCK_SIZE % cluster_size ==
0)?

Fam

> +                        addr_offset = addr * BDRV_SECTOR_SIZE
> +                                        + i * cluster_size;
> +                        buf_offset = buf + i * cluster_size;
> +
> +                        if (buffer_is_zero(buf_offset, cluster_size)) {
> +                            ret = blk_pwrite_zeroes(blk, addr_offset,
> +                                                    cluster_size,
> +                                                    BDRV_REQ_MAY_UNMAP);
> +                        } else {
> +                            ret = blk_pwrite(blk, addr_offset,
> +                                             buf_offset, cluster_size, 0);
> +                        }
> +
> +                        if (ret < 0) {
> +                            g_free(buf);
> +                            return ret;
> +                        }
> +                    }
> +                } else {
> +                    ret = blk_pwrite(blk, addr * BDRV_SECTOR_SIZE, buf,
> +                                     nr_sectors * BDRV_SECTOR_SIZE, 0);
> +                }
> +
>                  g_free(buf);
>              }
>  
> -- 
> 1.8.3.1
> 
