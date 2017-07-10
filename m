Received: from eggs.gnu.org ([2001:4830:134:3::10]:54699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUXaZ-0001fQ-4r
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUXaY-0002cR-6L
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:14:55 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 10 Jul 2017 07:14:26 -0500
Message-Id: <20170710121434.5047-4-eblake@redhat.com>
In-Reply-To: <20170710121434.5047-1-eblake@redhat.com>
References: <20170710121434.5047-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 03/11] nbd/server: refactor nbd_negotiate
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

Combine two successive "if (oldStyle) {...} else {...}" into one.

Block "if (client->tlscreds)" under "if (oldStyle)" is unreachable,
as we have "oldStyle = client->exp != NULL && !client->tlscreds;".
So, delete this block.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20170707152918.23086-3-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 3963972..a6a57ce 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -584,21 +584,15 @@ static coroutine_fn int nbd_negotiate(NBDClient *client)
         stq_be_p(buf + 8, NBD_CLIENT_MAGIC);
         stq_be_p(buf + 16, client->exp->size);
         stw_be_p(buf + 26, client->exp->nbdflags | myflags);
+
+        if (nbd_write(client->ioc, buf, sizeof(buf), NULL) < 0) {
+            LOG("write failed");
+            return -EINVAL;
+        }
     } else {
         stq_be_p(buf + 8, NBD_OPTS_MAGIC);
         stw_be_p(buf + 16, NBD_FLAG_FIXED_NEWSTYLE | NBD_FLAG_NO_ZEROES);
-    }

-    if (oldStyle) {
-        if (client->tlscreds) {
-            TRACE("TLS cannot be enabled with oldstyle protocol");
-            return -EINVAL;
-        }
-        if (nbd_write(client->ioc, buf, sizeof(buf), NULL) < 0) {
-            LOG("write failed");
-            return -EINVAL;
-        }
-    } else {
         if (nbd_write(client->ioc, buf, 18, NULL) < 0) {
             LOG("write failed");
             return -EINVAL;
-- 
2.9.4
