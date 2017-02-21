Received: from eggs.gnu.org ([2001:4830:134:3::10]:59576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cg8gW-0003jL-SX
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:32:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cg8gV-0006yK-P5
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:32:44 -0500
MIME-Version: 1.0
In-Reply-To: <f32893c7-5fa2-7075-4ca8-3d82b0f8eba7@amsat.org>
References: <1487604965-23220-1-git-send-email-peter.maydell@linaro.org>
	<1487604965-23220-11-git-send-email-peter.maydell@linaro.org>
	<f32893c7-5fa2-7075-4ca8-3d82b0f8eba7@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Feb 2017 03:32:09 -0800
Message-ID: <CAKmqyKO_jKea0wm7KtgU=6_FbAKoWRFz_WC2omNpPLv8QHqobw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 10/11] stm32f205: Create armv7m
 object without using armv7m_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Michael Davidsaver <mdavidsaver@gmail.com>, Patch Tracking <patches@linaro.org>

On Mon, Feb 20, 2017 at 9:45 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> On 02/20/2017 12:36 PM, Peter Maydell wrote:
>>
>> Switch the stm32f205 SoC to create the armv7m object directly
>> rather than via the armv7m_init() wrapper. This fits better
>> with the SoC model's very QOMified design.
>>
>> In particular this means we can push loading the guest image
>> out to the top level board code where it belongs, rather
>> than the SoC object having a QOM property for the filename
>> to load.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

>
>
>> ---
>>  include/hw/arm/stm32f205_soc.h |  4 +++-
>>  hw/arm/netduino2.c             |  7 ++++---
>>  hw/arm/stm32f205_soc.c         | 16 +++++++++++++---
>>  3 files changed, 20 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/hw/arm/stm32f205_soc.h
>> b/include/hw/arm/stm32f205_soc.h
>> index 1332141..e2dce11 100644
>> --- a/include/hw/arm/stm32f205_soc.h
>> +++ b/include/hw/arm/stm32f205_soc.h
>> @@ -31,6 +31,7 @@
>>  #include "hw/adc/stm32f2xx_adc.h"
>>  #include "hw/or-irq.h"
>>  #include "hw/ssi/stm32f2xx_spi.h"
>> +#include "hw/arm/armv7m.h"
>>
>>  #define TYPE_STM32F205_SOC "stm32f205-soc"
>>  #define STM32F205_SOC(obj) \
>> @@ -51,9 +52,10 @@ typedef struct STM32F205State {
>>      SysBusDevice parent_obj;
>>      /*< public >*/
>>
>> -    char *kernel_filename;
>>      char *cpu_model;
>>
>> +    ARMv7MState armv7m;
>> +
>>      STM32F2XXSyscfgState syscfg;
>>      STM32F2XXUsartState usart[STM_NUM_USARTS];
>>      STM32F2XXTimerState timer[STM_NUM_TIMERS];
>> diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
>> index 23d7928..3cfe332 100644
>> --- a/hw/arm/netduino2.c
>> +++ b/hw/arm/netduino2.c
>> @@ -27,17 +27,18 @@
>>  #include "hw/boards.h"
>>  #include "qemu/error-report.h"
>>  #include "hw/arm/stm32f205_soc.h"
>> +#include "hw/arm/arm.h"
>>
>>  static void netduino2_init(MachineState *machine)
>>  {
>>      DeviceState *dev;
>>
>>      dev =3D qdev_create(NULL, TYPE_STM32F205_SOC);
>> -    if (machine->kernel_filename) {
>> -        qdev_prop_set_string(dev, "kernel-filename",
>> machine->kernel_filename);
>> -    }
>>      qdev_prop_set_string(dev, "cpu-model", "cortex-m3");
>>      object_property_set_bool(OBJECT(dev), true, "realized",
>> &error_fatal);
>> +
>> +    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
>> +                       FLASH_SIZE);
>>  }
>>
>>  static void netduino2_machine_init(MachineClass *mc)
>> diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
>> index 38425bd..e6bd73a 100644
>> --- a/hw/arm/stm32f205_soc.c
>> +++ b/hw/arm/stm32f205_soc.c
>> @@ -49,6 +49,9 @@ static void stm32f205_soc_initfn(Object *obj)
>>      STM32F205State *s =3D STM32F205_SOC(obj);
>>      int i;
>>
>> +    object_initialize(&s->armv7m, sizeof(s->armv7m), TYPE_ARMV7M);
>> +    qdev_set_parent_bus(DEVICE(&s->armv7m), sysbus_get_default());
>> +
>>      object_initialize(&s->syscfg, sizeof(s->syscfg),
>> TYPE_STM32F2XX_SYSCFG);
>>      qdev_set_parent_bus(DEVICE(&s->syscfg), sysbus_get_default());
>>
>> @@ -110,8 +113,16 @@ static void stm32f205_soc_realize(DeviceState
>> *dev_soc, Error **errp)
>>      vmstate_register_ram_global(sram);
>>      memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, sram)=
;
>>
>> -    nvic =3D armv7m_init(get_system_memory(), FLASH_SIZE, 96,
>> -                       s->kernel_filename, s->cpu_model);
>> +    nvic =3D DEVICE(&s->armv7m);
>> +    qdev_prop_set_uint32(nvic, "num-irq", 96);
>> +    qdev_prop_set_string(nvic, "cpu-model", s->cpu_model);
>> +    object_property_set_link(OBJECT(&s->armv7m),
>> OBJECT(get_system_memory()),
>> +                                     "memory", &error_abort);
>> +    object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err=
);
>> +    if (err !=3D NULL) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>>
>>      /* System configuration controller */
>>      dev =3D DEVICE(&s->syscfg);
>> @@ -192,7 +203,6 @@ static void stm32f205_soc_realize(DeviceState
>> *dev_soc, Error **errp)
>>  }
>>
>>  static Property stm32f205_soc_properties[] =3D {
>> -    DEFINE_PROP_STRING("kernel-filename", STM32F205State,
>> kernel_filename),
>>      DEFINE_PROP_STRING("cpu-model", STM32F205State, cpu_model),
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>>
>
