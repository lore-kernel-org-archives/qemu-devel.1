Received: from eggs.gnu.org ([2001:4830:134:3::10]:38776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dFJ7O-0002g8-Rc
	for qemu-devel@nongnu.org; Mon, 29 May 2017 07:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dFJ7N-0002YJ-6Q
	for qemu-devel@nongnu.org; Mon, 29 May 2017 07:45:50 -0400
Date: Mon, 29 May 2017 13:45:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170529134536.6a558835@nial.brq.redhat.com>
In-Reply-To: <20170526160630.GT32274@thinpad.lan.raisama.net>
References: <1495550330-34087-1-git-send-email-imammedo@redhat.com>
	<1495550330-34087-4-git-send-email-imammedo@redhat.com>
	<20170526160630.GT32274@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/5] numa: make sure that all cpus in
 has has_node_id set if numa is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Andrew Jones <drjones@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Fri, 26 May 2017 13:06:30 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, May 23, 2017 at 04:38:48PM +0200, Igor Mammedov wrote:
> > It fixes/add missing _PXM object for non mapped CPU (x86)
> > and missing fdt node (virt-arm).
> > 
> > It ensures that possible_cpus contains complete mapping if
> > numa is enabled by the time machine_init() is executed.
> > 
> > As result non completely mapped CPUs:
> >  1) appear in ACPI/fdt blobs
> >  2) QMP query-hotpluggable-cpus command shows bound nodes for such CPUs
> >  3) allows to drop checks for has_node_id in numa only code,
> >    reducing number of invariants incomplete mapping could produce
> >  4) moves fixup/implicit node init from runtime numa_cpu_pre_plug()
> >    (when CPU object is created) to machine_numa_finish_init() which
> >    helps to fix [1, 2] and make possible_cpus complete source
> >    of numa mapping available even before CPUs are created.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> Code that will be affected, but will keep the same behavior:
> 
> * pre_plug handler when node-id is omitted on device_add: it
>   already sets node_id=0 if !has_node_id
>   * However, pre_plug behavior is being changed when node-id is
>     set. See below.
> * build_srat() (both x86 and arm): already sets node_id = 0 if
>   !has_node_id
> * bochs_bios_init(): already uses g_new0(), so already had
>   omitted entries set to 0.
> 
> Affected code that will change behavior with this patch:
> 
> * pre_plug handler when node-id is set:
>   * See my reply to patch 1/5.  This patch restores the old
>     behavior that rejected node-id != 0 on omitted CPUs.
I'll look into it.

> * ACPI _PXM initialization
> * arm/virt.c: numa-node-id will now be set for all CPUs
> * QMP/HMP query-hotpluggable-cpus output
>   * Desirable change, as now the QMP command will reflect what
>     the guest is really seeing
> 
> Due to the _PXM and FDT changes, I have the same objection I have
> for patch 4/5: if we are going to break user expectations when
> using incomplete NUMA mappings, let's do that only once (when we
> start rejecting incomplete NUMA mappings).

FDT/PXM change is bugfix to firmware that I insist on.
Firmware should properly describe all CPUs instead of repeating
partial CPU mapping nonsense.

Wrt _PXM change see
(27111931 acpi: provide _PXM method for CPU devices if QEMU is started numa enabled)
provided we keep 0 node fallback by dropping 4/5
linux guest will behave the same as without _PXM.

And again there wasn't any compat code around that
and guest saw node-id change when it's been restarted.

Wrt FDT change, it's the same and I also talked with
Drew about it, his reply was that for ARM target
they don't care much about NUMA as not all pieces are
there to make pinning work on host side yet.

PS:
There wasn't any promise made to keep firmware side
bug compatible or versioned so users should not have
expectations about it in the first place.

Pls don't push for bug compat stuff in the firmware
as it will rise false expectations (at least until
we decide to care about it by default).

(I'd use firmware compat stuff only in cases where
it breaks guest horribly, i.e. crash/fail boot)


