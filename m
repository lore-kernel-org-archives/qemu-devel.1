Received: from eggs.gnu.org ([2001:4830:134:3::10]:39735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwTu2-0006bI-7H
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwTu1-0007HR-67
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:30 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:20137 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dwTu0-0007G1-RT
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:29 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 25 Sep 2017 16:57:56 +0300
Message-Id: <20170925135801.144261-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170925135801.144261-1-vsementsov@virtuozzo.com>
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/8] nbd: rename NBD_REPLY_MAGIC to
 NBD_SIMPLE_REPLY_MAGIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Hmreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

To be consistent when NBD_STRUCTURED_REPLY_MAGIC will be introduced.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 nbd/nbd-internal.h                       | 2 +-
 nbd/client.c                             | 4 ++--
 nbd/server.c                             | 4 ++--
 tests/qemu-iotests/nbd-fault-injector.py | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 8a609a227f..2d6663de23 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -47,7 +47,7 @@
 #define NBD_OLDSTYLE_NEGOTIATE_SIZE (8 + 8 + 8 + 4 + 124)
 
 #define NBD_REQUEST_MAGIC       0x25609513
-#define NBD_REPLY_MAGIC         0x67446698
+#define NBD_SIMPLE_REPLY_MAGIC  0x67446698
 #define NBD_OPTS_MAGIC          0x49484156454F5054LL
 #define NBD_CLIENT_MAGIC        0x0000420281861253LL
 #define NBD_REP_MAGIC           0x0003e889045565a9LL
diff --git a/nbd/client.c b/nbd/client.c
index 68a0bc1ffc..cd5a2c80ac 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -931,7 +931,7 @@ int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
     }
 
     /* Reply
-       [ 0 ..  3]    magic   (NBD_REPLY_MAGIC)
+       [ 0 ..  3]    magic   (NBD_SIMPLE_REPLY_MAGIC)
        [ 4 ..  7]    error   (0 == no error)
        [ 7 .. 15]    handle
      */
@@ -949,7 +949,7 @@ int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
     }
     trace_nbd_receive_reply(magic, reply->error, reply->handle);
 
-    if (magic != NBD_REPLY_MAGIC) {
+    if (magic != NBD_SIMPLE_REPLY_MAGIC) {
         error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", magic);
         return -EINVAL;
     }
diff --git a/nbd/server.c b/nbd/server.c
index 993ade30bb..a1b21a6951 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -911,11 +911,11 @@ static int nbd_send_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
     trace_nbd_send_reply(reply->error, reply->handle);
 
     /* Reply
-       [ 0 ..  3]    magic   (NBD_REPLY_MAGIC)
+       [ 0 ..  3]    magic   (NBD_SIMPLE_REPLY_MAGIC)
        [ 4 ..  7]    error   (0 == no error)
        [ 7 .. 15]    handle
      */
-    stl_be_p(buf, NBD_REPLY_MAGIC);
+    stl_be_p(buf, NBD_SIMPLE_REPLY_MAGIC);
     stl_be_p(buf + 4, reply->error);
     stq_be_p(buf + 8, reply->handle);
 
diff --git a/tests/qemu-iotests/nbd-fault-injector.py b/tests/qemu-iotests/nbd-fault-injector.py
index 1c10dcb51c..8a04d979aa 100755
--- a/tests/qemu-iotests/nbd-fault-injector.py
+++ b/tests/qemu-iotests/nbd-fault-injector.py
@@ -56,7 +56,7 @@ NBD_CMD_READ = 0
 NBD_CMD_WRITE = 1
 NBD_CMD_DISC = 2
 NBD_REQUEST_MAGIC = 0x25609513
-NBD_REPLY_MAGIC = 0x67446698
+NBD_SIMPLE_REPLY_MAGIC = 0x67446698
 NBD_PASSWD = 0x4e42444d41474943
 NBD_OPTS_MAGIC = 0x49484156454F5054
 NBD_CLIENT_MAGIC = 0x0000420281861253
@@ -166,7 +166,7 @@ def read_request(conn):
     return req
 
 def write_reply(conn, error, handle):
-    buf = reply_struct.pack(NBD_REPLY_MAGIC, error, handle)
+    buf = reply_struct.pack(NBD_SIMPLE_REPLY_MAGIC, error, handle)
     conn.send(buf, event='reply')
 
 def handle_connection(conn, use_export):
-- 
2.11.1
