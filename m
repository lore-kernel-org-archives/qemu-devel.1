Received: from eggs.gnu.org ([2001:4830:134:3::10]:38068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d7nMS-00019m-3T
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d7nMO-00038N-P2
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:26:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57503)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d7nMO-00038C-Fy
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:26:16 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170505193810.2934-1-eblake@redhat.com>
	<20170505193810.2934-3-eblake@redhat.com>
Date: Mon, 08 May 2017 20:26:11 +0200
In-Reply-To: <20170505193810.2934-3-eblake@redhat.com> (Eric Blake's message
	of "Fri, 5 May 2017 14:38:07 -0500")
Message-ID: <87zien433w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 2/5] shutdown: Prepare for use of an
 enum in reset/shutdown_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, alistair.francis@xilinx.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>

Eric Blake <eblake@redhat.com> writes:

> We want to track why a guest was shutdown; in particular, being able
> to tell the difference between a guest request (such as ACPI request)
> and host request (such as SIGINT) will prove useful to libvirt.
> Since all requests eventually end up changing shutdown_requested in
> vl.c, the logical change is to make that value track the reason,
> rather than its current 0/1 contents.
>
> Since command-line options control whether a reset request is turned
> into a shutdown request instead, the same treatment is given to
> reset_requested.
>
> This patch adds an internal enum ShutdownCause that describes reasons
> that a shutdown can be requested, and changes qemu_system_reset() to
> pass the reason through, although for now it is not reported.  The
> enum could be exported via QAPI at a later date, if deemed necessary,
> but for now, there has not been a request to expose that much detail
> to end clients.
>
> For now, we only populate the reason with HOST_ERROR, along with FIXME
> comments that describe our plans for how to pass an actual correct
> reason.

In other words, replacing 0 by SHUTDOWN_CAUSE_NONE, and 1 by
SHUTDOWN_CAUSE_HOST_ERROR.  Makes sense.

