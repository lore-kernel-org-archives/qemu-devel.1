Received: from eggs.gnu.org ([2001:4830:134:3::10]:47242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eMySX-0003bq-0U
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eMyST-0008B8-Ux
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:51:36 -0500
Received: from [195.214.232.25] (port=1321 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eMyST-00089L-KF
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:51:33 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  7 Dec 2017 18:50:57 +0300
Message-Id: <20171207155102.66622-2-vsementsov@virtuozzo.com>
In-Reply-To: <20171207155102.66622-1-vsementsov@virtuozzo.com>
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/6] nbd/server: add additional assert to
 nbd_export_put
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

This place is not obvious, nbd_export_close may theoretically reduce
refcount to 0. It may happen if someone calls nbd_export_put on named
export not through nbd_export_set_name when refcount is 1.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 nbd/server.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index 92c0fdd03b..e817c48087 100644
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
2.11.1
