Received: from eggs.gnu.org ([2001:4830:134:3::10]:51425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAamn-0007hL-C4
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAami-00037U-Eq
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:13:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gAami-00036y-6Q
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:13:48 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181010120841.13214-1-fli@suse.com>
	<20181010120841.13214-3-fli@suse.com>
Date: Thu, 11 Oct 2018 15:13:40 +0200
In-Reply-To: <20181010120841.13214-3-fli@suse.com> (Fei Li's message of "Wed,
	10 Oct 2018 20:08:36 +0800")
Message-ID: <87h8hs4oe3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v5 2/7] ui/vnc.c: polish vnc_init_func
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com, armbru@redhat.com, famz@redhat.com

Fei Li <fli@suse.com> writes:

> Add a new Error parameter for vnc_display_init() to handle errors
> in its caller: vnc_init_func(), just like vnc_display_open() does.
> And let the call trace propagate the Error.
>
> Besides, make vnc_start_worker_thread() return a bool to indicate
> whether it succeeds instead of returning nothing.
>
> Signed-off-by: Fei Li <fli@suse.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> ---
>  include/ui/console.h |  2 +-
>  ui/vnc-jobs.c        |  9 ++++++---
>  ui/vnc-jobs.h        |  2 +-
>  ui/vnc.c             | 12 +++++++++---
>  4 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index fb969caf70..c17803c530 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -453,7 +453,7 @@ void qemu_display_early_init(DisplayOptions *opts);
>  void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
>  
>  /* vnc.c */
> -void vnc_display_init(const char *id);
> +void vnc_display_init(const char *id, Error **errp);
>  void vnc_display_open(const char *id, Error **errp);
>  void vnc_display_add_client(const char *id, int csock, bool skipauth);
>  int vnc_display_password(const char *id, const char *password);
> diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
> index 929391f85d..8807d7217c 100644
> --- a/ui/vnc-jobs.c
> +++ b/ui/vnc-jobs.c
> @@ -331,15 +331,18 @@ static bool vnc_worker_thread_running(void)
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
> +    }
>  
>      q = vnc_queue_init();
>      qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread, q,
>                         QEMU_THREAD_DETACHED);
>      queue = q; /* Set global queue */
> +out:
> +    return true;
>  }

This function cannot fail.  Why convert it to Error, and complicate its
caller?

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
> index cf221c83cc..f3806e76db 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3205,7 +3205,7 @@ static const DisplayChangeListenerOps dcl_ops = {
>      .dpy_cursor_define    = vnc_dpy_cursor_define,
>  };
>  
> -void vnc_display_init(const char *id)
> +void vnc_display_init(const char *id, Error **errp)
>  {
>      VncDisplay *vd;
>  
       if (vnc_display_find(id) != NULL) {
           return;
       }
       vd = g_malloc0(sizeof(*vd));

       vd->id = strdup(id);
       QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);

       QTAILQ_INIT(&vd->clients);
       vd->expires = TIME_MAX;

       if (keyboard_layout) {
           trace_vnc_key_map_init(keyboard_layout);
           vd->kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout);
       } else {
           vd->kbd_layout = init_keyboard_layout(name2keysym, "en-us");
       }

       if (!vd->kbd_layout) {
           exit(1);

Uh, init_keyboard_layout() reports errors to stderr, and the exit(1)
here makes them fatal.  Okay before this patch, but inappropriate
afterwards.  I'm afraid you have to convert init_keyboard_layout() to
Error first.

       }

       vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
> @@ -3235,7 +3235,9 @@ void vnc_display_init(const char *id)
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
> @@ -4079,7 +4081,11 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
>      char *id = (char *)qemu_opts_id(opts);
>  
>      assert(id);
> -    vnc_display_init(id);
> +    vnc_display_init(id, &local_err);
> +    if (local_err) {
> +        error_reportf_err(local_err, "Failed to init VNC server: ");
> +        exit(1);
> +    }
>      vnc_display_open(id, &local_err);
>      if (local_err != NULL) {
>          error_reportf_err(local_err, "Failed to start VNC server: ");

Conflicts with my "[PATCH 24/31] vl: Clean up error reporting in
vnc_init_func()".  Your patch shows that mine is incomplete.

Without my patch, there's no real reason for yours, however.  The two
should be squashed together.
