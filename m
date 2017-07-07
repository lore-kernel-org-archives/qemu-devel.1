Received: from eggs.gnu.org ([2001:4830:134:3::10]:40338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTVCH-0000sD-9E
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTVCF-0001DN-1w
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:33 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:23312 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dTVCE-0001BZ-M5
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:30 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  7 Jul 2017 18:29:10 +0300
Message-Id: <20170707152918.23086-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170707152918.23086-1-vsementsov@virtuozzo.com>
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 02/10] nbd/server: refactor nbd_negotiate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com, berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Combine two successive "if (oldStyle) {...} else {...}" into one.

Block "if (client->tlscreds)" under "if (oldStyle)" is unreachable,
as we have "oldStyle = client->exp != NULL && !client->tlscreds;".
So, delete this block.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 3963972337..a6a57ce7c1 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -584,21 +584,15 @@ static coroutine_fn int nbd_negotiate(NBDClient *client)
         stq_be_p(buf + 8, NBD_CLIENT_MAGIC);
         stq_be_p(buf + 16, client->exp->size);
         stw_be_p(buf + 26, client->exp->nbdflags | myflags);
-    } else {
-        stq_be_p(buf + 8, NBD_OPTS_MAGIC);
-        stw_be_p(buf + 16, NBD_FLAG_FIXED_NEWSTYLE | NBD_FLAG_NO_ZEROES);
-    }
 
-    if (oldStyle) {
-        if (client->tlscreds) {
-            TRACE("TLS cannot be enabled with oldstyle protocol");
-            return -EINVAL;
-        }
         if (nbd_write(client->ioc, buf, sizeof(buf), NULL) < 0) {
             LOG("write failed");
             return -EINVAL;
         }
     } else {
+        stq_be_p(buf + 8, NBD_OPTS_MAGIC);
+        stw_be_p(buf + 16, NBD_FLAG_FIXED_NEWSTYLE | NBD_FLAG_NO_ZEROES);
+
         if (nbd_write(client->ioc, buf, 18, NULL) < 0) {
             LOG("write failed");
             return -EINVAL;
-- 
2.11.1
