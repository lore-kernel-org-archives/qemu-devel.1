Received: from eggs.gnu.org ([2001:4830:134:3::10]:48975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzNu1-0001Fz-Fv
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzNtr-0007uz-Ii
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:10:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzNtr-0007tP-8w
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:10:19 -0400
Date: Tue, 3 Oct 2017 11:10:02 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171003141002.GB7087@localhost.localdomain>
References: <cover.1506037164.git.alistair.francis@xilinx.com>
	<d2e446ccb46d71bed3191fc97fe1aa6c884ea4ba.1506037164.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2e446ccb46d71bed3191fc97fe1aa6c884ea4ba.1506037164.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [RFC v2 1/2] machine: Add a valid_cpu_types
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
Cc: qemu-devel@nongnu.org, marcel@redhat.com, alistair23@gmail.com, imammedo@redhat.com

On Thu, Sep 21, 2017 at 04:41:50PM -0700, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
> RFC v2:
>  - Rebase on Igor's cpu_type work
>  - Use object_class_dynamic_cast()
>  - Use a NULL terminated cahr** list
>  - Do the check before the machine_class init() is called
> 
> 
>  hw/core/machine.c   | 35 +++++++++++++++++++++++++++++++++++
>  include/hw/boards.h |  1 +
>  2 files changed, 36 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 80647edc2a..abebfabdb8 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -758,6 +758,41 @@ void machine_run_board_init(MachineState *machine)
>      if (nb_numa_nodes) {
>          machine_numa_finish_init(machine);
>      }
> +
> +    if (machine_class->valid_cpu_types && machine->cpu_type) {
> +        int i;
> +
> +        for (i = 0; machine_class->valid_cpu_types[i]; i++) {
> +            ObjectClass *class = object_class_by_name(machine->cpu_type);
> +
> +            if (!class) {
> +                break;
> +            }
> +
> +            if (object_class_dynamic_cast(class,
> +                                          machine_class->valid_cpu_types[i])) {
> +                /* The user specificed CPU is in the valid field, we are
> +                 * good to go.
> +                 */
> +                goto done;

I would move the object_class_by_name() call outside the for loop
and remove the "goto", like this:

    if (machine->cpu_type && machine_class->valid_cpu_types) {
        ObjectClass *class = object_class_by_name(machine->cpu_type);
        int i;

        /* machine->cpu_type is supposed to be always a valid QOM type */
        assert(class);

        for (i = 0; machine_class->valid_cpu_types[i]; i++) {
            if (object_class_dynamic_cast(class,
                                          machine_class->valid_cpu_types[i])) {
                /* Valid CPU type, we're good to go */
                break;
            }
        }
        if (!machine_class->valid_cpu_types[i]) {
            error_report(...);
            ...
        }
    }

    machine_class->init(machine);

> +            }
> +        }
> +
> +        /* The user specified CPU must not be a valid CPU, print a sane
> +         * error
> +         */
> +        error_report("Invalid CPU: %s", machine->cpu_type);
> +        error_printf("The valid options are: %s",
> +                     machine_class->valid_cpu_types[0]);
> +        for (i = 1; machine_class->valid_cpu_types[i]; i++) {
> +            error_printf(", %s", machine_class->valid_cpu_types[i]);
> +        }
> +        error_printf("\n");

I would still like to make this share code with
query-cpu-definitions one day, but I'm OK with this
implementation.

I would just rewrite the message as "valid types are:" instead of
"valid options are:" and "Invalid CPU type:" instead of "Invalid
CPU:", because the -cpu option doesn't need to match a string in
valid_cpu_types exactly, it just needs to resolve to a type that
implements a valid type.


> +
> +        exit(1);
> +    }
> +
> +done:
>      machine_class->init(machine);
>  }
>  
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 156e0a5701..191a5b3cd8 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -191,6 +191,7 @@ struct MachineClass {
>      bool has_hotpluggable_cpus;
>      bool ignore_memory_transaction_failures;
>      int numa_mem_align_shift;
> +    const char **valid_cpu_types;
>      void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
>                                   int nb_nodes, ram_addr_t size);
>  
> -- 
> 2.11.0
> 
> 

-- 
Eduardo
