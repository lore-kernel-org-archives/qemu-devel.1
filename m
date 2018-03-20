Received: from eggs.gnu.org ([2001:4830:134:3::10]:60217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eyLbG-0005I8-32
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eyLbE-00014y-Se
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:03:06 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1520507908-16743-6-git-send-email-pl@kamp.de> (Peter Lieven's
	message of "Thu, 8 Mar 2018 12:18:28 +0100")
References: <1520507908-16743-1-git-send-email-pl@kamp.de>
	<1520507908-16743-6-git-send-email-pl@kamp.de>
Reply-To: quintela@redhat.com
Date: Tue, 20 Mar 2018 19:02:58 +0100
Message-ID: <87woy6zktp.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 5/5] migration/block: compare only read
 blocks against the rate limiter
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
> only read_done blocks are in the queued to be flushed to the migration
> stream. submitted blocks are still in flight.
>
> Signed-off-by: Peter Lieven <pl@kamp.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


> ---
>  migration/block.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/migration/block.c b/migration/block.c
> index ce939e2..4e950c2 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -773,8 +773,7 @@ static int block_save_iterate(QEMUFile *f, void *opaque)
>  
>      /* control the rate of transfer */
>      blk_mig_lock();
> -    while ((block_mig_state.submitted +
> -            block_mig_state.read_done) * BLOCK_SIZE <
> +    while (block_mig_state.read_done * BLOCK_SIZE <
>             qemu_file_get_rate_limit(f) &&
>             block_mig_state.submitted < MAX_PARALLEL_IO &&
>             (block_mig_state.submitted + block_mig_state.read_done) <
