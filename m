Received: from eggs.gnu.org ([2001:4830:134:3::10]:54808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dii3b-0006CC-6p
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dii3Z-0005xE-VR
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dii3Z-0005uv-LH
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D874461D2
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 14:15:24 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 18 Aug 2017 22:15:12 +0800
Message-Id: <20170818141512.15205-4-famz@redhat.com>
In-Reply-To: <20170818141512.15205-1-famz@redhat.com>
References: <20170818141512.15205-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/3] scsi-block: Support rerror/werror
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
to allow user specify error handling policy similar to scsi-hd.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/scsi/scsi-disk.c | 54 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 5f1e5e8070..ec7dbe4a2d 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -39,6 +39,7 @@ do { printf("scsi-disk: " fmt , ## __VA_ARGS__); } while (0)
 #include "hw/block/block.h"
 #include "sysemu/dma.h"
 #include "qemu/cutils.h"
+#include "scsi/scsi.h"
 
 #ifdef __linux
 #include <scsi/sg.h>
@@ -106,7 +107,7 @@ typedef struct SCSIDiskState
     bool tray_locked;
 } SCSIDiskState;
 
-static int scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed);
+static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed);
 
 static void scsi_free_request(SCSIRequest *req)
 {
@@ -184,19 +185,10 @@ static bool scsi_disk_req_check_error(SCSIDiskReq *r, int ret, bool acct_failed)
         return true;
     }
 
-    if (ret < 0) {
+    if (ret < 0 || (r->status && *r->status)) {
         return scsi_handle_rw_error(r, -ret, acct_failed);
     }
 
-    if (r->status && *r->status) {
-        if (acct_failed) {
-            SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
-            block_acct_failed(blk_get_stats(s->qdev.conf.blk), &r->acct);
-        }
-        scsi_req_complete(&r->req, *r->status);
-        return true;
-    }
-
     return false;
 }
 
@@ -422,13 +414,13 @@ static void scsi_read_data(SCSIRequest *req)
 }
 
 /*
- * scsi_handle_rw_error has two return values.  0 means that the error
- * must be ignored, 1 means that the error has been processed and the
+ * scsi_handle_rw_error has two return values.  False means that the error
+ * must be ignored, true means that the error has been processed and the
  * caller should not do anything else for this request.  Note that
  * scsi_handle_rw_error always manages its reference counts, independent
  * of the return value.
  */
-static int scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
+static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
 {
     bool is_read = (r->req.cmd.mode == SCSI_XFER_FROM_DEV);
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
@@ -440,6 +432,11 @@ static int scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
             block_acct_failed(blk_get_stats(s->qdev.conf.blk), &r->acct);
         }
         switch (error) {
+        case 0:
+            /* The command has run, no need to fake sense.  */
+            assert(r->status && *r->status);
+            scsi_req_complete(&r->req, *r->status);
+            break;
         case ENOMEDIUM:
             scsi_check_condition(r, SENSE_CODE(NO_MEDIUM));
             break;
@@ -457,6 +454,34 @@ static int scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
             break;
         }
     }
+    if (!error) {
+        int key, asc, ascq;
+        assert(r->status && *r->status);
+        switch (r->req.sense[0]) {
+        case 0x70: /* Fixed format sense data. */
+            key = r->req.sense[2] & 0xF;
+            asc = r->req.sense[12];
+            ascq = r->req.sense[13];
+            error = scsi_sense_to_errno(key, asc, ascq);
+            break;
+        case 0x72: /* Descriptor format sense data. */
+            key = r->req.sense[1] & 0xF;
+            asc = r->req.sense[2];
+            ascq = r->req.sense[3];
+            error = scsi_sense_to_errno(key, asc, ascq);
+            break;
+        default:
+            error = EIO;
+            break;
+        }
+
+        if (error == ECANCELED) {
+            /* Command aborted shouldn't stop the VM. */
+            scsi_req_complete(&r->req, *r->status);
+            return true;
+        }
+    }
+
     blk_error_action(s->qdev.conf.blk, action, is_read, error);
     if (action == BLOCK_ERROR_ACTION_STOP) {
         scsi_req_retry(&r->req);
@@ -2972,6 +2997,7 @@ static const TypeInfo scsi_cd_info = {
 
 #ifdef __linux__
 static Property scsi_block_properties[] = {
+    DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),         \
     DEFINE_PROP_DRIVE("drive", SCSIDiskState, qdev.conf.blk),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.13.4
