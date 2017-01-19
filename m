Received: from eggs.gnu.org ([2001:4830:134:3::10]:60045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cUEGP-0005Cn-Eu
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:04:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cUEGL-0000jx-Bd
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:04:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cUEGL-0000jV-42
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:04:29 -0500
Date: Thu, 19 Jan 2017 16:04:23 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170119160423.761d2c57@nial.brq.redhat.com>
In-Reply-To: <20170118185713.GK3491@thinpad.lan.raisama.net>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
	<1484759609-264075-9-git-send-email-imammedo@redhat.com>
	<20170118185713.GK3491@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 08/13] pc: add writeonly 'cpu' property to
 PCMachine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Dou Liyang <douly.fnst@cn.fujitsu.com>, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>

On Wed, 18 Jan 2017 16:57:13 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, Jan 18, 2017 at 06:13:24PM +0100, Igor Mammedov wrote:
> > it will allow generic numa code to set cpu to numa node mapping
> > in target independent manner in the next patch.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  hw/i386/pc.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> > 
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index f8ea635..1d33a5e 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -2201,6 +2201,56 @@ static void pc_machine_set_pit(Object *obj, bool value, Error **errp)
> >      pcms->pit = value;
> >  }
> >  
> > +static void pc_machine_set_cpu(Object *obj, Visitor *v, const char *name,
> > +                               void *opaque, Error **errp)
> > +{
> > +    uint32_t apic_id;
> > +    X86CPUTopoInfo topo;
> > +    CPUArchId *cpu_slot;
> > +    Error *local_err = NULL;
> > +    CpuInstanceProperties *cpu_props = NULL;
> > +    PCMachineState *pcms = PC_MACHINE(obj);
> > +    MachineClass *mc = MACHINE_GET_CLASS(obj);
> > +
> > +    visit_type_CpuInstanceProperties(v, name, &cpu_props, &local_err);
> > +    if (local_err) {
> > +        goto out;
> > +    }
> > +
> > +    if (!cpu_props->has_node_id) {
> > +        error_setg(&local_err, "node-id property is not specified");
> > +        goto out;
> > +    }
> > +
> > +    /*
> > +     * make sure that possible_cpus is initialized
> > +     * as property setter might be called before machine init is called
> > +     */
> > +    mc->possible_cpu_arch_ids(MACHINE(obj));
> > +
> > +    topo.pkg_id = cpu_props->socket_id;
> > +    topo.core_id = cpu_props->core_id;
> > +    topo.smt_id = cpu_props->thread_id;
> > +    apic_id = apicid_from_topo_ids(smp_cores, smp_threads, &topo);
> > +    cpu_slot = pc_find_cpu_slot(pcms, apic_id, NULL);  
> 
> If we make TYPE_MACHINE provide an API to query CPU slots, e.g.:
>   CPUArchId *machine_find_cpu_slot(MachineState *m, CpuInstanceProperties *props)
so if there is no objections, 
I'll move possible_cpus to MachineState
and add to MachineClass above callback so target machine
would be able to provide arch specific lookup function.
it should work for both x86 and ARM.



>   CPUArchId *machine_slot_for_cpu(MachineState *m, CPUState *cpu)
probably won't work for SPAPR where they have cores,
machine_find_cpu_slot() alone might be sufficient.


> (Which can probably be implemented using
> MachineClass::possible_cpu_arch_ids(), already)
> 
> Then this function could be implemented in a generic way, and all
> existing calls of:
>   numa_get_node_for_cpu(cpu->cpu_index)
> could be easily replaced by:
>   machine_slot_for_cpu(cpu)->props.node_id
most of such places could be replaced directly by plain
cpu->node_id

> 
> This should make it easier to get rid numa_info[].node_cpu.

PS:
Adding Bharata to CC so SPAPR side could voice their opinion.


> > +    if (!cpu_slot) {
> > +        error_setg(&local_err, "unable to find CPU");
> > +        goto out;
> > +    }
> > +
> > +    if (cpu_slot->props.has_node_id) {
> > +        error_setg(&local_err, "CPU has already been assigned to node: %"PRId64,
> > +                   cpu_slot->props.node_id);
> > +        goto out;
> > +    }
> > +    cpu_slot->props.has_node_id = true;
> > +    cpu_slot->props.node_id = cpu_props->node_id;
> > +
> > + out:
> > +    error_propagate(errp, local_err);
> > +    qapi_free_CpuInstanceProperties(cpu_props);
> > +}
> > +
> >  static void pc_machine_initfn(Object *obj)
> >  {
> >      PCMachineState *pcms = PC_MACHINE(obj);
> > @@ -2395,6 +2445,12 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
> >  
> >      object_class_property_add_bool(oc, PC_MACHINE_PIT,
> >          pc_machine_get_pit, pc_machine_set_pit, &error_abort);
> > +
> > +    object_class_property_add(oc, "cpu", "CpuInstanceProperties",
> > +        NULL, pc_machine_set_cpu,
> > +        NULL, NULL, &error_abort);
> > +    object_class_property_set_description(oc, "cpu",
> > +        "Possible cpu placement", &error_abort);
> >  }
> >  
> >  static const TypeInfo pc_machine_info = {
> > -- 
> > 2.7.4
> >   
> 
