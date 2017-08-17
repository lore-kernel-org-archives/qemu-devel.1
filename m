Received: from eggs.gnu.org ([2001:4830:134:3::10]:59296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1diLWg-0004Iv-3K
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1diLWc-0003XT-2g
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:11:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1diLWb-0003XA-P9
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:11:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B064C2C84
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 14:11:52 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu, 17 Aug 2017 22:11:48 +0800
Message-Id: <20170817141148.13111-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2] scsi-block: Add qdev error properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

This makes the werror/rerror options available on the scsi-block device,
to allow user specify error handling policy in the same way as scsi-hd
etc.

Signed-off-by: Fam Zheng <famz@redhat.com>

---

Take care of status, error, sense and QMP as well. [Paolo]
---
 hw/scsi/scsi-disk.c | 81 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 59 insertions(+), 22 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 5f1e5e8070..124d77c159 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -106,7 +106,8 @@ typedef struct SCSIDiskState
     bool tray_locked;
 } SCSIDiskState;
 
-static int scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed);
+static int scsi_handle_rw_error(SCSIDiskReq *r, int error, int status,
+                                bool update_sense, bool acct_failed);
 
 static void scsi_free_request(SCSIRequest *req)
 {
@@ -179,21 +180,23 @@ static void scsi_disk_load_request(QEMUFile *f, SCSIRequest *req)
 
 static bool scsi_disk_req_check_error(SCSIDiskReq *r, int ret, bool acct_failed)
 {
+    int status = r->status ? *r->status : 0;
+
     if (r->req.io_canceled) {
         scsi_req_cancel_complete(&r->req);
         return true;
     }
 
-    if (ret < 0) {
-        return scsi_handle_rw_error(r, -ret, acct_failed);
+    if (ret < 0 || status) {
+        return scsi_handle_rw_error(r, -ret, status, !r->status, acct_failed);
     }
 
-    if (r->status && *r->status) {
+    if (status) {
         if (acct_failed) {
             SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
             block_acct_failed(blk_get_stats(s->qdev.conf.blk), &r->acct);
         }
-        scsi_req_complete(&r->req, *r->status);
+        scsi_req_complete(&r->req, status);
         return true;
     }
 
@@ -421,6 +424,22 @@ static void scsi_read_data(SCSIRequest *req)
     }
 }
 
+static bool scsi_sense_matches(SCSIDiskReq *r, SCSISense sense)
+{
+    SCSIRequest *req = &r->req;
+    if (req->sense[0] == 0x70) {
+        return (req->sense[2] & 0xF) == sense.key &&
+               req->sense[12] == sense.asc &&
+               req->sense[13] == sense.ascq;
+    } else if (req->sense[0] == 0x72) {
+        return (req->sense[1] & 0xF) == sense.key &&
+               req->sense[2] == sense.asc &&
+               req->sense[3] == sense.ascq;
+    } else {
+        return false;
+    }
+}
+
 /*
  * scsi_handle_rw_error has two return values.  0 means that the error
  * must be ignored, 1 means that the error has been processed and the
@@ -428,7 +447,8 @@ static void scsi_read_data(SCSIRequest *req)
  * scsi_handle_rw_error always manages its reference counts, independent
  * of the return value.
  */
-static int scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
+static int scsi_handle_rw_error(SCSIDiskReq *r, int error, int status,
+                                bool update_sense, bool acct_failed)
 {
     bool is_read = (r->req.cmd.mode == SCSI_XFER_FROM_DEV);
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
@@ -439,22 +459,38 @@ static int scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
         if (acct_failed) {
             block_acct_failed(blk_get_stats(s->qdev.conf.blk), &r->acct);
         }
-        switch (error) {
-        case ENOMEDIUM:
-            scsi_check_condition(r, SENSE_CODE(NO_MEDIUM));
-            break;
-        case ENOMEM:
-            scsi_check_condition(r, SENSE_CODE(TARGET_FAILURE));
-            break;
-        case EINVAL:
-            scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
-            break;
-        case ENOSPC:
-            scsi_check_condition(r, SENSE_CODE(SPACE_ALLOC_FAILED));
-            break;
-        default:
-            scsi_check_condition(r, SENSE_CODE(IO_ERROR));
-            break;
+        if (update_sense) {
+            switch (error) {
+            case ENOMEDIUM:
+                scsi_check_condition(r, SENSE_CODE(NO_MEDIUM));
+                break;
+            case ENOMEM:
+                scsi_check_condition(r, SENSE_CODE(TARGET_FAILURE));
+                break;
+            case EINVAL:
+                scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
+                break;
+            case ENOSPC:
+                scsi_check_condition(r, SENSE_CODE(SPACE_ALLOC_FAILED));
+                break;
+            default:
+                scsi_check_condition(r, SENSE_CODE(IO_ERROR));
+                break;
+            }
+        }
+    }
+    if (!error) {
+        assert(status);
+        if (scsi_sense_matches(r, SENSE_CODE(NO_MEDIUM))) {
+            error = ENOMEDIUM;
+        } else if (scsi_sense_matches(r, SENSE_CODE(TARGET_FAILURE))) {
+            error = ENOMEM;
+        } else if (scsi_sense_matches(r, SENSE_CODE(INVALID_FIELD))) {
+            error = EINVAL;
+        } else if (scsi_sense_matches(r, SENSE_CODE(SPACE_ALLOC_FAILED))) {
+            error = ENOSPC;
+        } else {
+            error = EIO;
         }
     }
     blk_error_action(s->qdev.conf.blk, action, is_read, error);
@@ -2972,6 +3008,7 @@ static const TypeInfo scsi_cd_info = {
 
 #ifdef __linux__
 static Property scsi_block_properties[] = {
+    DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),         \
     DEFINE_PROP_DRIVE("drive", SCSIDiskState, qdev.conf.blk),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.13.4
