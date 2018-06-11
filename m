Received: from eggs.gnu.org ([2001:4830:134:3::10]:51780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSP9m-0001Rr-R5
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSP9l-0000Mp-Vz
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:54:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fSP9l-0000Md-QY
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:54:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53B18401EF26
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 15:54:57 +0000 (UTC)
Date: Mon, 11 Jun 2018 16:54:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180611155450.GH2661@work-vm>
References: <20180523111817.1463-1-quintela@redhat.com>
	<20180523111817.1463-11-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523111817.1463-11-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v13 10/12] migration: Wait for blocking IO
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
> We have three conditions here:
> - channel fails -> error
> - we have to quit: we close the channel and reads fails
> - normal read that success, we are in bussiness
> 
> So forget the complications of waiting in a semaphore.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

I'd still prefer this to be squashed into the earlier ones somehow, but
the result looks OK afterwards I think.

Dave

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 81 ++++++++++++++++++-------------------------------
>  1 file changed, 29 insertions(+), 52 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 2584130c85..a707d3ae80 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -595,8 +595,6 @@ typedef struct {
>      bool running;
>      /* should this thread finish */
>      bool quit;
> -    /* thread has work to do */
> -    bool pending_job;
>      /* array of pages to receive */
>      MultiFDPages_t *pages;
>      /* packet allocated len */
> @@ -1170,14 +1168,6 @@ static void multifd_recv_sync_main(void)
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>  
> -        trace_multifd_recv_sync_main_signal(p->id);
> -        qemu_mutex_lock(&p->mutex);
> -        p->pending_job = true;
> -        qemu_mutex_unlock(&p->mutex);
> -    }
> -    for (i = 0; i < migrate_multifd_channels(); i++) {
> -        MultiFDRecvParams *p = &multifd_recv_state->params[i];
> -
>          trace_multifd_recv_sync_main_wait(p->id);
>          qemu_sem_wait(&multifd_recv_state->sem_sync);
>          qemu_mutex_lock(&p->mutex);
> @@ -1190,7 +1180,6 @@ static void multifd_recv_sync_main(void)
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>  
>          trace_multifd_recv_sync_main_signal(p->id);
> -
>          qemu_sem_post(&p->sem_sync);
>      }
>      trace_multifd_recv_sync_main(multifd_recv_state->seq);
> @@ -1205,51 +1194,40 @@ static void *multifd_recv_thread(void *opaque)
>      trace_multifd_recv_thread_start(p->id);
>  
>      while (true) {
> +        uint32_t used;
> +        uint32_t flags;
> +
> +        ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
> +                                       p->packet_len, &local_err);
> +        if (ret == 0) {   /* EOF */
> +            break;
> +        }
> +        if (ret == -1) {   /* Error */
> +            break;
> +        }
> +
>          qemu_mutex_lock(&p->mutex);
> -        if (true || p->pending_job) {
> -            uint32_t used;
> -            uint32_t flags;
> -            qemu_mutex_unlock(&p->mutex);
> -
> -            ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
> -                                           p->packet_len, &local_err);
> -            if (ret == 0) {   /* EOF */
> -                break;
> -            }
> -            if (ret == -1) {   /* Error */
> -                break;
> -            }
> -
> -            qemu_mutex_lock(&p->mutex);
> -            ret = multifd_recv_unfill_packet(p, &local_err);
> -            if (ret) {
> -                qemu_mutex_unlock(&p->mutex);
> -                break;
> -            }
> -
> -            used = p->pages->used;
> -            flags = p->flags;
> -            trace_multifd_recv(p->id, p->seq, used, flags);
> -            p->pending_job = false;
> -            p->num_packets++;
> -            p->num_pages += used;
> +        ret = multifd_recv_unfill_packet(p, &local_err);
> +        if (ret) {
>              qemu_mutex_unlock(&p->mutex);
> +            break;
> +        }
>  
> -            ret = qio_channel_readv_all(p->c, p->pages->iov, used, &local_err);
> -            if (ret != 0) {
> -                break;
> -            }
> +        used = p->pages->used;
> +        flags = p->flags;
> +        trace_multifd_recv(p->id, p->seq, used, flags);
> +        p->num_packets++;
> +        p->num_pages += used;
> +        qemu_mutex_unlock(&p->mutex);
>  
> -            if (flags & MULTIFD_FLAG_SYNC) {
> -                qemu_sem_post(&multifd_recv_state->sem_sync);
> -                qemu_sem_wait(&p->sem_sync);
> -            }
> -        } else if (p->quit) {
> -            qemu_mutex_unlock(&p->mutex);
> +        ret = qio_channel_readv_all(p->c, p->pages->iov, used, &local_err);
> +        if (ret != 0) {
>              break;
> -        } else {
> -            qemu_mutex_unlock(&p->mutex);
> -            /* sometimes there are spurious wakeups */
> +        }
> +
> +        if (flags & MULTIFD_FLAG_SYNC) {
> +            qemu_sem_post(&multifd_recv_state->sem_sync);
> +            qemu_sem_wait(&p->sem_sync);
>          }
>      }
>  
> @@ -1287,7 +1265,6 @@ int multifd_load_setup(void)
>          qemu_sem_init(&p->sem, 0);
>          qemu_sem_init(&p->sem_sync, 0);
>          p->quit = false;
> -        p->pending_job = false;
>          p->id = i;
>          p->pages = multifd_pages_init(page_count);
>          p->packet_len = sizeof(MultiFDPacket_t)
> -- 
> 2.17.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
