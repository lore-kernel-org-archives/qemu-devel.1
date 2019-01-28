Received: from eggs.gnu.org ([209.51.188.92]:50165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go4KH-00083i-Df
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:39:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go4KE-0005t8-RJ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:39:37 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:43459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1go4KE-0005nq-MW
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:39:34 -0500
Received: by mail-ot1-x32e.google.com with SMTP id a11so14162658otr.10
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 02:39:22 -0800 (PST)
MIME-Version: 1.0
References: <87y378n5iy.fsf@dusky.pond.sub.org>
In-Reply-To: <87y378n5iy.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 10:39:09 +0000
Message-ID: <CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, =?UTF-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, Qemu-block <qemu-block@nongnu.org>

On Fri, 25 Jan 2019 at 15:11, Markus Armbruster <armbru@redhat.com> wrote:
> (1) cfi.pflash01 isn't available with -device.
>
> (2) "Magic board code picks up the backend [created for -drive
>     if=pflash], creates a frontend (a cfi.pflash01 device), and maps it
>     into the guest's address space."  When we replace if=pflash by
>     if=none, we get to replicate that magic on top of -device.
>
> Issue (1) isn't too hard: we add the device to the dynamic sysbus device
> white-list, move a sysbus_mmio_map() from pflash_cfi01_realize() into
> pflash_cfi01_realize().  The latter requires a new device property to
> configure the base address.  I got a working prototype.  Since this
> makes the device model's name and properties ABI, review would be
> advisable.

Flash devices exist on the board at specific addresses, so they
should in general be created by the board model. Creating them
by the user on the command line is a mess because then the
user has to know the right base address. And then the board
code needs to do something for "if the user didn't create this
then we need to do it", because the flash device should exist
in the model whether the user cared about its contents or not.

Dynamic sysbus is something I'd rather we did less of, not more
of. It's there because it solves an annoying problem (people
want to do device passthrough of hardware that's not on a nice
pluggable probeable bus), but it's really awkward.

> To solve (2), we first have to understand the magic.  Device
> cfi.pflash01 has the following properties:
>
>     num-blocks                  Size of the device in blocks
>     sector-length               Size of a block
>                                 (admire the choice of names)
>     width                       Bank width
>     big-endian                  Endianess (d'oh)
>     id0, id1, id2, id3          Some kind of device ID, guest-visible,
>                                 default to zero, few boards change it

Note that most of this is stuff that the hardware has.
A lot of boards set these to garbage values which happened
to be what the very old implementation of pflash hardcoded,
because most guests don't care. This is strictly speaking
wrong and they should use whatever the hardware really has,
but most of these cases are for old not-very-maintained dev
boards where probably nobody even has the relevant hardware
even if they cared enough to find out what its ID values are.

>     name                        Memory region name
>                                 (why is this even configurable?)

(a) for debug purposes, so a machine can create two flash
devices and give them names which make them easier to tell
apart in monitor "info mem" and similar command output
(b) more  importantly, the memory region name is used as
the migration vmstate ram name, so if you change it you
break migration compat.

>     phys-addr                   Physical base address
>                                 (this is the new device property
>                                 mentioned above)
>     secure                      For restricting access to firmware,
>                                 default off
>     device-width                you don't want to know,
>                                 there is a default, but it's documented
>                                 as "bad, do not use", yet pretty much
>                                 all boards use it

See above about "old not-very-maintained dev boards". A
board which does use this is one that's doing it for
back-compat because nobody's cared to fix and test.

>     max-device-width            defaults to device-width
>                                 not actually set anywhere
>     old-multiple-chip-handling  back-compat gunk for
>                                 machine types 2.8 and older
>
> The magic board code in hw/i386/pc_sysfw.c configures as follows:
>
>     num-blocks                  computed from backend size
>     sector-length               4096
>     width                       1
>     big-endian                  0
>     id0, id1, id2, id3          all 0
>     name                        system.pflash<U>, where U is -drive's
>                                 unit number
>     phys-addr                   computed so
>                                 unit 0 ends right below 0x100000000,
>                                 unit n+1 ends at right below unit n
>
> "secure", "device-width", "max-device-width",
> "old-multiple-chip-handling" are left at the default.
>
> One additional bit of magic is actually in libvirt: it configures
> "secure" by flipping its default with
> -global driver=cfi.pflash01,property=secure,value=on.
>
> Now let's consider how to replicate this magic on top of device.
>
> Perhaps machine-type specific defaults could take care of sector-length,
> width, big-endian, id0, id1, id2, id3.  Leaves num-blocks, name, and
> phys-addr.

You could at least in theory have a machine with several
different flash devices of different make/ID. This is why
they're device properties. I think they're fine the way
they are, ie set by the code that creates the device.

thanks
-- PMM
