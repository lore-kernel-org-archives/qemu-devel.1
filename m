Received: from eggs.gnu.org ([2001:4830:134:3::10]:59593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fpiib-0005YQ-5T
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fpiiX-0001rB-HR
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:27:15 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fpiiW-0001nv-Du
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:27:12 -0400
Received: by mail-wr1-x442.google.com with SMTP id f12-v6so18547157wrv.12
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 16:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
In-Reply-To: <20180713130916.4153-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 15 Aug 2018 01:26:59 +0200
Message-ID: <CAJ+F1CKHrOyD91HLk16eQFjV4JfWpH6poq_Svdihav15kJ62yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/29] vhost-user for input & GPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>

On Fri, Jul 13, 2018 at 3:12 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi,
>
> vhost-user allows to drive a virtio device in a seperate
> process. After vhost-user-net, we have seen
> vhost-user-{scsi,blk,crypto} added more recently.
>
> This series, initially proposed 2 years ago
> (https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg01905.html)
> contributes with vhost-user-input and vhost-user-gpu.
>
> Additionally, to factor out common code and ease the usage, a
> vhost-user-backend is introduced as an intermediary object between the
> backend and the qemu device.
>
> You may start a vhost-user-gpu with virgl rendering in a separate
> process like this:
>
> $ ./vhost-user-gpu --virgl -s vgpu.sock &
> $ qemu...
>   -chardev socket,id=3Dchr,path=3Dvgpu.sock
>   -object vhost-user-backend,id=3Dvug,chardev=3Dchr
>   -device vhost-user-vga,vhost-user=3Dvug
>
> You may also specify the backend command and the arguments as part of
> vhost-user-backend qemu arguments. For example, to start a
> vhost-user-input backend on input device /dev/input/event19:
>
> -object vhost-user-backend,id=3Dvuid,cmd=3D"vhost-user-input /dev/input/e=
vent19"
> -device virtio-input-host-pci,vhost-user=3Dvuid
>
> The vhost-user-gpu backend requires virgl from git.
>
> The libvirt support is on-going work:
> https://github.com/elmarco/libvirt/commits/vhost-user-gpu
>
> The GPU benchmarks are encouraging, giving up to x5 performance on
> Unigine Heaven 4.0.
>
> Feedback welcome,

ping

fwiw, there is a related series for libvirt support: "[libvirt] [RFC
PATCH 00/17] Add vhost-user-gpu support"

thanks

