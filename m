Received: from eggs.gnu.org ([2001:4830:134:3::10]:52546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eu0Yu-0004YO-Pe
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eu0Yp-0003J1-SG
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:46:44 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  8 Mar 2018 21:46:33 +0300
Message-Id: <20180308184636.178534-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180308184636.178534-1-vsementsov@virtuozzo.com>
References: <20180308184636.178534-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 2/5] nbd/server: fix sparse read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

In case of io error in nbd_co_send_sparse_read we should not
"goto reply:", as it is fatal error and common behavior is
disconnect in this case. We should not try to send client an
error reply, representing channel-io error on previous try to
send a reply.

Fix this by handle block-status error in nbd_co_send_sparse_read,
so nbd_co_send_sparse_read fails only on io error. Then just skip
common "reply:" code path in nbd_trip.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

v2: code movement splitted to 01
    remove error_report
    fix indent
    fix commit message subject line
    add comment to nbd_co_send_sparse_read (be free to adjust it)

 nbd/server.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index c406b0656d..e0de431e10 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1365,6 +1365,10 @@ static int coroutine_fn nbd_co_send_structured_error(NBDClient *client,
     return nbd_co_send_iov(client, iov, 1 + !!iov[1].iov_len, errp);
 }
 
+/* Do sparse read and send structured reply to the client.
+ * Returns -errno if sending fails. bdrv_block_status_above() fail is not
+ * considered as an error, but reported to the client instead (as a structured
+ * error). */
 static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
                                                 uint64_t handle,
                                                 uint64_t offset,
@@ -1385,8 +1389,13 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
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
@@ -1567,7 +1576,7 @@ static coroutine_fn void nbd_trip(void *opaque)
                                           request.from, req->data, request.len,
                                           &local_err);
             if (ret < 0) {
-                goto reply;
+                goto replied;
             }
             goto done;
         }
@@ -1664,6 +1673,8 @@ reply:
                                        req->data, reply_data_len, &local_err);
     }
     g_free(msg);
+
+replied:
     if (ret < 0) {
         error_prepend(&local_err, "Failed to send reply: ");
         goto disconnect;
-- 
2.11.1
