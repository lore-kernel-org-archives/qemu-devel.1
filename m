Received: from eggs.gnu.org ([2001:4830:134:3::10]:36401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTSw5-0002a7-Kd
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:32:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTSw2-0001Vn-Bj
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:32:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTSw2-0001V5-38
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:32:22 -0500
Date: Tue, 17 Jan 2017 10:32:17 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170117123217.GF3491@thinpad.lan.raisama.net>
References: <1484654591-11108-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484654591-11108-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] hw/core/null-machine: Add the
 possibility to instantiate a CPU, RAM and kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>

On Tue, Jan 17, 2017 at 01:03:11PM +0100, Thomas Huth wrote:
> Sometimes it is useful to have just a machine with CPU and RAM, without
> any further hardware in it, e.g. if you just want to do some instruction
> debugging for TCG with a remote GDB attached to QEMU, or run some embedded
> code with the "-semihosting" QEMU parameter. qemu-system-m68k already
> features a "dummy" machine, and xtensa a "sim" machine for exactly this
> purpose.
> All target architectures have nowadays also a "none" machine, which would
> be a perfect match for this, too - but it currently does not allow to add
> CPU, RAM or a kernel yet. Thus let's add these possibilities in a generic
> way to the "none" machine, too, so that we hopefully do not need additional
> "dummy" machines in the future anymore (and maybe can also get rid of the
> already existing "dummy"/"sim" machines one day).
> Note that the default behaviour of the "none" machine is not changed, i.e.
> no CPU and no RAM is instantiated by default. You've explicitely got to
> specify the CPU model with "-cpu" and the amount of RAM with "-m" to get
> these new features.
> We also introduce a wrapper called cpu_init_def() for the target-specific
> macro cpu_init() in cpus.c here, so we can continue to compile the file
> null-machine.c independently from the target.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Use the generic-loader device for providing the functionality of
>    the "-kernel" parameter

Peter argued in v1 against providing a -kernel option that
doesn't have the same capabilities as the other machines in the
same architecture (I will continue the discussion there).  Maybe
you'll want to split this in multiple patches so we could include
the RAM and CPU changes while discussing what to do about
-kernel.

>  - Explicitely set mc->max_cpus = 1
>  - Make sure that null-machine.c can be compiled independent from the
>    target (by introducing a wrapper function for cpu_init())

Most (or all?) architectures should work if you use
cpu_generic_init(). I wonder how many architectures don't use
cpu_generic_init() to implement cpu_init() yet.

> 
>  cpus.c                 |  5 +++++
>  hw/core/null-machine.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  include/qom/cpu.h      | 11 +++++++++++
>  3 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/cpus.c b/cpus.c
> index 5213351..7c4dc38 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -80,6 +80,11 @@ static unsigned int throttle_percentage;
>  #define CPU_THROTTLE_PCT_MAX 99
>  #define CPU_THROTTLE_TIMESLICE_NS 10000000
>  
> +CPUState *cpu_init_def(const char *cpu_model)
> +{
> +    return cpu_init(cpu_model);
> +}
> +

So, now we have two interfaces to do exactly the same thing:
cpu_init() and cpu_init_def(). But cpu_init() is a macro and
cpu_init_def() is a function. cpu_init() is available only if you
include cpu.h, but cpu_init_def() is available elsewhere.
Ideally, code should be able to simply call a cpu_init()
function, and it should work the same everywhere.

In practice, cleaning this up might take a while, so
cpu_init_def() might be a temporary solution. But now I am not
sure if having this additional wrapper is better than simply
making null-machine.o target-dependent like you did before.


>  bool cpu_is_stopped(CPUState *cpu)
>  {
>      return cpu->stopped || !runstate_is_running();
> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> index 0351ba7..eab5133 100644
> --- a/hw/core/null-machine.c
> +++ b/hw/core/null-machine.c
> @@ -13,18 +13,54 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> +#include "qemu/error-report.h"
>  #include "hw/hw.h"
>  #include "hw/boards.h"
> +#include "hw/core/generic-loader.h"
> +#include "sysemu/sysemu.h"
> +#include "exec/address-spaces.h"
> +#include "qom/cpu.h"
>  
> -static void machine_none_init(MachineState *machine)
> +static void machine_none_init(MachineState *mch)
>  {
> +    CPUState *cpu = NULL;
> +
> +    /* Initialize CPU (if a model has been specified) */
> +    if (mch->cpu_model) {
> +        cpu = cpu_init_def(mch->cpu_model);
> +        if (!cpu) {
> +            error_report("Unable to initialize CPU");
> +            exit(1);
> +        }
> +    }
> +
> +    /* RAM at address zero */
> +    if (mch->ram_size) {
> +        MemoryRegion *ram = g_new(MemoryRegion, 1);
> +
> +        memory_region_allocate_system_memory(ram, NULL, "ram", mch->ram_size);
> +        memory_region_add_subregion(get_system_memory(), 0, ram);
> +    }
> +
> +    /* Load kernel */
> +    if (mch->kernel_filename) {
> +        DeviceState *loader;
> +
> +        loader = qdev_create(sysbus_get_default(), TYPE_GENERIC_LOADER);
> +        qdev_prop_set_string(loader, "file", mch->kernel_filename);
> +        if (cpu) {
> +            qdev_prop_set_uint32(loader, "cpu-num", cpu->cpu_index);
> +        }
> +        qdev_init_nofail(loader);
> +    }
>  }
>  
>  static void machine_none_machine_init(MachineClass *mc)
>  {
>      mc->desc = "empty machine";
>      mc->init = machine_none_init;
> -    mc->max_cpus = 0;
> +    mc->max_cpus = 1;
> +    mc->default_ram_size = 0;
>  }
>  
>  DEFINE_MACHINE("none", machine_none_machine_init)
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 3f79a8e..c20da71 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -636,6 +636,17 @@ bool qemu_cpu_is_self(CPUState *cpu);
>  void qemu_cpu_kick(CPUState *cpu);
>  
>  /**
> + * cpu_init_def:
> + * @cpu_model: Specifies the CPU model which should be created.
> + *
> + * A wrapper around the cpu_init() macro which can be used in target
> + * independent code, too.
> + *
> + * Returns: The CPUState of the created CPU.
> + */
> +CPUState *cpu_init_def(const char *cpu_model);
> +
> +/**
>   * cpu_is_stopped:
>   * @cpu: The CPU to check.
>   *
> -- 
> 1.8.3.1
> 

-- 
Eduardo
