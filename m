Received: from eggs.gnu.org ([2001:4830:134:3::10]:34626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSdLZ-0001au-Ob
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSdLQ-00059f-8H
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:04:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59788 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fSdLQ-00059L-0s
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:03:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59FF780125F1
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 07:03:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<20180608130846.22234-3-dgilbert@redhat.com>
	<87fu1tlmu8.fsf@dusky.pond.sub.org> <20180611102716.GB2661@work-vm>
	<874li9h36p.fsf@dusky.pond.sub.org> <20180611184943.GT2661@work-vm>
Date: Tue, 12 Jun 2018 09:03:48 +0200
In-Reply-To: <20180611184943.GT2661@work-vm> (David Alan Gilbert's message of
	"Mon, 11 Jun 2018 19:49:43 +0100")
Message-ID: <87wov4wkob.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/7] hmp: Allow help on preconfig
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, imammedo@redhat.com, qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>> 
>> > * Markus Armbruster (armbru@redhat.com) wrote:
>> >> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:
>> >> 
>> >> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> >> >
>> >> > Allow the 'help' command in preconfig state but
>> >> > make it only list the preconfig commands.
>> >> >
>> >> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> >> > Reviewed-by: Peter Xu <peterx@redhat.com>
>> >> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> >> > ---
>> >> >  hmp-commands.hx | 1 +
>> >> >  monitor.c       | 8 +++++++-
>> >> >  2 files changed, 8 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/hmp-commands.hx b/hmp-commands.hx
>> >> > index 0734fea931..8bf590ae4b 100644
>> >> > --- a/hmp-commands.hx
>> >> > +++ b/hmp-commands.hx
>> >> > @@ -15,6 +15,7 @@ ETEXI
>> >> >          .params     = "[cmd]",
>> >> >          .help       = "show the help",
>> >> >          .cmd        = do_help_cmd,
>> >> > +        .flags      = "p",
>> >> >      },
>> >> >  
>> >> >  STEXI
>> >> > diff --git a/monitor.c b/monitor.c
>> >> > index f4a16e6a03..31c8f5dc88 100644
>> >> > --- a/monitor.c
>> >> > +++ b/monitor.c
>> >> > @@ -957,6 +957,10 @@ static void help_cmd_dump_one(Monitor *mon,
>> >> >  {
>> >> >      int i;
>> >> >  
>> >> > +    if (runstate_check(RUN_STATE_PRECONFIG) && !cmd_can_preconfig(cmd)) {
>> >> > +        return;
>> >> > +    }
>> >> > +
>> >> >      for (i = 0; i < prefix_args_nb; i++) {
>> >> >          monitor_printf(mon, "%s ", prefix_args[i]);
>> >> >      }
>> >> > @@ -979,7 +983,9 @@ static void help_cmd_dump(Monitor *mon, const mon_cmd_t *cmds,
>> >> >  
>> >> >      /* Find one entry to dump */
>> >> >      for (cmd = cmds; cmd->name != NULL; cmd++) {
>> >> > -        if (compare_cmd(args[arg_index], cmd->name)) {
>> >> > +        if (compare_cmd(args[arg_index], cmd->name) &&
>> >> > +            ((!runstate_check(RUN_STATE_PRECONFIG) ||
>> >> > +                cmd_can_preconfig(cmd)))) {
>> >> 
>> >> Why do we need this check in addition to the one in help_cmd_dump_one()?
>> >
>> > To gate entire subtables (we've only currently got 'info' and that's enabled,
>> > anyway, so it never actually triggers).
>> 
>> Something's bothering me around here, but I can't put a finger on it...
>> let me think aloud.
>> 
>> There's an asymmetry between command execution and help.  The former has
>> just one check, in monitor_parse_command().  If the command has a
>> sub-table, and there are arguments, monitor_parse_command() recurses
>> into the sub-table.  Thus, if the command is unavailable, the
>> sub-commands are unavailable as well, regardless of their "p" flags.
>> 
>> Help's recursion is different.  It's limited to two levels, unlike
>> execution.  help_cmd_dump_one()'s check applies to the last level.
>> help_cmd_dump()'s check applies to the first level.  If there's just one
>> level, we check twice.  Perhaps less than elegant, but harmless and
>> simple.
>> 
>> You can't make a sub-command available without also making the command
>> available.  Makes sense, I guess.  If you try, your "p" flags on the
>> sub-commands are silently ignored.  That's a bit ugly, but if it doesn't
>> bother you, I can pretend I didn't see it ;)
>
> Yes I'm OK with that; you've got to enable all the way down to the
> command that youw ant to enable.
>
> I think the difference between execution and help comes from the
> way you can do 'help' on it's own to list everything, and help
> on a subtable (help info) and help on a command (help info uuid);
> I think that's why the recursion gets a bit hairier.

Well, you can execute the command on its own (info), and a sub-command
(info uuid) --- same structure.  Anyway, what we have works.
