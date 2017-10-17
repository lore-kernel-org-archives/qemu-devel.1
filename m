Received: from eggs.gnu.org ([2001:4830:134:3::10]:58141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4N3s-0000Sv-C5
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 04:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4N3p-0008JN-5A
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 04:17:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e4N3o-0008IO-R2
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 04:17:13 -0400
Date: Tue, 17 Oct 2017 10:17:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171017101707.5ff95d1c@nial.brq.redhat.com>
In-Reply-To: <20171016163515.GH11975@redhat.com>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<1508170976-96869-5-git-send-email-imammedo@redhat.com>
	<20171016163515.GH11975@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 4/6] CLI: add -paused option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, ehabkost@redhat.com, cohuck@redhat.com, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Mon, 16 Oct 2017 17:35:15 +0100
"Daniel P. Berrange" <berrange@redhat.com> wrote:

> On Mon, Oct 16, 2017 at 06:22:54PM +0200, Igor Mammedov wrote:
> 
> This really needs to have a commit message that provides justification
> for why this option is needed when we already have -S that is used
> to allow configuration before the guest starts.
Sorry, I've should have added here what I've tried to describe in cover letter.

-S pauses machine too late as machine is already created by the time
it's paused so trying to reconfigure it might require machine to be recreated.
In case of NUMA options it might be possible to hack x86 target to
rebuild/override acpi/fw_cfg so it would reflect the new settings set
this late but I wouldn't expect that it would work in general.

The cleanest way to configure it is pausing and configuring numa mapping
before machine is build.


> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/sysemu/sysemu.h |  1 +
> >  qemu-options.hx         | 15 ++++++++++++++
> >  qmp.c                   |  5 +++++
> >  vl.c                    | 54 ++++++++++++++++++++++++++++++++++++++++++++++++-
> >  4 files changed, 74 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> > index b213696..3feb94f 100644
> > --- a/include/sysemu/sysemu.h
> > +++ b/include/sysemu/sysemu.h
> > @@ -66,6 +66,7 @@ typedef enum WakeupReason {
> >      QEMU_WAKEUP_REASON_OTHER,
> >  } WakeupReason;
> >  
> > +void qemu_exit_preconfig_request(void);
> >  void qemu_system_reset_request(ShutdownCause reason);
> >  void qemu_system_suspend_request(void);
> >  void qemu_register_suspend_notifier(Notifier *notifier);
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 39225ae..bd44db8 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -3498,6 +3498,21 @@ STEXI
> >  Run the emulation in single step mode.
> >  ETEXI
> >  
> > +DEF("paused", HAS_ARG, QEMU_OPTION_paused, \
> > +    "-paused [state=]postconf|preconf\n"
> > +    "                postconf: pause QEMU after machine is initialized\n"
> > +    "                preconf: pause QEMU before machine is initialized\n",
> > +    QEMU_ARCH_ALL)
> > +STEXI
> > +@item -paused
> > +@findex -paused
> > +if set enabled interactive configuration stages before machine emulation starts.
> > +'postconf' option value mimics -S option behaviour where machine is created
> > +but emulation isn't started. 'preconf' option value pauses QEMU before machine
> > +is created, which allows to query and configure properties affecting machine
> > +initialization. Use monitor/QMP command 'cont' to go to exit paused state.
> > +ETEXI  
> 
> To me it feels rather unpleasant to be exposing this kind of detailed knowledge
> about the steps QEMU goes through when consttructing the machine and expecting
> the mgmt application to synchronize certain monitor actions against this.
well, so far alternative seems to be unacceptable as well, i.e.
start qemu twice
  #1 to get cpu layout form given '-M -smp' options
  #2 add -numa options that would map cpus provided at #1 to numa nodes


