Received: from eggs.gnu.org ([2001:4830:134:3::10]:57432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eC6XP-0003F7-Cy
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eC6XI-0007SS-G7
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:15:43 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1509734853-3014-1-git-send-email-cota@braap.org>
	<20171103185610.GA3907@flamenco>
	<20171103200233.GI3111@localhost.localdomain>
	<20171103222407.GA22411@flamenco>
	<20171106141022.GO3111@localhost.localdomain>
	<20171106215454.GB2152@flamenco>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b268828c-4dce-dfb9-deec-414ecda57d9c@amsat.org>
Date: Tue, 7 Nov 2017 13:15:25 -0300
MIME-Version: 1.0
In-Reply-To: <20171106215454.GB2152@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] hw: add .min_cpus and
 .default_cpus fields to machine_class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Hi Emilio,

On 11/06/2017 06:54 PM, Emilio G. Cota wrote:
> On Mon, Nov 06, 2017 at 12:10:22 -0200, Eduardo Habkost wrote:
>> On Fri, Nov 03, 2017 at 06:24:07PM -0400, Emilio G. Cota wrote:
>>>  /**
>>>   * MachineClass:
>>>   * @max_cpus: maximum number of CPUs supported. Default: 1
>>> + * @force_max_cpus: if set, force the global max_cpus to match @max_cpus
>>>   * @min_cpus: minimum number of CPUs supported. Default: 1
>>>   * @default_cpus: number of CPUs instantiated if none are specified. Default: 1
>>>   * @get_hotplug_handler: this function is called during bus-less
>>
>> If we have a field containing the default value for smp_cpus
>> (default_cpus), what about a default_max_cpus field for the
>> default value of max_cpus?  This could make the rules a bit
>> easier to follow.
>>
>> (But I wonder if there's a way we can do this without introducing
>> another MachineClass field and making the initialization code
>> more complex.)
> 
> I don't think the rules are too hard to follow, since they're trivial
> for most machines because the defaults are reasonable (i.e. they
> only set max_cpus, and everything else is set to 1). Some machines
> though are tricky in what can and cannot support, e.g. the Xilinx
> ones we've been dealing with in this thread.
> 
> wrt .default_max_cpus instead of .force_max_cpus: it lets users
> shoot themselves in the foot, so I wouldn't go this route.
> For instance, what do we do if the user passes maxcpus < default_max_cpus?
> max_cpus would be set to maxcpus, yet they could still pass the
> -global override that instantiates two extra CPUs, and at that point
> we'd fail (in TCG) without providing a meaningful error.
> 
> We could increase maxcpus to default_max_cpus, but at that point
> default_max_cpus becomes the same thing as force_max_cpus (!).
> 
> An alternative I've come up with is to have a field that specifies how
> many CPUs could be created in addition to those specified in max_cpus
> (in the Xilinx case these would be the RPUs). Patch below.
> 
>> The fact that MachineClass::max_cpus and the 'max_cpus' globals
>> have completely different meanings makes this confusing enough.
>> Maybe we should rename the 'max_cpus' global variable to
>> 'max_hotplug_cpus'.
> 
> I have no trouble with their different meanings, although I admit
> I am now quite well acquainted with this code so my bias is strong :-)
> 
> Thanks,
> 
> 		Emilio
> 
> ---8<---
> 
> Subject: [PATCH] hw: add .{additional_max,min,default}_cpus fields to
>  machine_class
> 
> max_cpus needs to be an upper bound on the number of vCPUs
> initialized; otherwise TCG region initialization breaks.
> 
> Some boards initialize a hard-coded number of vCPUs, which is not
> captured by the global max_cpus. Fix it by adding the .min_cpus
> field to machine_class.
> 
> A subset of those boards can also instantiate additional vCPUs
> beyond what is specified in -smp, e.g. via -global overrides. To
> ensure that max_cpus remains an upper bound on the number of vCPUs
> that can be instantiated, we also add the .additional_max_cpus field
> to machine_class.
> 
> This commit also changes some user-facing behaviour: we now die if
> -smp is below this hard-coded vCPU minimum instead of silently
> ignoring the passed -smp value (sometimes announcing this by printing
> a warning). However, the introduction of .default_cpus lessens the
> likelihood that users will notice this: if -smp isn't set, we now
> assign the value in .default_cpus to both smp_cpus and max_cpus. IOW,
> if a user does not set -smp, they always get a correct number of vCPUs.
> 
> This change fixes 3468b59 ("tcg: enable multiple TCG contexts in
> softmmu", 2017-10-24), which broke TCG initialization for some
> ARM boards.
> 
> Fixes: 3468b59e18b179bc63c7ce934de912dfa9596122
> Reported-by: Thomas Huth <thuth@redhat.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  hw/arm/exynos4_boards.c | 12 ++++--------
>  hw/arm/raspi.c          |  2 ++
>  hw/arm/xlnx-zcu102.c    |  9 ++++++++-
>  include/hw/boards.h     | 10 ++++++++++
>  vl.c                    | 38 +++++++++++++++++++++++++++++++++++---
>  5 files changed, 59 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
> index f1441ec..750162c 100644
> --- a/hw/arm/exynos4_boards.c
> +++ b/hw/arm/exynos4_boards.c
> @@ -27,7 +27,6 @@
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "sysemu/sysemu.h"
> -#include "sysemu/qtest.h"
>  #include "hw/sysbus.h"
>  #include "net/net.h"
>  #include "hw/arm/arm.h"
> @@ -129,13 +128,6 @@ exynos4_boards_init_common(MachineState *machine,
>                             Exynos4BoardType board_type)
>  {
>      Exynos4BoardState *s = g_new(Exynos4BoardState, 1);
> -    MachineClass *mc = MACHINE_GET_CLASS(machine);
> -
> -    if (smp_cpus != EXYNOS4210_NCPUS && !qtest_enabled()) {
> -        error_report("%s board supports only %d CPU cores, ignoring smp_cpus"
> -                     " value",
> -                     mc->name, EXYNOS4210_NCPUS);
> -    }
>  
>      exynos4_board_binfo.ram_size = exynos4_board_ram_size[board_type];
>      exynos4_board_binfo.board_id = exynos4_board_id[board_type];
> @@ -189,6 +181,8 @@ static void nuri_class_init(ObjectClass *oc, void *data)
>      mc->desc = "Samsung NURI board (Exynos4210)";
>      mc->init = nuri_init;
>      mc->max_cpus = EXYNOS4210_NCPUS;
> +    mc->min_cpus = EXYNOS4210_NCPUS;
> +    mc->default_cpus = EXYNOS4210_NCPUS;
>      mc->ignore_memory_transaction_failures = true;
>  }
>  
> @@ -205,6 +199,8 @@ static void smdkc210_class_init(ObjectClass *oc, void *data)
>      mc->desc = "Samsung SMDKC210 board (Exynos4210)";
>      mc->init = smdkc210_init;
>      mc->max_cpus = EXYNOS4210_NCPUS;
> +    mc->min_cpus = EXYNOS4210_NCPUS;
> +    mc->default_cpus = EXYNOS4210_NCPUS;
>      mc->ignore_memory_transaction_failures = true;
>  }
>  
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 5941c9f..cd5fa8c 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -167,6 +167,8 @@ static void raspi2_machine_init(MachineClass *mc)
>      mc->no_floppy = 1;
>      mc->no_cdrom = 1;
>      mc->max_cpus = BCM2836_NCPUS;
> +    mc->min_cpus = BCM2836_NCPUS;
> +    mc->default_cpus = BCM2836_NCPUS;
>      mc->default_ram_size = 1024 * 1024 * 1024;
>      mc->ignore_memory_transaction_failures = true;
>  };
> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> index e2d15a1..0f1837e 100644
> --- a/hw/arm/xlnx-zcu102.c
> +++ b/hw/arm/xlnx-zcu102.c
> @@ -185,6 +185,10 @@ static void xlnx_ep108_machine_class_init(ObjectClass *oc, void *data)
>      mc->block_default_type = IF_IDE;
>      mc->units_per_default_bus = 1;
>      mc->ignore_memory_transaction_failures = true;
> +    mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
> +    mc->max_additional_cpus = XLNX_ZYNQMP_NUM_RPU_CPUS;
> +    mc->min_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
> +    mc->default_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
>  }
>  
>  static const TypeInfo xlnx_ep108_machine_init_typeinfo = {
> @@ -240,7 +244,10 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
>      mc->block_default_type = IF_IDE;
>      mc->units_per_default_bus = 1;
>      mc->ignore_memory_transaction_failures = true;
> -    mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
> +    mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
> +    mc->max_additional_cpus = XLNX_ZYNQMP_NUM_RPU_CPUS;
> +    mc->min_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
> +    mc->default_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
>  }
>  
>  static const TypeInfo xlnx_zcu102_machine_init_typeinfo = {
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 191a5b3..be582dd 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -102,6 +102,13 @@ typedef struct {
>  
>  /**
>   * MachineClass:
> + * @max_cpus: maximum number of CPUs supported. Default: 1
> + * @max_additional_cpus: # of CPUs that can be instantiated in addition to those
> + *    instantiated with -smp. For instance, if a machine has 4 main CPUs and 2
> + *    optional CPUs (e.g. instantiated via -global overrides), then @max_cpus
> + *    and @max_additional_cpus will be set to 4 and 2, respectively. Default: 0
> + * @min_cpus: minimum number of CPUs supported. Default: 1
> + * @default_cpus: number of CPUs instantiated if none are specified. Default: 1
>   * @get_hotplug_handler: this function is called during bus-less
>   *    device hotplug. If defined it returns pointer to an instance
>   *    of HotplugHandler object, which handles hotplug operation
> @@ -167,6 +174,9 @@ struct MachineClass {
>      BlockInterfaceType block_default_type;
>      int units_per_default_bus;
>      int max_cpus;
> +    int max_additional_cpus;
> +    int min_cpus;
> +    int default_cpus;
>      unsigned int no_serial:1,
>          no_parallel:1,
>          use_virtcon:1,
> diff --git a/vl.c b/vl.c
> index ec29909..e3ee36e 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -160,8 +160,8 @@ Chardev *virtcon_hds[MAX_VIRTIO_CONSOLES];
>  Chardev *sclp_hds[MAX_SCLP_CONSOLES];
>  int win2k_install_hack = 0;
>  int singlestep = 0;
> -int smp_cpus = 1;
> -unsigned int max_cpus = 1;
> +int smp_cpus;
> +unsigned int max_cpus;
>  int smp_cores = 1;
>  int smp_threads = 1;
>  int acpi_enabled = 1;
> @@ -4330,12 +4330,44 @@ int main(int argc, char **argv, char **envp)
>      smp_parse(qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
>  
>      machine_class->max_cpus = machine_class->max_cpus ?: 1; /* Default to UP */
> +    machine_class->min_cpus = machine_class->min_cpus ?: 1;
> +    machine_class->default_cpus = machine_class->default_cpus ?: 1;
> +
> +    /* if -smp is not set, default to mc->default_cpus */
> +    if (!smp_cpus) {
> +        smp_cpus = machine_class->default_cpus;
> +        max_cpus = machine_class->default_cpus;
> +    }
> +
> +    /* sanity-check smp_cpus and max_cpus */
> +    if (smp_cpus < machine_class->min_cpus) {
> +        error_report("Invalid SMP CPUs %d. The min CPUs "
> +                     "supported by machine '%s' is %d", smp_cpus,
> +                     machine_class->name, machine_class->min_cpus);
> +        exit(1);
> +    }
>      if (max_cpus > machine_class->max_cpus) {
> -        error_report("Invalid SMP CPUs %d. The max CPUs "
> +        error_report("Invalid max SMP CPUs %d. The max CPUs "
>                       "supported by machine '%s' is %d", max_cpus,
>                       machine_class->name, machine_class->max_cpus);
>          exit(1);
>      }
> +    if (max_cpus < machine_class->min_cpus) {
> +        error_report("Invalid max SMP CPUs %d. The min CPUs "
> +                     "supported by machine '%s' is %d", max_cpus,
> +                     machine_class->name, machine_class->min_cpus);
> +        exit(1);
> +    }
> +
> +    /*
> +     * Some boards can instantiate additional CPUs, e.g. by overriding
> +     * device params via -global arguments. Update max_cpus so that
> +     * we are sure to have an upper bound on the maximum number of
> +     * vCPUs that might be instantiated.
> +     */
> +    if (machine_class->max_additional_cpus) {
> +        max_cpus += machine_class->max_additional_cpus;
> +    }

This does fix 3468b59, so:
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

I'd rather think of another way, and wait for Richard review,
but for the time frame left for next release:
Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  
>      /*
>       * Get the default machine options from the machine if it is not already
> 
