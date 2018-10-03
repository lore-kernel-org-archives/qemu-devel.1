Received: from eggs.gnu.org ([2001:4830:134:3::10]:42258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7iRG-0003SL-N1
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7iRE-0007MJ-0z
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:47:46 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  3 Oct 2018 17:47:38 +0300
Message-Id: <20181003144738.70670-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] nbd/server: fix NBD_CMD_CACHE
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

We should not go to structured-read branch on CACHE command, fix that.

Bug intoroduced in bc37b06a5cde24 "nbd/server: introduce NBD_CMD_CACHE"
with the whole feature and affects 3.0.0 release.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index c3dd402b45..1fba21414b 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2177,7 +2177,8 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
     }
 
     if (client->structured_reply && !(request->flags & NBD_CMD_FLAG_DF) &&
-        request->len) {
+        request->len && request->type != NBD_CMD_CACHE)
+    {
         return nbd_co_send_sparse_read(client, request->handle, request->from,
                                        data, request->len, errp);
     }
-- 
2.18.0
