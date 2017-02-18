Received: from eggs.gnu.org ([2001:4830:134:3::10]:46570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cfDXM-0002mG-3j
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 17:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cfDXH-0001wK-Lp
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 17:31:28 -0500
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
	<20170202051445.5735-51-david@gibson.dropbear.id.au>
	<CACXAS8D4n00aTL3ALrCDAxPx4SEG3wJvxCyRQKeZfgpdCQiBXw@mail.gmail.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <aa3b7291-8d93-25b4-184e-daa8f5738346@reactos.org>
Date: Sat, 18 Feb 2017 23:31:05 +0100
MIME-Version: 1.0
In-Reply-To: <CACXAS8D4n00aTL3ALrCDAxPx4SEG3wJvxCyRQKeZfgpdCQiBXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 050/107] prep: add IBM RS/6000 7020 (40p)
 machine emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, mdroth@linux.vnet.ibm.com, Alexander Graf <agraf@suse.de>, aik@ozlabs.ru, qemu-ppc@nongnu.org

Le 12/02/2017 =C3=A0 22:15, Artyom Tarasenko a =C3=A9crit :
> On Thu, Feb 2, 2017 at 6:13 AM, David Gibson
> <david@gibson.dropbear.id.au> wrote:
>> From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>>
>> Machine supports both Open Hack'Ware and OpenBIOS.
>> Open Hack'Ware is the default because OpenBIOS is currently unable to =
boot
>> PReP boot partitions or PReP kernels.
>>
>> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>> [dwg: Correct compile failure with KVM located by Thomas Huth]
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  default-configs/ppc-softmmu.mak |   1 +
>>  hw/ppc/prep.c                   | 230 +++++++++++++++++++++++++++++++=
+++++++++
>>  2 files changed, 231 insertions(+)
>>
>> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-sof=
tmmu.mak
>> index e567658..7dd004e 100644
>> --- a/default-configs/ppc-softmmu.mak
>> +++ b/default-configs/ppc-softmmu.mak
>> @@ -18,6 +18,7 @@ CONFIG_I82378=3Dy
>>  CONFIG_PC87312=3Dy
>>  CONFIG_MACIO=3Dy
>>  CONFIG_PCSPK=3Dy
>> +CONFIG_CS4231A=3Dy
>>  CONFIG_CUDA=3Dy
>>  CONFIG_ADB=3Dy
>>  CONFIG_MAC_NVRAM=3Dy
>> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
>> index 9fb89d3..ca7959c 100644
>> --- a/hw/ppc/prep.c
>> +++ b/hw/ppc/prep.c
>> @@ -2,6 +2,7 @@
>>   * QEMU PPC PREP hardware System Emulator
>>   *
>>   * Copyright (c) 2003-2007 Jocelyn Mayer
>> + * Copyright (c) 2017 Herv=C3=A9 Poussineau
>>   *
>>   * Permission is hereby granted, free of charge, to any person obtain=
ing a copy
>>   * of this software and associated documentation files (the "Software=
"), to deal
>> @@ -43,17 +44,21 @@
>>  #include "hw/isa/pc87312.h"
>>  #include "sysemu/block-backend.h"
>>  #include "sysemu/arch_init.h"
>> +#include "sysemu/kvm.h"
>>  #include "sysemu/qtest.h"
>>  #include "exec/address-spaces.h"
>>  #include "trace.h"
>>  #include "elf.h"
>>  #include "qemu/cutils.h"
>> +#include "kvm_ppc.h"
>>
>>  /* SMP is not enabled, for now */
>>  #define MAX_CPUS 1
>>
>>  #define MAX_IDE_BUS 2
>>
>> +#define CFG_ADDR 0xf0000510
>> +
>>  #define BIOS_SIZE (1024 * 1024)
>>  #define BIOS_FILENAME "ppc_rom.bin"
>>  #define KERNEL_LOAD_ADDR 0x01000000
>> @@ -316,6 +321,12 @@ static uint32_t PREP_io_800_readb (void *opaque, =
uint32_t addr)
>>
>>  #define NVRAM_SIZE        0x2000
>>
>> +static void fw_cfg_boot_set(void *opaque, const char *boot_device,
>> +                            Error **errp)
>> +{
>> +    fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
>> +}
>> +
>>  static void ppc_prep_reset(void *opaque)
>>  {
>>      PowerPCCPU *cpu =3D opaque;
>> @@ -677,4 +688,223 @@ static void prep_machine_init(MachineClass *mc)
>>      mc->default_boot_order =3D "cad";
>>  }
>>
>> +static int prep_set_cmos_checksum(DeviceState *dev, void *opaque)
>> +{
>> +    uint16_t checksum =3D *(uint16_t *)opaque;
>> +    ISADevice *rtc;
>> +
>> +    if (object_dynamic_cast(OBJECT(dev), "mc146818rtc")) {
>> +        rtc =3D ISA_DEVICE(dev);
>> +        rtc_set_memory(rtc, 0x2e, checksum & 0xff);
>> +        rtc_set_memory(rtc, 0x3e, checksum & 0xff);
>> +        rtc_set_memory(rtc, 0x2f, checksum >> 8);
>> +        rtc_set_memory(rtc, 0x3f, checksum >> 8);
>> +    }
>> +    return 0;
>> +}
>> +
>> +static void ibm_40p_init(MachineState *machine)
>> +{
>> +    CPUPPCState *env =3D NULL;
>> +    uint16_t cmos_checksum;
>> +    PowerPCCPU *cpu;
>> +    DeviceState *dev;
>> +    SysBusDevice *pcihost;
>> +    Nvram *m48t59 =3D NULL;
>> +    PCIBus *pci_bus;
>> +    ISABus *isa_bus;
>> +    void *fw_cfg;
>> +    int i;
>> +    uint32_t kernel_base =3D 0, initrd_base =3D 0;
>> +    long kernel_size =3D 0, initrd_size =3D 0;
>> +    char boot_device;
>> +
>> +    /* init CPU */
>> +    if (!machine->cpu_model) {
>> +        machine->cpu_model =3D "604";
>> +    }
>> +    cpu =3D cpu_ppc_init(machine->cpu_model);
>> +    if (!cpu) {
>> +        error_report("could not initialize CPU '%s'",
>> +                     machine->cpu_model);
>> +        exit(1);
>> +    }
>> +    env =3D &cpu->env;
>> +    if (PPC_INPUT(env) !=3D PPC_FLAGS_INPUT_6xx) {
>> +        error_report("only 6xx bus is supported on this machine");
>> +        exit(1);
>> +    }
>> +
>> +    if (env->flags & POWERPC_FLAG_RTC_CLK) {
>> +        /* POWER / PowerPC 601 RTC clock frequency is 7.8125 MHz */
>> +        cpu_ppc_tb_init(env, 7812500UL);
>
> Is this necessary? Looks like it sets both decrementer and cpu
> frequency to 7.8125 MHz,
> so the machine with -cpu 601 is working very slow.

It is a copy/paste from 'prep' machine.
This code has been added 10 years ago, and commit said:
"  New PowerPC CPU flag to define the decrementer and time-base source cl=
ock.
    Use it to properly initialize the clock for the PreP target."

If you think that it is incorrect, feel free to send a patch.

>
>> +    } else {
>> +        /* Set time-base frequency to 100 Mhz */
>> +        cpu_ppc_tb_init(env, 100UL * 1000UL * 1000UL);
>> +    }
>> +    qemu_register_reset(ppc_prep_reset, cpu);

[...]

Herv=C3=A9