>          The next patches will then actually wire things up to modify
> events to report data based on the reason, and to pass the correct enum
> value in from various call-sites that can trigger a reset/shutdown (big
> enough that it was worth splitting from this patch).
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v6: make ShutdownCause internal-only, add SHUTDOWN_CAUSE_NONE so that
> comparison to 0 still works, tweak initial FIXME values
> v5: no change
> v4: s/ShutdownType/ShutdownCause/, no thanks to mingw header pollution
> v3: new patch
> ---
>  include/sysemu/sysemu.h | 22 ++++++++++++++++++---
>  vl.c                    | 51 +++++++++++++++++++++++++++++++------------------
>  hw/i386/xen/xen-hvm.c   |  7 +++++--
>  migration/colo.c        |  2 +-
>  migration/savevm.c      |  2 +-
>  5 files changed, 58 insertions(+), 26 deletions(-)
>
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 16175f7..e4da9d4 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -36,6 +36,22 @@ void vm_state_notify(int running, RunState state);
>  #define VMRESET_SILENT   false
>  #define VMRESET_REPORT   true
>
> +/* Enumeration of various causes for shutdown. */
> +typedef enum ShutdownCause ShutdownCause;
> +enum ShutdownCause {

Why define the typedef separately here?  What's wrong with

    typedef enum ShutdownCause {
        ...
    } ShutdownCause;

?

> +    SHUTDOWN_CAUSE_NONE,          /* No shutdown requested yet */

Comment is fine.  Possible alternative: /* No shutdown request pending */

> +    SHUTDOWN_CAUSE_HOST_QMP,      /* Reaction to a QMP command, like 'quit' */
> +    SHUTDOWN_CAUSE_HOST_SIGNAL,   /* Reaction to a signal, such as SIGINT */
> +    SHUTDOWN_CAUSE_HOST_UI,       /* Reaction to UI event, like window close */
> +    SHUTDOWN_CAUSE_HOST_ERROR,    /* An error prevents further use of guest */
> +    SHUTDOWN_CAUSE_GUEST_SHUTDOWN,/* Guest requested shutdown, such as via
> +                                     ACPI or other hardware-specific means */
> +    SHUTDOWN_CAUSE_GUEST_RESET,   /* Guest requested reset, and command line
> +                                     turns that into a shutdown */
> +    SHUTDOWN_CAUSE_GUEST_PANIC,   /* Guest panicked, and command line turns
> +                                     that into a shutdown */
> +};
> +
>  void vm_start(void);
>  int vm_prepare_start(void);
>  int vm_stop(RunState state);
> @@ -62,10 +78,10 @@ void qemu_system_debug_request(void);
>  void qemu_system_vmstop_request(RunState reason);
>  void qemu_system_vmstop_request_prepare(void);
>  bool qemu_vmstop_requested(RunState *r);
> -int qemu_shutdown_requested_get(void);
> -int qemu_reset_requested_get(void);
> +ShutdownCause qemu_shutdown_requested_get(void);
> +ShutdownCause qemu_reset_requested_get(void);
>  void qemu_system_killed(int signal, pid_t pid);
> -void qemu_system_reset(bool report);
> +void qemu_system_reset(bool report, ShutdownCause reason);
>  void qemu_system_guest_panicked(GuestPanicInformation *info);
>  size_t qemu_target_page_size(void);
>
> diff --git a/vl.c b/vl.c
> index f22a3ac..6069fb2 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1597,8 +1597,9 @@ void vm_state_notify(int running, RunState state)
>      }
>  }
>
> -static int reset_requested;
> -static int shutdown_requested, shutdown_signal;
> +static ShutdownCause reset_requested;
> +static ShutdownCause shutdown_requested;
> +static int shutdown_signal;
>  static pid_t shutdown_pid;
>  static int powerdown_requested;
>  static int debug_requested;
> @@ -1612,19 +1613,19 @@ static NotifierList wakeup_notifiers =
>      NOTIFIER_LIST_INITIALIZER(wakeup_notifiers);
>  static uint32_t wakeup_reason_mask = ~(1 << QEMU_WAKEUP_REASON_NONE);
>
> -int qemu_shutdown_requested_get(void)
> +ShutdownCause qemu_shutdown_requested_get(void)
>  {
>      return shutdown_requested;
>  }
>
> -int qemu_reset_requested_get(void)
> +ShutdownCause qemu_reset_requested_get(void)
>  {
>      return reset_requested;
>  }
>
>  static int qemu_shutdown_requested(void)
>  {
> -    return atomic_xchg(&shutdown_requested, 0);
> +    return atomic_xchg(&shutdown_requested, SHUTDOWN_CAUSE_NONE);
>  }
>
>  static void qemu_kill_report(void)
> @@ -1647,14 +1648,14 @@ static void qemu_kill_report(void)
>      }
>  }
>
> -static int qemu_reset_requested(void)
> +static ShutdownCause qemu_reset_requested(void)
>  {
> -    int r = reset_requested;
> +    ShutdownCause r = reset_requested;

Good opportunity to insert a blank line here.

>      if (r && replay_checkpoint(CHECKPOINT_RESET_REQUESTED)) {
> -        reset_requested = 0;
> +        reset_requested = SHUTDOWN_CAUSE_NONE;
>          return r;
>      }
> -    return false;
> +    return SHUTDOWN_CAUSE_NONE;
>  }
>
>  static int qemu_suspend_requested(void)
> @@ -1686,7 +1687,12 @@ static int qemu_debug_requested(void)
>      return r;
>  }
>
> -void qemu_system_reset(bool report)
> +/*
> + * Reset the VM. If @report is VMRESET_REPORT, issue an event, using
> + * the @reason interpreted as ShutdownCause for details.  Otherwise,
> + * @report is VMRESET_SILENT and @reason is ignored.
> + */

"interpreted as ShutdownCause"?  It *is* a ShutdownCause.  Leftover?

> +void qemu_system_reset(bool report, ShutdownCause reason)
>  {
>      MachineClass *mc;
>
> @@ -1700,6 +1706,7 @@ void qemu_system_reset(bool report)
>          qemu_devices_reset();
>      }
>      if (report) {
> +        assert(reason);
>          qapi_event_send_reset(&error_abort);
>      }
>      cpu_synchronize_all_post_reset();

Looks like we're not using @reason "for details" just yet.

