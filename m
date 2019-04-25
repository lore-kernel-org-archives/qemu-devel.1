Received: from eggs.gnu.org ([209.51.188.92]:47203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJX3O-0003hD-8L
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJX24-0008Up-8g
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:34:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hJX24-0008UQ-3J
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:34:52 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 25 Apr 2019 07:34:42 +0200
Message-Id: <1556170489-131927-7-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 06/13] tests: acpi: move boot_sector_init()
 into x86 tests branch
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

boot_sector_init() won't be used by arm/virt board, so move it from
global scope to x86 branch that uses it.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v3:
  - fix checkpatch errors triggered by moved old code (ident/space/braces=
)
---
 tests/bios-tables-test.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index e944d00..5790ee4 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -786,13 +786,14 @@ int main(int argc, char *argv[])
     const char *arch =3D qtest_get_arch();
     int ret;
=20
-    ret =3D boot_sector_init(disk);
-    if(ret)
-        return ret;
-
     g_test_init(&argc, &argv, NULL);
=20
     if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D 0=
) {
+        ret =3D boot_sector_init(disk);
+        if (ret) {
+            return ret;
+        }
+
         qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
--=20
2.7.4
