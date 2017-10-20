Received: from eggs.gnu.org ([2001:4830:134:3::10]:36022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e5cmj-0005lk-0q
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e5cmh-0008Pu-SK
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:16:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e5cmh-0008PZ-JD
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:16:43 -0400
Date: Fri, 20 Oct 2017 17:16:38 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171020191638.GR2942@localhost.localdomain>
References: <cover.1508279421.git.alistair.francis@xilinx.com>
	<7d590a446dfe29a1815c3cad2a93f7d6b0d8a214.1508279421.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d590a446dfe29a1815c3cad2a93f7d6b0d8a214.1508279421.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/5] xlnx-zcu102: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, marcel@redhat.com, imammedo@redhat.com, f4bug@amsat.org

On Tue, Oct 17, 2017 at 03:31:19PM -0700, Alistair Francis wrote:
> List all possible valid CPU options.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

> ---
> 
> An implementation for single CPU machines is still being discussed. A
> solution proposed by Eduardo is this:
> 
> 1) Change the default on TYPE_MACHINE to:
>      mc->valid_cpu_types = { TYPE_CPU, NULL };
> 
>    This will keep the existing behavior for all boards.
> 
> 2) mc->valid_cpu_types=NULL be interpreted as "no CPU model
>    except the default is accepted" or "-cpu is not accepted" in
>    machine_run_board_init() (I prefer the former, but both
>    options would be correct)
> 
> 3) Boards like xlnx_zynqmp could then just do this:
> 
>    static void xxx_class_init(...) {
>        mc->default_cpu_type = MY_CPU_TYPE;
>        /* Reason: XXX_init() is hardcoded to MY_CPU_TYPE */
>        mc->valid_cpu_types = NULL;
>    }
> 
> V3:
>  - Make variable static
> V2:
>  - Don't use the users -cpu
>  - Fixup allignment
> 
>  hw/arm/xlnx-zcu102.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> index 519a16ed98..d5a5425356 100644
> --- a/hw/arm/xlnx-zcu102.c
> +++ b/hw/arm/xlnx-zcu102.c
> @@ -160,6 +160,11 @@ static void xlnx_zynqmp_init(XlnxZCU102 *s, MachineState *machine)
>      arm_load_kernel(s->soc.boot_cpu_ptr, &xlnx_zcu102_binfo);
>  }
>  
> +static const char *xlnx_zynqmp_valid_cpus[] = {
> +                                            ARM_CPU_TYPE_NAME("cortex-a53"),
> +                                            NULL
> +                                              };
> +
>  static void xlnx_ep108_init(MachineState *machine)
>  {
>      XlnxZCU102 *s = EP108_MACHINE(machine);
> @@ -185,6 +190,12 @@ static void xlnx_ep108_machine_class_init(ObjectClass *oc, void *data)
>      mc->block_default_type = IF_IDE;
>      mc->units_per_default_bus = 1;
>      mc->ignore_memory_transaction_failures = true;
> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
> +    /* The ZynqMP SoC is always a Cortex-A53. We add this here to give
> +     * users a sane error if they specify a different CPU, but we never
> +     * use their CPU choice.
> +     */
> +    mc->valid_cpu_types = xlnx_zynqmp_valid_cpus;
>  }
>  
>  static const TypeInfo xlnx_ep108_machine_init_typeinfo = {
> @@ -240,6 +251,12 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
>      mc->block_default_type = IF_IDE;
>      mc->units_per_default_bus = 1;
>      mc->ignore_memory_transaction_failures = true;
> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
> +    /* The ZynqMP SoC is always a Cortex-A53. We add this here to give
> +     * users a sane error if they specify a different CPU, but we never
> +     * use their CPU choice.
> +     */
> +    mc->valid_cpu_types = xlnx_zynqmp_valid_cpus;
>  }
>  
>  static const TypeInfo xlnx_zcu102_machine_init_typeinfo = {
> -- 
> 2.11.0
> 

-- 
Eduardo
