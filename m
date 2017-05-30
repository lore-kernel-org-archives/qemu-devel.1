Received: from eggs.gnu.org ([2001:4830:134:3::10]:44799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dFj8r-0002xg-5j
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dFj8q-0005Lm-Bd
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:33:05 -0400
Date: Tue, 30 May 2017 11:32:56 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170530153256.GC2665@localhost.localdomain>
References: <1496157773-10779-1-git-send-email-kwolf@redhat.com>
	<1496157773-10779-4-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496157773-10779-4-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 3/4] migration/block: Clean
 up BBs in block_save_complete()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

On Tue, May 30, 2017 at 05:22:52PM +0200, Kevin Wolf wrote:
> We need to release any block migrations BlockBackends on the source
> before successfully completing the migration because otherwise
> inactivating the images will fail (inactivation only tolerates device
> BBs).
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  migration/block.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/block.c b/migration/block.c
> index 13f90d3..deb4b0e 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -673,16 +673,14 @@ static int64_t get_remaining_dirty(void)
>      return dirty << BDRV_SECTOR_BITS;
>  }
>  
> -/* Called with iothread lock taken.  */
>  
> -static void block_migration_cleanup(void *opaque)
> +
> +/* Called with iothread lock taken.  */
> +static void block_migration_cleanup_bmds(void)
>  {
>      BlkMigDevState *bmds;
> -    BlkMigBlock *blk;
>      AioContext *ctx;
>  
> -    bdrv_drain_all();
> -
>      unset_dirty_tracking();
>  
>      while ((bmds = QSIMPLEQ_FIRST(&block_mig_state.bmds_list)) != NULL) {
> @@ -700,6 +698,16 @@ static void block_migration_cleanup(void *opaque)
>          g_free(bmds->aio_bitmap);
>          g_free(bmds);
>      }
> +}
> +
> +/* Called with iothread lock taken.  */
> +static void block_migration_cleanup(void *opaque)
> +{
> +    BlkMigBlock *blk;
> +
> +    bdrv_drain_all();
> +
> +    block_migration_cleanup_bmds();
>  
>      blk_mig_lock();
>      while ((blk = QSIMPLEQ_FIRST(&block_mig_state.blk_list)) != NULL) {
> @@ -843,6 +851,10 @@ static int block_save_complete(QEMUFile *f, void *opaque)
>  
>      qemu_put_be64(f, BLK_MIG_FLAG_EOS);
>  
> +    /* Make sure that our BlockBackends are gone, so that the block driver
> +     * nodes can be inactivated. */
> +    block_migration_cleanup_bmds();
> +
>      return 0;
>  }
>  
> -- 
> 1.8.3.1
> 
>

Reviewed-by: Jeff Cody <jcody@redhat.com>
