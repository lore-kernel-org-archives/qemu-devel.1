Received: from eggs.gnu.org ([2001:4830:134:3::10]:38168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSNz-0006wY-9w
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSNy-0000ze-9t
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:20:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1drSNy-0000zL-4A
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:20:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32F5A85363
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 17:20:37 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:19:50 -0500
Message-Id: <20170911172022.4738-7-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 06/38] libqtest: Use qemu_strtoul()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com

This will keep checkpatch happy when the next patch does code motion.
Fix the include order to match HACKING when adding the needed header.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqtest.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 3f956f09fc..95d4159b38 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -15,12 +15,13 @@
  *
  */
 #include "qemu/osdep.h"
-#include "libqtest.h"

 #include <sys/socket.h>
 #include <sys/wait.h>
 #include <sys/un.h>

+#include "libqtest.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/json-streamer.h"
@@ -331,12 +332,14 @@ redo:
     g_string_free(line, TRUE);

     if (strcmp(words[0], "IRQ") =3D=3D 0) {
-        int irq;
+        long irq;
+        int ret;

         g_assert(words[1] !=3D NULL);
         g_assert(words[2] !=3D NULL);

-        irq =3D strtoul(words[2], NULL, 0);
+        ret =3D qemu_strtol(words[2], NULL, 0, &irq);
+        g_assert(!ret);
         g_assert_cmpint(irq, >=3D, 0);
         g_assert_cmpint(irq, <, MAX_IRQ);

@@ -699,11 +702,13 @@ void qtest_outl(QTestState *s, uint16_t addr, uint3=
2_t value)
 static uint32_t qtest_in(QTestState *s, const char *cmd, uint16_t addr)
 {
     gchar **args;
-    uint32_t value;
+    int ret;
+    unsigned long value;

     qtest_sendf(s, "%s 0x%x\n", cmd, addr);
     args =3D qtest_rsp(s, 2);
-    value =3D strtoul(args[1], NULL, 0);
+    ret =3D qemu_strtoul(args[1], NULL, 0, &value);
+    g_assert(!ret && value <=3D UINT32_MAX);
     g_strfreev(args);

     return value;
@@ -754,11 +759,13 @@ void qtest_writeq(QTestState *s, uint64_t addr, uin=
t64_t value)
 static uint64_t qtest_read(QTestState *s, const char *cmd, uint64_t addr=
)
 {
     gchar **args;
+    int ret;
     uint64_t value;

     qtest_sendf(s, "%s 0x%" PRIx64 "\n", cmd, addr);
     args =3D qtest_rsp(s, 2);
-    value =3D strtoull(args[1], NULL, 0);
+    ret =3D qemu_strtou64(args[1], NULL, 0, &value);
+    g_assert(!ret);
     g_strfreev(args);

     return value;
--=20
2.13.5
