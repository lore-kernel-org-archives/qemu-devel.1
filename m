Received: from eggs.gnu.org ([2001:4830:134:3::10]:51161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gYvee-0000hx-0v
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gYved-0000di-2C
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:22:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gYvec-0000cI-Lr
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:22:02 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E6E8788302
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 16:22:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 17 Dec 2018 17:21:30 +0100
Message-Id: <1545063690-10116-14-git-send-email-thuth@redhat.com>
In-Reply-To: <1545063690-10116-1-git-send-email-thuth@redhat.com>
References: <1545063690-10116-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/13] tests/bios-tables-test: Sanitize test
 verbose output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/bios-tables-test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index fabbed9..bac4b01 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -372,6 +372,9 @@ static GArray *load_expected_aml(test_data *data)
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
@@ -386,7 +389,7 @@ try_again:
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
@@ -398,7 +401,7 @@ try_again:
         }
         g_assert(exp_sdt.aml_file);
         if (getenv("V")) {
-            fprintf(stderr, "\nUsing expected file '%s'\n", aml_file);
+            fprintf(stderr, "Using expected file '%s'\n", aml_file);
         }
         ret =3D g_file_get_contents(aml_file, &exp_sdt.aml,
                                   &exp_sdt.aml_len, &error);
--=20
1.8.3.1
