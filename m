Received: from eggs.gnu.org ([2001:4830:134:3::10]:59648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHf1-0003iC-8B
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHf0-0005E5-Et
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:55 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHf0-0005Dm-9I
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:54 -0400
Received: by mail-wm0-x242.google.com with SMTP id i131so3748936wma.1
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:29:54 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:28:58 +0200
Message-Id: <1505824179-21541-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/50] scsi: Improve scsi_sense_to_errno
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

Tweak the errno mapping to return more accurate/appropriate values.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170821141008.19383-3-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/scsi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/util/scsi.c b/util/scsi.c
index a671079..472eb5b 100644
--- a/util/scsi.c
+++ b/util/scsi.c
@@ -18,13 +18,16 @@
 int scsi_sense_to_errno(int key, int asc, int ascq)
 {
     switch (key) {
-    case 0x02: /* NOT READY */
-        return EBUSY;
-    case 0x07: /* DATA PROTECTION */
-        return EACCES;
+    case 0x00: /* NO SENSE */
+    case 0x01: /* RECOVERED ERROR */
+    case 0x06: /* UNIT ATTENTION */
+        /* These sense keys are not errors */
+        return 0;
     case 0x0b: /* COMMAND ABORTED */
         return ECANCELED;
+    case 0x02: /* NOT READY */
     case 0x05: /* ILLEGAL REQUEST */
+    case 0x07: /* DATA PROTECTION */
         /* Parse ASCQ */
         break;
     default:
@@ -37,6 +40,7 @@ int scsi_sense_to_errno(int key, int asc, int ascq)
     case 0x2600: /* INVALID FIELD IN PARAMETER LIST */
         return EINVAL;
     case 0x2100: /* LBA OUT OF RANGE */
+    case 0x2707: /* SPACE ALLOC FAILED */
         return ENOSPC;
     case 0x2500: /* LOGICAL UNIT NOT SUPPORTED */
         return ENOTSUP;
@@ -46,6 +50,10 @@ int scsi_sense_to_errno(int key, int asc, int ascq)
         return ENOMEDIUM;
     case 0x2700: /* WRITE PROTECTED */
         return EACCES;
+    case 0x0401: /* NOT READY, IN PROGRESS OF BECOMING READY */
+        return EAGAIN;
+    case 0x0402: /* NOT READY, INITIALIZING COMMAND REQUIRED */
+        return ENOTCONN;
     default:
         return EIO;
     }
-- 
1.8.3.1
