Received: from eggs.gnu.org ([2001:4830:134:3::10]:49148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCJ-0000Yb-0r
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCF-0000Se-TD
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCF-0000RU-JY
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:31 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JFjhS143508
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:30 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epmh3e34s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:30 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:29 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:20 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-28-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 27/55] memory: fix off-by-one error in
 memory_region_notify_one()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Maxime Coquelin <maxime.coquelin@redhat.com>

This patch fixes an off-by-one error that could lead to the
notifyee to receive notifications for ranges it is not
registered to.

The bug has been spotted by code review.

Fixes: bd2bfa4c52e5 ("memory: introduce memory_region_notify_one()")
Cc: qemu-stable@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-Id: <20171010094247.10173-4-maxime.coquelin@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit b021d1c04452276f4926eed2d104ccbd1037a6e1)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/memory.c b/memory.c
index d90853855b..d05a80aba5 100644
--- a/memory.c
+++ b/memory.c
@@ -1891,7 +1891,7 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
      * Skip the notification if the notification does not overlap
      * with registered range.
      */
-    if (notifier->start > entry->iova + entry->addr_mask + 1 ||
+    if (notifier->start > entry->iova + entry->addr_mask ||
         notifier->end < entry->iova) {
         return;
     }
-- 
2.11.0
