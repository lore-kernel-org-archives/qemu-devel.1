Received: from eggs.gnu.org ([2001:4830:134:3::10]:42121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBe-00020N-Kg
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBb-00016T-Hm
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBb-00015f-7Q
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:15 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hbtx129178
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:14 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdkw907c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:14 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 19:46:12 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:08 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-15-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 14/67] scsi: mptconfig: fix an assert expression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, Paolo Bonzini <pbonzini@redhat.com>

From: Prasad J Pandit <pjp@fedoraproject.org>

When LSI SAS1068 Host Bus emulator builds configuration page
headers, mptsas_config_pack() should assert that the size
fits in a byte.  However, the size is expressed in 32-bit
units, so up to 1020 bytes fit.  The assertion was only
allowing replies up to 252 bytes, so fix it.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-Id: <1472645167-30765-2-git-send-email-ppandit@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit cf2bce203a45d7437029d108357fb23fea0967b6)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/scsi/mptconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/mptconfig.c b/hw/scsi/mptconfig.c
index 7071854..3e4f400 100644
--- a/hw/scsi/mptconfig.c
+++ b/hw/scsi/mptconfig.c
@@ -158,7 +158,7 @@ static size_t mptsas_config_pack(uint8_t **data, const char *fmt, ...)
     va_end(ap);
 
     if (data) {
-        assert(ret < 256 && (ret % 4) == 0);
+        assert(ret / 4 < 256 && (ret % 4) == 0);
         stb_p(*data + 1, ret / 4);
     }
     return ret;
-- 
1.9.1
