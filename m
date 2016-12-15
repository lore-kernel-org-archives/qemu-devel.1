Received: from eggs.gnu.org ([2001:4830:134:3::10]:43630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCU-0005DH-15
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCQ-0001kz-Ut
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKCQ-0001kD-K2
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:06 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hbrg064495
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:47:05 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bgh8h474-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:47:05 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:47:04 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:59 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-66-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 65/67] Revert "megasas: remove useless check
 for cmd->frame"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

This reverts commit 8cc46787b5b58f01a11c919c7ff939ed009e27fc.
It turns out that cmd->frame can be NULL and thus the commit
can cause a SIGSEGV

Reported-by: Holger Schranz <holger@fam-schranz.de>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 421cc3e7e89cb807d3c5f6de486abb2167c8e792)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/scsi/megasas.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index e968302..52a4123 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -1981,7 +1981,11 @@ static void megasas_handle_frame(MegasasState *s, uint64_t frame_addr,
         break;
     }
     if (frame_status != MFI_STAT_INVALID_STATUS) {
-        cmd->frame->header.cmd_status = frame_status;
+        if (cmd->frame) {
+            cmd->frame->header.cmd_status = frame_status;
+        } else {
+            megasas_frame_set_cmd_status(s, frame_addr, frame_status);
+        }
         megasas_unmap_frame(s, cmd);
         megasas_complete_frame(s, cmd->context);
     }
-- 
1.9.1
