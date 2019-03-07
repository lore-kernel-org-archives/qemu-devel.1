Received: from eggs.gnu.org ([209.51.188.92]:52474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h1jPX-0006Ra-CB
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:09:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h1jPU-0001Rg-Mc
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:09:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1h1jPU-0001Qm-DF
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:09:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC834811A9
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 03:09:26 +0000 (UTC)
Date: Thu, 7 Mar 2019 11:09:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190307030836.GA12485@xz-x1>
References: <20190306115532.23025-1-peterx@redhat.com>
	<20190306115532.23025-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190306115532.23025-2-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/5] iothread: replace init_done_cond
 with a semaphore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Mar 06, 2019 at 07:55:28PM +0800, Peter Xu wrote:
> Only sending an init-done message using lock+cond seems an overkill to
> me.  Replacing it with a simpler semaphore.
> 
> Meanwhile, init the semaphore unconditionally, then we can destroy it
> unconditionally too in finalize which seems cleaner.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Sorry I've definitely lost Stefan's r-b for this patch.  It's the same
patch as the one I posted in v1.

> ---
>  include/sysemu/iothread.h |  3 +--
>  iothread.c                | 17 ++++-------------
>  2 files changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
> index 8a7ac2c528..50411ba54a 100644
> --- a/include/sysemu/iothread.h
> +++ b/include/sysemu/iothread.h
> @@ -27,8 +27,7 @@ typedef struct {
>      GMainContext *worker_context;
>      GMainLoop *main_loop;
>      GOnce once;
> -    QemuMutex init_done_lock;
> -    QemuCond init_done_cond;    /* is thread initialization done? */
> +    QemuSemaphore init_done_sem; /* is thread init done? */
>      bool stopping;              /* has iothread_stop() been called? */
>      bool running;               /* should iothread_run() continue? */
>      int thread_id;
> diff --git a/iothread.c b/iothread.c
> index e615b7ae52..6e297e9ef1 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -55,10 +55,8 @@ static void *iothread_run(void *opaque)
>      rcu_register_thread();
>  
>      my_iothread = iothread;
> -    qemu_mutex_lock(&iothread->init_done_lock);
>      iothread->thread_id = qemu_get_thread_id();
> -    qemu_cond_signal(&iothread->init_done_cond);
> -    qemu_mutex_unlock(&iothread->init_done_lock);
> +    qemu_sem_post(&iothread->init_done_sem);
>  
>      while (iothread->running) {
>          aio_poll(iothread->ctx, true);
> @@ -115,6 +113,7 @@ static void iothread_instance_init(Object *obj)
>  
>      iothread->poll_max_ns = IOTHREAD_POLL_MAX_NS_DEFAULT;
>      iothread->thread_id = -1;
> +    qemu_sem_init(&iothread->init_done_sem, 0);
>  }
>  
>  static void iothread_instance_finalize(Object *obj)
> @@ -123,10 +122,6 @@ static void iothread_instance_finalize(Object *obj)
>  
>      iothread_stop(iothread);
>  
> -    if (iothread->thread_id != -1) {
> -        qemu_cond_destroy(&iothread->init_done_cond);
> -        qemu_mutex_destroy(&iothread->init_done_lock);
> -    }
>      /*
>       * Before glib2 2.33.10, there is a glib2 bug that GSource context
>       * pointer may not be cleared even if the context has already been
> @@ -145,6 +140,7 @@ static void iothread_instance_finalize(Object *obj)
>          g_main_context_unref(iothread->worker_context);
>          iothread->worker_context = NULL;
>      }
> +    qemu_sem_destroy(&iothread->init_done_sem);
>  }
>  
>  static void iothread_complete(UserCreatable *obj, Error **errp)
> @@ -173,8 +169,6 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
>          return;
>      }
>  
> -    qemu_mutex_init(&iothread->init_done_lock);
> -    qemu_cond_init(&iothread->init_done_cond);
>      iothread->once = (GOnce) G_ONCE_INIT;
>  
>      /* This assumes we are called from a thread with useful CPU affinity for us
> @@ -188,12 +182,9 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
>      g_free(name);
>  
>      /* Wait for initialization to complete */
> -    qemu_mutex_lock(&iothread->init_done_lock);
>      while (iothread->thread_id == -1) {
> -        qemu_cond_wait(&iothread->init_done_cond,
> -                       &iothread->init_done_lock);
> +        qemu_sem_wait(&iothread->init_done_sem);
>      }
> -    qemu_mutex_unlock(&iothread->init_done_lock);
>  }
>  
>  typedef struct {
> -- 
> 2.17.1
> 

Regards,

-- 
Peter Xu
