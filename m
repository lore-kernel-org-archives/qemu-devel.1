Received: from eggs.gnu.org ([2001:4830:134:3::10]:35406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1e2tZf-00080m-5B
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 02:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1e2tZd-0004wL-Ly
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 02:35:59 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47186
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1e2tZd-0004vF-BI
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 02:35:57 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Fri, 13 Oct 2017 14:32:09 +0800
Message-ID: <20171013063209.15617-5-maozy.fnst@cn.fujitsu.com>
In-Reply-To: <20171013063209.15617-1-maozy.fnst@cn.fujitsu.com>
References: <20171013063209.15617-1-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/4] colo: Consolidate the duplicate code chunk
 into a routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

Consolidate the code that extract the ip address(src,dst) and
port number(src,dst) of the packet into a separate routine
extract_ip_and_port() since the same chunk of code is called
from two place.

Cc: Zhang Chen <zhangckid@gmail.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 net/colo.c | 18 ++++++++++--------
 net/colo.h |  1 +
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/colo.c b/net/colo.c
index 28ce7c8..a39d600 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -82,6 +82,14 @@ int parse_packet_early(Packet *pkt)
     return 0;
 }
 
+void extract_ip_and_port(uint32_t tmp_ports, ConnectionKey *key, Packet *pkt)
+{
+        key->src = pkt->ip->ip_src;
+        key->dst = pkt->ip->ip_dst;
+        key->src_port = ntohs(tmp_ports >> 16);
+        key->dst_port = ntohs(tmp_ports & 0xffff);
+}
+
 void fill_connection_key(Packet *pkt, ConnectionKey *key)
 {
     uint32_t tmp_ports;
@@ -97,17 +105,11 @@ void fill_connection_key(Packet *pkt, ConnectionKey *key)
     case IPPROTO_SCTP:
     case IPPROTO_UDPLITE:
         tmp_ports = *(uint32_t *)(pkt->transport_header);
-        key->src = pkt->ip->ip_src;
-        key->dst = pkt->ip->ip_dst;
-        key->src_port = ntohs(tmp_ports & 0xffff);
-        key->dst_port = ntohs(tmp_ports >> 16);
+        extract_ip_and_port(tmp_ports, key, pkt);
         break;
     case IPPROTO_AH:
         tmp_ports = *(uint32_t *)(pkt->transport_header + 4);
-        key->src = pkt->ip->ip_src;
-        key->dst = pkt->ip->ip_dst;
-        key->src_port = ntohs(tmp_ports & 0xffff);
-        key->dst_port = ntohs(tmp_ports >> 16);
+        extract_ip_and_port(tmp_ports, key, pkt);
         break;
     default:
         break;
diff --git a/net/colo.h b/net/colo.h
index caedb0d..0658e86 100644
--- a/net/colo.h
+++ b/net/colo.h
@@ -76,6 +76,7 @@ typedef struct Connection {
 uint32_t connection_key_hash(const void *opaque);
 int connection_key_equal(const void *opaque1, const void *opaque2);
 int parse_packet_early(Packet *pkt);
+void extract_ip_and_port(uint32_t tmp_ports, ConnectionKey *key, Packet *pkt);
 void fill_connection_key(Packet *pkt, ConnectionKey *key);
 void reverse_connection_key(ConnectionKey *key);
 Connection *connection_new(ConnectionKey *key);
-- 
2.9.4
