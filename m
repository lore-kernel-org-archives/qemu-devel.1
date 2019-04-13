Received: from eggs.gnu.org ([209.51.188.92]:50579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hFLBs-0007ch-Ag
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hFLBr-0002Ss-IK
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:07:40 -0400
Received: from relay.sw.ru ([185.231.240.75]:34450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hFLBr-0002Qp-A1
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:07:39 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 13 Apr 2019 19:07:32 +0300
Message-Id: <20190413160732.55505-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] util/error: do not free error on error_abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, vsementsov@virtuozzo.com

It would be nice to have Error object not freed away when debugging a
coredump.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 util/error.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/util/error.c b/util/error.c
index 934a78e1b1..f9180c0f30 100644
--- a/util/error.c
+++ b/util/error.c
@@ -32,9 +32,11 @@ Error *error_fatal;
 static void error_handle_fatal(Error **errp, Error *err)
 {
     if (errp == &error_abort) {
-        fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
-                err->func, err->src, err->line);
-        error_report_err(err);
+        error_report("Unexpected error in %s() at %s:%d: %s",
+                     err->func, err->src, err->line, error_get_pretty(err));
+        if (err->hint) {
+            error_printf_unless_qmp("%s", err->hint->str);
+        }
         abort();
     }
     if (errp == &error_fatal) {
-- 
2.18.0
