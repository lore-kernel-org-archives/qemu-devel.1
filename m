Received: from eggs.gnu.org ([2001:4830:134:3::10]:59720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSQm4-0007KX-Qp
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSQm2-0006he-9C
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:38:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60326 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fSQm2-0006hS-3n
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:38:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A04884022905
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 17:38:33 +0000 (UTC)
Date: Mon, 11 Jun 2018 18:38:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180611173830.GN2661@work-vm>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<20180608130846.22234-4-dgilbert@redhat.com>
	<87bmchlmq1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bmchlmq1.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 3/7] hmp: Restrict auto-complete in
 preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:
> 
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Don't show the commands that aren't available.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  monitor.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/monitor.c b/monitor.c
> > index 31c8f5dc88..c369b392db 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -3951,12 +3951,17 @@ static void monitor_find_completion_by_table(Monitor *mon,
> >              cmdname = args[0];
> >          readline_set_completion_index(mon->rs, strlen(cmdname));
> >          for (cmd = cmd_table; cmd->name != NULL; cmd++) {
> > -            cmd_completion(mon, cmdname, cmd->name);
> > +            if (!runstate_check(RUN_STATE_PRECONFIG) ||
> > +                 cmd_can_preconfig(cmd)) {
> > +                cmd_completion(mon, cmdname, cmd->name);
> > +            }
> >          }
> >      } else {
> >          /* find the command */
> >          for (cmd = cmd_table; cmd->name != NULL; cmd++) {
> > -            if (compare_cmd(args[0], cmd->name)) {
> > +            if (compare_cmd(args[0], cmd->name) &&
> > +                (!runstate_check(RUN_STATE_PRECONFIG) ||
> > +                 cmd_can_preconfig(cmd))) {
> >                  break;
> >              }
> >          }
> 
> Hmm, I keep seeing
> 
>     !runstate_check(RUN_STATE_PRECONFIG) || cmd_can_preconfig(cmd)
> 
> Would a helper be worthwhile?  cmd_available(cmd)?

Yes, but I want to leave that change until I add the next flag (for OOB
some time) so I know how to generalise it;  I'm not sure what it'll need
yet.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
