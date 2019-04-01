Received: from eggs.gnu.org ([209.51.188.92]:41065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44k-0001XY-Vi
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44k-0003Yr-15
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55616
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB44j-0003SD-SY
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:37 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1pO9095664
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:27 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkswegx6f-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:26 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:24 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:19 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-46-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 45/97] ne2000: fix possible out of bound access
 in ne2000_receive
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

In ne2000_receive(), we try to assign size_ to size which converts
from size_t to integer. This will cause troubles when size_ is greater
INT_MAX, this will lead a negative value in size and it can then pass
the check of size < MIN_BUF_SIZE which may lead out of bound access of
for both buf and buf1.

Fixing by converting the type of size to size_t.

CC: qemu-stable@nongnu.org
Reported-by: Daniel Shapira <daniel@twistlock.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit fdc89e90fac40c5ca2686733df17b6423fb8d8fb)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/ne2000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index 07d79e317f..869518ee06 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -174,7 +174,7 @@ static int ne2000_buffer_full(NE2000State *s)
 ssize_t ne2000_receive(NetClientState *nc, const uint8_t *buf, size_t size_)
 {
     NE2000State *s = qemu_get_nic_opaque(nc);
-    int size = size_;
+    size_t size = size_;
     uint8_t *p;
     unsigned int total_len, next, avail, len, index, mcast_idx;
     uint8_t buf1[60];
@@ -182,7 +182,7 @@ ssize_t ne2000_receive(NetClientState *nc, const uint8_t *buf, size_t size_)
         { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 
 #if defined(DEBUG_NE2000)
-    printf("NE2000: received len=%d\n", size);
+    printf("NE2000: received len=%zu\n", size);
 #endif
 
     if (s->cmd & E8390_STOP || ne2000_buffer_full(s))
-- 
2.17.1
