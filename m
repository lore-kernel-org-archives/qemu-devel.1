Received: from eggs.gnu.org ([209.51.188.92]:49478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4F-00058b-E3
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4E-0002od-E3
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hMD4E-0002oJ-8Y
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:10 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  2 May 2019 16:51:53 +0200
Message-Id: <1556808723-226478-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 05/15] tests: acpi: fetch X_DSDT if pointer
 to DSDT is 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, Andrew Jones <drjones@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Ben Warren <ben@skyportsystems.com>, xuwei5@hisilicon.com, xuwei5@huawei.com, linuxarm@huawei.com

that way it would be possible to test a DSDT pointed by
64bit X_DSDT field in FADT.

PS:
it will allow to enable testing arm/virt board, which sets
only newer X_DSDT field.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v4:
 * dropping Reviewed-bys due to acpi_fetch_table() change
   introduced by earlier patch:
   "tests: acpi: make acpi_fetch_table() take size of fetched table point=
er"
v2:
  add 'val =3D le32_to_cpu(val)' even if it doesn't necessary
  it works as reminder that value copied from table is in
  little-endian format (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
---
 tests/bios-tables-test.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index a164d27..d165a1b 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -140,6 +140,9 @@ static void test_acpi_fadt_table(test_data *data)
     AcpiSdtTable table =3D g_array_index(data->tables, typeof(table), 0)=
;
     uint8_t *fadt_aml =3D table.aml;
     uint32_t fadt_len =3D table.aml_len;
+    uint32_t val;
+    int dsdt_offset =3D 40 /* DSDT */;
+    int dsdt_entry_size =3D 4;
=20
     g_assert(compare_signature(&table, "FACP"));
=20
@@ -148,8 +151,14 @@ static void test_acpi_fadt_table(test_data *data)
                      fadt_aml + 36 /* FIRMWARE_CTRL */, 4, "FACS", false=
);
     g_array_append_val(data->tables, table);
=20
+    memcpy(&val, fadt_aml + dsdt_offset, 4);
+    val =3D le32_to_cpu(val);
+    if (!val) {
+        dsdt_offset =3D 140 /* X_DSDT */;
+        dsdt_entry_size =3D 8;
+    }
     acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
-                     fadt_aml + 40 /* DSDT */, 4, "DSDT", true);
+                     fadt_aml + dsdt_offset, dsdt_entry_size, "DSDT", tr=
ue);
     g_array_append_val(data->tables, table);
=20
     memset(fadt_aml + 36, 0, 4); /* sanitize FIRMWARE_CTRL ptr */
--=20
2.7.4
