Received: from eggs.gnu.org ([2001:4830:134:3::10]:57229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erZWt-0007kP-1u
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:30:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erZWo-0002oB-IM
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:30:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43452 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erZWo-0002nJ-8P
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:30:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9133984222
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 01:30:18 +0000 (UTC)
Received: from red.redhat.com (ovpn-122-122.rdu2.redhat.com [10.10.122.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EA759213AEF8
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 01:30:13 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 19:29:37 -0600
Message-Id: <20180302013007.11827-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/30] QAPI patches for 2018-03-01
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 0dc8ae5e8e693737dfe65ba02d0c6eccb58a9c=
67:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180301-v2' in=
to staging (2018-03-01 17:08:16 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-03-01-v2

for you to fetch changes up to 76b2baeed38089c19f69c7117b8eaa64b0e7d227:

  qapi: Don't create useless directory qapi-generated (2018-03-01 19:16:4=
0 -0600)

v2: fix rebase on top of s390x work so that build is successful
(if I do it right, I'm sending just the changed patches)

Again, this series will be a conflict magnet due to content motion
from qapi-schema.json to qapi/misc.json; hopefully, the level of
rebasing required is not too painful

----------------------------------------------------------------
qapi patches for 2018-03-01

- Markus Armbruster: Modularize generated QAPI code

----------------------------------------------------------------
Eric Blake (1):
      watchdog: Consolidate QAPI into single file

Markus Armbruster (29):
      Include qapi/qmp/qerror.h exactly where needed
      qapi: Streamline boilerplate comment generation
      qapi: Generate up-to-date copyright notice
      qapi: Rename variable holding the QAPISchemaGenFOOVisitor
      qapi: New classes QAPIGenC, QAPIGenH, QAPIGenDoc
      qapi: Reduce use of global variables in generators some
      qapi: Turn generators into modules
      qapi-gen: New common driver for code and doc generators
      qapi-gen: Convert from getopt to argparse
      qapi: Touch generated files only when they change
      qapi: Improve include file name reporting in error messages
      qapi/common: Eliminate QAPISchema.exprs
      qapi: Lift error reporting from QAPISchema.__init__() to callers
      qapi: Concentrate QAPISchemaParser.exprs updates in .__init__()
      qapi: Record 'include' directives in parse tree
      qapi: Generate in source order
      qapi: Record 'include' directives in intermediate representation
      qapi: Rename generated qmp-marshal.c to qmp-commands.c
      qapi: Make code-generating visitors use QAPIGen more
      qapi/types qapi/visit: Generate built-in stuff into separate files
      qapi/common: Fix guardname() for funny filenames
      qapi: Generate separate .h, .c for each module
      Include less of the generated modular QAPI headers
      qapi: Empty out qapi-schema.json
      docs/devel/writing-qmp-commands: Update for modular QAPI
      docs: Correct outdated information on QAPI
      qapi: Move qapi-schema.json to qapi/, rename generated files
      Fix up dangling references to qmp-commands.* in comment and doc
      qapi: Don't create useless directory qapi-generated

 docs/devel/qapi-code-gen.txt                       | 124 ++++---
 docs/devel/writing-qmp-commands.txt                |  39 +--
 docs/interop/qmp-intro.txt                         |   3 +-
 docs/xen-save-devices-state.txt                    |   3 +-
 tests/qapi-schema/doc-good.texi                    |   3 +-
 configure                                          |   1 -
 Makefile                                           | 233 ++++++++++----
 Makefile.objs                                      |  80 ++++-
 qapi-schema.json =3D> qapi/misc.json                 | 105 +-----
 qapi/qapi-schema.json                              |  95 ++++++
 qapi/run-state.json                                |   9 +
 include/qapi/visitor.h                             |   2 +-
 scripts/qapi-gen.py                                |  57 ++++
 scripts/qapi/__init__.py                           |   0
 scripts/{qapi-commands.py =3D> qapi/commands.py}     | 155 ++++-----
 scripts/{qapi.py =3D> qapi/common.py}                | 355 +++++++++++++=
--------
 scripts/{qapi2texi.py =3D> qapi/doc.py}              |  92 +++---
 scripts/{qapi-event.py =3D> qapi/events.py}          | 128 +++-----
 scripts/{qapi-introspect.py =3D> qapi/introspect.py} | 123 +++----
 scripts/{qapi-types.py =3D> qapi/types.py}           | 185 ++++-------
 scripts/{qapi-visit.py =3D> qapi/visit.py}           | 189 ++++-------
 crypto/cipherpriv.h                                |   2 +-
 include/block/block.h                              |   2 +-
 include/block/dirty-bitmap.h                       |   2 +-
 include/block/nbd.h                                |   2 +-
 include/chardev/char.h                             |   1 +
 include/crypto/cipher.h                            |   2 +-
 include/crypto/hash.h                              |   2 +-
 include/crypto/hmac.h                              |   2 +-
 include/crypto/secret.h                            |   1 +
 include/crypto/tlscreds.h                          |   1 +
 include/hw/block/block.h                           |   2 +-
 include/hw/block/fdc.h                             |   2 +-
 include/hw/ppc/spapr_drc.h                         |   1 +
 include/hw/qdev-properties.h                       |   2 +
 include/io/dns-resolver.h                          |   1 +
 include/migration/colo.h                           |   2 +-
 include/migration/failover.h                       |   2 +-
 include/migration/global_state.h                   |   1 +
 include/monitor/monitor.h                          |   1 +
 include/net/filter.h                               |   1 +
 include/net/net.h                                  |   2 +-
 include/qapi/clone-visitor.h                       |   1 -
 include/qapi/error.h                               |   2 +-
 include/qapi/qmp/qobject.h                         |   2 +-
 include/qemu/sockets.h                             |   2 +-
 include/qemu/throttle.h                            |   2 +-
 include/qom/cpu.h                                  |   1 +
 include/qom/object.h                               |   2 +-
 include/sysemu/arch_init.h                         |   2 +-
 include/sysemu/balloon.h                           |   2 +-
 include/sysemu/dump.h                              |   2 +
 include/sysemu/hostmem.h                           |   1 +
 include/sysemu/replay.h                            |   2 +
 include/sysemu/sysemu.h                            |   1 +
 include/sysemu/tpm.h                               |   1 +
 include/sysemu/watchdog.h                          |   2 +-
 include/ui/console.h                               |   1 +
 include/ui/input.h                                 |   2 +-
 migration/migration.h                              |   1 +
 migration/ram.h                                    |   2 +-
 net/tap_int.h                                      |   2 +-
 replication.h                                      |   1 +
 ui/vnc.h                                           |   1 +
 vl.c                                               |   8 +-
 arch_init.c                                        |   2 +-
 backends/cryptodev.c                               |   1 -
 backends/hostmem.c                                 |   3 +-
 balloon.c                                          |   2 +-
 block.c                                            |   2 -
 block/block-backend.c                              |   2 +-
 block/crypto.c                                     |   2 +-
 block/iscsi.c                                      |   2 +-
 block/nbd.c                                        |   2 +-
 block/nfs.c                                        |   2 +-
 block/qapi.c                                       |   4 +-
 block/qcow2.c                                      |   4 +-
 block/quorum.c                                     |   2 +-
 block/sheepdog.c                                   |   2 +-
 block/ssh.c                                        |   2 +-
 block/throttle-groups.c                            |   2 +-
 block/write-threshold.c                            |   4 +-
 blockdev-nbd.c                                     |   2 +-
 blockdev.c                                         |   5 +-
 blockjob.c                                         |   2 +-
 chardev/char-fe.c                                  |   2 +-
 chardev/char-ringbuf.c                             |   2 +-
 chardev/char-socket.c                              |   1 +
 chardev/char.c                                     |   4 +-
 cpus.c                                             |   4 +-
 dump.c                                             |   4 +-
 hmp.c                                              |  12 +-
 hw/acpi/core.c                                     |   4 +-
 hw/acpi/cpu.c                                      |   2 +-
 hw/acpi/memory_hotplug.c                           |   2 +-
 hw/acpi/vmgenid.c                                  |   2 +-
 hw/block/block.c                                   |   1 +
 hw/block/hd-geometry.c                             |   1 +
 hw/char/virtio-console.c                           |   2 +-
 hw/core/machine.c                                  |   2 +-
 hw/core/qdev.c                                     |   2 +-
 hw/i386/pc.c                                       |   2 +-
 hw/i386/xen/xen-hvm.c                              |   2 +-
 hw/ipmi/ipmi.c                                     |   2 +-
 hw/mem/nvdimm.c                                    |   1 -
 hw/net/rocker/qmp-norocker.c                       |   2 +-
 hw/net/rocker/rocker.c                             |   2 +-
 hw/net/rocker/rocker_fp.c                          |   2 +-
 hw/net/rocker/rocker_of_dpa.c                      |   2 +-
 hw/net/virtio-net.c                                |   2 +-
 hw/pci/pci-stub.c                                  |   2 +-
 hw/pci/pci.c                                       |   2 +-
 hw/ppc/spapr_rtas.c                                |   1 -
 hw/ppc/spapr_rtc.c                                 |   2 +-
 hw/s390x/s390-skeys.c                              |   2 +-
 hw/timer/mc146818rtc.c                             |   4 +-
 hw/tpm/tpm_emulator.c                              |   1 +
 hw/tpm/tpm_passthrough.c                           |   1 +
 hw/virtio/virtio-balloon.c                         |   2 +-
 hw/watchdog/watchdog.c                             |   4 +-
 io/channel-socket.c                                |   1 +
 io/dns-resolver.c                                  |   1 +
 iothread.c                                         |   2 +-
 migration/colo-failover.c                          |   2 +-
 migration/colo.c                                   |   2 +-
 migration/migration.c                              |   4 +-
 migration/ram.c                                    |   2 +-
 migration/savevm.c                                 |   3 +-
 monitor.c                                          |   8 +-
 net/colo-compare.c                                 |   1 -
 net/filter-buffer.c                                |   2 +-
 net/filter-mirror.c                                |   1 -
 net/filter-rewriter.c                              |   1 -
 net/net.c                                          |   4 +-
 net/vhost-user.c                                   |   2 +-
 numa.c                                             |   4 +-
 qdev-monitor.c                                     |   2 +-
 qemu-img.c                                         |   2 +-
 qga/commands-posix.c                               |   2 +-
 qga/commands-win32.c                               |   2 +-
 qga/commands.c                                     |   2 +-
 qga/main.c                                         |   2 +-
 qmp.c                                              |  18 +-
 qom/object.c                                       |   2 +-
 qom/object_interfaces.c                            |   2 +-
 replay/replay-input.c                              |   1 +
 stubs/tpm.c                                        |   3 +-
 stubs/uuid.c                                       |   2 +-
 stubs/vmgenid.c                                    |   2 +-
 stubs/xen-hvm.c                                    |   2 +-
 target/arm/monitor.c                               |   3 +-
 target/i386/cpu.c                                  |   4 +-
 target/s390x/cpu.c                                 |   3 +-
 target/s390x/kvm.c                                 |   1 -
 target/s390x/sigp.c                                |   1 +
 tests/qmp-test.c                                   |   3 +-
 tests/test-char.c                                  |   2 +-
 tests/{test-qmp-commands.c =3D> test-qmp-cmds.c}     |   2 +-
 tests/test-qmp-event.c                             |   3 +-
 tests/test-qobject-input-visitor.c                 |   8 +-
 tests/test-visitor-serialization.c                 |   1 -
 tpm.c                                              |   5 +-
 trace/qmp.c                                        |   2 +-
 ui/console.c                                       |   2 +-
 ui/gtk.c                                           |   2 +-
 ui/input-legacy.c                                  |   2 +-
 ui/input.c                                         |   2 +-
 ui/spice-core.c                                    |   4 +-
 ui/vnc.c                                           |   4 +-
 util/qemu-config.c                                 |   2 +-
 util/qemu-sockets.c                                |   2 +-
 .gitignore                                         |  80 ++++-
 qga/Makefile.objs                                  |   2 +-
 tests/.gitignore                                   |   9 +-
 tests/Makefile.include                             |  70 ++--
 tests/qapi-schema/comments.out                     |   3 +-
 tests/qapi-schema/doc-bad-section.out              |   5 +-
 tests/qapi-schema/doc-good.out                     |  33 +-
 tests/qapi-schema/empty.out                        |   2 +-
 tests/qapi-schema/event-case.out                   |   3 +-
 tests/qapi-schema/ident-with-escape.out            |   7 +-
 tests/qapi-schema/include-no-file.err              |   2 +-
 tests/qapi-schema/include-relpath.out              |   7 +-
 tests/qapi-schema/include-repetition.out           |  12 +-
 tests/qapi-schema/include-simple.out               |   5 +-
 tests/qapi-schema/indented-expr.out                |   3 +-
 tests/qapi-schema/qapi-schema-test.out             | 321 +++++++++------=
----
 tests/qapi-schema/test-qapi.py                     |  19 +-
 ui/cocoa.m                                         |   2 +-
 189 files changed, 1563 insertions(+), 1356 deletions(-)
 rename qapi-schema.json =3D> qapi/misc.json (95%)
 create mode 100644 qapi/qapi-schema.json
 create mode 100755 scripts/qapi-gen.py
 create mode 100644 scripts/qapi/__init__.py
 rename scripts/{qapi-commands.py =3D> qapi/commands.py} (67%)
 rename scripts/{qapi.py =3D> qapi/common.py} (90%)
 rename scripts/{qapi2texi.py =3D> qapi/doc.py} (78%)
 mode change 100755 =3D> 100644
 rename scripts/{qapi-event.py =3D> qapi/events.py} (61%)
 rename scripts/{qapi-introspect.py =3D> qapi/introspect.py} (71%)
 rename scripts/{qapi-types.py =3D> qapi/types.py} (53%)
 rename scripts/{qapi-visit.py =3D> qapi/visit.py} (64%)
 rename tests/{test-qmp-commands.c =3D> test-qmp-cmds.c} (99%)

--=20
2.14.3
