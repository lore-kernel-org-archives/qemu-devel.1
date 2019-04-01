Received: from eggs.gnu.org ([209.51.188.92]:41110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44n-0001as-PH
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44m-0003aT-Pl
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB44m-0003TJ-BS
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:40 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L29rA119029
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:29 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkqt605h5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:27 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:25 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:21 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-48-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 47/97] pcnet: fix possible buffer overflow
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

In pcnet_receive(), we try to assign size_ to size which converts from
size_t to integer. This will cause troubles when size_ is greater
INT_MAX, this will lead a negative value in size and it can then pass
the check of size < MIN_BUF_SIZE which may lead out of bound access
for both buf and buf1.

Fixing by converting the type of size to size_t.

CC: qemu-stable@nongnu.org
Reported-by: Daniel Shapira <daniel@twistlock.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit b1d80d12c5f7ff081bb80ab4f4241d4248691192)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/pcnet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index 0c44554168..d9ba04bdfc 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -988,14 +988,14 @@ ssize_t pcnet_receive(NetClientState *nc, const uint8_t *buf, size_t size_)
     uint8_t buf1[60];
     int remaining;
     int crc_err = 0;
-    int size = size_;
+    size_t size = size_;
 
     if (CSR_DRX(s) || CSR_STOP(s) || CSR_SPND(s) || !size ||
         (CSR_LOOP(s) && !s->looptest)) {
         return -1;
     }
 #ifdef PCNET_DEBUG
-    printf("pcnet_receive size=%d\n", size);
+    printf("pcnet_receive size=%zu\n", size);
 #endif
 
     /* if too small buffer, then expand it */
-- 
2.17.1
