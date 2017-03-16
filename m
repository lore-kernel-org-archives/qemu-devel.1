Received: from eggs.gnu.org ([2001:4830:134:3::10]:60947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1coS5V-0000fD-Tr
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1coS5V-0005bo-1M
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:52:53 -0400
Received: from [59.151.112.132] (port=49856 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1coS5T-0005b4-PP
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:52:52 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Thu, 16 Mar 2017 17:52:07 +0800
Message-ID: <1489657928-14919-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1489657928-14919-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1489657928-14919-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/3] COLO-proxy: Add a tag to mark virtio-net
 packet
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

Add this tag that compare can recognize virtio-net packet.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo.c | 6 ++++++
 net/colo.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/net/colo.c b/net/colo.c
index 060e822..d2b3683 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -79,6 +79,12 @@ int parse_packet_early(Packet *pkt, int offset)
     }
     pkt->transport_header = pkt->network_header + network_length;
 
+    if (offset == VIRTIO_NET_HEADER) {
+        pkt->is_virtio_net_pkt = true;
+    } else {
+        pkt->is_virtio_net_pkt = false;
+    }
+
     return 0;
 }
 
diff --git a/net/colo.h b/net/colo.h
index b713f87..535793d 100644
--- a/net/colo.h
+++ b/net/colo.h
@@ -46,6 +46,8 @@ typedef struct Packet {
     int size;
     /* Time of packet creation, in wall clock ms */
     int64_t creation_ms;
+    /* Mark this packet as a virtio net packet or not */
+    bool is_virtio_net_pkt;
 } Packet;
 
 typedef struct ConnectionKey {
-- 
2.7.4
