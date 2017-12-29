Received: from eggs.gnu.org ([2001:4830:134:3::10]:34343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUrEA-00055e-FS
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 04:45:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUrE9-00029K-Hy
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 04:45:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eUrE9-00028l-Ar
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 04:45:21 -0500
Date: Fri, 29 Dec 2017 10:45:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171229104514.0ba54dac@igors-macbook-pro.local>
In-Reply-To: <20171229063145.29167-30-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
	<20171229063145.29167-30-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 29/38] hw/hppa: Implement DINO system board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de

On Thu, 28 Dec 2017 22:31:36 -0800
Richard Henderson <richard.henderson@linaro.org> wrote:

> Now that we have the prerequisites in target/hppa/,
> implement the hardware for a PA7100LC.
> 
> This also enables build for hppa-softmmu.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> [rth: Since it is all new code, squashed all branch development
> withing hw/hppa/ to a single patch.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
[...]

> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 4625e591ea..d491c2aeed 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -1,5 +1,5 @@
>  /*
> - * QEMU HPPA hardware system emulator.
> + * QEMU HP-PARISC (HPPA) hardware system emulator.
>   * Copyright 2017 Helge Deller <deller@gmx.de>
>   *
>   */
> @@ -17,12 +17,222 @@
>  #include "hw/ide.h"
>  #include "hw/timer/i8254.h"
>  #include "hw/char/serial.h"
> +#include "hw/hppa/hppa_sys.h"
>  #include "qemu/cutils.h"
>  #include "qapi/error.h"
>  
> +#define MAX_IDE_BUS 2
> +
> +static ISABus *hppa_isa_bus(void)
> +{
> +    ISABus *isa_bus;
> +    qemu_irq *isa_irqs;
> +    MemoryRegion *isa_region;
> +
> +    isa_region = g_new(MemoryRegion, 1);
> +    memory_region_init_io(isa_region, NULL, &hppa_pci_ignore_ops,
> +                          NULL, "isa-io", 0x800);
> +    memory_region_add_subregion(get_system_memory(), IDE_HPA,
> +                                isa_region);
> +
> +    isa_bus = isa_bus_new(NULL, get_system_memory(), isa_region,
> +                          &error_abort);
> +    isa_irqs = i8259_init(isa_bus,
> +                          /* qemu_allocate_irq(dino_set_isa_irq, s, 0)); */
> +                          NULL);
> +    isa_bus_irqs(isa_bus, isa_irqs);
> +
> +    return isa_bus;
> +}
> +
> +static uint64_t cpu_hppa_to_phys(void *opaque, uint64_t addr)
> +{
> +    addr &= (0x10000000 - 1);
> +    return addr;
> +}
>  
>  static void machine_hppa_init(MachineState *machine)
>  {
> +    ram_addr_t ram_size = machine->ram_size;
> +    const char *cpu_model
> +        = machine->cpu_model ? machine->cpu_model : "hppa1.1";
[...]

> +
> +    /* Create 1 cpu (for now).  */
> +    cpu0 = HPPA_CPU(cpu_generic_init(TYPE_HPPA_CPU, cpu_model));
[...]

Please don't use cpu_model in board code, use cpu_type instead.
See 5daab28e as example
