Received: from eggs.gnu.org ([209.51.188.92]:53994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hG2YB-0008UC-Qe
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hG2YA-0000Vz-Tr
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:25:35 -0400
Received: from relay.sw.ru ([185.231.240.75]:47676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hG2Y9-0000LS-BO
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:25:34 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 15 Apr 2019 17:25:19 +0300
Message-Id: <20190415142519.73060-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2] util/error: do not free error on error_abort
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

v2: don't change error output format

 util/error.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/util/error.c b/util/error.c
index 934a78e1b1..22f8a7924f 100644
--- a/util/error.c
+++ b/util/error.c
@@ -34,7 +34,10 @@ static void error_handle_fatal(Error **errp, Error *err)
     if (errp == &error_abort) {
         fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
                 err->func, err->src, err->line);
-        error_report_err(err);
+        error_report("%s", error_get_pretty(err));
+        if (err->hint) {
+            error_printf_unless_qmp("%s", err->hint->str);
+        }
         abort();
     }
     if (errp == &error_fatal) {
-- 
2.18.0
