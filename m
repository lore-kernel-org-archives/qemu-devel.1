Received: from eggs.gnu.org ([2001:4830:134:3::10]:60712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dIXgM-0000t5-Oj
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dIXgL-0003Wq-L6
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:55:18 -0400
Received: from [59.151.112.132] (port=2726 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dIXgK-0003W8-Od
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:55:17 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Wed, 7 Jun 2017 17:55:16 +0800
Message-ID: <1496829322-17099-5-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1496829322-17099-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1496829322-17099-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V6 04/10] net/net.c: Add vnet_hdr support in
 SocketReadState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, weifuqiang <weifuqiang@huawei.com>, "eddie
	. dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

We add a flag to dicide whether net_fill_rstate() to read
the vnet_hdr_len or not.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Suggested-by: Jason Wang <jasowang@redhat.com>
---
 include/net/net.h   |  6 +++++-
 net/filter-mirror.c |  1 +
 net/net.c           | 33 ++++++++++++++++++++++++++++++---
 3 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 9a92c70..b2167ae 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -112,9 +112,13 @@ typedef struct NICState {
 } NICState;
 
 struct SocketReadState {
-    int state; /* 0 = getting length, 1 = getting data */
+    /* 0 = getting length, 1 = getting vnet header length, 2 = getting data */
+    int state;
+    /* This flag decide whether to read the vnet_hdr_len field */
+    bool vnet_hdr;
     uint32_t index;
     uint32_t packet_len;
+    uint32_t vnet_hdr_len;
     uint8_t buf[NET_BUFSIZE];
     SocketReadStateFinalize *finalize;
 };
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 3413e82..4b03dda 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -267,6 +267,7 @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
     }
 
     net_socket_rs_init(&s->rs, redirector_rs_finalize);
+    s->rs.vnet_hdr = s->vnet_hdr;
 
     if (s->indev) {
         chr = qemu_chr_find(s->indev);
diff --git a/net/net.c b/net/net.c
index 4e7a305..b9b90c9 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1606,8 +1606,10 @@ void net_socket_rs_init(SocketReadState *rs,
                         SocketReadStateFinalize *finalize)
 {
     rs->state = 0;
+    rs->vnet_hdr = false;
     rs->index = 0;
     rs->packet_len = 0;
+    rs->vnet_hdr_len = 0;
     memset(rs->buf, 0, sizeof(rs->buf));
     rs->finalize = finalize;
 }
@@ -1622,8 +1624,12 @@ int net_fill_rstate(SocketReadState *rs, const uint8_t *buf, int size)
     unsigned int l;
 
     while (size > 0) {
-        /* reassemble a packet from the network */
-        switch (rs->state) { /* 0 = getting length, 1 = getting data */
+        /* Reassemble a packet from the network.
+         * 0 = getting length.
+         * 1 = getting vnet header length.
+         * 2 = getting data.
+         */
+        switch (rs->state) {
         case 0:
             l = 4 - rs->index;
             if (l > size) {
@@ -1637,10 +1643,31 @@ int net_fill_rstate(SocketReadState *rs, const uint8_t *buf, int size)
                 /* got length */
                 rs->packet_len = ntohl(*(uint32_t *)rs->buf);
                 rs->index = 0;
-                rs->state = 1;
+                if (rs->vnet_hdr) {
+                    rs->state = 1;
+                } else {
+                    rs->state = 2;
+                    rs->vnet_hdr_len = 0;
+                }
             }
             break;
         case 1:
+            l = 4 - rs->index;
+            if (l > size) {
+                l = size;
+            }
+            memcpy(rs->buf + rs->index, buf, l);
+            buf += l;
+            size -= l;
+            rs->index += l;
+            if (rs->index == 4) {
+                /* got vnet header length */
+                rs->vnet_hdr_len = ntohl(*(uint32_t *)rs->buf);
+                rs->index = 0;
+                rs->state = 2;
+            }
+            break;
+        case 2:
             l = rs->packet_len - rs->index;
             if (l > size) {
                 l = size;
-- 
2.7.4
