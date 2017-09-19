Received: from eggs.gnu.org ([2001:4830:134:3::10]:59723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHf7-0003oC-44
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHf6-0005Gz-9c
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:01 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:37665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHf6-0005Ga-3m
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:00 -0400
Received: by mail-wr0-x244.google.com with SMTP id u48so2145775wrf.4
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:29:59 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-246-117.clienti.tiscali.it.
	[78.12.246.117]) by smtp.gmail.com with ESMTPSA id
	k18sm1292878wmd.22.2017.09.19.05.29.58 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 19 Sep 2017 05:29:58 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:03 +0200
Message-Id: <1505824179-21541-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/50] scsi: introduce scsi_build_sense
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Move more knowledge of sense data format out of hw/scsi/scsi-bus.c
for reusability.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c   |  8 +-------
 include/scsi/utils.h |  2 ++
 scsi/utils.c         | 11 +++++++++++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 42920d5..652ab04 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -818,13 +818,7 @@ void scsi_req_build_sense(SCSIRequest *req, SCSISense sense)
 {
     trace_scsi_req_build_sense(req->dev->id, req->lun, req->tag,
                                sense.key, sense.asc, sense.ascq);
-    memset(req->sense, 0, 18);
-    req->sense[0] = 0x70;
-    req->sense[2] = sense.key;
-    req->sense[7] = 10;
-    req->sense[12] = sense.asc;
-    req->sense[13] = sense.ascq;
-    req->sense_len = 18;
+    req->sense_len = scsi_build_sense(req->sense, sense);
 }
 
 static void scsi_req_enqueue_internal(SCSIRequest *req)
diff --git a/include/scsi/utils.h b/include/scsi/utils.h
index 90bf4dc..b49392d 100644
--- a/include/scsi/utils.h
+++ b/include/scsi/utils.h
@@ -30,6 +30,8 @@ typedef struct SCSISense {
     uint8_t ascq;
 } SCSISense;
 
+int scsi_build_sense(uint8_t *buf, SCSISense sense);
+
 /*
  * Predefined sense codes
  */
diff --git a/scsi/utils.c b/scsi/utils.c
index 2327e06..89d9167 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -96,6 +96,17 @@ int scsi_cdb_length(uint8_t *buf)
     return cdb_len;
 }
 
+int scsi_build_sense(uint8_t *buf, SCSISense sense)
+{
+    memset(buf, 0, 18);
+    buf[0] = 0x70;
+    buf[2] = sense.key;
+    buf[7] = 10;
+    buf[12] = sense.asc;
+    buf[13] = sense.ascq;
+    return 18;
+}
+
 /*
  * Predefined sense codes
  */
-- 
1.8.3.1
