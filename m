Received: from eggs.gnu.org ([2001:4830:134:3::10]:41483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cifLz-00007L-Jv
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cifLx-0004lw-3d
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:49:59 -0500
Received: from [59.151.112.132] (port=51588 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cifLw-0004lJ-LS
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:49:57 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 28 Feb 2017 18:48:22 +0800
Message-ID: <1488278902-11223-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1488278902-11223-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1488278902-11223-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/3] COLO-compare: Add colo-compare Xen notify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

This patch have some TODO job.
Depend on patch:
https://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg05055.html

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 947a9e2..073d1f8 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -103,6 +103,7 @@ enum {
 static int compare_chr_send(CharBackend *out,
                             const uint8_t *buf,
                             uint32_t size);
+static void colo_flush_packets(void *opaque, void *user_data);
 
 static gint seq_sorter(Packet *a, Packet *b, gpointer data)
 {
@@ -430,6 +431,15 @@ static void colo_compare_connection(void *opaque, void *user_data)
             trace_colo_compare_main("packet different");
             g_queue_push_tail(&conn->primary_list, pkt);
             /* TODO: colo_notify_checkpoint();*/
+            /* If we have notify_dev that means COLO run on Xen */
+            if (s->notify_dev) {
+                char msg[] = "DO_CHECKPOINT";
+                ret = compare_chr_send(&s->chr_notify_dev, (uint8_t *)msg,
+                                       strlen(msg));
+                if (ret < 0) {
+                    error_report("Notify Xen COLO-frame failed");
+                }
+            }
             break;
         }
     }
@@ -645,7 +655,26 @@ static void compare_sec_rs_finalize(SocketReadState *sec_rs)
 
 static void compare_notify_rs_finalize(SocketReadState *notify_rs)
 {
+    CompareState *s = container_of(notify_rs, CompareState, notify_rs);
+
     /* Get Xen colo-frame's notify and handle the message */
+    char *data = g_memdup(notify_rs->buf, notify_rs->packet_len);
+    char msg[] = "COLO_COMPARE_GET_XEN_INIT";
+    int ret;
+
+    if (!strcmp(data, "COLO_USERSPACE_PROXY_INIT")) {
+        ret = compare_chr_send(&s->chr_notify_dev, (uint8_t *)msg,
+                               strlen(msg));
+        if (ret < 0) {
+            error_report("Notify Xen COLO-frame INIT failed");
+        }
+    }
+
+    if (!strcmp(data, "COLO_CHECKPOINT")) {
+        /* colo-compare do checkpoint, flush pri packet and remove sec packet */
+        g_queue_foreach(&s->conn_list, colo_flush_packets, s);
+    }
+
 }
 
 /*
-- 
2.7.4
