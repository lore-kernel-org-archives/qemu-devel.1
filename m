Received: from eggs.gnu.org ([209.51.188.92]:49393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDmVC-0004Be-KC
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDmV9-0002wj-3o
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:53:10 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  9 Apr 2019 10:52:44 +0200
Message-Id: <20190409085245.31548-5-thuth@redhat.com>
In-Reply-To: <20190409085245.31548-1-thuth@redhat.com>
References: <20190409085245.31548-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.1 4/5] tests/test-hmp: Use qtest_init()
 instead of qtest_start()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, armbru@redhat.com, Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, eblake@redhat.com, Hannes Reinecke <hare@suse.com>

qtest_start() + qtest_end() should be avoided, since they use the
global_qtest variable that we want to get rid of in the long run
Use qtest_init() and qtest_quit() instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/test-hmp.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 54a01824dc..f0d843e34a 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -72,13 +72,13 @@ static const char *hmp_cmds[] =3D {
 };
=20
 /* Run through the list of pre-defined commands */
-static void test_commands(void)
+static void test_commands(QTestState *qts)
 {
     char *response;
     int i;
=20
     for (i =3D 0; hmp_cmds[i] !=3D NULL; i++) {
-        response =3D hmp("%s", hmp_cmds[i]);
+        response =3D qtest_hmp(qts, "%s", hmp_cmds[i]);
         if (verbose) {
             fprintf(stderr,
                     "\texecute HMP command: %s\n"
@@ -91,11 +91,11 @@ static void test_commands(void)
 }
=20
 /* Run through all info commands and call them blindly (without argument=
s) */
-static void test_info_commands(void)
+static void test_info_commands(QTestState *qts)
 {
     char *resp, *info, *info_buf, *endp;
=20
-    info_buf =3D info =3D hmp("help info");
+    info_buf =3D info =3D qtest_hmp(qts, "help info");
=20
     while (*info) {
         /* Extract the info command, ignore parameters and description *=
/
@@ -107,7 +107,7 @@ static void test_info_commands(void)
         if (verbose) {
             fprintf(stderr, "\t%s\n", info);
         }
-        resp =3D hmp("%s", info);
+        resp =3D qtest_hmp(qts, "%s", info);
         g_free(resp);
         /* And move forward to the next line */
         info =3D strchr(endp + 1, '\n');
@@ -124,14 +124,15 @@ static void test_machine(gconstpointer data)
 {
     const char *machine =3D data;
     char *args;
+    QTestState *qts;
=20
     args =3D g_strdup_printf("-S -M %s", machine);
-    qtest_start(args);
+    qts =3D qtest_init(args);
=20
-    test_info_commands();
-    test_commands();
+    test_info_commands(qts);
+    test_commands(qts);
=20
-    qtest_end();
+    qtest_quit(qts);
     g_free(args);
     g_free((void *)data);
 }
--=20
2.21.0
