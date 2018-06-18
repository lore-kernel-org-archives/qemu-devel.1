Received: from eggs.gnu.org ([2001:4830:134:3::10]:43733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fUwqc-0001ja-DM
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fUwqW-0004tc-F2
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:17:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60966 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fUwqW-0004rG-AB
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:17:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 643DA401DE60
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 16:17:30 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 18 Jun 2018 18:17:03 +0200
Message-Id: <20180618161729.334-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/26] vhost-user for input & GPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

vhost-user allows to drive a virtio device in a seperate
process. After vhost-user-net, we have seen
vhost-user-{scsi,blk,crypto} added more recently.

This series, initially proposed 2 years ago
(https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg01905.html)
contributes with vhost-user-input and vhost-user-gpu.

Additionally, to factor out common code and ease the usage, a
vhost-user-backend is introduced as an intermediary object between the
backend and the qemu device.

You may start a vhost-user-gpu with virgl rendering in a separate
process like this:

$ ./vhost-user-gpu --virgl -s vgpu.sock &
$ qemu...
  -chardev socket,id=3Dchr,path=3Dvgpu.sock
  -object vhost-user-backend,id=3Dvug,chardev=3Dchr
  -device vhost-user-vga,vhost-user=3Dvug

You may also specify the backend command and the arguments as part of
vhost-user-backend qemu arguments. For example, to start a
vhost-user-input backend on input device /dev/input/event19:

-object vhost-user-backend,id=3Dvuid,cmd=3D"vhost-user-input /dev/input/e=
vent19"
-device virtio-input-host-pci,vhost-user=3Dvuid

The vhost-user-gpu backend requires virgl from git.

Feedback welcome,

v3: deal with most comments from rfcv2 and various improvements
 - "vhost-user-backend: allow to specify binary to execute" as seperate
  patch, not for inclusion since Daniel as concerned about parsing
  shell strings with glib
 - use dmabuf to share 2d rendering result (with intel gem only atm)
 - document the vhost-user-gpu protocol
 - make vhost-user-gpu-pci and vhost-user-vga seperate devices (instead
   of adding vhost-user support to existing devices)
 - allow to specify virgl rendering, and rendernode
 - let's promote out of RFC status :)

RFCv2: (addressing some of Gerd comments digged in the archives)
 - rebased, clean ups, various small fixes, update commit messages
 - teach the vhost-user-backend to take a chardev
 - add vhost-user-input-pci, instead of adding vhost code to virtio-input=
-host-pci

