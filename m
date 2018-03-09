Received: from eggs.gnu.org ([2001:4830:134:3::10]:38741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1euJUC-0004nO-8H
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:59:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1euJUB-0003of-Cx
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:59:08 -0500
Date: Fri, 9 Mar 2018 14:58:47 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180309145847.GB13990@work-vm>
References: <1520507908-16743-1-git-send-email-pl@kamp.de>
	<1520507908-16743-4-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520507908-16743-4-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH 3/5] migration/block: rename
 MAX_INFLIGHT_IO to MAX_IO_BUFFERS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, quintela@redhat.com, famz@redhat.com, stefanha@redhat.com, jjherne@linux.vnet.ibm.com

* Peter Lieven (pl@kamp.de) wrote:
> this actually limits (as the original commit mesage suggests) the
> number of I/O buffers that can be allocated and not the number
> of parallel (inflight) I/O requests.
> 
> Signed-off-by: Peter Lieven <pl@kamp.de>

I've queued 1-3 (which have Juan's R-b).

Dave

> ---
>  migration/block.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/block.c b/migration/block.c
> index 87bb35c..41b95d1 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -36,7 +36,7 @@
>  
>  #define MAX_IS_ALLOCATED_SEARCH (65536 * BDRV_SECTOR_SIZE)
>  
> -#define MAX_INFLIGHT_IO 512
> +#define MAX_IO_BUFFERS 512
>  
>  //#define DEBUG_BLK_MIGRATION
>  
> @@ -775,9 +775,8 @@ static int block_save_iterate(QEMUFile *f, void *opaque)
>      while ((block_mig_state.submitted +
>              block_mig_state.read_done) * BLOCK_SIZE <
>             qemu_file_get_rate_limit(f) &&
> -           (block_mig_state.submitted +
> -            block_mig_state.read_done) <
> -           MAX_INFLIGHT_IO) {
> +           (block_mig_state.submitted + block_mig_state.read_done) <
> +           MAX_IO_BUFFERS) {
>          blk_mig_unlock();
>          if (block_mig_state.bulk_completed == 0) {
>              /* first finish the bulk phase */
> -- 
> 2.7.4
> 
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
