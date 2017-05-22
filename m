Received: from eggs.gnu.org ([2001:4830:134:3::10]:45639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dCn5F-0008K6-T4
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dCn5E-0003UO-MQ
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:09:13 -0400
Date: Mon, 22 May 2017 10:09:00 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170522130900.GB18350@thinpad.lan.raisama.net>
References: <1495094971-177754-1-git-send-email-imammedo@redhat.com>
	<1495094971-177754-3-git-send-email-imammedo@redhat.com>
	<20170518185058.GP4748@thinpad.lan.raisama.net>
	<20170522090403.4b284345@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170522090403.4b284345@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] numa: move default mapping init to
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

On Mon, May 22, 2017 at 09:04:03AM +0200, Igor Mammedov wrote:
> On Thu, 18 May 2017 15:50:58 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> > On Thu, May 18, 2017 at 10:09:30AM +0200, Igor Mammedov wrote:
[...]
> > 
> > > +    default_mapping = !i; /* i == 0 : no explicit mapping provided by user */
> > > +
> > >      for (i = 0; i < possible_cpus->len; i++) {
> > >          const CPUArchId *cpu_slot = &possible_cpus->cpus[i];
> > >  
> > > -        /* at this point numa mappings are initilized by CLI options
> > > -         * or with default mappings so it's sufficient to list
> > > -         * all not yet mapped CPUs here */
> > > -        /* TODO: make it hard error in future */  
> > 
> > Did we change our mind about making it a hard error in the
> > future?
> nope, error message at the end of function says that partial mapping
> is obsoleted and will be removed. I've thought that's was sufficient
> reminder for us of what needs to be removed.

Yes, it is sufficient. I just didn't notice the message. :)

> I'll move TODO to:
> 
> +            } else {
> +                /* record slots with not set mapping */
> ++               /* TODO: make it hard error in future */ 
> +                char *cpu_str = cpu_slot_to_string(cpu_slot);
> +                g_string_append_printf(s, "%sCPU %d [%s]",

I don't mind removing the TODO comment, so it's up to you.

> 
> > 
> > >          if (!cpu_slot->props.has_node_id) {
> > > -            char *cpu_str = cpu_slot_to_string(cpu_slot);
> > > -            g_string_append_printf(s, "%sCPU %d [%s]", s->len ? ", " : "", i,
> > > -                                   cpu_str);
> > > -            g_free(cpu_str);
> > > +            if (default_mapping) {
> > > +                /* fetch default mapping from board and enable it */
> > > +                CpuInstanceProperties props = cpu_slot->props;
> > > +                props.has_node_id = true;
> > > +                machine_set_cpu_numa_node(machine, &props, &error_fatal);  
> > 
> > Is a machine_set_cpu_numa_node() call really necessary here, if
> > we are already looking at cpu_slot->props directly?
> yes, it's necessary as cpu_slot comes from:
>    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(machine);
> callback, which initializes machine::possible_cpus if necessary.
> 
> So cpu_slot is readonly and I'd prefer to keep mc->possible_cpu_arch_ids()
> returning 'const' as it's used by external callers and they shouldn't
> mess with possible_cpus content by accident.
> 
> usage of machine_set_cpu_numa_node() adds +2 more lines and it's
> proper/validating setter for node_id and will catch
> mistakes if we make them in the code.
> So I wouldn't use shortcuts here to save 2 lines.

Oh, I didn't notice cpu_slot was const. That's OK to me.

> 
>  
> > > +            } else {
> > > +                /* record slots with not set mapping */
> > > +                char *cpu_str = cpu_slot_to_string(cpu_slot);
> > > +                g_string_append_printf(s, "%sCPU %d [%s]",
> > > +                                       s->len ? ", " : "", i, cpu_str);
> > > +                g_free(cpu_str);
> > > +            }
> > >          }  
> > 
> > What about doing this instead:
> > 
> >         if (default_mapping) {
> >             /*
> >              * Default mapping was already set by board at
> >              * cpu_slot->props.node_id, just enable it
> >              */
> >             cpu_slot->props.has_node_id = true;
> >         } else if (!cpu_slot->props.has_node_id) {
> >             char *cpu_str = cpu_slot_to_string(cpu_slot);
> >             g_string_append_printf(s, "%sCPU %d [%s]", s->len ? ", " : "", i,
> >                                    cpu_str);
> >             g_free(cpu_str);
> >         }

-- 
Eduardo
