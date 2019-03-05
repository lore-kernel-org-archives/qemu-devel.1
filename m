Received: from eggs.gnu.org ([209.51.188.92]:36636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1FUY-00014M-7l
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:12:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1FUR-0004EF-N3
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:12:37 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:42514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1FUM-00047R-C9
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:12:31 -0500
Received: by mail-wr1-f41.google.com with SMTP id r5so10713400wrg.9
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 11:12:29 -0800 (PST)
References: <20190226193408.23862-1-armbru@redhat.com>
	<20190226193408.23862-7-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a6d6c528-69c8-5e09-02a6-4c7cef0c8891@redhat.com>
Date: Tue, 5 Mar 2019 20:12:26 +0100
MIME-Version: 1.0
In-Reply-To: <20190226193408.23862-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/11] sam460ex: Don't size flash memory
 to match backing image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, alex.bennee@linaro.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org, lersek@redhat.com

Hi Markus, Zoltan, Alex.

On 2/26/19 8:34 PM, Markus Armbruster wrote:
> Machine "sam460ex" maps its flash memory at address 0xFFF00000.  When
> no image is supplied, its size is 1MiB (0x100000), and 512KiB of ROM
> get mapped on top of its second half.  Else, it's the size of the
> image rounded up to the next multiple of 64KiB.
> 
> The rounding is actually useless: pflash_cfi01_realize() fails with
> "failed to read the initial flash content" unless it's a no-op.
> 
> I have no idea what happens when the pflash's size exceeds 1MiB.
> Useful outcomes seem unlikely.

With PFlashCFI02, it depends of the @nb_mappings parameter, which tries
to emulates how the bus connects the pflash (which address lines are
connected).

PFlashCFI01 doesn't support the feature to remap its content in aliases
(which might look unfortunate, because boards end doing it, in different
ways).

For this device we have:

  (qemu) info mtree
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
  00000004fff00000-00000004ffffffff (prio 0, romd): sam460ex.flash

I'm not familiar with this arch/machine, let's assume the system bus is
32bit, and the flash has a 8bit word (we have 8 data lines connected to
the pflash).
The 'no image' is 1MiB.

1 MiB = 8 Mbit
8 Mbit / 32 = 2 ^ 18
We need 18 address lines to reach the whole flash.

What happens if we connect a 2MiB flash? We need 19 addr lines.

If we only have 18 lines to connect our flash, we can hardwire our last
line as 0 or 1.

- line #17 hardwired as 0:
Only the bottom part of the flash is accessible (range 0x000000..0x0fffff).
CPU reading 0x4fff00000 read flash offset 0x0.
Using CFI it is still a announced as 2MiB.

- line #17 hardwired as 1:
Only the top part of the flash is accessible (range 0x100000..0x1fffff).
Can we trigger any operation from the internal state machine (writing to
address 0x555, named @unlock_addr0 in QEMU) since all access are
hardwardwired on top of 1MiB...?
Yes we can, because the pflash only uses 11 bits for it's I/O, so all
writes are masked and hit the I/O internal unit.
CPU reading 0x4fff00000 read flash offset 0x100000

If we do have 19 lines dedicated to our chip and connect a 512KiB flash,
we 'll use 17 lines and let 2 lines unused.
Regardless the values on the lines #17 and #18, the flash will answer to
the value on lines #0..#16. This might be called MMIO aliasing, and is
what setup the @nb_mappings argument.
This example with nb_mappings=4 would mean:
"I have a 2MiB I/O space and a 512KiB flash, map it and create 3 aliases".

Back to the architecture, what matters here is that the CPU reset vector
is always user-controlled (mapped on a flash device).
This arch has reset_vector @0x4fffffffc.
You could also map a 256KiB pflash at 0x4fffc0000, as long as the reset
vector is covered. If you map it at 0x4fff00000 or 0x4fff80000 it won't!

This explanation is not arch-specific (adapting the reset vector to each
arch).

