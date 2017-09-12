Received: from eggs.gnu.org ([2001:4830:134:3::10]:49069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drlTH-000527-A7
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drlTE-0000t6-4G
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:43:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1drlTD-0000sp-R8
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:43:20 -0400
Date: Tue, 12 Sep 2017 15:43:13 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170912154313.3616c2bf@nial.brq.redhat.com>
In-Reply-To: <20170911152150.12535-19-david@redhat.com>
References: <20170911152150.12535-1-david@redhat.com>
	<20170911152150.12535-19-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 18/21] s390x: implement
 query-hotpluggable-cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 11 Sep 2017 17:21:47 +0200
David Hildenbrand <david@redhat.com> wrote:

> CPU hotplug is only possible on a per core basis on s390x.
> 
> As we now have ms->possible_cpus, we can get rid of the global variable
> cpu_states.
> 
> While rewriting s390_cpu_addr2state() completely to be based on
> possible_cpus, move it to cpu.c, as it is independent of the virtio-ccw
> machine.
I'd split patch on
 1) introduce possible cpus 
 2) rewrite s390_cpu_addr2state() using #2

> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 87 +++++++++++++++++++++++++++++-----------------
>  qapi-schema.json           | 16 +++++++++
>  target/s390x/cpu.c         | 17 +++++++++
>  target/s390x/cpu.h         |  5 +--
>  4 files changed, 89 insertions(+), 36 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 120f82e339..0e10a4c73a 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -36,24 +36,12 @@
>  #include "qapi/qmp/qerror.h"
>  #include "hw/nmi.h"
>  
> -static S390CPU **cpu_states;
> -
> -S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
> -{
> -    if (cpu_addr >= max_cpus) {
> -        return NULL;
> -    }
> -
> -    /* Fast lookup via CPU ID */
> -    return cpu_states[cpu_addr];
> -}
> -
>  /* #define S390_TCG_SMP_SUPPORT */
>  
>  static void s390_init_cpus(MachineState *machine)
>  {
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
>      int i;
> -    gchar *name;
>  
>      if (machine->cpu_model == NULL) {
>          machine->cpu_model = s390_default_cpu_model_name();
> @@ -66,17 +54,8 @@ static void s390_init_cpus(MachineState *machine)
>      }
>  #endif
>  
> -    cpu_states = g_new0(S390CPU *, max_cpus);
> -
> -    for (i = 0; i < max_cpus; i++) {
> -        name = g_strdup_printf("cpu[%i]", i);
> -        object_property_add_link(OBJECT(machine), name, TYPE_S390_CPU,
> -                                 (Object **) &cpu_states[i],
> -                                 object_property_allow_set_link,
> -                                 OBJ_PROP_LINK_UNREF_ON_RELEASE,
> -                                 &error_abort);
> -        g_free(name);
> -    }
> +    /* initialize possible_cpus */
> +    mc->possible_cpu_arch_ids(machine);
>  
>      for (i = 0; i < smp_cpus; i++) {
>          s390x_new_cpu(machine->cpu_model, i, &error_fatal);
> @@ -307,17 +286,14 @@ static void ccw_init(MachineState *machine)
>      register_savevm_live(NULL, "todclock", 0, 1, &savevm_gtod, NULL);
>  }
>  
> -static void s390_cpu_plug(HotplugHandler *hotplug_dev,
> -                        DeviceState *dev, Error **errp)
> +static void s390_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                          Error **errp)
>  {
> -    gchar *name;
> +    MachineState *ms = MACHINE(hotplug_dev);
>      S390CPU *cpu = S390_CPU(dev);
> -    CPUState *cs = CPU(dev);
>  
> -    name = g_strdup_printf("cpu[%i]", cpu->env.core_id);
> -    object_property_set_link(OBJECT(hotplug_dev), OBJECT(cs), name,
> -                             errp);
> -    g_free(name);
> +    g_assert(!ms->possible_cpus->cpus[cpu->env.core_id].cpu);
> +    ms->possible_cpus->cpus[cpu->env.core_id].cpu = OBJECT(dev);
>  }
>  
>  static void s390_machine_reset(void)
> @@ -350,6 +326,50 @@ static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
>      }
>  }
>  
> +static CPUArchId *s390_find_cpu_slot(MachineState *ms, uint32_t core_id,
> +                                     int *idx)
> +{
> +    if (core_id >= ms->possible_cpus->len) {
> +        return NULL;
> +    }
> +    /* core_id corresponds to the index */
> +    if (idx) {
> +        *idx = core_id;
> +    }
> +    return &ms->possible_cpus->cpus[core_id];
> +}
it looks like cpu_index == core_id == idx in possible_cpus,
is this helper really necessary?
(we have it in x86 because of possible not 1:1 mapping)

