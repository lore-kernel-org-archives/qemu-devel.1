Received: from eggs.gnu.org ([2001:4830:134:3::10]:39837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e5ZNM-0008NM-EB
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e5ZNJ-0001KR-3w
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:38:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e5ZNI-0001Ji-Qe
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:38:17 -0400
Date: Fri, 20 Oct 2017 13:38:12 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171020153812.GN2942@localhost.localdomain>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<1508170976-96869-5-git-send-email-imammedo@redhat.com>
	<20171016163515.GH11975@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016163515.GH11975@redhat.com>
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Mon, Oct 16, 2017 at 05:35:15PM +0100, Daniel P. Berrange wrote:
> On Mon, Oct 16, 2017 at 06:22:54PM +0200, Igor Mammedov wrote:
> 
> This really needs to have a commit message that provides justification
> for why this option is needed when we already have -S that is used
> to allow configuration before the guest starts.
> 
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

After discussing some ideas with David in this thread, I think
you have a really good point here: I don't see a reason why
set-numa-node should require anything except -S, except for the
way our machine initialization code work.  In other words, why
should we generate the NUMA tables at
machine_run_board_init()-time and not at vm_start()-time?

-- 
Eduardo
