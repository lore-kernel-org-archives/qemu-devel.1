Received: from eggs.gnu.org ([2001:4830:134:3::10]:33861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Ux-0004f3-6F
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Uu-0001VY-Ez
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:35 -0400
Received: from [59.151.112.132] (port=49865 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Uu-0001QD-3b
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:32 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 28 Apr 2017 17:47:16 +0800
Message-ID: <1493372840-24551-7-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V3 06/10] tests/e1000e-test.c : change e1000e
 test case send data format
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
So, we add fake vnet_hdr_len in e1000e test case.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 tests/e1000e-test.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
index c612dc6..fb3bd77 100644
--- a/tests/e1000e-test.c
+++ b/tests/e1000e-test.c
@@ -329,11 +329,15 @@ static void e1000e_receive_verify(e1000e_device *d)
 
     char test[] = "TEST";
     int len = htonl(sizeof(test));
+    int vnet_hdr_len = 0;
     struct iovec iov[] = {
         {
             .iov_base = &len,
             .iov_len = sizeof(len),
         },{
+            .iov_base = &vnet_hdr_len,
+            .iov_len = sizeof(vnet_hdr_len),
+        },{
             .iov_base = test,
             .iov_len = sizeof(test),
         },
@@ -344,8 +348,10 @@ static void e1000e_receive_verify(e1000e_device *d)
     int ret;
 
     /* Send a dummy packet to device's socket*/
-    ret = iov_send(test_sockets[0], iov, 2, 0, sizeof(len) + sizeof(test));
-    g_assert_cmpint(ret, == , sizeof(test) + sizeof(len));
+    ret = iov_send(test_sockets[0], iov, 3, 0, sizeof(len)
+                   + sizeof(vnet_hdr_len) + sizeof(test));
+    g_assert_cmpint(ret, == , sizeof(test) + sizeof(len)
+                    + sizeof(vnet_hdr_len));
 
     /* Prepare test data buffer */
     uint64_t data = guest_alloc(test_alloc, data_len);
-- 
2.7.4
