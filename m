Received: from eggs.gnu.org ([2001:4830:134:3::10]:48256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52I-0000Zk-TI
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52H-0007x1-VV
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dX52H-0007vv-Pr
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:01 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jul 2017 20:21:34 +0800
Message-Id: <1500294105-13713-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
References: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 03/14] net/filter-mirror.c: Introduce parameter
 for filter_send()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

This patch change the filter_send() parameter from CharBackend to MirrorState,
we can get more information like vnet_hdr(We use it to support packet with vnet_header).

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/filter-mirror.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 1b6211b..e8e5b60 100644
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
 
     if (qemu_chr_fe_backend_connected(&s->chr_out)) {
-        ret = filter_send(&s->chr_out, iov, iovcnt);
+        ret = filter_send(s, iov, iovcnt);
         if (ret) {
             error_report("filter redirector send failed(%s)", strerror(-ret));
         }
-- 
2.7.4
