Received: from eggs.gnu.org ([2001:4830:134:3::10]:33487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ecbCa-0002gr-LX
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ecbCZ-0004wY-5s
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:15:44 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <0f5a2011-7378-dcee-cf31-5bfb341b85f8@amsat.org>
References: <cover.1516300623.git.alistair.francis@xilinx.com>
	<f5426a36d6a0d997d5f6445201861445d8e857da.1516300623.git.alistair.francis@xilinx.com>
	<0f5a2011-7378-dcee-cf31-5bfb341b85f8@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 19 Jan 2018 10:15:10 -0800
Message-ID: <CAKmqyKP+rfd26R_rBgguWspzASZm4GRjfnfCiyBvPemxkx8AGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v6 8/9] xlnx-zynqmp-pmu: Connect
 the IPI device to the PMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Edgar Iglesias <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>

On Thu, Jan 18, 2018 at 1:42 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> On 01/18/2018 03:38 PM, Alistair Francis wrote:
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>> ---
>> V4:
>>  - Move the IPI to the machine instead of the SoC
>>
>>  hw/microblaze/xlnx-zynqmp-pmu.c | 31 +++++++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>
>> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp=
-pmu.c
>> index 7312bfe23e..999a5657cf 100644
>> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
>> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
>> @@ -24,6 +24,7 @@
>>  #include "cpu.h"
>>  #include "boot.h"
>>
>> +#include "hw/intc/xlnx-zynqmp-ipi.h"
>>  #include "hw/intc/xlnx-pmu-iomod-intc.h"
>>
>>  /* Define the PMU device */
>> @@ -38,6 +39,15 @@
>>
>>  #define XLNX_ZYNQMP_PMU_INTC_ADDR   0xFFD40000
>>
>> +#define XLNX_ZYNQMP_PMU_NUM_IPIS    4
>> +
>> +static const uint64_t ipi_addr[XLNX_ZYNQMP_PMU_NUM_IPIS] =3D {
>> +    0xFF340000, 0xFF350000, 0xFF360000, 0xFF370000,
>> +};
>> +static const uint64_t ipi_irq[XLNX_ZYNQMP_PMU_NUM_IPIS] =3D {
>> +    19, 20, 21, 22,
>> +};
>> +
>>  typedef struct XlnxZynqMPPMUSoCState {
>>      /*< private >*/
>>      DeviceState parent_obj;
>> @@ -136,6 +146,9 @@ static void xlnx_zynqmp_pmu_init(MachineState *machi=
ne)
>>      MemoryRegion *address_space_mem =3D get_system_memory();
>>      MemoryRegion *pmu_rom =3D g_new(MemoryRegion, 1);
>>      MemoryRegion *pmu_ram =3D g_new(MemoryRegion, 1);
>> +    XlnxZynqMPIPI *ipi[XLNX_ZYNQMP_PMU_NUM_IPIS];
>
> Why use pointers and g_new() here?
>
> Isn't a plain array simpler?

I remember that I tried that and ran into issues. It was so long ago
though that I can't remember what the problem was. I think it was
related to adding the object as a child.

Alistair

>
>    XlnxZynqMPIPI ipi[XLNX_ZYNQMP_PMU_NUM_IPIS];
>
> (same apply to pmu_rom/ram)
>
> Or maybe do you plan to start implementing MachineClass::exit()?
>
> (or go in this direction, which might make sens thinking about having a
> multiarch single binary).
>
>> +    qemu_irq irq[32];
>> +    int i;
>>
>>      /* Create the ROM */
>>      memory_region_init_rom(pmu_rom, NULL, "xlnx-zynqmp-pmu.rom",
>> @@ -155,6 +168,24 @@ static void xlnx_zynqmp_pmu_init(MachineState *mach=
ine)
>>                                &error_abort);
>>      object_property_set_bool(OBJECT(pmu), true, "realized", &error_fata=
l);
>>
>> +    for (i =3D 0; i < 32; i++) {
>> +        irq[i] =3D qdev_get_gpio_in(DEVICE(&pmu->intc), i);
>> +    }
>> +
>> +    /* Create and connect the IPI device */
>> +    for (i =3D 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
>> +        ipi[i] =3D g_new0(XlnxZynqMPIPI, 1);
>> +        object_initialize(ipi[i], sizeof(XlnxZynqMPIPI), TYPE_XLNX_ZYNQ=
MP_IPI);
>> +        qdev_set_parent_bus(DEVICE(ipi[i]), sysbus_get_default());
>> +    }
>> +
>> +    for (i =3D 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
>> +        object_property_set_bool(OBJECT(ipi[i]), true, "realized",
>> +                                 &error_abort);
>> +        sysbus_mmio_map(SYS_BUS_DEVICE(ipi[i]), 0, ipi_addr[i]);
>> +        sysbus_connect_irq(SYS_BUS_DEVICE(ipi[i]), 0, irq[ipi_irq[i]]);
>> +    }
>> +
>>      /* Load the kernel */
>>      microblaze_load_kernel(&pmu->cpu, XLNX_ZYNQMP_PMU_RAM_ADDR,
>>                             machine->ram_size,
>>
