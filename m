Received: from eggs.gnu.org ([209.51.188.92]:44402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1go1xQ-0006O6-Hp
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:07:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1go1xO-0000ry-FJ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:07:52 -0500
References: <87y378n5iy.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <31953dd7-cd1c-94a7-6e2e-633ecd36d9af@redhat.com>
Date: Mon, 28 Jan 2019 08:58:00 +0100
MIME-Version: 1.0
In-Reply-To: <87y378n5iy.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libvir-list@redhat.com, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

(+Peter, keeping the context)

On 01/25/19 16:03, Markus Armbruster wrote:
> We configure OVMF firmware for PC machine types with -drive if=pflash.
> This is pretty much the last remaining use of -drive in libvirt we can't
> yet replace by -blockdev.  Such a replacement is desirable, because
> -blockdev + -device is more flexible than -drive if=pflash.  Also, once
> we don't need -drive with new QEMU anymore, the path for deleting all
> -drive code in libvirt some day is open.  As with all desirables, the
> benefit needs to exceed the cost.
> 
> I'm going to describe the status quo, how we got there (briefly and much
> simplified), then sketch how to replace -drive if=pflash.  I'm afraid
> this is fairly long; sorry.  Please correct misunderstandings.  Beware,
> my libvirt and OVMF fu is much weaker than my QEMU fu.
> 
> In the beginning, board code read the BIOS from a fixed file and mapped
> it into the guest's address space.  Life was simple.
> 
> On physical hardware, the BIOS can persist a bit of state across (cold)
> reboots by storing it in (non-volatile) CMOS RAM.  We didn't bother.
> Simple.
> 
> Fast forward several years, and The Law of OS Envy (every program wants
> to grow into a full-blown operating system) has asserted itself: PC
> Firmware has grown from an 8KiB ROM using a few bytes of volatile and
> non-volatile RAM into a multi-megabyte beast with much more complex
> storage needs.
> 
> On today's physical PC hardware, firmware is stored in flash memory.
> There's code, and there's persistent data.  For obvious reasons, the
> code should be write-protected except when doing an upgrade.  "Secure
> boot" additionally needs to restrict data writes to system management
> mode (SMM).
> 
> Here's our first iteration of OVMF support, at QEMU level:
> 
>     -drive if=pflash,format=raw,file=/where/ever/OVMF.fd
> 
> Generic code creates a block backend for it.  Magic board code picks up
> the backend, creates a frontend (a cfi.pflash01 device), and maps it
> into the guest's address space.
> 
> At libvirt level:
> 
>   <loader type="pflash">/where/ever/OVMF.fd</loader>
> 
> Problem: while the flash device model provides read-only capability,
> it's all-or-nothing.  You can't tell it to write-protect just the part
> holding code.  The examples above don't write-protect anything.
> /where/ever/OVMF.fd better be writable exclusively.
> 
> The flash device model could be enhanced, but we went down a different
> path: we split the single OVMF image OVMF.fd ("unified build") into a
> code image OVMF_CODE.fd and a data image OVMF_VARS.fd ("split build").
> At QEMU level:
> 
>     -drive if=pflash,format=raw,readonly,file=/usr/share/OVMF/OVMF_CODE.fd
>     -drive if=pflash,format=raw,file=/where/ever/OVMF_VARS.fd
> 
> OVMF_CODE.fd must be unit 0, and OVMF_VARS.fd must be unit 1.
> 
> Generic code creates two block backends.  Magic board code picks them
> up, creates a frontend (a cfi.pflash01 device) for each, and maps them
> into the guest's address space.
> 
> Note there are *two* virtual flash devices now, whereas physical
> hardware commonly has just one.
> 
> At libvirt level:
> 
>   <loader type="pflash" readonly="yes">/usr/share/OVMF/OVMF_CODE.fd</loader>
>   <nvram template="/usr/share/OVMF/OVMF_VARS.fd">/var/libvirt/nvram/${guest}_VARS.fd</nvram>
> 
> This treats OVMF_VARS.fd as a read-only template, and gives each guest
> its own writable copy, which is nice.
> 
> The flash device model supports restricting writes to SMM (remember,
> that's required for secure boot).  It's controlled by cfi.pflash01
> property secure, off by default.  If we created the device model with
> -device, we'd simply pass secure=on.  But since we create it with -drive
> if=pflash, we can't.  Instead we have to use
> 
>     -global driver=cfi.pflash01,property=secure,value=on
> 
> This flips the global default value.  Awkward, but works out okay,
> because (1) the flash device holding OVMF_VARS.fd wants this value, and
> (2) the flash device holding OVMF_CODE.fd doesn't care (it's read-only),
> and (3) there is no way to create additional flash devices.
> 
> At the libvirt level, we add secure='yes' to the loader element.
> 
> We also have to enable SMM emulation.  At QEMU level:
> 
>     -machine smm=on
> 
> At libvirt level:
> 
>     <features>
>       <smm state='on'/>
>     </features>
> 
> Note that the above configuration examples involve selecting OVMF
> images.  A bit of an inconvenience compared to BIOS, where the default
> "use the BIOS shipped with QEMU" pretty much just works.
> 
> To add annoyance to inconvenience, different distributions have
> different ideas on where to install OVMF images.  And because that's not
> complicated enough, we also have to pair code with data images.  And
> because that's still not complicated enough, any specific machine type
> may work only with a subset of the available firmwares.
> 
> The proposed way to deal with all that works as follows.
> 
> Each set of firmware images comes with a descriptor file.  These are
> JSON and conform to the QAPI schema docs/interop/firmware.json.
> 
> Among the descriptors that declare support for the kind of machine we
> want, we pick (really: the management application picks) the one with
> the highest priority.  The distribution provides default priorities,
> which system administrator and user can override.  firmware.json
> documents this in much more detail.
> 
> I wrote "proposed", because as far as I can tell, neither distributions
> nor libvirt are there, yet.
> 
> After all this text, I'm finally ready to curve towards -blockdev.
> Going from -drive if=T, T!=none to -blockdev involves two steps.  The
> first step replaces if=T with if=none and -device.  The second step
> replaces -drive if=none with -blockdev.  That step is "obvious" (it took
> us a few years to get to obvious, but I digress).  The difficulty is in
> the first step.  Two issues:
> 
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
> 
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
>     name                        Memory region name
>                                 (why is this even configurable?)
>     phys-addr                   Physical base address
>                                 (this is the new device property
>                                 mentioned above)
>     secure                      For restricting access to firmware,
>                                 default off
>     device-width                you don't want to know,
>                                 there is a default, but it's documented
>                                 as "bad, do not use", yet pretty much
>                                 all boards use it
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
> 
> Perhaps the realize() method could default num-blocks to size of
> backend.  But that doesn't really help the management application,
> because it needs to mess with the size anyway to compute phys-addr.  So
> scratch that idea.
> 
> Moving the magic code to compute num-blocks, phys-addr and name to the
> management application is certainly possible, but ugly.
> 
> Note that the values computed are fixed when the firmware gets deployed.
> If we record them in the firmware descriptor, the management application
> doesn't need magic, it can simply pass on the values obtained from the
> descriptor.
> 
> We'd want to include sector-length in the descriptor then, to ensure
> num-block has a defined meaning.
> 
> Same technique could take care of width, big-endian, ... in case
> machine-type specific defaults turn out to be inadequate for them.
> 
> Opinions?
> 
> One more problem: the magic board code does a bit more than just
> configure the cfi.pflash01 device.  That additional magic needs to be
> generalized to work regardless of whether the device gets configured
> with -drive if=pflash or with -device.  I got a working prototype.
> 

Great write-up.

For i440fx and q35, exposing the size info (i.e., "num-blocks" and
"sector-length"), and the base address ("phys-addr") in the firmware
descriptor json would be justifiable, and not much of a burden to fill in.

Regarding "name", I have no idea what that is used for (and so whether
it must remain "compatible"), so maybe we could auto-generate that in
generic "-device" code in QEMU. Not sure. If it must go in the
descriptor, it can, but it wouldn't provide any useful distinction
between OVMF builds at least.

"secure" is already covered in the descriptor, via @requires-smm.

Regarding the rest of the properties, from my POV, I'd prefer to
continue controlling them via machine type-specific defaults. My only
reason is to keep the json reasonably clutter-free. OTOH, if they
significantly helped this conversion and/or libvirtd, I wouldn't insist
on keeping them out.

Thanks!
Laszlo
