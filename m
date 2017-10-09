Received: from eggs.gnu.org ([2001:4830:134:3::10]:50519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e1bq4-0000V0-W7
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e1bq0-0004d0-Re
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:36 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:5591 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e1bq0-0004Zj-F7
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:32 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  9 Oct 2017 20:27:17 +0300
Message-Id: <20171009172723.190282-12-vsementsov@virtuozzo.com>
In-Reply-To: <20171009172723.190282-1-vsementsov@virtuozzo.com>
References: <20171009172723.190282-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 6/7] block/nbd-client: early fail
 nbd_read_reply_entry if s->quit is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Do not continue any operation if s->quit is set in parallel.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 280147e6a7..f80a4c5564 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -81,7 +81,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
         if (ret < 0) {
             error_report_err(local_err);
         }
-        if (ret <= 0) {
+        if (ret <= 0 || s->quit) {
             break;
         }
 
@@ -105,9 +105,8 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
             assert(qiov != NULL);
             assert(s->requests[i].request->len ==
                    iov_size(qiov->iov, qiov->niov));
-            if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
-                                      NULL) < 0)
-            {
+            ret = qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov, NULL);
+            if (ret < 0 || s->quit) {
                 s->requests[i].ret = -EIO;
                 break;
             }
-- 
2.11.1
