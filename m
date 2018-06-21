Received: from eggs.gnu.org ([2001:4830:134:3::10]:52617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVq8s-0006SW-7h
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 23:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVq8r-0001eg-2G
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 23:20:14 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 20 Jun 2018 22:19:52 -0500
Message-Id: <20180621031957.134718-3-eblake@redhat.com>
In-Reply-To: <20180621031957.134718-1-eblake@redhat.com>
References: <20180621031957.134718-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] nbd/server: fix trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Return code = 1 doesn't mean that we parsed base:allocation. Use
correct traces in both -parsed and -skipped cases.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180609151758.17343-2-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: comment tweaks]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 9e1f2271784..e71301b8cd7 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -736,12 +736,16 @@ static int nbd_negotiate_send_meta_context(NBDClient *client,

 /* nbd_meta_base_query
  *
- * Handle query to 'base' namespace. For now, only base:allocation context is
- * available in it.  'len' is the amount of text remaining to be read from
+ * Handle queries to 'base' namespace. For now, only the base:allocation
+ * context is available.  'len' is the amount of text remaining to be read from
  * the current name, after the 'base:' portion has been stripped.
  *
  * Return -errno on I/O error, 0 if option was completely handled by
- * sending a reply about inconsistent lengths, or 1 on success. */
+ * sending a reply about inconsistent lengths, or 1 on success.
+ *
+ * Note: return code = 1 doesn't mean that we've parsed the "base:allocation"
+ * namespace. It only means that there are no errors.
+ */
 static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
                                uint32_t len, Error **errp)
 {
@@ -768,10 +772,12 @@ static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
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
2.14.4
