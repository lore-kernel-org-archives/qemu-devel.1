Received: from eggs.gnu.org ([2001:4830:134:3::10]:44818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8jF-0005qP-GH
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8j3-0008KE-NE
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34868
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8j3-0008JO-De
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:17 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEL3s126830
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:16:17 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fyhwn1fqm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:16:15 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:16:14 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:26 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-6-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 05/54] qemu-pr-helper: miscellaneous fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

1) Return a generic sense if TEST UNIT READY does not provide one;

2) Fix two mistakes in copying from the spec.

Cc: qemu-stable@nongnu.org
Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit a4a9b6eaf35dbe4bf0e069854945bf5e45fc7eab)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.11.0
