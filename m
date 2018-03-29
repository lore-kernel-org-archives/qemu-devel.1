Received: from eggs.gnu.org ([2001:4830:134:3::10]:39059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f1Vxe-0005H1-Jn
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f1Vxb-0007YJ-CT
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:43:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47434 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1f1Vxb-0007Y6-6i
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:43:15 -0400
Date: Thu, 29 Mar 2018 13:43:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180329134303.548a864b@redhat.com>
In-Reply-To: <20180328192148.GR5046@localhost.localdomain>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-4-git-send-email-imammedo@redhat.com>
	<20180323212508.GF28161@localhost.localdomain>
	<20180327170541.295fc29a@redhat.com>
	<20180328134835.04f95535@redhat.com>
	<20180328192148.GR5046@localhost.localdomain>
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
Cc: peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Wed, 28 Mar 2018 16:21:48 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, Mar 28, 2018 at 01:48:35PM +0200, Igor Mammedov wrote:
> > On Tue, 27 Mar 2018 17:05:41 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >   
> > > On Fri, 23 Mar 2018 18:25:08 -0300
> > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >   
> > > > On Mon, Mar 12, 2018 at 02:11:09PM +0100, Igor Mammedov wrote:    
> > > [...]  
> > [...]  
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
> > > it's the same as it was with
> > >  { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
> > > which I probably should remove (I need to check it though)  
> > [...]
> >   
> > > > > @@ -4594,6 +4623,10 @@ int main(int argc, char **argv, char **envp)
> > > > >      }
> > > > >      parse_numa_opts(current_machine);
> > > > >  
> > > > > +    /* do monitor/qmp handling at preconfig state if requested */
> > > > > +    main_loop();      
> > > > 
> > > > Wouldn't it be simpler to do "if (!preconfig) { main_loop(); }"
> > > > instead of entering main_loop() just to exit immediately?    
> > > The thought didn't cross my mind, it might work and more readable
> > > as one doesn't have to jump into main_loop() to find out that
> > > it would exit immediately.
> > > I'll try to it on respin.  
> > Well doing as suggested end ups more messy:
> > 
> >     @@static bool main_loop_should_exit(void)
> >     ...
> >     if (preconfig_exit_requested) {
> >         runstate_set(RUN_STATE_PRELAUNCH);                                        
> >         return true;
> >     }
> >    
> >     @@main
> >     /* do monitor/qmp handling at preconfig state if requested */
> >     if (!preconfig_exit_requested) {
> >         main_loop();
> >     } else if (runstate_check(RUN_STATE_PRECONFIG)) {
> >         runstate_set(RUN_STATE_PRELAUNCH);
> >     }  
> 
> This doesn't make sense to me.  Why would we enter
> RUN_STATE_PRECONFIG state if -preconfig is not used at all?
because of RUN_STATE_PRECONFIG becomes new initial state of
our state machine where we start of (used to be RUN_STATE_PRELAUNCH)
Lets call it variant 1:

with this we have 2 possible transitions:
 RUN_STATE_PRECONFIG -> RUN_STATE_PRELAUNCH (machine_init)

and

 RUN_STATE_PRECONFIG -> RUN_STATE_INMIGRATE
   ugly but it was the same with RUN_STATE_PRELAUNCH initial transition

Another variant 2, in case we switch to RUN_STATE_PRECONFIG only on -preconfig
transitions would be
  RUN_STATE_PRELAUNCH -> RUN_STATE_PRECONFIG
    (allow switch from initial to -preconfig)

  RUN_STATE_PRECONFIG -> RUN_STATE_PRELAUNCH

while the last is valid transition, the 1st one isn't really
valid because of (beside of switching from initial state) it
allows bouncing back to RUN_STATE_PRECONFIG later.

If we consider only state machine transitions, I think it's
cleaner to start with variant 1 with the same
-inmigrate hack we already have (which potentially could
be fixed later), than allowing arbitrary bouncing to
RUN_STATE_PRECONFIG at later stage.

With this approach all processing before machine_init()
would run at RUN_STATE_PRECONFIG and then we would switch
to RUN_STATE_PRELAUNCH. Even though it is far reaching
goal but at least that's where we should be moving to
have sane initialization flow in vl.c

> >     preconfig_exit_requested = false;
> >     ...
> > 
> > I'd prefer original v4 approach, where only main_loop_should_exit()
> > has to deal with state transitions and book-keeping.  
> 
> If the above is unavoidable, I agree.  But I still don't
> understand we have to enter PRECONFIG state if the user didn't
> specify -preconfig.
> 
