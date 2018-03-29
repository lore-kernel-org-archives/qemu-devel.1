Received: from eggs.gnu.org ([2001:4830:134:3::10]:44386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1asD-0002l4-6p
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1asA-0005ZA-0B
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:58:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1as9-0005Yf-Hx
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:57:57 -0400
Date: Thu, 29 Mar 2018 13:57:54 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180329165754.GZ5046@localhost.localdomain>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-4-git-send-email-imammedo@redhat.com>
	<20180323212508.GF28161@localhost.localdomain>
	<20180327170541.295fc29a@redhat.com>
	<20180328191732.GQ5046@localhost.localdomain>
	<20180329150112.2e1d3030@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329150112.2e1d3030@redhat.com>
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

On Thu, Mar 29, 2018 at 03:01:12PM +0200, Igor Mammedov wrote:
> On Wed, 28 Mar 2018 16:17:32 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Tue, Mar 27, 2018 at 05:05:41PM +0200, Igor Mammedov wrote:
> > > On Fri, 23 Mar 2018 18:25:08 -0300
> > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >   
> > > > On Mon, Mar 12, 2018 at 02:11:09PM +0100, Igor Mammedov wrote:  
> > > [...]  
> > > > > diff --git a/vl.c b/vl.c
> > > > > index 3ef04ce..69b1997 100644
> > > > > --- a/vl.c
> > > > > +++ b/vl.c
> > > > > @@ -593,7 +593,7 @@ static int default_driver_check(void *opaque, QemuOpts *opts, Error **errp)
> > > > >  /***********************************************************/
> > > > >  /* QEMU state */
> > > > >  
> > > > > -static RunState current_run_state = RUN_STATE_PRELAUNCH;
> > > > > +static RunState current_run_state = RUN_STATE_PRECONFIG;
> > > > >  
> > > > >  /* We use RUN_STATE__MAX but any invalid value will do */
> > > > >  static RunState vmstop_requested = RUN_STATE__MAX;
> > > > > @@ -606,6 +606,9 @@ typedef struct {
> > > > >  
> > > > >  static const RunStateTransition runstate_transitions_def[] = {
> > > > >      /*     from      ->     to      */
> > > > > +    { RUN_STATE_PRECONFIG, RUN_STATE_PRELAUNCH },
> > > > > +    { RUN_STATE_PRECONFIG, RUN_STATE_INMIGRATE },    
> > > > 
> > > > Don't this mean -preconfig and -incoming could work together?  
> > > theoretically yes, but its not the reason why this transition is here.
> > > It's mimicking existing approach where initial state
> > >    { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
> > > were allowed to move to the next possible (including RUN_STATE_INMIGRATE)  
> > 
> > I still don't get it.  Where this definition of "next possible"
> > comes from?  If -incoming and -preconfig don't work together, why
> > is PRECONFIG -> INMIGRATE migration considered possible?
> I'd think it's the same (replacement) hack which we use now
>    RUN_STATE_PRELAUNCH -> RUN_STATE_INMIGRATE
> to allow following code to succeed:
> 
>       case QEMU_OPTION_incoming:
>       if (!incoming) {                                                 
>              runstate_set(RUN_STATE_INMIGRATE);                           
>       }                                                                
>       incoming = optarg;
>  
> I'd get rid of it and move state switching to the actual place
> where migration starts if it were just that simple, but from
> a quick look around it did look rather risky.
> That's why I abandoned an idea of changing it within this series.

Yeah, I now see that the initial state is PRECONFIG.

> 
> > > > >      { RUN_STATE_DEBUG, RUN_STATE_RUNNING },
> > > > >      { RUN_STATE_DEBUG, RUN_STATE_FINISH_MIGRATE },
> > > > >      { RUN_STATE_DEBUG, RUN_STATE_PRELAUNCH },
> > > > > @@ -1629,6 +1632,7 @@ static pid_t shutdown_pid;
> > > > >  static int powerdown_requested;
> > > > >  static int debug_requested;
> > > > >  static int suspend_requested;
> > > > > +static bool preconfig_exit_requested = true;
> > > > >  static WakeupReason wakeup_reason;
> > > > >  static NotifierList powerdown_notifiers =
> > > > >      NOTIFIER_LIST_INITIALIZER(powerdown_notifiers);
> > > > > @@ -1713,6 +1717,11 @@ static int qemu_debug_requested(void)
> > > > >      return r;
> > > > >  }
> > > > >  
> > > > > +void qemu_exit_preconfig_request(void)
> > > > > +{
> > > > > +    preconfig_exit_requested = true;
> > > > > +}
> > > > > +
> > > > >  /*
> > > > >   * Reset the VM. Issue an event unless @reason is SHUTDOWN_CAUSE_NONE.
> > > > >   */
> > > > > @@ -1886,6 +1895,13 @@ static bool main_loop_should_exit(void)
> > > > >      RunState r;
> > > > >      ShutdownCause request;
> > > > >  
> > > > > +    if (preconfig_exit_requested) {
> > > > > +        if (runstate_check(RUN_STATE_PRECONFIG)) {    
> > > > 
> > > > Is it possible to have preconfig_exit_request set outside of
> > > > RUN_STATE_PRECONFIG?  When and why?  
> > > preconfig_exit_requested is initialized with TRUE and
> > > in combo with '-inmigrate' we need this runstate check.  
> > 
> > I think this now makes sense to me.  It still looks confusing,
> > but I don't have a better suggestion right now.
> > 
> > Except...
> > 
> > Why exactly do you need to use main_loop() and
> > main_loop_should_exit() for the preconfig loop?  What about a
> > separate preconfig_loop() and preconfig_loop_should_exit()
> > function?
> that would duplicate main_loop() for practically no benefit at all,
> hence I'm reusing existing main_loop()/main_loop_should_exit()
> just by adding relevant exit condition. It also easier to read
> when state transitions are kept close to each other.

I wouldn't say that main_loop_should_exit() is easy to read, but
I understand that this is the existing style, so no objection.


> 
>  
> > > it's the same as it was with
> > >  { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
> > > which I probably should remove (I need to check it though)
> > >   
> > > > > +            runstate_set(RUN_STATE_PRELAUNCH);
> > > > > +        }
> > > > > +        preconfig_exit_requested = false;  
> > 
> > What happens if we don't set preconfig_exit_requested=false here?
> nothing should go wrong due to 'if (runstate_check(RUN_STATE_PRECONFIG))'
> condition. It's the same what qemu_reset_requested()/qemu_shutdown_requested()
> do with their respective request variables but not wrapped
> into a separate function as it's the only place it's used.
> 
>  
> > > > > +        return true;
> > > > > +    }
> > > > >      if (qemu_debug_requested()) {
> > > > >          vm_stop(RUN_STATE_DEBUG);
> > > > >      }
> > > > > @@ -3697,6 +3713,14 @@ int main(int argc, char **argv, char **envp)
> > > > >                      exit(1);
> > > > >                  }
> > > > >                  break;
> > > > > +            case QEMU_OPTION_preconfig:
> > > > > +                if (runstate_check(RUN_STATE_INMIGRATE)) {
> > > > > +                    error_report("option can not be used with "
> > > > > +                                 "-incoming option");
> > > > > +                    exit(EXIT_FAILURE);
> > > > > +                }    
> > > > 
> > > > So -incoming changes runstate as soon as the option is parsed?
> > > > 
> > > > Ouch.  
> > > yep and it's rather fragile (it's well out of scope of
> > > this series to re-factor this, so I'm not changing it here)
> > >   
> > > > I would rather not rely on that behavior and just do
> > > > "if (incoming)".
> > > > 
> > > > Why exactly it's not possible to use -incoming with -preconfig?  
> > > there are 2 reasons why I made options mutually exclusive
> > > 1. (excuse ) '-incoming' is an option with non explicit side effects
> > >    on other parts of code. It's hard to predict behavior
> > >    of preconfig commands in combination with inmigrate.
> > >    I wouldn't try to touch/change anything related to it
> > >    in this series.
> > >    If we need to change how option is handled, it should
> > >    be separate series that focuses on it.
> > > 2. (main reason) is to expose as minimal interface
> > >    as possible. It's easier to extend/modify it future if
> > >    necessary than cut it down after it was introduced.
> > > 
> > >    Not counting [1], I don't see a reason to permit
> > >    'preconfig' while migration is in progress.
> > >    Configuration commands that where used during 'preconfig'
> > >    stage on source side, should use corresponding CLI options
> > >    on target side. (it's the same behavior as with hotplugged
> > >    devices, keeping migration work-flow the same)
> > > 
> > > In short I'd prefer to keep restriction until there will be
> > > a real usecase for combo to work together.  
> > 
> > I understand the reasons, but I think we already have an
> > important use case: live-migrating a VM with non-trivial NUMA
> > config (that needs -preconfig).  Don't we?
> Not really,
> whatever we have configured on source side using -preconfig
> (discovering valid topology in process), we should be able
> to replicate using only CLI options on target since we
> already have all necessary values for it from source (it's
> certainly the case with this series set-numa-node command).
> 
> As for the future, I agree it would be much more flexible
> to allow both -preconfig and -incoming at the same time,
> so we could start target with empty CLI, and then feed it
> options from source. It would require audit/refactoring of
> INMIGRATE state and making 'all' current CLI options
> available via QMP interface.
> 
> But for now I'd prefer to keep using old way to start target.

Well, if management software developers tell us that -preconfig
will be already useful without -incoming support, I won't object.

But it would be very nice for management software if they can
simply assume that -preconfig and -incoming will work together
since the first version.  Can we have this as a goal for 2.13?


> 
> > > > > +                preconfig_exit_requested = false;
> > > > > +                break;
> > > > >              case QEMU_OPTION_enable_kvm:
> > > > >                  olist = qemu_find_opts("machine");
> > > > >                  qemu_opts_parse_noisily(olist, "accel=kvm", false);
> > > > > @@ -3902,6 +3926,11 @@ int main(int argc, char **argv, char **envp)
> > > > >                  }
> > > > >                  break;
> > > > >              case QEMU_OPTION_incoming:
> > > > > +                if (!preconfig_exit_requested) {
> > > > > +                    error_report("option can not be used with "
> > > > > +                                 "-preconfig option");
> > > > > +                    exit(EXIT_FAILURE);
> > > > > +                }    
> > > > 
> > > > Instead of reimplementing the same check in two separate places,
> > > > why not validate options and check for (incoming && preconfig)
> > > > after the option parsing loop?  
> > > it could be done this way, but then we would lose specialized
> > > error message.
> > > Even though the way I did it, it is more code but that code
> > > is close to related options and allows for specialized error
> > > message in the order options are parsed.  
> > 
> > What do you mean by specialized user message?  Both have exactly
> > the same information: "-incoming and -preconfig can't be used
> > together", just written in a different way.
> [...]
> > 
> > I agree with the argument that validation of config options
> > should be done all in the same place.  But I disagree that the
> > body of the option parsing loop is the right place for that.
> Ok, I'll move it out of loop as you suggested.
> 
> [...]
> 

-- 
Eduardo
