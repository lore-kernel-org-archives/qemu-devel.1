Received: from eggs.gnu.org ([2001:4830:134:3::10]:44900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d893Y-00053v-Ki
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d893V-0003Mm-IQ
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:36:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d893V-0003Md-8q
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:36:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3671780C1B
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 17:36:12 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 20:35:42 +0300
Message-Id: <20170509173559.31598-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/17] qobject/qapi: add uint type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

In previously sent series "[PATCH 00/21] WIP: dump: add kaslr support
(for after 2.9)", I proposed changes to accept uint64 values from
json, by adding a QUint type. During review, it was suggested to
introduce a QNum type to hold various number representations.

This series introduces the QNum type, adds uint representation to it,
and make uint64 values over json possible (while keeping json negative
int for values >INT64_MAX to unsigned cast compatibility). It also
improves some int vs uint usage for object properties and other
QObject related clean-ups.

The series is on top of http://repo.or.cz/qemu/armbru.git qapi-next

Marc-Andr=C3=A9 Lureau (17):
  qdev: remove PropertyInfo.qtype field
  object: fix potential leak in getters
  tests: remove alt num-int cases
  qapi: merge QInt and QFloat in QNum
  qapi: remove promote_int
  qnum: add uint type
  json: learn to parse uint64 numbers
  qapi: update the qobject visitor to use QUInt
  qnum: fix get_int() with values > INT64_MAX
  object: add uint property setter/getter
  object: use more specific property type names
  qdev: use int and uint properties as appropriate
  qdev: use appropriate getter/setters type
  acpi: fix s3/s4 disabled type
  Use uint property getter/setter where appropriate
  RFC: qdict: add uint
  qobject: move dump_qobject() from block/ to qobject/

 include/qapi/visitor.h                   |   4 +-
 include/qapi/visitor-impl.h              |   2 +-
 scripts/qapi.py                          |  30 ++---
 scripts/qapi-visit.py                    |  12 +-
 include/hw/isa/isa.h                     |   2 +-
 include/hw/qdev-core.h                   |   6 +-
 include/hw/qdev-properties.h             |  72 ++++++------
 include/qapi/qmp/qdict.h                 |  10 +-
 include/qapi/qmp/qfloat.h                |  29 -----
 include/qapi/qmp/qint.h                  |  28 -----
 include/qapi/qmp/qlist.h                 |   4 +-
 include/qapi/qmp/qnum.h                  |  47 ++++++++
 include/qapi/qmp/qobject.h               |   7 ++
 include/qapi/qmp/types.h                 |   3 +-
 include/qapi/qobject-input-visitor.h     |   2 +-
 include/qapi/qobject-output-visitor.h    |   8 +-
 include/qom/object.h                     |  23 ++++
 qapi/qapi-visit-core.c                   |   6 +-
 backends/cryptodev.c                     |   2 +-
 block/blkdebug.c                         |   1 -
 block/nbd.c                              |   1 -
 block/nfs.c                              |   1 -
 block/qapi.c                             |  93 +--------------
 block/quorum.c                           |   1 -
 block/sheepdog.c                         |   1 -
 block/ssh.c                              |   1 -
 block/vvfat.c                            |   1 -
 blockdev.c                               |   5 +-
 hw/acpi/ich9.c                           |  24 ++--
 hw/acpi/memory_hotplug.c                 |  10 +-
 hw/acpi/nvdimm.c                         |  10 +-
 hw/acpi/pcihp.c                          |   7 +-
 hw/acpi/piix4.c                          |   8 +-
 hw/arm/aspeed.c                          |   4 +-
 hw/arm/bcm2835_peripherals.c             |   9 +-
 hw/arm/raspi.c                           |   4 +-
 hw/block/fdc.c                           |  54 ++++-----
 hw/core/platform-bus.c                   |   2 +-
 hw/core/qdev-properties.c                |   8 +-
 hw/core/qdev.c                           |  44 ++++++--
 hw/i386/acpi-build.c                     |  71 ++++++------
 hw/i386/pc.c                             |   6 +-
 hw/i386/xen/xen-hvm.c                    |   6 +-
 hw/intc/arm_gicv3_common.c               |   2 +-
 hw/mem/pc-dimm.c                         |   5 +-
 hw/misc/auxbus.c                         |   2 +-
 hw/misc/pvpanic.c                        |   2 +-
 hw/net/e1000e.c                          |  14 +--
 hw/pci-host/gpex.c                       |   2 +-
 hw/pci-host/piix.c                       |   8 +-
 hw/pci-host/q35.c                        |  12 +-
 hw/pci-host/xilinx-pcie.c                |   2 +-
 hw/ppc/pnv.c                             |   2 +-
 hw/ppc/pnv_core.c                        |   2 +-
 hw/ppc/spapr.c                           |   8 +-
 hw/usb/xen-usb.c                         |   1 -
 monitor.c                                |   2 +-
 net/dump.c                               |   2 +-
 net/filter-buffer.c                      |   2 +-
 numa.c                                   |   6 +-
 qapi/qapi-clone-visitor.c                |   2 +-
 qapi/qapi-dealloc-visitor.c              |   2 +-
 qapi/qobject-input-visitor.c             |  47 ++++----
 qapi/qobject-output-visitor.c            |   7 +-
 qga/commands.c                           |   2 +-
 qga/main.c                               |   1 -
 qobject/json-lexer.c                     |   4 +
 qobject/json-parser.c                    |  42 ++++---
 qobject/qdict.c                          | 106 ++++++++++++++----
 qobject/qfloat.c                         |  62 ----------
 qobject/qint.c                           |  61 ----------
 qobject/qjson.c                          |  37 +-----
 qobject/qlist.c                          |  23 ++++
 qobject/qnum.c                           | 187 +++++++++++++++++++++++++=
