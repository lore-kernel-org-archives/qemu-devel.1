Received: from eggs.gnu.org ([2001:4830:134:3::10]:45295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejsVy-0002HC-8H
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:09:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejsVx-0002JJ-DP
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:09:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43650 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ejsVx-0002It-8h
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:09:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED84E40FB62E
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 20:09:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  8 Feb 2018 21:09:30 +0100
Message-Id: <1518120582-26647-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1518120582-26647-1-git-send-email-thuth@redhat.com>
References: <1518120582-26647-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/14] libqtest: Use qemu_strtoul()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
index 0ec8af2..5d90cdc 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -15,12 +15,13 @@
  *
  */
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
@@ -360,12 +361,14 @@ redo:
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
@@ -727,11 +730,13 @@ void qtest_outl(QTestState *s, uint16_t addr, uint3=
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
@@ -782,11 +787,13 @@ void qtest_writeq(QTestState *s, uint64_t addr, uin=
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
