Received: from eggs.gnu.org ([2001:4830:134:3::10]:35393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBRGT-00088K-52
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBRGO-0005je-Te
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:43:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59206 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fBRGO-0005jD-Mi
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:43:40 -0400
References: <20180323122520.11270-1-kraxel@redhat.com>
	<43fc23c1-d72f-748a-5b9d-a816466d7406@redhat.com>
	<20180425140749.6x3w4h4i2n6uaq7o@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1ed94b1c-b416-eebe-9cf3-91943a0e6c5a@redhat.com>
Date: Wed, 25 Apr 2018 22:43:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180425140749.6x3w4h4i2n6uaq7o@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>

On 04/25/18 16:07, Gerd Hoffmann wrote:
>   Hi,
> 
>>> We should make sure that any device model that combines ramfb with
>>> another PCI display device is not matched by the OVMF driver for that
>>> PCI display device. IOW, we should use separate PCI IDs or subsystem
>>> IDs (I don't recall the details off-hand). I'd like to avoid messing
>>> with the current device probing code in OVMF. It just wouldn't be nice
>>> if two independent drivers (e.g. VirtioGpuDxe and a supposed
>>> "RamFbDxe") bound the two interfaces at the same time.
>>
>> For example, virtio-vga is already problematic like this (it could be
>> driven by both Virtio10Dxe+VirtioGpuDxe, and QemuVideoDxe), and it had
>> to be hacked around in Virtio10Dxe. So I'm strongly in favor of a device
>> model that clearly looks like one device and one device only to the full
>> set of edk2 drivers, without cross-driver hacks.
> 
> Hmm, trying to figure what we should do here best ...
> 
> First, ramfb has absolutely no connection to the "combined" device,
> other than that the combined devices have a single device only.

I think you mean "... single back-end only">

> From
> the guests point of view there is no difference between
> 
>   (a) qemu -device virtio-ramfb, and
>   (b) qemu -device virtio-gpu-pci -device ramfb-testdev
> 
> On the host side the difference is that (a) is a single QemuConsole
> which shows virtio-gpu-pci once activated and ramfb otherwise, and
> (b) is two QemuConsoles, so you can see both virtio-gpu-pci and ramfb
> side-by-side, for debugging purposes.

Exactly this "multiple frontends, single backend" connection is the
problem. In UEFI, it is possible to establish a priority order between
drivers that are all capable of binding the same controller ("handle"),
but especially with ramfb + another (PCI) video frontend, it's the
"handles" that are different. The "priority mechanism" would have no
idea that the drivers cannot peacefully coexist, i.e. it's clueless
about the (host side only) competition.

This is a problem because you display something on the one device, and
the screen still shows the other, and users complain.

To my understanding, in Linux, special cross-driver hacks exist for
this. For example, you boot with efifb (which is not a PCI device), and
once an actual PCI display driver is configured, it is considered
superior, and it supplants efifb.

On a tangent: on the host side, we already have to entirely separate I/O
consoles: some kind of graphics + emulated keyboard, plus serial. Those
are always displayed in parallel -- not in two GUI toolkit windows, mind
you, but it's never the case that one permanently "hides" the other. You
can switch between them in virt-manager. Or, connect to the emulated
serial port from a terminal window that is separate from the main
graphics window.

If this was the case with ramfb + something else (i.e., writing to ramfb
wouldn't be possible to "read back" for the other firmware driver, from
the PCI framebuffer, and one could switch back and forth between ramfb
display and PCI display on their desktop), then it would be OK for both
firmware drivers to bind. Point is, the two back-ends need not occupy
double the screen real estate; it would suffice if one didn't hide the
other permanently, and users could switch at will.

> Second, one usecase is vgpu boot display.  When combining ramfb with a
> (mdev) vgpu qemu can't modify the pci device.  Which I think pretty much
> implies that adding a whitelist of pci devices to ramfb isn't going to
> fly.  It would also have the drawback that -device ramfb-testdev will
> not work.
> 
> So lets do it the other way around?  Blacklist devices which
> QemuVideoDxe and VirtioGpuDxe should *not* bind to?

(It's a bit worse than that, actually -- VirtioGpuDxe does not consume
EFI_PCI_IO_PROTOCOL, it consumes VIRTIO_DEVICE_PROTOCOL.
VIRTIO_DEVICE_PROTOCOL is produced by the various virtio transport
drivers we have; in this particular case, that is Virtio10Dxe. And it is
Virtio10Dxe that consumes EFI_PCI_IO_PROTOCOL. So the mutual exclusion,
for virtio-vga anyway, happens between QemuVideoDxe and Virtio10Dxe, on
the controller handle that has a PciIo interface on it.)

> One way would be to
> just use different pci (subsystem) ids.  Problem is that the guest os
> driver might not bind too then.  So something else?  Add a pci
> capability maybe?  Other ideas?

I could imagine an OvmfPkg-specific PCI capability that said, "all PCI
drivers in OvmfPkg that could otherwise drive this device, ignore it --
another (platform) driver in OvmfPkg will pick it up instead". This
would resolve the competition between ramfb and whatever PCI device;
ramfb would always win. (We should add the capability check to OvmfPkg's
PCI drivers *no later* than introducing the ramfb driver though, so
there be no "window" where both kinds bound.)

(Wrt. updating the PCI ID lists of guest OS drivers -- I guess that too
could be viable, at least for Linux. I'm not really certain.)

Thanks
Laszlo