> > +
> >  DEF("S", 0, QEMU_OPTION_S, \
> >      "-S              freeze CPU at startup (use 'c' to start execution)\n",
> >      QEMU_ARCH_ALL)
> > diff --git a/qmp.c b/qmp.c
> > index e8c3031..49e9a5c 100644
> > --- a/qmp.c
> > +++ b/qmp.c
> > @@ -167,6 +167,11 @@ void qmp_cont(Error **errp)
> >      BlockBackend *blk;
> >      Error *local_err = NULL;
> >  
> > +    if (runstate_check(RUN_STATE_PRELAUNCH)) {
> > +        qemu_exit_preconfig_request();
> > +        return;
> > +    }
> > +
> >      /* if there is a dump in background, we should wait until the dump
> >       * finished */
> >      if (dump_in_progress()) {
> > diff --git a/vl.c b/vl.c
> > index 3fed457..30631fd 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -555,6 +555,20 @@ static QemuOptsList qemu_fw_cfg_opts = {
> >      },
> >  };
> >  
> > +static QemuOptsList qemu_paused_opts = {
> > +    .name = "paused",
> > +    .implied_opt_name = "state",
> > +    .head = QTAILQ_HEAD_INITIALIZER(qemu_paused_opts.head),
> > +    .desc = {
> > +        {
> > +            .name = "state",
> > +            .type = QEMU_OPT_STRING,
> > +            .help = "Pause state of QEMU on startup",
> > +        },
> > +        { /* end of list */ }
> > +    },
> > +};
> > +
> >  /**
> >   * Get machine options
> >   *
> > @@ -1689,6 +1703,11 @@ static pid_t shutdown_pid;
> >  static int powerdown_requested;
> >  static int debug_requested;
> >  static int suspend_requested;
> > +static enum {
> > +    PRECONFIG_CONT = 0,
> > +    PRECONFIG_PAUSE,
> > +    PRECONFIG_SKIP,
> > +} preconfig_requested;
> >  static WakeupReason wakeup_reason;
> >  static NotifierList powerdown_notifiers =
> >      NOTIFIER_LIST_INITIALIZER(powerdown_notifiers);
> > @@ -1773,6 +1792,11 @@ static int qemu_debug_requested(void)
> >      return r;
> >  }
> >  
> > +void qemu_exit_preconfig_request(void)
> > +{
> > +    preconfig_requested = PRECONFIG_CONT;
> > +}
> > +
> >  /*
> >   * Reset the VM. Issue an event unless @reason is SHUTDOWN_CAUSE_NONE.
> >   */
> > @@ -1939,6 +1963,12 @@ static bool main_loop_should_exit(void)
> >      RunState r;
> >      ShutdownCause request;
> >  
> > +    if (runstate_check(RUN_STATE_PRELAUNCH)) {
> > +        if (preconfig_requested == PRECONFIG_CONT) {
> > +            preconfig_requested = PRECONFIG_SKIP;
> > +            return true;
> > +        }
> > +    }
> >      if (qemu_debug_requested()) {
> >          vm_stop(RUN_STATE_DEBUG);
> >      }
> > @@ -3177,6 +3207,7 @@ int main(int argc, char **argv, char **envp)
> >      qemu_add_opts(&qemu_icount_opts);
> >      qemu_add_opts(&qemu_semihosting_config_opts);
> >      qemu_add_opts(&qemu_fw_cfg_opts);
> > +    qemu_add_opts(&qemu_paused_opts);
> >      module_call_init(MODULE_INIT_OPTS);
> >  
> >      runstate_init();
> > @@ -3845,6 +3876,26 @@ int main(int argc, char **argv, char **envp)
> >                      exit(1);
> >                  }
> >                  break;
> > +            case QEMU_OPTION_paused:
> > +                {
> > +                    const char *value;
> > +
> > +                    opts = qemu_opts_parse_noisily(qemu_find_opts("paused"),
> > +                                                   optarg, true);
> > +                    if (opts == NULL) {
> > +                        exit(1);
> > +                    }
> > +                    value = qemu_opt_get(opts, "state");
> > +                    if (!strcmp(value, "postconf")) {
> > +                        autostart = 0;
> > +                    } else if (!strcmp(value, "preconf")) {
> > +                        preconfig_requested = PRECONFIG_PAUSE;
> > +                    } else {
> > +                        error_report("incomplete '-paused' option\n");
> > +                        exit(1);
> > +                    }
> > +                    break;
> > +                }
> >              case QEMU_OPTION_enable_kvm:
> >                  olist = qemu_find_opts("machine");
> >                  qemu_opts_parse_noisily(olist, "accel=kvm", false);
> > @@ -4731,7 +4782,6 @@ int main(int argc, char **argv, char **envp)
> >      current_machine->boot_order = boot_order;
> >      current_machine->cpu_model = cpu_model;
> >  
> > -
> >      /* parse features once if machine provides default cpu_type */
> >      if (machine_class->default_cpu_type) {
> >          current_machine->cpu_type = machine_class->default_cpu_type;
> > @@ -4741,6 +4791,8 @@ int main(int argc, char **argv, char **envp)
> >          }
> >      }
> >  
> > +    main_loop(); /* do monitor/qmp handling at preconfig state if requested */
> > +
> >      machine_run_board_init(current_machine);
> >  
> >      realtime_init();
> > -- 
> > 2.7.4
> > 
> >   
> 
> Regards,
> Daniel