> @@ -1738,9 +1745,10 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
>  void qemu_system_reset_request(void)
>  {
>      if (no_reboot) {
> -        shutdown_requested = 1;
> +        /* FIXME - add a parameter to allow callers to specify reason */
> +        shutdown_requested = SHUTDOWN_CAUSE_HOST_ERROR;
>      } else {
> -        reset_requested = 1;
> +        reset_requested = SHUTDOWN_CAUSE_HOST_ERROR;
>      }
>      cpu_stop_current();
>      qemu_notify_event();
> @@ -1807,7 +1815,7 @@ void qemu_system_killed(int signal, pid_t pid)
>      /* Cannot call qemu_system_shutdown_request directly because
>       * we are in a signal handler.
>       */
> -    shutdown_requested = 1;
> +    shutdown_requested = SHUTDOWN_CAUSE_HOST_SIGNAL;

Should this be SHUTDOWN_CAUSE_HOST_ERROR, to be updated in the next
patch?  Alternatively, tweak this patch's commit message?

>      qemu_notify_event();
>  }
>
> @@ -1815,7 +1823,8 @@ void qemu_system_shutdown_request(void)
>  {
>      trace_qemu_system_shutdown_request();
>      replay_shutdown_request();
> -    shutdown_requested = 1;
> +    /* FIXME - add a parameter to allow callers to specify reason */
> +    shutdown_requested = SHUTDOWN_CAUSE_HOST_ERROR;
>      qemu_notify_event();
>  }
>
> @@ -1846,13 +1855,16 @@ void qemu_system_debug_request(void)
>  static bool main_loop_should_exit(void)
>  {
>      RunState r;
> +    ShutdownCause request;
> +
>      if (qemu_debug_requested()) {
>          vm_stop(RUN_STATE_DEBUG);
>      }
>      if (qemu_suspend_requested()) {
>          qemu_system_suspend();
>      }
> -    if (qemu_shutdown_requested()) {
> +    request = qemu_shutdown_requested();
> +    if (request) {
>          qemu_kill_report();
>          qapi_event_send_shutdown(&error_abort);
>          if (no_shutdown) {

The detour through @request appears isn't necessary here.  Perhaps you
do it for consistency with the next hunk.  Do you?  Just asking to make
sure I get what you're doing.

Hmm, there's another one in xen-hvm.c, but consistency hardly applies
there.  If later patches add more uses, you might want delay the change
until then.

> @@ -1861,9 +1873,10 @@ static bool main_loop_should_exit(void)
>              return true;
>          }
>      }
> -    if (qemu_reset_requested()) {
> +    request = qemu_reset_requested();
> +    if (request) {
>          pause_all_vcpus();
> -        qemu_system_reset(VMRESET_REPORT);
> +        qemu_system_reset(VMRESET_REPORT, request);
>          resume_all_vcpus();
>          if (!runstate_check(RUN_STATE_RUNNING) &&
>                  !runstate_check(RUN_STATE_INMIGRATE)) {
> @@ -1872,7 +1885,7 @@ static bool main_loop_should_exit(void)
>      }
>      if (qemu_wakeup_requested()) {
>          pause_all_vcpus();
> -        qemu_system_reset(VMRESET_SILENT);
> +        qemu_system_reset(VMRESET_SILENT, SHUTDOWN_CAUSE_NONE);
>          notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
>          wakeup_reason = QEMU_WAKEUP_REASON_NONE;
>          resume_all_vcpus();
> @@ -4686,7 +4699,7 @@ int main(int argc, char **argv, char **envp)
>         reading from the other reads, because timer polling functions query
>         clock values from the log. */
>      replay_checkpoint(CHECKPOINT_RESET);
> -    qemu_system_reset(VMRESET_SILENT);
> +    qemu_system_reset(VMRESET_SILENT, SHUTDOWN_CAUSE_NONE);
>      register_global_state();
>      if (replay_mode != REPLAY_MODE_NONE) {
>          replay_vmstate_init();
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index b1c05ff..b1001c1 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -1089,11 +1089,14 @@ static void cpu_handle_ioreq(void *opaque)
>           * causes Xen to powerdown the domain.
>           */
>          if (runstate_is_running()) {
> +            ShutdownCause request;
> +
>              if (qemu_shutdown_requested_get()) {
>                  destroy_hvm_domain(false);
>              }
> -            if (qemu_reset_requested_get()) {
> -                qemu_system_reset(VMRESET_REPORT);
> +            request = qemu_reset_requested_get();
> +            if (request) {
> +                qemu_system_reset(VMRESET_REPORT, request);
>                  destroy_hvm_domain(true);
>              }
>          }
> diff --git a/migration/colo.c b/migration/colo.c
> index 963c802..bf5b7e9 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -623,7 +623,7 @@ void *colo_process_incoming_thread(void *opaque)
>          }
>
>          qemu_mutex_lock_iothread();
> -        qemu_system_reset(VMRESET_SILENT);
> +        qemu_system_reset(VMRESET_SILENT, SHUTDOWN_CAUSE_NONE);
>          vmstate_loading = true;
>          if (qemu_loadvm_state(fb) < 0) {
>              error_report("COLO: loadvm failed");
> diff --git a/migration/savevm.c b/migration/savevm.c
> index a00c1ab..9ac2d22 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2300,7 +2300,7 @@ int load_vmstate(const char *name)
>          return -EINVAL;
>      }
>
> -    qemu_system_reset(VMRESET_SILENT);
> +    qemu_system_reset(VMRESET_SILENT, SHUTDOWN_CAUSE_NONE);
>      mis->from_src_file = f;
>
>      aio_context_acquire(aio_context);

You seem to be passing SHUTDOWN_CAUSE_NONE exactly with VMRESET_SILENT.
Would it be possible to have SHUTDOWN_CAUSE_NONE imply !report, any
other case imply report, and get rid of the first parameter?
