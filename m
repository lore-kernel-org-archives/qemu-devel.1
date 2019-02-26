Received: from eggs.gnu.org ([209.51.188.92]:55272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gyfUg-0007dm-MZ
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:22:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gyfUe-0006Pt-Ki
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:22:10 -0500
References: <20190225183757.27378-1-armbru@redhat.com>
	<20190225183757.27378-7-armbru@redhat.com>
	<9d2b6670-5d1e-9c7d-df34-226cb1469f99@redhat.com>
	<87a7iizq16.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <93f7bdc8-037e-8b43-02a9-b6271f3d8246@redhat.com>
Date: Tue, 26 Feb 2019 17:21:56 +0100
MIME-Version: 1.0
In-Reply-To: <87a7iizq16.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 6/6] pc: Support firmware configuration
 with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org, mst@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

On 02/26/19 13:35, Markus Armbruster wrote:
> Laszlo Ersek <lersek@redhat.com> writes:

>>> -#define FLASH_MAP_UNIT_MAX 2
>>> +static PFlashCFI01 *pc_pflash_create(const char *name)
>>> +{
>>> +    DeviceState *dev = qdev_create(NULL, TYPE_CFI_PFLASH01);
>>> +
>>> +    qdev_prop_set_uint64(dev, "sector-length", 4096);
>>> +    qdev_prop_set_uint8(dev, "width", 1);
>>> +    qdev_prop_set_string(dev, "name", name);
>>> +    return CFI_PFLASH01(dev);
>>> +}
>>> +
>>> +void pc_system_flash_create(PCMachineState *pcms)
>>> +{
>>> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>>> +
>>> +    if (pcmc->pci_enabled) {
>>> +        pcms->flash[0] = pc_pflash_create("system.flash0");
>>> +        pcms->flash[1] = pc_pflash_create("system.flash1");
>>> +        object_property_add_alias(OBJECT(pcms), "pflash0",
>>> +                                  OBJECT(pcms->flash[0]), "drive",
>>> +                                  &error_abort);
>>> +        object_property_add_alias(OBJECT(pcms), "pflash1",
>>> +                                  OBJECT(pcms->flash[1]), "drive",
>>> +                                  &error_abort);
>>> +    }
>>> +}
>>> +
>>> +static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
>>> +{
>>> +    char *prop_name;
>>> +    int i;
>>> +    Object *dev_obj;
>>> +
>>> +    assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
>>> +        dev_obj = OBJECT(pcms->flash[i]);
>>> +        if (!object_property_get_bool(dev_obj, "realized", &error_abort)) {
>>> +            prop_name = g_strdup_printf("pflash%d", i);
>>> +            object_property_del(OBJECT(pcms), prop_name, &error_abort);
>>> +            g_free(prop_name);
>>> +            /*
>>> +             * FIXME delete @dev_obj.  Straight object_unref() is
>>> +             * wrong, since it leaves dangling references in the
>>> +             * parent bus behind.  object_unparent() doesn't work,
>>> +             * either: since @dev_obj hasn't been realized,
>>> +             * dev_obj->parent is null, and object_unparent() does
>>> +             * nothing.
>>> +             */
>>> +            pcms->flash[i] = NULL;
>>> +        }
>>> +    }
>>> +}
>>
>> I totally can't recommend a way to resolve this FIXME, alas.
> 
> I'm hoping for Paolo to don his shining armor and rescue me ;)
> 
>>>  
>>>  /* We don't have a theoretically justifiable exact lower bound on the base
>>>   * address of any flash mapping. In practice, the IO-APIC MMIO range is
>>> @@ -84,88 +135,78 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
>>>   * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB in
>>>   * size.
>>>   */
>>> -#define FLASH_MAP_BASE_MIN ((hwaddr)(4 * GiB - 8 * MiB))
>>> +#define FLASH_SIZE_LIMIT (8 * MiB)
>>>  
>>> -/* This function maps flash drives from 4G downward, in order of their unit
>>> - * numbers. The mapping starts at unit#0, with unit number increments of 1, and
>>> - * stops before the first missing flash drive, or before
>>> - * unit#FLASH_MAP_UNIT_MAX, whichever is reached first.
>>> +/*
>>> + * Map the pcms->flash[] from 4GiB downward, and realize.
>>> + * Map them in descending order, i.e. pcms->flash[0] at the top,
>>> + * without gaps.
>>> + * Stop at the first pcms->flash[0] lacking a block backend.
>>> + * Set each flash's size from its block backend.  Fatal error if the
>>> + * size isn't a non-zero multiples of 4KiB, or the total size exceeds
>>> + * FLASH_SIZE_LIMIT.
>>>   *
>>> - * Addressing within one flash drive is of course not reversed.
>>> - *
>>> - * An error message is printed and the process exits if:
>>> - * - the size of the backing file for a flash drive is non-positive, or not a
>>> - *   multiple of the required sector size, or
>>> - * - the current mapping's base address would fall below FLASH_MAP_BASE_MIN.
>>> - *
>>> - * The drive with unit#0 (if available) is mapped at the highest address, and
>>> - * it is passed to pc_isa_bios_init(). Merging several drives for isa-bios is
>>> + * If pcms->flash[0] has a block backend, its memory is passed to
>>> + * pc_isa_bios_init().  Merging several flash devices for isa-bios is
>>>   * not supported.
>>>   */
>>> -static void pc_system_flash_init(MemoryRegion *rom_memory)
>>> +static void pc_system_flash_map(PCMachineState *pcms,
>>> +                                MemoryRegion *rom_memory)
>>>  {
>>> -    int unit;
>>> -    DriveInfo *pflash_drv;
>>> +    hwaddr total_size = 0;
>>> +    int i;
>>>      BlockBackend *blk;
>>>      int64_t size;
>>> -    char *fatal_errmsg = NULL;
>>> -    hwaddr phys_addr = 0x100000000ULL;
>>>      uint32_t sector_size = 4096;
>>
>> (1) Rather than duplicate this constant here, can we get it inside the
>> loop, via the "sector-length" property? We set the property in
>> pc_pflash_create() (identically for both chips, but that's not a problem
>> I think).
> 
> We can.  It's slightly bothersome, since PFlashCFI01 is incomplete here.
> 
> Simpler: #define FLASH_SECTOR_SIZE 4096, and use it in both places.  Not
> quite as clean, because while the property value cannot change now, we
> can't completely exclude the possibility for the future.

I agree, a macro works too.

Thanks,
Laszlo
