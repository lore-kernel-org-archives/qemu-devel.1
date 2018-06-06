Received: from eggs.gnu.org ([2001:4830:134:3::10]:54128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fQU83-0000kq-EQ
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 04:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fQU7x-0006wy-FM
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 04:49:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39102 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fQU7x-0006wL-26
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 04:49:09 -0400
Date: Wed, 6 Jun 2018 10:49:00 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180606084900.77jv3z4il47bx5gi@sirius.home.kraxel.org>
References: <20180323122520.11270-1-kraxel@redhat.com>
	<43fc23c1-d72f-748a-5b9d-a816466d7406@redhat.com>
	<20180425140749.6x3w4h4i2n6uaq7o@sirius.home.kraxel.org>
	<1ed94b1c-b416-eebe-9cf3-91943a0e6c5a@redhat.com>
	<20180531084347.xb2r5aolkis2nmqg@sirius.home.kraxel.org>
	<4b65af58-8451-a365-6c81-52c49e42b6ff@redhat.com>
	<20180605110647.7ctaj7fiy6x4ewdw@sirius.home.kraxel.org>
	<a3fe57cf-1569-834d-5528-d85847b29f9f@redhat.com>
	<20180605131649.fu3cellm7vwaf4ao@sirius.home.kraxel.org>
	<20d457f0-647f-04e3-76c3-ed58f3494208@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20d457f0-647f-04e3-76c3-ed58f3494208@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/7] ramfb: simple boot framebuffer,
 no legacy vga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>

  Hi,

> > Maybe we should for now just scratch the idea of an virtio-ramfb device.
> > Linux doesn't need it, and windows wouldn't use the virtio part of it so
> > a standalone ramfb device would work equally well.
> 
> If that works for you, it works for me best!


Ok, pushed updated branches.

qemu (including seabios + ovmf blobs):
  https://git.kraxel.org/cgit/qemu/log/?h=sirius/ramfb

edk2:
  https://github.com/kraxel/edk2/commits/ramfb

seabios:
  https://git.kraxel.org/cgit/seabios/log/?h=bochs


What is in there?

qemu:
   -device ramfb
      standalone ramfb device
   -device virtio-ramfb
      kept for now for testing, as discussed above no plans
      to merge this one for now.
   -device vfio-pci-ramfb
      boot display for vgpu devices.
   bochs-display got a vgabios.

seabios:
   support for bochs-display + rmafb added.  For both of them
   vga text mode (at vgabios call level) is emulated by seabios
   inside the guest.

edk2:
   QemuRamfbDxe driver, x86 wireup, incomplete arm wireup.


Notes on QemuRamfbDxe:

QemuRamfbDxe registers as VenHw device with a fresh generated uuid.  The
uuid should probably go to some header file, suggestions where to place
it best? 

QemuRamfbDxe registers a acpi devpath node for the gop protocol.  It's
appended to the VenHw path, but looks like that isn't enough to create
it as child node of the VenHw device (according to devtree outout).
Suggestions how to fix that?  Still this is good enough for consplitter
to accept the device.

The device path is added to the gPlatformConsole list, so consplitter
will pick up the ramfb device even though it isn't a pci display device.
The firmware display will show up on ramfb in addition to other display
devices (if any).  Is that approach ok?  If so I'll do that for armvirt
too.

thanks and happy playing,

  Gerd
