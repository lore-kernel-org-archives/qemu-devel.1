Received: from eggs.gnu.org ([209.51.188.92]:54425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0R-00055P-WC
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0R-00059s-0u
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHE0Q-00059J-R5
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:38 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 18 Apr 2019 22:51:03 +0200
Message-Id: <20190418205135.6686-5-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for-4.1 04/36] util/error: do not free error on
 error_abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

It would be nice to have Error object not freed away when debugging a
coredump.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20190415142519.73060-1-vsementsov@virtuozzo.com>
[error_printf_unless_qmp() replaced by error_printf()]
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/error.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/util/error.c b/util/error.c
index 712b4d4b5d..ea6d1a3d7e 100644
--- a/util/error.c
+++ b/util/error.c
@@ -34,7 +34,10 @@ static void error_handle_fatal(Error **errp, Error *err)
     if (errp == &error_abort) {
         fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
                 err->func, err->src, err->line);
-        error_report_err(err);
+        error_report("%s", error_get_pretty(err));
+        if (err->hint) {
+            error_printf("%s", err->hint->str);
+        }
         abort();
     }
     if (errp == &error_fatal) {
-- 
2.17.2
