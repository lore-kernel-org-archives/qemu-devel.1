Received: from eggs.gnu.org ([2001:4830:134:3::10]:41037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d15k2-0004Vr-Ma
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d15k1-0005Uz-Qk
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:38:58 -0400
Received: from [59.151.112.132] (port=46559 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d15k1-0005Uj-E1
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:38:57 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Thu, 20 Apr 2017 14:39:04 +0800
Message-ID: <1492670346-18004-5-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1492670346-18004-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1492670346-18004-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V2 4/6] net/socket.c: Add vnet packet support
 in net_socket_receive()
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

Because of net_socket_send() add vnet header length argument,
Avoid conflict with net_socket_send().

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/socket.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/socket.c b/net/socket.c
index fe3547b..1f1f3d2 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -33,6 +33,7 @@
 #include "qemu/sockets.h"
 #include "qemu/iov.h"
 #include "qemu/main-loop.h"
+#include "hw/virtio/virtio-net.h"
 
 typedef struct NetSocketState {
     NetClientState nc;
@@ -81,12 +82,17 @@ static void net_socket_writable(void *opaque)
 static ssize_t net_socket_receive(NetClientState *nc, const uint8_t *buf, size_t size)
 {
     NetSocketState *s = DO_UPCAST(NetSocketState, nc, nc);
+    VirtIONet *n = qemu_get_nic_opaque(nc->peer);
     uint32_t len = htonl(size);
+    uint32_t vnet_hdr_len = htonl(n->guest_hdr_len);
     struct iovec iov[] = {
         {
             .iov_base = &len,
             .iov_len  = sizeof(len),
         }, {
+            .iov_base = &vnet_hdr_len,
+            .iov_len  = sizeof(vnet_hdr_len),
+        }, {
             .iov_base = (void *)buf,
             .iov_len  = size,
         },
-- 
2.7.4
