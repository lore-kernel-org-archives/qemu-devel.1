Received: from eggs.gnu.org ([209.51.188.92]:32804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1RHt-0000FJ-U6
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 02:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1RHl-0004tH-8Y
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 02:48:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1RHi-0004og-LA
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 02:48:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id q187so4905182wme.5
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 23:48:10 -0800 (PST)
References: <20190226193408.23862-1-armbru@redhat.com>
	<20190226193408.23862-7-armbru@redhat.com>
	<a6d6c528-69c8-5e09-02a6-4c7cef0c8891@redhat.com>
	<alpine.BSF.2.21.9999.1903052325280.40521@zero.eik.bme.hu>
	<87d0n41ond.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <85174ec4-f920-5135-b650-fc953e33a5aa@redhat.com>
Date: Wed, 6 Mar 2019 08:47:59 +0100
MIME-Version: 1.0
In-Reply-To: <87d0n41ond.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 06/11] sam460ex: Don't size
 flash memory to match backing image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, alex.bennee@linaro.org, qemu-block@nongnu.org, qemu-devel@nongnu.org

On 3/6/19 7:51 AM, Markus Armbruster wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
>> On Tue, 5 Mar 2019, Philippe Mathieu-Daudé wrote:
>>> On 2/26/19 8:34 PM, Markus Armbruster wrote:
>>>> Machine "sam460ex" maps its flash memory at address 0xFFF00000.  When
>>>> no image is supplied, its size is 1MiB (0x100000), and 512KiB of ROM
>>>> get mapped on top of its second half.  Else, it's the size of the
>>>> image rounded up to the next multiple of 64KiB.
>>>>
>>>> The rounding is actually useless: pflash_cfi01_realize() fails with
>>>> "failed to read the initial flash content" unless it's a no-op.
>>>>
>>>> I have no idea what happens when the pflash's size exceeds 1MiB.
>>>> Useful outcomes seem unlikely.
>>>
>>> With PFlashCFI02, it depends of the @nb_mappings parameter, which tries
>>> to emulates how the bus connects the pflash (which address lines are
>>> connected).
>>>
>>> PFlashCFI01 doesn't support the feature to remap its content in aliases
>>> (which might look unfortunate, because boards end doing it, in different
>>> ways).
>>
>> I think this is all theoretical at the moment since we don't actually
>> model the flash functions of this board (at least I haven't tested
>> that at all) and unless it somehow uses it in ways I'm unaware of I
>> think currently only the ROM is used.
>>
>>> For this device we have:
>>>
>>>  (qemu) info mtree
>>>  0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>>  00000004fff00000-00000004ffffffff (prio 0, romd): sam460ex.flash
>>>
>>> I'm not familiar with this arch/machine, let's assume the system bus is
>>> 32bit, and the flash has a 8bit word (we have 8 data lines connected to
>>> the pflash).
>>
>> Maybe this can help:
>> https://datasheet.octopart.com/PPC460EX-NUB800T-AMCC-datasheet-11553412.pdf
>> http://www.acube-systems.biz/index.php?page=hardware&pid=5
>>
>> Unfortunately I don't have any more detailed docs where it's explained
>> more but according to the above and in my limited understanding the
>> SoC could handle larger flash chips but this board has 512 MB. We have
>> not changed it now because I'm not sure if it would break anything and
>> I don't have time to test it so Marcus just added a comment to remind
>> about this and we're happy with that for now and could come back to it
>> separately.
> 
> And that's good enough for what I'm trying to do in this series, namely
> getting rid of unwarranted magic around pflash devices.
> 
>>> The 'no image' is 1MiB.
>>>
>>> 1 MiB = 8 Mbit
>>> 8 Mbit / 32 = 2 ^ 18
>>> We need 18 address lines to reach the whole flash.
>>>
>>> What happens if we connect a 2MiB flash? We need 19 addr lines.
>>>
>>> If we only have 18 lines to connect our flash, we can hardwire our last
>>> line as 0 or 1.
>>>
>>> - line #17 hardwired as 0:
>>> Only the bottom part of the flash is accessible (range 0x000000..0x0fffff).
>>> CPU reading 0x4fff00000 read flash offset 0x0.
>>> Using CFI it is still a announced as 2MiB.
>>>
>>> - line #17 hardwired as 1:
>>> Only the top part of the flash is accessible (range 0x100000..0x1fffff).
>>> Can we trigger any operation from the internal state machine (writing to
>>> address 0x555, named @unlock_addr0 in QEMU) since all access are
>>> hardwardwired on top of 1MiB...?
>>> Yes we can, because the pflash only uses 11 bits for it's I/O, so all
>>> writes are masked and hit the I/O internal unit.
>>> CPU reading 0x4fff00000 read flash offset 0x100000
>>>
>>> If we do have 19 lines dedicated to our chip and connect a 512KiB flash,
>>> we 'll use 17 lines and let 2 lines unused.
>>> Regardless the values on the lines #17 and #18, the flash will answer to
>>> the value on lines #0..#16. This might be called MMIO aliasing, and is
>>> what setup the @nb_mappings argument.
>>> This example with nb_mappings=4 would mean:
>>> "I have a 2MiB I/O space and a 512KiB flash, map it and create 3 aliases".
> 
> Physical hardware does address lines.  Hardwiring address lines leaves
> part of the hardware unaddressable.  Not decoding address lines gets the
> same stuff mapped multiple times in the address space.  Address lines is
> also what makes sizes powers of two.

