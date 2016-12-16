Received: from eggs.gnu.org ([2001:4830:134:3::10]:54137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhongjun@sangfor.com.cn>) id 1cHnwi-0006l8-E1
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhongjun@sangfor.com.cn>) id 1cHnwe-0008Q5-KE
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:32:52 -0500
Received: from m88101.mail.qiye.163.com ([106.2.88.101]:33184)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhongjun@sangfor.com.cn>) id 1cHnvm-0007vL-0E
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:32:48 -0500
From: Junlian Bell <zhongjun@sangfor.com.cn>
Date: Fri, 16 Dec 2016 15:55:27 +0800
Message-Id: <20161216075527.5421-1-zhongjun@sangfor.com.cn>
Subject: [Qemu-devel] [PATCH 1/1] scsi-disk: passthrough VERIFY command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Junlian Bell <zhongjun@sangfor.com.cn>

When a scsi-disk object receives VERIFY command with BYTCHK bit being zero,
scsi_block_is_passthrough returns false and finally makes req being proceeded
by scsi_block_dma_command. Because scsi_block_dma_command has removed process
of VERIFY, QEMU will abort in this function.

This patch makes all VERIFY passthrough to solve this problom.

Signed-off-by: Junlian Bell <zhongjun@sangfor.com.cn>
---
 hw/scsi/scsi-disk.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a96319138a..f30f97f976 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2690,13 +2690,6 @@ static bool scsi_block_is_passthrough(SCSIDiskState *s, uint8_t *buf)
     case VERIFY_10:
     case VERIFY_12:
     case VERIFY_16:
-        /* Check if BYTCHK == 0x01 (data-out buffer contains data
-         * for the number of logical blocks specified in the length
-         * field).  For other modes, do not use scatter/gather operation.
-         */
-        if ((buf[1] & 6) != 2) {
-            return false;
-        }
         break;
 
     case READ_6:
-- 
2.11.0.28.gde2efeb
