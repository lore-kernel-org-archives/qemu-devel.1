Received: from eggs.gnu.org ([2001:4830:134:3::10]:50590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dI9dZ-00047V-2v
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dI9dX-0002Tg-8G
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:14:49 -0400
Received: from [59.151.112.132] (port=63214 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dI9dW-0002Rd-TG
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:14:47 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 6 Jun 2017 16:12:56 +0800
Message-ID: <1496736776-19852-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1496736776-19852-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1496736776-19852-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V3 3/3] COLO-compare: Add remote initialization
 and checkpoint notification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

Initialize remote communication socket and make a handshack with remote colo-frame.
Then use this way to notify remote colo-frame do checkpoint.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 10a328e..8886640 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -100,6 +100,12 @@ enum {
     SECONDARY_IN,
 };
 
+typedef enum ProxyRemoteRequest {
+    USERSPACE_PROXY_INIT = 0,
+    USERSPACE_PROXY_GET_REMOTE_INIT = 1,
+    USERSPACE_PROXY_NOTIFY_CHECKPOINT = 2
+} ProxyRemoteRequest;
+
 static int compare_chr_send(CharBackend *out,
                             const uint8_t *buf,
                             uint32_t size);
@@ -498,6 +504,18 @@ static void colo_compare_connection(void *opaque, void *user_data)
             trace_colo_compare_main("packet different");
             g_queue_push_tail(&conn->primary_list, pkt);
             /* TODO: colo_notify_checkpoint();*/
+            /*
+             * If we have notify_dev that means COLO didn't running on KVM,
+             * So we use remote checkpoint notify, Xen is the first user.
+             */
+            if (s->notify_dev) {
+                ProxyRemoteRequest msg = USERSPACE_PROXY_NOTIFY_CHECKPOINT;
+                ret = compare_chr_send(&s->chr_notify_dev, (uint8_t *)msg,
+                                       sizeof(msg));
+                if (ret < 0) {
+                    error_report("Notify remote COLO-frame failed");
+                }
+            }
             break;
         }
     }
@@ -716,7 +734,21 @@ static void compare_sec_rs_finalize(SocketReadState *sec_rs)
 
 static void compare_notify_rs_finalize(SocketReadState *notify_rs)
 {
+    CompareState *s = container_of(notify_rs, CompareState, notify_rs);
+
     /* Get remote colo-frame's notify and handle the message */
+    char *data = g_memdup(notify_rs->buf, notify_rs->packet_len);
+    ProxyRemoteRequest msg = USERSPACE_PROXY_GET_REMOTE_INIT;
+    ProxyRemoteRequest msg_recv = *data;
+    int ret;
+
+    if (msg_recv == USERSPACE_PROXY_INIT) {
+        ret = compare_chr_send(&s->chr_notify_dev, (uint8_t *)msg,
+                               sizeof(msg));
+        if (ret < 0) {
+            error_report("Notify remote COLO-frame INIT failed");
+        }
+    }
 }
 
 /*
-- 
2.7.4
