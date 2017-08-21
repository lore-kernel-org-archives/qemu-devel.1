Received: from eggs.gnu.org ([2001:4830:134:3::10]:54818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1djnPS-0002ub-Tx
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1djnPN-0001Yv-AO
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:10:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1djnPN-0001YZ-48
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:10:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 37F0D13A9F
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 14:10:24 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Mon, 21 Aug 2017 22:10:06 +0800
Message-Id: <20170821141008.19383-3-famz@redhat.com>
In-Reply-To: <20170821141008.19383-1-famz@redhat.com>
References: <20170821141008.19383-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/4] scsi: Improve scsi_sense_to_errno
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

Tweak the errno mapping to return more accurate/appropriate values.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 util/scsi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/util/scsi.c b/util/scsi.c
index a6710799fc..472eb5bea5 100644
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
2.13.5
