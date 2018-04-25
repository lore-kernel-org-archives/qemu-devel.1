Received: from eggs.gnu.org ([2001:4830:134:3::10]:53227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fBL5V-00069L-5l
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fBL5Q-00010C-5y
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:08:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49644 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fBL5Q-0000zy-0N
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:07:56 -0400
Date: Wed, 25 Apr 2018 16:07:49 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180425140749.6x3w4h4i2n6uaq7o@sirius.home.kraxel.org>
References: <20180323122520.11270-1-kraxel@redhat.com>
	<43fc23c1-d72f-748a-5b9d-a816466d7406@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43fc23c1-d72f-748a-5b9d-a816466d7406@redhat.com>
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

> > We should make sure that any device model that combines ramfb with
> > another PCI display device is not matched by the OVMF driver for that
> > PCI display device. IOW, we should use separate PCI IDs or subsystem
> > IDs (I don't recall the details off-hand). I'd like to avoid messing
> > with the current device probing code in OVMF. It just wouldn't be nice
> > if two independent drivers (e.g. VirtioGpuDxe and a supposed
> > "RamFbDxe") bound the two interfaces at the same time.
> 
> For example, virtio-vga is already problematic like this (it could be
> driven by both Virtio10Dxe+VirtioGpuDxe, and QemuVideoDxe), and it had
> to be hacked around in Virtio10Dxe. So I'm strongly in favor of a device
> model that clearly looks like one device and one device only to the full
> set of edk2 drivers, without cross-driver hacks.

Hmm, trying to figure what we should do here best ...

First, ramfb has absolutely no connection to the "combined" device,
other than that the combined devices have a single device only.  From
the guests point of view there is no difference between

  (a) qemu -device virtio-ramfb, and
  (b) qemu -device virtio-gpu-pci -device ramfb-testdev

On the host side the difference is that (a) is a single QemuConsole
which shows virtio-gpu-pci once activated and ramfb otherwise, and
(b) is two QemuConsoles, so you can see both virtio-gpu-pci and ramfb
side-by-side, for debugging purposes.

Second, one usecase is vgpu boot display.  When combining ramfb with a
(mdev) vgpu qemu can't modify the pci device.  Which I think pretty much
implies that adding a whitelist of pci devices to ramfb isn't going to
fly.  It would also have the drawback that -device ramfb-testdev will
not work.

So lets do it the other way around?  Blacklist devices which
QemuVideoDxe and VirtioGpuDxe should *not* bind to?  One way would be to
just use different pci (subsystem) ids.  Problem is that the guest os
driver might not bind too then.  So something else?  Add a pci
capability maybe?  Other ideas?

cheers,
  Gerd
