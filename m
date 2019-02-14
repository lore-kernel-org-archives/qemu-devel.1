Received: from eggs.gnu.org ([209.51.188.92]:34644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1guL50-0003GX-Gk
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:45:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1guL4s-0002pR-9Q
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:45:41 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:49675)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1guL4b-0002Xx-UA
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:45:27 -0500
Date: Thu, 14 Feb 2019 18:45:10 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <BN6PR2201MB1251275AF7447D9252214C27C6670@BN6PR2201MB1251.namprd22.prod.outlook.com>
Message-ID: <alpine.BSF.2.21.9999.1902141822270.64316@zero.eik.bme.hu>
References: <cover.1549857716.git.balaton@eik.bme.hu>,
	<c86280648f23e89d6a864e4ab72912429c6277f2.1549857716.git.balaton@eik.bme.hu>
	<BN6PR2201MB1251275AF7447D9252214C27C6670@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 3/4] mips_fulong2e: Dynamically generate
 SPD EEPROM data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Huacai Chen <zltjiangshi@gmail.com>, =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>

Hello,

On Thu, 14 Feb 2019, Aleksandar Markovic wrote:
>> The machine comes with 256M memory module by default but it's
>> upgradable so it could have different memory size. There was a TODO
>> comment to replace static SPD EEPROM data with dynamically generated
>> one to support this. Now that we have a function for that, it's easy
>> to do. Although this would allow larger RAM sizes, the peculiar memory
>> map of the machine may need some special handling to map it as low and
>> high memory. Because I don't know what the correct place would be for
>> highmem, I've left memory size fixed at 256M for now and TODO is moved
>> there instead.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/mips/mips_fulong2e.c | 31 +++++++++++++------------------
>>  1 file changed, 13 insertions(+), 18 deletions(-)
>>
>
> Hello, Zoltan.
>
> Thank you for your work in this area. I genarally support this series.
> (When can we expect v2? I would like to integrate this series before
> 4.0 soft freeze planned for March 12th.)

I plan to submit v2 definitely before freeze (maybe this week end or next 
week) I was just waiting for review comments and to see what happens to 
the ati-vga patch this depends on.

> However, I have just a couple of questions:
>
> 1. Is this series dependent on the patches outside of this series?
> (meaning, the functionality won't work unless those other patches
> are in the tree?)

To quote my original cover letter:

"my recent via-ide changes and the separately submitted
hw/display: Add basic ATI VGA emulation
patch and after this series the pmon_2e.bin firmware from
https://mirrors.cloud.tencent.com/loongson/pmon/
can actually run and appears to work. I could not find an image to
boot so I could not test that further but this appears to be an
improvement that worth submitting now."

Maybe this wasn't clear but only the last patch in this series 
(mips_fulong2e: Add on-board graphics chip) depends on the separate 
ati-vga patch mentioned above, the rest are not dependent on anything 
else. My via changes are already merged through the ide tree so those are 
already in master.

> 2. Can you spell out the test procedure that you used, after this
> series (and possibly other needed patches) is applied?

I've tried:

qemu-system-mips64el -M fulong2e -bios pmon_2e.bin

with the pmon ROM image from the above link. I've also tried booting some 
Linux kernel but I could not find a suitable iso so if anyone is aware of 
a boot CD or image that should work on real hardware I could try that. I 
think Debian 8.11.0 should boot but needs external kernels which I don't 
have. Maybe Philippe can add to this what he tested.

> 3. What exactly this series fixes, or improves?

The series improves the fulong2e machine model to work with its original 
firmware. Previously it needed some modified firmware which was not 
available so this actually makes this board a bit more useful.

