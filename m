Received: from eggs.gnu.org ([2001:4830:134:3::10]:50088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebS3i-0002cU-JW
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebS3a-0004QA-Oz
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:17:50 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:43472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ebS3a-0004Ps-Ht
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:17:42 -0500
Received: by mail-wm0-x242.google.com with SMTP id g1so8671317wmg.2
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:17:42 -0800 (PST)
Received: from 640k.lan (dynamic-adsl-78-12-229-84.clienti.tiscali.it.
	[78.12.229.84])
	by smtp.gmail.com with ESMTPSA id u10sm1537758wrg.6.2018.01.16.06.17.39
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Jan 2018 06:17:39 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Jan 2018 15:16:44 +0100
Message-Id: <1516112253-14480-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/51] scsi: fix scsi_convert_sense crash when
 in_buf == NULL && in_len == 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

scsi_disk_emulate_command passes in_buf == NULL when sent a REQUEST
SENSE command.  Check for in_len == 0 before dereferencing in_buf.

Fixes: f68d98b21fa74155dc7c1fd212474379ac3c7531
Reported-by: Roman Kagan <rkagan@virtuozzo.com>
Tested-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/utils.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scsi/utils.c b/scsi/utils.c
index ddae650..8738522 100644
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
1.8.3.1
