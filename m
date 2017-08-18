Received: from eggs.gnu.org ([2001:4830:134:3::10]:59398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diocR-0006s4-Bi
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diocQ-0000cK-Hv
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:15:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1diocQ-0000bU-6r
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:15:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4AA194A6EB
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 21:15:49 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 18 Aug 2017 16:15:34 -0500
Message-Id: <20170818211542.5380-6-eblake@redhat.com>
In-Reply-To: <20170818211542.5380-1-eblake@redhat.com>
References: <20170818211542.5380-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 05/13] libqtest: Use qemu_strtoul()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

This will keep checkpatch happy when the next patch does code motion.
Fix the include order to match HACKING when adding the needed header.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index a6ce21d7f9..438a22678d 100644
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
@@ -333,12 +334,14 @@ redo:
     g_string_free(line, TRUE);

     if (strcmp(words[0], "IRQ") == 0) {
-        int irq;
+        long irq;
+        int ret;

         g_assert(words[1] != NULL);
         g_assert(words[2] != NULL);

-        irq = strtoul(words[2], NULL, 0);
+        ret = qemu_strtol(words[2], NULL, 0, &irq);
+        g_assert(!ret);
         g_assert_cmpint(irq, >=, 0);
         g_assert_cmpint(irq, <, MAX_IRQ);

@@ -701,11 +704,13 @@ void qtest_outl(QTestState *s, uint16_t addr, uint32_t value)
 static uint32_t qtest_in(QTestState *s, const char *cmd, uint16_t addr)
 {
     gchar **args;
-    uint32_t value;
+    int ret;
+    unsigned long value;

     qtest_sendf(s, "%s 0x%x\n", cmd, addr);
     args = qtest_rsp(s, 2);
-    value = strtoul(args[1], NULL, 0);
+    ret = qemu_strtoul(args[1], NULL, 0, &value);
+    g_assert(!ret && value <= UINT32_MAX);
     g_strfreev(args);

     return value;
@@ -756,11 +761,13 @@ void qtest_writeq(QTestState *s, uint64_t addr, uint64_t value)
 static uint64_t qtest_read(QTestState *s, const char *cmd, uint64_t addr)
 {
     gchar **args;
+    int ret;
     uint64_t value;

     qtest_sendf(s, "%s 0x%" PRIx64 "\n", cmd, addr);
     args = qtest_rsp(s, 2);
-    value = strtoull(args[1], NULL, 0);
+    ret = qemu_strtou64(args[1], NULL, 0, &value);
+    g_assert(!ret);
     g_strfreev(args);

     return value;
-- 
2.13.5
