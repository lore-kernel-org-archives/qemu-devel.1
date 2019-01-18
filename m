Received: from eggs.gnu.org ([209.51.188.92]:46619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1gkRAn-0005r7-2K
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:14:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1gkRAl-0004kP-G9
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:14:49 -0500
References: <DB7PR04MB4505EEB04A9500D8162463B9B9830@DB7PR04MB4505.eurprd04.prod.outlook.com>
	<DB7PR04MB45057508E2DF87EE77572CE3B9830@DB7PR04MB4505.eurprd04.prod.outlook.com>
	<dbf1160d-be81-741c-acef-aabcf99179a9@amsat.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <32a14c0d-ca3b-f3aa-d277-9a15c9b8575e@adacore.com>
Date: Fri, 18 Jan 2019 11:14:24 +0100
MIME-Version: 1.0
In-Reply-To: <dbf1160d-be81-741c-acef-aabcf99179a9@amsat.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] Problems adding TMS570LC43 - Cortex-R5f
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Jo=c3=a3o_Gaspar?= <joaogaspar_csw_qemu@hotmail.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>



Le 1/17/19 =E0 7:00 PM, Philippe Mathieu-Daud=E9 a =E9crit=A0:
> Hi,
>=20
> On 1/17/19 5:54 PM, Jo=E3o Gaspar wrote:
>> Hi!
>> I'm new at QEMU so I have some questions.
>>
>> I'm trying to create a new support machine to QEMU, the TMS570LC43
>> board, this board use the Cortex-R5f microcontroller.
>> At this moment when I do the "qemu-system-arm -M help" my machine is
>> showed with the name "cortex-r5".
>=20
> OMG why on Earth do you want to model a Hercules SoC? Speaking of
> experience, I used to work with those and spend some time tring to mode=
l
> them, I don't recommend this to you to start modelling an ARM SoC with
> QEMU. So I'm curious to understand your goal here, is it for hobby or
> univ/job assignment?
> Do you plan to run real world firmwares or simple/generic programs?
> Designed for Safety critical/Real-Time embedded world, it has plenty of
> very specific features that a safe firmware should be using, thus makin=
g
> the work of modelling very teddious.
> Any unmodified firmware require you to implement the Clock Monitoring,
> PBIST, and part of the ESM.
> Also, you might be limited to run from SRAM then EMIF, because the flas=
h
> registers (F021) aren't public.
> Also the CPU boots in Big Endian, and while QEMU backend support both
> endianess, there are no ARM system booting BE, and you might encounter
> weird bugs has it happened to me.

We have a TMS570 platform as well (very minimal though to boot our runtim=
es) and
I can confirm that there are some endianness pain with this platform.

For the initial question it seems that you used "cortex-r5" in:

 >>      DEFINE_MACHINE("cortex-r5", cortexR5_machine_init)

So expect the machine to be called like that.

Cheers,
Fred

