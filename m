Received: from eggs.gnu.org ([2001:4830:134:3::10]:49657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d8TwX-00019E-IV
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d8TwT-00030h-GG
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:54:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39716
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1d8TwT-00030S-9w
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:54:21 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4AFrl0w044867
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 11:54:20 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ac5r58j77-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 11:54:20 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Wed, 10 May 2017 16:54:18 +0100
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Wed, 10 May 2017 17:53:55 +0200
In-Reply-To: <20170510155359.32727-1-farman@linux.vnet.ibm.com>
References: <20170510155359.32727-1-farman@linux.vnet.ibm.com>
Message-Id: <20170510155359.32727-5-farman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 4/8] pc-bios/s390-ccw: Refactor
 scsi_inquiry function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>

If we want to issue any of the SCSI Inquiry EVPD pages,
which we do, we could use this function to issue both types
of commands with a little bit of refactoring.

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/scsi.h        |  6 ++++++
 pc-bios/s390-ccw/virtio-scsi.c | 10 ++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/scsi.h b/pc-bios/s390-ccw/scsi.h
index fc830f7..83ffaef 100644
--- a/pc-bios/s390-ccw/scsi.h
+++ b/pc-bios/s390-ccw/scsi.h
@@ -26,6 +26,12 @@
 #define SCSI_SENSE_KEY_NO_SENSE                 0
 #define SCSI_SENSE_KEY_UNIT_ATTENTION           6
 
+/* SCSI Inquiry Types */
+#define SCSI_INQUIRY_STANDARD                   0x00U
+
+/* SCSI Inquiry Pages */
+#define SCSI_INQUIRY_STANDARD_NONE              0x00U
+
 union ScsiLun {
     uint64_t v64;        /* numeric shortcut                             */
     uint8_t  v8[8];      /* generic 8 bytes representation               */
diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index ff65e2e..9d2e14c 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -89,10 +89,13 @@ static void vs_run(const char *title, VirtioCmd *cmd, VDev *vdev,
 
 /* SCSI protocol implementation routines */
 
-static bool scsi_inquiry(VDev *vdev, void *data, uint32_t data_size)
+static bool scsi_inquiry(VDev *vdev, uint8_t evpd, uint8_t page,
+                         void *data, uint32_t data_size)
 {
     ScsiCdbInquiry cdb = {
         .command = 0x12,
+        .b1 = evpd,
+        .b2 = page,
         .alloc_len = data_size < 65535 ? data_size : 65535,
     };
     VirtioCmd inquiry[] = {
@@ -346,7 +349,10 @@ void virtio_scsi_setup(VDev *vdev)
     }
 
     /* read and cache SCSI INQUIRY response */
-    if (!scsi_inquiry(vdev, scsi_inquiry_std_response,
+    if (!scsi_inquiry(vdev,
+                      SCSI_INQUIRY_STANDARD,
+                      SCSI_INQUIRY_STANDARD_NONE,
+                      scsi_inquiry_std_response,
                       sizeof(scsi_inquiry_std_response))) {
         virtio_scsi_verify_response(&resp, "virtio-scsi:setup:inquiry");
     }
-- 
2.10.2
