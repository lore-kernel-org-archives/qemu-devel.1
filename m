Received: from eggs.gnu.org ([2001:4830:134:3::10]:37405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eFjf4-00019g-T5
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:38:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eFjf0-0002nA-R2
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:38:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eFjf0-0002mP-I5
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:38:34 -0500
References: <20171117120454.13507-1-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <4ea6f197-0aee-50d6-e53c-f98a6a8f999a@redhat.com>
Date: Fri, 17 Nov 2017 17:38:21 +0100
MIME-Version: 1.0
In-Reply-To: <20171117120454.13507-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] ramfb: simple boot framebuffer,
 no legacy vga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Drew Jones <drjones@redhat.com>

CC Ard & Drew

Hi,

On 11/17/17 13:04, Gerd Hoffmann wrote:
>   Hi,
>=20
> Ok folks, here is a experimental patch series for a legacy free boot
> framebuffer.  If you want play with it I recommend getting the bits fro=
m
>=20
> 	https://www.kraxel.org/cgit/qemu/log/?h=3Dsirius/ramfb
>=20
> because they come with an updated seabios and a new vgabios rom.
>=20
> The boot framebuffer is expected to be configured by the firmware, so i=
t
> uses fw_cfg as interface.  Initialization goes as follows:
>=20
>   (1) Check whenever etc/ramfb is present.
>   (2) Allocate framebuffer from RAM.
>   (3) Fill struct RAMFBCfg, write it to etc/ramfb.

Please add documentation on the "fourcc" (pixel format?) and "flags"
fields. Also please document the endianness of the integer fields.

>=20
> Done.  You can write stuff to the framebuffer now, and it should appear
> automagically on the screen.
>=20
> Note that this isn't very efficient because it does a full display
> update on each refresh.  No dirty tracking.  Dirty tracking would have
> to be active for the whole ram slot, so that wouldn't be very efficient
> either.  So it is *really* intended to be only active for a short time
> at boot, before the guest loaded the drivers for the real display
> hardware.
>=20
> seavgabios is able to emulate vga text mode on top of a framebuffer, fo=
r
> coreboot native graphics initialialization.  Which works fine for
> everything which writes text using the vgabios interface (basically
> everyhing which works with sgabios).
>=20
> So I hacked that up to work with ramfb.  Right now it's proof-of-concep=
t
> code with too much cut+paste, so it will clearly need a bunch of
> cleanups if this approach turns out to be workable.  Look here:
> 	https://www.kraxe.org/cgit/seabios/log/?h=3Dramfb
>=20
> So, how to play?
>=20
> There is ramfb-testdev.  Standalone device, for testing purposes.  Also
> listens on vga ports and logs any access, so we can see the bad boys ;)
> Use "qemu -vga none -device ramfb-testdev".
>=20
> There is virtio-ramfb.  Simlar to virtio-vga, but using ramfb instead o=
f
> adding vga compatibility.  Shows how you can wire up ramfb support to
> some display device.  Unlike virtio-vga it should work fine on arm.  Us=
e
> "qemu -vga none -device virtio-ramfb" for this one.

(Side note: <https://bugzilla.tianocore.org/show_bug.cgi?id=3D785>.)

We should make sure that any device model that combines ramfb with
another PCI display device is not matched by the OVMF driver for that
PCI display device. IOW, we should use separate PCI IDs or subsystem IDs
(I don't recall the details off-hand). I'd like to avoid messing with
the current device probing code in OVMF. It just wouldn't be nice if two
independent drivers (e.g. VirtioGpuDxe and a supposed "RamFbDxe") bound
the two interfaces at the same time.

This device will take a DXE driver or UEFI driver that does not follow
the UEFI driver model because there's no "controller handle" to bind.
(The thing to probe is an fw_cfg file.)

>=20
> What works?
>=20
> Boot loaders all use vgabios calls for text mode, so they show up just
> fine.  Also ipxe, seabios itself of course.  So you can boot up your
> linux guest.  vesafb works too.
>=20
> What doesn't work?
>=20
> vgacon (direct vga hardware access).
>=20
> Windows (bios mode).  Boot logo shows up just fine.  But at some point
> windows does lots of vga register accesses (even though it sets the
> video mode via vesa bios interface) and appears to be unhappy that
> things don't work as expected because there is no actual vga hardware.
>=20
> Future plans:
>=20
> Try use that as vgpu boot display.  Requires solving that windows issue
> somehow, otherwise it's going to be a non-starter.
>=20
> Trick L=C3=A1szl=C3=B3 into writing a UEFI driver for that.

I cannot imagine when I'll get to this. :(

Feel free to file a BZ somewhere (TianoCore or RH Bugzilla) and/or poke
me occasionally. My TODO list is full of things than are *all* more
urgenterer than all the other things on the list.

I'm nearing TODO list bankruptcy (IRL too).

> Linux will use efifb
> not vgacon then, and hopefully Windows doesn't try access vga registers
> either.
>=20
> Comments?
> Hints on the windows issue anyone?

We looked into those when we worked on the Int10h VBE shim in OVMF. We
decided the VGA register accesses were way too complicated and so we did
the shim for BOCHS VGA and QXL only. IIRC. (I could be conflating things.=
)

This looks like a great job, honestly; I'm sorry I can't say more
positive things about a GOP driver for it right now.

Thanks,
Laszlo

>=20
> enjoy,
>   Gerd
>=20
> Gerd Hoffmann (4):
>   [testing] update bios, add vgabios-ramfb
>   ramfb: simple boot framebuffer living in guest ram
>   add virtio-ramfb
>   add ramfb-testdev
>=20
>  include/hw/display/ramfb.h |   8 +++
>  hw/display/ramfb-testdev.c |  87 ++++++++++++++++++++++++++
>  hw/display/ramfb.c         |  94 ++++++++++++++++++++++++++++
>  hw/display/virtio-ramfb.c  | 149 +++++++++++++++++++++++++++++++++++++=
++++++++
>  hw/display/Makefile.objs   |   5 +-
>  pc-bios/bios-256k.bin      | Bin 262144 -> 262144 bytes
>  pc-bios/vgabios-ramfb.bin  | Bin 0 -> 28160 bytes
>  7 files changed, 342 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/display/ramfb.h
>  create mode 100644 hw/display/ramfb-testdev.c
>  create mode 100644 hw/display/ramfb.c
>  create mode 100644 hw/display/virtio-ramfb.c
>  create mode 100644 pc-bios/vgabios-ramfb.bin
>=20
