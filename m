Received: from eggs.gnu.org ([2001:4830:134:3::10]:44345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSPwc-0004p9-1X
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSPwX-0002Ry-1F
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:45:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41084 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fSPwW-0002Rd-PW
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:45:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E5776BB428
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 16:45:19 +0000 (UTC)
Date: Mon, 11 Jun 2018 17:45:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180611164516.GI2661@work-vm>
References: <20180523111817.1463-1-quintela@redhat.com>
	<20180523111817.1463-12-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523111817.1463-12-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v13 11/12] migration: Remove not needed
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
> We know quit closing the QIO.

This patch does two different things; one of which I think I understand.

The 'quit' has been removed - I think that makes sense because the
multifd threads terminate when either they come to the end of a stream
or hit an error; there's no case of asking them to quit explicitly.
The 'sem' was basically for kicking the recv-thread to quit; which again
isn't needed.

Now, what about the object_unref on p->c ?
If I've got this right multifd_recv_terminate_threads is only called in
the error case; but doesn't multifd_load_cleanup also get called in that
case - it does the unref and p->c = NULL as well.

Dave

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index a707d3ae80..62eea9e02f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -587,14 +587,10 @@ typedef struct {
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
> @@ -1115,8 +1111,8 @@ static void multifd_recv_terminate_threads(Error *err)
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>  
>          qemu_mutex_lock(&p->mutex);
> -        p->quit = true;
> -        qemu_sem_post(&p->sem);
> +        object_unref(OBJECT(p->c));
> +        p->c = NULL;
>          qemu_mutex_unlock(&p->mutex);
>      }
>  }
> @@ -1139,7 +1135,6 @@ int multifd_load_cleanup(Error **errp)
>          object_unref(OBJECT(p->c));
>          p->c = NULL;
>          qemu_mutex_destroy(&p->mutex);
> -        qemu_sem_destroy(&p->sem);
>          qemu_sem_destroy(&p->sem_sync);
>          g_free(p->name);
>          p->name = NULL;
> @@ -1262,9 +1257,7 @@ int multifd_load_setup(void)
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
> 2.17.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