Marc-Andr=C3=A9 Lureau (26):
  chardev: avoid crash if no associated address
  chardev: remove qemu_chr_fe_write_all() counter
  dmabuf: add y0_top, pass it to spice
  vhost-user: simplify vhost_user_init/vhost_user_cleanup
  libvhost-user: exit by default on VHOST_USER_NONE
  vhost-user: wrap some read/write with retry handling
  qio: add qio_channel_command_new_spawn_with_pre_exec()
  Add vhost-user-backend
  HACK: vhost-user-backend: allow to specify binary to execute
  vhost-user: split vhost_user_read()
  vhost-user: add vhost_user_input_get_config()
  libvhost-user: export vug_source_new()
  contrib: add vhost-user-input
  Add vhost-user-input-pci
  vhost-user: add vhost_user_gpu_set_socket()
  vhost-user: add vhost_user_gpu_get_num_capsets()
  virtio: add virtio-gpu bswap helpers header
  util: promote qemu_egl_rendernode_open() to libqemuutil
  contrib: add vhost-user-gpu
  virtio-gpu: remove unused qdev
  virtio-gpu: remove unused config_size
  virtio-gpu: block both 2d and 3d rendering
  virtio-gpu: remove useless 'waiting' field
  virtio-gpu: split virtio-gpu, introduce virtio-gpu-base
  virtio-gpu: split virtio-gpu-pci & virtio-vga
  hw/display: add vhost-user-vga & gpu-pci

 contrib/libvhost-user/libvhost-user-glib.h |    3 +
 contrib/libvhost-user/libvhost-user.h      |    3 +
 contrib/vhost-user-gpu/drm.h               |   63 ++
 contrib/vhost-user-gpu/virgl.h             |   25 +
 contrib/vhost-user-gpu/vugpu.h             |  167 +++
 hw/display/virtio-vga.h                    |   22 +
 hw/virtio/virtio-pci.h                     |   27 +-
 include/hw/virtio/vhost-backend.h          |    6 +
 include/hw/virtio/vhost-user-blk.h         |    2 +-
 include/hw/virtio/vhost-user-scsi.h        |    2 +-
 include/hw/virtio/vhost-user.h             |    2 +-
 include/hw/virtio/virtio-gpu-bswap.h       |   48 +
 include/hw/virtio/virtio-gpu.h             |   90 +-
 include/hw/virtio/virtio-input.h           |   14 +
 include/io/channel-command.h               |   18 +
 include/qemu/drm.h                         |    6 +
 include/sysemu/vhost-user-backend.h        |   60 ++
 include/ui/console.h                       |    1 +
 backends/cryptodev-vhost-user.c            |   18 +-
 backends/vhost-user.c                      |  320 ++++++
 chardev/char-fe.c                          |    6 +-
 chardev/char-socket.c                      |    8 +-
 contrib/libvhost-user/libvhost-user-glib.c |   15 +-
 contrib/libvhost-user/libvhost-user.c      |    3 +-
 contrib/vhost-user-gpu/drm.c               |  189 ++++
 contrib/vhost-user-gpu/main.c              | 1100 ++++++++++++++++++++
 contrib/vhost-user-gpu/virgl.c             |  579 +++++++++++
 contrib/vhost-user-input/main.c            |  364 +++++++
 hw/block/vhost-user-blk.c                  |   22 +-
 hw/display/vhost-user-gpu-pci.c            |   51 +
 hw/display/vhost-user-gpu.c                |  488 +++++++++
 hw/display/vhost-user-vga.c                |   52 +
 hw/display/virtio-gpu-3d.c                 |   70 +-
 hw/display/virtio-gpu-base.c               |  292 ++++++
 hw/display/virtio-gpu-pci.c                |   39 +-
 hw/display/virtio-gpu.c                    |  367 ++-----
 hw/display/virtio-vga.c                    |  127 ++-
 hw/input/vhost-user-input.c                |  110 ++
 hw/scsi/vhost-user-scsi.c                  |   20 +-
 hw/virtio/vhost-stub.c                     |    2 +-
 hw/virtio/vhost-user.c                     |  143 ++-
 hw/virtio/virtio-pci.c                     |   20 +
 io/channel-command.c                       |   33 +-
 net/vhost-user.c                           |    8 +-
 ui/egl-helpers.c                           |   51 +-
 ui/spice-display.c                         |    3 +-
 util/drm.c                                 |   66 ++
 vl.c                                       |    4 +-
 MAINTAINERS                                |   12 +-
 Makefile                                   |    6 +
 Makefile.objs                              |    2 +
 backends/Makefile.objs                     |    3 +-
 configure                                  |   35 +
 contrib/vhost-user-gpu/Makefile.objs       |   10 +
 contrib/vhost-user-input/Makefile.objs     |    1 +
 docs/interop/vhost-user-gpu.txt            |  236 +++++
 docs/interop/vhost-user.txt                |   15 +
 hw/display/Makefile.objs                   |    5 +-
 hw/input/Makefile.objs                     |    1 +
 util/Makefile.objs                         |    1 +
 60 files changed, 4871 insertions(+), 585 deletions(-)
 create mode 100644 contrib/vhost-user-gpu/drm.h
 create mode 100644 contrib/vhost-user-gpu/virgl.h
 create mode 100644 contrib/vhost-user-gpu/vugpu.h
 create mode 100644 hw/display/virtio-vga.h
 create mode 100644 include/hw/virtio/virtio-gpu-bswap.h
 create mode 100644 include/qemu/drm.h
 create mode 100644 include/sysemu/vhost-user-backend.h
 create mode 100644 backends/vhost-user.c
 create mode 100644 contrib/vhost-user-gpu/drm.c
 create mode 100644 contrib/vhost-user-gpu/main.c
 create mode 100644 contrib/vhost-user-gpu/virgl.c
 create mode 100644 contrib/vhost-user-input/main.c
 create mode 100644 hw/display/vhost-user-gpu-pci.c
 create mode 100644 hw/display/vhost-user-gpu.c
 create mode 100644 hw/display/vhost-user-vga.c
 create mode 100644 hw/display/virtio-gpu-base.c
 create mode 100644 hw/input/vhost-user-input.c
 create mode 100644 util/drm.c
 create mode 100644 contrib/vhost-user-gpu/Makefile.objs
 create mode 100644 contrib/vhost-user-input/Makefile.objs
 create mode 100644 docs/interop/vhost-user-gpu.txt

--=20
2.18.0.rc1
