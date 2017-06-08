Received: from eggs.gnu.org ([2001:4830:134:3::10]:42935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dIq9r-00013C-D6
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 01:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dIq9m-0001sZ-7s
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 01:38:59 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1dIq9m-0001rr-1u
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 01:38:54 -0400
Received: by mail-pg0-x243.google.com with SMTP id f127so3463618pgc.2
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 22:38:52 -0700 (PDT)
Message-ID: <1496900327.2261.1.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu, 08 Jun 2017 15:38:47 +1000
In-Reply-To: <20170607191638.GG2384@work-vm>
References: <20170605004701.31891-1-sjitindarsingh@gmail.com>
	<20170607191638.GG2384@work-vm>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] monitor: Add -a (all) option to info
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

On Wed, 2017-06-07 at 20:16 +0100, Dr. David Alan Gilbert wrote:
> * Suraj Jitindar Singh (sjitindarsingh@gmail.com) wrote:
> > The info registers command in the qemu monitor is used to dump
> > register
> > values.
> > 
> > Currently this command uses the monitor cpu (which can be set by
> > the
> > user) as the cpu for whose registers will be dumped. Sometimes it
> > is
> > useful to see the registers for all cpus and currently this
> > requires
> > setting the monitor cpu and the re-running the command for each cpu
> > in the system. I would be nice if there was an easier way to do
> > this.
> > 
> > Add the "-a" option to the info registers command to dump the
> > register
> > values for all cpus.
> > 
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> 
> Hi Suraj,
>   That looks pretty good, one minor suggestion below

Thanks, V2 to come :)

> 
> > ---
> >  hmp-commands-info.hx |  6 +++---
> >  monitor.c            | 20 +++++++++++++++-----
> >  2 files changed, 18 insertions(+), 8 deletions(-)
> > 
> > diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> > index ae16901..ba98e58 100644
> > --- a/hmp-commands-info.hx
> > +++ b/hmp-commands-info.hx
> > @@ -100,9 +100,9 @@ ETEXI
> >  
> >      {
> >          .name       = "registers",
> > -        .args_type  = "",
> > -        .params     = "",
> > -        .help       = "show the cpu registers",
> > +        .args_type  = "cpustate_all:-a",
> > +        .params     = "[-a]",
> > +        .help       = "show the cpu registers (-a: all - show
> > register info for all cpus)",
> >          .cmd        = hmp_info_registers,
> >      },
> >  
> > diff --git a/monitor.c b/monitor.c
> > index baa73c9..5875f88 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -1078,13 +1078,23 @@ int monitor_get_cpu_index(void)
> >  
> >  static void hmp_info_registers(Monitor *mon, const QDict *qdict)
> >  {
> > -    CPUState *cs = mon_get_cpu();
> > +    bool all_cpus = qdict_get_try_bool(qdict, "cpustate_all",
> > false);
> > +    CPUState *cs;
> >  
> > -    if (!cs) {
> > -        monitor_printf(mon, "No CPU available\n");
> > -        return;
> > +    if (all_cpus) {
> > +        CPU_FOREACH(cs) {
> 
> Could we add a monitor_printf here giving the CPU number ?
> It would just make it a little easier when you have big list of CPUs
> and each has lots of registers to be able to see which one you're
> looking at.

Good idea, I never noticed because the CPU# is in the powerpc cpu dump
anyway.

I'll add it and send a V2.

> 
> 
> Thanks,
> 
> Dave
> 
> > +            cpu_dump_state(cs, (FILE *)mon, monitor_fprintf,
> > CPU_DUMP_FPU);
> > +        }
> > +    } else {
> > +        cs = mon_get_cpu();
> > +
> > +        if (!cs) {
> > +            monitor_printf(mon, "No CPU available\n");
> > +            return;
> > +        }
> > +
> > +        cpu_dump_state(cs, (FILE *)mon, monitor_fprintf,
> > CPU_DUMP_FPU);
> >      }
> > -    cpu_dump_state(cs, (FILE *)mon, monitor_fprintf,
> > CPU_DUMP_FPU);
> >  }
> >  
> >  static void hmp_info_jit(Monitor *mon, const QDict *qdict)
> > -- 
> > 2.9.4
> 
> Dave
> 
> > 
> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
