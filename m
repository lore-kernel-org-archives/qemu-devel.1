Received: from eggs.gnu.org ([2001:4830:134:3::10]:51724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFfOJ-00046J-Cl
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 07:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFfOG-0006Wd-U4
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 07:05:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:29175)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFfOG-0006Ve-Kx
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 07:05:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7F2A883BE
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 12:04:59 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 13:04:50 +0100
Message-Id: <20171117120454.13507-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] ramfb: simple boot framebuffer,
 no legacy vga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?L=C3=A1szl=C3=B3=20=C3=89rsek?= <lersek@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

  Hi,

Ok folks, here is a experimental patch series for a legacy free boot
framebuffer.  If you want play with it I recommend getting the bits from

	https://www.kraxel.org/cgit/qemu/log/?h=3Dsirius/ramfb

because they come with an updated seabios and a new vgabios rom.

The boot framebuffer is expected to be configured by the firmware, so it
uses fw_cfg as interface.  Initialization goes as follows:

  (1) Check whenever etc/ramfb is present.
  (2) Allocate framebuffer from RAM.
  (3) Fill struct RAMFBCfg, write it to etc/ramfb.

Done.  You can write stuff to the framebuffer now, and it should appear
automagically on the screen.

Note that this isn't very efficient because it does a full display
update on each refresh.  No dirty tracking.  Dirty tracking would have
to be active for the whole ram slot, so that wouldn't be very efficient
either.  So it is *really* intended to be only active for a short time
at boot, before the guest loaded the drivers for the real display
hardware.

seavgabios is able to emulate vga text mode on top of a framebuffer, for
coreboot native graphics initialialization.  Which works fine for
everything which writes text using the vgabios interface (basically
everyhing which works with sgabios).

So I hacked that up to work with ramfb.  Right now it's proof-of-concept
code with too much cut+paste, so it will clearly need a bunch of
cleanups if this approach turns out to be workable.  Look here:
	https://www.kraxe.org/cgit/seabios/log/?h=3Dramfb

So, how to play?

There is ramfb-testdev.  Standalone device, for testing purposes.  Also
listens on vga ports and logs any access, so we can see the bad boys ;)
Use "qemu -vga none -device ramfb-testdev".

There is virtio-ramfb.  Simlar to virtio-vga, but using ramfb instead of
adding vga compatibility.  Shows how you can wire up ramfb support to
some display device.  Unlike virtio-vga it should work fine on arm.  Use
"qemu -vga none -device virtio-ramfb" for this one.

What works?

Boot loaders all use vgabios calls for text mode, so they show up just
fine.  Also ipxe, seabios itself of course.  So you can boot up your
linux guest.  vesafb works too.

What doesn't work?

vgacon (direct vga hardware access).

Windows (bios mode).  Boot logo shows up just fine.  But at some point
windows does lots of vga register accesses (even though it sets the
video mode via vesa bios interface) and appears to be unhappy that
things don't work as expected because there is no actual vga hardware.

Future plans:

Try use that as vgpu boot display.  Requires solving that windows issue
somehow, otherwise it's going to be a non-starter.

Trick L=C3=A1szl=C3=B3 into writing a UEFI driver for that.  Linux will u=
se efifb
not vgacon then, and hopefully Windows doesn't try access vga registers
either.

Comments?
Hints on the windows issue anyone?

enjoy,
  Gerd

Gerd Hoffmann (4):
  [testing] update bios, add vgabios-ramfb
  ramfb: simple boot framebuffer living in guest ram
  add virtio-ramfb
  add ramfb-testdev

 include/hw/display/ramfb.h |   8 +++
 hw/display/ramfb-testdev.c |  87 ++++++++++++++++++++++++++
 hw/display/ramfb.c         |  94 ++++++++++++++++++++++++++++
 hw/display/virtio-ramfb.c  | 149 +++++++++++++++++++++++++++++++++++++++=
++++++
 hw/display/Makefile.objs   |   5 +-
 pc-bios/bios-256k.bin      | Bin 262144 -> 262144 bytes
 pc-bios/vgabios-ramfb.bin  | Bin 0 -> 28160 bytes
 7 files changed, 342 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/display/ramfb.h
 create mode 100644 hw/display/ramfb-testdev.c
 create mode 100644 hw/display/ramfb.c
 create mode 100644 hw/display/virtio-ramfb.c
 create mode 100644 pc-bios/vgabios-ramfb.bin

--=20
2.9.3
