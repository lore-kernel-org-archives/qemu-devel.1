Received: from eggs.gnu.org ([2001:4830:134:3::10]:57224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f0qAd-000897-OJ
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f0qAa-0004FE-DH
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:05:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32908 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1f0qAZ-0004F2-W1
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:05:52 -0400
Date: Tue, 27 Mar 2018 17:05:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180327170541.295fc29a@redhat.com>
In-Reply-To: <20180323212508.GF28161@localhost.localdomain>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-4-git-send-email-imammedo@redhat.com>
	<20180323212508.GF28161@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/9] cli: add -preconfig option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Fri, 23 Mar 2018 18:25:08 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Mar 12, 2018 at 02:11:09PM +0100, Igor Mammedov wrote:
[...]
> > diff --git a/vl.c b/vl.c
> > index 3ef04ce..69b1997 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -593,7 +593,7 @@ static int default_driver_check(void *opaque, QemuOpts *opts, Error **errp)
> >  /***********************************************************/
> >  /* QEMU state */
> >  
> > -static RunState current_run_state = RUN_STATE_PRELAUNCH;
> > +static RunState current_run_state = RUN_STATE_PRECONFIG;
> >  
> >  /* We use RUN_STATE__MAX but any invalid value will do */
> >  static RunState vmstop_requested = RUN_STATE__MAX;
> > @@ -606,6 +606,9 @@ typedef struct {
> >  
> >  static const RunStateTransition runstate_transitions_def[] = {
> >      /*     from      ->     to      */
> > +    { RUN_STATE_PRECONFIG, RUN_STATE_PRELAUNCH },
> > +    { RUN_STATE_PRECONFIG, RUN_STATE_INMIGRATE },  
> 
> Don't this mean -preconfig and -incoming could work together?
theoretically yes, but its not the reason why this transition is here.
It's mimicking existing approach where initial state
   { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
were allowed to move to the next possible (including RUN_STATE_INMIGRATE)

> > +
> >      { RUN_STATE_DEBUG, RUN_STATE_RUNNING },
> >      { RUN_STATE_DEBUG, RUN_STATE_FINISH_MIGRATE },
> >      { RUN_STATE_DEBUG, RUN_STATE_PRELAUNCH },
> > @@ -1629,6 +1632,7 @@ static pid_t shutdown_pid;
> >  static int powerdown_requested;
> >  static int debug_requested;
> >  static int suspend_requested;
> > +static bool preconfig_exit_requested = true;
> >  static WakeupReason wakeup_reason;
> >  static NotifierList powerdown_notifiers =
> >      NOTIFIER_LIST_INITIALIZER(powerdown_notifiers);
> > @@ -1713,6 +1717,11 @@ static int qemu_debug_requested(void)
> >      return r;
> >  }
> >  
> > +void qemu_exit_preconfig_request(void)
> > +{
> > +    preconfig_exit_requested = true;
> > +}
> > +
> >  /*
> >   * Reset the VM. Issue an event unless @reason is SHUTDOWN_CAUSE_NONE.
> >   */
> > @@ -1886,6 +1895,13 @@ static bool main_loop_should_exit(void)
> >      RunState r;
> >      ShutdownCause request;
> >  
> > +    if (preconfig_exit_requested) {
> > +        if (runstate_check(RUN_STATE_PRECONFIG)) {  
> 
> Is it possible to have preconfig_exit_request set outside of
> RUN_STATE_PRECONFIG?  When and why?
preconfig_exit_requested is initialized with TRUE and
in combo with '-inmigrate' we need this runstate check.
it's the same as it was with
 { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
which I probably should remove (I need to check it though)

> > +            runstate_set(RUN_STATE_PRELAUNCH);
> > +        }
> > +        preconfig_exit_requested = false;
> > +        return true;
> > +    }
> >      if (qemu_debug_requested()) {
> >          vm_stop(RUN_STATE_DEBUG);
> >      }
> > @@ -3697,6 +3713,14 @@ int main(int argc, char **argv, char **envp)
> >                      exit(1);
> >                  }
> >                  break;
> > +            case QEMU_OPTION_preconfig:
> > +                if (runstate_check(RUN_STATE_INMIGRATE)) {
> > +                    error_report("option can not be used with "
> > +                                 "-incoming option");
> > +                    exit(EXIT_FAILURE);
> > +                }  
> 
> So -incoming changes runstate as soon as the option is parsed?
> 
> Ouch.
yep and it's rather fragile (it's well out of scope of
this series to re-factor this, so I'm not changing it here)

> I would rather not rely on that behavior and just do
> "if (incoming)".
> 
> Why exactly it's not possible to use -incoming with -preconfig?
there are 2 reasons why I made options mutually exclusive
1. (excuse ) '-incoming' is an option with non explicit side effects
   on other parts of code. It's hard to predict behavior
   of preconfig commands in combination with inmigrate.
   I wouldn't try to touch/change anything related to it
   in this series.
   If we need to change how option is handled, it should
   be separate series that focuses on it.
2. (main reason) is to expose as minimal interface
   as possible. It's easier to extend/modify it future if
   necessary than cut it down after it was introduced.

   Not counting [1], I don't see a reason to permit
   'preconfig' while migration is in progress.
   Configuration commands that where used during 'preconfig'
   stage on source side, should use corresponding CLI options
   on target side. (it's the same behavior as with hotplugged
   devices, keeping migration work-flow the same)

In short I'd prefer to keep restriction until there will be
a real usecase for combo to work together.

> > +                preconfig_exit_requested = false;
> > +                break;
> >              case QEMU_OPTION_enable_kvm:
> >                  olist = qemu_find_opts("machine");
> >                  qemu_opts_parse_noisily(olist, "accel=kvm", false);
> > @@ -3902,6 +3926,11 @@ int main(int argc, char **argv, char **envp)
> >                  }
> >                  break;
> >              case QEMU_OPTION_incoming:
> > +                if (!preconfig_exit_requested) {
> > +                    error_report("option can not be used with "
> > +                                 "-preconfig option");
> > +                    exit(EXIT_FAILURE);
> > +                }  
> 
> Instead of reimplementing the same check in two separate places,
> why not validate options and check for (incoming && preconfig)
> after the option parsing loop?
it could be done this way, but then we would lose specialized
error message.
Even though the way I did it, it is more code but that code
is close to related options and allows for specialized error
message in the order options are parsed.
Also it's easier to read as one doesn't have to jump around,
all error handling is in place where where an option is parsed.
But it's more style question, so if you prefer
(incoming && preconfig) approach I can easily switch to it
on respin.

> >                  if (!incoming) {
> >                      runstate_set(RUN_STATE_INMIGRATE);
> >                  }
> > @@ -4594,6 +4623,10 @@ int main(int argc, char **argv, char **envp)
> >      }
> >      parse_numa_opts(current_machine);
> >  
> > +    /* do monitor/qmp handling at preconfig state if requested */
> > +    main_loop();  
> 
> Wouldn't it be simpler to do "if (!preconfig) { main_loop(); }"
> instead of entering main_loop() just to exit immediately?
The thought didn't cross my mind, it might work and more readable
as one doesn't have to jump into main_loop() to find out that
it would exit immediately.
I'll try to it on respin.

> > +
> > +    /* from here on runstate is RUN_STATE_PRELAUNCH */
> >      machine_run_board_init(current_machine);
> >  
> >      realtime_init();
> > -- 
> > 2.7.4
> > 
> >   
> 
