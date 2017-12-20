Received: from eggs.gnu.org ([2001:4830:134:3::10]:56047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhxy-0004FU-P8
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhxx-0006yQ-OF
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:38 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:15 +0100
Message-Id: <1513790098-9815-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/46] qemu-pr-helper: miscellaneous fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

1) Return a generic sense if TEST UNIT READY does not provide one;

2) Fix two mistakes in copying from the spec.

Cc: qemu-stable@nongnu.org
Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/scsi/utils.h  |  6 +++++-
 scsi/qemu-pr-helper.c | 30 ++++++++++++++++++++++++++----
 scsi/utils.c          | 10 ++++++++++
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/include/scsi/utils.h b/include/scsi/utils.h
index 00a4bdb..eb07e47 100644
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
index dd97851..9fe615c 100644
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
index 5684951..e4182a9 100644
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
1.8.3.1
