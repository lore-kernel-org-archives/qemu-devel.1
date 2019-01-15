Received: from eggs.gnu.org ([209.51.188.92]:33870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjR23-0001eU-M2
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjR21-0006TI-Jk
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:53:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gjR21-0006Rf-D1
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:53:37 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 15 Jan 2019 16:40:59 +0100
Message-Id: <1547566866-129386-8-git-send-email-imammedo@redhat.com>
In-Reply-To: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 07/14] tests: acpi: skip FACS table if board
 uses hw reduced ACPI profile
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

If FADT has HW_REDUCED_ACPI flag set, do not attempt to fetch
FACS as it's not provided by the board.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/bios-tables-test.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 0f04a0a..8887319 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -146,9 +146,13 @@ static void test_acpi_fadt_table(test_data *data)
     g_assert(compare_signature(&table, "FACP"));
 
     /* Since DSDT/FACS isn't in RSDT, add them to ASL test list manually */
-    acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
-                     fadt_aml + 36 /* FIRMWARE_CTRL */, "FACS", false);
-    g_array_append_val(data->tables, table);
+    memcpy(&val, fadt_aml + 112 /* Flags */, 4);
+    val = le32_to_cpu(val);
+    if (!(val & 1UL << 20 /* HW_REDUCED_ACPI */)) {
+        acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
+                         fadt_aml + 36 /* FIRMWARE_CTRL */, "FACS", false);
+        g_array_append_val(data->tables, table);
+    }
 
     memcpy(&val, fadt_aml + dsdt_offset, 4);
     if (!val) {
-- 
2.7.4
