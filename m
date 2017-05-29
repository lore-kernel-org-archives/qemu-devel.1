Received: from eggs.gnu.org ([2001:4830:134:3::10]:59411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dF8Op-0000K2-83
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:19:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dF8Oo-0006NR-Co
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:19:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dF8Oo-0006NH-65
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:19:06 -0400
Date: Mon, 29 May 2017 03:19:03 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1496017081-24032-13-git-send-email-mst@redhat.com>
References: <1496017081-24032-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496017081-24032-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 12/13] pc: ACPI BIOS: use highest NUMA node for
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Ladi Prosek <lprosek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Ladi Prosek <lprosek@redhat.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
---
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
MST
