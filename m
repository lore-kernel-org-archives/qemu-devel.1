Received: from eggs.gnu.org ([2001:4830:134:3::10]:50779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eydyS-0007r3-Ok
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eydyN-0000Fs-0o
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:40:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54904 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eydyM-0000F8-Ss
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:40:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DFAE412A023
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 13:40:10 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 14:40:02 +0100
Message-Id: <20180321134005.8822-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] RFC: simplify qobject refcount
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

Marc-Andr=C3=A9 Lureau (3):
  compiler: extend QEMU_GENERIC to handle more arguments
  qobject: assume base of a qobject is at offset 0
  qobject: replace qobject_incref/QINCREF qobject_decref/QDECREF

 scripts/qapi/events.py              |   2 +-
 include/qapi/qmp/qnull.h            |   2 +-
 include/qapi/qmp/qobject.h          |  70 +++++++++++++------
 include/qemu/compiler.h             |  23 +++++--
 block.c                             |  78 +++++++++++-----------
 block/blkdebug.c                    |   4 +-
 block/blkverify.c                   |   4 +-
 block/crypto.c                      |   4 +-
 block/gluster.c                     |   4 +-
 block/iscsi.c                       |   2 +-
 block/nbd.c                         |   4 +-
 block/nfs.c                         |   4 +-
 block/null.c                        |   2 +-
 block/nvme.c                        |   2 +-
 block/parallels.c                   |   4 +-
 block/qapi.c                        |   2 +-
 block/qcow.c                        |   8 +--
 block/qcow2.c                       |   8 +--
 block/qed.c                         |   4 +-
 block/quorum.c                      |   2 +-
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
 monitor.c                           |  46 ++++++-------
 qapi/qapi-dealloc-visitor.c         |   4 +-
 qapi/qmp-dispatch.c                 |   6 +-
 qapi/qobject-input-visitor.c        |   8 +--
 qapi/qobject-output-visitor.c       |   8 +--
 qemu-img.c                          |  18 ++---
 qemu-io.c                           |   6 +-
 qga/main.c                          |  12 ++--
 qmp.c                               |   4 +-
 qobject/json-parser.c               |  10 +--
 qobject/qdict.c                     |  38 +++++------
 qobject/qjson.c                     |   2 +-
 qobject/qlist.c                     |   4 +-
 qobject/qobject.c                   |  10 ++-
 qom/object.c                        |  16 ++---
 qom/object_interfaces.c             |   2 +-
 target/ppc/translate_init.c         |   2 +-
 target/s390x/cpu_models.c           |   2 +-
 tests/ahci-test.c                   |   6 +-
 tests/check-qdict.c                 | 100 ++++++++++++++--------------
 tests/check-qjson.c                 |  84 +++++++++++------------
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
 tests/qmp-test.c                    |  40 +++++------
 tests/qom-test.c                    |   8 +--
 tests/tco-test.c                    |  12 ++--
 tests/test-char.c                   |   2 +-
 tests/test-keyval.c                 |  82 +++++++++++------------
 tests/test-netfilter.c              |  26 ++++----
 tests/test-qemu-opts.c              |  14 ++--
 tests/test-qga.c                    |  76 ++++++++++-----------
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
 scripts/coccinelle/qobject.cocci    |   8 +--
 96 files changed, 666 insertions(+), 615 deletions(-)

--=20
2.16.2.521.g9aa15f885a
