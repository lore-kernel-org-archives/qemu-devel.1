Received: from eggs.gnu.org ([2001:4830:134:3::10]:59506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1caIsB-0002XE-G0
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 04:12:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1caIs8-0001qu-B9
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 04:12:39 -0500
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:34233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1caIs8-0001qo-4Z
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 04:12:36 -0500
Received: by mail-pg0-x234.google.com with SMTP id 14so19485119pgg.1
	for <qemu-devel@nongnu.org>; Sun, 05 Feb 2017 01:12:35 -0800 (PST)
From: ben@skyportsystems.com
Date: Sun,  5 Feb 2017 01:11:55 -0800
Message-Id: <cover.1486285434.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v5 00/10] Add support for VM Generation ID
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


Ben Warren (8):
  ACPI: Add a function for building named qword entries
  linker-loader: Add new 'write pointer' command
  docs: VM Generation ID device description
  ACPI: Add vmgenid storage entries to the build tables
  ACPI: Add Virtual Machine Generation ID support
  PC: Support dynamic sysbus on pc_i440fx
  tests: Move reusable ACPI macros into a new header file
  tests: Add unit tests for the VM Generation ID feature

Igor Mammedov (2):
  qmp/hmp: add query-vm-generation-id and 'info vm-generation-id'
    commands
  qmp/hmp: add set-vm-generation-id commands

 default-configs/i386-softmmu.mak     |   1 +
 default-configs/x86_64-softmmu.mak   |   1 +
 docs/specs/vmgenid.txt               | 239 +++++++++++++++++++++++++++++++++++
 hmp-commands-info.hx                 |  13 ++
 hmp-commands.hx                      |  13 ++
 hmp.c                                |  21 +++
 hmp.h                                |   2 +
 hw/acpi/Makefile.objs                |   1 +
 hw/acpi/aml-build.c                  |  39 +++++-
 hw/acpi/bios-linker-loader.c         |  35 +++--
 hw/acpi/nvdimm.c                     |   2 +-
 hw/acpi/vmgenid.c                    | 238 ++++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c             |   4 +-
 hw/i386/acpi-build.c                 |  18 ++-
 hw/i386/pc_piix.c                    |   1 +
 include/hw/acpi/acpi_dev_interface.h |   1 +
 include/hw/acpi/aml-build.h          |   5 +
 include/hw/acpi/bios-linker-loader.h |   3 +-
 include/hw/acpi/vmgenid.h            |  37 ++++++
 qapi-schema.json                     |  31 +++++
 stubs/Makefile.objs                  |   1 +
 stubs/vmgenid.c                      |  14 ++
 tests/Makefile.include               |   2 +
 tests/acpi-utils.h                   |  75 +++++++++++
 tests/bios-tables-test.c             |  72 +----------
 tests/vmgenid-test.c                 | 184 +++++++++++++++++++++++++++
 26 files changed, 962 insertions(+), 91 deletions(-)
 create mode 100644 docs/specs/vmgenid.txt
 create mode 100644 hw/acpi/vmgenid.c
 create mode 100644 include/hw/acpi/vmgenid.h
 create mode 100644 stubs/vmgenid.c
 create mode 100644 tests/acpi-utils.h
 create mode 100644 tests/vmgenid-test.c

-- 
2.7.4
