Received: from eggs.gnu.org ([2001:4830:134:3::10]:36720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5n-0007nq-Mp
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5i-00080y-K3
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:07 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:29031 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cZg5i-0007yG-7v
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:02 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Feb 2017 18:47:40 +0300
Message-Id: <20170203154757.36140-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-1-vsementsov@virtuozzo.com>
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 01/18] nbd: rename NBD_REPLY_MAGIC to
 NBD_SIMPLE_REPLY_MAGIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, den@virtuozzo.com, stefanha@redhat.com

To be consistent when NBD_STRUCTURED_REPLY_MAGIC will be introduced.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/client.c                             | 4 ++--
 nbd/nbd-internal.h                       | 2 +-
 nbd/server.c                             | 4 ++--
 tests/qemu-iotests/nbd-fault-injector.py | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index ffb0743bce..de5c9366c7 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -788,7 +788,7 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply)
     }
 
     /* Reply
-       [ 0 ..  3]    magic   (NBD_REPLY_MAGIC)
+       [ 0 ..  3]    magic   (NBD_SIMPLE_REPLY_MAGIC)
        [ 4 ..  7]    error   (0 == no error)
        [ 7 .. 15]    handle
      */
@@ -808,7 +808,7 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply)
           ", handle = %" PRIu64" }",
           magic, reply->error, reply->handle);
 
-    if (magic != NBD_REPLY_MAGIC) {
+    if (magic != NBD_SIMPLE_REPLY_MAGIC) {
         LOG("invalid magic (got 0x%" PRIx32 ")", magic);
         return -EINVAL;
     }
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index eee20abc25..49b66b6896 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -59,7 +59,7 @@
 #define NBD_REQUEST_SIZE        (4 + 2 + 2 + 8 + 8 + 4)
 #define NBD_REPLY_SIZE          (4 + 4 + 8)
 #define NBD_REQUEST_MAGIC       0x25609513
-#define NBD_REPLY_MAGIC         0x67446698
+#define NBD_SIMPLE_REPLY_MAGIC  0x67446698
 #define NBD_OPTS_MAGIC          0x49484156454F5054LL
 #define NBD_CLIENT_MAGIC        0x0000420281861253LL
 #define NBD_REP_MAGIC           0x0003e889045565a9LL
diff --git a/nbd/server.c b/nbd/server.c
index 5b76261666..b63a8b85e3 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -750,11 +750,11 @@ static ssize_t nbd_send_reply(QIOChannel *ioc, NBDReply *reply)
           reply->error, reply->handle);
 
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
index 6c07191a5a..5d092ee1f6 100755
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
2.11.0
