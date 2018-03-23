Received: from eggs.gnu.org ([2001:4830:134:3::10]:42570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ezO2l-0008Da-Oh
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ezO2i-0005yY-Mw
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:51:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37622 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ezO2i-0005xu-HZ
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:51:44 -0400
Date: Fri, 23 Mar 2018 15:51:31 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180323145131.whyitmksl2s3d6c6@sirius.home.kraxel.org>
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

> I believe the only point of this device model (and the associated guest
> fw driver) is Windows-on-KVM/aarch64.

The other one is vgpu boot display.

And maybe killing vga emulation.  Well, at least be able to not use it
any more for UEFI guests.  It's so much crazy stuff in vga emulation
which isn't used by anyone these days (especially on uefi which doesn't
even need vga text mode any more), except by guys who try to find holes
in qemu for a host escape ...

> Would it be possible to make this stuff available for testing to the
> guy(s) who reported
> <https://bugzilla.tianocore.org/show_bug.cgi?id=785>? (Registration in
> the TianoCore bugzilla is open, and once you log in, you can read email
> addresses, and/or comment on BZs of course.)

I plan to look at arm, but that likely will happen after easter holidays
(I'm offline next week).

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

Yep, that is one of the things which still need to be sorted.  The
approach of the experimental firmware builds to just disable the
QemuVideo and VirtioGpu drivers clearly doesn't fly for anything but the
initial testing.

Giving out different IDs to the ramfb-enabled device variants would be
one option.  Not fully sure whenever that works for virtio-gpu.  But
given that there are no legacy/transitional virtio-gpu devices I think
we are free to change the subsystem ID as we like.

cheers,
  Gerd
