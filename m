Received: from eggs.gnu.org ([2001:4830:134:3::10]:33839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cVZ7s-0004tG-EY
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:33:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cVZ7o-0006bw-0r
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:33:16 -0500
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:36066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cVZ7n-0006bI-Qu
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:33:11 -0500
Received: by mail-pg0-x231.google.com with SMTP id t6so42798262pgt.3
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 23:33:09 -0800 (PST)
From: ben@skyportsystems.com
Date: Sun, 22 Jan 2017 23:32:46 -0800
Message-Id: <cover.1485155611.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v3 0/6] Add support for VM Generation ID
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

Ben Warren (4):
  ACPI: Add a function for building named qword entries
  linker-loader: add new 'allocate and return address' cmd
  ACPI: Add Virtual Machine Generation ID support
  PC: Support dynamic sysbus on pc_i440fx

Igor Mammedov (2):
  qmp/hmp: add query-vm-generation-id and 'info vm-generation-id'
    commands
  qmp/hmp: add set-vm-generation-id commands

 default-configs/i386-softmmu.mak     |   1 +
 default-configs/x86_64-softmmu.mak   |   1 +
 hmp-commands-info.hx                 |  13 +++
 hmp-commands.hx                      |  13 +++
 hmp.c                                |  21 ++++
 hmp.h                                |   2 +
 hw/acpi/Makefile.objs                |   1 +
 hw/acpi/aml-build.c                  |  28 +++++
 hw/acpi/bios-linker-loader.c         |  71 +++++++++++-
 hw/acpi/vmgenid.c                    | 214 +++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c                 |   9 ++
 hw/i386/pc_piix.c                    |   1 +
 include/hw/acpi/acpi_dev_interface.h |   1 +
 include/hw/acpi/aml-build.h          |   4 +
 include/hw/acpi/bios-linker-loader.h |   7 ++
 include/hw/acpi/vmgenid.h            |  32 ++++++
 qapi-schema.json                     |  31 +++++
 stubs/Makefile.objs                  |   1 +
 stubs/vmgenid.c                      |  14 +++
 19 files changed, 462 insertions(+), 3 deletions(-)
 create mode 100644 hw/acpi/vmgenid.c
 create mode 100644 include/hw/acpi/vmgenid.h
 create mode 100644 stubs/vmgenid.c

-- 
2.10.1 (Apple Git-78)
