Received: from eggs.gnu.org ([2001:4830:134:3::10]:39763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d6HpC-0004G9-AB
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d6HpB-0005oq-1L
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:33:46 -0400
Date: Thu, 4 May 2017 16:33:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170504163330.5b0c0c86@nial.brq.redhat.com>
In-Reply-To: <20170504131602.4v5pbh6t2skrjici@kamzik.brq.redhat.com>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-4-git-send-email-imammedo@redhat.com>
	<20170504093822.2u4p7z7qjcyorbto@kamzik.brq.redhat.com>
	<20170504145509.394ce832@nial.brq.redhat.com>
	<20170504131602.4v5pbh6t2skrjici@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/24] hw/arm/virt: use
 machine->possible_cpus for storing possible topology info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Thu, 4 May 2017 15:16:02 +0200
Andrew Jones <drjones@redhat.com> wrote:

> On Thu, May 04, 2017 at 02:55:09PM +0200, Igor Mammedov wrote:
> > On Thu, 4 May 2017 11:38:22 +0200
> > Andrew Jones <drjones@redhat.com> wrote:
> >   
> > > On Wed, May 03, 2017 at 02:56:57PM +0200, Igor Mammedov wrote:  
> > > > for now precalculate and store mp_afinity in possible_cpus
> > > > as ARM cpus don't have socket/core/thread-id properties yet.
> > > > In follow patches possible_cpus will be used for storing
> > > > and setting NUMA node mapping and replace legacy bitmap
> > > > based numa_info[node_id].node_cpu/numa_get_node_for_cpu()
> > > > 
> > > > For the lack of better idea, this patch cannibalizes
> > > > possible_cpus.cpus[x].props.thread_id so that
> > > > *_cpu_index_to_props() callback could return addressable
> > > > by props CPU which will be used by machine_set_cpu_numa_node()
> > > > in follow up patches to assign a CPU to node. But
> > > > cannibalizing is fine for now as that thread_id isn't exposed
> > > > to users (no hotpluggable_cpus callback support for ARM yet)
> > > > and it will be used only internally until 'device_add cpu'
> > > > is supported where we can decide on which properties to use.
> > > > 
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > ---
> > > > v2:
> > > >   (Drew)
> > > >     - discarding result of possible_cpu_arch_ids() makes
> > > >       call not obvious and is confusing. Instead assign
> > > >       possible_cpu_arch_ids() result to local var and use
> > > >       it instead of direct access to machine->possible_cpus
> > > >       field, as it's done in pc.c
> > > > ---
> > > >  hw/arm/virt.c | 40 +++++++++++++++++++++++++++++++++++++---
> > > >  1 file changed, 37 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > > index 61ae437..e2c5626 100644
> > > > --- a/hw/arm/virt.c
> > > > +++ b/hw/arm/virt.c
> > > > @@ -1221,6 +1221,8 @@ static void machvirt_init(MachineState *machine)
> > > >  {
> > > >      VirtMachineState *vms = VIRT_MACHINE(machine);
> > > >      VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(machine);
> > > > +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> > > > +    const CPUArchIdList *possible_cpus;
> > > >      qemu_irq pic[NUM_IRQS];
> > > >      MemoryRegion *sysmem = get_system_memory();
> > > >      MemoryRegion *secure_sysmem = NULL;
> > > > @@ -1344,10 +1346,16 @@ static void machvirt_init(MachineState *machine)
> > > >          exit(1);
> > > >      }
> > > >  
> > > > -    for (n = 0; n < smp_cpus; n++) {
> > > > -        Object *cpuobj = object_new(typename);
> > > > +    possible_cpus = mc->possible_cpu_arch_ids(machine);
> > > > +    for (n = 0; n < possible_cpus->len; n++) {
> > > > +        Object *cpuobj;
> > > >  
> > > > -        object_property_set_int(cpuobj, virt_cpu_mp_affinity(vms, n),
> > > > +        if (n >= smp_cpus) {
> > > > +            break;
> > > > +        }    
> > > 
> > > Why the break instead of just looping 'n < smp_cpus' like x86 does? Is
> > > there some future work where looping up to possible_cpus->len (aka
> > > max_cpus) is what we'll eventually want? If so, then we need a TODO
> > > comment here. If not, then we should clean this up by removing the break.  
> > There is no plans to loop here upto possible_cpus->len.
> > 
> > It seemed to me more consistent/safer to use index limited
> > by possible_cpus->len to index possible_cpus->cpus[n] array
> > than index limited by smp_cpus though the former currently is
> > always less than smp_cpus.  
>          ^ greater than or equal to
> > 
> > If you prefer 'n < smp_cpus' loop, then I can switch to it.  
> 
> I just don't like the 'if (n >= smp_cpus) { break; }' - the whole thing
> would look much nicer without it. And, if there's a valid concern that
> possible_cpus->len can be < smp_cpus, then we should check it in x86
> too. Anyway we can check both conditions in the 'for', which would
> look a bit more pleasing to me...
> 
>  for (n = 0; n < possible_cpus->len && n < smp_cpus; n++) {
nice, I'll do it this way on respin.

>      Object *cpuobj = object_new(typename);
>      object_property_set_int(cpuobj, possible_cpus->cpus[n].arch_id,
>                              "mp-affinity", NULL);
>      ...
> 
> All that said, it's just a nit in the end, so
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>
