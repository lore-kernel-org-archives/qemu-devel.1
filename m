Received: from eggs.gnu.org ([2001:4830:134:3::10]:41824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6R5-00026G-5m
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qv-0005HV-VG
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47305
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qv-0005GS-N4
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:49 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8WlM084372
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:49 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29amb2abca-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:48 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:48 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:39 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-76-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 75/81] NetRxPkt: Do not try to pull more data
 than present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>

From: Dmitry Fleytman <dmitry@daynix.com>

In case of VLAN stripping, ETH header put into a
separate buffer, therefore amont of data copied
from original IOV should be smaller.

Cc: qemu-stable@nongnu.org
Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit d5e772146d2bbc92e5126c145eddef3b2843d026)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/net_rx_pkt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 7c0beac..d38babe 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -96,7 +96,8 @@ net_rx_pkt_pull_data(struct NetRxPkt *pkt,
 
         pkt->tot_len = iov_size(iov, iovcnt) - ploff + pkt->ehdr_buf_len;
         pkt->vec_len = iov_copy(pkt->vec + 1, pkt->vec_len_total - 1,
-                                iov, iovcnt, ploff, pkt->tot_len);
+                                iov, iovcnt, ploff,
+                                pkt->tot_len - pkt->ehdr_buf_len);
     } else {
         net_rx_pkt_iovec_realloc(pkt, iovcnt);
 
-- 
2.7.4
