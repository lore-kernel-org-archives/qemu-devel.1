Received: from eggs.gnu.org ([208.118.235.92]:53935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ehg0u-0003GC-4D
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:25:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ehfzo-0003HH-Ir
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:24:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ehfzo-0003Fm-8i
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:23:32 -0500
Date: Fri, 2 Feb 2018 16:23:26 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180202182326.GB22556@localhost.localdomain>
References: <cover.1517532021.git.alistair.francis@xilinx.com>
	<56ba11cee61d769a9a2816fa990d472ab1480906.1517532021.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56ba11cee61d769a9a2816fa990d472ab1480906.1517532021.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/6] machine: Convert the valid cpu
 types to use cpu_model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, f4bug@amsat.org, imammedo@redhat.com, marcel@redhat.com, alistair23@gmail.com

On Thu, Feb 01, 2018 at 04:42:05PM -0800, Alistair Francis wrote:
> As cpu_type is not a user visible string let's convert the
> valid_cpu_types to compare against cpu_model instead. This way we have a
> user friendly string to report back.
> 
> Once we have a cpu_type to cpu_model conversion this patch should be
> reverted and we should use cpu_type instead.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
>  hw/core/machine.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index cdc1163dc6..de5bac1c84 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -776,13 +776,12 @@ void machine_run_board_init(MachineState *machine)
>      /* If the machine supports the valid_cpu_types check and the user
>       * specified a CPU with -cpu check here that the user CPU is supported.
>       */
> -    if (machine_class->valid_cpu_types && machine->cpu_type) {
> -        ObjectClass *class = object_class_by_name(machine->cpu_type);
> +    if (machine_class->valid_cpu_types && machine->cpu_model) {
>          int i;
>  
>          for (i = 0; machine_class->valid_cpu_types[i]; i++) {
> -            if (object_class_dynamic_cast(class,
> -                                          machine_class->valid_cpu_types[i])) {
> +            if (!strcmp(machine->cpu_model,
> +                        machine_class->valid_cpu_types[i])) {

I would rename valid_cpu_types to valid_cpu_models to make the
new semantics clearer.

Anyway, I have bad and good news:

The bad news is Igor already sent patches last week that remove
MachineState::cpu_model, so this conflicts with his series.  Now
parse_cpu_model() will be the only place where the original CPU model name is
available, but the function needs to work on *-user too.  See:
"[PATCH v3 23/25] Use cpu_create(type) instead of cpu_init(cpu_model)".

The good news is that I think we can fix this very easily if
validation is done at the same place where parse_cpu_model() is
called.  e.g.:

    current_machine->cpu_type = machine_class->default_cpu_type;
    if (cpu_model) {
        current_machine->cpu_type = parse_cpu_model(cpu_model);

        if (machine_class->valid_cpu_models) {
            ObjectClass *class = object_class_by_name(machine->cpu_type);
            int i;

            for (i = 0; machine_class->valid_cpu_models[i]; i++) {
                const char *valid_model = machine_class->valid_cpu_models[i];
                ObjectClass *valid_class = cpu_class_by_name(machine->cpu_type, valid_model);
                if (object_class_dynamic_cast(class,
                                              object_class_get_name(valid_class))) {
                     /* Valid CPU type, we're good to go */
                     break;
                }
            }
            if (!machine_class->valid_cpu_models[i]) {
                error_report("Invalid CPU model: %s", cpu_model);
                error_printf("The valid CPU models are: %s",
                             machine_class->valid_cpu_models[0]);
                for (i = 1; machine_class->valid_cpu_models[i]; i++) {
                    error_printf(", %s", machine_class->valid_cpu_models[i]);
                }
                error_printf("\n");
                exit(1);
            }
        }
    }

This can be done inside main(), or moved inside
machine_run_board_init() if main() pass cpu_model as argument to
the function.

On either case, I think it's a good idea to do validation and
printing of error messages closer to the code that parses the
command-line options.  This way we separate parsing/validation
from initialization.

>                  /* The user specificed CPU is in the valid field, we are
>                   * good to go.
>                   */
> @@ -792,8 +791,8 @@ void machine_run_board_init(MachineState *machine)
>  
>          if (!machine_class->valid_cpu_types[i]) {
>              /* The user specified CPU is not valid */
> -            error_report("Invalid CPU type: %s", machine->cpu_type);
> -            error_printf("The valid types are: %s",
> +            error_report("Invalid CPU model: %s", machine->cpu_model);
> +            error_printf("The valid models are: %s",
>                           machine_class->valid_cpu_types[0]);
>              for (i = 1; machine_class->valid_cpu_types[i]; i++) {
>                  error_printf(", %s", machine_class->valid_cpu_types[i]);
> -- 
> 2.14.1
> 
> 

-- 
Eduardo
