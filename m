Received: from eggs.gnu.org ([2001:4830:134:3::10]:60762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eb9TC-0001TT-0V
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eb9T8-00045l-QQ
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:26:53 -0500
Received: from chuckie.co.uk ([82.165.15.123]:45331
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eb9T8-00043P-Ie
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:26:50 -0500
References: <20180114104751.21965-1-mark.cave-ayland@ilande.co.uk>
	<20180114104751.21965-8-mark.cave-ayland@ilande.co.uk>
	<ee46e8fc-0ff2-3624-1b51-7377f05143d3@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <af188181-8d00-27b4-f268-75401c893b32@ilande.co.uk>
Date: Mon, 15 Jan 2018 18:26:41 +0000
MIME-Version: 1.0
In-Reply-To: <ee46e8fc-0ff2-3624-1b51-7377f05143d3@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/11] sun4u: rename apb variables and
 constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, atar4qemu@gmail.com
Cc: qemu-devel@nongnu.org

On 14/01/18 13:20, Philippe Mathieu-Daudé wrote:
> Hi Mark,
> 
> On 01/14/2018 07:47 AM, Mark Cave-Ayland wrote:
>> In order to reflect the previous change of TYPE_APB to TYPE_SABRE, update
>> the corresponding variable names to keep the terminology consistent.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/sparc64/sun4u.c | 41 +++++++++++++++++++++--------------------
>>   1 file changed, 21 insertions(+), 20 deletions(-)
>>
>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>> index b8f685847a..fb18afaaa6 100644
>> --- a/hw/sparc64/sun4u.c
>> +++ b/hw/sparc64/sun4u.c
>> @@ -55,9 +55,9 @@
>>   #define CMDLINE_ADDR         0x003ff000
>>   #define PROM_SIZE_MAX        (4 * 1024 * 1024)
>>   #define PROM_VADDR           0x000ffd00000ULL
>> -#define APB_SPECIAL_BASE     0x1fe00000000ULL
>> -#define APB_MEM_BASE         0x1ff00000000ULL
>> -#define APB_PCI_IO_BASE      (APB_SPECIAL_BASE + 0x02000000ULL)
>> +#define PBM_SPECIAL_BASE     0x1fe00000000ULL
>> +#define PBM_MEM_BASE         0x1ff00000000ULL
>> +#define PBM_PCI_IO_BASE      (PBM_SPECIAL_BASE + 0x02000000ULL)
>>   #define PROM_FILENAME        "openbios-sparc64"
>>   #define NVRAM_SIZE           0x2000
>>   #define MAX_IDE_BUS          2
>> @@ -465,7 +465,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>>       Nvram *nvram;
>>       unsigned int i;
>>       uint64_t initrd_addr, initrd_size, kernel_addr, kernel_size, kernel_entry;
>> -    SabreState *apb;
>> +    SabreState *sabre;
>>       PCIBus *pci_bus, *pci_busA, *pci_busB;
>>       PCIDevice *ebus, *pci_dev;
>>       SysBusDevice *s;
>> @@ -489,23 +489,24 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>>       prom_init(hwdef->prom_addr, bios_name);
>>   
>>       /* Init sabre (PCI host bridge) */
>> -    apb = SABRE_DEVICE(qdev_create(NULL, TYPE_SABRE));
>> -    qdev_prop_set_uint64(DEVICE(apb), "special-base", APB_SPECIAL_BASE);
>> -    qdev_prop_set_uint64(DEVICE(apb), "mem-base", APB_MEM_BASE);
>> -    object_property_set_link(OBJECT(apb), OBJECT(iommu), "iommu", &error_abort);
>> -    qdev_init_nofail(DEVICE(apb));
>> +    sabre = SABRE_DEVICE(qdev_create(NULL, TYPE_SABRE));
>> +    qdev_prop_set_uint64(DEVICE(sabre), "special-base", PBM_SPECIAL_BASE);
>> +    qdev_prop_set_uint64(DEVICE(sabre), "mem-base", PBM_MEM_BASE);
>> +    object_property_set_link(OBJECT(sabre), OBJECT(iommu), "iommu",
>> +                             &error_abort);
>> +    qdev_init_nofail(DEVICE(sabre));
>>   
>>       /* Wire up PCI interrupts to CPU */
>>       for (i = 0; i < IVEC_MAX; i++) {
>> -        qdev_connect_gpio_out_named(DEVICE(apb), "ivec-irq", i,
>> +        qdev_connect_gpio_out_named(DEVICE(sabre), "ivec-irq", i,
>>               qdev_get_gpio_in_named(DEVICE(cpu), "ivec-irq", i));
>>       }
>>   
>> -    pci_bus = PCI_HOST_BRIDGE(apb)->bus;
>> -    pci_busA = pci_bridge_get_sec_bus(apb->bridgeA);
>> -    pci_busB = pci_bridge_get_sec_bus(apb->bridgeB);
>> +    pci_bus = PCI_HOST_BRIDGE(sabre)->bus;
>> +    pci_busA = pci_bridge_get_sec_bus(sabre->bridgeA);
>> +    pci_busB = pci_bridge_get_sec_bus(sabre->bridgeB);
>>   
>> -    /* Only in-built Simba PBMs can exist on the root bus, slot 0 on busA is
>> +    /* Only in-built Simba APBs can exist on the root bus, slot 0 on busA is
> 
> This single change might go in patch #2 instead.
> 
> Anyway:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Hi Philippe,

I did think about that, but it feels a bit cleaner to keep all the sun4u 
changes in one place (see the change to the constants and the other 
comments within the file).


ATB,

Mark.
