Received: from eggs.gnu.org ([2001:4830:134:3::10]:43831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dD7kk-0007Se-7a
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dD7kf-0002tG-OB
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:13:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dD7kf-0002rj-FG
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:13:21 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4NB4Ikd105859
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 07:13:20 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2amc2g4279-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 07:13:20 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 23 May 2017 12:13:17 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 23 May 2017 13:12:50 +0200
In-Reply-To: <20170523111306.25493-1-cornelia.huck@de.ibm.com>
References: <20170523111306.25493-1-cornelia.huck@de.ibm.com>
Message-Id: <20170523111306.25493-6-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 05/21] pc-bios/s390-ccw: Get list of supported
 VPD pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@redhat.com
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Eric Farman <farman@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Eric Farman <farman@linux.vnet.ibm.com>

The "Supported Pages" Inquiry EVPD page is mandatory for all SCSI devices,
and is used as a gateway for what VPD pages the device actually supports.
Let's issue this Inquiry, and dump that list with the debug facility.

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
Message-Id: <20170510155359.32727-6-farman@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 pc-bios/s390-ccw/scsi.h        | 10 ++++++++++
 pc-bios/s390-ccw/virtio-scsi.c | 17 +++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/pc-bios/s390-ccw/scsi.h b/pc-bios/s390-ccw/scsi.h
index 83ffaef54e..803eff8ae3 100644
--- a/pc-bios/s390-ccw/scsi.h
+++ b/pc-bios/s390-ccw/scsi.h
@@ -28,9 +28,11 @@
 
 /* SCSI Inquiry Types */
 #define SCSI_INQUIRY_STANDARD                   0x00U
+#define SCSI_INQUIRY_EVPD                       0x01U
 
 /* SCSI Inquiry Pages */
 #define SCSI_INQUIRY_STANDARD_NONE              0x00U
+#define SCSI_INQUIRY_EVPD_SUPPORTED_PAGES       0x00U
 
 union ScsiLun {
     uint64_t v64;        /* numeric shortcut                             */
@@ -77,6 +79,14 @@ struct ScsiInquiryStd {
 }  __attribute__((packed));
 typedef struct ScsiInquiryStd ScsiInquiryStd;
 
+struct ScsiInquiryEvpdPages {
+    uint8_t peripheral_qdt; /* b0, use (b0 & 0x1f) to get SCSI_INQ_RDT  */
+    uint8_t page_code;      /* b1                                       */
+    uint16_t page_length;   /* b2..b3 length = N-3                      */
+    uint8_t byte[28];       /* b4..bN Supported EVPD pages (N=31 here)  */
+}  __attribute__((packed));
+typedef struct ScsiInquiryEvpdPages ScsiInquiryEvpdPages;
+
 struct ScsiCdbInquiry {
     uint8_t command;     /* b0, == 0x12         */
     uint8_t b1;          /* b1, |= 0x01 (evpd)  */
diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index 9d2e14cdf0..e34755c4d4 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -19,6 +19,7 @@ static VirtioScsiCmdReq req;
 static VirtioScsiCmdResp resp;
 
 static uint8_t scsi_inquiry_std_response[256];
+static ScsiInquiryEvpdPages scsi_inquiry_evpd_pages_response;
 
 static inline void vs_assert(bool term, const char **msgs)
 {
@@ -319,6 +320,8 @@ void virtio_scsi_setup(VDev *vdev)
     int retry_test_unit_ready = 3;
     uint8_t data[256];
     uint32_t data_size = sizeof(data);
+    ScsiInquiryEvpdPages *evpd = &scsi_inquiry_evpd_pages_response;
+    int i;
 
     vdev->scsi_device = &default_scsi_device;
     virtio_scsi_locate_device(vdev);
@@ -363,6 +366,20 @@ void virtio_scsi_setup(VDev *vdev)
         vdev->scsi_block_size = VIRTIO_ISO_BLOCK_SIZE;
     }
 
+    if (!scsi_inquiry(vdev,
+                      SCSI_INQUIRY_EVPD,
+                      SCSI_INQUIRY_EVPD_SUPPORTED_PAGES,
+                      evpd,
+                      sizeof(*evpd))) {
+        virtio_scsi_verify_response(&resp, "virtio-scsi:setup:supported_pages");
+    }
+
+    debug_print_int("EVPD length", evpd->page_length);
+
+    for (i = 0; i <= evpd->page_length; i++) {
+        debug_print_int("supported EVPD page", evpd->byte[i]);
+    }
+
     if (!scsi_read_capacity(vdev, data, data_size)) {
         virtio_scsi_verify_response(&resp, "virtio-scsi:setup:read_capacity");
     }
-- 
2.13.0
