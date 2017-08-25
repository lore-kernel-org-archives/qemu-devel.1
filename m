Received: from eggs.gnu.org ([2001:4830:134:3::10]:54426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dlGWA-00038b-O1
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dlGW8-0007mi-8u
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:27:30 -0400
Received: from mail-vk0-x233.google.com ([2607:f8b0:400c:c05::233]:34218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dlGW8-0007ly-0T
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:27:28 -0400
Received: by mail-vk0-x233.google.com with SMTP id s199so370752vke.1
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 08:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<1503471071-2233-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1503471071-2233-3-git-send-email-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 25 Aug 2017 15:27:16 +0000
Message-ID: <CAJ+F1CKvY9iMtTQSrM2xVUwXYb0pcHjtFf8x4xpxG5ke-FPf3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 2/8] monitor: allow monitor to create
 thread to poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, mdroth@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Wed, Aug 23, 2017 at 8:52 AM Peter Xu <peterx@redhat.com> wrote:

> Firstly, introduce Monitor.use_thread, and set it for monitors that are
> using non-mux typed backend chardev.  We only do this for monitors, so
> mux-typed chardevs are not suitable (when it connects to, e.g., serials
> and the monitor together).
>
> When use_thread is set, we create standalone thread to poll the monitor
> events, isolated from the main loop thread.  Here we still need to take
> the BQL before dispatching the tasks since some of the monitor commands
> are not allowed to execute without the protection of BQL.  Then this
> gives us the chance to avoid taking the BQL for some monitor commands in
> the future.
>
> * Why this change?
>
> We need these per-monitor threads to make sure we can have at least one
> monitor that will never stuck (that can receive further monitor
> commands).
>
> * So when will monitors stuck?  And, how do they stuck?
>
> After we have postcopy and remote page faults, it's simple to achieve a
> stuck in the monitor (which is also a stuck in main loop thread):
>
> (1) Monitor deadlock on BQL
>
> As we may know, when postcopy is running on destination VM, the vcpu
> threads can stuck merely any time as long as it tries to access an
> uncopied guest page.  Meanwhile, when the stuck happens, it is possible
> that the vcpu thread is holding the BQL.  If the page fault is not
> handled quickly, you'll find that monitors stop working, which is trying
> to take the BQL.
>
> If the page fault cannot be handled correctly (one case is a paused
> postcopy, when network is temporarily down), monitors will hang
> forever.  Without current patch, that means the main loop hanged.  We'll
> never find a way to talk to VM again.
>

Could the BQL be pushed down to the monitor commands level instead? That
way we wouldn't need a seperate thread to solve the hang on commands that
do not need BQL.

We could also optionnally make command that need the BQL to fail if lock is
held (after a timeout)?



> (2) Monitor tries to run codes page-faulted vcpus
>
> The HMP command "info cpus" is one of the good example - it tries to
> kick all the vcpus and sync status from them.  However, if there is any
> vcpu that stuck at an unhandled page fault, it can never achieve the
> sync, then the HMP hangs.  Again, it hangs the main loop thread as well.
>
> After either (1) or (2), we can see the deadlock problem:
>
> - On one hand, if monitor hangs, we cannot do the postcopy recovery,
>   because postcopy recovery needs user to specify new listening port on
>   destination monitor.
>
> - On the other hand, if we cannot recover the paused postcopy, then page
>   faults cannot be serviced, and the monitors will possibly hang
>   forever then.
>
> * How this patch helps?
>
> - Firstly, we'll have our own thread for each dedicated monitor (or say,
>   the backend chardev is only used for monitor), so even main loop
>   thread hangs (it is always possible), this monitor thread may still
>   survive.
>
> - Not all monitor commands need the BQL.  We can selectively take the
>   BQL (depends on which command we are running) to avoid waiting on a
>   page-faulted vcpu thread that has taken the BQL (this will be done in
>   following up patches).
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c           | 75
> +++++++++++++++++++++++++++++++++++++++++++++++++----
>  qapi/qmp-dispatch.c | 15 +++++++++++
>  2 files changed, 85 insertions(+), 5 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 7c90df7..3d4ecff 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -36,6 +36,8 @@
>  #include "net/net.h"
>  #include "net/slirp.h"
>  #include "chardev/char-fe.h"
> +#include "chardev/char-mux.h"
> +#include "chardev/char-io.h"
>  #include "ui/qemu-spice.h"
>  #include "sysemu/numa.h"
>  #include "monitor/monitor.h"
> @@ -190,6 +192,8 @@ struct Monitor {
>      int flags;
>      int suspend_cnt;
>      bool skip_flush;
> +    /* Whether the monitor wants to be polled in standalone thread */
> +    bool use_thread;
>
>      QemuMutex out_lock;
>      QString *outbuf;
> @@ -206,6 +210,11 @@ struct Monitor {
>      mon_cmd_t *cmd_table;
>      QLIST_HEAD(,mon_fd_t) fds;
>      QLIST_ENTRY(Monitor) entry;
> +
> +    /* Only used when "use_thread" is used */
> +    QemuThread mon_thread;
> +    GMainContext *mon_context;
> +    GMainLoop *mon_loop;
>  };
>
>  /* QMP checker flags */
> @@ -568,7 +577,7 @@ static void monitor_qapi_event_init(void)
>
>  static void handle_hmp_command(Monitor *mon, const char *cmdline);
>
> -static void monitor_data_init(Monitor *mon, bool skip_flush)
> +static void monitor_data_init(Monitor *mon, bool skip_flush, bool
> use_thread)
>  {
>      memset(mon, 0, sizeof(Monitor));
>      qemu_mutex_init(&mon->out_lock);
> @@ -576,10 +585,34 @@ static void monitor_data_init(Monitor *mon, bool
> skip_flush)
>      /* Use *mon_cmds by default. */
>      mon->cmd_table =3D mon_cmds;
>      mon->skip_flush =3D skip_flush;
> +    mon->use_thread =3D use_thread;
> +    if (use_thread) {
> +        /*
> +         * For monitors that use isolated threads, they'll need their
> +         * own GMainContext and GMainLoop.  Otherwise, these pointers
> +         * will be NULL, which means the default context will be used.
> +         */
> +        mon->mon_context =3D g_main_context_new();
> +        mon->mon_loop =3D g_main_loop_new(mon->mon_context, TRUE);
> +    }
>  }
>
>  static void monitor_data_destroy(Monitor *mon)
>  {
> +    /* Destroy the thread first if there is */
> +    if (mon->use_thread) {
> +        /* Notify the per-monitor thread to quit. */
> +        g_main_loop_quit(mon->mon_loop);
> +        /*
> +         * Make sure the context will get the quit message since it's
> +         * in another thread.  Without this, it may not be able to
> +         * respond to the quit message immediately.
> +         */
> +        g_main_context_wakeup(mon->mon_context);
> +        qemu_thread_join(&mon->mon_thread);
> +        g_main_loop_unref(mon->mon_loop);
> +        g_main_context_unref(mon->mon_context);
> +    }
>      qemu_chr_fe_deinit(&mon->chr, false);
>      if (monitor_is_qmp(mon)) {
>          json_message_parser_destroy(&mon->qmp.parser);
> @@ -595,7 +628,7 @@ char *qmp_human_monitor_command(const char
> *command_line, bool has_cpu_index,
>      char *output =3D NULL;
>      Monitor *old_mon, hmp;
>
> -    monitor_data_init(&hmp, true);
> +    monitor_data_init(&hmp, true, false);
>
>      old_mon =3D cur_mon;
>      cur_mon =3D &hmp;
> @@ -3101,6 +3134,11 @@ static void handle_hmp_command(Monitor *mon, const
> char *cmdline)
>  {
>      QDict *qdict;
>      const mon_cmd_t *cmd;
> +    /*
> +     * If we haven't take the BQL (when called by per-monitor
> +     * threads), we need to take care of the BQL on our own.
> +     */
> +    bool take_bql =3D !qemu_mutex_iothread_locked();
>
>      trace_handle_hmp_command(mon, cmdline);
>
> @@ -3116,7 +3154,16 @@ static void handle_hmp_command(Monitor *mon, const
> char *cmdline)
>          return;
>      }
>
> +    if (take_bql) {
> +        qemu_mutex_lock_iothread();
> +    }
> +
>      cmd->cmd(mon, qdict);
> +
> +    if (take_bql) {
> +        qemu_mutex_unlock_iothread();
> +    }
> +
>      QDECREF(qdict);
>  }
>
> @@ -4086,6 +4133,15 @@ static void __attribute__((constructor))
> monitor_lock_init(void)
>      qemu_mutex_init(&monitor_lock);
>  }
>
> +static void *monitor_thread(void *data)
> +{
> +    Monitor *mon =3D data;
> +
> +    g_main_loop_run(mon->mon_loop);
> +
> +    return NULL;
> +}
> +
>  void monitor_init(Chardev *chr, int flags)
>  {
>      static int is_first_init =3D 1;
> @@ -4098,7 +4154,9 @@ void monitor_init(Chardev *chr, int flags)
>      }
>
>      mon =3D g_malloc(sizeof(*mon));
> -    monitor_data_init(mon, false);
> +
> +    /* For non-mux typed monitors, we create dedicated threads. */
> +    monitor_data_init(mon, false, !CHARDEV_IS_MUX(chr));
>
>      qemu_chr_fe_init(&mon->chr, chr, &error_abort);
>      mon->flags =3D flags;
> @@ -4112,12 +4170,19 @@ void monitor_init(Chardev *chr, int flags)
>
>      if (monitor_is_qmp(mon)) {
>          qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read,
> monitor_qmp_read,
> -                                 monitor_qmp_event, NULL, mon, NULL,
> true);
> +                                 monitor_qmp_event, NULL, mon,
> +                                 mon->mon_context, true);
>          qemu_chr_fe_set_echo(&mon->chr, true);
>          json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
>      } else {
>          qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read,
> monitor_read,
> -                                 monitor_event, NULL, mon, NULL, true);
> +                                 monitor_event, NULL, mon,
> +                                 mon->mon_context, true);
> +    }
> +
> +    if (mon->use_thread) {
> +        qemu_thread_create(&mon->mon_thread, chr->label, monitor_thread,
> +                           mon, QEMU_THREAD_JOINABLE);
>      }
>
>      qemu_mutex_lock(&monitor_lock);
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index 5ad36f8..3b6b224 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -19,6 +19,7 @@
>  #include "qapi/qmp/qjson.h"
>  #include "qapi-types.h"
>  #include "qapi/qmp/qerror.h"
> +#include "qemu/main-loop.h"
>
>  static QDict *qmp_dispatch_check_obj(const QObject *request, Error **err=
p)
>  {
> @@ -75,6 +76,11 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds,
> QObject *request,
>      QDict *args, *dict;
>      QmpCommand *cmd;
>      QObject *ret =3D NULL;
> +    /*
> +     * If we haven't take the BQL (when called by per-monitor
> +     * threads), we need to take care of the BQL on our own.
> +     */
> +    bool take_bql =3D !qemu_mutex_iothread_locked();
>
>      dict =3D qmp_dispatch_check_obj(request, errp);
>      if (!dict) {
> @@ -101,7 +107,16 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds=
,
> QObject *request,
>          QINCREF(args);
>      }
>
> +    if (take_bql) {
> +        qemu_mutex_lock_iothread();
> +    }
> +
>      cmd->fn(args, &ret, &local_err);
> +
> +    if (take_bql) {
> +        qemu_mutex_unlock_iothread();
> +    }
> +
>      if (local_err) {
>          error_propagate(errp, local_err);
>      } else if (cmd->options & QCO_NO_SUCCESS_RESP) {
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
