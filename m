Received: from eggs.gnu.org ([2001:4830:134:3::10]:57433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gBGc0-0002hk-Pv
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 05:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gBGbz-00015F-E5
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 05:53:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gBGby-00014n-Rw
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 05:53:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B726EBB0E
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 09:53:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 13 Oct 2018 11:53:22 +0200
Message-Id: <1539424403-2884-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539424403-2884-1-git-send-email-pbonzini@redhat.com>
References: <1539424403-2884-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] scsi-disk: fix double completion of
 failing passthrough requests
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

If a command fails with a sense that scsi_sense_buf_to_errno converts to
ECANCELED/EAGAIN/ENOTCONN or with a unit attention, scsi_req_complete is
called twice.  This caused a crash.

Reported-by: Wangguang <wang.guangA@h3c.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index c43163c..4074d7c 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -441,9 +441,18 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
         }
         switch (error) {
         case 0:
-            /* The command has run, no need to fake sense.  */
+            /* A passthrough command has run and has produced sense data; check
+             * whether the error has to be handled by the guest or should rather
+             * pause the host.
+             */
             assert(r->status && *r->status);
-            scsi_req_complete(&r->req, *r->status);
+            error = scsi_sense_buf_to_errno(r->req.sense, sizeof(r->req.sense));
+            if (error == ECANCELED || error == EAGAIN || error == ENOTCONN ||
+                error == 0)  {
+                /* These errors are handled by guest. */
+                scsi_req_complete(&r->req, *r->status);
+                return true;
+            }
             break;
         case ENOMEDIUM:
             scsi_check_condition(r, SENSE_CODE(NO_MEDIUM));
@@ -462,17 +471,6 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
             break;
         }
     }
-    if (!error) {
-        assert(r->status && *r->status);
-        error = scsi_sense_buf_to_errno(r->req.sense, sizeof(r->req.sense));
-
-        if (error == ECANCELED || error == EAGAIN || error == ENOTCONN ||
-            error == 0)  {
-            /* These errors are handled by guest. */
-            scsi_req_complete(&r->req, *r->status);
-            return true;
-        }
-    }
 
     blk_error_action(s->qdev.conf.blk, action, is_read, error);
     if (action == BLOCK_ERROR_ACTION_STOP) {
-- 
1.8.3.1
