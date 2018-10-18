Received: from eggs.gnu.org ([2001:4830:134:3::10]:48220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyO-0007Pr-6c
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyL-0006PF-LS
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:46 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:56242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyL-0006MV-7a
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:45 -0400
Received: by mail-wm1-x336.google.com with SMTP id 206-v6so1557281wmb.5
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:43 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-231-174.clienti.tiscali.it.
	[78.12.231.174]) by smtp.gmail.com with ESMTPSA id
	a12-v6sm14270952wrr.71.2018.10.18.13.32.41
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Oct 2018 13:32:41 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:50 +0200
Message-Id: <1539894735-14232-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 23/48] scsi-disk: fix rerror/werror=ignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
