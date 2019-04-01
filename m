Received: from eggs.gnu.org ([209.51.188.92]:43540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47z-0004cD-CG
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47v-0005cE-Hv
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB47s-0005Pv-FT
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:53 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L5IsM006165
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:05:27 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkqrc0804-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:05:23 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:28 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:22 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-49-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 48/97] net: ignore packet size greater than
 INT_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>

From: Jason Wang <jasowang@redhat.com>

There should not be a reason for passing a packet size greater than
INT_MAX. It's usually a hint of bug somewhere, so ignore packet size
greater than INT_MAX in qemu_deliver_packet_iov()

CC: qemu-stable@nongnu.org
Reported-by: Daniel Shapira <daniel@twistlock.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 1592a9947036d60dde5404204a5d45975133caf5)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 net/net.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/net.c b/net/net.c
index 2a3133990c..46db72811b 100644
--- a/net/net.c
+++ b/net/net.c
@@ -712,10 +712,15 @@ ssize_t qemu_deliver_packet_iov(NetClientState *sender,
                                 void *opaque)
 {
     NetClientState *nc = opaque;
+    size_t size = iov_size(iov, iovcnt);
     int ret;
 
+    if (size > INT_MAX) {
+        return size;
+    }
+
     if (nc->link_down) {
-        return iov_size(iov, iovcnt);
+        return size;
     }
 
     if (nc->receive_disabled) {
-- 
2.17.1
