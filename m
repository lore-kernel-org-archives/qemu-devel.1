Received: from eggs.gnu.org ([2001:4830:134:3::10]:51754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dpHmj-0003I1-SM
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dpHme-0008MZ-Py
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:37:13 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170904093224.62b43efb@nial.brq.redhat.com>
References: <cover.1504293917.git.alistair.francis@xilinx.com>
	<241130c59df31aebaf4f23b5f151b6b5c91f36fa.1504293917.git.alistair.francis@xilinx.com>
	<20170904093224.62b43efb@nial.brq.redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 5 Sep 2017 10:36:36 -0700
Message-ID: <CAKmqyKOyxQX__uV8Sh3bmyq9NACwsekPz2EaGVBZP9i3dFKSPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/6] xlnx-zynqmp-pmu: Add the CPU and
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Edgar Iglesias <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>

On Mon, Sep 4, 2017 at 12:32 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> On Fri, 1 Sep 2017 14:00:37 -0700
> Alistair Francis <alistair.francis@xilinx.com> wrote:
>
>> Connect the MicroBlaze CPU and the ROM and RAM memory regions.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>
>>  hw/microblaze/xlnx-zynqmp-pmu.c | 65 +++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 63 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
>> index fc3c8b236f..33584cfa4d 100644
>> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
>> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
>> @@ -18,8 +18,11 @@
>>  #include "qemu/osdep.h"
>>  #include "qapi/error.h"
>>  #include "qemu-common.h"
>> +#include "exec/address-spaces.h"
>>  #include "hw/boards.h"
>> +#include "hw/qdev-properties.h"
>>  #include "cpu.h"
>> +#include "boot.h"
>>
>>  /* Define the PMU device */
>>
>> @@ -27,21 +30,51 @@
>>  #define XLNX_ZYNQMP_PMU(obj) OBJECT_CHECK(XlnxZynqMPPMUState, (obj), \
>>                                            TYPE_XLNX_ZYNQMP_PMU)
>>
>> +#define XLNX_ZYNQMP_PMU_ROM_SIZE    0x8000
>> +#define XLNX_ZYNQMP_PMU_ROM_ADDR    0xFFD00000
>> +#define XLNX_ZYNQMP_PMU_RAM_ADDR    0xFFDC0000
>> +
>>  typedef struct XlnxZynqMPPMUState {
>>      /*< private >*/
>>      DeviceState parent_obj;
>>
>>      /*< public >*/
>> +    MicroBlazeCPU cpu;
>>  }  XlnxZynqMPPMUState;
>>
>>  static void xlnx_zynqmp_pmu_init(Object *obj)
>>  {
>> +    XlnxZynqMPPMUState *s = XLNX_ZYNQMP_PMU(obj);
>>
>> +    object_initialize(&s->cpu, sizeof(s->cpu),
>> +                      TYPE_MICROBLAZE_CPU);
>> +    object_property_add_child(obj, "pmu-cpu[*]", OBJECT(&s->cpu),
>                                               ^^^ why do you use this syntax here?
>

Woops, that was a left over from the ARM ZynqMP. I'll remove the '[*]'

>> +                              &error_abort);
>>  }
>>
>>  static void xlnx_zynqmp_pmu_realize(DeviceState *dev, Error **errp)
>>  {
>> -
>> +    XlnxZynqMPPMUState *s = XLNX_ZYNQMP_PMU(dev);
>> +
>> +    object_property_set_uint(OBJECT(&s->cpu), XLNX_ZYNQMP_PMU_ROM_ADDR,
>> +                             "base-vectors", &error_abort);
>> +    object_property_set_bool(OBJECT(&s->cpu), true, "use-stack-protection",
>> +                             &error_abort);
>> +    object_property_set_uint(OBJECT(&s->cpu), 0, "use-fpu", &error_abort);
>> +    object_property_set_uint(OBJECT(&s->cpu), 0, "use-hw-mul", &error_abort);
>> +    object_property_set_bool(OBJECT(&s->cpu), true, "use-barrel",
>> +                             &error_abort);
>> +    object_property_set_bool(OBJECT(&s->cpu), true, "use-msr-instr",
>> +                             &error_abort);
>> +    object_property_set_bool(OBJECT(&s->cpu), true, "use-pcmp-instr",
>> +                             &error_abort);
>> +    object_property_set_bool(OBJECT(&s->cpu), false, "use-mmu", &error_abort);
>> +    object_property_set_bool(OBJECT(&s->cpu), true, "endianness",
>> +                             &error_abort);
>> +    object_property_set_str(OBJECT(&s->cpu), "8.40.b", "version",
>> +                            &error_abort);
>> +    object_property_set_uint(OBJECT(&s->cpu), 0, "pvr", &error_abort);
>> +    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &error_fatal);
> I'd replace error_fatal here with errp

Will do.

Thanks,
Alistair

>
>>  }
>>
>>  static void xlnx_zynqmp_pmu_class_init(ObjectClass *oc, void *data)
>> @@ -70,7 +103,35 @@ type_init(xlnx_zynqmp_pmu_register_types)
>>
>>  static void xlnx_zcu102_pmu_init(MachineState *machine)
>>  {
>> -
>> +    XlnxZynqMPPMUState *pmu = g_new0(XlnxZynqMPPMUState, 1);
>> +    MemoryRegion *address_space_mem = get_system_memory();
>> +    MemoryRegion *pmu_rom = g_new(MemoryRegion, 1);
>> +    MemoryRegion *pmu_ram = g_new(MemoryRegion, 1);
>> +
>> +    /* Create the ROM */
>> +    memory_region_init_rom(pmu_rom, NULL, "xlnx-zcu102-pmu.rom",
>> +                           XLNX_ZYNQMP_PMU_ROM_SIZE, &error_fatal);
>> +    memory_region_add_subregion(address_space_mem, XLNX_ZYNQMP_PMU_ROM_ADDR,
>> +                                pmu_rom);
>> +
>> +    /* Create the RAM */
>> +    memory_region_init_ram(pmu_ram, NULL, "xlnx-zcu102-pmu.ram",
>> +                           machine->ram_size, &error_fatal);
>> +    memory_region_add_subregion(address_space_mem, XLNX_ZYNQMP_PMU_RAM_ADDR,
>> +                                pmu_ram);
>> +
>> +    /* Create the PMU device */
>> +    object_initialize(pmu, sizeof(XlnxZynqMPPMUState), TYPE_XLNX_ZYNQMP_PMU);
>> +    object_property_add_child(OBJECT(machine), "pmu", OBJECT(pmu),
>> +                              &error_abort);
>> +    object_property_set_bool(OBJECT(pmu), true, "realized", &error_fatal);
>> +
>> +    /* Load the kernel */
>> +    microblaze_load_kernel(&pmu->cpu, XLNX_ZYNQMP_PMU_RAM_ADDR,
>> +                           machine->ram_size,
>> +                           machine->kernel_filename,
>> +                           machine->dtb,
>> +                           NULL);
>>  }
>>
>>  static void xlnx_zcu102_pmu_machine_init(MachineClass *mc)
>
