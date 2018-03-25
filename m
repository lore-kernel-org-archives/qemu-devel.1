Received: from eggs.gnu.org ([2001:4830:134:3::10]:50280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1f0CvQ-0001gV-MW
	for qemu-devel@nongnu.org; Sun, 25 Mar 2018 17:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1f0CvN-0004it-B7
	for qemu-devel@nongnu.org; Sun, 25 Mar 2018 17:11:36 -0400
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-18-mark.cave-ayland@ilande.co.uk>
	<20180321032924.GP3905@umbus.fritz.box>
	<08c7c486-850c-ce0b-71f8-1cb505028d5c@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <16bbd1be-1d4a-b158-884b-9cda30502816@ilande.co.uk>
Date: Sun, 25 Mar 2018 22:11:12 +0100
MIME-Version: 1.0
In-Reply-To: <08c7c486-850c-ce0b-71f8-1cb505028d5c@amsat.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 17/19] uninorth: create new uninorth device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 22/03/18 09:00, Philippe Mathieu-Daudé wrote:

> Hi Mark,
> 
> On 03/21/2018 12:29 AM, David Gibson wrote:
>> On Tue, Mar 06, 2018 at 08:31:01PM +0000, Mark Cave-Ayland wrote:
>>> Commit 4e46dcdbd3 "PPC: Newworld: Add uninorth token register" added a TODO
>>> which was to convert the uninorth registers hack to a proper device. Move
>>> these registers to a new uninorth device, removing the old hacks from
>>> mac_newworld.c.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>   hw/pci-host/trace-events       |  2 ++
>>>   hw/pci-host/uninorth.c         | 58 ++++++++++++++++++++++++++++++++++++++++++
>>>   hw/ppc/mac_newworld.c          | 41 +++++------------------------
>>>   hw/ppc/trace-events            |  4 ---
>>>   include/hw/pci-host/uninorth.h | 11 ++++++++
>>>   5 files changed, 77 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
>>> index 341a87a702..dd7a398e96 100644
>>> --- a/hw/pci-host/trace-events
>>> +++ b/hw/pci-host/trace-events
>>> @@ -18,3 +18,5 @@ unin_set_irq(int irq_num, int level) "setting INT %d = %d"
>>>   unin_get_config_reg(uint32_t reg, uint32_t addr, uint32_t retval) "converted config space accessor 0x%"PRIx32 "/0x%"PRIx32 " -> 0x%"PRIx32
>>>   unin_data_write(uint64_t addr, unsigned len, uint64_t val) "write addr 0x%"PRIx64 " len %d val 0x%"PRIx64
>>>   unin_data_read(uint64_t addr, unsigned len, uint64_t val) "read addr 0x%"PRIx64 " len %d val 0x%"PRIx64
>>> +unin_write(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
>>> +unin_read(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
>>> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
>>> index fada0ffd5f..dbfad01d9d 100644
>>> --- a/hw/pci-host/uninorth.c
>>> +++ b/hw/pci-host/uninorth.c
>>> @@ -519,6 +519,62 @@ static const TypeInfo pci_unin_internal_info = {
>>>       .class_init    = pci_unin_internal_class_init,
>>>   };
>>>   
>>> +/* UniN device */
>>> +static void unin_write(void *opaque, hwaddr addr, uint64_t value,
>>> +                       unsigned size)
>>> +{
>>> +    trace_unin_write(addr, value);
>>> +    if (addr == 0x0) {
>>> +        *(int *)opaque = value;
> 
> This looks a dirty insecure optimization...
> 
> I see this is code motion, can you clean up using UNINState:
> 
>          UNINState *s = UNI_NORTH(obj);
> 
>          ...
>              s->token = value;
> 
>>> +    }
>>> +}
>>> +
>>> +static uint64_t unin_read(void *opaque, hwaddr addr, unsigned size)
>>> +{
>>> +    uint32_t value;
>>> +
>>> +    value = 0;
>>> +    switch (addr) {
>>> +    case 0:
>>> +        value = *(int *)opaque;
> 
> Same,
> 
>>> +    }
>>> +
>>> +    trace_unin_read(addr, value);
>>> +
>>> +    return value;
>>> +}
>>> +
>>> +static const MemoryRegionOps unin_ops = {
>>> +    .read = unin_read,
>>> +    .write = unin_write,
>>> +    .endianness = DEVICE_NATIVE_ENDIAN,
>>
>> DEVICE_NATIVE_ENDIAN is almost always wrong.  I'm pretty sure it
>> should be DEVICE_BIG_ENDIAN.  I realize this is just a code motion,
>> but while you're making a proper device of it, you might as well fix
>> this to.
>>
>>> +};
>>> +
>>> +static void unin_init(Object *obj)
>>> +{
>>> +    UNINState *s = UNI_NORTH(obj);
>>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>>> +
>>> +    memory_region_init_io(&s->mem, obj, &unin_ops, &s->token, "unin", 0x1000);
> 
> And here:
> 
>      memory_region_init_io(&s->mem, obj, &unin_ops, s, "unin", 0x1000);
> 
>>> +
>>> +    sysbus_init_mmio(sbd, &s->mem);
>>> +}
>>> +
>>> +static void unin_class_init(ObjectClass *klass, void *data)
>>> +{
>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>> +
>>> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>>> +}
>>> +
>>> +static const TypeInfo unin_info = {
>>> +    .name          = TYPE_UNI_NORTH,
>>> +    .parent        = TYPE_SYS_BUS_DEVICE,
>>> +    .instance_size = sizeof(UNINState),
>>> +    .instance_init = unin_init,
>>> +    .class_init    = unin_class_init,
>>> +};
>>> +
>>>   static void unin_register_types(void)
>>>   {
>>>       type_register_static(&unin_main_pci_host_info);
>>> @@ -530,6 +586,8 @@ static void unin_register_types(void)
>>>       type_register_static(&pci_u3_agp_info);
>>>       type_register_static(&pci_unin_agp_info);
>>>       type_register_static(&pci_unin_internal_info);
>>> +
>>> +    type_register_static(&unin_info);
>>>   }
>>>   
>>>   type_init(unin_register_types)
>>> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
>>> index ae0de4e36e..2fcb101982 100644
>>> --- a/hw/ppc/mac_newworld.c
>>> +++ b/hw/ppc/mac_newworld.c
>>> @@ -83,36 +83,6 @@
>>>   
>>>   #define NDRV_VGA_FILENAME "qemu_vga.ndrv"
>>>   
>>> -/* UniN device */
>>> -static void unin_write(void *opaque, hwaddr addr, uint64_t value,
>>> -                       unsigned size)
>>> -{
>>> -    trace_mac99_uninorth_write(addr, value);
>>> -    if (addr == 0x0) {
>>> -        *(int*)opaque = value;
>>> -    }
>>> -}
>>> -
>>> -static uint64_t unin_read(void *opaque, hwaddr addr, unsigned size)
>>> -{
>>> -    uint32_t value;
>>> -
>>> -    value = 0;
>>> -    switch (addr) {
>>> -    case 0:
>>> -        value = *(int*)opaque;
>>> -    }
>>> -
>>> -    trace_mac99_uninorth_read(addr, value);
>>> -
>>> -    return value;
>>> -}
>>> -
>>> -static const MemoryRegionOps unin_ops = {
>>> -    .read = unin_read,
>>> -    .write = unin_write,
>>> -    .endianness = DEVICE_NATIVE_ENDIAN,
>>> -};
>>>   
>>>   static void fw_cfg_boot_set(void *opaque, const char *boot_device,
>>>                               Error **errp)
>>> @@ -146,7 +116,6 @@ static void ppc_core99_init(MachineState *machine)
>>>       CPUPPCState *env = NULL;
>>>       char *filename;
>>>       qemu_irq *pic, **openpic_irqs;
>>> -    MemoryRegion *unin_memory = g_new(MemoryRegion, 1);
>>>       int linux_boot, i, j, k;
>>>       MemoryRegion *ram = g_new(MemoryRegion, 1), *bios = g_new(MemoryRegion, 1);
>>>       hwaddr kernel_base, initrd_base, cmdline_base = 0;
>>> @@ -165,7 +134,6 @@ static void ppc_core99_init(MachineState *machine)
>>>       int machine_arch;
>>>       SysBusDevice *s;
>>>       DeviceState *dev, *pic_dev;
>>> -    int *token = g_new(int, 1);
>>>       hwaddr nvram_addr = 0xFFF04000;
>>>       uint64_t tbfreq;
>>>   
>>> @@ -273,9 +241,12 @@ static void ppc_core99_init(MachineState *machine)
>>>           }
>>>       }
>>>   
>>> -    /* UniN init: XXX should be a real device */
>>> -    memory_region_init_io(unin_memory, NULL, &unin_ops, token, "unin", 0x1000);
>>> -    memory_region_add_subregion(get_system_memory(), 0xf8000000, unin_memory);
>>> +    /* UniN init */
>>> +    dev = qdev_create(NULL, TYPE_UNI_NORTH);
>>> +    qdev_init_nofail(dev);
>>> +    s = SYS_BUS_DEVICE(dev);
>>> +    memory_region_add_subregion(get_system_memory(), 0xf8000000,
>>> +                                sysbus_mmio_get_region(s, 0));
>>>   
>>>       openpic_irqs = g_malloc0(smp_cpus * sizeof(qemu_irq *));
>>>       openpic_irqs[0] =
>>> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
>>> index 66ec7eda6e..dc5e65aee9 100644
>>> --- a/hw/ppc/trace-events
>>> +++ b/hw/ppc/trace-events
>>> @@ -92,10 +92,6 @@ rs6000mc_size_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
>>>   rs6000mc_size_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
>>>   rs6000mc_parity_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
>>>   
>>> -# hw/ppc/mac_newworld.c
>>> -mac99_uninorth_write(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
>>> -mac99_uninorth_read(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
>>> -
>>>   # hw/ppc/ppc4xx_pci.c
>>>   ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
>>>   ppc4xx_pci_set_irq(int irq_num) "PCI irq %d"
>>> diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninorth.h
>>> index d1424b165a..b0eb093e72 100644
>>> --- a/include/hw/pci-host/uninorth.h
>>> +++ b/include/hw/pci-host/uninorth.h
>>> @@ -51,4 +51,15 @@ typedef struct UNINHostState {
>>>       MemoryRegion pci_io;
>>>   } UNINHostState;
>>>   
>>> +typedef struct UNINState {
>>> +    SysBusDevice parent_obj;
>>> +
>>> +    MemoryRegion mem;
>>> +    int token[1];
> 
> having 'token' being 'int' type also looks weird.
> 
> Maybe target_ulong is better?
> 
>>> +} UNINState;
>>> +
>>> +#define TYPE_UNI_NORTH "uni-north"
>>> +#define UNI_NORTH(obj) \
>>> +    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH)
>>> +
>>>   #endif /* UNINORTH_H */

Just to follow up on this, I spent a bit looking at what this register 
is trying to do and from the Darwin source I can see that in fact it is 
simply a hard-wired hardware register which should return the revision 
of the UniNorth hardware.

So in fact the code in its current form is completely bogus which is 
visible when trying to boot FreeBSD, which as the register is never 
written to, returns a completely different random number each time.

David - are you okay to change DEVICE_NATIVE_ENDIAN to DEVICE_BIG_ENDIAN 
and then apply this and the final patch to your for-2.13 queue? I can 
then follow up with another patch later that will implement this 
register (and also the matching PCI revision ID) correctly.


ATB,

Mark.
