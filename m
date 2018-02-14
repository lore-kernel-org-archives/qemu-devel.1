Received: from eggs.gnu.org ([2001:4830:134:3::10]:43437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elv7K-0006Ig-GK
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elv7H-00078u-CP
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:20:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57164 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1elv7H-00078M-6h
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:20:47 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 14 Feb 2018 12:20:18 +0100
Message-Id: <1518607234-17739-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1518607234-17739-1-git-send-email-thuth@redhat.com>
References: <1518607234-17739-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/18] libqtest: Use qemu_strtoul()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

This will keep checkpatch happy when the next patch does code motion.
Fix the include order to match HACKING when adding the needed header.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqtest.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index f2c2853..13c9100 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -15,12 +15,13 @@
  */
=20
 #include "qemu/osdep.h"
-#include "libqtest.h"
=20
 #include <sys/socket.h>
 #include <sys/wait.h>
 #include <sys/un.h>
=20
+#include "libqtest.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/json-streamer.h"
@@ -363,12 +364,14 @@ redo:
     g_string_free(line, TRUE);
=20
     if (strcmp(words[0], "IRQ") =3D=3D 0) {
-        int irq;
+        long irq;
+        int ret;
=20
         g_assert(words[1] !=3D NULL);
         g_assert(words[2] !=3D NULL);
=20
-        irq =3D strtoul(words[2], NULL, 0);
+        ret =3D qemu_strtol(words[2], NULL, 0, &irq);
+        g_assert(!ret);
         g_assert_cmpint(irq, >=3D, 0);
         g_assert_cmpint(irq, <, MAX_IRQ);
=20
@@ -730,11 +733,13 @@ void qtest_outl(QTestState *s, uint16_t addr, uint3=
2_t value)
 static uint32_t qtest_in(QTestState *s, const char *cmd, uint16_t addr)
 {
     gchar **args;
-    uint32_t value;
+    int ret;
+    unsigned long value;
=20
     qtest_sendf(s, "%s 0x%x\n", cmd, addr);
     args =3D qtest_rsp(s, 2);
-    value =3D strtoul(args[1], NULL, 0);
+    ret =3D qemu_strtoul(args[1], NULL, 0, &value);
+    g_assert(!ret && value <=3D UINT32_MAX);
     g_strfreev(args);
=20
     return value;
@@ -785,11 +790,13 @@ void qtest_writeq(QTestState *s, uint64_t addr, uin=
t64_t value)
 static uint64_t qtest_read(QTestState *s, const char *cmd, uint64_t addr=
)
 {
     gchar **args;
+    int ret;
     uint64_t value;
=20
     qtest_sendf(s, "%s 0x%" PRIx64 "\n", cmd, addr);
     args =3D qtest_rsp(s, 2);
-    value =3D strtoull(args[1], NULL, 0);
+    ret =3D qemu_strtou64(args[1], NULL, 0, &value);
+    g_assert(!ret);
     g_strfreev(args);
=20
     return value;
--=20
1.8.3.1
