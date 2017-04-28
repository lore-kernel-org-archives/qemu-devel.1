Received: from eggs.gnu.org ([2001:4830:134:3::10]:60827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d40xA-0003NJ-Cl
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d40x5-0002CH-B9
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:08:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d40x4-00029f-UP
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:08:31 -0400
Date: Fri, 28 Apr 2017 09:08:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170428080821.GB2085@work-vm>
References: <20170428021317.24711-1-eblake@redhat.com>
	<20170428021317.24711-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170428021317.24711-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/4] shutdown: Prepare for use of an
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, alistair.francis@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>

* Eric Blake (eblake@redhat.com) wrote:
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
> This patch adds a QAPI enum ShutdownCause that describes reasons
> that a shutdown can be requested, and changes qemu_system_reset() to
> pass the reason through, although for now it is not reported.  The
> next patch will actually wire things up to modify events to report
> data based on the reason, and to pass the correct enum value in from
> various call-sites that can trigger a reset/shutdown.  Since QAPI
> generates enums starting at 0, it's easier if we use a different
> number as our sentinel that no request has happened yet.  Most of
> the changes are in vl.c, but xen was using things externally.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v4: s/ShutdownType/ShutdownCause/, no thanks to mingw header pollution
> v3: new patch
> ---
>  qapi-schema.json        | 23 +++++++++++++++++++++++
>  include/sysemu/sysemu.h |  2 +-
>  vl.c                    | 44 ++++++++++++++++++++++++++++----------------
>  hw/i386/xen/xen-hvm.c   |  9 ++++++---
>  migration/colo.c        |  2 +-
>  migration/savevm.c      |  2 +-
>  6 files changed, 60 insertions(+), 22 deletions(-)
> 
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 01b087f..a4ebdd1 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -2304,6 +2304,29 @@
>  { 'command': 'system_powerdown' }
> 
>  ##
> +# @ShutdownCause:
> +#
> +# Enumeration of various causes for shutdown.
> +#
> +# @host-qmp: Reaction to a QMP command, such as 'quit'
> +# @host-signal: Reaction to a signal, such as SIGINT
> +# @host-ui: Reaction to a UI event, such as closing the window
> +# @host-replay: The host is replaying an earlier shutdown event
> +# @host-error: Qemu encountered an error that prevents further use of the guest
> +# @guest-shutdown: The guest requested a shutdown, such as via ACPI or
> +#                  other hardware-specific action
> +# @guest-reset: The guest requested a reset, and the command line
> +#               response to a reset is to instead trigger a shutdown
> +# @guest-panic: The guest panicked, and the command line response to
> +#               a panic is to trigger a shutdown

It's a little coarse grained;  is there anyway to pass platform specific information
for debug?  I ask because I spent a while debugging a few bugs with unexpected
resets and had to figure out which of x86's many reset causes triggered it.

Dave

