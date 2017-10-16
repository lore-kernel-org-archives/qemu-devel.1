Received: from eggs.gnu.org ([2001:4830:134:3::10]:60844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e40Qo-0001Bz-Lg
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e40Ql-0004xi-Gp
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:07:26 -0400
Date: Mon, 16 Oct 2017 10:07:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171016100718.1ec98df6@nial.brq.redhat.com>
In-Reply-To: <20171013120546.7a89eeaf@bahia.lan>
References: <150788370618.25736.8030708425923435364.stgit@bahia>
	<150788373123.25736.7359515819699182906.stgit@bahia>
	<20171013112459.0082e823@nial.brq.redhat.com>
	<20171013120546.7a89eeaf@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] monitor: add proper reference counting
 of the current CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Fri, 13 Oct 2017 12:05:46 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Fri, 13 Oct 2017 11:24:59 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Fri, 13 Oct 2017 10:35:31 +0200
> > Greg Kurz <groug@kaod.org> wrote:
> >   
> > > If a CPU selected with the "cpu" command is hot-unplugged then "info cpus"
> > > causes QEMU to exit:
> > > 
> > > (qemu) device_del cpu1
> > > (qemu) info cpus
> > > qemu:qemu_cpu_kick_thread: No such process
> > > 
> > > This happens because "cpu" stores the pointer to the selected CPU into
> > > the monitor structure. When the CPU is hot-unplugged, we end up with a
> > > dangling pointer. The "info cpus" command then does:
> > > 
> > > hmp_info_cpus()
> > >  monitor_get_cpu_index()
> > >   mon_get_cpu()
> > >    cpu_synchronize_state() <--- called with dangling pointer
> > > 
> > > This could cause a QEMU crash as well.
> > > 
> > > This patch switches the monitor to use object_ref() to ensure the
> > > CPU object doesn't vanish unexpectedly. The reference is dropped
> > > either when "cpu" is used to switch to another CPU, or when the
> > > selected CPU is unrealized and cpu_list_remove() sets its cpu_index
> > > back to UNASSIGNED_CPU_INDEX.    
> > I don't really like an idea of leaving dangling cpu around.
> > Is it possible to store QOM path on set_cpu in monitor and
> > resolving it each to instance each time it's needed?
> >   
> 
> It sounds workable. Also it would allow the fix to not depend on patch 1
> for ppc.
yep,
also if you'd touch these cpu_index based monitor commands,
it might make sense to convert them to use qmo path directly
instead if cpu_index (with command completion it would be
easy to use)


> 
> Thanks for the suggestion!
> 
> >   
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  monitor.c |   12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/monitor.c b/monitor.c
> > > index fe0d1bdbb461..1c0b9a2c3ad3 100644
> > > --- a/monitor.c
> > > +++ b/monitor.c
> > > @@ -579,6 +579,9 @@ static void monitor_data_init(Monitor *mon)
> > >  
> > >  static void monitor_data_destroy(Monitor *mon)
> > >  {
> > > +    if (mon->mon_cpu) {
> > > +        object_unref((Object *) mon->mon_cpu);
> > > +    }
> > >      qemu_chr_fe_deinit(&mon->chr, false);
> > >      if (monitor_is_qmp(mon)) {
> > >          json_message_parser_destroy(&mon->qmp.parser);
> > > @@ -1047,12 +1050,21 @@ int monitor_set_cpu(int cpu_index)
> > >      if (cpu == NULL) {
> > >          return -1;
> > >      }
> > > +    if (cur_mon->mon_cpu) {
> > > +        object_unref((Object *) cur_mon->mon_cpu);
> > > +    }
> > >      cur_mon->mon_cpu = cpu;
> > > +    object_ref((Object *) cpu);
> > >      return 0;
> > >  }
> > >  
> > >  CPUState *mon_get_cpu(void)
> > >  {
> > > +    if (cur_mon->mon_cpu &&
> > > +        cur_mon->mon_cpu->cpu_index == UNASSIGNED_CPU_INDEX) {
> > > +        object_unref((Object *) cur_mon->mon_cpu);
> > > +        cur_mon->mon_cpu = NULL;
> > > +    }
> > >      if (!cur_mon->mon_cpu) {
> > >          if (!first_cpu) {
> > >              return NULL;
> > > 
> > >     
> >   
> 
