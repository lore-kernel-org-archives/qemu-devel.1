Received: from eggs.gnu.org ([209.51.188.92]:33781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjR1x-0001aW-Qm
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjR1v-0006QR-E0
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:53:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:21647)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gjR1q-0006IQ-TB
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:53:29 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 15 Jan 2019 16:40:57 +0100
Message-Id: <1547566866-129386-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 05/14] tests: acpi: fetch X_DSDT if pointer to
 DSDT is 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

that way it would be possible to test a DSDT pointed by
64bit X_DSDT field in FADT.

PS:
it will allow to enable testing arm/virt board, which sets
only newer X_DSDT field.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/bios-tables-test.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index c28c5c7..0f04a0a 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -140,6 +140,8 @@ static void test_acpi_fadt_table(test_data *data)
     AcpiSdtTable table = g_array_index(data->tables, typeof(table), 0);
     uint8_t *fadt_aml = table.aml;
     uint32_t fadt_len = table.aml_len;
+    uint32_t val;
+    int dsdt_offset = 40 /* DSDT */;
 
     g_assert(compare_signature(&table, "FACP"));
 
@@ -148,8 +150,12 @@ static void test_acpi_fadt_table(test_data *data)
                      fadt_aml + 36 /* FIRMWARE_CTRL */, "FACS", false);
     g_array_append_val(data->tables, table);
 
+    memcpy(&val, fadt_aml + dsdt_offset, 4);
+    if (!val) {
+        dsdt_offset = 140 /* X_DSDT */;
+    }
     acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
-                     fadt_aml + 40 /* DSDT */, "DSDT", true);
+                     fadt_aml + dsdt_offset, "DSDT", true);
     g_array_append_val(data->tables, table);
 
     memset(fadt_aml + 36, 0, 4); /* sanitize FIRMWARE_CTRL ptr */
-- 
2.7.4