I'd drop it and just access array directly

> +
> +static CpuInstanceProperties s390_cpu_index_to_props(MachineState *machine,
> +                                                     unsigned cpu_index)
> +{
> +    CPUArchId *slot = s390_find_cpu_slot(machine, cpu_index, NULL);
> +
> +    assert(slot);
> +    return slot->props;
> +}
> +
> +static const CPUArchIdList *s390_possible_cpu_arch_ids(MachineState *ms)
> +{
> +    int i;
> +
> +    if (ms->possible_cpus) {
> +        g_assert(ms->possible_cpus && ms->possible_cpus->len == max_cpus);
> +        return ms->possible_cpus;
> +    }
> +
> +    ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
> +                                  sizeof(CPUArchId) * max_cpus);
> +    ms->possible_cpus->len = max_cpus;
> +    for (i = 0; i < ms->possible_cpus->len; i++) {
> +        ms->possible_cpus->cpus[i].vcpus_count = 1;
> +        ms->possible_cpus->cpus[i].arch_id = i;
> +        ms->possible_cpus->cpus[i].props.has_core_id = true;
> +        ms->possible_cpus->cpus[i].props.core_id = i;
> +    }
> +
> +    return ms->possible_cpus;
> +}
> +
>  static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
>                                                  DeviceState *dev)
>  {
> @@ -397,7 +417,10 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>      mc->no_sdcard = 1;
>      mc->use_sclp = 1;
>      mc->max_cpus = 248;
> +    mc->has_hotpluggable_cpus = true;
>      mc->get_hotplug_handler = s390_get_hotplug_handler;
> +    mc->cpu_index_to_instance_props = s390_cpu_index_to_props;
> +    mc->possible_cpu_arch_ids = s390_possible_cpu_arch_ids;
>      hc->plug = s390_machine_device_plug;
>      hc->unplug_request = s390_machine_device_unplug_request;
>      nc->nmi_monitor_handler = s390_nmi;
> diff --git a/qapi-schema.json b/qapi-schema.json
> index f3af2cb851..79e9f85404 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3121,6 +3121,22 @@
>  #      }
>  #    ]}
>  #
> +# For s390x-virtio-ccw machine type started with -smp 1,maxcpus=2 -cpu qemu
> +# (Since: 2.11):
> +#
> +# -> { "execute": "query-hotpluggable-cpus" }
> +# <- {"return": [
> +#      {
> +#         "type": "qemu-s390-cpu", "vcpus-count": 1,
> +#         "props": { "core-id": 1 }
> +#      },
> +#      {
> +#         "qom-path": "/machine/unattached/device[0]",
> +#         "type": "qemu-s390-cpu", "vcpus-count": 1,
> +#         "props": { "core-id": 0 }
> +#      }
> +#    ]}
> +#
>  ##
>  { 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'] }
>  
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 5724dffb88..7f174f90a4 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -38,6 +38,7 @@
>  #include "exec/exec-all.h"
>  #include "hw/qdev-properties.h"
>  #ifndef CONFIG_USER_ONLY
> +#include "hw/boards.h"
>  #include "hw/hw.h"
>  #include "sysemu/arch_init.h"
>  #include "sysemu/sysemu.h"
> @@ -446,6 +447,22 @@ void s390_enable_css_support(S390CPU *cpu)
>          kvm_s390_enable_css_support(cpu);
>      }
>  }
> +
> +S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
> +{
target/cpu.c and cpu itself preferably shouldn't pull in
or depend on machine, so I'd keep s390_cpu_addr2state() where it's now
or somewhere in board related files


> +    static MachineState *ms;
> +
> +    if (!ms) {
> +        ms = MACHINE(qdev_get_machine());
> +        g_assert(ms->possible_cpus);
> +    }
> +
> +    /* CPU address corresponds to the core_id and the index */
> +    if (cpu_addr >= ms->possible_cpus->len) {
> +        return NULL;
> +    }
> +    return S390_CPU(ms->possible_cpus->cpus[cpu_addr].cpu);
> +}
>  #endif
>  
>  static gchar *s390_gdb_arch_name(CPUState *cs)
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 1c8456fa57..5810079f48 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -671,6 +671,7 @@ int s390_cpu_restart(S390CPU *cpu);
>  void s390_enable_css_support(S390CPU *cpu);
>  int s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch_id,
>                                  int vq, bool assign);
> +S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
>  #ifndef CONFIG_USER_ONLY
>  unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu);
>  #else
> @@ -718,8 +719,4 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
>  #define s390_cpu_virt_mem_check_write(cpu, laddr, ar, len)   \
>          s390_cpu_virt_mem_rw(cpu, laddr, ar, NULL, len, true)
>  
> -
> -/* outside of target/s390x/ */
> -S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
> -
>  #endif
