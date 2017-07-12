Received: from eggs.gnu.org ([2001:4830:134:3::10]:59256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dV8XW-0004nk-EL
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 23:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dV8XS-0001B5-Ew
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 23:42:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dV8XS-0001Az-8U
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 23:42:10 -0400
Date: Wed, 12 Jul 2017 11:42:05 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170712034204.GF29326@pxdev.xzpeter.org>
References: <20170704184915.31586-1-dgilbert@redhat.com>
	<20170704184915.31586-6-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170704184915.31586-6-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] migration/rdma: Send error during
 cancelling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, michael@hinespot.com, quintela@redhat.com, lvivier@redhat.com, berrange@redhat.com

On Tue, Jul 04, 2017 at 07:49:15PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> When we issue a cancel and clean up the RDMA channel
> send a CONTROL_ERROR to get the destination to quit.
> 
> The rdma_cleanup code waits for the event to come back
> from the rdma_disconnect; but that wont happen until the
> destination quits and there's currently nothing to force
> it.
> 
> Note this makes the case of a cancel work while the destination
> is alive, and it already works if the destination is
> truly dead.  Note it doesn't fix the case where the destination
> is hung (we get stuck waiting for the rdma_disconnect event).
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Looks like we'll print this as well when we cancel the migration
(before sending the RDMA_CONTROL_ERROR):

  error_report("Early error. Sending error.");

But I don't think it really matters. So:

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  migration/rdma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index bfb0a43740..3d17db3a23 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -2260,7 +2260,9 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
>      int ret, idx;
>  
>      if (rdma->cm_id && rdma->connected) {
> -        if (rdma->error_state && !rdma->received_error) {
> +        if ((rdma->error_state ||
> +             migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) &&
> +            !rdma->received_error) {
>              RDMAControlHeader head = { .len = 0,
>                                         .type = RDMA_CONTROL_ERROR,
>                                         .repeat = 1,
> -- 
> 2.13.0
> 

-- 
Peter Xu
