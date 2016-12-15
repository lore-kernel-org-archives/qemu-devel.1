Received: from eggs.gnu.org ([2001:4830:134:3::10]:42247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBj-0002H0-St
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBg-0001AY-Q1
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBg-00019k-GY
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:20 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0jnBH130293
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:19 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdku12et-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:19 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 19:46:18 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:14 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-21-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 20/67] ahci: clear aiocb in ncq_cb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>

From: John Snow <jsnow@redhat.com>

Similar to existing fixes for IDE (87ac25fd) and ATAPI (7f951b2d), the
AIOCB must be cleared in the callback. Otherwise, we may accidentally
try to reset a dangling pointer in bdrv_aio_cancel() from a port reset.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 1474575040-32079-2-git-send-email-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit df403bc58859c893ebd0accda07678e84d15dc5d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ide/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index f3438ad..63ead21 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -948,6 +948,7 @@ static void ncq_cb(void *opaque, int ret)
     NCQTransferState *ncq_tfs = (NCQTransferState *)opaque;
     IDEState *ide_state = &ncq_tfs->drive->port.ifs[0];
 
+    ncq_tfs->aiocb = NULL;
     if (ret == -ECANCELED) {
         return;
     }
-- 
1.9.1
