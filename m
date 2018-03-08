Received: from eggs.gnu.org ([2001:4830:134:3::10]:57867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1etxlS-0004vb-BF
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:47:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1etxlM-0000DP-9l
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:47:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34002 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1etxlM-0000CA-2E
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:47:24 -0500
Date: Thu, 8 Mar 2018 16:47:11 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180308164711.19c368a1@redhat.com>
In-Reply-To: <20180307140126.GB3090@work-vm>
References: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
	<1518784641-43151-5-git-send-email-imammedo@redhat.com>
	<20180307140126.GB3090@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/9] HMP: disable monitor in preconfig
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, ehabkost@redhat.com, cohuck@redhat.com, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Wed, 7 Mar 2018 14:01:27 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Igor Mammedov (imammedo@redhat.com) wrote:
> > Ban it for now, if someone would need it to work early,
> > one would have to implement checks if HMP command is valid
> > at preconfig state.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > ---
> >  monitor.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/monitor.c b/monitor.c
> > index f499250..fcb5386 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -3097,6 +3097,10 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
> >  
> >      trace_handle_hmp_command(mon, cmdline);
> >  
> > +    if (runstate_check(RUN_STATE_PRECONFIG)) {
> > +        monitor_printf(mon, "HMP not available in precofig state\n");
> > +    }  
> 
> But you've not returned, so the command will still get parsed?
yep, it's bug. I've already fixed in v4.
Plan to post simplified v4 this Friday if nothing goes south.

> 
> Dave
> 
> >      cmd = monitor_parse_command(mon, cmdline, &cmdline, mon->cmd_table);
> >      if (!cmd) {
> >          return;
> > -- 
> > 2.7.4
> > 
> >   
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
