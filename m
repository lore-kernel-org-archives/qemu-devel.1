Received: from eggs.gnu.org ([2001:4830:134:3::10]:57443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gBGc1-0002hl-6f
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 05:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gBGc0-00015T-2s
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 05:53:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gBGbz-00015D-TE
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 05:53:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49A353084217
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 09:53:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 13 Oct 2018 11:53:23 +0200
Message-Id: <1539424403-2884-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539424403-2884-1-git-send-email-pbonzini@redhat.com>
References: <1539424403-2884-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] scsi-disk: fix rerror/werror=ignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

rerror=ignore was returning true from scsi_handle_rw_error but the callers were not
calling scsi_req_complete when rerror=ignore returns true (this is the correct thing
to do when true is returned after executing a passthrough command).  Fix this by
calling it in scsi_handle_rw_error.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 4074d7c..e2c5408 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -473,10 +473,15 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
     }
 
     blk_error_action(s->qdev.conf.blk, action, is_read, error);
+    if (action == BLOCK_ERROR_ACTION_IGNORE) {
+        scsi_req_complete(&r->req, 0);
+        return true;
+    }
+
     if (action == BLOCK_ERROR_ACTION_STOP) {
         scsi_req_retry(&r->req);
     }
-    return action != BLOCK_ERROR_ACTION_IGNORE;
+    return false;
 }
 
 static void scsi_write_complete_noio(SCSIDiskReq *r, int ret)
-- 
1.8.3.1
