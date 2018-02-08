Received: from eggs.gnu.org ([2001:4830:134:3::10]:57325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1ejmjv-0000tl-BP
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1ejmjs-0001SZ-7i
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:59:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49022 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lcapitulino@redhat.com>)
	id 1ejmjs-0001RB-1E
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:59:48 -0500
Date: Thu, 8 Feb 2018 08:59:30 -0500
From: Luiz Capitulino <lcapitulino@redhat.com>
Message-ID: <20180208085930.63c83bac@redhat.com>
In-Reply-To: <5cb72a0b-5ff0-42ab-d992-ccdd2a565cfa@linux.vnet.ibm.com>
References: <20180207175014.11157-1-lcapitulino@redhat.com>
	<20180207175014.11157-2-lcapitulino@redhat.com>
	<5cb72a0b-5ff0-42ab-d992-ccdd2a565cfa@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com, ehabkost@redhat.com, berrange@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu, 8 Feb 2018 08:41:31 +0100
Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:

> On 07.02.2018 18:50, Luiz Capitulino wrote:
> > The query-cpus command has an extremely serious side effect:
> > it always interrupt all running vCPUs so that they can run
> > ioctl calls. This can cause a huge performance degradation for
> > some workloads. And most of the information retrieved by the
> > ioctl calls are not even used by query-cpus.
> > 
> > This commit introduces a replacement for query-cpus called
> > query-cpus-fast, which has the following features:
> > 
> >  o Never interrupt vCPUs threads. query-cpus-fast only returns
> >    vCPU information maintained by QEMU itself, which should be
> >    sufficient for most management software needs
> > 
> >  o Make "halted" field optional: we only return it if the
> >    halted state is maintained by QEMU. But this also gives
> >    the option of dropping the field in the future (see below)
> > 
> >  o Drop irrelevant fields such as "current", "pc" and "arch"  
> I disagree that arch is irrelevant and would strongly suggest to keep
> arch and arch-specific fields. At least in the case of s390 there's a
> cpu_state field that can be obtained cheaply.

The arch name can be queried with query-target. The only other
arch field I'm dropping is pc, which should be considered debug
only if anything.

Also, if this need to query CPU registers increase, then we
probably should port 'info registers' to QMP. Otherwise, we'll
eventually run into the performance problem once again.

> [...]
> > diff --git a/cpus.c b/cpus.c
> > index 2cb0af9b22..3b68a8146c 100644
> > --- a/cpus.c
> > +++ b/cpus.c
> > @@ -2083,6 +2083,50 @@ CpuInfoList *qmp_query_cpus(Error **errp)
> >      return head;
> >  }
> > 
> > +/*
> > + * fast means: we NEVER interrupt vCPU threads to retrieve
> > + * information from KVM.
> > + */
> > +CpuInfo2List *qmp_query_cpus_fast(Error **errp)
> > +{
> > +    MachineState *ms = MACHINE(qdev_get_machine());
> > +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> > +    CpuInfo2List *head = NULL, *cur_item = NULL;
> > +    CPUState *cpu;
> > +
> > +    CPU_FOREACH(cpu) {
> > +        CpuInfo2List *info = g_malloc0(sizeof(*info));
> > +        info->value = g_malloc0(sizeof(*info->value));
> > +
> > +        info->value->cpu_index = cpu->cpu_index;
> > +        info->value->qom_path = object_get_canonical_path(OBJECT(cpu));
> > +        info->value->thread_id = cpu->thread_id;
> > +
> > +        info->value->has_props = !!mc->cpu_index_to_instance_props;
> > +        if (info->value->has_props) {
> > +            CpuInstanceProperties *props;
> > +            props = g_malloc0(sizeof(*props));
> > +            *props = mc->cpu_index_to_instance_props(ms, cpu->cpu_index);
> > +            info->value->props = props;
> > +        }
> > +
> > +        /* if in kernel irqchip is used, we don't have 'halted' */
> > +        info->value->has_halted = !kvm_irqchip_in_kernel();  
> This is definitely not true for s390. Externally observable CPU state
> changes are handled by QEMU there. We may still drop halted if we add a
> more appropriate arch-specific field.
> > +        if (info->value->has_halted) {
> > +            info->value->halted = cpu->halted;
> > +        }  
> [...]
> 
