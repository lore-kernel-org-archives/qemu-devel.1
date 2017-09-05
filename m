Received: from eggs.gnu.org ([2001:4830:134:3::10]:37793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dpLhx-0007KY-Di
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 17:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dpLhp-0001zu-7k
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 17:48:33 -0400
MIME-Version: 1.0
In-Reply-To: <20170905213152.GG17184@localhost.localdomain>
References: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
	<1504533662-198084-7-git-send-email-imammedo@redhat.com>
	<20170905213152.GG17184@localhost.localdomain>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 Sep 2017 14:47:52 -0700
Message-ID: <CAKmqyKPWDmVYJceYao7NkD5svWqN_fYbDoUJ4uLNFdAhv+kFwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 6/6] arm: drop intermadiate cpu_model ->
 cpu type parsing and use cpu type directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Rob Herring <robh@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>

On Tue, Sep 5, 2017 at 2:31 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Mon, Sep 04, 2017 at 04:01:02PM +0200, Igor Mammedov wrote:
>> there are 2 use cases to deal with:
>>   1: fixed CPU models per board/soc
>>   2: boards with user configurable cpu_model and fallback to
>>      default cpu_model if user hasn't specified one explicitly
>>
>> For the 1st
>>   drop intermediate cpu_model parsing and use const cpu type
>>   directly, which replaces:
>>      typename = object_class_get_name(
>>            cpu_class_by_name(TYPE_ARM_CPU, cpu_model))
>>      object_new(typename)
>>   with
>>      object_new(FOO_CPU_TYPE_NAME)
>>   or
>>      cpu_generic_init(BASE_CPU_TYPE, "my cpu model")
>>   with
>>      cpu_create(FOO_CPU_TYPE_NAME)
>>
>> as result 1st use case doesn't have to invoke not necessary
>> translation and not needed code is removed.
>>
>> For the 2nd
>>  1: set default cpu type with MachineClass::default_cpu_type and
>>  2: use generic cpu_model parsing that done before machine_init()
>>     is run and:
>>     2.1: drop custom cpu_model parsing where pattern is:
>>        typename = object_class_get_name(
>>            cpu_class_by_name(TYPE_ARM_CPU, cpu_model))
>>        [parse_features(typename, cpu_model, &err) ]
>>
>>     2.2: or replace cpu_generic_init() which does what
>>          2.1 does + create_cpu(typename) with just
>>          create_cpu(machine->cpu_type)
>> as result cpu_name -> cpu_type translation is done using
>> generic machine code one including parsing optional features
>> if supported/present (removes a bunch of duplicated cpu_model
>> parsing code) and default cpu type is defined in an uniform way
>> within machine_class_init callbacks instead of adhoc places
>> in boadr's machine_init code.
>>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>> CC: Peter Maydell <peter.maydell@linaro.org>
>> CC: Igor Mitsyanko <i.mitsyanko@gmail.com>
>> CC: Rob Herring <robh@kernel.org>
>> CC: Andrzej Zaborowski <balrogg@gmail.com>
>> CC: Jan Kiszka <jan.kiszka@web.de>
>> CC: Alistair Francis <alistair@alistair23.me>
>> CC: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
>> CC: qemu-arm@nongnu.org
>> ---
>>  include/hw/arm/armv7m.h        |  2 +-
>>  include/hw/arm/aspeed_soc.h    |  2 +-
>>  include/hw/arm/stm32f205_soc.h |  2 +-
>>  target/arm/cpu.h               |  3 +++
>>  hw/arm/armv7m.c                | 40 +++++-------------------------------
>>  hw/arm/aspeed_soc.c            | 13 +++++-------
>>  hw/arm/collie.c                | 10 +++------
>>  hw/arm/exynos4210.c            |  6 +-----
>>  hw/arm/gumstix.c               |  5 +++--
>>  hw/arm/highbank.c              | 10 ++++-----
>>  hw/arm/integratorcp.c          | 30 ++-------------------------
>>  hw/arm/mainstone.c             |  9 ++++-----
>>  hw/arm/mps2.c                  | 17 +++++++---------
>>  hw/arm/musicpal.c              |  7 ++-----
>>  hw/arm/netduino2.c             |  2 +-
>>  hw/arm/nseries.c               |  4 +++-
>>  hw/arm/omap1.c                 |  7 ++-----
>>  hw/arm/omap2.c                 |  4 ++--
>>  hw/arm/omap_sx1.c              |  5 ++++-
>>  hw/arm/palm.c                  |  5 +++--
>>  hw/arm/pxa2xx.c                | 10 ++++-----
>>  hw/arm/realview.c              | 25 +++++------------------
>>  hw/arm/spitz.c                 | 12 ++++++-----
>>  hw/arm/stellaris.c             | 16 +++++++--------
>>  hw/arm/stm32f205_soc.c         |  4 ++--
>>  hw/arm/strongarm.c             | 10 +++------
>>  hw/arm/tosa.c                  |  4 ----
>>  hw/arm/versatilepb.c           | 15 +++-----------
>>  hw/arm/vexpress.c              | 32 +++++++++--------------------
>>  hw/arm/virt.c                  | 46 +++++++++---------------------------------
>>  hw/arm/xilinx_zynq.c           | 10 ++-------
>>  hw/arm/z2.c                    |  9 +++------
>>  target/arm/cpu.c               |  2 +-
>>  33 files changed, 114 insertions(+), 264 deletions(-)
>>
>> diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
>> index a9b3f2a..8496743 100644
>> --- a/include/hw/arm/armv7m.h
>> +++ b/include/hw/arm/armv7m.h
>> @@ -55,7 +55,7 @@ typedef struct ARMv7MState {
>>      MemoryRegion container;
>>
>>      /* Properties */
>> -    char *cpu_model;
>> +    char *cpu_type;
>>      /* MemoryRegion the board provides to us (with its devices, RAM, etc) */
>>      MemoryRegion *board_memory;
>>  } ARMv7MState;
>> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
>> index 0b88baa..f26914a 100644
>> --- a/include/hw/arm/aspeed_soc.h
>> +++ b/include/hw/arm/aspeed_soc.h
>> @@ -49,7 +49,7 @@ typedef struct AspeedSoCState {
>>
>>  typedef struct AspeedSoCInfo {
>>      const char *name;
>> -    const char *cpu_model;
>> +    const char *cpu_type;
>>      uint32_t silicon_rev;
>>      hwaddr sdram_base;
>>      uint64_t sram_size;
>> diff --git a/include/hw/arm/stm32f205_soc.h b/include/hw/arm/stm32f205_soc.h
>> index e2dce11..922a733 100644
>> --- a/include/hw/arm/stm32f205_soc.h
>> +++ b/include/hw/arm/stm32f205_soc.h
>> @@ -52,7 +52,7 @@ typedef struct STM32F205State {
>>      SysBusDevice parent_obj;
>>      /*< public >*/
>>
>> -    char *cpu_model;
>> +    char *cpu_type;
>>
>>      ARMv7MState armv7m;
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 5932ef1..3e1ba19 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -2002,6 +2002,9 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
>>
>>  #define cpu_init(cpu_model) cpu_generic_init(TYPE_ARM_CPU, cpu_model)
>>
>> +#define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
>> +#define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
>> +
>>  #define cpu_signal_handler cpu_arm_signal_handler
>>  #define cpu_list arm_cpu_list
>>
>> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
>> index c8a11f2..9c45f26 100644
>> --- a/hw/arm/armv7m.c
>> +++ b/hw/arm/armv7m.c
>> @@ -163,10 +163,6 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
>>      SysBusDevice *sbd;
>>      Error *err = NULL;
>>      int i;
>> -    char **cpustr;
>> -    ObjectClass *oc;
>> -    const char *typename;
>> -    CPUClass *cc;
>>
>>      if (!s->board_memory) {
>>          error_setg(errp, "memory property was not set");
>> @@ -175,29 +171,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
>>
>>      memory_region_add_subregion_overlap(&s->container, 0, s->board_memory, -1);
>>
>> -    cpustr = g_strsplit(s->cpu_model, ",", 2);
>> -
>> -    oc = cpu_class_by_name(TYPE_ARM_CPU, cpustr[0]);
>> -    if (!oc) {
>> -        error_setg(errp, "Unknown CPU model %s", cpustr[0]);
>> -        g_strfreev(cpustr);
>> -        return;
>> -    }
>> -
>> -    cc = CPU_CLASS(oc);
>> -    typename = object_class_get_name(oc);
>> -    cc->parse_features(typename, cpustr[1], &err);
>> -    g_strfreev(cpustr);
>> -    if (err) {
>> -        error_propagate(errp, err);
>> -        return;
>> -    }
>> -
>> -    s->cpu = ARM_CPU(object_new(typename));
>> -    if (!s->cpu) {
>> -        error_setg(errp, "Unknown CPU model %s", s->cpu_model);
>> -        return;
>> -    }
>> +    s->cpu = ARM_CPU(object_new(s->cpu_type));
>
> Nice.
>
>>
>>      object_property_set_link(OBJECT(s->cpu), OBJECT(&s->container), "memory",
>>                               &error_abort);
>> @@ -253,7 +227,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
>>  }
>>
>>  static Property armv7m_properties[] = {
>> -    DEFINE_PROP_STRING("cpu-model", ARMv7MState, cpu_model),
>> +    DEFINE_PROP_STRING("cpu-type", ARMv7MState, cpu_type),
>
> Are we 100% sure the cpu-model property is never manually set by
> users?
>
>
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>>
>> @@ -285,20 +259,16 @@ static void armv7m_reset(void *opaque)
>>     Returns the ARMv7M device.  */
>>
>>  DeviceState *armv7m_init(MemoryRegion *system_memory, int mem_size, int num_irq,
>> -                      const char *kernel_filename, const char *cpu_model)
>> +                      const char *kernel_filename, const char *cpu_type)
>>  {
>>      DeviceState *armv7m;
>>
>> -    if (cpu_model == NULL) {
>> -        cpu_model = "cortex-m3";
>> -    }
>> -
>
> I was going to suggest doing the default_cpu_type stuff in a
> separate patch, but it might require touching those lines twice.
> So I guess this is OK.
>
>
>>      armv7m = qdev_create(NULL, "armv7m");
>>      qdev_prop_set_uint32(armv7m, "num-irq", num_irq);
>> -    qdev_prop_set_string(armv7m, "cpu-model", cpu_model);
>> +    qdev_prop_set_string(armv7m, "cpu-type", cpu_type);
>>      object_property_set_link(OBJECT(armv7m), OBJECT(get_system_memory()),
>>                                       "memory", &error_abort);
>> -    /* This will exit with an error if the user passed us a bad cpu_model */
>> +    /* This will exit with an error if the user passed us a bad cpu_type */
>>      qdev_init_nofail(armv7m);
>>
>>      armv7m_load_kernel(ARM_CPU(first_cpu), kernel_filename, mem_size);
>> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
>> index 5529024..cd7bb94 100644
>> --- a/hw/arm/aspeed_soc.c
>> +++ b/hw/arm/aspeed_soc.c
>> @@ -54,7 +54,7 @@ static const char *aspeed_soc_ast2500_typenames[] = {
>>  static const AspeedSoCInfo aspeed_socs[] = {
>>      {
>>          .name         = "ast2400-a0",
>> -        .cpu_model    = "arm926",
>> +        .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
>>          .silicon_rev  = AST2400_A0_SILICON_REV,
>>          .sdram_base   = AST2400_SDRAM_BASE,
>>          .sram_size    = 0x8000,
>> @@ -65,7 +65,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
>>          .wdts_num     = 2,
>>      }, {
>>          .name         = "ast2400-a1",
>> -        .cpu_model    = "arm926",
>> +        .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
>>          .silicon_rev  = AST2400_A1_SILICON_REV,
>>          .sdram_base   = AST2400_SDRAM_BASE,
>>          .sram_size    = 0x8000,
>> @@ -76,7 +76,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
>>          .wdts_num     = 2,
>>      }, {
>>          .name         = "ast2400",
>> -        .cpu_model    = "arm926",
>> +        .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
>>          .silicon_rev  = AST2400_A0_SILICON_REV,
>>          .sdram_base   = AST2400_SDRAM_BASE,
>>          .sram_size    = 0x8000,
>> @@ -87,7 +87,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
>>          .wdts_num     = 2,
>>      }, {
>>          .name         = "ast2500-a1",
>> -        .cpu_model    = "arm1176",
>> +        .cpu_type     = ARM_CPU_TYPE_NAME("arm1176"),
>>          .silicon_rev  = AST2500_A1_SILICON_REV,
>>          .sdram_base   = AST2500_SDRAM_BASE,
>>          .sram_size    = 0x9000,
>> @@ -128,13 +128,10 @@ static void aspeed_soc_init(Object *obj)
>>  {
>>      AspeedSoCState *s = ASPEED_SOC(obj);
>>      AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>> -    char *cpu_typename;
>>      int i;
>>
>> -    cpu_typename = g_strdup_printf("%s-" TYPE_ARM_CPU, sc->info->cpu_model);
>> -    object_initialize(&s->cpu, sizeof(s->cpu), cpu_typename);
>> +    object_initialize(&s->cpu, sizeof(s->cpu), sc->info->cpu_type);
>>      object_property_add_child(obj, "cpu", OBJECT(&s->cpu), NULL);
>> -    g_free(cpu_typename);
>>
>
> Nice.
>
>>      object_initialize(&s->vic, sizeof(s->vic), TYPE_ASPEED_VIC);
>>      object_property_add_child(obj, "vic", OBJECT(&s->vic), NULL);
>> diff --git a/hw/arm/collie.c b/hw/arm/collie.c
>> index 2e69531..f043cd8 100644
>> --- a/hw/arm/collie.c
>> +++ b/hw/arm/collie.c
>> @@ -18,7 +18,7 @@
>>  #include "hw/block/flash.h"
>>  #include "sysemu/block-backend.h"
>>  #include "exec/address-spaces.h"
>> -#include "qom/cpu.h"
>> +#include "cpu.h"
>>
>>  static struct arm_boot_info collie_binfo = {
>>      .loader_start = SA_SDCS0,
>> @@ -27,7 +27,6 @@ static struct arm_boot_info collie_binfo = {
>>
>>  static void collie_init(MachineState *machine)
>>  {
>> -    const char *cpu_model = machine->cpu_model;
>>      const char *kernel_filename = machine->kernel_filename;
>>      const char *kernel_cmdline = machine->kernel_cmdline;
>>      const char *initrd_filename = machine->initrd_filename;
>> @@ -35,11 +34,7 @@ static void collie_init(MachineState *machine)
>>      DriveInfo *dinfo;
>>      MemoryRegion *sysmem = get_system_memory();
>>
>> -    if (!cpu_model) {
>> -        cpu_model = "sa1110";
>> -    }
>> -
>> -    s = sa1110_init(sysmem, collie_binfo.ram_size, cpu_model);
>> +    s = sa1110_init(sysmem, collie_binfo.ram_size, machine->cpu_type);
>>
>>      dinfo = drive_get(IF_PFLASH, 0, 0);
>>      pflash_cfi01_register(SA_CS0, NULL, "collie.fl1", 0x02000000,
>> @@ -64,6 +59,7 @@ static void collie_machine_init(MachineClass *mc)
>>  {
>>      mc->desc = "Sharp SL-5500 (Collie) PDA (SA-1110)";
>>      mc->init = collie_init;
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("sa1110");
>>  }
>>
>>  DEFINE_MACHINE("collie", collie_machine_init)
>> diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
>> index f9e79f3..81f12e3 100644
>> --- a/hw/arm/exynos4210.c
>> +++ b/hw/arm/exynos4210.c
>> @@ -169,15 +169,11 @@ Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
>>      Exynos4210State *s = g_new(Exynos4210State, 1);
>>      qemu_irq gate_irq[EXYNOS4210_NCPUS][EXYNOS4210_IRQ_GATE_NINPUTS];
>>      SysBusDevice *busdev;
>> -    ObjectClass *cpu_oc;
>>      DeviceState *dev;
>>      int i, n;
>>
>> -    cpu_oc = cpu_class_by_name(TYPE_ARM_CPU, "cortex-a9");
>> -    assert(cpu_oc);
>> -
>>      for (n = 0; n < EXYNOS4210_NCPUS; n++) {
>> -        Object *cpuobj = object_new(object_class_get_name(cpu_oc));
>> +        Object *cpuobj = object_new(ARM_CPU_TYPE_NAME("cortex-a9"));
>>
>>          /* By default A9 CPUs have EL3 enabled.  This board does not currently
>>           * support EL3 so the CPU EL3 property is disabled before realization.
>> diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
>> index d59d9ba..2b66bb7 100644
>> --- a/hw/arm/gumstix.c
>> +++ b/hw/arm/gumstix.c
>> @@ -44,6 +44,7 @@
>>  #include "sysemu/block-backend.h"
>>  #include "exec/address-spaces.h"
>>  #include "sysemu/qtest.h"
>> +#include "cpu.h"
>>
>>  static const int sector_len = 128 * 1024;
>>
>> @@ -86,7 +87,6 @@ static void connex_init(MachineState *machine)
>>
>>  static void verdex_init(MachineState *machine)
>>  {
>> -    const char *cpu_model = machine->cpu_model;
>>      PXA2xxState *cpu;
>>      DriveInfo *dinfo;
>>      int be;
>> @@ -95,7 +95,7 @@ static void verdex_init(MachineState *machine)
>>      uint32_t verdex_rom = 0x02000000;
>>      uint32_t verdex_ram = 0x10000000;
>>
>> -    cpu = pxa270_init(address_space_mem, verdex_ram, cpu_model ?: "pxa270-c0");
>> +    cpu = pxa270_init(address_space_mem, verdex_ram, machine->cpu_type);
>>
>>      dinfo = drive_get(IF_PFLASH, 0, 0);
>>      if (!dinfo && !qtest_enabled()) {
>> @@ -142,6 +142,7 @@ static void verdex_class_init(ObjectClass *oc, void *data)
>>
>>      mc->desc = "Gumstix Verdex (PXA270)";
>>      mc->init = verdex_init;
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c0");
>>  }
>>
>>  static const TypeInfo verdex_type = {
>> diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
>> index 20e60f1..0d7190a 100644
>> --- a/hw/arm/highbank.c
>> +++ b/hw/arm/highbank.c
>> @@ -219,7 +219,6 @@ enum cxmachines {
>>  static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
>>  {
>>      ram_addr_t ram_size = machine->ram_size;
>> -    const char *cpu_model = machine->cpu_model;
>>      const char *kernel_filename = machine->kernel_filename;
>>      const char *kernel_cmdline = machine->kernel_cmdline;
>>      const char *initrd_filename = machine->initrd_filename;
>> @@ -236,19 +235,20 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
>>
>>      switch (machine_id) {
>>      case CALXEDA_HIGHBANK:
>> -        cpu_model = "cortex-a9";
>> +        machine->cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
>>          break;
>>      case CALXEDA_MIDWAY:
>> -        cpu_model = "cortex-a15";
>> +        machine->cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
>>          break;
>> +    default:
>> +        assert(0);
>>      }
>
> Why not delete this switch statement completely and set
> default_cpu_type at midway_class_init() and
> highbank_class_init()?
>
>
>>
>>      for (n = 0; n < smp_cpus; n++) {
>> -        ObjectClass *oc = cpu_class_by_name(TYPE_ARM_CPU, cpu_model);
>>          Object *cpuobj;
>>          ARMCPU *cpu;
>>
>> -        cpuobj = object_new(object_class_get_name(oc));
>> +        cpuobj = object_new(machine->cpu_type);
>>          cpu = ARM_CPU(cpuobj);
>>
>>          object_property_set_int(cpuobj, QEMU_PSCI_CONDUIT_SMC,
>> diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
>> index d9530ed..44d247e 100644
>> --- a/hw/arm/integratorcp.c
>> +++ b/hw/arm/integratorcp.c
>> @@ -572,46 +572,19 @@ static struct arm_boot_info integrator_binfo = {
>>  static void integratorcp_init(MachineState *machine)
>>  {
>>      ram_addr_t ram_size = machine->ram_size;
>> -    const char *cpu_model = machine->cpu_model;
>>      const char *kernel_filename = machine->kernel_filename;
>>      const char *kernel_cmdline = machine->kernel_cmdline;
>>      const char *initrd_filename = machine->initrd_filename;
>> -    char **cpustr;
>> -    ObjectClass *cpu_oc;
>> -    CPUClass *cc;
>>      Object *cpuobj;
>>      ARMCPU *cpu;
>> -    const char *typename;
>>      MemoryRegion *address_space_mem = get_system_memory();
>>      MemoryRegion *ram = g_new(MemoryRegion, 1);
>>      MemoryRegion *ram_alias = g_new(MemoryRegion, 1);
>>      qemu_irq pic[32];
>>      DeviceState *dev, *sic, *icp;
>>      int i;
>> -    Error *err = NULL;
>>
>> -    if (!cpu_model) {
>> -        cpu_model = "arm926";
>> -    }
>> -
>> -    cpustr = g_strsplit(cpu_model, ",", 2);
>> -
>> -    cpu_oc = cpu_class_by_name(TYPE_ARM_CPU, cpustr[0]);
>> -    if (!cpu_oc) {
>> -        fprintf(stderr, "Unable to find CPU definition\n");
>> -        exit(1);
>> -    }
>> -    typename = object_class_get_name(cpu_oc);
>> -
>> -    cc = CPU_CLASS(cpu_oc);
>> -    cc->parse_features(typename, cpustr[1], &err);
>> -    g_strfreev(cpustr);
>> -    if (err) {
>> -        error_report_err(err);
>> -        exit(1);
>> -    }
>> -
>> -    cpuobj = object_new(typename);
>> +    cpuobj = object_new(machine->cpu_type);
>
> Nice.
>
>>
>>      /* By default ARM1176 CPUs have EL3 enabled.  This board does not
>>       * currently support EL3 so the CPU EL3 property is disabled before
>> @@ -681,6 +654,7 @@ static void integratorcp_machine_init(MachineClass *mc)
>>  {
>>      mc->desc = "ARM Integrator/CP (ARM926EJ-S)";
>>      mc->init = integratorcp_init;
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
>>  }
>>
>>  DEFINE_MACHINE("integratorcp", integratorcp_machine_init)
>> diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
>> index fb268e6..2b13d30 100644
>> --- a/hw/arm/mainstone.c
>> +++ b/hw/arm/mainstone.c
>> @@ -24,6 +24,7 @@
>>  #include "hw/sysbus.h"
>>  #include "exec/address-spaces.h"
>>  #include "sysemu/qtest.h"
>> +#include "cpu.h"
>>
>>  /* Device addresses */
>>  #define MST_FPGA_PHYS        0x08000000
>> @@ -121,13 +122,10 @@ static void mainstone_common_init(MemoryRegion *address_space_mem,
>>      int i;
>>      int be;
>>      MemoryRegion *rom = g_new(MemoryRegion, 1);
>> -    const char *cpu_model = machine->cpu_model;
>> -
>> -    if (!cpu_model)
>> -        cpu_model = "pxa270-c5";
>>
>>      /* Setup CPU & memory */
>> -    mpu = pxa270_init(address_space_mem, mainstone_binfo.ram_size, cpu_model);
>> +    mpu = pxa270_init(address_space_mem, mainstone_binfo.ram_size,
>> +                      machine->cpu_type);
>>      memory_region_init_ram(rom, NULL, "mainstone.rom", MAINSTONE_ROM,
>>                             &error_fatal);
>>      memory_region_set_readonly(rom, true);
>> @@ -196,6 +194,7 @@ static void mainstone2_machine_init(MachineClass *mc)
>>  {
>>      mc->desc = "Mainstone II (PXA27x)";
>>      mc->init = mainstone_init;
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c5");
>>  }
>>
>>  DEFINE_MACHINE("mainstone", mainstone2_machine_init)
>> diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
>> index abb0ab6..aeaad80 100644
>> --- a/hw/arm/mps2.c
>> +++ b/hw/arm/mps2.c
>> @@ -46,7 +46,6 @@ typedef enum MPS2FPGAType {
>>  typedef struct {
>>      MachineClass parent;
>>      MPS2FPGAType fpga_type;
>> -    const char *cpu_model;
>>      uint32_t scc_id;
>>  } MPS2MachineClass;
>>
>> @@ -107,14 +106,12 @@ static void mps2_common_init(MachineState *machine)
>>      MPS2MachineState *mms = MPS2_MACHINE(machine);
>>      MPS2MachineClass *mmc = MPS2_MACHINE_GET_CLASS(machine);
>>      MemoryRegion *system_memory = get_system_memory();
>> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
>>      DeviceState *armv7m, *sccdev;
>>
>> -    if (!machine->cpu_model) {
>> -        machine->cpu_model = mmc->cpu_model;
>> -    }
>> -
>> -    if (strcmp(machine->cpu_model, mmc->cpu_model) != 0) {
>> -        error_report("This board can only be used with CPU %s", mmc->cpu_model);
>> +    if (strcmp(machine->cpu_type, mc->default_cpu_type) != 0) {
>> +        error_report("This board can only be used with CPU %s",
>> +                     mc->default_cpu_type);
>
> Suggestion for later: a generic mechanism to let the machine
> class validate the CPU type this way.  Maybe a
> MachineClass::configurable_cpu_type=false field?
>
>
>>          exit(1);
>>      }
>>
>> @@ -188,7 +185,7 @@ static void mps2_common_init(MachineState *machine)
>>      default:
>>          g_assert_not_reached();
>>      }
>> -    qdev_prop_set_string(armv7m, "cpu-model", machine->cpu_model);
>> +    qdev_prop_set_string(armv7m, "cpu-type", machine->cpu_type);
>>      object_property_set_link(OBJECT(&mms->armv7m), OBJECT(system_memory),
>>                               "memory", &error_abort);
>>      object_property_set_bool(OBJECT(&mms->armv7m), true, "realized",
>> @@ -339,7 +336,7 @@ static void mps2_an385_class_init(ObjectClass *oc, void *data)
>>
>>      mc->desc = "ARM MPS2 with AN385 FPGA image for Cortex-M3";
>>      mmc->fpga_type = FPGA_AN385;
>> -    mmc->cpu_model = "cortex-m3";
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
>>      mmc->scc_id = 0x41040000 | (385 << 4);
>>  }
>>
>> @@ -350,7 +347,7 @@ static void mps2_an511_class_init(ObjectClass *oc, void *data)
>>
>>      mc->desc = "ARM MPS2 with AN511 DesignStart FPGA image for Cortex-M3";
>>      mmc->fpga_type = FPGA_AN511;
>> -    mmc->cpu_model = "cortex-m3";
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
>>      mmc->scc_id = 0x4104000 | (511 << 4);
>>  }
>>
>> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
>> index 64c8e09..9b2000d 100644
>> --- a/hw/arm/musicpal.c
>> +++ b/hw/arm/musicpal.c
>> @@ -1570,7 +1570,6 @@ static struct arm_boot_info musicpal_binfo = {
>>
>>  static void musicpal_init(MachineState *machine)
>>  {
>> -    const char *cpu_model = machine->cpu_model;
>>      const char *kernel_filename = machine->kernel_filename;
>>      const char *kernel_cmdline = machine->kernel_cmdline;
>>      const char *initrd_filename = machine->initrd_filename;
>> @@ -1590,10 +1589,7 @@ static void musicpal_init(MachineState *machine)
>>      MemoryRegion *ram = g_new(MemoryRegion, 1);
>>      MemoryRegion *sram = g_new(MemoryRegion, 1);
>>
>> -    if (!cpu_model) {
>> -        cpu_model = "arm926";
>> -    }
>> -    cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, cpu_model));
>> +    cpu = ARM_CPU(cpu_create(machine->cpu_type));
>>
>>      /* For now we use a fixed - the original - RAM size */
>>      memory_region_allocate_system_memory(ram, NULL, "musicpal.ram",
>> @@ -1714,6 +1710,7 @@ static void musicpal_machine_init(MachineClass *mc)
>>  {
>>      mc->desc = "Marvell 88w8618 / MusicPal (ARM926EJ-S)";
>>      mc->init = musicpal_init;
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
>>  }
>>
>>  DEFINE_MACHINE("musicpal", musicpal_machine_init)
>> diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
>> index 3cfe332..4790824 100644
>> --- a/hw/arm/netduino2.c
>> +++ b/hw/arm/netduino2.c
>> @@ -34,7 +34,7 @@ static void netduino2_init(MachineState *machine)
>>      DeviceState *dev;
>>
>>      dev = qdev_create(NULL, TYPE_STM32F205_SOC);
>> -    qdev_prop_set_string(dev, "cpu-model", "cortex-m3");
>> +    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
>>      object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
>>
>>      armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
>> diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
>> index 503a3b6..b41850e 100644
>> --- a/hw/arm/nseries.c
>> +++ b/hw/arm/nseries.c
>> @@ -1310,7 +1310,7 @@ static void n8x0_init(MachineState *machine,
>>      struct n800_s *s = (struct n800_s *) g_malloc0(sizeof(*s));
>>      int sdram_size = binfo->ram_size;
>>
>> -    s->mpu = omap2420_mpu_init(sysmem, sdram_size, machine->cpu_model);
>> +    s->mpu = omap2420_mpu_init(sysmem, sdram_size, machine->cpu_type);
>>
>>      /* Setup peripherals
>>       *
>> @@ -1425,6 +1425,7 @@ static void n800_class_init(ObjectClass *oc, void *data)
>>      mc->desc = "Nokia N800 tablet aka. RX-34 (OMAP2420)";
>>      mc->init = n800_init;
>>      mc->default_boot_order = "";
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm1136-r2");
>>  }
>>
>>  static const TypeInfo n800_type = {
>> @@ -1440,6 +1441,7 @@ static void n810_class_init(ObjectClass *oc, void *data)
>>      mc->desc = "Nokia N810 tablet aka. RX-44 (OMAP2420)";
>>      mc->init = n810_init;
>>      mc->default_boot_order = "";
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm1136-r2");
>>  }
>>
>>  static const TypeInfo n810_type = {
>> diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
>> index 04e65ce..b3e7625 100644
>> --- a/hw/arm/omap1.c
>> +++ b/hw/arm/omap1.c
>> @@ -3850,7 +3850,7 @@ static int omap_validate_tipb_mpui_addr(struct omap_mpu_state_s *s,
>>
>>  struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
>>                  unsigned long sdram_size,
>> -                const char *core)
>> +                const char *cpu_type)
>>  {
>>      int i;
>>      struct omap_mpu_state_s *s = g_new0(struct omap_mpu_state_s, 1);
>> @@ -3858,12 +3858,9 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
>>      DriveInfo *dinfo;
>>      SysBusDevice *busdev;
>>
>> -    if (!core)
>> -        core = "ti925t";
>> -
>>      /* Core */
>>      s->mpu_model = omap310;
>> -    s->cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, core));
>> +    s->cpu = ARM_CPU(cpu_create(cpu_type));
>>      s->sdram_size = sdram_size;
>>      s->sram_size = OMAP15XX_SRAM_SIZE;
>>
>> diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
>> index 5821477..3f6076e 100644
>> --- a/hw/arm/omap2.c
>> +++ b/hw/arm/omap2.c
>> @@ -2250,7 +2250,7 @@ static const struct dma_irq_map omap2_dma_irq_map[] = {
>>
>>  struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
>>                  unsigned long sdram_size,
>> -                const char *core)
>> +                const char *cpu_type)
>>  {
>>      struct omap_mpu_state_s *s = g_new0(struct omap_mpu_state_s, 1);
>>      qemu_irq dma_irqs[4];
>> @@ -2261,7 +2261,7 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
>>
>>      /* Core */
>>      s->mpu_model = omap2420;
>> -    s->cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, core ?: "arm1136-r2"));
>> +    s->cpu = ARM_CPU(cpu_create(cpu_type));
>>      s->sdram_size = sdram_size;
>>      s->sram_size = OMAP242X_SRAM_SIZE;
>>
>> diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
>> index 9809106..1236ec1 100644
>> --- a/hw/arm/omap_sx1.c
>> +++ b/hw/arm/omap_sx1.c
>> @@ -36,6 +36,7 @@
>>  #include "sysemu/block-backend.h"
>>  #include "sysemu/qtest.h"
>>  #include "exec/address-spaces.h"
>> +#include "cpu.h"
>>
>>  /*****************************************************************************/
>>  /* Siemens SX1 Cellphone V1 */
>> @@ -120,7 +121,7 @@ static void sx1_init(MachineState *machine, const int version)
>>      }
>>
>>      mpu = omap310_mpu_init(address_space, sx1_binfo.ram_size,
>> -                           machine->cpu_model);
>> +                           machine->cpu_type);
>>
>>      /* External Flash (EMIFS) */
>>      memory_region_init_ram(flash, NULL, "omap_sx1.flash0-0", flash_size,
>> @@ -223,6 +224,7 @@ static void sx1_machine_v2_class_init(ObjectClass *oc, void *data)
>>
>>      mc->desc = "Siemens SX1 (OMAP310) V2";
>>      mc->init = sx1_init_v2;
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("ti925t");
>>  }
>>
>>  static const TypeInfo sx1_machine_v2_type = {
>> @@ -237,6 +239,7 @@ static void sx1_machine_v1_class_init(ObjectClass *oc, void *data)
>>
>>      mc->desc = "Siemens SX1 (OMAP310) V1";
>>      mc->init = sx1_init_v1;
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("ti925t");
>>  }
>>
>>  static const TypeInfo sx1_machine_v1_type = {
>> diff --git a/hw/arm/palm.c b/hw/arm/palm.c
>> index 64cf8ca..862f048 100644
>> --- a/hw/arm/palm.c
>> +++ b/hw/arm/palm.c
>> @@ -29,6 +29,7 @@
>>  #include "hw/devices.h"
>>  #include "hw/loader.h"
>>  #include "exec/address-spaces.h"
>> +#include "cpu.h"
>>
>>  static uint32_t static_readb(void *opaque, hwaddr offset)
>>  {
>> @@ -195,7 +196,6 @@ static struct arm_boot_info palmte_binfo = {
>>
>>  static void palmte_init(MachineState *machine)
>>  {
>> -    const char *cpu_model = machine->cpu_model;
>>      const char *kernel_filename = machine->kernel_filename;
>>      const char *kernel_cmdline = machine->kernel_cmdline;
>>      const char *initrd_filename = machine->initrd_filename;
>> @@ -211,7 +211,7 @@ static void palmte_init(MachineState *machine)
>>      MemoryRegion *flash = g_new(MemoryRegion, 1);
>>      MemoryRegion *cs = g_new(MemoryRegion, 4);
>>
>> -    mpu = omap310_mpu_init(address_space_mem, sdram_size, cpu_model);
>> +    mpu = omap310_mpu_init(address_space_mem, sdram_size, machine->cpu_type);
>>
>>      /* External Flash (EMIFS) */
>>      memory_region_init_ram(flash, NULL, "palmte.flash", flash_size,
>> @@ -274,6 +274,7 @@ static void palmte_machine_init(MachineClass *mc)
>>  {
>>      mc->desc = "Palm Tungsten|E aka. Cheetah PDA (OMAP310)";
>>      mc->init = palmte_init;
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("ti925t");
>>  }
>>
>>  DEFINE_MACHINE("cheetah", palmte_machine_init)
>> diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
>> index c16657d..79b317a 100644
>> --- a/hw/arm/pxa2xx.c
>> +++ b/hw/arm/pxa2xx.c
>> @@ -2052,21 +2052,19 @@ static void pxa2xx_reset(void *opaque, int line, int level)
>>
>>  /* Initialise a PXA270 integrated chip (ARM based core).  */
>>  PXA2xxState *pxa270_init(MemoryRegion *address_space,
>> -                         unsigned int sdram_size, const char *revision)
>> +                         unsigned int sdram_size, const char *cpu_type)
>>  {
>>      PXA2xxState *s;
>>      int i;
>>      DriveInfo *dinfo;
>>      s = g_new0(PXA2xxState, 1);
>>
>> -    if (revision && strncmp(revision, "pxa27", 5)) {
>> +    if (strncmp(cpu_type, ARM_CPU_TYPE_NAME("pxa27"), 5)) {
>
> Why are you using ARM_CPU_TYPE_NAME here, if you are only
> checking if cpu_type starts with "pxa27"?
>
> I suggest adding a TODO here noting that we implement this using
> either a TYPE_ARM_PXA27 subclass (so we can use
> object_class_dynamic_cast()), or a ARMCPUClass field to identify
> if the CPU is pxa27.
>
>>          fprintf(stderr, "Machine requires a PXA27x processor.\n");
>>          exit(1);
>>      }
>
> This would be another use case for a generic CPU model validation
> mechanism in MachineClass.
>
>
>> -    if (!revision)
>> -        revision = "pxa270";
>>
>> -    s->cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, revision));
>> +    s->cpu = ARM_CPU(cpu_create(cpu_type));
>>      s->reset = qemu_allocate_irq(pxa2xx_reset, s, 0);
>>
>>      /* SDRAM & Internal Memory Storage */
>> @@ -2192,7 +2190,7 @@ PXA2xxState *pxa255_init(MemoryRegion *address_space, unsigned int sdram_size)
>>
>>      s = g_new0(PXA2xxState, 1);
>>
>> -    s->cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, "pxa255"));
>> +    s->cpu = ARM_CPU(cpu_create(ARM_CPU_TYPE_NAME("pxa255")));
>>      s->reset = qemu_allocate_irq(pxa2xx_reset, s, 0);
>>
>>      /* SDRAM & Internal Memory Storage */
>> diff --git a/hw/arm/realview.c b/hw/arm/realview.c
>> index 76ff557..38e3278 100644
>> --- a/hw/arm/realview.c
>> +++ b/hw/arm/realview.c
>> @@ -55,7 +55,6 @@ static void realview_init(MachineState *machine,
>>  {
>>      ARMCPU *cpu = NULL;
>>      CPUARMState *env;
>> -    ObjectClass *cpu_oc;
>>      MemoryRegion *sysmem = get_system_memory();
>>      MemoryRegion *ram_lo;
>>      MemoryRegion *ram_hi = g_new(MemoryRegion, 1);
>> @@ -96,14 +95,8 @@ static void realview_init(MachineState *machine,
>>          break;
>>      }
>>
>> -    cpu_oc = cpu_class_by_name(TYPE_ARM_CPU, machine->cpu_model);
>> -    if (!cpu_oc) {
>> -        fprintf(stderr, "Unable to find CPU definition\n");
>> -        exit(1);
>> -    }
>> -
>>      for (n = 0; n < smp_cpus; n++) {
>> -        Object *cpuobj = object_new(object_class_get_name(cpu_oc));
>> +        Object *cpuobj = object_new(machine->cpu_type);
>>
>>          /* By default A9,A15 and ARM1176 CPUs have EL3 enabled.  This board
>>           * does not currently support EL3 so the CPU EL3 property is disabled
>> @@ -359,33 +352,21 @@ static void realview_init(MachineState *machine,
>>
>>  static void realview_eb_init(MachineState *machine)
>>  {
>> -    if (!machine->cpu_model) {
>> -        machine->cpu_model = "arm926";
>> -    }
>>      realview_init(machine, BOARD_EB);
>>  }
>>
>>  static void realview_eb_mpcore_init(MachineState *machine)
>>  {
>> -    if (!machine->cpu_model) {
>> -        machine->cpu_model = "arm11mpcore";
>> -    }
>>      realview_init(machine, BOARD_EB_MPCORE);
>>  }
>>
>>  static void realview_pb_a8_init(MachineState *machine)
>>  {
>> -    if (!machine->cpu_model) {
>> -        machine->cpu_model = "cortex-a8";
>> -    }
>>      realview_init(machine, BOARD_PB_A8);
>>  }
>>
>>  static void realview_pbx_a9_init(MachineState *machine)
>>  {
>> -    if (!machine->cpu_model) {
>> -        machine->cpu_model = "cortex-a9";
>> -    }
>>      realview_init(machine, BOARD_PBX_A9);
>>  }
>>
>> @@ -396,6 +377,7 @@ static void realview_eb_class_init(ObjectClass *oc, void *data)
>>      mc->desc = "ARM RealView Emulation Baseboard (ARM926EJ-S)";
>>      mc->init = realview_eb_init;
>>      mc->block_default_type = IF_SCSI;
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
>>  }
>>
>>  static const TypeInfo realview_eb_type = {
>> @@ -412,6 +394,7 @@ static void realview_eb_mpcore_class_init(ObjectClass *oc, void *data)
>>      mc->init = realview_eb_mpcore_init;
>>      mc->block_default_type = IF_SCSI;
>>      mc->max_cpus = 4;
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm11mpcore");
>>  }
>>
>>  static const TypeInfo realview_eb_mpcore_type = {
>> @@ -426,6 +409,7 @@ static void realview_pb_a8_class_init(ObjectClass *oc, void *data)
>>
>>      mc->desc = "ARM RealView Platform Baseboard for Cortex-A8";
>>      mc->init = realview_pb_a8_init;
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a8");
>>  }
>>
>>  static const TypeInfo realview_pb_a8_type = {
>> @@ -441,6 +425,7 @@ static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
>>      mc->desc = "ARM RealView Platform Baseboard Explore for Cortex-A9";
>>      mc->init = realview_pbx_a9_init;
>>      mc->max_cpus = 4;
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
>>  }
>>
>>  static const TypeInfo realview_pbx_a9_type = {
>> diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
>> index 7f588ce..b6ddb7c 100644
>> --- a/hw/arm/spitz.c
>> +++ b/hw/arm/spitz.c
>> @@ -30,6 +30,7 @@
>>  #include "hw/sysbus.h"
>>  #include "exec/address-spaces.h"
>>  #include "sysemu/sysemu.h"
>> +#include "cpu.h"
>>
>>  #undef REG_FMT
>>  #define REG_FMT                      "0x%02lx"
>> @@ -909,13 +910,10 @@ static void spitz_common_init(MachineState *machine,
>>      DeviceState *scp0, *scp1 = NULL;
>>      MemoryRegion *address_space_mem = get_system_memory();
>>      MemoryRegion *rom = g_new(MemoryRegion, 1);
>> -    const char *cpu_model = machine->cpu_model;
>> -
>> -    if (!cpu_model)
>> -        cpu_model = (model == terrier) ? "pxa270-c5" : "pxa270-c0";
>>
>
> Nice to see this go away.
>
>
>>      /* Setup CPU & memory */
>> -    mpu = pxa270_init(address_space_mem, spitz_binfo.ram_size, cpu_model);
>> +    mpu = pxa270_init(address_space_mem, spitz_binfo.ram_size,
>> +                      machine->cpu_type);
>>
>>      sl_flash_register(mpu, (model == spitz) ? FLASH_128M : FLASH_1024M);
>>
>> @@ -983,6 +981,7 @@ static void akitapda_class_init(ObjectClass *oc, void *data)
>>
>>      mc->desc = "Sharp SL-C1000 (Akita) PDA (PXA270)";
>>      mc->init = akita_init;
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c0");
>>  }
>>
>>  static const TypeInfo akitapda_type = {
>> @@ -998,6 +997,7 @@ static void spitzpda_class_init(ObjectClass *oc, void *data)
>>      mc->desc = "Sharp SL-C3000 (Spitz) PDA (PXA270)";
>>      mc->init = spitz_init;
>>      mc->block_default_type = IF_IDE;
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c0");
>>  }
>>
>>  static const TypeInfo spitzpda_type = {
>> @@ -1013,6 +1013,7 @@ static void borzoipda_class_init(ObjectClass *oc, void *data)
>>      mc->desc = "Sharp SL-C3100 (Borzoi) PDA (PXA270)";
>>      mc->init = borzoi_init;
>>      mc->block_default_type = IF_IDE;
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c0");
>>  }
>>
>>  static const TypeInfo borzoipda_type = {
>> @@ -1028,6 +1029,7 @@ static void terrierpda_class_init(ObjectClass *oc, void *data)
>>      mc->desc = "Sharp SL-C3200 (Terrier) PDA (PXA270)";
>>      mc->init = terrier_init;
>>      mc->block_default_type = IF_IDE;
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c5");
>>  }
>>
>>  static const TypeInfo terrierpda_type = {
>> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
>> index 408c1a1..c8fa9da 100644
>> --- a/hw/arm/stellaris.c
>> +++ b/hw/arm/stellaris.c
>> @@ -22,6 +22,7 @@
>>  #include "sysemu/sysemu.h"
>>  #include "hw/char/pl011.h"
>>  #include "hw/misc/unimp.h"
>> +#include "cpu.h"
>>
>>  #define GPIO_A 0
>>  #define GPIO_B 1
>> @@ -1225,8 +1226,7 @@ static stellaris_board_info stellaris_boards[] = {
>>    }
>>  };
>>
>> -static void stellaris_init(const char *kernel_filename, const char *cpu_model,
>> -                           stellaris_board_info *board)
>> +static void stellaris_init(MachineState *ms, stellaris_board_info *board)
>>  {
>>      static const int uart_irq[] = {5, 6, 33, 34};
>>      static const int timer_irq[] = {19, 21, 23, 35};
>> @@ -1298,7 +1298,7 @@ static void stellaris_init(const char *kernel_filename, const char *cpu_model,
>>      memory_region_add_subregion(system_memory, 0x20000000, sram);
>>
>>      nvic = armv7m_init(system_memory, flash_size, NUM_IRQ_LINES,
>> -                      kernel_filename, cpu_model);
>> +                       ms->kernel_filename, ms->cpu_type);
>>
>>      qdev_connect_gpio_out_named(nvic, "SYSRESETREQ", 0,
>>                                  qemu_allocate_irq(&do_sys_reset, NULL, 0));
>> @@ -1435,16 +1435,12 @@ static void stellaris_init(const char *kernel_filename, const char *cpu_model,
>>  /* FIXME: Figure out how to generate these from stellaris_boards.  */
>>  static void lm3s811evb_init(MachineState *machine)
>>  {
>> -    const char *cpu_model = machine->cpu_model;
>> -    const char *kernel_filename = machine->kernel_filename;
>> -    stellaris_init(kernel_filename, cpu_model, &stellaris_boards[0]);
>> +    stellaris_init(machine, &stellaris_boards[0]);
>>  }
>>
>>  static void lm3s6965evb_init(MachineState *machine)
>>  {
>> -    const char *cpu_model = machine->cpu_model;
>> -    const char *kernel_filename = machine->kernel_filename;
>> -    stellaris_init(kernel_filename, cpu_model, &stellaris_boards[1]);
>> +    stellaris_init(machine, &stellaris_boards[1]);
>>  }
>>
>>  static void lm3s811evb_class_init(ObjectClass *oc, void *data)
>> @@ -1453,6 +1449,7 @@ static void lm3s811evb_class_init(ObjectClass *oc, void *data)
>>
>>

...

>>
>>  static const TypeInfo lm3s6965evb_type = {
>> diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
>> index f61e735..1cd6374 100644
>> --- a/hw/arm/stm32f205_soc.c
>> +++ b/hw/arm/stm32f205_soc.c
>> @@ -112,7 +112,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
>>
>>      armv7m = DEVICE(&s->armv7m);
>>      qdev_prop_set_uint32(armv7m, "num-irq", 96);
>> -    qdev_prop_set_string(armv7m, "cpu-model", s->cpu_model);
>> +    qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
>>      object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
>>                                       "memory", &error_abort);
>>      object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
>> @@ -200,7 +200,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
>>  }
>>
>>  static Property stm32f205_soc_properties[] = {
>> -    DEFINE_PROP_STRING("cpu-model", STM32F205State, cpu_model),
>> +    DEFINE_PROP_STRING("cpu-type", STM32F205State, cpu_type),
>
> Same as armv7m: are we 100% sure users are not setting this
> manually?

In an embedded board like this it really doesn't make sense to let the
user overwrite the CPU. The SoC will take it as an option, but the
board (which creates the SoC) just blindly always uses the same CPU.
That feature is more for QOMificatoion then any real reason though.

In saying that I think a warning if the user tries to set the CPU
would make sense. I know that this issues comes up in other ARM boards
(Zynq-7000 has the same issue as well) so maybe a machine property
saying that the board doesn't accept custom CPUs would be a good idea.

Overall I think this patch is moving in the right direction though and
this CPU option being ignored existed before this series.

Thanks,
Alistair


>
>