I'm amazed about how you sumarized... Thanks!

> QEMU device models are software.  Emulating address lines faithfully
> there takes extra effort.  A hack job that simply maps whatever size
> wherever is easier.  It's why we could do 7919 sectors of 5323 bytes for
> a size of 42152837 bytes, and map it at address 0x12345678.
> 
> Of course, none of our boards is that nuts.  But this one exudes a bit
> of a nutty flavor: with "-drive if=pflash,format=raw,file=1G.img", it
> happily maps 1G at address 0x4fff00000.  info mtree:
> 
>     address-space: memory
>       0000000000000000-ffffffffffffffff (prio 0, i/o): system
>         0000000000000000-000000001fffffff (prio 0, i/o): sdram-containers
>           0000000000000000-000000001fffffff (prio 0, i/o): alias ppc4xx.sdram0 @ppc4xx.sdram 0000000000000000-000000001fffffff
>         0000000400000000-000000040003ffff (prio 0, ram): ppc440.l2cache_ram
>         00000004bffd0000-00000004bffd00ff (prio 0, i/o): ohci
>         00000004bffd0400-00000004bffd13ff (prio 0, i/o): ehci
>           00000004bffd0400-00000004bffd040f (prio 0, i/o): capabilities
>           00000004bffd0410-00000004bffd0453 (prio 0, i/o): operational
>           00000004bffd0454-00000004bffd046b (prio 0, i/o): ports
>         00000004ef600300-00000004ef600307 (prio 0, i/o): serial
>         00000004ef600700-00000004ef600711 (prio 0, i/o): ppc4xx-i2c
>         00000004ef600800-00000004ef600811 (prio 0, i/o): ppc4xx-i2c
> --->    00000004fff00000-000000053fefffff (prio 0, romd): sam460ex.flash
>         0000000c08000000-0000000c0800ffff (prio 0, i/o): alias isa_mmio @io 0000000000000000-000000000000ffff
>         0000000c0ec00000-0000000c0ec800fe (prio 0, i/o): pci-container
>           0000000c0ec00000-0000000c0ec00003 (prio 0, i/o): pci-conf-idx
>           0000000c0ec00004-0000000c0ec00007 (prio 0, i/o): pci-conf-data
>           0000000c0ec80000-0000000c0ec800fe (prio 0, i/o): pci.reg
> 
> Looks like there's plenty of space before we crash into pci-container.
> Still, boards emulating real hardware should not take such liberties.

