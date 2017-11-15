Received: from eggs.gnu.org ([2001:4830:134:3::10]:58559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eF2GM-0003DG-Tr
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:18:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eF2GM-0002xb-02
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:18:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eF2GL-0002xF-Pz
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:18:13 -0500
Date: Wed, 15 Nov 2017 20:18:05 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1510769835-31902-4-git-send-email-mst@redhat.com>
References: <1510769835-31902-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1510769835-31902-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/10] tests: report errors when iasl exits with
 non-zero status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Igor Mammedov <imammedo@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

If iasl exits with non-zero status, the test unhelpfully just reports
that the AML did not match, because the data files it thought iasl
generated do not exist. This adds an explicit check for the exit status
of iasl and prints stderr if it was non-zero. Thus gives us a fighting
chance of diagnosing why iasl failed.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 564da45..ee441f1 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -304,6 +304,7 @@ static bool load_asl(GArray *sdts, AcpiSdtTable *sdt)
     gchar *out, *out_err;
     gboolean ret;
     int i;
+    int status;
=20
     fd =3D g_file_open_tmp("asl-XXXXXX.dsl", &sdt->asl_file, &error);
     g_assert_no_error(error);
@@ -324,14 +325,25 @@ static bool load_asl(GArray *sdts, AcpiSdtTable *sd=
t)
     g_string_append_printf(command_line, "-d %s", sdt->aml_file);
=20
     /* pass 'out' and 'out_err' in order to be redirected */
-    ret =3D g_spawn_command_line_sync(command_line->str, &out, &out_err,=
 NULL, &error);
+    ret =3D g_spawn_command_line_sync(command_line->str, &out, &out_err,=
 &status, &error);
     g_assert_no_error(error);
     if (ret) {
-        ret =3D g_file_get_contents(sdt->asl_file, (gchar **)&sdt->asl,
-                                  &sdt->asl_len, &error);
-        g_assert(ret);
-        g_assert_no_error(error);
-        ret =3D (sdt->asl_len > 0);
+        if (status !=3D 0) {
+            g_printerr("'%s' exited with status %d", command_line->str, =
status);
+            if (!g_str_equal(out, "")) {
+                g_printerr("%s", out);
+            }
+            if (!g_str_equal(out_err, "")) {
+                g_printerr("%s", out_err);
+            }
+            ret =3D FALSE;
+        } else {
+            ret =3D g_file_get_contents(sdt->asl_file, (gchar **)&sdt->a=
sl,
+                                      &sdt->asl_len, &error);
+            g_assert(ret);
+            g_assert_no_error(error);
+            ret =3D (sdt->asl_len > 0);
+        }
     }
=20
     g_free(out);
--=20
MST
