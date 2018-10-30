Received: from eggs.gnu.org ([2001:4830:134:3::10]:59799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHHkc-000621-Iv
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 20:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHHkb-00072f-CG
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 20:19:18 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 30 Oct 2018 01:18:40 +0100
Message-Id: <20181030001841.1658-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] tests/bios-tables-test: Sanitize test verbose
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Fix the extraneous extra blank lines in the test output when running with=
 V=3D1.

Before:

    TEST: tests/bios-tables-test... (pid=3D25678)
      /i386/acpi/piix4:
    Looking for expected file 'tests/acpi-test-data/pc/DSDT'

    Using expected file 'tests/acpi-test-data/pc/DSDT'

    Looking for expected file 'tests/acpi-test-data/pc/FACP'

    Using expected file 'tests/acpi-test-data/pc/FACP'

    Looking for expected file 'tests/acpi-test-data/pc/APIC'

    Using expected file 'tests/acpi-test-data/pc/APIC'

    Looking for expected file 'tests/acpi-test-data/pc/HPET'

    Using expected file 'tests/acpi-test-data/pc/HPET'
    OK

After:

    TEST: tests/bios-tables-test... (pid=3D667)
      /i386/acpi/piix4:
    Looking for expected file 'tests/acpi-test-data/pc/DSDT'
    Using expected file 'tests/acpi-test-data/pc/DSDT'
    Looking for expected file 'tests/acpi-test-data/pc/FACP'
    Using expected file 'tests/acpi-test-data/pc/FACP'
    Looking for expected file 'tests/acpi-test-data/pc/APIC'
    Using expected file 'tests/acpi-test-data/pc/APIC'
    Looking for expected file 'tests/acpi-test-data/pc/HPET'
    Using expected file 'tests/acpi-test-data/pc/HPET'
    OK

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/bios-tables-test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 4e24930c4b..02dd48de0d 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -371,6 +371,9 @@ static GArray *load_expected_aml(test_data *data)
     gboolean ret;
=20
     GArray *exp_tables =3D g_array_new(false, true, sizeof(AcpiSdtTable)=
);
+    if (getenv("V")) {
+        fputc('\n', stderr);
+    }
     for (i =3D 0; i < data->tables->len; ++i) {
         AcpiSdtTable exp_sdt;
         gchar *aml_file =3D NULL;
@@ -385,7 +388,7 @@ try_again:
         aml_file =3D g_strdup_printf("%s/%s/%.4s%s", data_dir, data->mac=
hine,
                                    (gchar *)&sdt->header.signature, ext)=
;
         if (getenv("V")) {
-            fprintf(stderr, "\nLooking for expected file '%s'\n", aml_fi=
le);
+            fprintf(stderr, "Looking for expected file '%s'\n", aml_file=
);
         }
         if (g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
             exp_sdt.aml_file =3D aml_file;
@@ -397,7 +400,7 @@ try_again:
         }
         g_assert(exp_sdt.aml_file);
         if (getenv("V")) {
-            fprintf(stderr, "\nUsing expected file '%s'\n", aml_file);
+            fprintf(stderr, "Using expected file '%s'\n", aml_file);
         }
         ret =3D g_file_get_contents(aml_file, &exp_sdt.aml,
                                   &exp_sdt.aml_len, &error);
--=20
2.17.2
