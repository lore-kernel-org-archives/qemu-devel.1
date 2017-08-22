Received: from eggs.gnu.org ([2001:4830:134:3::10]:49677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk950-0002dy-Pm
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk94u-0005m5-SJ
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:18:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dk94u-0005dc-Hz
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:18:44 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 22 Aug 2017 15:18:23 +0200
Message-Id: <20170822131832.20191-2-pbonzini@redhat.com>
In-Reply-To: <20170822131832.20191-1-pbonzini@redhat.com>
References: <20170822131832.20191-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 01/10] scsi: rename scsi_convert_sense
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

After introducing the scsi/ subdirectory, there will be a scsi_build_sense
function that is the same as scsi_req_build_sense but without needing
a SCSIRequest.  The existing scsi_build_sense function gets in the way,
remove it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c     | 10 +++++-----
 hw/scsi/scsi-disk.c    |  4 ++--
 include/hw/scsi/scsi.h |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index e364410a23..890f8fcc83 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -769,7 +769,7 @@ int scsi_req_get_sense(SCSIRequest *req, uint8_t *buf, int len)
         return 0;
     }
 
-    ret = scsi_build_sense(req->sense, req->sense_len, buf, len, true);
+    ret = scsi_convert_sense(req->sense, req->sense_len, buf, len, true);
 
     /*
      * FIXME: clearing unit attention conditions upon autosense should be done
@@ -790,7 +790,7 @@ int scsi_req_get_sense(SCSIRequest *req, uint8_t *buf, int len)
 
 int scsi_device_get_sense(SCSIDevice *dev, uint8_t *buf, int len, bool fixed)
 {
-    return scsi_build_sense(dev->sense, dev->sense_len, buf, len, fixed);
+    return scsi_convert_sense(dev->sense, dev->sense_len, buf, len, fixed);
 }
 
 void scsi_req_build_sense(SCSIRequest *req, SCSISense sense)
@@ -1510,12 +1510,12 @@ const struct SCSISense sense_code_SPACE_ALLOC_FAILED = {
 };
 
 /*
- * scsi_build_sense
+ * scsi_convert_sense
  *
  * Convert between fixed and descriptor sense buffers
  */
-int scsi_build_sense(uint8_t *in_buf, int in_len,
-                     uint8_t *buf, int len, bool fixed)
+int scsi_convert_sense(uint8_t *in_buf, int in_len,
+                       uint8_t *buf, int len, bool fixed)
 {
     bool fixed_in;
     SCSISense sense;
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 5f1e5e8070..0a1f4ef0c7 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1978,8 +1978,8 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
         break;
     case REQUEST_SENSE:
         /* Just return "NO SENSE".  */
-        buflen = scsi_build_sense(NULL, 0, outbuf, r->buflen,
-                                  (req->cmd.buf[1] & 1) == 0);
+        buflen = scsi_convert_sense(NULL, 0, outbuf, r->buflen,
+                                    (req->cmd.buf[1] & 1) == 0);
         if (buflen < 0) {
             goto illegal_request;
         }
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 6b85786dbf..6ef67fb504 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -244,8 +244,8 @@ extern const struct SCSISense sense_code_SPACE_ALLOC_FAILED;
 uint32_t scsi_data_cdb_xfer(uint8_t *buf);
 uint32_t scsi_cdb_xfer(uint8_t *buf);
 int scsi_cdb_length(uint8_t *buf);
-int scsi_build_sense(uint8_t *in_buf, int in_len,
-                     uint8_t *buf, int len, bool fixed);
+int scsi_convert_sense(uint8_t *in_buf, int in_len,
+                       uint8_t *buf, int len, bool fixed);
 
 SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
                             uint32_t tag, uint32_t lun, void *hba_private);
-- 
2.13.5
