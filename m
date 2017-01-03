Received: from eggs.gnu.org ([2001:4830:134:3::10]:60113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cOSmu-00044c-53
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cOSmp-000105-Vi
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:22:16 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  3 Jan 2017 18:22:10 +0100
Message-Id: <20170103172210.26034-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] scsi-block: fix direction of BYTCHK test for
 VERIFY commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Qian <zhangqian@sangfor.com.cn>, qemu-stable@nongnu.org

The direction is wrong; scsi_block_is_passthrough returns
false for commands that *can* use sglists.

Reported-by: Zhang Qian <zhangqian@sangfor.com.cn>
Fixes: 8fdc7839e40f43a426bc7e858cf1dbfe315a3804
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index bdd1e5f..c080888 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2701,7 +2701,7 @@ static bool scsi_block_is_passthrough(SCSIDiskState *s, uint8_t *buf)
          * for the number of logical blocks specified in the length
          * field).  For other modes, do not use scatter/gather operation.
          */
-        if ((buf[1] & 6) != 2) {
+        if ((buf[1] & 6) == 2) {
             return false;
         }
         break;
-- 
2.9.3
