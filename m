Received: from eggs.gnu.org ([2001:4830:134:3::10]:48480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCowv-0000Yi-1z
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCowq-0006yf-5p
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:41:01 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:46397 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eCowp-0006wq-QG
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:40:56 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  9 Nov 2017 18:40:48 +0300
Message-Id: <20171109154049.42386-2-vsementsov@virtuozzo.com>
In-Reply-To: <20171109154049.42386-1-vsementsov@virtuozzo.com>
References: <20171109154049.42386-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/2] nbd/server: add additional assert to
 nbd_export_put
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

This place is not obvious, nbd_export_close may theoretically reduce
refcount to 0. It may happen if someone calls nbd_export_put on named
export not through nbd_export_set_name when refcount is 1.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/nbd/server.c b/nbd/server.c
index 70b40ed27e..2f2e05943f 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1179,6 +1179,7 @@ void nbd_export_put(NBDExport *exp)
         nbd_export_close(exp);
     }
 
+    assert(exp->refcount > 0);
     if (--exp->refcount == 0) {
         assert(exp->name == NULL);
         assert(exp->description == NULL);
-- 
2.11.1
