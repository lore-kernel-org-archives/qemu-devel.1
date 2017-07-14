Received: from eggs.gnu.org ([2001:4830:134:3::10]:46702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVrP1-0004Yn-6I
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVrOy-0001Gx-3L
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:36:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dVrOx-0001Ge-QP
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:36:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EBC074862
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:36:22 +0000 (UTC)
Date: Fri, 14 Jul 2017 11:36:19 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170714033619.GG27284@pxdev.xzpeter.org>
References: <20170713115649.11853-1-dgilbert@redhat.com>
	<20170713115649.11853-4-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713115649.11853-4-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] migration/rdma: Allow cancelling
 while waiting for wrid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com

On Thu, Jul 13, 2017 at 12:56:47PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> When waiting for a WRID, if the other side dies we end up waiting
> for ever with no way to cancel the migration.
> Cure this by poll()ing the fd first with a timeout and checking
> error flags and migration state.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/rdma.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 6111e10c70..30f5542b49 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -1466,6 +1466,50 @@ static uint64_t qemu_rdma_poll(RDMAContext *rdma, uint64_t *wr_id_out,
>      return  0;
>  }
>  
> +/* Wait for activity on the completion channel.
> + * Returns 0 on success, none-0 on error.
> + */
> +static int qemu_rdma_wait_comp_channel(RDMAContext *rdma)
> +{
> +    /*
> +     * Coroutine doesn't start until migration_fd_process_incoming()
> +     * so don't yield unless we know we're running inside of a coroutine.
> +     */
> +    if (rdma->migration_started_on_destination) {
> +        yield_until_fd_readable(rdma->comp_channel->fd);
> +    } else {
> +        /* This is the source side, we're in a separate thread
> +         * or destination prior to migration_fd_process_incoming()
> +         * we can't yield; so we have to poll the fd.
> +         * But we need to be able to handle 'cancel' or an error
> +         * without hanging forever.
> +         */
> +        while (!rdma->error_state  && !rdma->received_error) {
> +            GPollFD pfds[1];
> +            pfds[0].fd = rdma->comp_channel->fd;
> +            pfds[0].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
> +            /* 0.1s timeout, should be fine for a 'cancel' */
> +            switch (qemu_poll_ns(pfds, 1, 100 * 1000 * 1000)) {
> +            case 1: /* fd active */
> +                return 0;
> +
> +            case 0: /* Timeout, go around again */
> +                break;
> +
> +            default: /* Error of some type */
> +                return -1;
> +            }
> +
> +            if (migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) {
> +                /* Bail out and let the cancellation happen */
> +                return -EPIPE;
> +            }
> +        }
> +    }
> +
> +    return rdma->error_state || rdma->received_error;

Just to note that this operation will return either 0 or 1, but not
anything <0 (most RDMA codes are using <0 as error, and error_state
should be <= 0 always iiuc).

But as the comment for this function, it's fine.

> +}
> +
>  /*
>   * Block until the next work request has completed.
>   *
> @@ -1513,12 +1557,8 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rdma, int wrid_requested,
>      }
>  
>      while (1) {
> -        /*
> -         * Coroutine doesn't start until migration_fd_process_incoming()
> -         * so don't yield unless we know we're running inside of a coroutine.
> -         */
> -        if (rdma->migration_started_on_destination) {
> -            yield_until_fd_readable(rdma->comp_channel->fd);
> +        if (qemu_rdma_wait_comp_channel(rdma)) {

Do we want something like:

  ret = -EIO;

Here? Or capture the return code of qemu_rdma_wait_comp_channel() (but
then we need to make sure its return code is <0)?

I guess "ret" is still zero, and it means this function will return
with zero as well even timed out?

Thanks,

-- 
Peter Xu
