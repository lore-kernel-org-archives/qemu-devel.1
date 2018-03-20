Received: from eggs.gnu.org ([2001:4830:134:3::10]:50605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7lw-0006Na-QJ
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7lv-0007wf-Ps
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42534 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7lv-0007wH-Jw
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:11 -0400
Date: Tue, 20 Mar 2018 05:17:10 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-8-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 07/50] acpi: add build_append_gas() helper
 for Generic Address Structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Eric Auger <eric.auger@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

it will help to add Generic Address Structure to ACPI tables
without using packed C structures and avoid endianness
issues as API doesn't need an explicit conversion.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/aml-build.h | 20 ++++++++++++++++++++
 hw/acpi/aml-build.c         | 16 ++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 88d0738..8692ccc 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -78,6 +78,15 @@ typedef enum {
 } AmlUpdateRule;
 
 typedef enum {
+    AML_AS_SYSTEM_MEMORY = 0X00,
+    AML_AS_SYSTEM_IO = 0X01,
+    AML_AS_PCI_CONFIG = 0X02,
+    AML_AS_EMBEDDED_CTRL = 0X03,
+    AML_AS_SMBUS = 0X04,
+    AML_AS_FFH = 0X7F,
+} AmlAddressSpace;
+
+typedef enum {
     AML_SYSTEM_MEMORY = 0X00,
     AML_SYSTEM_IO = 0X01,
     AML_PCI_CONFIG = 0X02,
@@ -389,6 +398,17 @@ int
 build_append_named_dword(GArray *array, const char *name_format, ...)
 GCC_FMT_ATTR(2, 3);
 
+void build_append_gas(GArray *table, AmlAddressSpace as,
+                      uint8_t bit_width, uint8_t bit_offset,
+                      uint8_t access_width, uint64_t address);
+
+static inline void
+build_append_gas_from_struct(GArray *table, const struct AcpiGenericAddress *s)
+{
+    build_append_gas(table, s->space_id, s->bit_width, s->bit_offset,
+                     s->access_width, s->address);
+}
+
 void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags);
 
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 36a6cc4..3fef5f6 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -258,6 +258,22 @@ static void build_append_int(GArray *table, uint64_t value)
     }
 }
 
+/* Generic Address Structure (GAS)
+ * ACPI 2.0/3.0: 5.2.3.1 Generic Address Structure
+ * 2.0 compat note:
+ *    @access_width must be 0, see ACPI 2.0:Table 5-1
+ */
+void build_append_gas(GArray *table, AmlAddressSpace as,
+                      uint8_t bit_width, uint8_t bit_offset,
+                      uint8_t access_width, uint64_t address)
+{
+    build_append_int_noprefix(table, as, 1);
+    build_append_int_noprefix(table, bit_width, 1);
+    build_append_int_noprefix(table, bit_offset, 1);
+    build_append_int_noprefix(table, access_width, 1);
+    build_append_int_noprefix(table, address, 8);
+}
+
 /*
  * Build NAME(XXXX, 0x00000000) where 0x00000000 is encoded as a dword,
  * and return the offset to 0x00000000 for runtime patching.
-- 
MST