Good catch, this is a Chip Select slot and is limited to the max
addressing the bus allow to this CS.

>>> Back to the architecture, what matters here is that the CPU reset vector
>>> is always user-controlled (mapped on a flash device).
>>> This arch has reset_vector @0x4fffffffc.
>>> You could also map a 256KiB pflash at 0x4fffc0000, as long as the reset
>>> vector is covered. If you map it at 0x4fff00000 or 0x4fff80000 it won't!
>>>
>>> This explanation is not arch-specific (adapting the reset vector to each
>>> arch).
>>>
>>>>
>>>> I guess memory at the end of the address space remains unmapped when
>>>> it's smaller than 1MiB.  Again, useful outcomes seem unlikely.
>>>
>>> If you map a 512KiB flash at 0x4fff00000, then the reset vector is not
>>> covered. At 0x4fff80000 it is.
>>
>> Yes, I said the same before but this would be a separate patch and
>> would need more testing so it wasn't included in this series. Since it
>> works as it is now this can wait until later when it can be cleaned
>> up. If we want to model the actual board we don't have to consider
>> different flash sizes than the 512 MB that the board has so everything
>> else is probably "overthinking" it.
> 
> Isn't modelling the actual board why we have the virtual board in the
> first place?  But I digress...
> 
> [...]
>>>> The physical hardware appears to have 512KiB of flash memory:
>>>> https://eu.mouser.com/datasheet/2/268/atmel_AT49BV040B-1180330.pdf
>>>>
>>>> For now, just set the flash memory size to 1MiB regardless of image
>>>> size, and document the mess.
>>>>
>>>> Cc: BALATON Zoltan <balaton@eik.bme.hu>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>  hw/ppc/sam460ex.c | 41 ++++++++++++++++++++++++++---------------
>>>>  1 file changed, 26 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>>>> index 75250d49e4..0c919529f8 100644
>>>> --- a/hw/ppc/sam460ex.c
>>>> +++ b/hw/ppc/sam460ex.c
>>>> @@ -91,32 +91,43 @@ struct boot_info {
>>>>
>>>>  static int sam460ex_load_uboot(void)
>>>>  {
>>>> +    /*
>>>> +     * This first creates 1MiB of flash memory mapped at the end of
>>>> +     * the 32-bit address space (0xFFF00000..0xFFFFFFFF).
>>>> +     *
>>>> +     * If_PFLASH unit 0 is defined, the flash memory is initialized
>>>> +     * from that block backend.
>>>> +     *
>>>> +     * Else, it's initialized to zero.  And then 512KiB of ROM get
>>>> +     * mapped on top of its second half (0xFFF80000..0xFFFFFFFF),
>>>> +     * initialized from u-boot-sam460-20100605.bin.
>>>
>>> I think the correct check is:
>>>
>>>    if (! something_mapped_at(0x4fffffffc)) {
>>>        rom_map("u-boot-sam460.bin",
>>>                0x500000000 - sizeof("u-boot-sam460.bin"));
>>>    }
>>>
>>> Maybe:
>>>
>>>    if (!memory_region_present(get_system_memory(), 0x4fffffffc)) {
>>>        /* Current uboot ROM is 512KiB */
>>>        /* TODO check [0x500000000 - 512KiB,0x500000000 - 1] unmapped */
>>>        rom_add_file_fixed(UBOOT_FILENAME,
>>>                           UBOOT_LOAD_BASE | ((hwaddr)FLASH_BASE_H << 32),
>>>                           -1);
>>>    }
> 
> I think this should be addressed in separate patches.  This one merely
> kills bad magic around pflash, such as inheriting the flash's size from
> the block backend without sanity checking.

"... let him speak now or forever hold his peace."