>
> v4:
>  - move qemu_write_pidfile() in util, improve it a bit
>  - add --pid and --fd arguments to vhost-user to help with libvirt suppor=
t
>  - various bug fixes for synchronization, and tearing down
>
> v3: deal with most comments from rfcv2 and various improvements
>  - "vhost-user-backend: allow to specify binary to execute" as seperate
>   patch, not for inclusion since Daniel as concerned about parsing
>   shell strings with glib
>  - use dmabuf to share 2d rendering result (with intel gem only atm)
>  - document the vhost-user-gpu protocol
>  - make vhost-user-gpu-pci and vhost-user-vga seperate devices (instead
>    of adding vhost-user support to existing devices)
>  - allow to specify virgl rendering, and rendernode
>  - let's promote out of RFC status :)
>
> RFCv2: (addressing some of Gerd comments digged in the archives)
>  - rebased, clean ups, various small fixes, update commit messages
>  - teach the vhost-user-backend to take a chardev
>  - add vhost-user-input-pci, instead of adding vhost code to virtio-input=
-host-pci
>
> Marc-Andr=C3=A9 Lureau (29):
>   chardev: avoid crash if no associated address
>   chardev: remove qemu_chr_fe_read_all() counter
>   chardev: unref if underlying chardev has no parent
>   dmabuf: add y0_top, pass it to spice
>   vhost-user: simplify vhost_user_init/vhost_user_cleanup
>   libvhost-user: exit by default on VHOST_USER_NONE
>   vhost-user: wrap some read/write with retry handling
>   Add vhost-user-backend
>   qio: add qio_channel_command_new_spawn_with_pre_exec()
>   HACK: vhost-user-backend: allow to specify binary to execute
>   vhost-user: split vhost_user_read()
>   vhost-user: add vhost_user_input_get_config()
>   libvhost-user: export vug_source_new()
>   contrib: add vhost-user-input
>   Add vhost-user-input-pci
>   vhost-user: add vhost_user_gpu_set_socket()
>   vhost-user: add vhost_user_gpu_get_num_capsets()
>   virtio: add virtio-gpu bswap helpers header
>   util: promote qemu_egl_rendernode_open() to libqemuutil
>   util: add qemu_write_pidfile()
>   util: use fcntl() for qemu_write_pidfile() locking
>   contrib: add vhost-user-gpu
>   virtio-gpu: remove unused qdev
>   virtio-gpu: remove unused config_size
>   virtio-gpu: block both 2d and 3d rendering
>   virtio-gpu: remove useless 'waiting' field
>   virtio-gpu: split virtio-gpu, introduce virtio-gpu-base
>   virtio-gpu: split virtio-gpu-pci & virtio-vga
>   hw/display: add vhost-user-vga & gpu-pci
>
>  contrib/libvhost-user/libvhost-user-glib.h |    3 +
>  contrib/libvhost-user/libvhost-user.h      |    3 +
>  contrib/vhost-user-gpu/drm.h               |   63 ++
>  contrib/vhost-user-gpu/virgl.h             |   25 +
>  contrib/vhost-user-gpu/vugpu.h             |  168 +++
>  hw/display/virtio-vga.h                    |   22 +
>  hw/virtio/virtio-pci.h                     |   27 +-
>  include/hw/virtio/vhost-backend.h          |    6 +
>  include/hw/virtio/vhost-user-blk.h         |    2 +-
>  include/hw/virtio/vhost-user-scsi.h        |    2 +-
>  include/hw/virtio/vhost-user.h             |    2 +-
>  include/hw/virtio/virtio-gpu-bswap.h       |   61 +
>  include/hw/virtio/virtio-gpu.h             |   90 +-
>  include/hw/virtio/virtio-input.h           |   14 +
>  include/io/channel-command.h               |   18 +
>  include/qemu/drm.h                         |    6 +
>  include/qemu/osdep.h                       |    3 +-
>  include/sysemu/vhost-user-backend.h        |   60 +
>  include/ui/console.h                       |    1 +
>  backends/cryptodev-vhost-user.c            |   18 +-
>  backends/vhost-user.c                      |  320 ++++++
>  chardev/char-fe.c                          |   13 +-
>  chardev/char-socket.c                      |    8 +-
>  contrib/libvhost-user/libvhost-user-glib.c |   15 +-
>  contrib/libvhost-user/libvhost-user.c      |    3 +-
>  contrib/vhost-user-gpu/drm.c               |  190 ++++
>  contrib/vhost-user-gpu/main.c              | 1164 ++++++++++++++++++++
>  contrib/vhost-user-gpu/virgl.c             |  579 ++++++++++
>  contrib/vhost-user-input/main.c            |  379 +++++++
>  hw/block/vhost-user-blk.c                  |   22 +-
>  hw/display/vhost-user-gpu-pci.c            |   51 +
>  hw/display/vhost-user-gpu.c                |  524 +++++++++
>  hw/display/vhost-user-vga.c                |   52 +
>  hw/display/virtio-gpu-3d.c                 |   70 +-
>  hw/display/virtio-gpu-base.c               |  292 +++++
>  hw/display/virtio-gpu-pci.c                |   39 +-
>  hw/display/virtio-gpu.c                    |  368 ++-----
>  hw/display/virtio-vga.c                    |  127 ++-
>  hw/input/vhost-user-input.c                |  110 ++
>  hw/scsi/vhost-user-scsi.c                  |   20 +-
>  hw/virtio/vhost-stub.c                     |    4 +-
>  hw/virtio/vhost-user.c                     |  143 ++-
>  hw/virtio/virtio-pci.c                     |   20 +
>  io/channel-command.c                       |   33 +-
>  net/vhost-user.c                           |   13 +-
>  os-posix.c                                 |   24 -
>  os-win32.c                                 |   25 -
>  qga/main.c                                 |   54 +-
>  scsi/qemu-pr-helper.c                      |   40 +-
>  ui/egl-helpers.c                           |   51 +-
>  ui/spice-display.c                         |    3 +-
>  util/drm.c                                 |   66 ++
>  util/oslib-posix.c                         |   39 +
>  util/oslib-win32.c                         |   27 +
>  vl.c                                       |    8 +-
>  MAINTAINERS                                |   15 +-
>  Makefile                                   |    6 +
>  Makefile.objs                              |    2 +
>  backends/Makefile.objs                     |    3 +-
>  configure                                  |   35 +
>  contrib/vhost-user-gpu/Makefile.objs       |   10 +
>  contrib/vhost-user-input/Makefile.objs     |    1 +
>  docs/interop/vhost-user-gpu.rst            |  236 ++++
>  docs/interop/vhost-user.txt                |   24 +
>  hw/display/Makefile.objs                   |    5 +-
>  hw/input/Makefile.objs                     |    1 +
>  qemu-options.hx                            |   24 +
>  util/Makefile.objs                         |    1 +
>  68 files changed, 5130 insertions(+), 723 deletions(-)
>  create mode 100644 contrib/vhost-user-gpu/drm.h
>  create mode 100644 contrib/vhost-user-gpu/virgl.h
>  create mode 100644 contrib/vhost-user-gpu/vugpu.h
>  create mode 100644 hw/display/virtio-vga.h
>  create mode 100644 include/hw/virtio/virtio-gpu-bswap.h
>  create mode 100644 include/qemu/drm.h
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
>  create mode 100644 util/drm.c
>  create mode 100644 contrib/vhost-user-gpu/Makefile.objs
>  create mode 100644 contrib/vhost-user-input/Makefile.objs
>  create mode 100644 docs/interop/vhost-user-gpu.rst
>
> --
> 2.18.0.129.ge3331758f1
>
>


--=20
Marc-Andr=C3=A9 Lureau
