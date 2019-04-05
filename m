Received: from eggs.gnu.org ([209.51.188.92]:35748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCLTu-0003BO-L8
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCLTp-0003ju-Bf
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:49:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCLTn-0003Z1-E5
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:49:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so6491751wmd.0
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 02:49:44 -0700 (PDT)
References: <20190404221238.12468-1-philmd@redhat.com>
	<20190404221238.12468-5-philmd@redhat.com>
	<bb4e3258-9036-e487-81b4-8bc5eff24158@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2ac6c0ac-7304-91f3-49d5-649e1bdda8c9@redhat.com>
Date: Fri, 5 Apr 2019 11:49:41 +0200
MIME-Version: 1.0
In-Reply-To: <bb4e3258-9036-e487-81b4-8bc5eff24158@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 4/4] hw/mips/r4k: Refactor the
 Super I/O chipset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>

On 4/5/19 6:51 AM, Thomas Huth wrote:
> On 05/04/2019 00.12, Philippe Mathieu-Daudé wrote:
>> ISA Super I/O are already modeled by the ISASuperIODevice abstract
>> device.
>> Since this board uses a generic ISA Super I/O chipset, refactor it
>> as the TYPE_R4K_SUPERIO device, child of ISASuperIODevice.
> 
> Good idea!
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/mips/mips_r4k.c | 61 ++++++++++++++++++++++++++++++++++------------
>>  1 file changed, 45 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
>> index 93dbf76bb49..b51a9523b43 100644
>> --- a/hw/mips/mips_r4k.c
>> +++ b/hw/mips/mips_r4k.c
>> @@ -18,6 +18,7 @@
>>  #include "hw/i386/pc.h"
>>  #include "hw/char/serial.h"
>>  #include "hw/isa/isa.h"
>> +#include "hw/isa/superio.h"
>>  #include "net/net.h"
>>  #include "hw/net/ne2000-isa.h"
>>  #include "sysemu/sysemu.h"
>> @@ -29,7 +30,6 @@
>>  #include "hw/loader.h"
>>  #include "elf.h"
>>  #include "hw/timer/mc146818rtc.h"
>> -#include "hw/input/i8042.h"
>>  #include "hw/timer/i8254.h"
>>  #include "exec/address-spaces.h"
>>  #include "sysemu/qtest.h"
>> @@ -37,10 +37,6 @@
>>  
>>  #define MAX_IDE_BUS 2
>>  
>> -static const int ide_iobase[2] = { 0x1f0, 0x170 };
>> -static const int ide_iobase2[2] = { 0x3f6, 0x376 };
>> -static const int ide_irq[2] = { 14, 15 };
>> -
>>  static ISADevice *pit; /* PIT i8254 */
>>  
>>  /* i8254 PIT is attached to the IRQ0 at PIC i8259 */
>> @@ -73,6 +69,49 @@ static const MemoryRegionOps mips_qemu_ops = {
>>      .endianness = DEVICE_NATIVE_ENDIAN,
>>  };
>>  
>> +#define TYPE_R4K_SUPERIO "r4k-superio"
>> +
>> +static uint16_t get_ide_iobase(ISASuperIODevice *sio, uint8_t index)
>> +{
>> +    static const uint16_t ide_iobase[] = { 0x1f0, 0x3f6, 0x170, 0x376 };
>> +
>> +    return ide_iobase[index];
>> +}
>> +
>> +static unsigned int get_ide_irq(ISASuperIODevice *sio, uint8_t index)
>> +{
>> +    return index < MAX_IDE_DEVS ? 14 : 15;
>> +}
>> +
>> +static void r4k_superio_class_init(ObjectClass *klass, void *data)
>> +{
>> +    ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
>> +
>> +    sc->serial.count = MAX_ISA_SERIAL_PORTS;
>> +    sc->parallel.count = 0;
>> +    sc->floppy.count = 0;
>> +    sc->ide = (ISASuperIOFuncs){
>> +        .count = MAX_IDE_BUS * MAX_IDE_DEVS,
>> +        .get_iobase = get_ide_iobase,
>> +        .get_irq    = get_ide_irq,
>> +    };
>> +}
>> +
>> +static const TypeInfo r4k_superio_type_info = {
>> +    .name          = TYPE_R4K_SUPERIO,
>> +    .parent        = TYPE_ISA_SUPERIO,
>> +    .instance_size = sizeof(ISASuperIODevice),
>> +    .class_size    = sizeof(ISASuperIOClass),
>> +    .class_init    = r4k_superio_class_init,
>> +};
>> +
>> +static void r4k_superio_register_types(void)
>> +{
>> +    type_register_static(&r4k_superio_type_info);
>> +}
>> +
>> +type_init(r4k_superio_register_types)
>> +
>>  typedef struct ResetData {
>>      MIPSCPU *cpu;
>>      uint64_t vector;
>> @@ -179,10 +218,8 @@ void mips_r4k_init(MachineState *machine)
>>      MIPSCPU *cpu;
>>      CPUMIPSState *env;
>>      ResetData *reset_info;
>> -    int i;
>>      qemu_irq *i8259;
>>      ISABus *isa_bus;
>> -    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>>      DriveInfo *dinfo;
>>      int be;
>>  
>> @@ -274,20 +311,12 @@ void mips_r4k_init(MachineState *machine)
>>  
>>      pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
>>  
>> -    serial_hds_isa_init(isa_bus, 0, MAX_ISA_SERIAL_PORTS);
>> -
>>      isa_vga_init(isa_bus);
>>  
>>      if (nd_table[0].used)
>>          isa_ne2000_init(isa_bus, 0x300, 9, &nd_table[0]);
>>  
>> -    ide_drive_get(hd, ARRAY_SIZE(hd));
>> -    for(i = 0; i < MAX_IDE_BUS; i++)
>> -        isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i], ide_irq[i],
>> -                     hd[MAX_IDE_DEVS * i],
>> -                     hd[MAX_IDE_DEVS * i + 1]);
>> -
>> -    isa_create_simple(isa_bus, TYPE_I8042);
>> +    isa_create_simple(isa_bus, TYPE_R4K_SUPERIO);
> 
> What about the ide_drive_get() and the ide_create_drive() that is done
> by isa_ide_init() internally? As far as I can see, the superio code does
> not do this job for you? So don't you have to do that manually here
> after creating the R4K_SUPERIO device?

Oops... I was scared I did the same mistake with the Floppy controller
in 7313b1f28be but hopefully not. However you made me notice I never
considered the case MAX_FD>2. I'll send a mail asking if this case is
still used.

Thanks!

Phil.
