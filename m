Received: from eggs.gnu.org ([2001:4830:134:3::10]:51334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1Gdu-0001Rw-8T
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 15:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1Gdr-0008P0-3i
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 15:21:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1Gdq-0008Oj-Rd
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 15:21:51 -0400
Date: Wed, 28 Mar 2018 16:21:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180328192148.GR5046@localhost.localdomain>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-4-git-send-email-imammedo@redhat.com>
	<20180323212508.GF28161@localhost.localdomain>
	<20180327170541.295fc29a@redhat.com>
	<20180328134835.04f95535@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328134835.04f95535@redhat.com>
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
Cc: peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Wed, Mar 28, 2018 at 01:48:35PM +0200, Igor Mammedov wrote:
> On Tue, 27 Mar 2018 17:05:41 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Fri, 23 Mar 2018 18:25:08 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > 
> > > On Mon, Mar 12, 2018 at 02:11:09PM +0100, Igor Mammedov wrote:  
> > [...]
> [...]
> > > > @@ -1886,6 +1895,13 @@ static bool main_loop_should_exit(void)
> > > >      RunState r;
> > > >      ShutdownCause request;
> > > >  
> > > > +    if (preconfig_exit_requested) {
> > > > +        if (runstate_check(RUN_STATE_PRECONFIG)) {    
> > > 
> > > Is it possible to have preconfig_exit_request set outside of
> > > RUN_STATE_PRECONFIG?  When and why?  
> > preconfig_exit_requested is initialized with TRUE and
> > in combo with '-inmigrate' we need this runstate check.
> > it's the same as it was with
> >  { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
> > which I probably should remove (I need to check it though)
> [...]
> 
> > > > @@ -4594,6 +4623,10 @@ int main(int argc, char **argv, char **envp)
> > > >      }
> > > >      parse_numa_opts(current_machine);
> > > >  
> > > > +    /* do monitor/qmp handling at preconfig state if requested */
> > > > +    main_loop();    
> > > 
> > > Wouldn't it be simpler to do "if (!preconfig) { main_loop(); }"
> > > instead of entering main_loop() just to exit immediately?  
> > The thought didn't cross my mind, it might work and more readable
> > as one doesn't have to jump into main_loop() to find out that
> > it would exit immediately.
> > I'll try to it on respin.
> Well doing as suggested end ups more messy:
> 
>     @@static bool main_loop_should_exit(void)
>     ...
>     if (preconfig_exit_requested) {
>         runstate_set(RUN_STATE_PRELAUNCH);                                        
>         return true;
>     }
>    
>     @@main
>     /* do monitor/qmp handling at preconfig state if requested */
>     if (!preconfig_exit_requested) {
>         main_loop();
>     } else if (runstate_check(RUN_STATE_PRECONFIG)) {
>         runstate_set(RUN_STATE_PRELAUNCH);
>     }

This doesn't make sense to me.  Why would we enter
RUN_STATE_PRECONFIG state if -preconfig is not used at all?


>     preconfig_exit_requested = false;
>     ...
> 
> I'd prefer original v4 approach, where only main_loop_should_exit()
> has to deal with state transitions and book-keeping.

If the above is unavoidable, I agree.  But I still don't
understand we have to enter PRECONFIG state if the user didn't
specify -preconfig.

-- 
Eduardo
