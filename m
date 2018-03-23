Received: from eggs.gnu.org ([2001:4830:134:3::10]:56755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ezUBX-0008AK-RP
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ezUBT-0005Fu-Qm
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:25:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ezUBT-0005EX-I4
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:25:11 -0400
Date: Fri, 23 Mar 2018 18:25:08 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180323212508.GF28161@localhost.localdomain>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-4-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520860275-101576-4-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/9] cli: add -preconfig option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Mon, Mar 12, 2018 at 02:11:09PM +0100, Igor Mammedov wrote:
> This option allows pausing QEMU in the new RUN_STATE_PRECONFIG state,
> allowing the configuration of QEMU from QMP before the machine jumps
> into board initialization code of machine_run_board_init()
> 
> Intent is to allow management to query machine state and additionally
> configure it using previous query results within one QEMU instance
> (i.e. eliminate need to start QEMU twice, 1st to query board specific
> parameters and 2nd for actual VM start using query results for
> additional parameters).
> 
> New option complements -S option and could be used with or without
> it. Difference is that -S pauses QEMU when machine is completely
> build with all devices wired up and ready run (QEMU need only to
> unpause CPUs to let guest execute its code).
> And "preconfig" option pauses QEMU early before board specific init
> callback (machine_run_board_init) is executed and will allow to
> configure machine parameters which will be used by board init code.
> 
> When early introspection/configuration is done, command 'cont' should
> be used to exit RUN_STATE_PRECONFIG and transition to the next
> requested state (i.e. if -S is used then QEMU will pause the second
> time when board/device initialization is completed or start guest
> execution if -S isn't provided on CLI)
> 
> PS:
> Initially 'preconfig' is planned to be used for configuring numa
> topology depending on board specified possible cpus layout.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v4:
>   * Explain more on behaviour in commit message and use suggested
>     wording in message and patch (Eric Blake <eblake@redhat.com>)
> ---
>  include/sysemu/sysemu.h |  1 +
>  qapi/run-state.json     |  5 ++++-
>  qemu-options.hx         | 13 +++++++++++++
>  qmp.c                   |  5 +++++
>  vl.c                    | 35 ++++++++++++++++++++++++++++++++++-
>  5 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 356bfdc..996bc38 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -66,6 +66,7 @@ typedef enum WakeupReason {
>      QEMU_WAKEUP_REASON_OTHER,
>  } WakeupReason;
>  
> +void qemu_exit_preconfig_request(void);
>  void qemu_system_reset_request(ShutdownCause reason);
>  void qemu_system_suspend_request(void);
>  void qemu_register_suspend_notifier(Notifier *notifier);
> diff --git a/qapi/run-state.json b/qapi/run-state.json
> index 1c9fff3..ce846a5 100644
> --- a/qapi/run-state.json
> +++ b/qapi/run-state.json
> @@ -49,12 +49,15 @@
>  # @colo: guest is paused to save/restore VM state under colo checkpoint,
>  #        VM can not get into this state unless colo capability is enabled
>  #        for migration. (since 2.8)
> +# @preconfig: QEMU is paused before board specific init callback is executed.
> +#             The state is reachable only if -preconfig CLI option is used.
> +#             (Since 2.12)
>  ##
>  { 'enum': 'RunState',
>    'data': [ 'debug', 'inmigrate', 'internal-error', 'io-error', 'paused',
>              'postmigrate', 'prelaunch', 'finish-migrate', 'restore-vm',
>              'running', 'save-vm', 'shutdown', 'suspended', 'watchdog',
> -            'guest-panicked', 'colo' ] }
> +            'guest-panicked', 'colo', 'preconfig' ] }
>  
>  ##
>  # @StatusInfo:
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 6585058..7c8aaa5 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3302,6 +3302,19 @@ STEXI
>  Run the emulation in single step mode.
>  ETEXI
>  
> +DEF("preconfig", 0, QEMU_OPTION_preconfig, \
> +    "-preconfig      pause QEMU before machine is initialized\n",
> +    QEMU_ARCH_ALL)
> +STEXI
> +@item -preconfig
> +@findex -preconfig
> +Pause QEMU for interactive configuration before the machine is created,
> +which allows querying and configuring properties that will affect
> +machine initialization. Use the QMP command 'cont' to exit the preconfig
> +state and move to the next state (ie. run guest if -S isn't used or
> +pause the second time is -S is used).
> +ETEXI
> +
>  DEF("S", 0, QEMU_OPTION_S, \
>      "-S              freeze CPU at startup (use 'c' to start execution)\n",
>      QEMU_ARCH_ALL)
> diff --git a/qmp.c b/qmp.c
> index 8c7d1cc..b38090d 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -166,6 +166,11 @@ void qmp_cont(Error **errp)
>      BlockBackend *blk;
>      Error *local_err = NULL;
>  
> +    if (runstate_check(RUN_STATE_PRECONFIG)) {
> +        qemu_exit_preconfig_request();
> +        return;
> +    }
> +
>      /* if there is a dump in background, we should wait until the dump
>       * finished */
>      if (dump_in_progress()) {
> diff --git a/vl.c b/vl.c
> index 3ef04ce..69b1997 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -593,7 +593,7 @@ static int default_driver_check(void *opaque, QemuOpts *opts, Error **errp)
>  /***********************************************************/
>  /* QEMU state */
>  
> -static RunState current_run_state = RUN_STATE_PRELAUNCH;
> +static RunState current_run_state = RUN_STATE_PRECONFIG;
>  
>  /* We use RUN_STATE__MAX but any invalid value will do */
>  static RunState vmstop_requested = RUN_STATE__MAX;
> @@ -606,6 +606,9 @@ typedef struct {
>  
>  static const RunStateTransition runstate_transitions_def[] = {
>      /*     from      ->     to      */
> +    { RUN_STATE_PRECONFIG, RUN_STATE_PRELAUNCH },
> +    { RUN_STATE_PRECONFIG, RUN_STATE_INMIGRATE },

Don't this mean -preconfig and -incoming could work together?

> +
>      { RUN_STATE_DEBUG, RUN_STATE_RUNNING },
>      { RUN_STATE_DEBUG, RUN_STATE_FINISH_MIGRATE },
>      { RUN_STATE_DEBUG, RUN_STATE_PRELAUNCH },
> @@ -1629,6 +1632,7 @@ static pid_t shutdown_pid;
>  static int powerdown_requested;
>  static int debug_requested;
>  static int suspend_requested;
> +static bool preconfig_exit_requested = true;
>  static WakeupReason wakeup_reason;
>  static NotifierList powerdown_notifiers =
>      NOTIFIER_LIST_INITIALIZER(powerdown_notifiers);
> @@ -1713,6 +1717,11 @@ static int qemu_debug_requested(void)
>      return r;
>  }
>  
> +void qemu_exit_preconfig_request(void)
> +{
> +    preconfig_exit_requested = true;
> +}
> +
>  /*
>   * Reset the VM. Issue an event unless @reason is SHUTDOWN_CAUSE_NONE.
>   */
> @@ -1886,6 +1895,13 @@ static bool main_loop_should_exit(void)
>      RunState r;
>      ShutdownCause request;
>  
> +    if (preconfig_exit_requested) {
> +        if (runstate_check(RUN_STATE_PRECONFIG)) {

Is it possible to have preconfig_exit_request set outside of
RUN_STATE_PRECONFIG?  When and why?

> +            runstate_set(RUN_STATE_PRELAUNCH);
> +        }
> +        preconfig_exit_requested = false;
> +        return true;
> +    }
>      if (qemu_debug_requested()) {
>          vm_stop(RUN_STATE_DEBUG);
>      }
> @@ -3697,6 +3713,14 @@ int main(int argc, char **argv, char **envp)
>                      exit(1);
>                  }
>                  break;
> +            case QEMU_OPTION_preconfig:
> +                if (runstate_check(RUN_STATE_INMIGRATE)) {
> +                    error_report("option can not be used with "
> +                                 "-incoming option");
> +                    exit(EXIT_FAILURE);
> +                }

So -incoming changes runstate as soon as the option is parsed?

Ouch.

I would rather not rely on that behavior and just do
"if (incoming)".

Why exactly it's not possible to use -incoming with -preconfig?


> +                preconfig_exit_requested = false;
> +                break;
>              case QEMU_OPTION_enable_kvm:
>                  olist = qemu_find_opts("machine");
>                  qemu_opts_parse_noisily(olist, "accel=kvm", false);
> @@ -3902,6 +3926,11 @@ int main(int argc, char **argv, char **envp)
>                  }
>                  break;
>              case QEMU_OPTION_incoming:
> +                if (!preconfig_exit_requested) {
> +                    error_report("option can not be used with "
> +                                 "-preconfig option");
> +                    exit(EXIT_FAILURE);
> +                }

Instead of reimplementing the same check in two separate places,
why not validate options and check for (incoming && preconfig)
after the option parsing loop?

>                  if (!incoming) {
>                      runstate_set(RUN_STATE_INMIGRATE);
>                  }
> @@ -4594,6 +4623,10 @@ int main(int argc, char **argv, char **envp)
>      }
>      parse_numa_opts(current_machine);
>  
> +    /* do monitor/qmp handling at preconfig state if requested */
> +    main_loop();

Wouldn't it be simpler to do "if (!preconfig) { main_loop(); }"
instead of entering main_loop() just to exit immediately?

> +
> +    /* from here on runstate is RUN_STATE_PRELAUNCH */
>      machine_run_board_init(current_machine);
>  
>      realtime_init();
> -- 
> 2.7.4
> 
> 

-- 
Eduardo
