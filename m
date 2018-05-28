Received: from eggs.gnu.org ([2001:4830:134:3::10]:60681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fNEV7-0004Z9-BU
	for qemu-devel@nongnu.org; Mon, 28 May 2018 05:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fNEV3-0007Js-8y
	for qemu-devel@nongnu.org; Mon, 28 May 2018 05:31:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42280 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fNEV3-0007J4-3E
	for qemu-devel@nongnu.org; Mon, 28 May 2018 05:31:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0ADC040201A0
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 09:31:32 +0000 (UTC)
Date: Mon, 28 May 2018 11:31:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180528113130.20c2e6dc@redhat.com>
In-Reply-To: <20180525193934.GN8988@localhost.localdomain>
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
	<1525423069-61903-5-git-send-email-imammedo@redhat.com>
	<87h8mx11t9.fsf@dusky.pond.sub.org>
	<87lgc8zzpn.fsf@dusky.pond.sub.org>
	<20180524182634.GH8988@localhost.localdomain>
	<87603cxob9.fsf@dusky.pond.sub.org>
	<20180525193934.GN8988@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 04/11] hmp: disable monitor in preconfig
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, pkrempa@redhat.com, qemu-devel@nongnu.org

On Fri, 25 May 2018 16:39:34 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Fri, May 25, 2018 at 08:05:30AM +0200, Markus Armbruster wrote:
> > Eduardo Habkost <ehabkost@redhat.com> writes:
> >   
> > > On Thu, May 24, 2018 at 08:16:20PM +0200, Markus Armbruster wrote:  
> > >> Markus Armbruster <armbru@redhat.com> writes:
> > >>   
> > >> > Igor Mammedov <imammedo@redhat.com> writes:
> > >> >  
> > >> >> Ban it for now, if someone would need it to work early,
> > >> >> one would have to implement checks if HMP command is valid
> > >> >> at preconfig state.
> > >> >>
> > >> >> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > >> >> Reviewed-by: Eric Blake <eblake@redhat.com>
> > >> >> ---
> > >> >> v5:
> > >> >>   * add 'use QMP instead" to error message, suggesting user
> > >> >>     the right interface to use
> > >> >> v4:
> > >> >>   * v3 was only printing error but not preventing command execution,
> > >> >>     Fix it by returning after printing error message.
> > >> >>     ("Dr. David Alan Gilbert" <dgilbert@redhat.com>)
> > >> >> ---
> > >> >>  monitor.c | 6 ++++++
> > >> >>  1 file changed, 6 insertions(+)
> > >> >>
> > >> >> diff --git a/monitor.c b/monitor.c
> > >> >> index 39f8ee1..0ffdf1d 100644
> > >> >> --- a/monitor.c
> > >> >> +++ b/monitor.c
> > >> >> @@ -3374,6 +3374,12 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
> > >> >>  
> > >> >>      trace_handle_hmp_command(mon, cmdline);
> > >> >>  
> > >> >> +    if (runstate_check(RUN_STATE_PRECONFIG)) {
> > >> >> +        monitor_printf(mon, "HMP not available in preconfig state, "
> > >> >> +                            "use QMP instead\n");
> > >> >> +        return;
> > >> >> +    }
> > >> >> +
> > >> >>      cmd = monitor_parse_command(mon, cmdline, &cmdline, mon->cmd_table);
> > >> >>      if (!cmd) {
> > >> >>          return;  
> > >> >
> > >> > So we offer the user an HMP monitor, but we summarily fail all commands.
> > >> > I'm sorry, but that's... searching for polite word... embarrassing.  We
> > >> > should accept HMP output only when we're ready to accept it.  Yes, that
> > >> > would involve a bit more surgery rather than this cheap hack.  The whole
> > >> > preconfig thing smells like a cheap hack to me, but let's not overdo it.  
> > >> 
> > >> Clarification: I don't think we need to hold the series because of
> > >> this.  I do think you should investigate delaying HMP until it can work.  
> > >
> > > What would it mean to delay HMP?  Not creating the socket?
> > > Creating the socket but not accepting clients?  Accepting clients
> > > but not consuming any input from the socket until we are out of
> > > preconfig?
> > >
> > > I'm not sure if any of those options would be better.  If a human
> > > is already trying to talk on the other side, it seems better to
> > > show QEMU is alive (but not ready to hold a conversation yet)
> > > than staying silent.  
> > 
> > If this
> > 
> >     QEMU 2.12.50 monitor - type 'help' for more information
> >     (qemu) help
> >     HMP not available in preconfig state, use QMP instead
> >     (qemu) quit
> >     HMP not available in preconfig state, use QMP instead
> >     (qemu) let me out dammit
> >     HMP not available in preconfig state, use QMP instead
> >     (qemu) 
> > 
> > is better than the alternatives, then I wonder how much more
> > entertainment the alternatives could provide!
> > 
> > We *can* do better.  Start like this:
> > 
> >     QEMU 2.12.50 monitor is not ready with -preconfig until you complete
> >     configuration with QMP
> > 
> > and when we exit preconfig state, add:
> > 
> >     QEMU 2.12.50 monitor - type 'help' for more information
> >     (qemu) 
> > 
> > Note that this is upfront about the monitor not being ready, avoids
> > misleading the user about "help", talks to the user in the user's terms
> > (-preconfig) instead of internal terms (preconfig state), and is more
> > specific on how to ready the monitor.  
> 
> Yes, this sounds better than any of the options I have
> considered.
> 
> Making at least 'help', 'quit', and 'exit-preconfig' work might
> be even better, though.
I'll look into both options and try to come up a patch to make it better.
