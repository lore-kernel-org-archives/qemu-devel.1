Received: from eggs.gnu.org ([209.51.188.92]:39650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gorjM-0006EX-AZ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:24:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gorjL-0005B5-4A
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:24:48 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gorjK-00059x-Fd
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:24:47 -0500
Received: by mail-oi1-x243.google.com with SMTP id m6so19462124oig.11
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 07:24:44 -0800 (PST)
MIME-Version: 1.0
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<871s4uobf0.fsf@dusky.pond.sub.org>
In-Reply-To: <871s4uobf0.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Jan 2019 15:24:31 +0000
Message-ID: <CAFEAcA_t2707yp5cz+rbMVE3nhLk288iFgK=vUgzFyCw79uX5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, =?UTF-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On Wed, 30 Jan 2019 at 07:24, Markus Armbruster <armbru@redhat.com> wrote:
>
> Let me reply to the "why is the cfi.pflash01 device so weird" part
> first, because that's relatively quick, and because it could easily
> distract us from the more important "how do we want to configure OVMF"
> part.  I'll reply to that part later.
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Fri, 25 Jan 2019 at 15:11, Markus Armbruster <armbru@redhat.com> wrote:
> [...]
> >> To solve (2), we first have to understand the magic.  Device
> >> cfi.pflash01 has the following properties:
> >>
> >>     num-blocks                  Size of the device in blocks
> >>     sector-length               Size of a block
> >>                                 (admire the choice of names)
> >>     width                       Bank width
> >>     big-endian                  Endianess (d'oh)
> >>     id0, id1, id2, id3          Some kind of device ID, guest-visible,
> >>                                 default to zero, few boards change it
> >
> > Note that most of this is stuff that the hardware has.
> > A lot of boards set these to garbage values which happened
> > to be what the very old implementation of pflash hardcoded,
> > because most guests don't care. This is strictly speaking
> > wrong and they should use whatever the hardware really has,
> > but most of these cases are for old not-very-maintained dev
> > boards where probably nobody even has the relevant hardware
> > even if they cared enough to find out what its ID values are.
>
> Why are we emulating (badly) stuff nobody cares about enough to find out
> what exactly we should be emulating, the world wonders...

Usual reason -- we don't change stuff unless we're reasonably
sure it doesn't actually break guests that used to work.

> >>     name                        Memory region name
> >>                                 (why is this even configurable?)
> >
> > (a) for debug purposes, so a machine can create two flash
> > devices and give them names which make them easier to tell
> > apart in monitor "info mem" and similar command output
>
> That's what we have qdev IDs for.

The property setup here is basically maintaining compat
with the way the old pre-qdev implementation worked.
If there's a nicer way to do this that doesn't change
the memory region name and break migration compat, that's
great.

> > See above about "old not-very-maintained dev boards". A
> > board which does use this is one that's doing it for
> > back-compat because nobody's cared to fix and test.
>
> Boards that seem to care:
>
>     hw/arm/vexpress.c:    qdev_prop_set_uint8(dev, "device-width", 2);
>     hw/arm/virt.c:    qdev_prop_set_uint8(dev, "device-width", 2);

Yes. vexpress was the board where the broken pflash implementation
was first reported, so we fixed the pflash device and made
vexpress set things correctly. virt also gets a fixed device
because it postdates things being fixed.

> Boards that seem not to care:
>
>     hw/arm/collie.c:    pflash_cfi01_register(SA_CS0, NULL, "collie.fl1", 0x02000000,
>     hw/arm/collie.c:    pflash_cfi01_register(SA_CS1, NULL, "collie.fl2", 0x02000000,
>     hw/arm/gumstix.c:    if (!pflash_cfi01_register(0x00000000, NULL, "connext.rom", connex_rom,
>     hw/arm/gumstix.c:    if (!pflash_cfi01_register(0x00000000, NULL, "verdex.rom", verdex_rom,
>     hw/arm/mainstone.c:        if (!pflash_cfi01_register(mainstone_flash_base[i], NULL,
>     hw/arm/omap_sx1.c:        if (!pflash_cfi01_register(OMAP_CS0_BASE, NULL,
>     hw/arm/omap_sx1.c:        if (!pflash_cfi01_register(OMAP_CS1_BASE, NULL,
>     hw/arm/versatilepb.c:    if (!pflash_cfi01_register(VERSATILE_FLASH_ADDR, NULL, "versatile.flash",
>     hw/arm/vexpress.c:static pflash_t *ve_pflash_cfi01_register(hwaddr base, const char *name,
>     hw/arm/vexpress.c:    pflash0 = ve_pflash_cfi01_register(map[VE_NORFLASH0], "vexpress.flash0",
>     hw/arm/vexpress.c:    if (!ve_pflash_cfi01_register(map[VE_NORFLASH1], "vexpress.flash1",

...vexpress can't be both fixed and not...

>     hw/arm/z2.c:    if (!pflash_cfi01_register(Z2_FLASH_BASE,
>     hw/i386/pc_sysfw.c:        /* pflash_cfi01_register() creates a deep copy of the name */
>     hw/i386/pc_sysfw.c:        system_flash = pflash_cfi01_register(phys_addr, NULL /* qdev */, name,
>     hw/lm32/milkymist.c:    pflash_cfi01_register(flash_base, NULL, "milkymist.flash", flash_size,
>     hw/microblaze/petalogix_ml605_mmu.c:    pflash_cfi01_register(FLASH_BASEADDR,
>     hw/microblaze/petalogix_s3adsp1800_mmu.c:    pflash_cfi01_register(FLASH_BASEADDR,
>     hw/mips/mips_malta.c:    fl = pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
>     hw/mips/mips_r4k.c:        if (!pflash_cfi01_register(0x1fc00000, NULL, "mips_r4k.bios", mips_rom,
>     hw/ppc/sam460ex.c:    if (!pflash_cfi01_register(base, NULL, "sam460ex.flash", bios_size,
>     hw/ppc/virtex_ml507.c:    pflash_cfi01_register(PFLASH_BASEADDR, NULL, "virtex.flash", FLASH_SIZE,
>
> At least PC can't be characterized as "not-very-maintaned dev board".

Well, nobody who does anything with x86 has cared enough to
make the pflash implementation actually correct. The
weird "behave like a buggy implementation" default is there
pretty much exactly because x86 uses it and I didn't
want to change the x86 behaviour.

thanks
-- PMM
