Received: from eggs.gnu.org ([2001:4830:134:3::10]:55398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fO4yd-0003p2-0I
	for qemu-devel@nongnu.org; Wed, 30 May 2018 13:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fO4yY-0007C3-VD
	for qemu-devel@nongnu.org; Wed, 30 May 2018 13:33:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53468 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fO4yY-0007BG-Im
	for qemu-devel@nongnu.org; Wed, 30 May 2018 13:33:30 -0400
Date: Wed, 30 May 2018 18:33:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180530173325.GG2410@work-vm>
References: <1527673416-31268-1-git-send-email-lidongchen@tencent.com>
	<1527673416-31268-12-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527673416-31268-12-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v4 11/12] migration: poll the cm event
 while wait RDMA work request completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, berrange@redhat.com, aviadye@mellanox.com, pbonzini@redhat.com, qemu-devel@nongnu.org, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

* Lidong Chen (jemmy858585@gmail.com) wrote:
> If the peer qemu is crashed, the qemu_rdma_wait_comp_channel function
> maybe loop forever. so we should also poll the cm event fd, and when
> receive any cm event, we consider some error happened.
> 
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>

I don't understand enough about the way the infiniband fd's work to
fully review this; so I'd appreciate if some one who does could
comment/add their review.

> ---
>  migration/rdma.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 1b9e261..d611a06 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -1489,6 +1489,9 @@ static uint64_t qemu_rdma_poll(RDMAContext *rdma, uint64_t *wr_id_out,
>   */
>  static int qemu_rdma_wait_comp_channel(RDMAContext *rdma)
>  {
> +    struct rdma_cm_event *cm_event;
> +    int ret = -1;
> +
>      /*
>       * Coroutine doesn't start until migration_fd_process_incoming()
>       * so don't yield unless we know we're running inside of a coroutine.
> @@ -1504,25 +1507,35 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma)
>           * But we need to be able to handle 'cancel' or an error
>           * without hanging forever.
>           */
> -        while (!rdma->error_state  && !rdma->received_error) {
> -            GPollFD pfds[1];
> +        while (!rdma->error_state && !rdma->received_error) {
> +            GPollFD pfds[2];
>              pfds[0].fd = rdma->comp_channel->fd;
>              pfds[0].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
> +            pfds[0].revents = 0;
> +
> +            pfds[1].fd = rdma->channel->fd;
> +            pfds[1].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
> +            pfds[1].revents = 0;
> +
>              /* 0.1s timeout, should be fine for a 'cancel' */
> -            switch (qemu_poll_ns(pfds, 1, 100 * 1000 * 1000)) {
> -            case 1: /* fd active */
> -                return 0;
> +            qemu_poll_ns(pfds, 2, 100 * 1000 * 1000);

Shouldn't we still check the return value of this; if it's negative
something has gone wrong.

Dave

> -            case 0: /* Timeout, go around again */
> -                break;
> +            if (pfds[1].revents) {
> +                ret = rdma_get_cm_event(rdma->channel, &cm_event);
> +                if (!ret) {
> +                    rdma_ack_cm_event(cm_event);
> +                }
> +                error_report("receive cm event while wait comp channel,"
> +                             "cm event is %d", cm_event->event);
>  
> -            default: /* Error of some type -
> -                      * I don't trust errno from qemu_poll_ns
> -                     */
> -                error_report("%s: poll failed", __func__);
> +                /* consider any rdma communication event as an error */
>                  return -EPIPE;
>              }
>  
> +            if (pfds[0].revents) {
> +                return 0;
> +            }
> +
>              if (migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) {
>                  /* Bail out and let the cancellation happen */
>                  return -EPIPE;
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
