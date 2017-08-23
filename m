Received: from eggs.gnu.org ([2001:4830:134:3::10]:43230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYO8-00056w-QO
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYO4-0006Z5-OY
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dkYO4-0006Yk-Du
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:12 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 18:19:37 +0200
Message-Id: <20170823162004.27337-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/27] vhost-user-scsi: code clean-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: changpeng.liu@intel.com, felipe@nutanix.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

While reviewing vhost-user-blk, I realized a lot of code was based on
vhost-user-scsi, and I found a number of improvements could be
made. As a result in this series, I tried to move common glib code in
libvhost-user-glib. (I originally made libvhost-user glib-free, so if
external projects want to play with it, they don't have to depend on
glib, for ex vhost-user-bridge doesn't use glib).

I haven't done extensive testing, I tried to setup a LUN with help
from https://fedoraproject.org/wiki/Scsi-target-utils_Quickstart_Guide, b=
ut
the guest says "Unexpected response from lun 1 while scanning, scan
aborted" (before or after the series). Help welcome!

Thanks

Marc-Andr=C3=A9 Lureau (27):
  glib-compat: move G_SOURCE_CONTINUE/REMOVE there
  libvhost-user: drop dependency on glib
  libvhost-user: improve vu_queue_pop() doc
  vhost-user-scsi: use g_strdup()
  vhost-user-scsi: connect unix socket before allocating
  vhost-user-scsi: code style fixes
  vhost-user-scsi: use glib allocation
  vhost-user-scsi: glib calls that allocate don't return NULL
  vhost-user-scsi: also free the gtree
  vhost-user-scsi: remove vdev_scsi_find_by_vu()
  vhost-user-scsi: simplify unix path cleanup
  vhost-user-scsi: use NULL pointer
  vhost-user-scsi: use glib watch directly
  vhost-user-scsi: assert() in iscsi_add_lun()
  vhost-user-scsi: remove vdev_scsi_add_iscsi_lun()
  vhost-user-scsi: remove VUS_MAX_LUNS
  vhost-user-scsi: remove unimplemented functions
  vhost-user-scsi: rename VUS types
  vhost-user-scsi: avoid use of iscsi_ namespace
  vhost-user-scsi: don't copy iscsi/scsi-lowlevel.h
  vhost-user-scsi: drop extra callback pointer
  vhost-user-scsi: simplify source handling
  vhost-user-scsi: use glib logging
  libvhost-user: add glib source helper
  build-sys: fix libvhost-user.a build
  vhost-user-scsi: use libvhost-user glib helper
  vhost-user-scsi: remove server_sock from VusDev

 contrib/libvhost-user/libvhost-user-glib.h |  32 ++
 contrib/libvhost-user/libvhost-user.h      |   3 +-
 include/glib-compat.h                      |   7 +
 contrib/libvhost-user/libvhost-user-glib.c | 145 +++++++
 contrib/libvhost-user/libvhost-user.c      |  25 +-
 contrib/vhost-user-scsi/vhost-user-scsi.c  | 619 +++++------------------=
------
 Makefile                                   |   3 +-
 Makefile.objs                              |   3 +-
 contrib/libvhost-user/Makefile.objs        |   2 +-
 tests/Makefile.include                     |   2 +-
 10 files changed, 320 insertions(+), 521 deletions(-)
 create mode 100644 contrib/libvhost-user/libvhost-user-glib.h
 create mode 100644 contrib/libvhost-user/libvhost-user-glib.c

--=20
2.14.1.146.gd35faa819
