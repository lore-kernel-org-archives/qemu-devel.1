Received: from eggs.gnu.org ([2001:4830:134:3::10]:42637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOzv-0005eC-69
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOzq-0004sX-JT
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1duOzq-0004s0-Bh
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:54 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 19 Sep 2017 17:18:49 -0300
Message-Id: <20170919201850.14772-12-ehabkost@redhat.com>
In-Reply-To: <20170919201850.14772-1-ehabkost@redhat.com>
References: <20170919201850.14772-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 11/12] hw/acpi-build: Fix SRAT memory building
 in case of node 0 without RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Currently, Using the fisrt node without memory on the machine makes
QEMU unhappy. With this example command line:
  ... \
  -m 1024M,slots=4,maxmem=32G \
  -numa node,nodeid=0 \
  -numa node,mem=1024M,nodeid=1 \
  -numa node,nodeid=2 \
  -numa node,nodeid=3 \
Guest reports "No NUMA configuration found" and the NUMA topology is
wrong.

This is because when QEMU builds ACPI SRAT, it regards node 0 as the
default node to deal with the memory hole(640K-1M). this means the
node0 must have some memory(>1M), but, actually it can have no
memory.

Fix this problem by cut out the 640K hole in the same way the PCI
4G hole does.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-Id: <1504231805-30957-2-git-send-email-douly.fnst@cn.fujitsu.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/acpi-build.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4d19d91e1b..d72bcdcd49 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2288,6 +2288,9 @@ build_tpm2(GArray *table_data, BIOSLinker *linker)
                  (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, NULL);
 }
 
+#define HOLE_640K_START  (640 * 1024)
+#define HOLE_640K_END   (1024 * 1024)
+
 static void
 build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 {
@@ -2343,17 +2346,30 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     next_base = 0;
     numa_start = table_data->len;
 
-    numamem = acpi_data_push(table_data, sizeof *numamem);
-    build_srat_memory(numamem, 0, 640 * 1024, 0, MEM_AFFINITY_ENABLED);
-    next_base = 1024 * 1024;
     for (i = 1; i < pcms->numa_nodes + 1; ++i) {
         mem_base = next_base;
         mem_len = pcms->node_mem[i - 1];
-        if (i == 1) {
-            mem_len -= 1024 * 1024;
-        }
         next_base = mem_base + mem_len;
 
+        /* Cut out the 640K hole */
+        if (mem_base <= HOLE_640K_START &&
+            next_base > HOLE_640K_START) {
+            mem_len -= next_base - HOLE_640K_START;
+            if (mem_len > 0) {
+                numamem = acpi_data_push(table_data, sizeof *numamem);
+                build_srat_memory(numamem, mem_base, mem_len, i - 1,
+                                  MEM_AFFINITY_ENABLED);
+            }
+
+            /* Check for the rare case: 640K < RAM < 1M */
+            if (next_base <= HOLE_640K_END) {
+                next_base = HOLE_640K_END;
+                continue;
+            }
+            mem_base = HOLE_640K_END;
+            mem_len = next_base - HOLE_640K_END;
+        }
+
         /* Cut out the ACPI_PCI hole */
         if (mem_base <= pcms->below_4g_mem_size &&
             next_base > pcms->below_4g_mem_size) {
-- 
2.13.5
