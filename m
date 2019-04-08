Received: from eggs.gnu.org ([209.51.188.92]:34096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hDTnG-00079F-F0
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hDTnF-0000ls-26
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:54:34 -0400
Date: Mon, 8 Apr 2019 14:54:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190408145424.45af3db8@redhat.com>
In-Reply-To: <1553849325-44201-4-git-send-email-like.xu@linux.intel.com>
References: <1553849325-44201-1-git-send-email-like.xu@linux.intel.com>
	<1553849325-44201-4-git-send-email-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/9] cpu/topology: add uncommon arch
 support for smp machine properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Like Xu <like.xu@linux.intel.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, "Daniel P.
	=?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, like.xu@intel.com

On Fri, 29 Mar 2019 16:48:39 +0800
Like Xu <like.xu@linux.intel.com> wrote:

here should be a commit message explaining what patch does
in more detail.


> Signed-off-by: Like Xu <like.xu@linux.intel.com>

Generic note, try not call qdev_get_machine() every time
you replace smp_cpus or other variables. It's often possible
to pass MachineState via call chain with trivial fixups.

> ---
>  hw/alpha/dp264.c     | 1 +
>  hw/hppa/machine.c    | 4 ++++
>  hw/mips/boston.c     | 1 +
>  hw/mips/mips_malta.c | 9 +++++++++
>  hw/sparc/sun4m.c     | 2 ++
>  hw/sparc64/sun4u.c   | 2 ++
>  hw/xtensa/sim.c      | 1 +
>  hw/xtensa/xtfpga.c   | 1 +
>  8 files changed, 21 insertions(+)
> 
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index 0347eb8..ee5d432 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -63,6 +63,7 @@ static void clipper_init(MachineState *machine)
>      char *palcode_filename;
>      uint64_t palcode_entry, palcode_low, palcode_high;
>      uint64_t kernel_entry, kernel_low, kernel_high;
> +    unsigned int smp_cpus = machine->topo.smp_cpus;
>  
>      /* Create up to 4 cpus.  */
>      memset(cpus, 0, sizeof(cpus));
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index d1b1d3c..f652891 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -16,6 +16,7 @@
>  #include "hw/ide.h"
>  #include "hw/timer/i8254.h"
>  #include "hw/char/serial.h"
> +#include "hw/boards.h"
>  #include "hppa_sys.h"
>  #include "qemu/units.h"
>  #include "qapi/error.h"
> @@ -72,6 +73,7 @@ static void machine_hppa_init(MachineState *machine)
>      MemoryRegion *ram_region;
>      MemoryRegion *cpu_region;
>      long i;
> +    unsigned int smp_cpus = machine->topo.smp_cpus;
I'd prefer to replace smp_cpus with machine->topo.smp_cpus
directly at places it's used, as it makes affected sites
more visible in the patch.
And use local smp_cpus only in places where using machine->topo.smp_cpus
makes core less readable.
(but it's just personal preference so I don't insist on it)

>  
>      ram_size = machine->ram_size;
>  
> @@ -242,7 +244,9 @@ static void machine_hppa_init(MachineState *machine)
>  
>  static void hppa_machine_reset(void)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
>      int i;
> +    unsigned int smp_cpus = ms->topo.smp_cpus;

***)
It would be better to pass MachineState as argument to
hppa_machine_reset(), a patch to so should go before this one.

Quick look shows only 3 overrides (hppa, pc, pnv) and one caller,
so I'd rather fix it than calling qdev_get_machine() unnecessarily 

>  
>      qemu_devices_reset();
>  
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index e5bab3c..7752c10 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -434,6 +434,7 @@ static void boston_mach_init(MachineState *machine)
>      DriveInfo *hd[6];
>      Chardev *chr;
>      int fw_size, fit_err;
> +    unsigned int smp_cpus = machine->topo.smp_cpus;
>      bool is_64b;
>  
>      if ((machine->ram_size % GiB) ||
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 439665a..d595375 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1095,6 +1095,8 @@ static int64_t load_kernel (void)
>  
>  static void malta_mips_config(MIPSCPU *cpu)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>      CPUMIPSState *env = &cpu->env;
>      CPUState *cs = CPU(cpu);
this one also called from reset, so the same [***] applies here too.

>  
> @@ -1127,9 +1129,11 @@ static void main_cpu_reset(void *opaque)
>  static void create_cpu_without_cps(const char *cpu_type,
>                                     qemu_irq *cbus_irq, qemu_irq *i8259_irq)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
caller has an access to MachineState so pass it down call chain all the way

>      CPUMIPSState *env;
>      MIPSCPU *cpu;
>      int i;
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>  
>      for (i = 0; i < smp_cpus; i++) {
>          cpu = MIPS_CPU(cpu_create(cpu_type));
> @@ -1149,7 +1153,9 @@ static void create_cpu_without_cps(const char *cpu_type,
>  static void create_cps(MaltaState *s, const char *cpu_type,
>                         qemu_irq *cbus_irq, qemu_irq *i8259_irq)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
ditto

>      Error *err = NULL;
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>  
>      s->cps = MIPS_CPS(object_new(TYPE_MIPS_CPS));
>      qdev_set_parent_bus(DEVICE(s->cps), sysbus_get_default());
> @@ -1171,6 +1177,9 @@ static void create_cps(MaltaState *s, const char *cpu_type,
>  static void mips_create_cpu(MaltaState *s, const char *cpu_type,
>                              qemu_irq *cbus_irq, qemu_irq *i8259_irq)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
ditto

> +    unsigned int smp_cpus = ms->topo.smp_cpus;
> +
>      if ((smp_cpus > 1) && cpu_supports_cps_smp(cpu_type)) {
>          create_cps(s, cpu_type, cbus_irq, i8259_irq);
>      } else {
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index ca1e382..2321cfb 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -853,6 +853,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>      unsigned int num_vsimms;
>      DeviceState *dev;
>      SysBusDevice *s;
> +    unsigned int smp_cpus = machine->topo.smp_cpus;
> +    unsigned int max_cpus = machine->topo.max_cpus;
>  
>      /* init CPUs */
>      for(i = 0; i < smp_cpus; i++) {
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 399f2d7..d089c4d 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -546,6 +546,8 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>      NICInfo *nd;
>      MACAddr macaddr;
>      bool onboard_nic;
> +    unsigned int smp_cpus = machine->topo.smp_cpus;
> +    unsigned int max_cpus = machine->topo.max_cpus;
>  
>      /* init CPUs */
>      cpu = sparc64_cpu_devinit(machine->cpu_type, hwdef->prom_addr);
> diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
> index 12c7437..cc0396b 100644
> --- a/hw/xtensa/sim.c
> +++ b/hw/xtensa/sim.c
> @@ -59,6 +59,7 @@ static void xtensa_sim_init(MachineState *machine)
>      ram_addr_t ram_size = machine->ram_size;
>      const char *kernel_filename = machine->kernel_filename;
>      int n;
> +    unsigned int smp_cpus = machine->topo.smp_cpus;
>  
>      for (n = 0; n < smp_cpus; n++) {
>          cpu = XTENSA_CPU(cpu_create(machine->cpu_type));
> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> index e05ef75..f71a15e 100644
> --- a/hw/xtensa/xtfpga.c
> +++ b/hw/xtensa/xtfpga.c
> @@ -238,6 +238,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
>      const unsigned system_io_size = 224 * MiB;
>      uint32_t freq = 10000000;
>      int n;
> +    unsigned int smp_cpus = machine->topo.smp_cpus;
>  
>      if (smp_cpus > 1) {
>          mx_pic = xtensa_mx_pic_init(31);
