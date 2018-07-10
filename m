Received: from eggs.gnu.org ([2001:4830:134:3::10]:36027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fcg62-00018C-Mh
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fcg5z-0001nR-LV
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:01:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51376 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fcg5z-0001nK-G3
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:01:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB2DC808255B
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 00:01:30 +0000 (UTC)
Date: Tue, 10 Jul 2018 03:01:30 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180710000024.542612-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH hack dontapply v2 0/7] Dynamic _CST generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com

Now that basic support for guest CPU PM is upstream, I started looking
for making it migrateable.  Since a VM can be migrated between different
hosts, PM info needs to change each time with move the VM to a different
host.

This adds infrastructure - based on Load/Unload - to support exactly
that: QEMU generates AML (changing it on migration) and stores it in
reserved memory, OSPM loads _CST from there on demand.

This is a partially functional prototype.

What works:
    loading _CST dynamically and reporting it to OSPM

What doesn't:
    detecting host configuration and generating correct _CST package
    notifying guest about the change to trigger _CST re-evaluation
    disabling mwait/halt exists as appropriate

Michael S. Tsirkin (6):
  acpi: aml: add aml_register()
  acpi: generalize aml_package / aml_varpackage
  acpi: aml_load/aml_unload
  acpi: export acpi_checksum
  acpi: init header without linking
  acpi: aml generation for _CST
  pc: HACK: acpi: tie in _CST object to Processor

 include/hw/acpi/acpi.h      |   2 +
 include/hw/acpi/aml-build.h |  14 ++-
 include/hw/acpi/cst.h       |   8 ++
 include/hw/i386/pc.h        |   5 ++
 hw/acpi/aml-build.c         |  81 ++++++++++++++---
 hw/acpi/core.c              |   2 +-
 hw/acpi/cpu.c               |   5 ++
 hw/acpi/cpu_hotplug.c       |  11 +--
 hw/acpi/cst.c               | 173 ++++++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c    |   2 +-
 hw/i386/acpi-build.c        |  10 ++-
 hw/acpi/Makefile.objs       |   2 +-
 12 files changed, 290 insertions(+), 25 deletions(-)
 create mode 100644 include/hw/acpi/cst.h
 create mode 100644 hw/acpi/cst.c

-- 
MST
