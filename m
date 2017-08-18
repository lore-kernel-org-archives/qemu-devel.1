Received: from eggs.gnu.org ([2001:4830:134:3::10]:54782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dii3Z-0006A2-1B
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dii3Y-0005sz-4S
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dii3X-0005qK-UN
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB50C7EA8D
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 14:15:22 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 18 Aug 2017 22:15:11 +0800
Message-Id: <20170818141512.15205-3-famz@redhat.com>
In-Reply-To: <20170818141512.15205-1-famz@redhat.com>
References: <20170818141512.15205-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/3] scsi: Enhance scsi_sense_to_errno
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

Two changes:

1) Look at asc/ascq for NOT_READY and DATA_PROTECT;
2) Translate SPACE_ALLOC_FAILED as ENOSPC;

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 util/scsi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/util/scsi.c b/util/scsi.c
index 92ca436cd0..d42ce33449 100644
--- a/util/scsi.c
+++ b/util/scsi.c
@@ -18,13 +18,11 @@
 int scsi_sense_to_errno(int key, int asc, int ascq)
 {
     switch (key) {
-    case 0x02: /* SCSI_SENSE_NOT_READY */
-        return EBUSY;
-    case 0x07: /* SCSI_SENSE_DATA_PROTECTION */
-        return EACCES;
     case 0x0b: /* SCSI_SENSE_COMMAND_ABORTED */
         return ECANCELED;
+    case 0x02: /* SCSI_SENSE_NOT_READY */
     case 0x05: /* SCSI_SENSE_ILLEGAL_REQUEST */
+    case 0x07: /* SCSI_SENSE_DATA_PROTECTION */
         /* Parse ASCQ */
         break;
     default:
@@ -37,6 +35,7 @@ int scsi_sense_to_errno(int key, int asc, int ascq)
     case 0x2600: /* SCSI_SENSE_ASCQ_INVALID_FIELD_IN_PARAMETER_LIST */
         return EINVAL;
     case 0x2100: /* SCSI_SENSE_ASCQ_LBA_OUT_OF_RANGE */
+    case 0x2707: /* SCSI_SENSE_ASCQ_SPACE_ALLOC_FAILED */
         return ENOSPC;
     case 0x2500: /* SCSI_SENSE_ASCQ_LOGICAL_UNIT_NOT_SUPPORTED */
         return ENOTSUP;
-- 
2.13.4