>
> Thanks again!
>
> Aleksandar
>
>> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
>> index 10e6ed585a..eec6fd02c8 100644
>> --- a/hw/mips/mips_fulong2e.c
>> +++ b/hw/mips/mips_fulong2e.c
>> @@ -214,20 +214,6 @@ static void main_cpu_reset(void *opaque)
>>      }
>>  }
>>
>> -static const uint8_t eeprom_spd[0x80] = {
>> -    0x80,0x08,0x07,0x0d,0x09,0x02,0x40,0x00,0x04,0x70,
>> -    0x70,0x00,0x82,0x10,0x00,0x01,0x0e,0x04,0x0c,0x01,
>> -    0x02,0x20,0x80,0x75,0x70,0x00,0x00,0x50,0x3c,0x50,
>> -    0x2d,0x20,0xb0,0xb0,0x50,0x50,0x00,0x00,0x00,0x00,
>> -    0x00,0x41,0x48,0x3c,0x32,0x75,0x00,0x00,0x00,0x00,
>> -    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
>> -    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
>> -    0x00,0x00,0x00,0x9c,0x7b,0x07,0x00,0x00,0x00,0x00,
>> -    0x00,0x00,0x00,0x00,0x48,0x42,0x35,0x34,0x41,0x32,
>> -    0x35,0x36,0x38,0x4b,0x4e,0x2d,0x41,0x37,0x35,0x42,
>> -    0x20,0x30,0x20
>> -};
>> -
>>  static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
>>                                         I2CBus **i2c_bus, ISABus **p_isa_bus)
>>  {
>> @@ -284,7 +270,6 @@ static void network_init (PCIBus *pci_bus)
>>
>>  static void mips_fulong2e_init(MachineState *machine)
>>  {
>> -    ram_addr_t ram_size = machine->ram_size;
>>      const char *kernel_filename = machine->kernel_filename;
>>      const char *kernel_cmdline = machine->kernel_cmdline;
>>      const char *initrd_filename = machine->initrd_filename;
>> @@ -292,7 +277,10 @@ static void mips_fulong2e_init(MachineState *machine)
>>      MemoryRegion *address_space_mem = get_system_memory();
>>      MemoryRegion *ram = g_new(MemoryRegion, 1);
>>      MemoryRegion *bios = g_new(MemoryRegion, 1);
>> +    ram_addr_t ram_size = machine->ram_size;
>>      long bios_size;
>> +    uint8_t *spd_data;
>> +    Error *err = NULL;
>>      int64_t kernel_entry;
>>      PCIBus *pci_bus;
>>      ISABus *isa_bus;
>> @@ -306,7 +294,7 @@ static void mips_fulong2e_init(MachineState *machine)
>>
>>      qemu_register_reset(main_cpu_reset, cpu);
>>
>> -    /* fulong 2e has 256M ram. */
>> +    /* TODO: support more than 256M RAM as highmem */
>>      ram_size = 256 * MiB;

This particular patch about SPD EEPROM just removes the static EEPROM data 
in favour of the spd_data_generate() function I've recently added which 
also allows to use different RAM size than hard coded 256 that was 
previously also limited by the static SPD data. RAM size is still fixed to 
256M here because I don't know where to map the highmem beyond the first 
256M on MIPS in general and on this board in particular but PMON now 
recognises bigger RAM sizes as highmem when I remove this fixed setting 
after this patch. I've added a TODO comment here for this, when this is 
resolved these lines could be removed as well but I don't intend to do 
that as I don't know how it should work.

Similar cleanup could be done for the malta board which I could try to do 
but I couldn't find its YAMON firmware to test with (a comment in the code 
mentions that it's the way it is due to a bug in that firmware so that 
should be tested to make sure it works, that's why I haven't touched 
that.)

Regards,
BALATON Zoltan

>>      /* allocate RAM */
>> @@ -359,8 +347,14 @@ static void mips_fulong2e_init(MachineState *machine)
>>      vt82c686b_southbridge_init(pci_bus, FULONG2E_VIA_SLOT, env->irq[5],
>>                                 &smbus, &isa_bus);
>>
>> -    /* TODO: Populate SPD eeprom data.  */
>> -    smbus_eeprom_init(smbus, 1, eeprom_spd, sizeof(eeprom_spd));
>> +    /* Populate SPD eeprom data */
>> +    spd_data = spd_data_generate(DDR, ram_size, &err);
>> +    if (err) {
>> +        warn_report_err(err);
>> +    }
>> +    if (spd_data) {
>> +        smbus_eeprom_init_one(smbus, 0x50, spd_data);
>> +    }
>>
>>      mc146818_rtc_init(isa_bus, 2000, NULL);
>>
>> @@ -374,6 +368,7 @@ static void mips_fulong2e_machine_init(MachineClass *mc)
>>      mc->init = mips_fulong2e_init;
>>      mc->block_default_type = IF_IDE;
>>      mc->default_cpu_type = MIPS_CPU_TYPE_NAME("Loongson-2E");
>> +    mc->default_ram_size = 256 * MiB;
>>  }
>>
>>  DEFINE_MACHINE("fulong2e", mips_fulong2e_machine_init)
>> --
>> 2.13.7
>>
>
>
