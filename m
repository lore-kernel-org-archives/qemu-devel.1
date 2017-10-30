Received: from eggs.gnu.org ([2001:4830:134:3::10]:50512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e9H7A-0008NY-LH
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e9H79-000159-Q0
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:56:56 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 30 Oct 2017 21:56:28 +0100
Message-Id: <20171030205636.14236-5-eblake@redhat.com>
In-Reply-To: <20171030205636.14236-1-eblake@redhat.com>
References: <20171030205636.14236-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 04/12] nbd/server: Report error for write to
 read-only export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

When the server is read-only, we were already reporting an error
message for NBD_CMD_WRITE_ZEROES, but failed to set errp for a
similar NBD_CMD_WRITE.  This will matter more once structured
replies allow the server to propagate the errp information back
to the client.  While at it, use an error message that makes a
bit more sense if viewed on the client side.

Note that when using qemu-io to test qemu-nbd behavior, it is
rather difficult to convince qemu-io to send protocol violations
(such as a read beyond bounds), because we have a lot of active
checking on the client side that a qemu-io request makes sense
before it ever goes over the wire to the server.  The case of a
client attempting a write when the server is started as
'qemu-nbd -r' is one of the few places where we can easily test
error path handling, without having to resort to hacking in known
temporary bugs to either the server or client.  [Maybe we want a
future patch to the client to do up-front checking on writes to a
read-only export, the way it does up-front bounds checking; but I
don't see anything in the NBD spec that points to a protocol
violation in our current behavior.]

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20171027104037.8319-5-eblake@redhat.com>
---
 nbd/server.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index efb6003364..05ff7470d5 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1381,6 +1381,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         break;
     case NBD_CMD_WRITE:
         if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
+            error_setg(&local_err, "Export is read-only");
             ret = -EROFS;
             break;
         }
@@ -1398,7 +1399,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         break;
     case NBD_CMD_WRITE_ZEROES:
         if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
-            error_setg(&local_err, "Server is read-only, return error");
+            error_setg(&local_err, "Export is read-only");
             ret = -EROFS;
             break;
         }
-- 
2.13.6
