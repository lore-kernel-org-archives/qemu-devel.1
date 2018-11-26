Received: from eggs.gnu.org ([2001:4830:134:3::10]:48974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRGEM-0006xv-WB
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:43:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRGEI-0006Ik-2z
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:43:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gRGEE-0006EJ-Ir
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:43:08 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0C53307D943
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 12:43:04 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Nov 2018 16:42:39 +0400
Message-Id: <20181126124250.29985-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 00/11] vhost-user-backend &
 vhost-user-input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

This series is based on previously discussed "[PATCH v4 00/29]
vhost-user for input & GPU" and "vhost-user: define conventions for
vhost-user backends" work. The GPU part is left off for now.

This series introduces a "vhost-user-backend": a convenience object
for vhost-user devices, for common command line and initilization
handling. As a simple showcase, a "vhost-user-input-pci" device is
introduced, which can be used with the "contrib: add vhost-user-input"
example. vhost-user-input isn't meant to be installed, discovered or
used by libvirt: no installation is done (no vhost-user JSON file is
provided either).

thanks

Marc-Andr=C3=A9 Lureau (11):
  vhost-user: define conventions for vhost-user backends
  vhost-user: simplify vhost_user_init/vhost_user_cleanup
  libvhost-user: exit by default on VHOST_USER_NONE
  vhost-user: wrap some read/write with retry handling
  Add vhost-user-backend
  vhost-user: split vhost_user_read()
  vhost-user: add vhost_user_input_get_config()
  libvhost-user-glib: export vug_source_new()
  libvhost-user: add vu_queue_unpop()
  Add vhost-user-input-pci
  contrib: add vhost-user-input

 contrib/libvhost-user/libvhost-user-glib.h |   3 +
 contrib/libvhost-user/libvhost-user.h      |  15 +
 hw/virtio/virtio-pci.h                     |  10 +
 include/hw/virtio/vhost-backend.h          |   4 +
 include/hw/virtio/vhost-user-blk.h         |   2 +-
 include/hw/virtio/vhost-user-scsi.h        |   2 +-
 include/hw/virtio/vhost-user.h             |   2 +-
 include/hw/virtio/virtio-input.h           |  14 +
 include/sysemu/vhost-user-backend.h        |  60 ++++
 backends/cryptodev-vhost-user.c            |  18 +-
 backends/vhost-user.c                      | 244 +++++++++++++
 contrib/libvhost-user/libvhost-user-glib.c |  11 +-
 contrib/libvhost-user/libvhost-user.c      |  19 +-
 contrib/vhost-user-input/main.c            | 398 +++++++++++++++++++++
 hw/block/vhost-user-blk.c                  |  22 +-
 hw/input/vhost-user-input.c                | 110 ++++++
 hw/scsi/vhost-user-scsi.c                  |  20 +-
 hw/virtio/vhost-stub.c                     |   4 +-
 hw/virtio/vhost-user.c                     | 118 +++++-
 hw/virtio/virtio-pci.c                     |  22 ++
 net/vhost-user.c                           |  13 +-
 vl.c                                       |   3 +-
 MAINTAINERS                                |   5 +
 Makefile                                   |   3 +
 Makefile.objs                              |   1 +
 backends/Makefile.objs                     |   3 +-
 configure                                  |   3 +
 contrib/vhost-user-input/Makefile.objs     |   1 +
 docs/interop/vhost-user.json               | 219 ++++++++++++
 docs/interop/vhost-user.txt                | 109 +++++-
 hw/input/Makefile.objs                     |   1 +
 qemu-options.hx                            |  20 ++
 32 files changed, 1392 insertions(+), 87 deletions(-)
 create mode 100644 include/sysemu/vhost-user-backend.h
 create mode 100644 backends/vhost-user.c
 create mode 100644 contrib/vhost-user-input/main.c
 create mode 100644 hw/input/vhost-user-input.c
 create mode 100644 contrib/vhost-user-input/Makefile.objs
 create mode 100644 docs/interop/vhost-user.json

--=20
2.20.0.rc1
