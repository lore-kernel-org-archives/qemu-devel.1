Received: from eggs.gnu.org ([2001:4830:134:3::10]:36108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dVX3v-0007O6-FF
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 01:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dVX3s-0006G0-CU
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 01:53:19 -0400
Received: from [59.151.112.132] (port=25092 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dVX3r-0006C3-Vt
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 01:53:16 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Thu, 13 Jul 2017 13:52:53 +0800
Message-ID: <1499925175-21218-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1499925175-21218-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1499925175-21218-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V2 2/4] net/colo-compare.c: Compare the tcp
 packets that has the same sequence number
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

If primary packet's sequence number not same with secondary packet's
sequence number, no need to compare the packet other field.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 0f8e198..2caeb80 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -222,6 +222,12 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
     ptcp = (struct tcphdr *)ppkt->transport_header;
     stcp = (struct tcphdr *)spkt->transport_header;
 
+    if ((ptcp->th_flags & TH_SYN) != TH_SYN &&
+        ptcp->th_seq != stcp->th_seq) {
+        trace_colo_compare_main("colo_packet_compare_tcp seq not same");
+        return -1;
+    }
+
     /*
      * The 'identification' field in the IP header is *very* random
      * it almost never matches.  Fudge this by ignoring differences in
-- 
2.7.4
