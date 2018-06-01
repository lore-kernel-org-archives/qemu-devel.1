Received: from eggs.gnu.org ([2001:4830:134:3::10]:39121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fOmuA-0002yg-Hf
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fOmu7-0007jD-Cb
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60148 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fOmu7-0007it-5r
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B46FF805A531
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 16:27:50 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  1 Jun 2018 18:27:37 +0200
Message-Id: <20180601162749.27406-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v2 00/12] vhost-user for input & GPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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

$ ./vhost-user-gpu -s vgpu.sock &
$ qemu...
  -chardev socket,id=3Dchr,path=3Dvgpu.sock
  -object vhost-user-backend,id=3Dvug,chardev=3Dchr
  -device virtio-vga,virgl=3Dtrue,vhost-user=3Dvug

You may also specify the backend command and the arguments as part of
vhost-user-backend qemu arguments. For example, to start a
vhost-user-input backend on input device /dev/input/event19:

-object vhost-user-backend,id=3Dvuid,cmd=3D"vhost-user-input /dev/input/e=
vent19"
-device virtio-input-host-pci,vhost-user=3Dvuid

Feedback welcome,

RFCv2: (addressing some of Gerd comments digged in the archives)
 - rebased, clean ups, various small fixes, update commit messages
 - teach the vhost-user-backend to take a chardev
 - add vhost-user-input-pci, instead of adding vhost code to virtio-input=
-host-pci

Marc-Andr=C3=A9 Lureau (12):
  chardev: avoid crash if no associated address
  libvhost-user: exit by default on VHOST_USER_NONE
  vhost-user: wrap some read/write with retry handling
  Add vhost-user-backend
  vhost-user: split vhost_user_read()
  vhost-user: add vhost_user_input_get_config()
  libvhost-user: export vug_source_new
  contrib: add vhost-user-input
  Add vhost-input-pci
  vhost-user: add vhost_user_gpu_set_socket()
  Add virtio-gpu vhost-user backend
  contrib: add vhost-user-gpu

 contrib/libvhost-user/libvhost-user-glib.h |   3 +
 contrib/libvhost-user/libvhost-user.h      |   2 +
 contrib/vhost-user-gpu/virgl.h             |  24 +
 contrib/vhost-user-gpu/vugpu.h             | 152 ++++
 hw/virtio/virtio-pci.h                     |  10 +
 include/hw/virtio/vhost-backend.h          |   5 +
 include/hw/virtio/virtio-gpu.h             |   9 +
 include/hw/virtio/virtio-input.h           |  14 +
 include/sysemu/vhost-user-backend.h        |  58 ++
 include/ui/console.h                       |   1 +
 backends/vhost-user.c                      | 330 +++++++
 chardev/char-socket.c                      |   7 +-
 contrib/libvhost-user/libvhost-user-glib.c |  15 +-
 contrib/libvhost-user/libvhost-user.c      |   2 +
 contrib/vhost-user-gpu/main.c              | 953 +++++++++++++++++++++
 contrib/vhost-user-gpu/virgl.c             | 537 ++++++++++++
 contrib/vhost-user-input/main.c            | 358 ++++++++
 hw/display/vhost-gpu.c                     | 290 +++++++
 hw/display/virtio-gpu-3d.c                 |   8 +-
 hw/display/virtio-gpu-pci.c                |   5 +
 hw/display/virtio-gpu.c                    |  77 +-
 hw/display/virtio-vga.c                    |   5 +
 hw/input/vhost-user-input.c                | 124 +++
 hw/virtio/vhost-user.c                     | 112 ++-
 hw/virtio/virtio-pci.c                     |  20 +
 ui/spice-display.c                         |   3 +-
 vl.c                                       |   3 +-
 MAINTAINERS                                |   1 +
 Makefile                                   |   6 +
 Makefile.objs                              |   2 +
 backends/Makefile.objs                     |   4 +
 configure                                  |   5 +
 contrib/vhost-user-gpu/Makefile.objs       |   7 +
 contrib/vhost-user-input/Makefile.objs     |   1 +
 docs/interop/vhost-user.txt                |   6 +
 hw/display/Makefile.objs                   |   2 +-
 hw/input/Makefile.objs                     |   1 +
 37 files changed, 3137 insertions(+), 25 deletions(-)
 create mode 100644 contrib/vhost-user-gpu/virgl.h
 create mode 100644 contrib/vhost-user-gpu/vugpu.h
 create mode 100644 include/sysemu/vhost-user-backend.h
 create mode 100644 backends/vhost-user.c
 create mode 100644 contrib/vhost-user-gpu/main.c
 create mode 100644 contrib/vhost-user-gpu/virgl.c
 create mode 100644 contrib/vhost-user-input/main.c
 create mode 100644 hw/display/vhost-gpu.c
 create mode 100644 hw/input/vhost-user-input.c
 create mode 100644 contrib/vhost-user-gpu/Makefile.objs
 create mode 100644 contrib/vhost-user-input/Makefile.objs


base-commit: c181ddaa176856b3cd2dfd12bbcf25fa9c884a97
--=20
2.17.1.906.g10fd178552
