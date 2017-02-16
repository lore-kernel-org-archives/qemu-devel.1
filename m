Received: from eggs.gnu.org ([2001:4830:134:3::10]:48807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceFOk-00011m-QB
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:18:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceFOh-0000Of-K6
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:18:34 -0500
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:35184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1ceFOh-0000OL-FQ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:18:31 -0500
Received: by mail-ot0-x233.google.com with SMTP id 45so5257264otd.2
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 22:18:31 -0800 (PST)
From: ben@skyportsystems.com
Date: Wed, 15 Feb 2017 22:18:10 -0800
Message-Id: <cover.1487224954.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v7 0/8] Add support for VM Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, Ben Warren <ben@skyportsystems.com>

From: Ben Warren <ben@skyportsystems.com>

This patch set adds support for passing a GUID to Windows guests.  It is a
re-implementation of previous patch sets written by Igor Mammedov et al, but
this time passing the GUID data as a fw_cfg blob.

This patch set has dependencies on new guest functionality, in particular the
support for a new linker-loader command and the ability to write back data
to QEMU over a DMA link.  Work is in flight in both SeaBIOS and OVMF to support this.

v6->v7:
    - Rebased to top of tree.
    - Added 'src_offset' field to "write pointer" command
    - Reworked unit tests based on feedback
    - various minor changes based on feedback
    - Added entries to MAINTAINERS file

v5->v6:
    - Rebased to top of tree.
    - Changed device from sysbus to a simple device.  This removed the need for
      adding dynamic sysbus support to pc_piix boards.
    - Removed patch that introduced QWORD patching of AML.
    - Removed ability to set GUID via QMP/HMP.
    - Improved comments/documentation in code.

v4->v5:
    - Added significantly more detail to the documentation.
    - Replaced the previously-implemented linker-loader command with a new one:
      "write pointer".  This allows writing the guest address of a fw_cfg blob back
      to an arbitrary offset in a writeable fw_cfg file visible to QEMU.  This will
      require support in SeaBIOS and OVMF (ongoing).
    - Fixed endianness issues throughout.
    - Several styling cleanups.

v3->v4:
    - Rebased to top of tree.
    - Re-added document patch that was accidentally dropped from the last revision.
    - Added VMState functionality so that VGIA is restored properly.
    - Added Unit tests
v2->v3:
    - Added second writeable fw_cfg for storing the VM Generaiton ID
      address.  This uses a new linker-loader command for instructing the
      guest to write back the allocated address.  A patch for SeaBIOS has been
      submitted (https://www.seabios.org/pipermail/seabios/2017-January/011079.html)
      and the resulting binary will need to be pulled into QEMU once accepted.
    - Setting VM Generation ID by command line or qmp/hmp now accepts an "auto"
      value, whereby QEMU generates a random GUID.
    - Incorporated review comments from v2 mainly around code styling and AML syntax
    - Changed to use the E05 ACPI event instead of E00
v1->v2:
    - Removed "changed" boolean parameter as it is unneeded
    - Added ACPI Notify logic
    - Style changes to pass checkpatch.pl
    - Added support for dynamic sysbus to pc_piix boards


Ben Warren (7):
  linker-loader: Add new 'write pointer' command
  docs: VM Generation ID device description
  ACPI: Add vmgenid blob storage to the build tables
  ACPI: Add Virtual Machine Generation ID support
  tests: Move reusable ACPI code into a utility file
  tests: Add unit tests for the VM Generation ID feature
  MAINTAINERS: Add VM Generation ID entry

Igor Mammedov (1):
  qmp/hmp: add query-vm-generation-id and 'info vm-generation-id'
    commands

 MAINTAINERS                          |   8 ++
 default-configs/i386-softmmu.mak     |   1 +
 default-configs/x86_64-softmmu.mak   |   1 +
 docs/specs/vmgenid.txt               | 245 +++++++++++++++++++++++++++++++++
 hmp-commands-info.hx                 |  14 ++
 hmp.c                                |   9 ++
 hmp.h                                |   1 +
 hw/acpi/Makefile.objs                |   1 +
 hw/acpi/aml-build.c                  |   2 +
 hw/acpi/bios-linker-loader.c         |  66 ++++++++-
 hw/acpi/vmgenid.c                    | 255 +++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c                 |  16 +++
 include/hw/acpi/acpi_dev_interface.h |   1 +
 include/hw/acpi/aml-build.h          |   1 +
 include/hw/acpi/bios-linker-loader.h |   7 +
 include/hw/acpi/vmgenid.h            |  35 +++++
 qapi-schema.json                     |  20 +++
 stubs/Makefile.objs                  |   1 +
 stubs/vmgenid.c                      |   9 ++
 tests/Makefile.include               |   4 +-
 tests/acpi-utils.c                   |  65 +++++++++
 tests/acpi-utils.h                   |  94 +++++++++++++
 tests/bios-tables-test.c             | 132 +++---------------
 tests/vmgenid-test.c                 | 174 ++++++++++++++++++++++++
 24 files changed, 1041 insertions(+), 121 deletions(-)
 create mode 100644 docs/specs/vmgenid.txt
 create mode 100644 hw/acpi/vmgenid.c
 create mode 100644 include/hw/acpi/vmgenid.h
 create mode 100644 stubs/vmgenid.c
 create mode 100644 tests/acpi-utils.c
 create mode 100644 tests/acpi-utils.h
 create mode 100644 tests/vmgenid-test.c

-- 
2.7.4
