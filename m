Received: from eggs.gnu.org ([2001:4830:134:3::10]:56550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyW-0004o9-8z
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyU-0007Jz-RY
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:12 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:40601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyU-0007Je-GW
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:10 -0500
Received: by mail-wm0-x243.google.com with SMTP id f206so11070121wmf.5
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:16:10 -0800 (PST)
Received: from 640k.lan (dynamic-adsl-78-12-251-125.clienti.tiscali.it.
	[78.12.251.125]) by smtp.gmail.com with ESMTPSA id
	f125sm2751101wme.45.2017.12.20.09.16.07 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 20 Dec 2017 09:16:08 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:44 +0100
Message-Id: <1513790098-9815-33-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 32/46] scsi: provide general-purpose functions
 to manage sense data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Extract the common parts of scsi_sense_buf_to_errno, scsi_convert_sense
and scsi_target_send_command's REQUEST SENSE handling into two new
functions scsi_parse_sense_buf and scsi_build_sense_buf.

Fix a bug in scsi_target_send_command along the way; the length was
written in buf[10] rather than buf[7].

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Fixes: b07fbce634 ("scsi-bus: correct responses for INQUIRY and REQUEST SENSE")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c   |  16 +-----
 include/scsi/utils.h |   3 ++
 scsi/utils.c         | 139 +++++++++++++++++++++++++--------------------------
 3 files changed, 72 insertions(+), 86 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 977f7bc..965becf 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -540,20 +540,8 @@ static int32_t scsi_target_send_command(SCSIRequest *req, uint8_t *buf)
         if (req->lun != 0) {
             const struct SCSISense sense = SENSE_CODE(LUN_NOT_SUPPORTED);
 
-            if (fixed_sense) {
-                r->buf[0] = 0x70;
-                r->buf[2] = sense.key;
-                r->buf[10] = 10;
-                r->buf[12] = sense.asc;
-                r->buf[13] = sense.ascq;
-                r->len = MIN(req->cmd.xfer, SCSI_SENSE_LEN);
-            } else {
-                r->buf[0] = 0x72;
-                r->buf[1] = sense.key;
-                r->buf[2] = sense.asc;
-                r->buf[3] = sense.ascq;
-                r->len = 8;
-            }
+            r->len = scsi_build_sense_buf(r->buf, req->cmd.xfer,
+                                          sense, fixed_sense);
         } else {
             r->len = scsi_device_get_sense(r->req.dev, r->buf,
                                            MIN(req->cmd.xfer, r->buf_len),
diff --git a/include/scsi/utils.h b/include/scsi/utils.h
index eb07e47..4b705f5 100644
--- a/include/scsi/utils.h
+++ b/include/scsi/utils.h
@@ -31,6 +31,9 @@ typedef struct SCSISense {
 } SCSISense;
 
 int scsi_build_sense(uint8_t *buf, SCSISense sense);
+SCSISense scsi_parse_sense_buf(const uint8_t *in_buf, int in_len);
+int scsi_build_sense_buf(uint8_t *buf, size_t max_size, SCSISense sense,
+                         bool fixed_sense);
 
 /*
  * Predefined sense codes
diff --git a/scsi/utils.c b/scsi/utils.c
index e4182a9..61bc1a8 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -96,15 +96,60 @@ int scsi_cdb_length(uint8_t *buf)
     return cdb_len;
 }
 
+SCSISense scsi_parse_sense_buf(const uint8_t *in_buf, int in_len)
+{
+    bool fixed_in;
+    SCSISense sense;
+
+    assert(in_len > 0);
+    fixed_in = (in_buf[0] & 2) == 0;
+    if (fixed_in) {
+        if (in_len < 14) {
+            return SENSE_CODE(IO_ERROR);
+        }
+        sense.key = in_buf[2];
+        sense.asc = in_buf[12];
+        sense.ascq = in_buf[13];
+    } else {
+        if (in_len < 4) {
+            return SENSE_CODE(IO_ERROR);
+        }
+        sense.key = in_buf[1];
+        sense.asc = in_buf[2];
+        sense.ascq = in_buf[3];
+    }
+
+    return sense;
+}
+
+int scsi_build_sense_buf(uint8_t *out_buf, size_t size, SCSISense sense,
+                         bool fixed_sense)
+{
+    int len;
+    uint8_t buf[SCSI_SENSE_LEN] = { 0 };
+
+    if (fixed_sense) {
+        buf[0] = 0x70;
+        buf[2] = sense.key;
+        buf[7] = 10;
+        buf[12] = sense.asc;
+        buf[13] = sense.ascq;
+        len = 18;
+    } else {
+        buf[0] = 0x72;
+        buf[1] = sense.key;
+        buf[2] = sense.asc;
+        buf[3] = sense.ascq;
+        len = 8;
+    }
+    len = MIN(len, size);
+    memcpy(out_buf, buf, len);
+    return len;
+}
+
 int scsi_build_sense(uint8_t *buf, SCSISense sense)
 {
-    memset(buf, 0, 18);
-    buf[0] = 0x70;
-    buf[2] = sense.key;
-    buf[7] = 10;
-    buf[12] = sense.asc;
-    buf[13] = sense.ascq;
-    return 18;
+    return scsi_build_sense_buf(buf, SCSI_SENSE_LEN, sense, true);
 }
 
 /*
@@ -274,52 +319,21 @@ const struct SCSISense sense_code_SPACE_ALLOC_FAILED = {
 int scsi_convert_sense(uint8_t *in_buf, int in_len,
                        uint8_t *buf, int len, bool fixed)
 {
-    bool fixed_in;
     SCSISense sense;
-    if (!fixed && len < 8) {
-        return 0;
-    }
-
-    if (in_len == 0) {
-        sense.key = NO_SENSE;
-        sense.asc = 0;
-        sense.ascq = 0;
-    } else {
-        fixed_in = (in_buf[0] & 2) == 0;
-
-        if (fixed == fixed_in) {
-            memcpy(buf, in_buf, MIN(len, in_len));
-            return MIN(len, in_len);
-        }
+    bool fixed_in;
 
-        if (fixed_in) {
-            sense.key = in_buf[2];
-            sense.asc = in_buf[12];
-            sense.ascq = in_buf[13];
-        } else {
-            sense.key = in_buf[1];
-            sense.asc = in_buf[2];
-            sense.ascq = in_buf[3];
-        }
+    fixed_in = (in_buf[0] & 2) == 0;
+    if (in_len && fixed == fixed_in) {
+        memcpy(buf, in_buf, MIN(len, in_len));
+        return MIN(len, in_len);
     }
 
-    memset(buf, 0, len);
-    if (fixed) {
-        /* Return fixed format sense buffer */
-        buf[0] = 0x70;
-        buf[2] = sense.key;
-        buf[7] = 10;
-        buf[12] = sense.asc;
-        buf[13] = sense.ascq;
-        return MIN(len, SCSI_SENSE_LEN);
+    if (in_len == 0) {
+        sense = SENSE_CODE(NO_SENSE);
     } else {
-        /* Return descriptor format sense buffer */
-        buf[0] = 0x72;
-        buf[1] = sense.key;
-        buf[2] = sense.asc;
-        buf[3] = sense.ascq;
-        return 8;
+        sense = scsi_parse_sense_buf(in_buf, in_len);
     }
+    return scsi_build_sense_buf(buf, len, sense, fixed);
 }
 
 int scsi_sense_to_errno(int key, int asc, int ascq)
@@ -366,34 +380,15 @@ int scsi_sense_to_errno(int key, int asc, int ascq)
     }
 }
 
-int scsi_sense_buf_to_errno(const uint8_t *sense, size_t sense_size)
+int scsi_sense_buf_to_errno(const uint8_t *in_buf, size_t in_len)
 {
-    int key, asc, ascq;
-    if (sense_size < 1) {
-        return EIO;
-    }
-    switch (sense[0]) {
-    case 0x70: /* Fixed format sense data. */
-        if (sense_size < 14) {
-            return EIO;
-        }
-        key = sense[2] & 0xF;
-        asc = sense[12];
-        ascq = sense[13];
-        break;
-    case 0x72: /* Descriptor format sense data. */
-        if (sense_size < 4) {
-            return EIO;
-        }
-        key = sense[1] & 0xF;
-        asc = sense[2];
-        ascq = sense[3];
-        break;
-    default:
+    SCSISense sense;
+    if (in_len < 1) {
         return EIO;
-        break;
     }
-    return scsi_sense_to_errno(key, asc, ascq);
+
+    sense = scsi_parse_sense_buf(in_buf, in_len);
+    return scsi_sense_to_errno(sense.key, sense.asc, sense.ascq);
 }
 
 const char *scsi_command_name(uint8_t cmd)
-- 
1.8.3.1
