Received: from eggs.gnu.org ([2001:4830:134:3::10]:46303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7obM-0001dU-Il
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 17:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7obL-00010B-Gh
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 17:22:36 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  3 Oct 2018 16:22:08 -0500
Message-Id: <20181003212211.812374-3-eblake@redhat.com>
In-Reply-To: <20181003212211.812374-1-eblake@redhat.com>
References: <20181003212211.812374-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] nbd/server: fix NBD_CMD_CACHE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We should not go to structured-read branch on CACHE command, fix that.

Bug introduced in bc37b06a5cde24 "nbd/server: introduce NBD_CMD_CACHE"
with the whole feature and affects 3.0.0 release.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: qemu-stable@nongnu.org
Message-Id: <20181003144738.70670-1-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: commit message typo fix]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index 98d0fa25158..4fb247b1166 100644
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
2.17.1
