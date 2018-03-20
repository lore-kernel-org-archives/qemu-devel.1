Received: from eggs.gnu.org ([2001:4830:134:3::10]:60216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eyLbG-0005Hy-2Q
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:03:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eyLbC-00012p-4v
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:03:06 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1520507908-16743-5-git-send-email-pl@kamp.de> (Peter Lieven's
	message of "Thu, 8 Mar 2018 12:18:27 +0100")
References: <1520507908-16743-1-git-send-email-pl@kamp.de>
	<1520507908-16743-5-git-send-email-pl@kamp.de>
Reply-To: quintela@redhat.com
Date: Tue, 20 Mar 2018 19:02:44 +0100
Message-ID: <871sge1v7f.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/5] migration/block: limit the number of
 parallel I/O requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, dgilbert@redhat.com, famz@redhat.com, stefanha@redhat.com, jjherne@linux.vnet.ibm.com

Peter Lieven <pl@kamp.de> wrote:
> the current implementation submits up to 512 I/O requests in parallel
> which is much to high especially for a background task.
> This patch adds a maximum limit of 16 I/O requests that can
> be submitted in parallel to avoid monopolizing the I/O device.
>
> Signed-off-by: Peter Lieven <pl@kamp.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>

PD.  I can't see a trivial way to change things without refactoring the
whole code.

> ---
>  migration/block.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/migration/block.c b/migration/block.c
> index 41b95d1..ce939e2 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -37,6 +37,7 @@
>  #define MAX_IS_ALLOCATED_SEARCH (65536 * BDRV_SECTOR_SIZE)
>  
>  #define MAX_IO_BUFFERS 512
> +#define MAX_PARALLEL_IO 16
>  
>  //#define DEBUG_BLK_MIGRATION
>  
> @@ -775,6 +776,7 @@ static int block_save_iterate(QEMUFile *f, void *opaque)
>      while ((block_mig_state.submitted +
>              block_mig_state.read_done) * BLOCK_SIZE <
>             qemu_file_get_rate_limit(f) &&
> +           block_mig_state.submitted < MAX_PARALLEL_IO &&
>             (block_mig_state.submitted + block_mig_state.read_done) <
>             MAX_IO_BUFFERS) {
>          blk_mig_unlock();
