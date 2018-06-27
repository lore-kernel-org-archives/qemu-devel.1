Received: from eggs.gnu.org ([2001:4830:134:3::10]:46558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fY7yD-0004Ll-SQ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fY7y9-0007M0-0U
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:46:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47298 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fY7y8-0007LH-Rh
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:46:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A78D401EF28
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 10:46:36 +0000 (UTC)
Date: Wed, 27 Jun 2018 11:46:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180627104630.GD2423@work-vm>
References: <20180626181932.11909-1-quintela@redhat.com>
	<20180626181932.11909-13-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626181932.11909-13-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v16 13/14] migration: Remove not needed
 semaphore and quit
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
> We know quit with shutdwon in the QIO.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> --
> Add comment
> Use shutdown() instead of unref()
> ---
>  migration/ram.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 5d38d699f3..61f7313093 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -594,14 +594,10 @@ typedef struct {
>      QemuThread thread;
>      /* communication channel */
>      QIOChannel *c;
> -    /* sem where to wait for more work */
> -    QemuSemaphore sem;
>      /* this mutex protects the following parameters */
>      QemuMutex mutex;
>      /* is this channel thread running */
>      bool running;
> -    /* should this thread finish */
> -    bool quit;
>      /* array of pages to receive */
>      MultiFDPages_t *pages;
>      /* packet allocated len */
> @@ -1144,8 +1140,11 @@ static void multifd_recv_terminate_threads(Error *err)
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>  
>          qemu_mutex_lock(&p->mutex);
> -        p->quit = true;
> -        qemu_sem_post(&p->sem);
> +        /* We could arrive here for two reasons:
> +           - normal quit, i.e. everything went fine, just finished
> +           - error quit: We close the channels so the channel threads
> +             finish the qio_channel_read_all_eof() */
> +        qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
>          qemu_mutex_unlock(&p->mutex);
>      }
>  }
> @@ -1168,7 +1167,6 @@ int multifd_load_cleanup(Error **errp)
>          object_unref(OBJECT(p->c));
>          p->c = NULL;
>          qemu_mutex_destroy(&p->mutex);
> -        qemu_sem_destroy(&p->sem);
>          qemu_sem_destroy(&p->sem_sync);
>          g_free(p->name);
>          p->name = NULL;
> @@ -1291,9 +1289,7 @@ int multifd_load_setup(void)
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>  
>          qemu_mutex_init(&p->mutex);
> -        qemu_sem_init(&p->sem, 0);
>          qemu_sem_init(&p->sem_sync, 0);
> -        p->quit = false;
>          p->id = i;
>          p->pages = multifd_pages_init(page_count);
>          p->packet_len = sizeof(MultiFDPacket_t)
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
