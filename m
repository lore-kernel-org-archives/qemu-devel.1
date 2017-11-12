Received: from eggs.gnu.org ([2001:4830:134:3::10]:44637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDhFT-0004jj-BC
	for qemu-devel@nongnu.org; Sat, 11 Nov 2017 20:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDhFS-0000VD-Jj
	for qemu-devel@nongnu.org; Sat, 11 Nov 2017 20:39:47 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 11 Nov 2017 19:39:36 -0600
Message-Id: <20171112013936.5942-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11] nbd: Don't crash when server reports
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
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

If a server fails a read, for example with EIO, but the connection
is still live, then we would crash trying to print a non-existent
error message.  Bug introduced in commit f140e300.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index b44d4d4a01..5f3375a970 100644
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
@@ -681,7 +681,7 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,

     ret = nbd_co_receive_cmdread_reply(client, request.handle, offset, qiov,
                                        &local_err);
-    if (ret < 0) {
+    if (local_err) {
         error_report_err(local_err);
     }
     return ret;
-- 
2.13.6
