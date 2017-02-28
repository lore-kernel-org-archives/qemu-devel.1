Received: from eggs.gnu.org ([2001:4830:134:3::10]:33594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciqDt-00056R-RL
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciqDs-0000Xz-9I
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ciqDs-0000XT-2x
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:20 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4890F5455D
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 22:26:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1620D1DCC0
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 22:26:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 23:26:00 +0100
Message-Id: <1488320775-9849-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1488320775-9849-1-git-send-email-armbru@redhat.com>
References: <1488320775-9849-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 09/24] libqtest: Fix qmp() & friends to abort on
 JSON parse errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <1488317230-26248-10-git-send-email-armbru@redhat.com>
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
