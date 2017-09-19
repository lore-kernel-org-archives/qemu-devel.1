Received: from eggs.gnu.org ([2001:4830:134:3::10]:59734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHf7-0003oG-Iu
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHf3-0005Fa-IZ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:01 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHf3-0005FH-Cs
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:57 -0400
Received: by mail-wr0-x241.google.com with SMTP id g50so2141046wra.3
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:29:57 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-246-117.clienti.tiscali.it.
	[78.12.246.117]) by smtp.gmail.com with ESMTPSA id
	k18sm1292878wmd.22.2017.09.19.05.29.55 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 19 Sep 2017 05:29:55 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:01 +0200
Message-Id: <1505824179-21541-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/50] scsi: rename scsi_build_sense to
 scsi_convert_sense
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

After introducing the scsi/ subdirectory, there will be a scsi_build_sense
function that is the same as scsi_req_build_sense but without needing
a SCSIRequest.  The existing scsi_build_sense function gets in the way,
remove it.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c     | 10 +++++-----
 hw/scsi/scsi-disk.c    |  4 ++--
 include/hw/scsi/scsi.h |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index ade31c1..fac360e 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -790,7 +790,7 @@ int scsi_req_get_sense(SCSIRequest *req, uint8_t *buf, int len)
         return 0;
     }
 
-    ret = scsi_build_sense(req->sense, req->sense_len, buf, len, true);
+    ret = scsi_convert_sense(req->sense, req->sense_len, buf, len, true);
 
     /*
      * FIXME: clearing unit attention conditions upon autosense should be done
@@ -811,7 +811,7 @@ int scsi_req_get_sense(SCSIRequest *req, uint8_t *buf, int len)
 
 int scsi_device_get_sense(SCSIDevice *dev, uint8_t *buf, int len, bool fixed)
 {
-    return scsi_build_sense(dev->sense, dev->sense_len, buf, len, fixed);
+    return scsi_convert_sense(dev->sense, dev->sense_len, buf, len, fixed);
 }
 
 void scsi_req_build_sense(SCSIRequest *req, SCSISense sense)
@@ -1531,12 +1531,12 @@ const struct SCSISense sense_code_SPACE_ALLOC_FAILED = {
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
index cf38f93..990ba04 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1987,8 +1987,8 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
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
index 6b85786..6ef67fb 100644
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
1.8.3.1
