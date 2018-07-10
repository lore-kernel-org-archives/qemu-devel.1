Received: from eggs.gnu.org ([2001:4830:134:3::10]:50564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1fcoTi-0003O4-4J
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1fcoTf-00042r-2i
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:58:34 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:55231
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1fcoTe-00042X-Jq
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:58:30 -0400
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Tue, 10 Jul 2018 16:58:01 +0800
Message-ID: <20180710085802.30386-1-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 1/2] hw/acpi-build: Add a check for
 memory-less NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, ehabkost@redhat.com, indou.takao@jp.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

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
---
Note to maintainer: update ACPI tables test blobs on commit.
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
2.14.3
