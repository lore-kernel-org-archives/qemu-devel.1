Received: from eggs.gnu.org ([209.51.188.92]:45607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gokOY-0004zO-ES
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gokOX-0007CB-Cq
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:50 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
Date: Wed, 30 Jan 2019 08:24:35 +0100
In-Reply-To: <CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	(Peter Maydell's message of "Mon, 28 Jan 2019 10:39:09 +0000")
Message-ID: <871s4uobf0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

Let me reply to the "why is the cfi.pflash01 device so weird" part
first, because that's relatively quick, and because it could easily
distract us from the more important "how do we want to configure OVMF"
part.  I'll reply to that part later.

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 25 Jan 2019 at 15:11, Markus Armbruster <armbru@redhat.com> wrote:
[...]
>> To solve (2), we first have to understand the magic.  Device
>> cfi.pflash01 has the following properties:
>>
>>     num-blocks                  Size of the device in blocks
>>     sector-length               Size of a block
>>                                 (admire the choice of names)
>>     width                       Bank width
>>     big-endian                  Endianess (d'oh)
>>     id0, id1, id2, id3          Some kind of device ID, guest-visible,
>>                                 default to zero, few boards change it
>
> Note that most of this is stuff that the hardware has.
> A lot of boards set these to garbage values which happened
> to be what the very old implementation of pflash hardcoded,
> because most guests don't care. This is strictly speaking
> wrong and they should use whatever the hardware really has,
> but most of these cases are for old not-very-maintained dev
> boards where probably nobody even has the relevant hardware
> even if they cared enough to find out what its ID values are.

Why are we emulating (badly) stuff nobody cares about enough to find out
what exactly we should be emulating, the world wonders...

>>     name                        Memory region name
>>                                 (why is this even configurable?)
>
> (a) for debug purposes, so a machine can create two flash
> devices and give them names which make them easier to tell
> apart in monitor "info mem" and similar command output

That's what we have qdev IDs for.

> (b) more  importantly, the memory region name is used as
> the migration vmstate ram name, so if you change it you
> break migration compat.

Sounds about as useful as a --break-me-but-subtly option.

>>     phys-addr                   Physical base address
>>                                 (this is the new device property
>>                                 mentioned above)
>>     secure                      For restricting access to firmware,
>>                                 default off
>>     device-width                you don't want to know,
>>                                 there is a default, but it's documented
>>                                 as "bad, do not use", yet pretty much
>>                                 all boards use it
>
> See above about "old not-very-maintained dev boards". A
> board which does use this is one that's doing it for
> back-compat because nobody's cared to fix and test.

Boards that seem to care:

    hw/arm/vexpress.c:    qdev_prop_set_uint8(dev, "device-width", 2);
    hw/arm/virt.c:    qdev_prop_set_uint8(dev, "device-width", 2);

Boards that seem not to care:

    hw/arm/collie.c:    pflash_cfi01_register(SA_CS0, NULL, "collie.fl1", 0x02000000,
    hw/arm/collie.c:    pflash_cfi01_register(SA_CS1, NULL, "collie.fl2", 0x02000000,
    hw/arm/gumstix.c:    if (!pflash_cfi01_register(0x00000000, NULL, "connext.rom", connex_rom,
    hw/arm/gumstix.c:    if (!pflash_cfi01_register(0x00000000, NULL, "verdex.rom", verdex_rom,
    hw/arm/mainstone.c:        if (!pflash_cfi01_register(mainstone_flash_base[i], NULL,
    hw/arm/omap_sx1.c:        if (!pflash_cfi01_register(OMAP_CS0_BASE, NULL,
    hw/arm/omap_sx1.c:        if (!pflash_cfi01_register(OMAP_CS1_BASE, NULL,
    hw/arm/versatilepb.c:    if (!pflash_cfi01_register(VERSATILE_FLASH_ADDR, NULL, "versatile.flash",
    hw/arm/vexpress.c:static pflash_t *ve_pflash_cfi01_register(hwaddr base, const char *name,
    hw/arm/vexpress.c:    pflash0 = ve_pflash_cfi01_register(map[VE_NORFLASH0], "vexpress.flash0",
    hw/arm/vexpress.c:    if (!ve_pflash_cfi01_register(map[VE_NORFLASH1], "vexpress.flash1",
    hw/arm/z2.c:    if (!pflash_cfi01_register(Z2_FLASH_BASE,
    hw/i386/pc_sysfw.c:        /* pflash_cfi01_register() creates a deep copy of the name */
    hw/i386/pc_sysfw.c:        system_flash = pflash_cfi01_register(phys_addr, NULL /* qdev */, name,
    hw/lm32/milkymist.c:    pflash_cfi01_register(flash_base, NULL, "milkymist.flash", flash_size,
    hw/microblaze/petalogix_ml605_mmu.c:    pflash_cfi01_register(FLASH_BASEADDR,
    hw/microblaze/petalogix_s3adsp1800_mmu.c:    pflash_cfi01_register(FLASH_BASEADDR,
    hw/mips/mips_malta.c:    fl = pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
    hw/mips/mips_r4k.c:        if (!pflash_cfi01_register(0x1fc00000, NULL, "mips_r4k.bios", mips_rom,
    hw/ppc/sam460ex.c:    if (!pflash_cfi01_register(base, NULL, "sam460ex.flash", bios_size,
    hw/ppc/virtex_ml507.c:    pflash_cfi01_register(PFLASH_BASEADDR, NULL, "virtex.flash", FLASH_SIZE,

At least PC can't be characterized as "not-very-maintaned dev board".

>>     max-device-width            defaults to device-width
>>                                 not actually set anywhere
>>     old-multiple-chip-handling  back-compat gunk for
>>                                 machine types 2.8 and older
>>
>> The magic board code in hw/i386/pc_sysfw.c configures as follows:
>>
>>     num-blocks                  computed from backend size
>>     sector-length               4096
>>     width                       1
>>     big-endian                  0
>>     id0, id1, id2, id3          all 0
>>     name                        system.pflash<U>, where U is -drive's
>>                                 unit number
>>     phys-addr                   computed so
>>                                 unit 0 ends right below 0x100000000,
>>                                 unit n+1 ends at right below unit n
>>
>> "secure", "device-width", "max-device-width",
>> "old-multiple-chip-handling" are left at the default.
>>
>> One additional bit of magic is actually in libvirt: it configures
>> "secure" by flipping its default with
>> -global driver=cfi.pflash01,property=secure,value=on.
[...]
