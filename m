Received: from eggs.gnu.org ([2001:4830:134:3::10]:47093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gaFqa-00065l-DT
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 03:07:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gaFqV-0003ES-Gh
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 03:07:52 -0500
Received: from mail.ispras.ru ([83.149.199.45]:54730)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gaFqV-0003DK-2Z
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 03:07:47 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20181218112056.11727.96529.stgit@pasha-VirtualBox>	<20181218112154.11727.4557.stgit@pasha-VirtualBox>
	<87y38lit4n.fsf@dusky.pond.sub.org>
In-Reply-To: <87y38lit4n.fsf@dusky.pond.sub.org>
Date: Fri, 21 Dec 2018 11:07:49 +0300
Message-ID: <002a01d49904$43f86c20$cbe94460$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v8 10/20] replay: introduce info hmp/qmp
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Markus Armbruster' <armbru@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com, quintela@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net

> From: Markus Armbruster [mailto:armbru@redhat.com]
> Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:
> 
> > This patch introduces 'info replay' monitor command and
> > corresponding qmp request.
> > These commands request the current record/replay mode, replay log file name,
> > and the execution step (number or recorded/replayed instructions).
> > User may use step number for replay_seek/replay_break commands and
> > for controlling the execution of replay.
> >
> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> > Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
> > --
> >
> > v2:
> >  - renamed info_replay qmp into query-replay (suggested by Eric Blake)
> > v7:
> >  - added empty line (suggested by Markus Armbruster)
> > ---
> >  hmp-commands-info.hx      |   14 ++++++++++++++
> >  hmp.h                     |    1 +
> >  qapi/misc.json            |   35 +++++++++++++++++++++++++++++++++++
> >  replay/Makefile.objs      |    3 ++-
> >  replay/replay-debugging.c |   42 ++++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 94 insertions(+), 1 deletion(-)
> >  create mode 100644 replay/replay-debugging.c
> >
> > diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> > index cbee8b9..9f2f35e 100644
> > --- a/hmp-commands-info.hx
> > +++ b/hmp-commands-info.hx
> > @@ -918,6 +918,20 @@ STEXI
> >  Show SEV information.
> >  ETEXI
> >
> > +    {
> > +        .name       = "replay",
> > +        .args_type  = "",
> > +        .params     = "",
> > +        .help       = "show parameters of the record/replay",
> > +        .cmd        = hmp_info_replay,
> > +    },
> > +
> > +STEXI
> > +@item info replay
> > +@findex info replay
> > +Display the current record/replay mode and the currently executing step.
> > +ETEXI
> > +
> >  STEXI
> >  @end table
> >  ETEXI
> > diff --git a/hmp.h b/hmp.h
> > index 5f1addc..d792149 100644
> > --- a/hmp.h
> > +++ b/hmp.h
> > @@ -148,5 +148,6 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
> >  void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
> >  void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
> >  void hmp_info_sev(Monitor *mon, const QDict *qdict);
> > +void hmp_info_replay(Monitor *mon, const QDict *qdict);
> >
> >  #endif
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index 8325e0d..e47aea6 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -3113,6 +3113,41 @@
> >    'data': [ 'none', 'record', 'play' ] }
> >
> >  ##
> > +# @ReplayInfo:
> > +#
> > +# Status of the record/replay mode.
> > +#
> > +# @mode: current mode.
> > +#
> > +# @filename: name of the record/replay log file.
> > +#
> > +# @step: current step number.
> > +#
> > +# Since: 4.0
> > +#
> > +##
> > +{ 'struct': 'ReplayInfo',
> > +  'data': { 'mode': 'ReplayMode', '*filename': 'str', 'step': 'int' } }
> 
> @filename is optional.  For each ReplayMode: is @filename always absent,
> always present, or can it be either?
> 
> > +
> > +##
> > +# @query-replay:
> > +#
> > +# Retrieves the status of the execution record/replay.
> > +#
> > +# Returns: structure with the properties of the record/replay.
> 
> You've used "parameters of the record/replay" (in HMP help info),
> "status of the record/replay mode" (QMP ReplayInfo doc), "the status of
> the execution record/replay" (QMP query-replay doc), and "structure with
> the properties of the record/replay".  Please pick one.  I think I'd
> pick "record/replay information".
> 
> In my (superficial) review of v6, I asked what a client would do with
> @step.  You gave two use cases:
> 
>  1. Control current step to be sure that replay is not stalled due to the bug.
>  2. Requesting the step for some moment of execution to use it as a parameter
>     of replay_seek/replay_break operations. I.e., for returning to the same
>     point later.
> 
> The first one is a bit vague.  The second one sounds plausible enough to
> me at least for stopped VMs (for running VMs, it feels too imprecise to
> be useful, but what do I know).  replay-break is in PATCH 11,
> replay-seek in PATCH 12.  Would it make sense add a suitable reference
> to ReplayInfo's documentation then?

Thanks for reviewing, I'll update this in the next version.

Pavel Dovgalyuk
