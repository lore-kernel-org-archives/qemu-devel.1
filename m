Received: from eggs.gnu.org ([2001:4830:134:3::10]:53610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e47nl-00044w-Us
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e47nh-0007ka-21
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:59:38 -0400
Received: from 13.mo4.mail-out.ovh.net ([178.33.251.8]:36870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e47ng-0007jI-Og
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:59:32 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 47982E4201
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 17:59:30 +0200 (CEST)
Date: Mon, 16 Oct 2017 17:59:25 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171016175925.6600180b@bahia.lan>
In-Reply-To: <20171016163107.5d036fd0@nial.brq.redhat.com>
References: <150789527176.5487.14861721766357709655.stgit@bahia.lan>
	<20171016104139.5f7afa6c@nial.brq.redhat.com>
	<20171016132420.3accb7b4@bahia.lan>
	<20171016163107.5d036fd0@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] monitor: fix dangling CPU pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, 16 Oct 2017 16:31:07 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Mon, 16 Oct 2017 13:24:20 +0200
> Greg Kurz <groug@kaod.org> wrote:
> 
> > On Mon, 16 Oct 2017 10:41:39 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >   
> > > On Fri, 13 Oct 2017 13:47:51 +0200
> > > Greg Kurz <groug@kaod.org> wrote:
> > > 
> > > [...]
> > >     
> > > > Note that the resolution should really return a CPU object, otherwise
> > > > we have a bug. This is achieved by relying on object_resolve_path()
> > > > and CPU() instead of calling object_resolve_path_type(path, TYPE_CPU).      
> > > I'm not sure what you are trying to say here, could you explain
> > > a bit more why CPU(object_resolve_path()) is chosen vs
> > > object_resolve_path_type(path, TYPE_CPU)
> > >     
> > 
> > IIUC, if we use object_resolve_path_type(path, TYPE_CPU) and path doesn't
> > point to a CPU object, it will return NULL (see object_resolve_abs_path())
> > just like if the CPU got hot-unplugged.
> > 
> > My point is that the path we got from object_get_canonical_path() did
> > point to a CPU: if later on this path resolves to an object that isn't
> > a CPU, then some code somewhere used the same QOM path for some unrelated
> > object. I tend to think this is a bug in QEMU and we shouldn't silently
> > ignore it.  
> sometimes QOM path to a cpu object could be:
>  1. arbitrary if set explicitly by board 
>  2. /unattached/device[X] or /peripheral-anon/device[X]
>        potentially might end-up with another device at the same path
>        in case of hot-remove + migration
>  3. /peripheral
>        hot-remove named (i.e. non null 'id') cpu and then plug a non cpu device with the same 'id',
>        which is legitimate thing to do
> 

Ok, I didn't think of these cases...

> I'd use object_resolve_path_type(path, TYPE_CPU) and
> gracefully error out in case it returns NULL.
> 

I'll do that. Thanks for the detailed explanation.

> > Makes sense ?
> >   
> > >     
> > > > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---
> > > >  monitor.c |   25 ++++++++++++++++++++-----
> > > >  1 file changed, 20 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/monitor.c b/monitor.c
> > > > index fe0d1bdbb461..8489b2ad99c0 100644
> > > > --- a/monitor.c
> > > > +++ b/monitor.c
> > > > @@ -200,7 +200,7 @@ struct Monitor {
> > > >  
> > > >      ReadLineState *rs;
> > > >      MonitorQMP qmp;
> > > > -    CPUState *mon_cpu;
> > > > +    gchar *mon_cpu_path;
> > > >      BlockCompletionFunc *password_completion_cb;
> > > >      void *password_opaque;
> > > >      mon_cmd_t *cmd_table;
> > > > @@ -579,6 +579,7 @@ static void monitor_data_init(Monitor *mon)
> > > >  
> > > >  static void monitor_data_destroy(Monitor *mon)
> > > >  {
> > > > +    g_free(mon->mon_cpu_path);
> > > >      qemu_chr_fe_deinit(&mon->chr, false);
> > > >      if (monitor_is_qmp(mon)) {
> > > >          json_message_parser_destroy(&mon->qmp.parser);
> > > > @@ -1047,20 +1048,34 @@ int monitor_set_cpu(int cpu_index)
> > > >      if (cpu == NULL) {
> > > >          return -1;
> > > >      }
> > > > -    cur_mon->mon_cpu = cpu;
> > > > +    g_free(cur_mon->mon_cpu_path);
> > > > +    cur_mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
> > > >      return 0;
> > > >  }
> > > >  
> > > >  CPUState *mon_get_cpu(void)
> > > >  {
> > > > -    if (!cur_mon->mon_cpu) {
> > > > +    CPUState *cpu;
> > > > +
> > > > +    if (cur_mon->mon_cpu_path) {
> > > > +        Object *obj = object_resolve_path(cur_mon->mon_cpu_path, NULL);
> > > > +
> > > > +        if (!obj) {
> > > > +            g_free(cur_mon->mon_cpu_path);
> > > > +            cur_mon->mon_cpu_path = NULL;
> > > > +        } else {
> > > > +            cpu = CPU(obj);      
> > > this potentially might abort if obj couldn't be cast to TYPE_CPU
> > >     
> > 
> > This is deliberate... is there a case where cur_mon->mon_cpu_path would
> > legitimately point to something that isn't of type TYPE_CPU ?
> >   
> > >     
> > > > +        }
> > > > +    }
> > > > +    if (!cur_mon->mon_cpu_path) {
> > > >          if (!first_cpu) {
> > > >              return NULL;
> > > >          }
> > > >          monitor_set_cpu(first_cpu->cpu_index);
> > > > +        cpu = first_cpu;
> > > >      }
> > > > -    cpu_synchronize_state(cur_mon->mon_cpu);
> > > > -    return cur_mon->mon_cpu;
> > > > +    cpu_synchronize_state(cpu);
> > > > +    return cpu;
> > > >  }
> > > >  
> > > >  CPUArchState *mon_get_cpu_env(void)
> > > > 
> > > >       
> > >     
> > 
> >   
> 