>=20
> So if you don't have a strong reason, I'd redirect you to use another
> ARM SoC.
>=20
>> The probleme start when I try to instaciate the machine with the coman=
d
>> "qemu-system-arm --machine cortex-r5 -cpu cortex-r5f", after that I
>> received the message "segmentation fault (core dump)".
>>
>> Does anyone have an possible cause to my problem or an tip?
>=20
> Since this question isn't ARM specific but generic about QEMU machines,
> I recommend you to also post to the qemu-devel@nongnu.org list (now cop=
ied).
>=20
> You can have a more verbose debug output configuring QEMU as:
>=20
> ./configure ... --extra-cflags=3D--ggdb --enable-debug
>=20
> Regards,
>=20
> Phil.
>=20
>>
>> I'm gonna let the code too, because probably I'm doing aniything wrong=
!
>>
>>      #include "qemu/osdep.h"
>>      #include "qapi/error.h"
>>      #include "qemu-common.h"
>>      #include "hw/arm/arm.h"
>>      #include "exec/address-spaces.h"
>>      #include "qemu/error-report.h"
>>      #include "qom/object.h"
>>      #include "cpu.h"
>>      #include "hw/sysbus.h"
>>      #include "hw/arm/cortex-R5.h"
>>
>>      //RTI -> Real Time Interruption
>>      //static const uint32_t RTI_addr =3D 0xFFFFFC00;
>>
>>      //SPI
>>      static const uint32_t spi_addr[CR5_NUM_SPI] =3D {0xFFF7F400,
>>      0xFFF7F600, 0xFFF7F800, 0xFFF7FA00, 0xFFF7FC00};
>>      //I2C
>>      static const uint32_t i2c_addr[CR5_NUM_I2C] =3D {0xFFF7D400, 0xFF=
F7D500};
>>      //CAN
>>      static const uint32_t can_addr[CR5_NUM_CAN] =3D {0XFFF7DC00,
>>      0XFFF7DE00, 0X0FFF7E00, 0X0FFF7E200};
>>      //ADC
>>      static const uint32_t adc_addr[CR5_NUM_ADC] =3D {0xFFF7C000, 0xFF=
F7C200};
>>      //GIO
>>      static const uint32_t gio_addr[CR5_NUM_GIO] =3D {0xFFF7BC00};
>>
>>      /*IRQ
>>      Interrupt Request Assignement
>>      http://www.ti.com/lit/ds/spns195c/spns195c.pdf
>>      Page: 118
>>      */
>>      //irq RTI
>>      /* static const int rti_cmp_irq0 =3D 2;
>>      static const int rti_cmp_irq1 =3D 3;
>>      static const int rti_cmp_irq2 =3D 4;
>>      static const int rti_cmp_irq3 =3D 5;
>>      static const int rti_oflw_irq0 =3D 6;
>>      static const int rti_oflw_irq1 =3D 7;
>>      static const int rti_timebase_irq =3D 8; */
>>      //irq SPI
>>      static const int spi_l0_irq[CR5_NUM_SPI] =3D {12, 17, 37, 49, 53}=
;
>>      static const int spi_l1_irq[CR5_NUM_SPI] =3D {26, 30, 38, 54, 56}=
;
>>      //irq I2C
>>      static const int i2c_irq[CR5_NUM_I2C] =3D {66, 114};
>>      //irc CAN
>>      static const int can_l0_irq[CR5_NUM_CAN] =3D {16, 35, 45, 113};
>>      static const int can_l1_irq[CR5_NUM_CAN] =3D {29, 42, 55, 117};
>>      static const int can_if3_irq[CR5_NUM_CAN] =3D {44, 46, 60, 120};
>>      //irq ADC
>>      static const int adc_swgroup1_irq[CR5_NUM_ADC] =3D {15, 51};
>>      static const int adc_swgroup2_irq[CR5_NUM_ADC] =3D {28, 57};
>>      static const int adc_eventgroup_irq[CR5_NUM_ADC] =3D {14, 50};
>>      static const int adc_magnitudecmp_irq[CR5_NUM_ADC] =3D {31, 59};
>>      //irq GIO
>>      static const int gio_high_irq[CR5_NUM_GIO] =3D {9};
>>      static const int gio_low_irq[CR5_NUM_GIO] =3D {23};
>>
>>
>>      static void cortexR5_initf(MachineState *mc)
>>      {
>>      =A0 =A0 CORTEXR5State *s =3D g_new0(CORTEXR5State, 1);
>>
>>      =A0 =A0 DeviceState *dev;
>>      =A0 =A0 SysBusDevice *busdev;
>>      =A0 =A0 Error *err =3D NULL;
>>
>>      =A0 =A0 int i;
>>      =A0 =A0 ARMCPU *cpu;
>>
>>
>>      =A0 =A0 MemoryRegion *system_memory =3D get_system_memory();
>>      =A0 =A0 MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>>      =A0 =A0 MemoryRegion *flash =3D g_new(MemoryRegion, 1);
>>      =A0 =A0 MemoryRegion *flash_alias =3D g_new(MemoryRegion, 1);
>>
>>        =20
>>
>>      =A0 =A0 //s->cr5_cpu =3D ARM_CPU(object_new(mc->cpu_type));
>>      =A0 =A0 cpu =3D ARM_CPU(object_new(mc->cpu_type));
>>
>>      =A0 =A0 //object_initialize_child(obj, "cpu", &s->cr5_cpu,
>>      sizeof(s->cr5_cpu), ARM_CPU_TYPE_NAME("cortex-r5f"), &error_abort=
,
>>      NULL);
>>      =A0 =A0 object_property_set_bool(OBJECT(cpu), true, "realized",
>>      &error_fatal);
>>
>>      =A0 =A0 memory_region_init_ram(flash, NULL, "CORTEXR5.flash",
>>      FLASH_SIZE, &error_fatal);
>>
>>      =A0 =A0 memory_region_init_alias(flash_alias, NULL,
>>      "CORTEXR5.flash.alias", flash, 0, FLASH_SIZE);
>>
>>      =A0 =A0 memory_region_set_readonly(flash, true);
>>      =A0 =A0 memory_region_set_readonly(flash_alias, true);
>>
>>      =A0 =A0 memory_region_add_subregion(system_memory, FLASH_BASE_ADD=
RESS,
>>      flash);
>>      =A0 =A0 memory_region_add_subregion(system_memory, 0, flash_alias=
);
>>
>>      =A0 =A0 memory_region_init_ram(ram, NULL, "CORTEXR5.ram", SRAM_SI=
ZE,
>>      &error_fatal);
>>      =A0 =A0 memory_region_add_subregion(system_memory, RAM_BASE_ADDRE=
SS, ram);
>>
>>      =A0 =A0 //SPI
>>      =A0 =A0 for (i =3D 0; i < CR5_NUM_SPI; i++)
>>      =A0 =A0 {
>>      =A0 =A0 =A0 =A0 dev =3D DEVICE(&(s->spi[i]));
>>      =A0 =A0 =A0 =A0 object_property_set_bool(OBJECT(&s->spi[i]), true=
,
>>      "realized", &err);
>>      =A0 =A0 =A0 =A0 if (err !=3D NULL)
>>      =A0 =A0 =A0 =A0 {
>>      =A0 =A0 =A0 =A0 =A0 =A0 //error_propagate(errp, err);
>>      =A0 =A0 =A0 =A0 =A0 =A0 return;
>>      =A0 =A0 =A0 =A0 }
>>      =A0 =A0 =A0 =A0 busdev =3D SYS_BUS_DEVICE(dev);
>>      =A0 =A0 =A0 =A0 sysbus_mmio_map(busdev, 0, spi_addr[i]);
>>      =A0 =A0 =A0 =A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DE=
VICE(dev),
>>      spi_l0_irq[i]));
>>      =A0 =A0 =A0 =A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DE=
VICE(dev),
>>      spi_l1_irq[i]));
>>      =A0 =A0 }
>>
>>      =A0 =A0 //I2C
>>      =A0 =A0 for (i =3D 0; i < CR5_NUM_I2C; i++)
>>      =A0 =A0 {
>>      =A0 =A0 =A0 =A0 dev =3D DEVICE(&(s->i2c[i]));
>>      =A0 =A0 =A0 =A0 object_property_set_bool(OBJECT(&s->i2c[i]), true=
,
>>      "realized", &err);
>>      =A0 =A0 =A0 =A0 if (err !=3D NULL)
>>      =A0 =A0 =A0 =A0 {
>>      =A0 =A0 =A0 =A0 =A0 =A0 //error_propagate(errp, err);
>>      =A0 =A0 =A0 =A0 =A0 =A0 return;
>>      =A0 =A0 =A0 =A0 }
>>      =A0 =A0 =A0 =A0 busdev =3D SYS_BUS_DEVICE(dev);
>>      =A0 =A0 =A0 =A0 sysbus_mmio_map(busdev, 0, i2c_addr[i]);
>>      =A0 =A0 =A0 =A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DE=
VICE(dev),
>>      i2c_irq[i]));
>>      =A0 =A0 }
>>
>>      =A0 =A0 //CAN
>>      =A0 =A0 for (i =3D 0; i < CR5_NUM_CAN; i++)
>>      =A0 =A0 {
>>      =A0 =A0 =A0 =A0 dev =3D DEVICE(&(s->can[i]));
>>      =A0 =A0 =A0 =A0 object_property_set_bool(OBJECT(&s->can[i]), true=
,
>>      "realized", &err);
>>      =A0 =A0 =A0 =A0 if (err !=3D NULL)
>>      =A0 =A0 =A0 =A0 {
>>      =A0 =A0 =A0 =A0 =A0 =A0 //error_propagate(errp, err);
>>      =A0 =A0 =A0 =A0 =A0 =A0 return;
>>      =A0 =A0 =A0 =A0 }
>>      =A0 =A0 =A0 =A0 busdev =3D SYS_BUS_DEVICE(dev);
>>      =A0 =A0 =A0 =A0 sysbus_mmio_map(busdev, 0, can_addr[i]);
>>      =A0 =A0 =A0 =A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DE=
VICE(dev),
>>      can_l0_irq[i]));
>>      =A0 =A0 =A0 =A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DE=
VICE(dev),
>>      can_l1_irq[i]));
>>      =A0 =A0 =A0 =A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DE=
VICE(dev),
>>      can_if3_irq[i]));
>>      =A0 =A0 }
>>
>>      =A0 =A0 //ADC
>>      =A0 =A0 object_property_set_int(OBJECT(s->adc_irqs), CR5_NUM_ADC,
>>      "num-lines", &err);
>>      =A0 =A0 object_property_set_bool(OBJECT(s->adc_irqs), true, "real=
ized",
>>      &err);
>>      =A0 =A0 if (err !=3D NULL)
>>      =A0 =A0 {
>>      =A0 =A0 =A0 =A0 //error_propagate(errp, err);
>>      =A0 =A0 =A0 =A0 return;
>>      =A0 =A0 }
>>      =A0 =A0// qdev_connect_gpio_out(DEVICE(s->adc_irq), 0,
>>      qdev_get_gpio_in(dev));
>>
>>      =A0 =A0 for (i =3D 0; i < CR5_NUM_ADC; i++)
>>      =A0 =A0 {
>>      =A0 =A0 =A0 =A0 dev =3D DEVICE(&(s->adc[i]));
>>      =A0 =A0 =A0 =A0 object_property_set_bool(OBJECT(&s->adc[i]), true=
,
>>      "realized", &err);
>>      =A0 =A0 =A0 =A0 if (err !=3D NULL)
>>      =A0 =A0 =A0 =A0 {
>>      =A0 =A0 =A0 =A0 =A0 =A0 //error_propagate(errp, err);
>>      =A0 =A0 =A0 =A0 =A0 =A0 return;
>>      =A0 =A0 =A0 =A0 }
>>      =A0 =A0 =A0 =A0 busdev =3D SYS_BUS_DEVICE(dev);
>>      =A0 =A0 =A0 =A0 sysbus_mmio_map(busdev, 0, adc_addr[i]);
>>      =A0 =A0 =A0 =A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DE=
VICE(dev),
>>      adc_swgroup1_irq[i]));
>>      =A0 =A0 =A0 =A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DE=
VICE(dev),
>>      adc_swgroup2_irq[i]));
>>      =A0 =A0 =A0 =A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DE=
VICE(dev),
>>      adc_eventgroup_irq[i]));
>>      =A0 =A0 =A0 =A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DE=
VICE(dev),
>>      adc_magnitudecmp_irq[i]));
>>      =A0 =A0 }
>>
>>      =A0 =A0 //GIO
>>      =A0 =A0 for (i =3D 0; i < CR5_NUM_GIO; i++)
>>      =A0 =A0 {
>>      =A0 =A0 =A0 =A0 dev =3D DEVICE(&(s->gio[i]));
>>      =A0 =A0 =A0 =A0 object_property_set_bool(OBJECT(&s->gio[i]), true=
,
>>      "realized", &err);
>>      =A0 =A0 =A0 =A0 if (err !=3D NULL)
>>      =A0 =A0 =A0 =A0 {
>>      =A0 =A0 =A0 =A0 =A0 =A0 //error_propagate(errp, err);
>>      =A0 =A0 =A0 =A0 =A0 =A0 return;
>>      =A0 =A0 =A0 =A0 }
>>      =A0 =A0 =A0 =A0 busdev =3D SYS_BUS_DEVICE(dev);
>>      =A0 =A0 =A0 =A0 sysbus_mmio_map(busdev, 0, gio_addr[i]);
>>      =A0 =A0 =A0 =A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DE=
VICE(dev),
>>      gio_high_irq[i]));
>>      =A0 =A0 =A0 =A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DE=
VICE(dev),
>>      gio_low_irq[i]));
>>      =A0 =A0 }
>>      }
>>
>>
>>
>>      static void cortexR5_machine_init(MachineClass *mc){
>>      =A0 =A0//mc->name =3D "Cortex-R5f";
>>      =A0 =A0 mc->desc =3D "Based on TMS570LC43x";
>>      =A0 =A0 mc->init =3D =A0cortexR5_initf;
>>      =A0 =A0 mc->max_cpus =3D 1;
>>      =A0 =A0 mc->ignore_memory_transaction_failures =3D true;
>>      =A0 =A0 mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-r5f");
>>      }
>>
>>
>>
>>      DEFINE_MACHINE("cortex-r5", cortexR5_machine_init)
>>
>>
>>
>>
>> Thanks in advanced,
>>
>> Jo=E3o Gaspar
>>
>> Enviado do Outlook <http://aka.ms/weboutlook>
>=20
