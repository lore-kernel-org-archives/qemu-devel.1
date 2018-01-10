Received: from eggs.gnu.org ([2001:4830:134:3::10]:44880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZPLg-0001bK-Jc
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZPLf-0004jJ-OQ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:59:56 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 10 Jan 2018 16:59:43 -0600
Message-Id: <20180110225944.17920-2-eblake@redhat.com>
In-Reply-To: <20180110225944.17920-1-eblake@redhat.com>
References: <20180110225944.17920-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] nbd/server: add additional assert to
 nbd_export_put
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

This place is not obvious, nbd_export_close may theoretically reduce
refcount to 0. It may happen if someone calls nbd_export_put on named
export not through nbd_export_set_name when refcount is 1.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20171207155102.66622-2-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index e443b3cf5c..6cf2eeb2c1 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1190,6 +1190,12 @@ void nbd_export_put(NBDExport *exp)
         nbd_export_close(exp);
     }

+    /* nbd_export_close() may theoretically reduce refcount to 0. It may happen
+     * if someone calls nbd_export_put() on named export not through
+     * nbd_export_set_name() when refcount is 1. So, let's assert that
+     * it is > 0.
+     */
+    assert(exp->refcount > 0);
     if (--exp->refcount == 0) {
         assert(exp->name == NULL);
         assert(exp->description == NULL);
-- 
2.14.3
