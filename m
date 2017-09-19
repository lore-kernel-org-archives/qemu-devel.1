Received: from eggs.gnu.org ([2001:4830:134:3::10]:59754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHf8-0003pH-EG
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHf7-0005HZ-Cr
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:02 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHf7-0005HF-4S
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:01 -0400
Received: by mail-wr0-x243.google.com with SMTP id n64so2146949wrb.2
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:01 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-246-117.clienti.tiscali.it.
	[78.12.246.117]) by smtp.gmail.com with ESMTPSA id
	k18sm1292878wmd.22.2017.09.19.05.29.58 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 19 Sep 2017 05:29:59 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:04 +0200
Message-Id: <1505824179-21541-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/50] scsi: introduce sg_io_sense_from_errno
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Move more knowledge of SG_IO out of hw/scsi/scsi-generic.c, for
reusability.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c | 40 +++++++---------------------------------
 include/scsi/utils.h   |  3 +++
 scsi/utils.c           | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 7a8f500..04c687e 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -81,6 +81,7 @@ static void scsi_free_request(SCSIRequest *req)
 static void scsi_command_complete_noio(SCSIGenericReq *r, int ret)
 {
     int status;
+    SCSISense sense;
 
     assert(r->req.aiocb == NULL);
 
@@ -88,42 +89,15 @@ static void scsi_command_complete_noio(SCSIGenericReq *r, int ret)
         scsi_req_cancel_complete(&r->req);
         goto done;
     }
-    if (r->io_header.driver_status & SG_ERR_DRIVER_SENSE) {
-        r->req.sense_len = r->io_header.sb_len_wr;
-    }
-
-    if (ret != 0) {
-        switch (ret) {
-        case -EDOM:
-            status = TASK_SET_FULL;
-            break;
-        case -ENOMEM:
-            status = CHECK_CONDITION;
-            scsi_req_build_sense(&r->req, SENSE_CODE(TARGET_FAILURE));
-            break;
-        default:
-            status = CHECK_CONDITION;
-            scsi_req_build_sense(&r->req, SENSE_CODE(IO_ERROR));
-            break;
-        }
-    } else {
-        if (r->io_header.host_status == SG_ERR_DID_NO_CONNECT ||
-            r->io_header.host_status == SG_ERR_DID_BUS_BUSY ||
-            r->io_header.host_status == SG_ERR_DID_TIME_OUT ||
-            (r->io_header.driver_status & SG_ERR_DRIVER_TIMEOUT)) {
-            status = BUSY;
-            BADF("Driver Timeout\n");
-        } else if (r->io_header.host_status) {
-            status = CHECK_CONDITION;
-            scsi_req_build_sense(&r->req, SENSE_CODE(I_T_NEXUS_LOSS));
-        } else if (r->io_header.status) {
-            status = r->io_header.status;
-        } else if (r->io_header.driver_status & SG_ERR_DRIVER_SENSE) {
-            status = CHECK_CONDITION;
+    status = sg_io_sense_from_errno(-ret, &r->io_header, &sense);
+    if (status == CHECK_CONDITION) {
+        if (r->io_header.driver_status & SG_ERR_DRIVER_SENSE) {
+            r->req.sense_len = r->io_header.sb_len_wr;
         } else {
-            status = GOOD;
+            scsi_req_build_sense(&r->req, sense);
         }
     }
+
     DPRINTF("Command complete 0x%p tag=0x%x status=%d\n",
             r, r->req.tag, status);
 
diff --git a/include/scsi/utils.h b/include/scsi/utils.h
index b49392d..d301b31 100644
--- a/include/scsi/utils.h
+++ b/include/scsi/utils.h
@@ -116,6 +116,9 @@ int scsi_cdb_length(uint8_t *buf);
 #define SG_ERR_DID_TIME_OUT    0x03
 
 #define SG_ERR_DRIVER_SENSE    0x08
+
+int sg_io_sense_from_errno(int errno_value, struct sg_io_hdr *io_hdr,
+                           SCSISense *sense);
 #endif
 
 #endif
diff --git a/scsi/utils.c b/scsi/utils.c
index 89d9167..6ee9f40 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -501,3 +501,38 @@ const char *scsi_command_name(uint8_t cmd)
     }
     return names[cmd];
 }
+
+#ifdef CONFIG_LINUX
+int sg_io_sense_from_errno(int errno_value, struct sg_io_hdr *io_hdr,
+                           SCSISense *sense)
+{
+    if (errno_value != 0) {
+        switch (errno_value) {
+        case EDOM:
+            return TASK_SET_FULL;
+        case ENOMEM:
+            *sense = SENSE_CODE(TARGET_FAILURE);
+            return CHECK_CONDITION;
+        default:
+            *sense = SENSE_CODE(IO_ERROR);
+            return CHECK_CONDITION;
+        }
+    } else {
+        if (io_hdr->host_status == SG_ERR_DID_NO_CONNECT ||
+            io_hdr->host_status == SG_ERR_DID_BUS_BUSY ||
+            io_hdr->host_status == SG_ERR_DID_TIME_OUT ||
+            (io_hdr->driver_status & SG_ERR_DRIVER_TIMEOUT)) {
+            return BUSY;
+        } else if (io_hdr->host_status) {
+            *sense = SENSE_CODE(I_T_NEXUS_LOSS);
+            return CHECK_CONDITION;
+        } else if (io_hdr->status) {
+            return io_hdr->status;
+        } else if (io_hdr->driver_status & SG_ERR_DRIVER_SENSE) {
+            return CHECK_CONDITION;
+        } else {
+            return GOOD;
+        }
+    }
+}
+#endif
-- 
1.8.3.1
