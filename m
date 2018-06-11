Received: from eggs.gnu.org ([2001:4830:134:3::10]:49892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSP49-0006EA-Pv
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSP46-00066P-Ob
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:49:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40180 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fSP46-00065u-JF
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:49:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ACAB4401EF29
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 15:49:05 +0000 (UTC)
Date: Mon, 11 Jun 2018 16:49:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180611154902.GG2661@work-vm>
References: <20180523111817.1463-1-quintela@redhat.com>
	<20180523111817.1463-10-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523111817.1463-10-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v13 09/12] migration: Start sending messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 28f5cea4d8..2584130c85 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -729,9 +729,6 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>      RAMBlock *block;
>      int i;
>  
> -    /* ToDo: We can't use it until we haven't received a message */
> -    return 0;
> -
>      be32_to_cpus(&packet->magic);
>      if (packet->magic != MULTIFD_MAGIC) {
>          error_setg(errp, "multifd: received packet "
> @@ -965,6 +962,7 @@ static void *multifd_send_thread(void *opaque)
>  {
>      MultiFDSendParams *p = opaque;
>      Error *local_err = NULL;
> +    int ret;
>  
>      trace_multifd_send_thread_start(p->id);
>  
> @@ -992,7 +990,16 @@ static void *multifd_send_thread(void *opaque)
>  
>              trace_multifd_send(p->id, seq, used, flags);
>  
> -            /* ToDo: send packet here */
> +            ret = qio_channel_write_all(p->c, (void *)p->packet,
> +                                        p->packet_len, &local_err);
> +            if (ret != 0) {
> +                break;
> +            }
> +
> +            ret = qio_channel_writev_all(p->c, p->pages->iov, used, &local_err);
> +            if (ret != 0) {
> +                break;
> +            }
>  
>              qemu_mutex_lock(&p->mutex);
>              p->pending_job--;
> @@ -1204,7 +1211,14 @@ static void *multifd_recv_thread(void *opaque)
>              uint32_t flags;
>              qemu_mutex_unlock(&p->mutex);
>  
> -            /* ToDo: recv packet here */
> +            ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
> +                                           p->packet_len, &local_err);
> +            if (ret == 0) {   /* EOF */
> +                break;
> +            }
> +            if (ret == -1) {   /* Error */
> +                break;
> +            }
>  
>              qemu_mutex_lock(&p->mutex);
>              ret = multifd_recv_unfill_packet(p, &local_err);
> @@ -1221,6 +1235,11 @@ static void *multifd_recv_thread(void *opaque)
>              p->num_pages += used;
>              qemu_mutex_unlock(&p->mutex);
>  
> +            ret = qio_channel_readv_all(p->c, p->pages->iov, used, &local_err);
> +            if (ret != 0) {
> +                break;
> +            }
> +
>              if (flags & MULTIFD_FLAG_SYNC) {
>                  qemu_sem_post(&multifd_recv_state->sem_sync);
>                  qemu_sem_wait(&p->sem_sync);
> -- 
> 2.17.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
