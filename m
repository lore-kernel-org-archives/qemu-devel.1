Received: from eggs.gnu.org ([2001:4830:134:3::10]:60547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dDmsK-0004Q5-2r
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dDmsF-0001Y6-3L
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:08:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dDmsE-0001XE-Sq
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:07:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E86CAC049E32
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 07:07:53 +0000 (UTC)
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 25 May 2017 09:07:47 +0200
Message-Id: <20170525070747.29890-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v2] pc: ACPI BIOS: use highest NUMA node for
 hotplug mem hole SRAT entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com, lersek@redhat.com

For reasons unknown, Windows won't online all memory, both at command
line and hot-plugged later, unless the hotplug mem hole SRAT entry
specifies a node greater than or equal to the ones where memory is
added.

Using the highest node on the machine makes recent versions of Windows
happy.

With this example command line:
  ... \
  -m 1024,slots=4,maxmem=32G \
  -numa node,nodeid=0 \
  -numa node,nodeid=1 \
  -numa node,nodeid=2 \
  -numa node,nodeid=3 \
  -object memory-backend-ram,size=1G,id=mem-mem1 \
  -device pc-dimm,id=dimm-mem1,memdev=mem-mem1,node=1

Windows reports a total of 1G of RAM without this commit and the expected
2G with this commit.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---

note to maintainer:
tests/acpi-test-data need to be updated due to change in SRAT table

 hw/i386/acpi-build.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index afcadac..82bd44f 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2404,14 +2404,17 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     }
 
     /*
-     * Entry is required for Windows to enable memory hotplug in OS.
+     * Entry is required for Windows to enable memory hotplug in OS
+     * and for Linux to enable SWIOTLB when booted with less than
+     * 4G of RAM. Windows works better if the entry sets proximity
+     * to the highest NUMA node in the machine.
      * Memory devices may override proximity set by this entry,
      * providing _PXM method if necessary.
      */
     if (hotplugabble_address_space_size) {
         numamem = acpi_data_push(table_data, sizeof *numamem);
         build_srat_memory(numamem, pcms->hotplug_memory.base,
-                          hotplugabble_address_space_size, 0,
+                          hotplugabble_address_space_size, pcms->numa_nodes - 1,
                           MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
     }
 
-- 
2.9.3
