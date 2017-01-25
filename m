Received: from eggs.gnu.org ([2001:4830:134:3::10]:47454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cWCcw-0003hB-4E
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cWCcr-0005M4-Og
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:43:58 -0500
Received: from mail-yb0-x235.google.com ([2607:f8b0:4002:c09::235]:35665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cWCcr-0005Lo-JN
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:43:53 -0500
Received: by mail-yb0-x235.google.com with SMTP id l23so1940085ybj.2
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 17:43:51 -0800 (PST)
From: ben@skyportsystems.com
Date: Tue, 24 Jan 2017 17:43:19 -0800
Message-Id: <cover.1485308342.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v4 0/9] Add support for VM Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>

From: Ben Warren <ben@skyportsystems.com>

This patch set adds support for passing a GUID to Windows guests.  It is a
re-implementation of previous patch sets written by Igor Mammedov et al, but
this time passing the GUID data as a fw_cfg blob.

This patch set has dependencies on new guest functionality, in particular the
support for a new linker-loader command and the ability to write back data
to QEMU over a DMA link.  Work is in flight in both SeaBIOS and OVMF to support this.
The SeaBIOS project is awaiting committing of this patch set before pulling in the
matching patches:
https://www.seabios.org/pipermail/seabios/2017-January/011097.html

v4->v3:
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
  ACPI: Add a function for building named qword entries
  linker-loader: Add new 'allocate and return address' cmd
  docs: VM Generation ID device description
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
 docs/specs/vmgenid.txt               |  40 ++++++
 hmp-commands-info.hx                 |  13 ++
 hmp-commands.hx                      |  13 ++
 hmp.c                                |  21 +++
 hmp.h                                |   2 +
 hw/acpi/Makefile.objs                |   1 +
 hw/acpi/aml-build.c                  |  28 ++++
 hw/acpi/bios-linker-loader.c         |  71 +++++++++-
 hw/acpi/vmgenid.c                    | 244 +++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c                 |   9 ++
 hw/i386/pc_piix.c                    |   1 +
 include/hw/acpi/acpi_dev_interface.h |   1 +
 include/hw/acpi/aml-build.h          |   4 +
 include/hw/acpi/bios-linker-loader.h |   7 +
 include/hw/acpi/vmgenid.h            |  32 +++++
 qapi-schema.json                     |  31 +++++
 stubs/Makefile.objs                  |   1 +
 stubs/vmgenid.c                      |  14 ++
 tests/Makefile.include               |   2 +
 tests/acpi-utils.h                   |  75 +++++++++++
 tests/bios-tables-test.c             |  72 +----------
 tests/vmgenid-test.c                 | 184 ++++++++++++++++++++++++++
 24 files changed, 794 insertions(+), 74 deletions(-)
 create mode 100644 docs/specs/vmgenid.txt
 create mode 100644 hw/acpi/vmgenid.c
 create mode 100644 include/hw/acpi/vmgenid.h
 create mode 100644 stubs/vmgenid.c
 create mode 100644 tests/acpi-utils.h
 create mode 100644 tests/vmgenid-test.c

-- 
2.7.4
