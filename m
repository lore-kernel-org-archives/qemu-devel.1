Received: from eggs.gnu.org ([2001:4830:134:3::10]:60090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fL7XN-0004VF-2i
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fL7XH-0001DH-Li
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:41:12 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 22 May 2018 16:41:02 +0300
Message-Id: <20180522134102.17332-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] nbd/server: fix trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Return code = 1 doesn't mean that we parsed base:allocation. Move
trace point to appropriate place.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 9e1f227178..84381baaa8 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -741,7 +741,10 @@ static int nbd_negotiate_send_meta_context(NBDClient *client,
  * the current name, after the 'base:' portion has been stripped.
  *
  * Return -errno on I/O error, 0 if option was completely handled by
- * sending a reply about inconsistent lengths, or 1 on success. */
+ * sending a reply about inconsistent lengths, or 1 on success.
+ *
+ * Note: return code = 1 doesn't mean that we've parsed "base:allocation"
+ * namespace. It only mean that there are no errors.*/
 static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
                                uint32_t len, Error **errp)
 {
@@ -768,10 +771,10 @@ static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
     }
 
     if (strncmp(query, "allocation", alen) == 0) {
+        trace_nbd_negotiate_meta_query_parse("base:allocation");
         meta->base_allocation = true;
     }
 
-    trace_nbd_negotiate_meta_query_parse("base:allocation");
     return 1;
 }
 
-- 
2.11.1
