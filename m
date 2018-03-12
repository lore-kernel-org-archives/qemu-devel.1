Received: from eggs.gnu.org ([2001:4830:134:3::10]:51292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evJc6-000334-SM
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evJc5-0000Ix-Vx
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:19:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33034 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1evJc5-0000I4-QU
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:19:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2DB4D4000B6E
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 09:19:22 +0000 (UTC)
Date: Mon, 12 Mar 2018 17:19:13 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180312091913.GG5234@xz-mi>
References: <20180307110010.2205-1-quintela@redhat.com>
	<20180307110010.2205-20-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180307110010.2205-20-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 19/24] migration: Create multifd
 channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Wed, Mar 07, 2018 at 12:00:05PM +0100, Juan Quintela wrote:
> In both sides.  We still don't transmit anything through them.

s/In/On/?

> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 52 ++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 42 insertions(+), 10 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index b57d9fd667..7ef0c2b7e2 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -399,6 +399,7 @@ struct MultiFDSendParams {
>      uint8_t id;
>      char *name;
>      QemuThread thread;
> +    QIOChannel *c;
>      QemuSemaphore sem;
>      QemuMutex mutex;
>      bool running;
> @@ -455,6 +456,8 @@ int multifd_save_cleanup(Error **errp)
>              qemu_thread_join(&p->thread);
>              p->running = false;
>          }
> +        socket_send_channel_destroy(p->c);
> +        p->c = NULL;
>          qemu_mutex_destroy(&p->mutex);
>          qemu_sem_destroy(&p->sem);
>          g_free(p->name);
> @@ -514,6 +517,27 @@ static void *multifd_send_thread(void *opaque)
>      return NULL;
>  }
>  
> +static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
> +{
> +    MultiFDSendParams *p = opaque;
> +    QIOChannel *sioc = QIO_CHANNEL(qio_task_get_source(task));
> +    Error *local_err = NULL;
> +
> +    if (qio_task_propagate_error(task, &local_err)) {
> +        if (multifd_save_cleanup(&local_err) != 0) {

Do we need to call multifd_save_cleanup() explicitly here?

Asked since I saw that it would also be called in migrate_fd_cleanup(),
and it seems that we should call migrate_fd_cleanup() soon too when
this happens?

Otherwise it looks fine to me.  Thanks,

> +            migrate_set_error(migrate_get_current(), local_err);
> +        }
> +    } else {
> +        p->c = QIO_CHANNEL(sioc);
> +        qio_channel_set_delay(p->c, false);
> +        p->running = true;
> +        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
> +                           QEMU_THREAD_JOINABLE);
> +
> +        atomic_inc(&multifd_send_state->count);
> +    }
> +}

[...]


-- 
Peter Xu
