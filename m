Received: from eggs.gnu.org ([2001:4830:134:3::10]:43775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dEDK2-0006G7-Mg
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dEDK0-0006O5-KM
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:22:22 -0400
Received: from [59.151.112.132] (port=52326 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dEDK0-0006Mq-86
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:22:20 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 26 May 2017 19:22:07 +0800
Message-ID: <1495797727-16695-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1495797727-16695-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1495797727-16695-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V2 3/3] COLO-compare: Add remote initialization
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
 net/colo-compare.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index c968597..34e31e1 100644
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
@@ -713,7 +731,21 @@ static void compare_sec_rs_finalize(SocketReadState *sec_rs)
 
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
@@ -784,7 +816,7 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
             !qemu_chr_fe_init(&s->chr_notify_dev, chr, errp)) {
             return;
         }
-        net_socket_rs_init(&s->notify_dev, compare_notify_rs_finalize);
+        net_socket_rs_init(&s->notify_rs, compare_notify_rs_finalize);
     }
 
     net_socket_rs_init(&s->pri_rs, compare_pri_rs_finalize);
-- 
2.7.4
