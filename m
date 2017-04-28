Received: from eggs.gnu.org ([2001:4830:134:3::10]:33858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Ux-0004f0-5h
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Ut-0001U6-DM
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:35 -0400
Received: from [59.151.112.132] (port=49865 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Ut-0001QD-0o
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:31 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 28 Apr 2017 17:47:17 +0800
Message-ID: <1493372840-24551-8-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V3 07/10] tests/virtio-net-test.c : change
 virtio-net test case iov send data format
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

Because we change net_fill_rstate() date format from
struct {int size; const uint8_t buf[];} to {int size; int vnet_hdr_len; const uint8_t buf[];}.
So, we add fake vnet_hdr_len in virtio-net test case.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 tests/virtio-net-test.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 8f94360..93f4fe0 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -89,11 +89,15 @@ static void rx_test(QVirtioDevice *dev,
     char test[] = "TEST";
     char buffer[64];
     int len = htonl(sizeof(test));
+    int vnet_hdr_len = 0;
     struct iovec iov[] = {
         {
             .iov_base = &len,
             .iov_len = sizeof(len),
         }, {
+            .iov_base = &vnet_hdr_len,
+            .iov_len = sizeof(vnet_hdr_len),
+        }, {
             .iov_base = test,
             .iov_len = sizeof(test),
         },
@@ -105,8 +109,9 @@ static void rx_test(QVirtioDevice *dev,
     free_head = qvirtqueue_add(vq, req_addr, 64, true, false);
     qvirtqueue_kick(dev, vq, free_head);
 
-    ret = iov_send(socket, iov, 2, 0, sizeof(len) + sizeof(test));
-    g_assert_cmpint(ret, ==, sizeof(test) + sizeof(len));
+    ret = iov_send(socket, iov, 3, 0, sizeof(len)
+                   + sizeof(test) + sizeof(vnet_hdr_len));
+    g_assert_cmpint(ret, ==, sizeof(test) + sizeof(len) + sizeof(vnet_hdr_len));
 
     qvirtio_wait_queue_isr(dev, vq, QVIRTIO_NET_TIMEOUT_US);
     memread(req_addr + VNET_HDR_SIZE, buffer, sizeof(test));
@@ -151,12 +156,16 @@ static void rx_stop_cont_test(QVirtioDevice *dev,
     char test[] = "TEST";
     char buffer[64];
     int len = htonl(sizeof(test));
+    int vnet_hdr_len = 0;
     QDict *rsp;
     struct iovec iov[] = {
         {
             .iov_base = &len,
             .iov_len = sizeof(len),
         }, {
+            .iov_base = &vnet_hdr_len,
+            .iov_len = sizeof(vnet_hdr_len),
+        }, {
             .iov_base = test,
             .iov_len = sizeof(test),
         },
@@ -171,8 +180,9 @@ static void rx_stop_cont_test(QVirtioDevice *dev,
     rsp = qmp("{ 'execute' : 'stop'}");
     QDECREF(rsp);
 
-    ret = iov_send(socket, iov, 2, 0, sizeof(len) + sizeof(test));
-    g_assert_cmpint(ret, ==, sizeof(test) + sizeof(len));
+    ret = iov_send(socket, iov, 3, 0, sizeof(len)
+                   + sizeof(test) + sizeof(vnet_hdr_len));
+    g_assert_cmpint(ret, ==, sizeof(test) + sizeof(len) + sizeof(vnet_hdr_len));
 
     /* We could check the status, but this command is more importantly to
      * ensure the packet data gets queued in QEMU, before we do 'cont'.
-- 
2.7.4
