Received: from eggs.gnu.org ([2001:4830:134:3::10]:59984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1er44H-0006Z1-UN
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1er44D-0003iI-2W
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:54:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39630 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1er44C-0003i0-T2
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:54:53 -0500
Date: Wed, 28 Feb 2018 16:54:44 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180228165444.3e74e083@redhat.com>
In-Reply-To: <ef81e2f1-1c6a-82ad-86fd-fab56ab92c78@redhat.com>
References: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
	<1518784641-43151-4-git-send-email-imammedo@redhat.com>
	<ef81e2f1-1c6a-82ad-86fd-fab56ab92c78@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/9] CLI: add -preconfig option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, ehabkost@redhat.com, cohuck@redhat.com, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Tue, 27 Feb 2018 14:39:22 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 02/16/2018 06:37 AM, Igor Mammedov wrote:
> > Option allows to pause QEMU at new RUN_STATE_PRECONFIG time,
> > which would allow to configure QEMU from QMP before machine
> > jumps into board initialization code machine_run_board_init().  
> 
> Grammar suggestion:
> 
> This option allows pausing QEMU in the new RUN_STATE_PRECONFIG state, 
> allowing the configuration of QEMU from QMP before the machine jumps 
> into board initialization code of machine_run_board_init().
> 
> > 
> > Intent is to allow management to query machine state and
> > additionally configure it using previous query results
> > within one QEMU instance (i.e. eliminate need to start QEMU
> > twice, 1st to query board specific parameters and 2nd for
> > for actual VM start using query result for additional
> > parameters).
> > 
> > Initially it's planned to be used for configuring numa
> > topology depending on cpu layout.  
> 
> It may be worth mentioning in the commit message how this differs from 
> -S, and what the QMP client must do to get the guest started in this 
> mode to enter the normal lifecycle that it used to have when using -S.
> 
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >   include/sysemu/sysemu.h |  1 +
> >   qapi/run-state.json     |  3 ++-
> >   qemu-options.hx         | 11 +++++++++++
> >   qmp.c                   |  5 +++++
> >   vl.c                    | 35 ++++++++++++++++++++++++++++++++++-
> >   5 files changed, 53 insertions(+), 2 deletions(-)
> >   
> 
> > +++ b/qapi/run-state.json
> > @@ -49,12 +49,13 @@
> >   # @colo: guest is paused to save/restore VM state under colo checkpoint,
> >   #        VM can not get into this state unless colo capability is enabled
> >   #        for migration. (since 2.8)
> > +# @preconfig: QEMU is paused before machine is created.  
> 
> Needs a '(since 2.12)' tag.  Probably also be worth mentioning that this 
> state is only visible for clients that pass the new CLI option.
> 
> > +++ b/qemu-options.hx
> > @@ -3283,6 +3283,17 @@ STEXI
> >   Run the emulation in single step mode.
> >   ETEXI
> >   
> > +DEF("preconfig", 0, QEMU_OPTION_preconfig, \
> > +    "-preconfig      pause QEMU before machine is initialized\n",
> > +    QEMU_ARCH_ALL)
> > +STEXI
> > +@item -preconfig
> > +@findex -preconfig
> > +Pause QEMU for interactive configuration before machine is created,
> > +which allows to query and configure properties affecting machine
> > +initialization. Use QMP command 'cont' to exit paused state.  
> 
> Pause QEMU for interactive configuration before the machine is created, 
> which allows querying and configuring properties that will affect 
> machine initialization.  Use the QMP command 'cont' to exit the 
> preconfig state.
Thanks,
I'll fix all of above on respin.

> Hmm - can you also transition from preconfig to the normal paused state 
> via 'stop', which you would do to emit other commands that you used to 
> issue between the older 'qemu -S' and the 'cont'?
Both -preconfig and -S could be used together on CLI to
achieve above effect, where 'cont' would transition state
to the next requested state (i.e. if -S specified QEMU will do
second pause where it used to do and if there is no -S on
CLI machine will start to execute guest code).

I'm not sure about suggested 'stop' behavior though,
wouldn't it be confusing since it would actually do
something beside pausing and from already paused state
at that?
I've opted for adding as little as possible of new behavior,
and 'cont' looked like a reasonable choice.
 
