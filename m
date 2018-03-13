Received: from eggs.gnu.org ([2001:4830:134:3::10]:47114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUp-0007Hk-7e
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUn-0000q3-Sv
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:13:55 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 13 Mar 2018 12:13:32 -0500
Message-Id: <20180313171345.659672-5-eblake@redhat.com>
In-Reply-To: <20180313171345.659672-1-eblake@redhat.com>
References: <20180313171345.659672-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 04/17] nbd/server: fix: check client->closing
 before sending reply
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

Since the unchanged code has just set client->recv_coroutine to
NULL before calling nbd_client_receive_next_request(), we are
spawning a new coroutine unconditionally, but the first thing
that coroutine will do is check for client->closing, making it
a no-op if we have already detected that the client is going
away.  Furthermore, for any error other than EIO (where we
disconnect, which itself sets client->closing), if the client
has already gone away, we'll probably encounter EIO later
in the function and attempt disconnect at that point.  Logically,
as soon as we know the connection is closing, there is no need
to try a likely-to-fail a response or spawn a no-op coroutine.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180308184636.178534-4-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: squash in further reordering: hoist check before spawning
next coroutine, and document rationale in commit message]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 5f292064af0..b230ecb4fb8 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1543,14 +1543,6 @@ static coroutine_fn void nbd_trip(void *opaque)
     req = nbd_request_get(client);
     ret = nbd_co_receive_request(req, &request, &local_err);
     client->recv_coroutine = NULL;
-    nbd_client_receive_next_request(client);
-    if (ret == -EIO) {
-        goto disconnect;
-    }
-
-    if (ret < 0) {
-        goto reply;
-    }

     if (client->closing) {
         /*
@@ -1560,6 +1552,15 @@ static coroutine_fn void nbd_trip(void *opaque)
         goto done;
     }

+    nbd_client_receive_next_request(client);
+    if (ret == -EIO) {
+        goto disconnect;
+    }
+
+    if (ret < 0) {
+        goto reply;
+    }
+
     switch (request.type) {
     case NBD_CMD_READ:
         /* XXX: NBD Protocol only documents use of FUA with WRITE */
-- 
2.14.3
