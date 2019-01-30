Received: from eggs.gnu.org ([209.51.188.92]:34388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gophc-0007UO-C6
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:14:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gophb-00081Z-ED
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:14:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gophb-00080F-5S
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:14:51 -0500
References: <20190129221928.11522-1-huth@tuxfamily.org>
	<4fb7e672-2572-15e4-598e-5ea6378006c2@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fd280788-5f28-e2cf-85f6-595a6142062b@redhat.com>
Date: Wed, 30 Jan 2019 14:14:43 +0100
MIME-Version: 1.0
In-Reply-To: <4fb7e672-2572-15e4-598e-5ea6378006c2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/m68k/mcf5208: Support loading of bios
 images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

On 2019-01-30 12:15, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
> On 1/29/19 11:19 PM, Thomas Huth wrote:
>> The MCF5208EVB supports 2 MiB of flash at address 0. Add support
>> for this memory region and some code to load the file that can
>> be specified with the "-bios" command line option.
>> This can be used for example to load U-Boot images for the
>> MCF5208EVB (we still lack some features in the CPU emulation for
>> this firmware, though, so it can not be run successfully yet).
>>
>> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
>> ---
>>  hw/m68k/mcf5208.c | 29 ++++++++++++++++++++++++++++-
>>  1 file changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
>> index 0f2245dd81..021194498d 100644
>> --- a/hw/m68k/mcf5208.c
>> +++ b/hw/m68k/mcf5208.c
>> @@ -27,6 +27,8 @@
>> =20
>>  #define SYS_FREQ 166666666
>> =20
>> +#define ROM_SIZE 0x200000
>> +
>>  #define PCSR_EN         0x0001
>>  #define PCSR_RLD        0x0002
>>  #define PCSR_PIF        0x0004
>> @@ -227,6 +229,7 @@ static void mcf5208evb_init(MachineState *machine)
>>      hwaddr entry;
>>      qemu_irq *pic;
>>      MemoryRegion *address_space_mem =3D get_system_memory();
>> +    MemoryRegion *rom =3D g_new(MemoryRegion, 1);
>>      MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>>      MemoryRegion *sram =3D g_new(MemoryRegion, 1);
>> =20
>> @@ -237,6 +240,10 @@ static void mcf5208evb_init(MachineState *machine=
)
>>      env->vbr =3D 0;
>>      /* TODO: Configure BARs.  */
>> =20
>> +    /* ROM at 0x00000000 */
>> +    memory_region_init_rom(rom, NULL, "mcf5208.rom", ROM_SIZE, &error=
_fatal);
>> +    memory_region_add_subregion(address_space_mem, 0x0, rom);
>=20
> I'd use 0x00000000 here as in the comment.
>=20
>> +
>>      /* DRAM at 0x40000000 */
>>      memory_region_allocate_system_memory(ram, NULL, "mcf5208.ram", ra=
m_size);
>>      memory_region_add_subregion(address_space_mem, 0x40000000, ram);
>> @@ -285,9 +292,29 @@ static void mcf5208evb_init(MachineState *machine=
)
>>      /*  0xfc0a4000 GPIO.  */
>>      /* 0xfc0a8000 SDRAM controller.  */
>> =20
>> +    /* Load firmware */
>> +    if (bios_name) {
>> +        char *fn;
>> +        uint8_t *ptr;
>> +
>> +        fn =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>> +        if (!fn) {
>> +            error_report("Could not find ROM image '%s'", bios_name);
>> +            exit(1);
>> +        }
>> +        if (load_image_targphys(fn, 0x0, ROM_SIZE) < 8) {
>> +            error_report("Could not load ROM image '%s'", bios_name);
>> +            exit(1);
>> +        }
>> +        g_free(fn);
>=20
> Can you add a comment about the 3 next lines?
> As this doesn't seem m68k specific but firmware specific

It's m68k specific: At the very bottom of the address map, the first
4-byte value is always the initial stack, the next four bytes are always
the initial value for the program counter. But, ok, I can add a comment
here to make it clearer.

> shouldn't you
> magic check for the image loaded to be your particular firmware (if thi=
s
> is possible) or check $pc is within sane range?

We don't do this in any of our other boards, do we? At least I can not
remember any examples for such a check right now.

>> +        ptr =3D rom_ptr(0x4, 4);
>> +        assert(ptr !=3D NULL);
>> +        env->pc =3D ldl_p(ptr);
>> +    }
>> +
>>      /* Load kernel.  */
>>      if (!kernel_filename) {
>> -        if (qtest_enabled()) {
>> +        if (qtest_enabled() || bios_name) {
>>              return;
>>          }
>>          error_report("Kernel image must be specified");

 Thomas
