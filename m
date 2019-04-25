Received: from eggs.gnu.org ([209.51.188.92]:47203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJX3R-0003hD-Cx
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJX1t-0008Gl-E7
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:34:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hJX1t-0008G9-8Z
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:34:41 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 25 Apr 2019 07:34:39 +0200
Message-Id: <1556170489-131927-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 03/13] tests: acpi: make pointer to RSDP
 64bit
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

In case of UEFI, RSDP doesn't have to be located in lowmem,
it could be placed at any address. Make sure that test won't
break if it is placed above the first 4Gb of address space.

PS:
While at it cleanup some local variables as we don't really
need them.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2:
  - s/In case of UEFI/In case of UEFI,/ (Laszlo Ersek <lersek@redhat.com>=
)
---
 tests/bios-tables-test.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 2ee044c..c29dcf4 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -26,7 +26,7 @@
 typedef struct {
     const char *machine;
     const char *variant;
-    uint32_t rsdp_addr;
+    uint64_t rsdp_addr;
     uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
     GArray *tables;
     uint32_t smbios_ep_addr;
@@ -86,13 +86,11 @@ static void test_acpi_rsdp_address(test_data *data)
=20
 static void test_acpi_rsdp_table(test_data *data)
 {
-    uint8_t *rsdp_table =3D data->rsdp_table, revision;
-    uint32_t addr =3D data->rsdp_addr;
+    uint8_t *rsdp_table =3D data->rsdp_table;
=20
-    acpi_fetch_rsdp_table(data->qts, addr, rsdp_table);
-    revision =3D rsdp_table[15 /* Revision offset */];
+    acpi_fetch_rsdp_table(data->qts, data->rsdp_addr, rsdp_table);
=20
-    switch (revision) {
+    switch (rsdp_table[15 /* Revision offset */]) {
     case 0: /* ACPI 1.0 RSDP */
         /* With rev 1, checksum is only for the first 20 bytes */
         g_assert(!acpi_calc_checksum(rsdp_table,  20));
--=20
2.7.4
