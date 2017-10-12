Received: from eggs.gnu.org ([2001:4830:134:3::10]:35439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2aBI-0001FU-4o
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2aBF-0000HW-Dj
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:32 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:15318 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e2aBF-0000DX-1M
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:29 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 12 Oct 2017 12:53:13 +0300
Message-Id: <20171012095319.136610-8-vsementsov@virtuozzo.com>
In-Reply-To: <20171012095319.136610-1-vsementsov@virtuozzo.com>
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 07/13] nbd-server: simplify reply
 transmission
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

Send qiov via qio_channel_writev_all instead of calling nbd_write twice
with a cork.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 50 ++++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index afc127bbd9..c1bbe8d2d1 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1188,6 +1188,23 @@ void nbd_export_close_all(void)
     }
 }
 
+static int coroutine_fn nbd_co_send_iov(NBDClient *client, struct iovec *iov,
+                                        unsigned niov, Error **errp)
+{
+    int ret;
+
+    g_assert(qemu_in_coroutine());
+    qemu_co_mutex_lock(&client->send_lock);
+    client->send_coroutine = qemu_coroutine_self();
+
+    ret = qio_channel_writev_all(client->ioc, iov, niov, errp) < 0 ? -EIO : 0;
+
+    client->send_coroutine = NULL;
+    qemu_co_mutex_unlock(&client->send_lock);
+
+    return ret;
+}
+
 static inline void set_be_simple_reply(NBDSimpleReply *reply, uint64_t error,
                                        uint64_t handle)
 {
@@ -1203,36 +1220,17 @@ static int nbd_co_send_simple_reply(NBDClient *client,
                                     size_t len,
                                     Error **errp)
 {
-    NBDSimpleReply simple_reply;
-    int ret;
-
-    g_assert(qemu_in_coroutine());
+    NBDSimpleReply reply;
+    struct iovec iov[] = {
+        {.iov_base = &reply, .iov_len = sizeof(reply)},
+        {.iov_base = data, .iov_len = len}
+    };
 
     trace_nbd_co_send_simple_reply(handle, error, len);
 
-    set_be_simple_reply(&simple_reply, system_errno_to_nbd_errno(error),
-                        handle);
-
-    qemu_co_mutex_lock(&client->send_lock);
-    client->send_coroutine = qemu_coroutine_self();
-
-    if (!len) {
-        ret = nbd_write(client->ioc, &simple_reply, sizeof(simple_reply), NULL);
-    } else {
-        qio_channel_set_cork(client->ioc, true);
-        ret = nbd_write(client->ioc, &simple_reply, sizeof(simple_reply), NULL);
-        if (ret == 0) {
-            ret = nbd_write(client->ioc, data, len, errp);
-            if (ret < 0) {
-                ret = -EIO;
-            }
-        }
-        qio_channel_set_cork(client->ioc, false);
-    }
+    set_be_simple_reply(&reply, system_errno_to_nbd_errno(error), handle);
 
-    client->send_coroutine = NULL;
-    qemu_co_mutex_unlock(&client->send_lock);
-    return ret;
+    return nbd_co_send_iov(client, iov, len ? 2 : 1, errp);
 }
 
 /* nbd_co_receive_request
-- 
2.11.1
