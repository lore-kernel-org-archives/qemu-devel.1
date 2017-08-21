Received: from eggs.gnu.org ([2001:4830:134:3::10]:54832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1djnPU-0002um-T1
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1djnPQ-0001fq-6r
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:10:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1djnPQ-0001dR-17
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:10:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17D26C047B82
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 14:10:27 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Mon, 21 Aug 2017 22:10:07 +0800
Message-Id: <20170821141008.19383-4-famz@redhat.com>
In-Reply-To: <20170821141008.19383-1-famz@redhat.com>
References: <20170821141008.19383-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 3/4] scsi: Introduce scsi_sense_buf_to_errno
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

This recognizes the "fixed" and "descriptor" format sense data, extracts
the sense key/asc/ascq fields then converts them to an errno.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/scsi/scsi.h |  1 +
 util/scsi.c         | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index f894ace4bf..fe330385d8 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -15,5 +15,6 @@
 #define QEMU_SCSI_H
 
 int scsi_sense_to_errno(int key, int asc, int ascq);
+int scsi_sense_buf_to_errno(const uint8_t *sense, size_t sense_size);
 
 #endif
diff --git a/util/scsi.c b/util/scsi.c
index 472eb5bea5..472293d59b 100644
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
2.13.5