++++++
 qobject/qobject.c                        |  22 +++-
 qom/object.c                             |  60 ++++++++--
 target/i386/cpu.c                        |  12 +-
 tests/check-qdict.c                      |  55 +++++++--
 tests/check-qfloat.c                     |  53 ---------
 tests/check-qint.c                       |  87 --------------
 tests/check-qjson.c                      | 131 +++++++++++++++-------
 tests/check-qlist.c                      |  15 +--
 tests/check-qnum.c                       | 182 +++++++++++++++++++++++++=
+++++
 tests/test-keyval.c                      |   4 -
 tests/test-qmp-commands.c                |   6 +-
 tests/test-qmp-event.c                   |   7 +-
 tests/test-qobject-input-visitor.c       |  65 +++--------
 tests/test-qobject-output-visitor.c      |  73 +++++++-----
 tests/test-x86-cpuid-compat.c            |  13 +--
 ui/console.c                             |   4 +-
 ui/spice-core.c                          |   1 -
 ui/vnc-enc-tight.c                       |   1 -
 util/qemu-option.c                       |  20 +---
 MAINTAINERS                              |   3 +-
 qapi/trace-events                        |   2 +-
 qobject/Makefile.objs                    |   2 +-
 scripts/coccinelle/qobject.cocci         |   4 +-
 tests/.gitignore                         |   3 +-
 tests/Makefile.include                   |  13 +--
 tests/qapi-schema/comments.out           |   2 +-
 tests/qapi-schema/doc-good.out           |   2 +-
 tests/qapi-schema/empty.out              |   2 +-
 tests/qapi-schema/event-case.out         |   2 +-
 tests/qapi-schema/ident-with-escape.out  |   2 +-
 tests/qapi-schema/include-relpath.out    |   2 +-
 tests/qapi-schema/include-repetition.out |   2 +-
 tests/qapi-schema/include-simple.out     |   2 +-
 tests/qapi-schema/indented-expr.out      |   2 +-
 tests/qapi-schema/qapi-schema-test.json  |   2 -
 tests/qapi-schema/qapi-schema-test.out   |  10 +-
 110 files changed, 1211 insertions(+), 983 deletions(-)
 delete mode 100644 include/qapi/qmp/qfloat.h
 delete mode 100644 include/qapi/qmp/qint.h
 create mode 100644 include/qapi/qmp/qnum.h
 delete mode 100644 qobject/qfloat.c
 delete mode 100644 qobject/qint.c
 create mode 100644 qobject/qnum.c
 delete mode 100644 tests/check-qfloat.c
 delete mode 100644 tests/check-qint.c
 create mode 100644 tests/check-qnum.c

--=20
2.13.0.rc1.16.gd80b50c3f