> +# Since: 2.10
> +##
> +{ 'enum': 'ShutdownCause',
> +  'data': [ 'host-qmp', 'host-signal', 'host-ui', 'host-replay', 'host-error',
> +            'guest-shutdown', 'guest-reset', 'guest-panic' ] }
> +
> +##
>  # @cpu:
>  #
>  # This command is a nop that is only provided for the purposes of compatibility.
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 16175f7..00a907f 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -65,7 +65,7 @@ bool qemu_vmstop_requested(RunState *r);
>  int qemu_shutdown_requested_get(void);
>  int qemu_reset_requested_get(void);
>  void qemu_system_killed(int signal, pid_t pid);
> -void qemu_system_reset(bool report);
> +void qemu_system_reset(bool report, int reason);
>  void qemu_system_guest_panicked(GuestPanicInformation *info);
>  size_t qemu_target_page_size(void);
> 
> diff --git a/vl.c b/vl.c
> index 879786a..2b95b7f 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1597,8 +1597,8 @@ void vm_state_notify(int running, RunState state)
>      }
>  }
> 
> -static int reset_requested;
> -static int shutdown_requested, shutdown_signal;
> +static int reset_requested = -1;
> +static int shutdown_requested = -1, shutdown_signal;
>  static pid_t shutdown_pid;
>  static int powerdown_requested;
>  static int debug_requested;
> @@ -1624,7 +1624,7 @@ int qemu_reset_requested_get(void)
> 
>  static int qemu_shutdown_requested(void)
>  {
> -    return atomic_xchg(&shutdown_requested, 0);
> +    return atomic_xchg(&shutdown_requested, -1);
>  }
> 
>  static void qemu_kill_report(void)
> @@ -1650,11 +1650,11 @@ static void qemu_kill_report(void)
>  static int qemu_reset_requested(void)
>  {
>      int r = reset_requested;
> -    if (r && replay_checkpoint(CHECKPOINT_RESET_REQUESTED)) {
> -        reset_requested = 0;
> +    if (r >= 0 && replay_checkpoint(CHECKPOINT_RESET_REQUESTED)) {
> +        reset_requested = -1;
>          return r;
>      }
> -    return false;
> +    return -1;
>  }
> 
>  static int qemu_suspend_requested(void)
> @@ -1686,7 +1686,12 @@ static int qemu_debug_requested(void)
>      return r;
>  }
> 
> -void qemu_system_reset(bool report)
> +/*
> + * Reset the VM. If @report is VMRESET_REPORT, issue an event, using
> + * the @reason interpreted as ShutdownType for details.  Otherwise,
> + * @report is VMRESET_SILENT and @reason is ignored.
> + */
> +void qemu_system_reset(bool report, int reason)
>  {
>      MachineClass *mc;
> 
> @@ -1700,6 +1705,7 @@ void qemu_system_reset(bool report)
>          qemu_devices_reset();
>      }
>      if (report) {
> +        assert(reason >= 0);
>          qapi_event_send_reset(&error_abort);
>      }
>      cpu_synchronize_all_post_reset();
> @@ -1738,9 +1744,10 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
>  void qemu_system_reset_request(void)
>  {
>      if (no_reboot) {
> -        shutdown_requested = 1;
> +        /* FIXME - add a parameter to allow callers to specify reason */
> +        shutdown_requested = SHUTDOWN_CAUSE_GUEST_RESET;
>      } else {
> -        reset_requested = 1;
> +        reset_requested = SHUTDOWN_CAUSE_GUEST_RESET;
>      }
>      cpu_stop_current();
>      qemu_notify_event();
> @@ -1807,7 +1814,7 @@ void qemu_system_killed(int signal, pid_t pid)
>      /* Cannot call qemu_system_shutdown_request directly because
>       * we are in a signal handler.
>       */
> -    shutdown_requested = 1;
> +    shutdown_requested = SHUTDOWN_CAUSE_HOST_SIGNAL;
>      qemu_notify_event();
>  }
> 
> @@ -1815,7 +1822,8 @@ void qemu_system_shutdown_request(void)
>  {
>      trace_qemu_system_shutdown_request();
>      replay_shutdown_request();
> -    shutdown_requested = 1;
> +    /* FIXME - add a parameter to allow callers to specify reason */
> +    shutdown_requested = SHUTDOWN_CAUSE_GUEST_SHUTDOWN;
>      qemu_notify_event();
>  }
> 
> @@ -1846,13 +1854,16 @@ void qemu_system_debug_request(void)
>  static bool main_loop_should_exit(void)
>  {
>      RunState r;
> +    int request;
> +
>      if (qemu_debug_requested()) {
>          vm_stop(RUN_STATE_DEBUG);
>      }
>      if (qemu_suspend_requested()) {
>          qemu_system_suspend();
>      }
> -    if (qemu_shutdown_requested()) {
> +    request = qemu_shutdown_requested();
> +    if (request >= 0) {
>          qemu_kill_report();
>          qapi_event_send_shutdown(&error_abort);
>          if (no_shutdown) {
> @@ -1861,9 +1872,10 @@ static bool main_loop_should_exit(void)
>              return true;
>          }
>      }
> -    if (qemu_reset_requested()) {
> +    request = qemu_reset_requested();
> +    if (request >= 0) {
>          pause_all_vcpus();
> -        qemu_system_reset(VMRESET_REPORT);
> +        qemu_system_reset(VMRESET_REPORT, request);
>          resume_all_vcpus();
>          if (!runstate_check(RUN_STATE_RUNNING) &&
>                  !runstate_check(RUN_STATE_INMIGRATE)) {
> @@ -1872,7 +1884,7 @@ static bool main_loop_should_exit(void)
>      }
>      if (qemu_wakeup_requested()) {
>          pause_all_vcpus();
> -        qemu_system_reset(VMRESET_SILENT);
> +        qemu_system_reset(VMRESET_SILENT, -1);
>          notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
>          wakeup_reason = QEMU_WAKEUP_REASON_NONE;
>          resume_all_vcpus();
> @@ -4684,7 +4696,7 @@ int main(int argc, char **argv, char **envp)
>         reading from the other reads, because timer polling functions query
>         clock values from the log. */
>      replay_checkpoint(CHECKPOINT_RESET);
> -    qemu_system_reset(VMRESET_SILENT);
> +    qemu_system_reset(VMRESET_SILENT, -1);
>      register_global_state();
>      if (replay_mode != REPLAY_MODE_NONE) {
>          replay_vmstate_init();
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index b1c05ff..3a6484c 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -1089,11 +1089,14 @@ static void cpu_handle_ioreq(void *opaque)
>           * causes Xen to powerdown the domain.
>           */
>          if (runstate_is_running()) {
> -            if (qemu_shutdown_requested_get()) {
> +            int request;
> +
> +            if (qemu_shutdown_requested_get() >= 0) {
>                  destroy_hvm_domain(false);
>              }
> -            if (qemu_reset_requested_get()) {
> -                qemu_system_reset(VMRESET_REPORT);
> +            request = qemu_reset_requested_get();
> +            if (request >= 0) {
> +                qemu_system_reset(VMRESET_REPORT, request);
>                  destroy_hvm_domain(true);
>              }
>          }
> diff --git a/migration/colo.c b/migration/colo.c
> index c19eb3f..17a5482 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -611,7 +611,7 @@ void *colo_process_incoming_thread(void *opaque)
>          }
> 
>          qemu_mutex_lock_iothread();
> -        qemu_system_reset(VMRESET_SILENT);
> +        qemu_system_reset(VMRESET_SILENT, -1);
>          vmstate_loading = true;
>          if (qemu_loadvm_state(fb) < 0) {
>              error_report("COLO: loadvm failed");
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 03ae1bd..dcbaf00 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2292,7 +2292,7 @@ int load_vmstate(const char *name)
>          return -EINVAL;
>      }
> 
> -    qemu_system_reset(VMRESET_SILENT);
> +    qemu_system_reset(VMRESET_SILENT, -1);
>      mis->from_src_file = f;
> 
>      aio_context_acquire(aio_context);
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