> A few extra comments about the has_node_id checks below:
> 
> > ---
> >  hw/arm/virt-acpi-build.c |  4 +---
> >  hw/core/machine.c        | 16 ++++++++++------
> >  hw/i386/acpi-build.c     |  3 +--
> >  hw/i386/pc.c             |  4 +---
> >  numa.c                   |  7 +------
> >  5 files changed, 14 insertions(+), 20 deletions(-)
> > 
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index e585206..977a794 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -496,12 +496,10 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >      srat->reserved1 = cpu_to_le32(1);
> >  
> >      for (i = 0; i < cpu_list->len; ++i) {
> > -        int node_id = cpu_list->cpus[i].props.has_node_id ?
> > -            cpu_list->cpus[i].props.node_id : 0;
> >          core = acpi_data_push(table_data, sizeof(*core));
> >          core->type = ACPI_SRAT_PROCESSOR_GICC;
> >          core->length = sizeof(*core);
> > -        core->proximity = cpu_to_le32(node_id);
> > +        core->proximity = cpu_to_le32(cpu_list->cpus[i].props.node_id);
> >          core->acpi_processor_uid = cpu_to_le32(i);
> >          core->flags = cpu_to_le32(1);
> >      }
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index aaf3cff..964b75d 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -720,19 +720,23 @@ static void machine_numa_finish_init(MachineState *machine)
> >          const CPUArchId *cpu_slot = &possible_cpus->cpus[i];
> >  
> >          if (!cpu_slot->props.has_node_id) {
> > -            if (default_mapping) {
> > -                /* fetch default mapping from board and enable it */
> > -                CpuInstanceProperties props = cpu_slot->props;
> > -                props.has_node_id = true;
> > -                machine_set_cpu_numa_node(machine, &props, &error_fatal);
> > -            } else {
> > +            /* fetch default mapping from board and enable it */
> > +            CpuInstanceProperties props = cpu_slot->props;
> > +
> > +            if (!default_mapping) {
> >                  /* record slots with not set mapping,
> >                   * TODO: make it hard error in future */
> >                  char *cpu_str = cpu_slot_to_string(cpu_slot);
> >                  g_string_append_printf(s, "%sCPU %d [%s]",
> >                                         s->len ? ", " : "", i, cpu_str);
> >                  g_free(cpu_str);
> > +
> > +                /* non mapped cpus used to fallback to node 0 */
> > +                props.node_id = 0;
> >              }
> > +
> > +            props.has_node_id = true;
> > +            machine_set_cpu_numa_node(machine, &props, &error_fatal);
> >          }
> >      }
> >      if (s->len) {
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index afcadac..873880d 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -2335,8 +2335,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
> >      srat->reserved1 = cpu_to_le32(1);
> >  
> >      for (i = 0; i < apic_ids->len; i++) {
> > -        int node_id = apic_ids->cpus[i].props.has_node_id ?
> > -            apic_ids->cpus[i].props.node_id : 0;
> > +        int node_id = apic_ids->cpus[i].props.node_id;  
> 
> What about an assert(props.has_node_id) here?
I considered it but dropped idea, as it's mostly useless
since build_srat() is called only when numa is enabled.

and sticking asserts in every place just in case doesn't
seem to me like good idea as it would lead to absurd 
asserts after every line.

Considering the new code behaves the same in case !has_node_id
I don't see any reason to put assert here, the same goes
for 'Ditto" comment in the next hunk.

But if you insist I can' add assert().

> 
> >          uint32_t apic_id = apic_ids->cpus[i].arch_id;
> >  
> >          if (apic_id < 255) {
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index cf09949..84f0a6f 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -788,9 +788,7 @@ static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcms)
> >      for (i = 0; i < cpus->len; i++) {
> >          unsigned int apic_id = cpus->cpus[i].arch_id;
> >          assert(apic_id < pcms->apic_id_limit);
> > -        if (cpus->cpus[i].props.has_node_id) {
> > -            numa_fw_cfg[apic_id + 1] = cpu_to_le64(cpus->cpus[i].props.node_id);
> > -        }
> > +        numa_fw_cfg[apic_id + 1] = cpu_to_le64(cpus->cpus[i].props.node_id);  
> 
> Ditto.
> 
> >      }
> >      for (i = 0; i < nb_numa_nodes; i++) {
> >          numa_fw_cfg[pcms->apic_id_limit + 1 + i] =
> > diff --git a/numa.c b/numa.c
> > index e30702e..4ef6dea 100644
> > --- a/numa.c
> > +++ b/numa.c
> > @@ -513,17 +513,12 @@ void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp)
> >      int node_id = object_property_get_int(OBJECT(dev), "node-id", &error_abort);
> >  
> >      if (node_id == CPU_UNSET_NUMA_NODE_ID) {
> > -        /* by default CPUState::numa_node was 0 if it wasn't set explicitly
> > -         * TODO: make it error when incomplete numa mapping support is removed
> > -         */
> > -        node_id = 0;
> > -
> >          /* due to bug in libvirt, it doesn't pass node-id from props on
> >           * device_add as expected, so we have to fix it up here */
> >          if (slot->props.has_node_id) {
> >              node_id = slot->props.node_id;
> > +            object_property_set_int(OBJECT(dev), node_id, "node-id", errp);
> >          }
> > -        object_property_set_int(OBJECT(dev), node_id, "node-id", errp);  
> 
> Why not removing the has_node_id check completely, here?
because numa_cpu_pre_plug() is called unconditionally
As alternative, I can replace has_node_id check with assert
and do following from callers:

 if (nb_numa_nodes) {
     numa_cpu_pre_plug()
 }


> In case this patch get respun, I suggest also removing the
> has_node_id check at: build_cpus_aml() _PXM code.
that would be wrong, build_cpus_aml() is called for both
numa and non numa use-cases, there shouldn't be _PXM
object if numa is not enabled, hence the check.

 
> >      } else if (node_id != slot->props.node_id) {
> >          error_setg(errp, "node-id=%d must match numa node specified "
> >                     "with -numa option", node_id);
> > -- 
> > 2.7.4
> > 
> >   
> 
