Received: from eggs.gnu.org ([2001:4830:134:3::10]:48926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dBQVx-0002wR-15
	for qemu-devel@nongnu.org; Thu, 18 May 2017 14:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dBQVv-0000pr-SD
	for qemu-devel@nongnu.org; Thu, 18 May 2017 14:51:09 -0400
Date: Thu, 18 May 2017 15:50:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170518185058.GP4748@thinpad.lan.raisama.net>
References: <1495094971-177754-1-git-send-email-imammedo@redhat.com>
	<1495094971-177754-3-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495094971-177754-3-git-send-email-imammedo@redhat.com>
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

On Thu, May 18, 2017 at 10:09:30AM +0200, Igor Mammedov wrote:
> there is no need use cpu_index_to_instance_props() for setting
> default cpu -> node mapping. Generic machine code can do it
> without cpu_index by just enabling already preset defaults
> in possible_cpus.
> 
> PS:
> as bonus it makes one less user of cpu_index_to_instance_props()
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/core/machine.c | 32 +++++++++++++++++++++-----------
>  numa.c            | 26 --------------------------
>  2 files changed, 21 insertions(+), 37 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index fd6a436..2e91aa9 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -700,26 +700,36 @@ static char *cpu_slot_to_string(const CPUArchId *cpu)
>      return g_string_free(s, false);
>  }
>  
> -static void machine_numa_validate(MachineState *machine)
> +static void machine_numa_finish_init(MachineState *machine)
>  {
> -    int i;
> +    int i, default_mapping;

I suggest bool instead of int.

>      GString *s = g_string_new(NULL);
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
>      const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(machine);
>  
>      assert(nb_numa_nodes);
> +    for (i = possible_cpus->len;
> +         i && !possible_cpus->cpus[i - 1].props.has_node_id;
> +         i--)
> +        ;;

I believe the original code was more readable, and it had only 1
more line than this version. i.e.:

    for (i = 0; i < possible_cpus->len; i++) {
        if (possible_cpus->cpus[i].props.has_node_id) {
            break;
        }
    }
    default_mapping = (i == possible_cpus->len);

> +    default_mapping = !i; /* i == 0 : no explicit mapping provided by user */
> +
>      for (i = 0; i < possible_cpus->len; i++) {
>          const CPUArchId *cpu_slot = &possible_cpus->cpus[i];
>  
> -        /* at this point numa mappings are initilized by CLI options
> -         * or with default mappings so it's sufficient to list
> -         * all not yet mapped CPUs here */
> -        /* TODO: make it hard error in future */

Did we change our mind about making it a hard error in the
future?

>          if (!cpu_slot->props.has_node_id) {
> -            char *cpu_str = cpu_slot_to_string(cpu_slot);
> -            g_string_append_printf(s, "%sCPU %d [%s]", s->len ? ", " : "", i,
> -                                   cpu_str);
> -            g_free(cpu_str);
> +            if (default_mapping) {
> +                /* fetch default mapping from board and enable it */
> +                CpuInstanceProperties props = cpu_slot->props;
> +                props.has_node_id = true;
> +                machine_set_cpu_numa_node(machine, &props, &error_fatal);

Is a machine_set_cpu_numa_node() call really necessary here, if
we are already looking at cpu_slot->props directly?

> +            } else {
> +                /* record slots with not set mapping */
> +                char *cpu_str = cpu_slot_to_string(cpu_slot);
> +                g_string_append_printf(s, "%sCPU %d [%s]",
> +                                       s->len ? ", " : "", i, cpu_str);
> +                g_free(cpu_str);
> +            }
>          }

What about doing this instead:

        if (default_mapping) {
            /*
             * Default mapping was already set by board at
             * cpu_slot->props.node_id, just enable it
             */
            cpu_slot->props.has_node_id = true;
        } else if (!cpu_slot->props.has_node_id) {
            char *cpu_str = cpu_slot_to_string(cpu_slot);
            g_string_append_printf(s, "%sCPU %d [%s]", s->len ? ", " : "", i,
                                   cpu_str);
            g_free(cpu_str);
        }

>      }
>      if (s->len) {
> @@ -737,7 +747,7 @@ void machine_run_board_init(MachineState *machine)
>      MachineClass *machine_class = MACHINE_GET_CLASS(machine);
>  
>      if (nb_numa_nodes) {
> -        machine_numa_validate(machine);
> +        machine_numa_finish_init(machine);
>      }
>      machine_class->init(machine);
>  }
> diff --git a/numa.c b/numa.c
> index 0115bfd..796cd7d 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -427,7 +427,6 @@ void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
>  void parse_numa_opts(MachineState *ms)
>  {
>      int i;
> -    const CPUArchIdList *possible_cpus;
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
>  
>      if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, NULL)) {
> @@ -485,31 +484,6 @@ void parse_numa_opts(MachineState *ms)
>  
>          numa_set_mem_ranges();
>  
> -        /* assign CPUs to nodes using board provided default mapping */
> -        if (!mc->cpu_index_to_instance_props || !mc->possible_cpu_arch_ids) {
> -            error_report("default CPUs to NUMA node mapping isn't supported");
> -            exit(1);
> -        }
> -
> -        possible_cpus = mc->possible_cpu_arch_ids(ms);
> -        for (i = 0; i < possible_cpus->len; i++) {
> -            if (possible_cpus->cpus[i].props.has_node_id) {
> -                break;
> -            }
> -        }
> -
> -        /* no CPUs are assigned to NUMA nodes */
> -        if (i == possible_cpus->len) {
> -            for (i = 0; i < max_cpus; i++) {
> -                CpuInstanceProperties props;
> -                /* fetch default mapping from board and enable it */
> -                props = mc->cpu_index_to_instance_props(ms, i);
> -                props.has_node_id = true;
> -
> -                machine_set_cpu_numa_node(ms, &props, &error_fatal);
> -            }
> -        }
> -
>          /* QEMU needs at least all unique node pair distances to build
>           * the whole NUMA distance table. QEMU treats the distance table
>           * as symmetric by default, i.e. distance A->B == distance B->A.
> -- 
> 2.7.4
> 

-- 
Eduardo