> 
> I guess memory at the end of the address space remains unmapped when
> it's smaller than 1MiB.  Again, useful outcomes seem unlikely.

If you map a 512KiB flash at 0x4fff00000, then the reset vector is not
covered. At 0x4fff80000 it is.

> The physical hardware appears to have 512KiB of flash memory:
> https://eu.mouser.com/datasheet/2/268/atmel_AT49BV040B-1180330.pdf
> 
> For now, just set the flash memory size to 1MiB regardless of image
> size, and document the mess.
> 
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/ppc/sam460ex.c | 41 ++++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 75250d49e4..0c919529f8 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -91,32 +91,43 @@ struct boot_info {
>  
>  static int sam460ex_load_uboot(void)
>  {
> +    /*
> +     * This first creates 1MiB of flash memory mapped at the end of
> +     * the 32-bit address space (0xFFF00000..0xFFFFFFFF).
> +     *
> +     * If_PFLASH unit 0 is defined, the flash memory is initialized
> +     * from that block backend.
> +     *
> +     * Else, it's initialized to zero.  And then 512KiB of ROM get
> +     * mapped on top of its second half (0xFFF80000..0xFFFFFFFF),
> +     * initialized from u-boot-sam460-20100605.bin.

I think the correct check is:

    if (! something_mapped_at(0x4fffffffc)) {
        rom_map("u-boot-sam460.bin",
                0x500000000 - sizeof("u-boot-sam460.bin"));
    }

Maybe:

    if (!memory_region_present(get_system_memory(), 0x4fffffffc)) {
        /* Current uboot ROM is 512KiB */
        /* TODO check [0x500000000 - 512KiB,0x500000000 - 1] unmapped */
        rom_add_file_fixed(UBOOT_FILENAME,
                           UBOOT_LOAD_BASE | ((hwaddr)FLASH_BASE_H << 32),
                           -1);
    }

Regards,

Phil.

> +     *
> +     * This doesn't smell right.
> +     *
> +     * The physical hardware appears to have 512KiB flash memory.
> +     *
> +     * TODO Figure out what we really need here, and clean this up.
> +     */
> +
>      DriveInfo *dinfo;
> -    BlockBackend *blk = NULL;
> -    hwaddr base = FLASH_BASE | ((hwaddr)FLASH_BASE_H << 32);
> -    long bios_size = FLASH_SIZE;
> -    int fl_sectors;
>  
>      dinfo = drive_get(IF_PFLASH, 0, 0);
> -    if (dinfo) {
> -        blk = blk_by_legacy_dinfo(dinfo);
> -        bios_size = blk_getlength(blk);
> -    }
> -    fl_sectors = (bios_size + 65535) >> 16;
> -
> -    if (!pflash_cfi01_register(base, NULL, "sam460ex.flash", bios_size,
> -                               blk, 64 * KiB, fl_sectors,
> +    if (!pflash_cfi01_register(FLASH_BASE | ((hwaddr)FLASH_BASE_H << 32),
> +                               NULL, "sam460ex.flash", FLASH_SIZE,
> +                               dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> +                               64 * KiB, FLASH_SIZE / (64 * KiB),
>                                 1, 0x89, 0x18, 0x0000, 0x0, 1)) {
>          error_report("Error registering flash memory");
>          /* XXX: return an error instead? */
>          exit(1);
>      }
>  
> -    if (!blk) {
> +    if (!dinfo) {
>          /*error_report("No flash image given with the 'pflash' parameter,"
>                  " using default u-boot image");*/
> -        base = UBOOT_LOAD_BASE | ((hwaddr)FLASH_BASE_H << 32);
> -        rom_add_file_fixed(UBOOT_FILENAME, base, -1);
> +        rom_add_file_fixed(UBOOT_FILENAME,
> +                           UBOOT_LOAD_BASE | ((hwaddr)FLASH_BASE_H << 32),
> +                           -1);
>      }
>  
>      return 0;
> 
