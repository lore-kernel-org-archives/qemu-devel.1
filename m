Received: from eggs.gnu.org ([2001:4830:134:3::10]:57263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1flWNP-0003xL-QT
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1flWNO-00028u-Nd
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:28:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54316 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1flWNO-00027K-Go
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:28:02 -0400
Date: Fri, 3 Aug 2018 12:27:59 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180803083830.775669-3-mst@redhat.com>
References: <20180803083830.775669-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803083830.775669-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] hw/acpi-build: Add a check for memory-less
 NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Dou Liyang <douly.fnst@cn.fujitsu.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

Currently, Qemu ACPI builder doesn't consider the memory-less NUMA nodes, eg:

  -m 4G,slots=4,maxmem=8G \
  -numa node,nodeid=0 \
  -numa node,nodeid=1,mem=2G \
  -numa node,nodeid=2,mem=2G \
  -numa node,nodeid=3\

Guest Linux will report

  [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0xffffffffffffffff]
  [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x00000000-0x0009ffff]
  [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x00100000-0x7fffffff]
  [    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x80000000-0xbfffffff]
  [    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x100000000-0x13fffffff]
  [    0.000000] ACPI: SRAT: Node 3 PXM 3 [mem 0x140000000-0x13fffffff]
  [    0.000000] ACPI: SRAT: Node 3 PXM 3 [mem 0x140000000-0x33fffffff] hotplug

[mem 0x00000000-0xffffffffffffffff] and [mem 0x140000000-0x13fffffff] are bogus.

Add a check to avoid building srat memory for memory-less NUMA nodes, also update
the test file. Now the info in guest linux will be

  [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x00000000-0x0009ffff]
  [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x00100000-0x7fffffff]
  [    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x80000000-0xbfffffff]
  [    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x100000000-0x13fffffff]
  [    0.000000] ACPI: SRAT: Node 3 PXM 3 [mem 0x140000000-0x33fffffff] hotplug

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9e8350c55d..c584642e4e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2392,9 +2392,12 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
             mem_len = next_base - pcms->below_4g_mem_size;
             next_base = mem_base + mem_len;
         }
-        numamem = acpi_data_push(table_data, sizeof *numamem);
-        build_srat_memory(numamem, mem_base, mem_len, i - 1,
-                          MEM_AFFINITY_ENABLED);
+
+        if (mem_len > 0) {
+            numamem = acpi_data_push(table_data, sizeof *numamem);
+            build_srat_memory(numamem, mem_base, mem_len, i - 1,
+                              MEM_AFFINITY_ENABLED);
+        }
     }
     slots = (table_data->len - numa_start) / sizeof *numamem;
     for (; slots < pcms->numa_nodes + 2; slots++) {
-- 
MST
