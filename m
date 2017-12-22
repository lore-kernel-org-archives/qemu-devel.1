Received: from eggs.gnu.org ([2001:4830:134:3::10]:52635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eSPfU-0003LI-5z
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:55:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eSPfR-0000Cr-KL
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:55:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eSPfR-0000CA-Cl
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:55:25 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Dec 2017 16:55:22 +0100
Message-Id: <20171222155522.17868-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] scsi: fix scsi_convert_sense crash when in_buf
 == NULL && in_len == 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rkagan@virtuozzo.com

scsi_disk_emulate_command passes in_buf == NULL when sent a REQUEST
SENSE command.  Check for in_len == 0 before dereferencing in_buf.

Fixes: f68d98b21fa74155dc7c1fd212474379ac3c7531
Reported-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/utils.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scsi/utils.c b/scsi/utils.c
index ddae650a99..8738522955 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -322,18 +322,18 @@ int scsi_convert_sense(uint8_t *in_buf, int in_len,
     SCSISense sense;
     bool fixed_in;
 
+    if (in_len == 0) {
+        return scsi_build_sense_buf(buf, len, SENSE_CODE(NO_SENSE), fixed);
+    }
+
     fixed_in = (in_buf[0] & 2) == 0;
-    if (in_len && fixed == fixed_in) {
+    if (fixed == fixed_in) {
         memcpy(buf, in_buf, MIN(len, in_len));
         return MIN(len, in_len);
-    }
-
-    if (in_len == 0) {
-        sense = SENSE_CODE(NO_SENSE);
     } else {
         sense = scsi_parse_sense_buf(in_buf, in_len);
+        return scsi_build_sense_buf(buf, len, sense, fixed);
     }
-    return scsi_build_sense_buf(buf, len, sense, fixed);
 }
 
 int scsi_sense_to_errno(int key, int asc, int ascq)
-- 
2.14.3
