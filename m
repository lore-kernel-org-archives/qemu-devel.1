Received: from eggs.gnu.org ([2001:4830:134:3::10]:40989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d15jz-0004U9-5F
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d15jw-0005T6-1b
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:38:55 -0400
Received: from [59.151.112.132] (port=59779 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d15jv-0005Sl-3y
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:38:51 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Thu, 20 Apr 2017 14:39:02 +0800
Message-ID: <1492670346-18004-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1492670346-18004-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1492670346-18004-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V2 2/6] net/net.c: Add vnet header length to
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
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Address Jason Wang's comments add vnet header length to SocketReadState.
So we change net_fill_rstate() to read
struct  {int size; int vnet_hdr_len; const uint8_t buf[];}.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 include/net/net.h |  4 +++-
 net/net.c         | 24 ++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 99b28d5..1204fe5 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -111,9 +111,11 @@ typedef struct NICState {
 } NICState;
 
 struct SocketReadState {
-    int state; /* 0 = getting length, 1 = getting data */
+    /* 0 = getting length, 1 = getting vnet header length, 2 = getting data */
+    int state;
     uint32_t index;
     uint32_t packet_len;
+    uint32_t vnet_hdr_len;
     uint8_t buf[NET_BUFSIZE];
     SocketReadStateFinalize *finalize;
 };
diff --git a/net/net.c b/net/net.c
index 0ac3b9e..d467452 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1621,8 +1621,12 @@ int net_fill_rstate(SocketReadState *rs, const uint8_t *buf, int size)
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
@@ -1640,6 +1644,22 @@ int net_fill_rstate(SocketReadState *rs, const uint8_t *buf, int size)
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
