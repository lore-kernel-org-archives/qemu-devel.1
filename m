Received: from eggs.gnu.org ([209.51.188.92]:51463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggZ6h-0006Az-Kf
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggZ6Q-00024n-Em
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:54:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ggZ6P-00023b-U0
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:54:18 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-15-fli@suse.com>
Date: Mon, 07 Jan 2019 18:54:11 +0100
In-Reply-To: <20181225140449.15786-15-fli@suse.com> (Fei Li's message of "Tue,
	25 Dec 2018 22:04:47 +0800")
Message-ID: <87a7kcl5fg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 14/16] qemu_thread: supplement
 error handling for vnc_start_worker_thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, lifei1214@126.com, Gerd Hoffmann <kraxel@redhat.com>

Fei Li <fli@suse.com> writes:

> Supplement the error handling for vnc_thread_worker_thread: add
> an Error parameter for it to propagate the error to its caller to
> handle in case it fails, and make it return a Boolean to indicate
> whether it succeeds.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Fei Li <fli@suse.com>
> ---
>  ui/vnc-jobs.c | 17 +++++++++++------
>  ui/vnc-jobs.h |  2 +-
>  ui/vnc.c      |  4 +++-
>  3 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
> index 5712f1f501..35a652d1fd 100644
> --- a/ui/vnc-jobs.c
> +++ b/ui/vnc-jobs.c
> @@ -332,16 +332,21 @@ static bool vnc_worker_thread_running(void)
>      return queue; /* Check global queue */
>  }
>  
> -void vnc_start_worker_thread(void)
> +bool vnc_start_worker_thread(Error **errp)
>  {
>      VncJobQueue *q;
>  
> -    if (vnc_worker_thread_running())
> -        return ;
> +    if (vnc_worker_thread_running()) {
> +        goto out;

Why not simply return true?

> +    }
>  
>      q = vnc_queue_init();
> -    /* TODO: let the further caller handle the error instead of abort() here */
> -    qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread,
> -                       q, QEMU_THREAD_DETACHED, &error_abort);
> +    if (!qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread,
> +                            q, QEMU_THREAD_DETACHED, errp)) {
> +        vnc_queue_clear(q);
> +        return false;
> +    }
>      queue = q; /* Set global queue */
> +out:
> +    return true;
>  }
> diff --git a/ui/vnc-jobs.h b/ui/vnc-jobs.h
> index 59f66bcc35..14640593db 100644
> --- a/ui/vnc-jobs.h
> +++ b/ui/vnc-jobs.h
> @@ -37,7 +37,7 @@ void vnc_job_push(VncJob *job);
>  void vnc_jobs_join(VncState *vs);
>  
>  void vnc_jobs_consume_buffer(VncState *vs);
> -void vnc_start_worker_thread(void);
> +bool vnc_start_worker_thread(Error **errp);
>  
>  /* Locks */
>  static inline int vnc_trylock_display(VncDisplay *vd)
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 0c1b477425..0ffe9e6a5d 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3236,7 +3236,9 @@ void vnc_display_init(const char *id, Error **errp)
>      vd->connections_limit = 32;
>  
>      qemu_mutex_init(&vd->mutex);
> -    vnc_start_worker_thread();
> +    if (!vnc_start_worker_thread(errp)) {
> +        return;
> +    }
>  
>      vd->dcl.ops = &dcl_ops;
>      register_displaychangelistener(&vd->dcl);
