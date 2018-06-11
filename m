Received: from eggs.gnu.org ([2001:4830:134:3::10]:59441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSQks-0006bd-E8
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSQkp-0006Co-Qn
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:37:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60314 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fSQkp-0006Ce-L3
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:37:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E3DF4023131
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 17:37:19 +0000 (UTC)
Date: Mon, 11 Jun 2018 18:37:15 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180611173715.GM2661@work-vm>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<20180608130846.22234-2-dgilbert@redhat.com>
	<87k1r5lnbl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1r5lnbl.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 1/7] hmp: Add flag for preconfig commands
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
> > Add a flag to command definitions to allow them to be used in preconfig
> > and check it.
> > If users try to use commands that aren't available, tell them to use
> > the exit_preconfig comand we're adding in a few patches.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  monitor.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/monitor.c b/monitor.c
> > index 6d0cec552e..f4a16e6a03 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -128,6 +128,7 @@ typedef struct mon_cmd_t {
> >      const char *args_type;
> >      const char *params;
> >      const char *help;
> > +    const char *flags; /* p=preconfig */
> 
> I'd add a bool for each flag instead of encoding them in a string.  No
> need for a comment then (yours is cryptic).  But your artistic license
> applies.

It's a lot smaller change using the string, so simplicity won.

> >      void (*cmd)(Monitor *mon, const QDict *qdict);
> >      /* @sub_table is a list of 2nd level of commands. If it does not exist,
> >       * cmd should be used. If it exists, sub_table[?].cmd should be
> > @@ -936,6 +937,19 @@ static int parse_cmdline(const char *cmdline,
> >      return -1;
> >  }
> >  
> > +/*
> > + * Returns true if the command can be executed in preconfig mode
> > + * i.e. it has the 'p' flag.
> > + */
> > +static bool cmd_can_preconfig(const mon_cmd_t *cmd)
> > +{
> > +    if (!cmd->flags) {
> > +        return false;
> > +    }
> > +
> > +    return strchr(cmd->flags, 'p');
> > +}
> > +
> >  static void help_cmd_dump_one(Monitor *mon,
> >                                const mon_cmd_t *cmd,
> >                                char **prefix_args,
> > @@ -2976,6 +2990,12 @@ static const mon_cmd_t *monitor_parse_command(Monitor *mon,
> >                         (int)(p - cmdp_start), cmdp_start);
> >          return NULL;
> >      }
> > +    if (runstate_check(RUN_STATE_PRECONFIG) && !cmd_can_preconfig(cmd)) {
> > +        monitor_printf(mon, "Command '%.*s' not available with -preconfig; "
> > +                            "use exit_preconfig after configuration.\n",
> > +                       (int)(p - cmdp_start), cmdp_start);
> > +        return NULL;
> > +    }
> >  
> >      /* filter out following useless space */
> >      while (qemu_isspace(*p)) {
> 
> Suggest "not available with -preconfig until after exit_preconfig".

Done.

> Regardless,
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
