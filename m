Received: from eggs.gnu.org ([2001:4830:134:3::10]:48078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f1ZnG-000546-Vy
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 11:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f1ZnB-0006S9-WD
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 11:48:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38464 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f1ZnB-0006QL-Qm
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 11:48:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 500DE4068053
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 15:48:41 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 29 Mar 2018 17:48:29 +0200
Message-Id: <20180329154833.566-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/4] RFC: simplify qobject refcount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

This series aims to get rid of the distinction between QObject, that
must use qobject_incref/qobject_decref and its various derived types
that have to use QINCREF/QDECREF. Instead, replace it with
qobject_ref/qobject_unref for all types.

v3: after v2 review with Eric and Paolo
- fix clang ubsan warning when a null pointer is given to QOBJECT.
- add a patch to make qobject_ref() assert on null pointer, and return
  the same pointer, simplifying some code.

v2:
- use the QObjectCommon base approach suggested by Paolo and Eric
- remove need for QEMU_GENERIC

Marc-Andr=C3=A9 Lureau (4):
  qobject: ensure base is at offset 0
  qobject: introduce QObjectCommon
  qobject: replace qobject_incref/QINCREF qobject_decref/QDECREF
  qobject: modify qobject_ref() to assert on NULL and return obj

 scripts/qapi/events.py              |   2 +-
 include/qapi/qmp/qbool.h            |   2 +-
 include/qapi/qmp/qdict.h            |   2 +-
 include/qapi/qmp/qlist.h            |   2 +-
 include/qapi/qmp/qnull.h            |   4 +-
 include/qapi/qmp/qnum.h             |   2 +-
 include/qapi/qmp/qobject.h          |  75 +++++++++++---------
 include/qapi/qmp/qstring.h          |   2 +-
 block.c                             |  82 ++++++++++-----------
 block/blkdebug.c                    |   7 +-
 block/blkverify.c                   |   8 +--
 block/crypto.c                      |   4 +-
 block/gluster.c                     |   4 +-
 block/iscsi.c                       |   2 +-
 block/nbd.c                         |   4 +-
 block/nfs.c                         |   4 +-
 block/null.c                        |   3 +-
 block/nvme.c                        |   3 +-
 block/parallels.c                   |   4 +-
 block/qapi.c                        |   2 +-
 block/qcow.c                        |   8 +--
 block/qcow2.c                       |   8 +--
 block/qed.c                         |   4 +-
 block/quorum.c                      |   4 +-
 block/rbd.c                         |  14 ++--
 block/sheepdog.c                    |  12 ++--
 block/snapshot.c                    |   4 +-
 block/ssh.c                         |   4 +-
 block/vdi.c                         |   2 +-
 block/vhdx.c                        |   4 +-
 block/vpc.c                         |   4 +-
 block/vvfat.c                       |   2 +-
 block/vxhs.c                        |   2 +-
 blockdev.c                          |  16 ++---
 hw/i386/acpi-build.c                |  12 ++--
 hw/ppc/spapr_drc.c                  |   2 +-
 hw/usb/xen-usb.c                    |   4 +-
 migration/migration.c               |   4 +-
 migration/qjson.c                   |   2 +-
 monitor.c                           |  57 +++++++--------
 qapi/qapi-dealloc-visitor.c         |   4 +-
 qapi/qmp-dispatch.c                 |   6 +-
 qapi/qobject-input-visitor.c        |  10 ++-
 qapi/qobject-output-visitor.c       |  11 ++-
 qemu-img.c                          |  18 ++---
 qemu-io.c                           |   6 +-
 qga/main.c                          |  12 ++--
 qmp.c                               |   4 +-
 qobject/json-parser.c               |  10 +--
 qobject/qdict.c                     |  49 +++++--------
 qobject/qjson.c                     |   2 +-
 qobject/qlist.c                     |   4 +-
 qobject/qobject.c                   |  21 ++++--
 qom/object.c                        |  16 ++---
 qom/object_interfaces.c             |   2 +-
 target/ppc/translate_init.c         |   2 +-
 target/s390x/cpu_models.c           |   2 +-
 tests/ahci-test.c                   |   6 +-
 tests/check-qdict.c                 | 106 ++++++++++++++--------------
 tests/check-qjson.c                 |  84 +++++++++++-----------
 tests/check-qlist.c                 |   8 +--
 tests/check-qlit.c                  |  10 +--
 tests/check-qnull.c                 |  10 +--
 tests/check-qnum.c                  |  28 ++++----
 tests/check-qobject.c               |   2 +-
 tests/check-qstring.c               |  10 +--
 tests/cpu-plug-test.c               |   4 +-
 tests/device-introspect-test.c      |  24 +++----
 tests/drive_del-test.c              |   4 +-
 tests/libqos/libqos.c               |   8 +--
 tests/libqos/pci-pc.c               |   2 +-
 tests/libqtest.c                    |  24 +++----
 tests/machine-none-test.c           |   2 +-
 tests/migration-test.c              |  24 +++----
 tests/numa-test.c                   |  16 ++---
 tests/pvpanic-test.c                |   2 +-
 tests/q35-test.c                    |   2 +-
 tests/qmp-test.c                    |  38 +++++-----
 tests/qom-test.c                    |   8 +--
 tests/tco-test.c                    |  12 ++--
 tests/test-char.c                   |   2 +-
 tests/test-keyval.c                 |  82 ++++++++++-----------
 tests/test-netfilter.c              |  26 +++----
 tests/test-qemu-opts.c              |  14 ++--
 tests/test-qga.c                    |  76 ++++++++++----------
 tests/test-qmp-cmds.c               |  24 +++----
 tests/test-qmp-event.c              |   2 +-
 tests/test-qobject-input-visitor.c  |  10 +--
 tests/test-qobject-output-visitor.c |  18 ++---
 tests/test-visitor-serialization.c  |   6 +-
 tests/test-x86-cpuid-compat.c       |  14 ++--
 tests/tmp105-test.c                 |   4 +-
 tests/vhost-user-test.c             |   6 +-
 tests/virtio-net-test.c             |   6 +-
 tests/vmgenid-test.c                |   2 +-
 tests/wdt_ib700-test.c              |  14 ++--
 util/keyval.c                       |  12 ++--
 util/qemu-config.c                  |   4 +-
 docs/devel/qapi-code-gen.txt        |   2 +-
 roms/seabios                        |   2 +-
 scripts/coccinelle/qobject.cocci    |   8 +--
 101 files changed, 665 insertions(+), 669 deletions(-)

--=20
2.17.0.rc1.36.gcedb63ea2f
