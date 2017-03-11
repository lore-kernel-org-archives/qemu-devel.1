Received: from eggs.gnu.org ([2001:4830:134:3::10]:58456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzB-0001js-Vp
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgz7-0002DN-Uf
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cmgz7-0002BY-Lw
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:01 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 11 Mar 2017 17:22:35 +0400
Message-Id: <20170311132256.22951-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/21] WIP: dump: add kaslr support (for after
 2.9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anderson@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

Latest linux kernel enabled kaslr to randomize phys/virt memory
addresses. There has been some effort to support kexec/kdump so that
crash utility can still works in case crashed kernel has kaslr
enabled.

This series aims to provide enough information in qemu dumps so that
crash utility can work with kaslr kernel too, with x86_64 guests (it
hasn't been tested on other archs, help welcome).

Two pieces of informations are necessary: the phys_base (the physical
address where the kernel is loaded) and the kaslr offset. Other useful
informations for debugging are provided in Linux vmcoreinfo too.

There has been discussions to provide those details in early boot,
with ACPI, fw_cfg, virtio-pstore etc, but none has reached a consensus
yet. A possiblity for now is to provide the information when qemu-ga
starts. This has the advantage of working with older guests and may
not be incompatible with future methods (in this case it could ignore
qga info for example). The drawback is that qemu will have to parse
the json stream. For now it stops processing it whem VMDUMP_INFO is
received. It would be wise to introduce a QMP welcome message, so that
qemu would stop immediately processing the stream if the agent doesn't
have the event. Another option is to create a seperate channel...
I welcome other ideas and discussion.

crash upstream doesn't yet parse NUMBER(phys_base). You may pass it to
crash with --machdep phys_base=3D0x.. provided you snooped on qga.

kdump kaslr-dumps should now work with crash out of the box.

A large part of the series has to do with json and the qobject type
system to deal with uint64 values, so that addresses can now be sent
over json. The second halfs adds qga VMDUMP_INFO event, and ELF/kdump
dumping. Depending on the feedback, I will probably split the series,
but for those who would like to try it, help or suggest ideas, here is
the whole thing.

cheers

Marc-Andr=C3=A9 Lureau (21):
  qapi: add info comment for generated types
  pci-host: use more specific type names
  object: fix potential leak in getters
  qobject: add quint type
  qapi: update the qobject visitor to use QUInt
  json: learn to parse uint64 numbers
  object: add uint property setter/getter
  qdev: use int and uint properties
  qdev: use appropriate type
  Use uint property getter/setter where appropriate
  qdict: learn to lookup quint
  test-qga: drop everything until guest-sync
  qga: report error on keyfile dump error
  qga: add and populate VMDumpInfo
  qga: register event emit function
  qga: emit VMDUMP_INFO event
  virtio-channel: parse qga stream for VMDUMP_INFO event
  dump: use qga VMDUMP_INFO for ELF dump
  kdump: write vmcoreinfo in header
  scripts/dump-guest-memory.py: fix int128_get64 on recent gcc
  scripts/dump-guest-memory.py: add VMCOREINFO

 qapi/introspect.json                     |   2 +-
 scripts/qapi.py                          |  39 ++++---
 scripts/dump-guest-memory.py             |  66 ++++++++++-
 scripts/qapi-event.py                    |   4 +-
 scripts/qapi-types.py                    |  17 +--
 scripts/qapi-visit.py                    |   3 +-
 include/hw/isa/isa.h                     |   2 +-
 include/hw/qdev-core.h                   |   5 +-
 include/hw/qdev-properties.h             |  59 ++++++----
 include/qapi/qmp/qdict.h                 |   2 +
 include/qapi/qmp/quint.h                 |  25 +++++
 include/qapi/qmp/types.h                 |   1 +
 include/qom/object.h                     |  23 ++++
 include/sysemu/dump-info.h               |  15 +++
 include/sysemu/dump.h                    |   2 +
 qga/guest-agent-core.h                   |   2 +
 block/qapi.c                             |   5 +
 dump.c                                   | 184 +++++++++++++++++++++++++=
+++++-
 hw/acpi/memory_hotplug.c                 |  10 +-
 hw/acpi/nvdimm.c                         |  10 +-
 hw/acpi/pcihp.c                          |   6 +-
 hw/arm/aspeed.c                          |   4 +-
 hw/arm/bcm2835_peripherals.c             |   9 +-
 hw/arm/raspi.c                           |   4 +-
 hw/block/fdc.c                           |  54 ++++-----
 hw/char/virtio-console.c                 |  53 +++++++++
 hw/core/platform-bus.c                   |   2 +-
 hw/core/qdev-properties.c                |   8 +-
 hw/core/qdev.c                           |   8 +-
 hw/i386/acpi-build.c                     |  70 ++++++------
 hw/i386/pc.c                             |   6 +-
 hw/intc/arm_gicv3_common.c               |   2 +-
 hw/mem/pc-dimm.c                         |   5 +-
 hw/misc/auxbus.c                         |   2 +-
 hw/misc/pvpanic.c                        |   2 +-
 hw/net/e1000e.c                          |  14 +--
 hw/pci-host/gpex.c                       |   2 +-
 hw/pci-host/piix.c                       |   8 +-
 hw/pci-host/q35.c                        |  12 +-
 hw/pci-host/xilinx-pcie.c                |   2 +-
 hw/ppc/pnv_core.c                        |   2 +-
 hw/ppc/spapr.c                           |   8 +-
 numa.c                                   |   6 +-
 qapi/qobject-input-visitor.c             |  30 ++++-
 qapi/qobject-output-visitor.c            |   3 +-
 qga/channel-posix.c                      |  11 ++
 qga/main.c                               | 162 +++++++++++++++++++++++++=
+-
 qobject/json-lexer.c                     |   4 +
 qobject/json-parser.c                    |  19 +++-
 qobject/qdict.c                          |  37 ++++++-
 qobject/qjson.c                          |   8 ++
 qobject/qobject.c                        |   1 +
 qobject/quint.c                          |  58 ++++++++++
 qom/object.c                             |  38 ++++++-
 target/i386/cpu.c                        |   6 +-
 tests/check-qdict.c                      |  31 ++++++
 tests/check-qint.c                       |  59 ++++++++++
 tests/check-qjson.c                      |  28 +++++
 tests/test-qga.c                         |  27 +++--
 tests/test-qobject-input-visitor.c       |  15 +++
 tests/test-qobject-output-visitor.c      |  19 +++-
 ui/console.c                             |   4 +-
 util/qemu-option.c                       |   6 +
 xen-hvm.c                                |   6 +-
 Makefile                                 |   7 +-
 qga/Makefile.objs                        |   1 +
 qga/qapi-schema.json                     |  15 +++
 qobject/Makefile.objs                    |   2 +-
 tests/qapi-schema/comments.out           |   2 +-
 tests/qapi-schema/empty.out              |   2 +-
 tests/qapi-schema/event-case.out         |   2 +-
 tests/qapi-schema/ident-with-escape.out  |   2 +-
 tests/qapi-schema/include-relpath.out    |   2 +-
 tests/qapi-schema/include-repetition.out |   2 +-
 tests/qapi-schema/include-simple.out     |   2 +-
 tests/qapi-schema/indented-expr.out      |   2 +-
 tests/qapi-schema/qapi-schema-test.out   |   2 +-
 77 files changed, 1153 insertions(+), 227 deletions(-)
 create mode 100644 include/qapi/qmp/quint.h
 create mode 100644 include/sysemu/dump-info.h
 create mode 100644 qobject/quint.c

--=20
2.12.0.191.gc5d8de91d
