Received: from eggs.gnu.org ([2001:4830:134:3::10]:55426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewi6E-0005eg-BU
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 01:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewi6D-0003DZ-8g
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 01:40:18 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 16 Mar 2018 06:39:55 +0100
Message-Id: <1521178795-21894-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1521178795-21894-1-git-send-email-thuth@redhat.com>
References: <1521178795-21894-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/3] tests/cdrom-test: Test that -cdrom
 parameter is working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Victor Kaplansky <victork@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Commit 1454509726719e0933c800 recently broke the "-cdrom" parameter
on a couple of boards without us noticing it immediately. Thus let's
add a test which checks that "-cdrom" can at least be used to start
QEMU with certain machine types.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/cdrom-test.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 58 insertions(+)

diff --git a/tests/cdrom-test.c b/tests/cdrom-test.c
index 5bbf322..7a1fce5 100644
--- a/tests/cdrom-test.c
+++ b/tests/cdrom-test.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "boot-sector.h"
+#include "qapi/qmp/qdict.h"
=20
 static char isoimage[] =3D "cdrom-boot-iso-XXXXXX";
=20
@@ -89,6 +90,32 @@ cleanup:
     return ret;
 }
=20
+/**
+ * Check that at least the -cdrom parameter is basically working, i.e. w=
e can
+ * see the filename of the ISO image in the output of "info block" after=
wards
+ */
+static void test_cdrom_param(gconstpointer data)
+{
+    QTestState *qts;
+    char *resp;
+
+    qts =3D qtest_startf("-M %s -cdrom %s", (const char *)data, isoimage=
);
+    resp =3D qtest_hmp(qts, "info block");
+    g_assert(strstr(resp, isoimage) !=3D 0);
+    g_free(resp);
+    qtest_quit(qts);
+}
+
+static void add_cdrom_param_tests(const char **machines)
+{
+    while (*machines) {
+        char *testname =3D g_strdup_printf("cdrom/param/%s", *machines);
+        qtest_add_data_func(testname, *machines, test_cdrom_param);
+        g_free(testname);
+        machines++;
+    }
+}
+
 static void test_cdboot(gconstpointer data)
 {
     QTestState *qts;
@@ -154,6 +181,37 @@ int main(int argc, char **argv)
         add_x86_tests();
     } else if (g_str_equal(arch, "s390x")) {
         add_s390x_tests();
+    } else if (g_str_equal(arch, "ppc64")) {
+        const char *ppcmachines[] =3D {
+            "pseries", "mac99", "g3beige", "40p", "prep", NULL
+        };
+        add_cdrom_param_tests(ppcmachines);
+    } else if (g_str_equal(arch, "sparc")) {
+        const char *sparcmachines[] =3D {
+            "LX", "SPARCClassic", "SPARCbook", "SS-10", "SS-20", "SS-4",
+            "SS-5", "SS-600MP", "Voyager", "leon3_generic", NULL
+        };
+        add_cdrom_param_tests(sparcmachines);
+    } else if (g_str_equal(arch, "sparc64")) {
+        const char *sparc64machines[] =3D {
+            "niagara", "sun4u", "sun4v", NULL
+        };
+        add_cdrom_param_tests(sparc64machines);
+    } else if (!strncmp(arch, "mips64", 6)) {
+        const char *mips64machines[] =3D {
+            "magnum", "malta", "mips", "pica61", NULL
+        };
+        add_cdrom_param_tests(mips64machines);
+    } else if (g_str_equal(arch, "arm") || g_str_equal(arch, "aarch64"))=
 {
+        const char *armmachines[] =3D {
+            "realview-eb", "realview-eb-mpcore", "realview-pb-a8",
+            "realview-pbx-a9", "versatileab", "versatilepb", "vexpress-a=
15",
+            "vexpress-a9", "virt", NULL
+        };
+        add_cdrom_param_tests(armmachines);
+    } else {
+        const char *nonemachine[] =3D { "none", NULL };
+        add_cdrom_param_tests(nonemachine);
     }
=20
     ret =3D g_test_run();
--=20
1.8.3.1
