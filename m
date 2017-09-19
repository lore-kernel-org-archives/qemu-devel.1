Received: from eggs.gnu.org ([2001:4830:134:3::10]:59684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHf4-0003m0-UD
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHf1-0005Eq-HM
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:58 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHf1-0005EL-C3
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:55 -0400
Received: by mail-wm0-x244.google.com with SMTP id i131so3748990wma.1
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:29:55 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:28:59 +0200
Message-Id: <1505824179-21541-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/50] scsi: Introduce scsi_sense_buf_to_errno
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

This recognizes the "fixed" and "descriptor" format sense data, extracts
the sense key/asc/ascq fields then converts them to an errno.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170821141008.19383-4-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/scsi/scsi.h |  1 +
 util/scsi.c         | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index f894ace..fe33038 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -15,5 +15,6 @@
 #define QEMU_SCSI_H
 
 int scsi_sense_to_errno(int key, int asc, int ascq);
+int scsi_sense_buf_to_errno(const uint8_t *sense, size_t sense_size);
 
 #endif
diff --git a/util/scsi.c b/util/scsi.c
index 472eb5b..472293d 100644
--- a/util/scsi.c
+++ b/util/scsi.c
@@ -58,3 +58,33 @@ int scsi_sense_to_errno(int key, int asc, int ascq)
         return EIO;
     }
 }
+
+int scsi_sense_buf_to_errno(const uint8_t *sense, size_t sense_size)
+{
+    int key, asc, ascq;
+    if (sense_size < 1) {
+        return EIO;
+    }
+    switch (sense[0]) {
+    case 0x70: /* Fixed format sense data. */
+        if (sense_size < 14) {
+            return EIO;
+        }
+        key = sense[2] & 0xF;
+        asc = sense[12];
+        ascq = sense[13];
+        break;
+    case 0x72: /* Descriptor format sense data. */
+        if (sense_size < 4) {
+            return EIO;
+        }
+        key = sense[1] & 0xF;
+        asc = sense[2];
+        ascq = sense[3];
+        break;
+    default:
+        return EIO;
+        break;
+    }
+    return scsi_sense_to_errno(key, asc, ascq);
+}
-- 
1.8.3.1
