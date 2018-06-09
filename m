Received: from eggs.gnu.org ([2001:4830:134:3::10]:36196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRfd0-0002y3-JW
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 11:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRfcx-00051z-EH
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 11:18:06 -0400
Received: from relay.sw.ru ([195.214.232.25]:51892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1fRfcx-00050X-5R
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 11:18:03 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat,  9 Jun 2018 18:17:53 +0300
Message-Id: <20180609151758.17343-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180609151758.17343-1-vsementsov@virtuozzo.com>
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 1/6] nbd/server: fix trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Return code = 1 doesn't mean that we parsed base:allocation. Use
correct traces in both -parsed and -skipped cases.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 9e1f227178..8e02e077ec 100644
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
+ * namespace. It only means that there are no errors.*/
 static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
                                uint32_t len, Error **errp)
 {
@@ -768,10 +771,12 @@ static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
     }
 
     if (strncmp(query, "allocation", alen) == 0) {
+        trace_nbd_negotiate_meta_query_parse("base:allocation");
         meta->base_allocation = true;
+    } else {
+        trace_nbd_negotiate_meta_query_skip("not base:allocation");
     }
 
-    trace_nbd_negotiate_meta_query_parse("base:allocation");
     return 1;
 }
 
-- 
2.11.1
