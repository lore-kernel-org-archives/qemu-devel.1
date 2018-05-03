Received: from eggs.gnu.org ([2001:4830:134:3::10]:45682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fEGGS-0005af-CW
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fEGGM-0004mq-P1
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:35:24 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  3 May 2018 17:35:09 +0200
Message-Id: <20180503153509.22223-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] sheepdog: Fix sd_co_create_opts() memory leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

Both the option string for the 'redundancy' option and the
SheepdogRedundancy object that is created accordingly could be leaked in
error paths. This fixes the memory leaks.

Reported by Coverity (CID 1390614 and 1390641).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/sheepdog.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index a2f26efc0e..6ec647e558 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1987,6 +1987,7 @@ static SheepdogRedundancy *parse_redundancy_str(const char *opt)
     } else {
         ret = qemu_strtol(n2, NULL, 10, &parity);
         if (ret < 0) {
+            g_free(redundancy);
             return NULL;
         }
 
@@ -2183,7 +2184,7 @@ static int coroutine_fn sd_co_create_opts(const char *filename, QemuOpts *opts,
     QDict *qdict, *location_qdict;
     QObject *crumpled;
     Visitor *v;
-    const char *redundancy;
+    char *redundancy;
     Error *local_err = NULL;
     int ret;
 
@@ -2253,6 +2254,7 @@ static int coroutine_fn sd_co_create_opts(const char *filename, QemuOpts *opts,
 fail:
     qapi_free_BlockdevCreateOptions(create_options);
     QDECREF(qdict);
+    g_free(redundancy);
     return ret;
 }
 
-- 
2.13.6
