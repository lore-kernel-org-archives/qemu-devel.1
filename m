Received: from eggs.gnu.org ([2001:4830:134:3::10]:38192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cktMq-0002pa-Fd
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:12:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cktMm-0002m4-Rk
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:12:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cktMm-0002lE-L5
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:12:00 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5273C0467F0
	for <qemu-devel@nongnu.org>; Mon,  6 Mar 2017 14:12:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v26EBxci011924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 09:12:00 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  6 Mar 2017 15:11:40 +0100
Message-Id: <1488809515-4047-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1488809515-4047-1-git-send-email-armbru@redhat.com>
References: <1488809515-4047-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 09/24] libqtest: Fix qmp() & friends to abort
 on JSON parse errors
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
index 9033c5f..a5c3d2b 100644
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
