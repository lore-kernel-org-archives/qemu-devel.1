Received: from eggs.gnu.org ([2001:4830:134:3::10]:42281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1entk5-00019X-Jk
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 17:17:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1entk1-0007zx-It
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 17:17:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1entk1-0007zd-9y
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 17:16:57 -0500
Date: Mon, 19 Feb 2018 15:16:49 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180219151649.13a197f9@w520.home>
In-Reply-To: <20180219111458.25983-1-kraxel@redhat.com>
References: <20180219111458.25983-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/7] vfio: add display support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>

On Mon, 19 Feb 2018 12:14:51 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> This series adds support for a vgpu display to the qemu vfio code.
> For now only regions are supported, dmabufs will follow later.
> 
> This version adds a patch to allow devices disable hotplugging, which
> will be used by vfio display support.  Also fixed issues Alex found in
> review.

Looks ok to me, if this is to go through my tree I'll need a qdev ack
for 4/7.  If you want to go a different route, for 5-7:

Acked-by: Alex Williamson <alex.williamson@redhat.com>

I'm still a bit confused though, what's preventing us from adding
dmabuf support now?  It's strange to provide the implementation for the
proprietary, unavailable vendor driver implementation first.  Is GVT-g
broken, lagging?  Thanks,

Alex


> Gerd Hoffmann (7):
>   linux-headers: update to 4.16-rc1
>   standard-headers: add drm/drm_fourcc.h
>   ui/pixman: add qemu_drm_format_to_pixman()
>   qdev: add hotpluggable to DeviceState
>   vfio/common: cleanup in vfio_region_finalize
>   vfio/display: core & wireup
>   vfio/display: adding region support
> 
>  hw/vfio/pci.h                                      |   4 +
>  include/hw/qdev-core.h                             |   1 +
>  include/hw/vfio/vfio-common.h                      |   8 +
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
>  hw/core/qdev.c                                     |   5 +-
>  hw/vfio/common.c                                   |   7 +
>  hw/vfio/display.c                                  | 152 ++++++++
>  hw/vfio/pci.c                                      |   9 +
>  ui/qemu-pixman.c                                   |  22 ++
>  hw/vfio/Makefile.objs                              |   2 +-
>  scripts/update-linux-headers.sh                    |   7 +
>  25 files changed, 1545 insertions(+), 413 deletions(-)
>  create mode 100644 include/standard-headers/drm/drm_fourcc.h
>  create mode 100644 linux-headers/asm-s390/unistd_32.h
>  create mode 100644 linux-headers/asm-s390/unistd_64.h
>  create mode 100644 hw/vfio/display.c
> 
