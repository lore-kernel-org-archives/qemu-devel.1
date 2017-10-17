Received: from eggs.gnu.org ([2001:4830:134:3::10]:41973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4Ntp-0008HH-3b
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 05:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4Ntl-0002EF-Q7
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 05:10:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e4Ntl-0002DF-Go
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 05:10:53 -0400
Date: Tue, 17 Oct 2017 11:10:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171017111047.1ae8e518@nial.brq.redhat.com>
In-Reply-To: <20171016165916.GI3246@localhost.localdomain>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<1508170976-96869-5-git-send-email-imammedo@redhat.com>
	<20171016165916.GI3246@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com

On Mon, 16 Oct 2017 14:59:16 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Oct 16, 2017 at 06:22:54PM +0200, Igor Mammedov wrote:
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
> 
> I would like to allow pausing before machine-type is selected, so
> management could run query-machines before choosing a
> machine-type.  Would that need a third "-pause" mode, or will we
> be able to change "preconf" to pause before select_machine() is
> called?
> The same probably applies to other things initialized before
> machine_run_board_init() that could be configurable using QMP,
> including but not limited to:
> * Accelerator configuration
> * Registering global properties
> * RAM size
> * SMP/CPU configuration
My goal is/were much more narrow and reachable without rewriting whole
qemu again (well I had to do a bit of necessary preparatory refactoring
for that to happen default_cpu+generilizing cpu_model parsing).

This series is focused on allowing to query cpu layout defined by f("-M foo -smp ...")
and configiring numa mapping for resulted layout. So it needs machine
object to exist by the time it's paused, which means that -M and -smp
options have to be parsed by that time.

Allowing pause basically before machine is created I'd guess, would be
a lot of additional re-factoring (beyond this series scope), I can't
say for sure if new pause mode is need for it or 'preconf' could be
moved to earlier stage later.
I'd speculate that for generic handling we would need
  - CLI options dependency tree
  - add new QMP/HMP command (process-cli-option)
       make it actionable, i.e. "process-cli-option -M foo" would create
       machine and user would be allowed to use other options
       that have machine dependency (for example -smp and after that -numa)
I woudn't like to go down that bottomless pit yet right now,
but probably we could add "process-cli-option" right now and allow only
-numa command for now so we would have external interface in place
and could extend it later.

> > +STEXI
> > +@item -paused
> > +@findex -paused
> > +if set enabled interactive configuration stages before machine emulation starts.
> > +'postconf' option value mimics -S option behaviour where machine is created
> > +but emulation isn't started. 'preconf' option value pauses QEMU before machine
> > +is created, which allows to query and configure properties affecting machine
> > +initialization. Use monitor/QMP command 'cont' to go to exit paused state.  
> 
> What if "-S" is used at the same time"?  Will "cont" only
> initialize the machine and wait for another "cont" command to
> start the VCPUs, or will it unpause everything?
in current impl. first 'cont' will exit preconfig loop and continue to
work as it used to be, i.e. -S will cause second pause right before
vcpus started and the second 'cont' will be needed to run machine.

> 
> > +ETEXI
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
> 
> I'm impressed by the simplicity of the implementation.  I though
> this would involve moving everything between this line and the
> next main_loop() call outside main(), so they would be called by
> qmp_cont().
> 
> Any expert on GLib's Event Loop sees any gotcha in this method?
> 
> I would like to do a careful review of main_loop_wait() and
> main_loop_should_exit(), to ensure those functions don't depend
> on anything that's initialized after this line.  Probably a few
> existing QMP commands can crash if machine is not initialized
> yet?
some HMP/QMP commands will crash for sure, any idea on how to
handle issue (i.e. prevent not allowed commands to run) is welcome.

> The rules and expectations on initialization ordering are very
> subtle, I suggest including test code for the new feature to
> ensure nothing crashes or breaks in the future.
that's only RFC, I've omitted testing part as approach
to be used isn't certain yet, but yep I plan on adding tests
for features that are expected to work with this.


> 
> >      machine_run_board_init(current_machine);
> >  
> >      realtime_init();
> > -- 
> > 2.7.4
> >   
> 
