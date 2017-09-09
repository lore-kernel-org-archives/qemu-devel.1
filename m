Received: from eggs.gnu.org ([2001:4830:134:3::10]:41515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dqmBe-0005yl-Ul
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 16:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dqmBb-0000xk-Po
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 16:17:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dqmBb-0000sL-Gi
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 16:17:03 -0400
Date: Sat, 9 Sep 2017 17:16:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170909201657.GF7570@localhost.localdomain>
References: <cover.1504656490.git.alistair.francis@xilinx.com>
	<b2bfe1ee20bd9764572015df0d167d3015036ef0.1504656490.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2bfe1ee20bd9764572015df0d167d3015036ef0.1504656490.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [RFC v1 1/2] machine: Add a valid_cpu_types
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, marcel@redhat.com

On Tue, Sep 05, 2017 at 05:12:01PM -0700, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
>  hw/core/machine.c   | 27 +++++++++++++++++++++++++++
>  include/hw/boards.h |  1 +
>  2 files changed, 28 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 41b53a17ad..de0f127d27 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -758,6 +758,33 @@ void machine_run_board_init(MachineState *machine)
>          machine_numa_finish_init(machine);
>      }
>      machine_class->init(machine);
> +
> +    if (machine_class->valid_cpu_types && machine->cpu_model) {
> +        const char *temp;
> +        int i, len = machine_class->valid_cpu_types->len;

I suggest doing this after Igor's series that replaces the
cpu_model field (full -cpu string) with cpu_type (only the CPU
type name).

> +
> +        for (i = 0; i < len; i++) {
> +            temp = g_array_index(machine_class->valid_cpu_types, char *, i);
> +            if (!strcmp(machine->cpu_model, temp)) {
> +                /* The user specificed CPU is in the valid field, we are
> +                 * good to go.
> +                 */
> +                g_array_free(machine_class->valid_cpu_types, true);
> +                return;

I suggest checking for:
  object_class_dynamic_cast(object_class_get_name(machine->cpu_type), type)
instead.  This way machines could just enumerate a common parent
type to all supported CPU models.

> +            }
> +        }
> +        /* The user specified CPU must not be a valid CPU, print a sane error */
> +        temp = g_array_index(machine_class->valid_cpu_types, char *, 0);
> +        error_report("Invalid CPU: %s", machine->cpu_model);
> +        error_printf("The valid options are: %s", temp);
> +        for (i = 1; i < len; i++) {
> +            temp = g_array_index(machine_class->valid_cpu_types, char *, i);
> +            error_printf(", %s", temp);
> +        }
> +        error_printf("\n");

Now we have a completely new method to list the valid CPU types
in addition to arch_query_cpu_definitions() and list_cpus()
(which are already a bit messy and need to share more code).

I think this should share code with "-cpu
help"/query-cpu-definitions instead.  This means
arch_query_cpu_definitions() will need a MachineClass* argument,
if the user wants only the CPU types supported by a specific
machine type, but I think it would be an interesting improvement
to query-cpu-definitions.

> +        g_array_free(machine_class->valid_cpu_types, true);
> +        exit(1);
> +    }
>  }
>  
>  static void machine_class_finalize(ObjectClass *klass, void *data)
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 3363dd19fd..78678f84a9 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -172,6 +172,7 @@ struct MachineClass {
>      int minimum_page_bits;
>      bool has_hotpluggable_cpus;
>      int numa_mem_align_shift;
> +    GArray *valid_cpu_types;

The list of CPU types for a machine are very likely to be
statically defined at build time.  Any specific reason to not
make it a simple char** pointer?

>      void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
>                                   int nb_nodes, ram_addr_t size);
>  
> -- 
> 2.11.0
> 

-- 
Eduardo
