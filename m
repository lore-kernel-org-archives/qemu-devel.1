Received: from eggs.gnu.org ([209.51.188.92]:47203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJX3T-0003hD-3t
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJX1r-0008EK-57
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:34:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hJX1q-0008Dt-TW
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:34:39 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 25 Apr 2019 07:34:38 +0200
Message-Id: <1556170489-131927-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 02/13] tests: acpi: rename
 acpi_parse_rsdp_table() into acpi_fetch_rsdp_table()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, Andrew Jones <drjones@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Ben Warren <ben@skyportsystems.com>

so name would reflect what the function does

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acpi-utils.h       | 2 +-
 tests/acpi-utils.c       | 2 +-
 tests/bios-tables-test.c | 2 +-
 tests/vmgenid-test.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index 8c68201..75f78f2 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -46,7 +46,7 @@ typedef struct {
=20
 uint8_t acpi_calc_checksum(const uint8_t *data, int len);
 uint32_t acpi_find_rsdp_address(QTestState *qts);
-void acpi_parse_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp=
_table);
+void acpi_fetch_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp=
_table);
 void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
                       const uint8_t *addr_ptr, const char *sig,
                       bool verify_checksum);
diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
index 9a6d1d3..2dd4fe0 100644
--- a/tests/acpi-utils.c
+++ b/tests/acpi-utils.c
@@ -51,7 +51,7 @@ uint32_t acpi_find_rsdp_address(QTestState *qts)
     return off;
 }
=20
-void acpi_parse_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp=
_table)
+void acpi_fetch_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp=
_table)
 {
     uint8_t revision;
=20
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 24bd102..2ee044c 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -89,7 +89,7 @@ static void test_acpi_rsdp_table(test_data *data)
     uint8_t *rsdp_table =3D data->rsdp_table, revision;
     uint32_t addr =3D data->rsdp_addr;
=20
-    acpi_parse_rsdp_table(data->qts, addr, rsdp_table);
+    acpi_fetch_rsdp_table(data->qts, addr, rsdp_table);
     revision =3D rsdp_table[15 /* Revision offset */];
=20
     switch (revision) {
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index ae38ee5..f400184 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -40,7 +40,7 @@ static uint32_t acpi_find_vgia(QTestState *qts)
     g_assert_cmphex(rsdp_offset, <, RSDP_ADDR_INVALID);
=20
=20
-    acpi_parse_rsdp_table(qts, rsdp_offset, rsdp_table);
+    acpi_fetch_rsdp_table(qts, rsdp_offset, rsdp_table);
     acpi_fetch_table(qts, &rsdt, &rsdt_len, &rsdp_table[16 /* RsdtAddres=
s */],
                      "RSDT", true);
=20
--=20
2.7.4
