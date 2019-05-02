Received: from eggs.gnu.org ([209.51.188.92]:49502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4I-0005Cs-4j
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4H-0002rH-5O
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hMD4G-0002qr-Vz
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:13 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  2 May 2019 16:51:54 +0200
Message-Id: <1556808723-226478-7-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 06/15] tests: acpi: skip FACS table if board
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
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, Andrew Jones <drjones@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Ben Warren <ben@skyportsystems.com>, xuwei5@hisilicon.com, xuwei5@huawei.com, linuxarm@huawei.com

If FADT has HW_REDUCED_ACPI flag set, do not attempt to fetch
FACS as it's not provided by the board.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
---
 tests/bios-tables-test.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index d165a1b..e2fc341 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -147,9 +147,13 @@ static void test_acpi_fadt_table(test_data *data)
     g_assert(compare_signature(&table, "FACP"));
=20
     /* Since DSDT/FACS isn't in RSDT, add them to ASL test list manually=
 */
-    acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
-                     fadt_aml + 36 /* FIRMWARE_CTRL */, 4, "FACS", false=
);
-    g_array_append_val(data->tables, table);
+    memcpy(&val, fadt_aml + 112 /* Flags */, 4);
+    val =3D le32_to_cpu(val);
+    if (!(val & 1UL << 20 /* HW_REDUCED_ACPI */)) {
+        acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
+                         fadt_aml + 36 /* FIRMWARE_CTRL */, 4, "FACS", f=
alse);
+        g_array_append_val(data->tables, table);
+    }
=20
     memcpy(&val, fadt_aml + dsdt_offset, 4);
     val =3D le32_to_cpu(val);
--=20
2.7.4
