Received: from eggs.gnu.org ([2001:4830:134:3::10]:44280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fOJBY-0003mi-Sx
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fOJBV-0007vG-Q6
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:43:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44916 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fOJBV-0007ul-JU
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:43:49 -0400
Date: Thu, 31 May 2018 10:43:47 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180531084347.xb2r5aolkis2nmqg@sirius.home.kraxel.org>
References: <20180323122520.11270-1-kraxel@redhat.com>
	<43fc23c1-d72f-748a-5b9d-a816466d7406@redhat.com>
	<20180425140749.6x3w4h4i2n6uaq7o@sirius.home.kraxel.org>
	<1ed94b1c-b416-eebe-9cf3-91943a0e6c5a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ed94b1c-b416-eebe-9cf3-91943a0e6c5a@redhat.com>
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

Resuming an old discussion ...

> > From
> > the guests point of view there is no difference between
> > 
> >   (a) qemu -device virtio-ramfb, and
> >   (b) qemu -device virtio-gpu-pci -device ramfb-testdev
> > 
> > On the host side the difference is that (a) is a single QemuConsole
> > which shows virtio-gpu-pci once activated and ramfb otherwise, and
> > (b) is two QemuConsoles, so you can see both virtio-gpu-pci and ramfb
> > side-by-side, for debugging purposes.
> 
> Exactly this "multiple frontends, single backend" connection is the
> problem. In UEFI, it is possible to establish a priority order between
> drivers that are all capable of binding the same controller ("handle"),
> but especially with ramfb + another (PCI) video frontend, it's the
> "handles" that are different. The "priority mechanism" would have no
> idea that the drivers cannot peacefully coexist, i.e. it's clueless
> about the (host side only) competition.

Well, virtio-vga and qxl-vga are very simliar.  They both are two-in-one
devices, with legacy vga frontend and native (qxl/virtio) frontend
sharing a single backend.  When the guest initialized the native
frontend the backend switches over from vga to native.

> This is a problem because you display something on the one device, and
> the screen still shows the other, and users complain.

In ovmf the console splitter handles this reasonable well, firmware and
bootloader simply show up on all outputs.  Got the ramfb driver to the
point where it joins the party properly.

The early boot phase (efifb active for linux) is more problematic.  Only
one of the GOPs is used, and it seems whatever GOP was registered first
gets used.  Try boot a fedora live iso with (a) "-device VGA -device
secondary-vga" and (b) "-device secondary-vga -device VGA".  efifb shows
up on the first device (probably because it also is first in pci scan
order).  fbcon shows up on the VGA device.  So for (b) the boot output
switches the display when bochs-drm.ko loads.

> To my understanding, in Linux, special cross-driver hacks exist for
> this. For example, you boot with efifb (which is not a PCI device), and
> once an actual PCI display driver is configured, it is considered
> superior, and it supplants efifb.

Linux does two things here.

First it checks ressource ranges, and if there is a conflict the
firmware framebuffer (efifb in ovmf case, but vesafb and others on !x86
platforms are handled simliar) the firmware framebuffer driver is
unregistered, only the native framebuffer driver remains active.

Second one device is picked as "primary".  Basically linux tries to
figure which device was activated by the firmware, to prefer that for
fbcon.  This is what makes linux switch over in case (b) above, because
linux prefers VGA display devices here (-device secondary-vga is
PCI_CLASS_DISPLAY_OTHER).

The logic to pick the "primary" display is arch-specific.

> On a tangent: on the host side, we already have to entirely separate I/O
> consoles: some kind of graphics + emulated keyboard, plus serial. Those
> are always displayed in parallel -- not in two GUI toolkit windows, mind
> you, but it's never the case that one permanently "hides" the other.

Well, try "View / Detach tab" in the gtk ui in case you want them side
by side in two windows.  SDL2 uses one window per console too.

> If this was the case with ramfb + something else (i.e., writing to ramfb
> wouldn't be possible to "read back" for the other firmware driver, from
> the PCI framebuffer, and one could switch back and forth between ramfb
> display and PCI display on their desktop), then it would be OK for both
> firmware drivers to bind. Point is, the two back-ends need not occupy
> double the screen real estate; it would suffice if one didn't hide the
> other permanently, and users could switch at will.

I think it makes sense for the *-ramfb devices behave simliar to the
existing *-vga devices, which are *not* user-switchable between
frontends.

Given ovmf has virtio-gpu drivers I'm not sure we need virtio-ramfb at
all.

> I could imagine an OvmfPkg-specific PCI capability that said, "all PCI
> drivers in OvmfPkg that could otherwise drive this device, ignore it --
> another (platform) driver in OvmfPkg will pick it up instead".

pci capability for ramfb could be useful (also for linux).  I'll keep it
in mind for now.

cheers,
  Gerd
