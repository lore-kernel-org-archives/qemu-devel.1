Received: from eggs.gnu.org ([2001:4830:134:3::10]:37385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWX-0002UE-3f
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWW-0004A0-05
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:01 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQYWV-00045M-PW
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:59 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWL-0001OR-7h
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:53:49 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 11:53:31 +0000
Message-Id: <1483962824-29185-9-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
References: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 08/21] hw/arm/virt-acpi-build: gtdt: improve
 flag naming
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrew Jones <drjones@redhat.com>

Also remove all unused flags.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Message-id: 20170102200153.28864-4-drjones@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/acpi/acpi-defs.h | 17 ++---------------
 hw/arm/virt-acpi-build.c    | 10 +++++-----
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 510f23c..8fe0996 100644
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
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 5071a0b..420cd21 100644
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
-- 
2.7.4
