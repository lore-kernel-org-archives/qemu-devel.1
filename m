Received: from eggs.gnu.org ([2001:4830:134:3::10]:39827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etDyN-0004qI-Mi
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etDyJ-00039R-D5
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:53:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41200 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etDyJ-000399-8F
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:53:43 -0500
Date: Tue, 6 Mar 2018 15:53:31 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180306145331.y36cuci2lvd3qnnf@sirius.home.kraxel.org>
References: <20180306113442.15295-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306113442.15295-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 0/9] vfio: add display support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: intel-gvt-dev@lists.freedesktop.org, Alex Williamson <alex.williamson@redhat.com>, Tina Zhang <tina.zhang@intel.com>, Kirti Wankhede <kwankhede@nvidia.com>

On Tue, Mar 06, 2018 at 12:34:33PM +0100, Gerd Hoffmann wrote:
> This series adds support for a vgpu display to the qemu vfio code.

Ok, for anyone who wants play with this, the requirements:

qemu
====

The repo at git://git.kraxel.org/qemu has a sirius/dmabufs-merge branch
with this series and spice patches and gtk patches merged.

The traditional work/intel-vgpu branch has been updated too (it is the
same as sirius/dmabufs-merge plus some work-in-progress patches).

host kernel
===========

You need a 4.16-rc kernel.  The intel graphics driver comes with mdev
support.  Needs gen5+ hardware (broadwell, skylake, kaby-lake).  Not
sure about nvidia.

Pure software drivers are available from 
   git://git.kraxel.org/cgit/linux vfio-sample-display

There are three kernel modules in samples/vfio-mdev:

  (1) mdpy.ko.  Very simple display device.  Fixed framebuffer and
      resolution.  Uses the region-based vfio display interface.
  (2) mbochs.ko.  Mimics qemu vga with bochs dispi vbe interface.
      Doesn't emulate any legacy vga.  But good enough to make the
      bochs-drm.ko driver happy.  Uses the dmabuf-based vfio display
      interface.  Zero-copy display updates.
  (3) mdpy-fb.ko.  Guest framebuffer driver for (1).

guest kernel
============

intel-gvt: 4.9+ I think.
nvidia:    dunno.
mbochs:    3.14+ should work.
mdpy:      The vfio-sample-display branch above if you want see guest
	   display updates.  Without that you'll see a static test
	   pattern.

booting the guest
=================

Create mdev devices and use "-device vfio-pci,..." as usual, see
https://www.kernel.org/doc/Documentation/vfio-mediated-device.txt

For mdev devices using dmabufs you need opengl support.
So start qemu with spice or gtk ui and opengl enabled:

  qemu -display gtk,gl=on
  qemu -spice gl=on,$otherargs

When using a display without opengl support you can use egl-headless to
handle the opengl rendering and texture readout (which of course adds
some overhead):

  qemu -display egl-headless -vga $display
  qemu -display egl-headless -spice gl=off,$otherargs

enjoy,
  Gerd
