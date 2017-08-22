Received: from eggs.gnu.org ([2001:4830:134:3::10]:49652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk94y-0002dF-WB
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk94v-0005mM-1Q
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:18:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30175)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dk94u-0005hU-Qz
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:18:44 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 22 Aug 2017 15:18:25 +0200
Message-Id: <20170822131832.20191-4-pbonzini@redhat.com>
In-Reply-To: <20170822131832.20191-1-pbonzini@redhat.com>
References: <20170822131832.20191-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 03/10] scsi: introduce scsi_build_sense
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, famz@redhat.com

Move more knowledge of sense data format out of hw/scsi/scsi-bus.c
for reusability.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c   |  8 +-------
 include/scsi/utils.h |  2 ++
 scsi/utils.c         | 11 +++++++++++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 300912d213..f71218f02a 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -797,13 +797,7 @@ void scsi_req_build_sense(SCSIRequest *req, SCSISense sense)
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
index 35a74436bf..76c3db98c0 100644
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
index 0db727591f..54d6d4486a 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -81,6 +81,17 @@ int scsi_cdb_length(uint8_t *buf)
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
2.13.5
