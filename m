Received: from eggs.gnu.org ([2001:4830:134:3::10]:33816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fTENW-00027a-44
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 18:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fTENV-0004U9-4R
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 18:36:34 -0400
Date: Thu, 14 Jun 2018 00:36:25 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180613223625.lf6xkzgipzkfslit@sirius.home.kraxel.org>
References: <20180613084149.14523-1-kraxel@redhat.com>
	<20180613084149.14523-4-kraxel@redhat.com>
	<20180613135047.5c1ce227@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613135047.5c1ce227@w520.home>
Subject: Re: [Qemu-devel] [PATCH v4 3/3] hw/vfio/display: add ramfb support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, libvir-list@redhat.com, Erik Skultety <eskultet@redhat.com>, Laine Stump <laine@redhat.com>

On Wed, Jun 13, 2018 at 01:50:47PM -0600, Alex Williamson wrote:
> On Wed, 13 Jun 2018 10:41:49 +0200
> Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
> > So we have a boot display when using a vgpu as primary display.
> > 
> > Use vfio-pci-ramfb instead of vfio-pci to enable it.
> 
> Using a different device here seems like it almost guarantees a very
> complicated path to support under libvirt.  What necessitates this
> versus a simple ramfb=on option to vfio-pci?

Well, it's simliar to qxl vs. qxl-vga.  It's not qxl,vga={on,off} and
libvirt has no problems to deal with that ...

Another more technical reason is (again) hotplug.  ramfb needs an fw_cfg
entry for configuration, and fw_cfg entries can't be hotplugged.  So
hotplugging vfio-pci with ramfb=on isn't going to fly.  So we need a
separate device with hotplug turned off.

> I'm also not sure I understand the usage model, SeaBIOS and OVMF know
> how to write to this display, but it seems that the guest does not.

Yes.

> I suppose in the UEFI case runtime services can be used to continue
> writing this display,

Yes.

> but BIOS doesn't have such an option, unless we're somehow emulating
> VGA here.

vgabios support is in the pipeline, including text mode emulation (at
vgabios level, direct access to vga window @ 0xa0000 doesn't work).

> So for UEFI, I can imagine this
> covers us from power on through firmware boot and up to guest drivers
> initializing the GPU (assuming the vGPU supports a kernel mode driver,
> does NVIDIA?),

Yes.  Shouldn't matter whenever the driver is kernel or userspace.

> but for BIOS it seems we likely still have a break from
> the bootloader to GPU driver initialization.

Depends.  vgacon (text mode console) doesn't work.  fbcon @ vesafb works.

> For instance, what driver
> is used to draw the boot animation (or blue screen) on SeaBIOS Windows
> VM?

Windows depends on vgabios for that and it works fine.

> I'm assuming that this display and the vGPU display are one in the
> same, so there's some cut from one to the other.

Yes.  If the vfio query plane ioctl reports a valid guest video mode
configuration the vgpu display will be used, ramfb otherwise.

cheers,
  Gerd
