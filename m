Received: from eggs.gnu.org ([209.51.188.92]:54142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hJHpY-0004Qc-NH
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hJHpW-0000t4-WE
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:20:56 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hJHpW-0000q2-Q5
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:20:54 -0400
Received: by mail-qk1-f194.google.com with SMTP id c1so10797012qkk.4
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:20:53 -0700 (PDT)
Date: Wed, 24 Apr 2019 09:20:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190424092028-mutt-send-email-mst@kernel.org>
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190423132004.13725-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 00/11] vhost-user for input & GPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Tue, Apr 23, 2019 at 03:19:53PM +0200, Marc-André Lureau wrote:
> Hi,
> 
> vhost-user allows to drive a virtio device in a seperate
> process. After vhost-user-net, we have seen
> vhost-user-{scsi,blk,crypto} added more recently.
> 
> This series, initially proposed ~3 years ago, time flies
> (https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg01905.html)
> contributes with vhost-user-input and vhost-user-gpu.


Pls note asan errors reported by patchew.


> You may start a vhost-user-gpu with virgl rendering in a separate
> process like this:
> 
> $ ./vhost-user-gpu --virgl -s vgpu.sock &
> $ qemu...
>   -chardev socket,id=chr,path=vgpu.sock
>   -device vhost-user-vga,chardev=chr
> 
> v6:
>  - do not install vhost-user-input
>  - install vhost-user-gpu and json file following the spec
>  - fix the build when drm-intel-devel missing
>  - rebase (& resend without already applied patches)
> 
> v5:
>  - remove user-creatable version of vhost-user-backend
>  - remove optinal management of sub-process in vhost-user-backend
>  - removed daemonize/pid code
>  - drop introduction of new input & gpu messages for PCI config space
>    handling, instead use VHOST_USER_PROTOCOL_F_CONFIG
>  - plain mem & udmabuf fallback for 2d rendering
>  - rebased, kconfig-ify, rst-ify
> 
> Marc-André Lureau (11):
>   Add vhost-user-backend
>   Add vhost-user-input-pci
>   libvhost-user: add PROTOCOL_F_CONFIG if {set,get}_config
>   contrib: add vhost-user-input
>   vhost-user: add vhost_user_gpu_set_socket()
>   virtio: add virtio-gpu bswap helpers header
>   util: compile drm.o on Linux
>   contrib: add vhost-user-gpu
>   virtio-gpu: split virtio-gpu, introduce virtio-gpu-base
>   virtio-gpu: split virtio-gpu-pci & virtio-vga
>   hw/display: add vhost-user-vga & gpu-pci
> 
>  contrib/libvhost-user/libvhost-user.h      |    1 +
>  contrib/vhost-user-gpu/drm.h               |   72 ++
>  contrib/vhost-user-gpu/virgl.h             |   25 +
>  contrib/vhost-user-gpu/vugpu.h             |  170 +++
>  hw/display/virtio-vga.h                    |   32 +
>  include/hw/virtio/vhost-backend.h          |    2 +
>  include/hw/virtio/virtio-gpu-bswap.h       |   61 +
>  include/hw/virtio/virtio-gpu-pci.h         |   40 +
>  include/hw/virtio/virtio-gpu.h             |   92 +-
>  include/hw/virtio/virtio-input.h           |   14 +
>  include/sysemu/vhost-user-backend.h        |   57 +
>  backends/vhost-user.c                      |  209 ++++
>  contrib/libvhost-user/libvhost-user.c      |    5 +
>  contrib/vhost-user-gpu/drm.c               |  341 ++++++
>  contrib/vhost-user-gpu/main.c              | 1236 ++++++++++++++++++++
>  contrib/vhost-user-gpu/virgl.c             |  579 +++++++++
>  contrib/vhost-user-input/main.c            |  427 +++++++
>  hw/display/vhost-user-gpu-pci.c            |   51 +
>  hw/display/vhost-user-gpu.c                |  572 +++++++++
>  hw/display/vhost-user-vga.c                |   52 +
>  hw/display/virtio-gpu-3d.c                 |   49 +-
>  hw/display/virtio-gpu-base.c               |  268 +++++
>  hw/display/virtio-gpu-pci.c                |   55 +-
>  hw/display/virtio-gpu.c                    |  415 ++-----
>  hw/display/virtio-vga.c                    |  138 +--
>  hw/input/vhost-user-input.c                |  129 ++
>  hw/virtio/vhost-user-input-pci.c           |   53 +
>  hw/virtio/vhost-user.c                     |   11 +
>  vl.c                                       |    1 +
>  MAINTAINERS                                |   14 +-
>  Makefile                                   |   27 +-
>  Makefile.objs                              |    2 +
>  backends/Makefile.objs                     |    2 +
>  configure                                  |   29 +
>  contrib/vhost-user-gpu/50-qemu-gpu.json.in |    5 +
>  contrib/vhost-user-gpu/Makefile.objs       |   10 +
>  contrib/vhost-user-input/Makefile.objs     |    1 +
>  docs/interop/index.rst                     |    2 +-
>  docs/interop/vhost-user-gpu.rst            |  238 ++++
>  docs/interop/vhost-user.txt                |    9 +
>  hw/display/Kconfig                         |   10 +
>  hw/display/Makefile.objs                   |    5 +-
>  hw/input/Kconfig                           |    5 +
>  hw/input/Makefile.objs                     |    1 +
>  hw/virtio/Makefile.objs                    |    1 +
>  rules.mak                                  |    9 +-
>  util/Makefile.objs                         |    2 +-
>  47 files changed, 5070 insertions(+), 459 deletions(-)
>  create mode 100644 contrib/vhost-user-gpu/drm.h
>  create mode 100644 contrib/vhost-user-gpu/virgl.h
>  create mode 100644 contrib/vhost-user-gpu/vugpu.h
>  create mode 100644 hw/display/virtio-vga.h
>  create mode 100644 include/hw/virtio/virtio-gpu-bswap.h
>  create mode 100644 include/hw/virtio/virtio-gpu-pci.h
>  create mode 100644 include/sysemu/vhost-user-backend.h
>  create mode 100644 backends/vhost-user.c
>  create mode 100644 contrib/vhost-user-gpu/drm.c
>  create mode 100644 contrib/vhost-user-gpu/main.c
>  create mode 100644 contrib/vhost-user-gpu/virgl.c
>  create mode 100644 contrib/vhost-user-input/main.c
>  create mode 100644 hw/display/vhost-user-gpu-pci.c
>  create mode 100644 hw/display/vhost-user-gpu.c
>  create mode 100644 hw/display/vhost-user-vga.c
>  create mode 100644 hw/display/virtio-gpu-base.c
>  create mode 100644 hw/input/vhost-user-input.c
>  create mode 100644 hw/virtio/vhost-user-input-pci.c
>  create mode 100644 contrib/vhost-user-gpu/50-qemu-gpu.json.in
>  create mode 100644 contrib/vhost-user-gpu/Makefile.objs
>  create mode 100644 contrib/vhost-user-input/Makefile.objs
>  create mode 100644 docs/interop/vhost-user-gpu.rst
> 
> -- 
> 2.21.0.313.ge35b8cb8e2
