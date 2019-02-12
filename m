Received: from eggs.gnu.org ([209.51.188.92]:44205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtLV3-0002wg-Rh
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 19:00:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtLV1-0002XF-MS
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 19:00:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtLUx-0002Ow-Mq
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 19:00:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id t18so742212wrx.2
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 16:00:26 -0800 (PST)
References: <cover.1549857716.git.balaton@eik.bme.hu>
	<c86280648f23e89d6a864e4ab72912429c6277f2.1549857716.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <270f8d3d-884a-ec19-fabc-4b6a2867d48f@redhat.com>
Date: Tue, 12 Feb 2019 01:00:23 +0100
MIME-Version: 1.0
In-Reply-To: <c86280648f23e89d6a864e4ab72912429c6277f2.1549857716.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Huacai Chen <zltjiangshi@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On 2/11/19 5:01 AM, BALATON Zoltan wrote:
> The machine comes with 256M memory module by default but it's
> upgradable so it could have different memory size. There was a TODO
> comment to replace static SPD EEPROM data with dynamically generated
> one to support this. Now that we have a function for that, it's easy
> to do. Although this would allow larger RAM sizes, the peculiar memory
> map of the machine may need some special handling to map it as low and
> high memory. Because I don't know what the correct place would be for
> highmem, I've left memory size fixed at 256M for now and TODO is moved
> there instead.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/mips/mips_fulong2e.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 10e6ed585a..eec6fd02c8 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -214,20 +214,6 @@ static void main_cpu_reset(void *opaque)
>      }
>  }
>  
> -static const uint8_t eeprom_spd[0x80] = {
> -    0x80,0x08,0x07,0x0d,0x09,0x02,0x40,0x00,0x04,0x70,
> -    0x70,0x00,0x82,0x10,0x00,0x01,0x0e,0x04,0x0c,0x01,
> -    0x02,0x20,0x80,0x75,0x70,0x00,0x00,0x50,0x3c,0x50,
> -    0x2d,0x20,0xb0,0xb0,0x50,0x50,0x00,0x00,0x00,0x00,
> -    0x00,0x41,0x48,0x3c,0x32,0x75,0x00,0x00,0x00,0x00,
> -    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> -    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> -    0x00,0x00,0x00,0x9c,0x7b,0x07,0x00,0x00,0x00,0x00,
> -    0x00,0x00,0x00,0x00,0x48,0x42,0x35,0x34,0x41,0x32,
> -    0x35,0x36,0x38,0x4b,0x4e,0x2d,0x41,0x37,0x35,0x42,
> -    0x20,0x30,0x20
> -};
> -
>  static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
>                                         I2CBus **i2c_bus, ISABus **p_isa_bus)
>  {
> @@ -284,7 +270,6 @@ static void network_init (PCIBus *pci_bus)
>  
>  static void mips_fulong2e_init(MachineState *machine)
>  {
> -    ram_addr_t ram_size = machine->ram_size;
>      const char *kernel_filename = machine->kernel_filename;
>      const char *kernel_cmdline = machine->kernel_cmdline;
>      const char *initrd_filename = machine->initrd_filename;
> @@ -292,7 +277,10 @@ static void mips_fulong2e_init(MachineState *machine)
>      MemoryRegion *address_space_mem = get_system_memory();
>      MemoryRegion *ram = g_new(MemoryRegion, 1);
>      MemoryRegion *bios = g_new(MemoryRegion, 1);
> +    ram_addr_t ram_size = machine->ram_size;
>      long bios_size;
> +    uint8_t *spd_data;
> +    Error *err = NULL;
>      int64_t kernel_entry;
>      PCIBus *pci_bus;
>      ISABus *isa_bus;
> @@ -306,7 +294,7 @@ static void mips_fulong2e_init(MachineState *machine)
>  
>      qemu_register_reset(main_cpu_reset, cpu);
>  
> -    /* fulong 2e has 256M ram. */
> +    /* TODO: support more than 256M RAM as highmem */
>      ram_size = 256 * MiB;
>  
>      /* allocate RAM */
> @@ -359,8 +347,14 @@ static void mips_fulong2e_init(MachineState *machine)
>      vt82c686b_southbridge_init(pci_bus, FULONG2E_VIA_SLOT, env->irq[5],
>                                 &smbus, &isa_bus);
>  
> -    /* TODO: Populate SPD eeprom data.  */
> -    smbus_eeprom_init(smbus, 1, eeprom_spd, sizeof(eeprom_spd));
> +    /* Populate SPD eeprom data */
> +    spd_data = spd_data_generate(DDR, ram_size, &err);
> +    if (err) {
> +        warn_report_err(err);
> +    }
> +    if (spd_data) {
> +        smbus_eeprom_init_one(smbus, 0x50, spd_data);
> +    }
>  
>      mc146818_rtc_init(isa_bus, 2000, NULL);
>  
> @@ -374,6 +368,7 @@ static void mips_fulong2e_machine_init(MachineClass *mc)
>      mc->init = mips_fulong2e_init;
>      mc->block_default_type = IF_IDE;
>      mc->default_cpu_type = MIPS_CPU_TYPE_NAME("Loongson-2E");
> +    mc->default_ram_size = 256 * MiB;
>  }
>  
>  DEFINE_MACHINE("fulong2e", mips_fulong2e_machine_init)
> 
