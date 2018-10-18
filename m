Received: from eggs.gnu.org ([2001:4830:134:3::10]:48219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyO-0007Pq-6b
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyL-0006Oe-B2
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:46 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:36668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyJ-0006Lt-OC
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:45 -0400
Received: by mail-wm1-x331.google.com with SMTP id a8-v6so1627157wmf.1
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:42 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-231-174.clienti.tiscali.it.
	[78.12.231.174]) by smtp.gmail.com with ESMTPSA id
	a12-v6sm14270952wrr.71.2018.10.18.13.32.40
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Oct 2018 13:32:41 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:49 +0200
Message-Id: <1539894735-14232-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 22/48] scsi-disk: fix double completion of
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
