Received: from eggs.gnu.org ([2001:4830:134:3::10]:47110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUp-0007He-4o
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUn-0000pr-Nf
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:13:55 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 13 Mar 2018 12:13:31 -0500
Message-Id: <20180313171345.659672-4-eblake@redhat.com>
In-Reply-To: <20180313171345.659672-1-eblake@redhat.com>
References: <20180313171345.659672-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 03/17] nbd/server: fix sparse read
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

In case of io error in nbd_co_send_sparse_read we should not
"goto reply:", as it was a fatal error and the common behavior
is to disconnect in this case. We should not try to send the
client an additional error reply, since we already hit a
channel-io error on our previous attempt to send one.

Fix this by handling block-status error in nbd_co_send_sparse_read,
so nbd_co_send_sparse_read fails only on io error. Then just skip
common "reply:" code path in nbd_trip.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180308184636.178534-3-vsementsov@virtuozzo.com>
[eblake: grammar tweaks]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 3d0f024193c..5f292064af0 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1366,6 +1366,10 @@ static int coroutine_fn nbd_co_send_structured_error(NBDClient *client,
     return nbd_co_send_iov(client, iov, 1 + !!iov[1].iov_len, errp);
 }

+/* Do a sparse read and send the structured reply to the client.
+ * Returns -errno if sending fails. bdrv_block_status_above() failure is
+ * reported to the client, at which point this function succeeds.
+ */
 static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
                                                 uint64_t handle,
                                                 uint64_t offset,
@@ -1386,8 +1390,13 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
         bool final;

         if (status < 0) {
-            error_setg_errno(errp, -status, "unable to check for holes");
-            return status;
+            char *msg = g_strdup_printf("unable to check for holes: %s",
+                                        strerror(-status));
+
+            ret = nbd_co_send_structured_error(client, handle, -status, msg,
+                                               errp);
+            g_free(msg);
+            return ret;
         }
         assert(pnum && pnum <= size - progress);
         final = progress + pnum == size;
@@ -1568,7 +1577,7 @@ static coroutine_fn void nbd_trip(void *opaque)
                                           request.from, req->data, request.len,
                                           &local_err);
             if (ret < 0) {
-                goto reply;
+                goto replied;
             }
             goto done;
         }
@@ -1665,6 +1674,8 @@ reply:
                                        req->data, reply_data_len, &local_err);
     }
     g_free(msg);
+
+replied:
     if (ret < 0) {
         error_prepend(&local_err, "Failed to send reply: ");
         goto disconnect;
-- 
2.14.3
