Received: from eggs.gnu.org ([2001:4830:134:3::10]:42935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4oCD-0004W3-9F
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4oC7-0005aa-Ht
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:15:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e4oC7-0005aG-Bd
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:15:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 793A8C04AC4F
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 13:15:34 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 18 Oct 2017 14:15:28 +0100
Message-Id: <20171018131529.19453-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] tests: report errors when iasl exits with
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

If iasl exits with non-zero status, the test unhelpfully just reports
that the AML did not match, because the data files it thought iasl
generated do not exist. This adds an explicit check for the exit status
of iasl and prints stderr if it was non-zero. Thus gives us a fighting
chance of diagnosing why iasl failed.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/bios-tables-test.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 564da45f65..ee441f1e17 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -304,6 +304,7 @@ static bool load_asl(GArray *sdts, AcpiSdtTable *sdt)
     gchar *out, *out_err;
     gboolean ret;
     int i;
+    int status;
 
     fd = g_file_open_tmp("asl-XXXXXX.dsl", &sdt->asl_file, &error);
     g_assert_no_error(error);
@@ -324,14 +325,25 @@ static bool load_asl(GArray *sdts, AcpiSdtTable *sdt)
     g_string_append_printf(command_line, "-d %s", sdt->aml_file);
 
     /* pass 'out' and 'out_err' in order to be redirected */
-    ret = g_spawn_command_line_sync(command_line->str, &out, &out_err, NULL, &error);
+    ret = g_spawn_command_line_sync(command_line->str, &out, &out_err, &status, &error);
     g_assert_no_error(error);
     if (ret) {
-        ret = g_file_get_contents(sdt->asl_file, (gchar **)&sdt->asl,
-                                  &sdt->asl_len, &error);
-        g_assert(ret);
-        g_assert_no_error(error);
-        ret = (sdt->asl_len > 0);
+        if (status != 0) {
+            g_printerr("'%s' exited with status %d", command_line->str, status);
+            if (!g_str_equal(out, "")) {
+                g_printerr("%s", out);
+            }
+            if (!g_str_equal(out_err, "")) {
+                g_printerr("%s", out_err);
+            }
+            ret = FALSE;
+        } else {
+            ret = g_file_get_contents(sdt->asl_file, (gchar **)&sdt->asl,
+                                      &sdt->asl_len, &error);
+            g_assert(ret);
+            g_assert_no_error(error);
+            ret = (sdt->asl_len > 0);
+        }
     }
 
     g_free(out);
-- 
2.13.6
