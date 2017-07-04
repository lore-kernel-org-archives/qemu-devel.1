Received: from eggs.gnu.org ([2001:4830:134:3::10]:43931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhh-0003he-1t
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhd-00072T-80
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:57 -0400
Received: from [59.151.112.132] (port=28283 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhc-0006vy-Rt
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:53 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 4 Jul 2017 14:53:47 +0800
Message-ID: <1499151236-14671-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1499151236-14671-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1499151236-14671-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V7 03/12] net/filter-mirror.c: Introduce
 parameter for filter_send()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

This patch change the filter_send() parameter from CharBackend to MirrorState,
we can get more information like vnet_hdr(We use it to support packet with vnet_header).

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/filter-mirror.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index b67f0fb..69cf4ca 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -43,7 +43,7 @@ typedef struct MirrorState {
     SocketReadState rs;
 } MirrorState;
 
-static int filter_send(CharBackend *chr_out,
+static int filter_send(MirrorState *s,
                        const struct iovec *iov,
                        int iovcnt)
 {
@@ -58,14 +58,14 @@ static int filter_send(CharBackend *chr_out,
     }
 
     len = htonl(size);
-    ret = qemu_chr_fe_write_all(chr_out, (uint8_t *)&len, sizeof(len));
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
@@ -141,7 +141,7 @@ static ssize_t filter_mirror_receive_iov(NetFilterState *nf,
     MirrorState *s = FILTER_MIRROR(nf);
     int ret;
 
-    ret = filter_send(&s->chr_out, iov, iovcnt);
+    ret = filter_send(s, iov, iovcnt);
     if (ret) {
         error_report("filter mirror send failed(%s)", strerror(-ret));
     }
@@ -164,7 +164,7 @@ static ssize_t filter_redirector_receive_iov(NetFilterState *nf,
     int ret;
 
     if (qemu_chr_fe_get_driver(&s->chr_out)) {
-        ret = filter_send(&s->chr_out, iov, iovcnt);
+        ret = filter_send(s, iov, iovcnt);
         if (ret) {
             error_report("filter redirector send failed(%s)", strerror(-ret));
         }
-- 
2.7.4
