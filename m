Received: from eggs.gnu.org ([2001:4830:134:3::10]:52236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e3WzB-0006ew-Br
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 20:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e3WzA-0003vr-JJ
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 20:40:57 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat, 14 Oct 2017 19:40:32 -0500
Message-Id: <20171015004033.3248-9-eblake@redhat.com>
In-Reply-To: <20171015004033.3248-1-eblake@redhat.com>
References: <20171015004033.3248-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 8/9] nbd/server: simplify reply transmission
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

Send qiov via qio_channel_writev_all instead of calling nbd_write twice
with a cork.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20171012095319.136610-8-vsementsov@virtuozzo.com>
[eblake: rebase to tweaks earlier in series]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 3fcc3d3c7c..3df3548d6d 100644
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
@@ -1203,35 +1220,17 @@ static int nbd_co_send_simple_reply(NBDClient *client,
                                     size_t len,
                                     Error **errp)
 {
-    NBDSimpleReply simple_reply;
+    NBDSimpleReply reply;
     int nbd_err = system_errno_to_nbd_errno(error);
-    int ret;
-
-    g_assert(qemu_in_coroutine());
+    struct iovec iov[] = {
+        {.iov_base = &reply, .iov_len = sizeof(reply)},
+        {.iov_base = data, .iov_len = len}
+    };

     trace_nbd_co_send_simple_reply(handle, nbd_err, len);
-    set_be_simple_reply(&simple_reply, nbd_err, handle);
+    set_be_simple_reply(&reply, nbd_err, handle);

-    qemu_co_mutex_lock(&client->send_lock);
-    client->send_coroutine = qemu_coroutine_self();
-
-    if (!len) {
-        ret = nbd_write(client->ioc, &simple_reply, sizeof(simple_reply), errp);
-    } else {
-        qio_channel_set_cork(client->ioc, true);
-        ret = nbd_write(client->ioc, &simple_reply, sizeof(simple_reply), errp);
-        if (ret == 0) {
-            ret = nbd_write(client->ioc, data, len, errp);
-            if (ret < 0) {
-                ret = -EIO;
-            }
-        }
-        qio_channel_set_cork(client->ioc, false);
-    }
-
-    client->send_coroutine = NULL;
-    qemu_co_mutex_unlock(&client->send_lock);
-    return ret;
+    return nbd_co_send_iov(client, iov, len ? 2 : 1, errp);
 }

 /* nbd_co_receive_request
-- 
2.13.6
