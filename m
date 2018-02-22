Received: from eggs.gnu.org ([2001:4830:134:3::10]:53889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eoqEf-0005Xx-9H
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:44:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eoqEe-00056m-8G
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:44:29 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 22 Feb 2018 13:42:50 +0100
Message-Id: <1519303376-92875-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1519303376-92875-1-git-send-email-imammedo@redhat.com>
References: <1519303376-92875-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 3/9] acpi: reuse AcpiGenericAddress instead of
 Acpi20GenericAddress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, qemu-arm@nongnu.org

Drop duplicate in form of Acpi20GenericAddress and reuse
AcpiGenericAddress.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/acpi/acpi-defs.h | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 80c8099..9942bc5 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -40,18 +40,6 @@ enum {
     ACPI_FADT_F_LOW_POWER_S0_IDLE_CAPABLE,
 };
 
-/*
- * ACPI 2.0 Generic Address Space definition.
- */
-struct Acpi20GenericAddress {
-    uint8_t  address_space_id;
-    uint8_t  register_bit_width;
-    uint8_t  register_bit_offset;
-    uint8_t  reserved;
-    uint64_t address;
-} QEMU_PACKED;
-typedef struct Acpi20GenericAddress Acpi20GenericAddress;
-
 struct AcpiRsdpDescriptor {        /* Root System Descriptor Pointer */
     uint64_t signature;              /* ACPI signature, contains "RSD PTR " */
     uint8_t  checksum;               /* To make sum of struct == 0 */
@@ -167,7 +155,8 @@ struct AcpiGenericAddress {
     uint8_t space_id;        /* Address space where struct or register exists */
     uint8_t bit_width;       /* Size in bits of given register */
     uint8_t bit_offset;      /* Bit offset within the register */
-    uint8_t access_width;    /* Minimum Access size (ACPI 3.0) */
+    uint8_t access_width;    /* ACPI 3.0: Minimum Access size (ACPI 3.0),
+                                ACPI 2.0: Reserved, Table 5-1 */
     uint64_t address;        /* 64-bit address of struct or register */
 } QEMU_PACKED;
 
@@ -456,7 +445,7 @@ typedef struct AcpiGenericTimerTable AcpiGenericTimerTable;
 struct Acpi20Hpet {
     ACPI_TABLE_HEADER_DEF                    /* ACPI common table header */
     uint32_t           timer_block_id;
-    Acpi20GenericAddress addr;
+    struct AcpiGenericAddress addr;
     uint8_t            hpet_number;
     uint16_t           min_tick;
     uint8_t            page_protect;
-- 
2.7.4
