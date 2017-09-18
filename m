Received: from eggs.gnu.org ([2001:4830:134:3::10]:38501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dtwaT-0001kX-7t
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dtwaS-0001TO-Aa
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:59:49 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:19804 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dtwaR-0001S7-Vc
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:59:48 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 18 Sep 2017 16:59:34 +0300
Message-Id: <20170918135935.255591-7-vsementsov@virtuozzo.com>
In-Reply-To: <20170918135935.255591-1-vsementsov@virtuozzo.com>
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
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
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

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
