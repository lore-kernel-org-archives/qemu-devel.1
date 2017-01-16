Received: from eggs.gnu.org ([2001:4830:134:3::10]:56869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cTCq4-0002Tf-Ox
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cTCq1-0007HF-Hc
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:21:08 -0500
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:33135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cTCq1-0007GR-Aq
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:21:05 -0500
Received: by mail-pf0-x22d.google.com with SMTP id y143so55498443pfb.0
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:21:05 -0800 (PST)
From: ben@skyportsystems.com
Date: Mon, 16 Jan 2017 11:20:52 -0800
Message-Id: <cover.1484593565.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v2 0/6] Add support for VM Generation ID
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

This is not yet fully functional because the data in the fw_cfg blob is immutable,
so that any changes via the monitor are not seen by the guest.
When that hurdle is passed, unit tests that work will be added.

v1->v2:
	Removed "changed" boolean parameter as it is unneeded
	Added ACPI Notify logic
	Style changes to pass checkpatch.pl
	Added support for dynamic sysbus to pc_piix boards

Ben Warren (4):
  docs: vm generation id device's description
  ACPI: Add a function for building named qword entries
  ACPI: Add Virtual Machine Generation ID support
  PC: Support dynamic sysbus on pc_i440fx

Igor Mammedov (2):
  qmp/hmp: add query-vm-generation-id and 'info vm-generation-id'
    commands
  qmp/hmp: add set-vm-generation-id commands

 default-configs/i386-softmmu.mak   |   1 +
 default-configs/x86_64-softmmu.mak |   1 +
 docs/specs/vmgenid.txt             |  38 +++++++
 hmp-commands-info.hx               |  13 +++
 hmp-commands.hx                    |  13 +++
 hmp.c                              |  21 ++++
 hmp.h                              |   2 +
 hw/acpi/Makefile.objs              |   1 +
 hw/acpi/aml-build.c                |  28 +++++
 hw/acpi/vmgenid.c                  | 208 +++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c               |   5 +
 hw/i386/pc_piix.c                  |   1 +
 hw/misc/Makefile.objs              |   1 +
 include/hw/acpi/aml-build.h        |   4 +
 include/hw/acpi/vmgenid.h          |  24 +++++
 qapi-schema.json                   |  32 ++++++
 stubs/Makefile.objs                |   1 +
 stubs/vmgenid.c                    |  14 +++
 18 files changed, 408 insertions(+)
 create mode 100644 docs/specs/vmgenid.txt
 create mode 100644 hw/acpi/vmgenid.c
 create mode 100644 include/hw/acpi/vmgenid.h
 create mode 100644 stubs/vmgenid.c

-- 
2.7.4
