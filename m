Received: from eggs.gnu.org ([209.51.188.92]:46301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gx4IV-0006rG-82
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:27:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gx4IS-0003HY-Vq
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:26:58 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gx4IQ-00027t-Tn
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:26:56 -0500
Received: by mail-qt1-f195.google.com with SMTP id j36so1347639qta.7
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 22:25:31 -0800 (PST)
MIME-Version: 1.0
References: <20190222031413.20250-1-peterx@redhat.com>
	<20190222031413.20250-2-peterx@redhat.com>
In-Reply-To: <20190222031413.20250-2-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 22 Feb 2019 07:25:16 +0100
Message-ID: <CAMxuvayiNpRqudM9Ex_3MDYuTvcs3ya-tHmoAhWvCEu70WzUOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/4] iothread: replace init_done_cond with
 a semaphore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

Hi

On Fri, Feb 22, 2019 at 4:14 AM Peter Xu <peterx@redhat.com> wrote:
>
> Only sending an init-done message using lock+cond seems an overkill to
> me.  Replacing it with a simpler semaphore.
>
> Meanwhile, init the semaphore unconditionally, then we can destroy it
> unconditionally too in finalize which seems cleaner.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

The lock is also protecting thread_id.

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
