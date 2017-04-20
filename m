Received: from eggs.gnu.org ([2001:4830:134:3::10]:41016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d15k0-0004UC-4H
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d15jz-0005UF-5Q
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:38:56 -0400
Received: from [59.151.112.132] (port=35327 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d15jx-0005TG-M1
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:38:55 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Thu, 20 Apr 2017 14:39:01 +0800
Message-ID: <1492670346-18004-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1492670346-18004-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1492670346-18004-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V2 1/6] net/filter-mirror.c: Add filter-mirror
 and filter-redirector vnet support.
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

In this patch, we change the send packet format from
struct {int size; const uint8_t buf[];} to {int size; int vnet_hdr_len; const uint8_t buf[];}.
make other module(like colo-compare) know how to parse net packet correctly.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/filter-mirror.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 72fa7c2..5b4d616 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -23,6 +23,7 @@
 #include "sysemu/char.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
+#include "hw/virtio/virtio-net.h"
 
 #define FILTER_MIRROR(obj) \
     OBJECT_CHECK(MirrorState, (obj), TYPE_FILTER_MIRROR)
@@ -43,12 +44,15 @@ typedef struct MirrorState {
     SocketReadState rs;
 } MirrorState;
 
-static int filter_mirror_send(CharBackend *chr_out,
+static int filter_mirror_send(MirrorState *s,
                               const struct iovec *iov,
                               int iovcnt)
 {
+    NetFilterState *nf = NETFILTER(s);
+    VirtIONet *n = qemu_get_nic_opaque(nf->netdev->peer);
     int ret = 0;
     ssize_t size = 0;
+    ssize_t vnet_hdr_len;
     uint32_t len = 0;
     char *buf;
 
@@ -58,14 +62,25 @@ static int filter_mirror_send(CharBackend *chr_out,
     }
 
     len = htonl(size);
-    ret = qemu_chr_fe_write_all(chr_out, (uint8_t *)&len, sizeof(len));
+    ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof(len));
+    if (ret != sizeof(len)) {
+        goto err;
+    }
+
+    /*
+     * We send vnet header len make other module(like colo-compare)
+     * know how to parse net packet correctly.
+     */
+    vnet_hdr_len = n->guest_hdr_len;
+    len = htonl(vnet_hdr_len);
+    ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof(len));
     if (ret != sizeof(len)) {
         goto err;
     }
 
     buf = g_malloc(size);
     iov_to_buf(iov, iovcnt, 0, buf, size);
-    ret = qemu_chr_fe_write_all(chr_out, (uint8_t *)buf, size);
+    ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, size);
     g_free(buf);
     if (ret != size) {
         goto err;
@@ -141,7 +156,7 @@ static ssize_t filter_mirror_receive_iov(NetFilterState *nf,
     MirrorState *s = FILTER_MIRROR(nf);
     int ret;
 
-    ret = filter_mirror_send(&s->chr_out, iov, iovcnt);
+    ret = filter_mirror_send(s, iov, iovcnt);
     if (ret) {
         error_report("filter_mirror_send failed(%s)", strerror(-ret));
     }
@@ -164,7 +179,7 @@ static ssize_t filter_redirector_receive_iov(NetFilterState *nf,
     int ret;
 
     if (qemu_chr_fe_get_driver(&s->chr_out)) {
-        ret = filter_mirror_send(&s->chr_out, iov, iovcnt);
+        ret = filter_mirror_send(s, iov, iovcnt);
         if (ret) {
             error_report("filter_mirror_send failed(%s)", strerror(-ret));
         }
-- 
2.7.4
