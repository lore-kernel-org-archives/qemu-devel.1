Received: from eggs.gnu.org ([2001:4830:134:3::10]:47988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eKpIZ-00057p-El
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:40:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eKpIV-0006WN-Ad
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:40:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eKpIV-0006Ui-1y
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:40:23 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B8557F755
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 17:40:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  1 Dec 2017 18:40:18 +0100
Message-Id: <20171201174018.6517-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-pr-helper: miscellaneous fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

1) Return a generic sense if TEST UNIT READY does not provide one;

2) Fix two mistakes in copying from the spec.

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/scsi/utils.h  |  6 +++++-
 scsi/qemu-pr-helper.c | 30 ++++++++++++++++++++++++++----
 scsi/utils.c          | 10 ++++++++++
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/include/scsi/utils.h b/include/scsi/utils.h
index 00a4bdb080..eb07e474ee 100644
--- a/include/scsi/utils.h
+++ b/include/scsi/utils.h
@@ -76,7 +76,11 @@ extern const struct SCSISense sense_code_LUN_FAILURE;
 extern const struct SCSISense sense_code_LUN_COMM_FAILURE;
 /* Command aborted, Overlapped Commands Attempted */
 extern const struct SCSISense sense_code_OVERLAPPED_COMMANDS;
-/* LUN not ready, Capacity data has changed */
+/* Medium error, Unrecovered read error */
+extern const struct SCSISense sense_code_READ_ERROR;
+/* LUN not ready, Cause not reportable */
+extern const struct SCSISense sense_code_NOT_READY;
+/* Unit attention, Capacity data has changed */
 extern const struct SCSISense sense_code_CAPACITY_CHANGED;
 /* Unit attention, SCSI bus reset */
 extern const struct SCSISense sense_code_SCSI_BUS_RESET;
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index dd9785143b..9fe615c73c 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -314,6 +314,22 @@ static int is_mpath(int fd)
     return !strncmp(tgt->target_type, "multipath", DM_MAX_TYPE_NAME);
 }
 
+static SCSISense mpath_generic_sense(int r)
+{
+    switch (r) {
+    case MPATH_PR_SENSE_NOT_READY:
+         return SENSE_CODE(NOT_READY);
+    case MPATH_PR_SENSE_MEDIUM_ERROR:
+         return SENSE_CODE(READ_ERROR);
+    case MPATH_PR_SENSE_HARDWARE_ERROR:
+         return SENSE_CODE(TARGET_FAILURE);
+    case MPATH_PR_SENSE_ABORTED_COMMAND:
+         return SENSE_CODE(IO_ERROR);
+    default:
+         abort();
+    }
+}
+
 static int mpath_reconstruct_sense(int fd, int r, uint8_t *sense)
 {
     switch (r) {
@@ -329,7 +345,13 @@ static int mpath_reconstruct_sense(int fd, int r, uint8_t *sense)
              */
             uint8_t cdb[6] = { TEST_UNIT_READY };
             int sz = 0;
-            return do_sgio(fd, cdb, sense, NULL, &sz, SG_DXFER_NONE);
+            int r = do_sgio(fd, cdb, sense, NULL, &sz, SG_DXFER_NONE);
+
+            if (r != GOOD) {
+                return r;
+            }
+            scsi_build_sense(sense, mpath_generic_sense(r));
+            return CHECK_CONDITION;
         }
 
     case MPATH_PR_SENSE_UNIT_ATTENTION:
@@ -449,7 +471,7 @@ static int multipath_pr_out(int fd, const uint8_t *cdb, uint8_t *sense,
     memset(&paramp, 0, sizeof(paramp));
     memcpy(&paramp.key, &param[0], 8);
     memcpy(&paramp.sa_key, &param[8], 8);
-    paramp.sa_flags = param[10];
+    paramp.sa_flags = param[20];
     if (sz > PR_OUT_FIXED_PARAM_SIZE) {
         size_t transportid_len;
         int i, j;
@@ -478,8 +500,8 @@ static int multipath_pr_out(int fd, const uint8_t *cdb, uint8_t *sense,
                 j += offsetof(struct transportid, n_port_name[8]);
                 i += 24;
                 break;
-            case 3:
-            case 0x43:
+            case 5:
+            case 0x45:
                 /* iSCSI transport.  */
                 len = lduw_be_p(&param[i + 2]);
                 if (len > 252 || (len & 3) || i + len + 4 > transportid_len) {
diff --git a/scsi/utils.c b/scsi/utils.c
index 5684951b12..e4182a9b09 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -211,6 +211,16 @@ const struct SCSISense sense_code_LUN_COMM_FAILURE = {
     .key = ABORTED_COMMAND, .asc = 0x08, .ascq = 0x00
 };
 
+/* Medium Error, Unrecovered read error */
+const struct SCSISense sense_code_READ_ERROR = {
+    .key = MEDIUM_ERROR, .asc = 0x11, .ascq = 0x00
+};
+
+/* Not ready, Cause not reportable */
+const struct SCSISense sense_code_NOT_READY = {
+    .key = NOT_READY, .asc = 0x04, .ascq = 0x00
+};
+
 /* Unit attention, Capacity data has changed */
 const struct SCSISense sense_code_CAPACITY_CHANGED = {
     .key = UNIT_ATTENTION, .asc = 0x2a, .ascq = 0x09
-- 
2.14.3
