Received: from eggs.gnu.org ([2001:4830:134:3::10]:36078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cipIo-0007SQ-6m
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:27:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cipIl-0000uG-S2
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:27:22 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 22:26:55 +0100
Message-Id: <1488317230-26248-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1488317230-26248-1-git-send-email-armbru@redhat.com>
References: <1488317230-26248-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/24] libqtest: Fix qmp() & friends to
 abort on JSON parse errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/libqtest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 683d5e3..bb444d5 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -21,6 +21,7 @@
 #include <sys/wait.h>
 #include <sys/un.h>
 
+#include "qapi/error.h"
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/qjson.h"
@@ -442,7 +443,7 @@ void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
      * is an array type.
      */
     va_copy(ap_copy, ap);
-    qobj = qobject_from_jsonv(fmt, &ap_copy, NULL);
+    qobj = qobject_from_jsonv(fmt, &ap_copy, &error_abort);
     va_end(ap_copy);
 
     /* No need to send anything for an empty QObject.  */
-- 
2.7.4
