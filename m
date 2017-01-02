Received: from eggs.gnu.org ([2001:4830:134:3::10]:33152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8o4-0001bX-Ff
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8o3-0003q6-Cj
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:08 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Mon,  2 Jan 2017 21:01:40 +0100
Message-Id: <20170102200153.28864-4-drjones@redhat.com>
In-Reply-To: <20170102200153.28864-1-drjones@redhat.com>
References: <20170102200153.28864-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/16] hw/arm/virt-acpi-build: gtdt: improve
 flag naming
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: imammedo@redhat.com, peter.maydell@linaro.org, zhaoshenglong@huawei.com, shannon.zhao@linaro.org, mst@redhat.com, ehabkost@redhat.com

Also remove all unused flags.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt-acpi-build.c    | 10 +++++-----
 include/hw/acpi/acpi-defs.h | 17 ++---------------
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 0ed406cdd89c..b6b64296f119 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -543,17 +543,17 @@ build_gtdt(GArray *table_data, BIOSLinker *linker)
     gtdt = acpi_data_push(table_data, sizeof *gtdt);
     /* The interrupt values are the same with the device tree when adding 16 */
     gtdt->secure_el1_interrupt = cpu_to_le32(ARCH_TIMER_S_EL1_IRQ + 16);
-    gtdt->secure_el1_flags = cpu_to_le32(ACPI_EDGE_SENSITIVE);
+    gtdt->secure_el1_flags = cpu_to_le32(ACPI_GTDT_INTERRUPT_MODE_EDGE);
 
     gtdt->non_secure_el1_interrupt = cpu_to_le32(ARCH_TIMER_NS_EL1_IRQ + 16);
-    gtdt->non_secure_el1_flags = cpu_to_le32(ACPI_EDGE_SENSITIVE |
-                                             ACPI_GTDT_ALWAYS_ON);
+    gtdt->non_secure_el1_flags = cpu_to_le32(ACPI_GTDT_INTERRUPT_MODE_EDGE |
+                                             ACPI_GTDT_CAP_ALWAYS_ON);
 
     gtdt->virtual_timer_interrupt = cpu_to_le32(ARCH_TIMER_VIRT_IRQ + 16);
-    gtdt->virtual_timer_flags = cpu_to_le32(ACPI_EDGE_SENSITIVE);
+    gtdt->virtual_timer_flags = cpu_to_le32(ACPI_GTDT_INTERRUPT_MODE_EDGE);
 
     gtdt->non_secure_el2_interrupt = cpu_to_le32(ARCH_TIMER_NS_EL2_IRQ + 16);
-    gtdt->non_secure_el2_flags = cpu_to_le32(ACPI_EDGE_SENSITIVE);
+    gtdt->non_secure_el2_flags = cpu_to_le32(ACPI_GTDT_INTERRUPT_MODE_EDGE);
 
     build_header(linker, table_data,
                  (void *)(table_data->data + gtdt_start), "GTDT",
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 510f23c93183..8fe0996e15fb 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -430,21 +430,8 @@ typedef struct AcpiMadtGenericTranslator AcpiMadtGenericTranslator;
 /*
  * Generic Timer Description Table (GTDT)
  */
-
-#define ACPI_GTDT_INTERRUPT_MODE        (1 << 0)
-#define ACPI_GTDT_INTERRUPT_POLARITY    (1 << 1)
-#define ACPI_GTDT_ALWAYS_ON             (1 << 2)
-
-/* Triggering */
-
-#define ACPI_LEVEL_SENSITIVE            ((uint8_t) 0x00)
-#define ACPI_EDGE_SENSITIVE             ((uint8_t) 0x01)
-
-/* Polarity */
-
-#define ACPI_ACTIVE_HIGH                ((uint8_t) 0x00)
-#define ACPI_ACTIVE_LOW                 ((uint8_t) 0x01)
-#define ACPI_ACTIVE_BOTH                ((uint8_t) 0x02)
+#define ACPI_GTDT_INTERRUPT_MODE_EDGE     (1 << 0)
+#define ACPI_GTDT_CAP_ALWAYS_ON           (1 << 2)
 
 struct AcpiGenericTimerTable {
     ACPI_TABLE_HEADER_DEF
-- 
2.9.3
