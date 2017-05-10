Received: from eggs.gnu.org ([2001:4830:134:3::10]:60228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1d8PZK-0003L5-FZ
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:14:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1d8PZG-0004yb-3T
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:14:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1d8PZF-0004yQ-T8
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:14:06 -0400
From: P J P <ppandit@redhat.com>
Date: Wed, 10 May 2017 16:43:50 +0530
Message-Id: <20170510111350.18422-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] scsi: megasas: check request object in
 MegasasCmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhangyanyu <zyy4013@stu.ouc.edu.cn>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

When processing completed commands, if SCSIRequest object
'cmd->req' was null, it could lead to null pointer dereference
in megasas_complete_command. Add check to avoid it.

Reported-by: Zhangyanyu <zyy4013@stu.ouc.edu.cn>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/scsi/megasas.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 84b8caf..25e3541 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -580,9 +580,11 @@ static void megasas_complete_command(MegasasCmd *cmd)
     cmd->iov_size = 0;
     cmd->iov_offset = 0;
 
-    cmd->req->hba_private = NULL;
-    scsi_req_unref(cmd->req);
-    cmd->req = NULL;
+    if (cmd->req) {
+        cmd->req->hba_private = NULL;
+        scsi_req_unref(cmd->req);
+        cmd->req = NULL;
+    }
 
     megasas_unmap_frame(cmd->state, cmd);
     megasas_complete_frame(cmd->state, cmd->context);
-- 
2.9.3
