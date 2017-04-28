Received: from eggs.gnu.org ([2001:4830:134:3::10]:33887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Ux-0004f8-T8
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Uv-0001WK-IF
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:35 -0400
Received: from [59.151.112.132] (port=49865 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Uv-0001QD-63
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:33 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 28 Apr 2017 17:47:20 +0800
Message-ID: <1493372840-24551-11-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V3 10/10] net/colo-compare.c: Add vnet packet's
 tcp/udp/icmp compare
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

COLO-Proxy just focus on packet payload, So we skip vnet header.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index b3e933c..1941ad9 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -187,6 +187,8 @@ static int packet_enqueue(CompareState *s, int mode)
  */
 static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, int offset)
 {
+    int offset_all;
+
     if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
         char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_dst[20];
 
@@ -200,9 +202,12 @@ static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, int offset)
                                    sec_ip_src, sec_ip_dst);
     }
 
+    offset_all = ppkt->vnet_hdr_len + offset;
+
     if (ppkt->size == spkt->size) {
-        return memcmp(ppkt->data + offset, spkt->data + offset,
-                      spkt->size - offset);
+        return memcmp(ppkt->data + offset_all,
+                      spkt->data + offset_all,
+                      spkt->size - offset_all);
     } else {
         trace_colo_compare_main("Net packet size are not the same");
         return -1;
-- 
2.7.4
