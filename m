Received: from eggs.gnu.org ([2001:4830:134:3::10]:32966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFiDd-0004Ot-6P
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:06:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFiDc-0000to-Di
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:06:13 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 17 Nov 2017 09:05:53 -0600
Message-Id: <20171117150556.16947-2-eblake@redhat.com>
In-Reply-To: <20171117150556.16947-1-eblake@redhat.com>
References: <20171117150556.16947-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 1/4] nbd: Don't crash when server reports
 NBD_CMD_READ failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

If a server fails a read, for example with EIO, but the connection
is still live, then we would crash trying to print a non-existent
error message in nbd_client_co_preadv().  For consistency, also
change the error printout in nbd_read_reply_entry(), although that
instance does not crash.  Bug introduced in commit f140e300.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20171112013936.5942-1-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index bcfed0133d..9206652e45 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -78,7 +78,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
     while (!s->quit) {
         assert(s->reply.handle == 0);
         ret = nbd_receive_reply(s->ioc, &s->reply, &local_err);
-        if (ret < 0) {
+        if (local_err) {
             error_report_err(local_err);
         }
         if (ret <= 0) {
@@ -691,7 +691,7 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,

     ret = nbd_co_receive_cmdread_reply(client, request.handle, offset, qiov,
                                        &local_err);
-    if (ret < 0) {
+    if (local_err) {
         error_report_err(local_err);
     }
     return ret;
-- 
2.13.6
