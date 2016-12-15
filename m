Received: from eggs.gnu.org ([2001:4830:134:3::10]:41982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBY-0001kP-9p
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBV-00010p-6k
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53887
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBV-00010T-1L
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:09 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hbeo084815
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:07 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdme90qf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:07 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:06 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:03 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-10-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 09/67] scsi: mptsas: use g_new0 to allocate
 MPTSASRequest object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Li Qiang <liqiang6-s@360.cn>, Prasad J Pandit <pjp@fedoraproject.org>, Paolo Bonzini <pbonzini@redhat.com>

From: Li Qiang <liqiang6-s@360.cn>

When processing IO request in mptsas, it uses g_new to allocate
a 'req' object. If an error occurs before 'req->sreq' is
allocated, It could lead to an OOB write in mptsas_free_request
function. Use g_new0 to avoid it.

Reported-by: Li Qiang <liqiang6-s@360.cn>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-Id: <1473684251-17476-1-git-send-email-ppandit@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 670e56d3ed2918b3861d9216f2c0540d9e9ae0d5)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/scsi/mptsas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 0e0a22f..eaae1bb 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -304,7 +304,7 @@ static int mptsas_process_scsi_io_request(MPTSASState *s,
         goto bad;
     }
 
-    req = g_new(MPTSASRequest, 1);
+    req = g_new0(MPTSASRequest, 1);
     QTAILQ_INSERT_TAIL(&s->pending, req, next);
     req->scsi_io = *scsi_io;
     req->dev = s;
-- 
1.9.1
