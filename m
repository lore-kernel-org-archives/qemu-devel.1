Received: from eggs.gnu.org ([2001:4830:134:3::10]:48137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eqk3t-0001vY-Rp
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:33:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eqk3q-0005wD-Jg
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:33:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eqk3q-0005vf-BM
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:33:10 -0500
Date: Tue, 27 Feb 2018 11:32:51 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180227113251.3d24a58f@w520.home>
In-Reply-To: <20180227085209.19151-1-kraxel@redhat.com>
References: <20180227085209.19151-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/7] vfio: add display support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>, Laine Stump <laine@redhat.com>, Erik Skultety <eskultet@redhat.com>, libvir-list@redhat.com

[CC +libvirt]

On Tue, 27 Feb 2018 09:52:02 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> This series adds support for a vgpu display to the qemu vfio code.
> 
> v5:
>  - rebase to latest master
>  - drop DeviceState->hotpluggable patch, use separate vfio-pci-display
>    device instead so we can use DeviceClass->hotpluggable.

I can't imagine that management layers are going to be happy with this
approach, it's one thing to have certain USB controllers where the
version intimately tied to the machine chipset is not hotpluggable,
while standalone versions are, but having a fork of an entirely
standalone device for this purpose sounds very invasive.  What does the
XML look like that would make libvirt select this option?  I'm still
thinking that a separate display device, which vfio-pci can bind to as
a device option, not affecting the hotplug-ability of the vfio-pci
device itself is the correct, but clearly difficult, approach to this.
I can't agree to a separate device unless libvirt is willing to sign up
for enabling it.

Furthermore, if we take the separate device approach, shouldn't it be
something like vfio-pci-nohotplug, where display is an option only for
this version of the DeviceClass?  Thanks,

Alex

>  - add vfio dma-buf patch.  Right now this can be tested with '-display
>    egl-headless' only.  gtk and spice support is almost ready for merge
>    and should follow soon.
> 
> cheers,
>   Gerd
> 
> Gerd Hoffmann (7):
>   linux-headers: update to 4.16-rc1
>   standard-headers: add drm/drm_fourcc.h
>   ui/pixman: add qemu_drm_format_to_pixman()
>   vfio/common: cleanup in vfio_region_finalize
>   vfio/display: core & wireup
>   vfio/display: adding region support
>   vfio/display: adding dmabuf support
> 
>  hw/vfio/pci.h                                      |   4 +
>  include/hw/vfio/vfio-common.h                      |  22 ++
>  include/standard-headers/drm/drm_fourcc.h          | 411 +++++++++++++++++++++
>  include/standard-headers/linux/input-event-codes.h |   1 +
>  include/standard-headers/linux/input.h             |  11 +
>  include/standard-headers/linux/pci_regs.h          |  30 +-
>  include/standard-headers/linux/virtio_net.h        |  13 +
>  include/ui/qemu-pixman.h                           |   5 +
>  linux-headers/asm-powerpc/kvm.h                    |   2 +
>  linux-headers/asm-powerpc/unistd.h                 |   3 +
>  linux-headers/asm-s390/unistd.h                    | 401 +-------------------
>  linux-headers/asm-s390/unistd_32.h                 | 364 ++++++++++++++++++
>  linux-headers/asm-s390/unistd_64.h                 | 331 +++++++++++++++++
>  linux-headers/asm-x86/kvm_para.h                   |   4 +
>  linux-headers/linux/kvm.h                          |  90 +++++
>  linux-headers/linux/psci.h                         |   3 +
>  linux-headers/linux/vfio.h                         |  72 ++++
>  hw/vfio/common.c                                   |   7 +
>  hw/vfio/display.c                                  | 286 ++++++++++++++
>  hw/vfio/pci.c                                      |  30 ++
>  ui/qemu-pixman.c                                   |  22 ++
>  hw/vfio/Makefile.objs                              |   2 +-
>  scripts/update-linux-headers.sh                    |   7 +
>  23 files changed, 1710 insertions(+), 411 deletions(-)
>  create mode 100644 include/standard-headers/drm/drm_fourcc.h
>  create mode 100644 linux-headers/asm-s390/unistd_32.h
>  create mode 100644 linux-headers/asm-s390/unistd_64.h
>  create mode 100644 hw/vfio/display.c
> 
