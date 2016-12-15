Received: from eggs.gnu.org ([2001:4830:134:3::10]:42767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC2-0003SR-L5
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC0-0001PF-41
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBz-0001ON-PW
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:40 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0ha6G047943
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:38 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm3s3he-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:38 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:37 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:33 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-40-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 39/67] net: rtl8139: limit processing of ring
 descriptors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, Jason Wang <jasowang@redhat.com>

From: Prasad J Pandit <pjp@fedoraproject.org>

RTL8139 ethernet controller in C+ mode supports multiple
descriptor rings, each with maximum of 64 descriptors. While
processing transmit descriptor ring in 'rtl8139_cplus_transmit',
it does not limit the descriptor count and runs forever. Add
check to avoid it.

Reported-by: Andrew Henderson <hendersa@icculus.org>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit c7c35916692fe010fef25ac338443d3fe40be225)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/rtl8139.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 3345bc6..f05e59c 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -2350,7 +2350,7 @@ static void rtl8139_cplus_transmit(RTL8139State *s)
 {
     int txcount = 0;
 
-    while (rtl8139_cplus_transmit_one(s))
+    while (txcount < 64 && rtl8139_cplus_transmit_one(s))
     {
         ++txcount;
     }
-- 
1.9.1
