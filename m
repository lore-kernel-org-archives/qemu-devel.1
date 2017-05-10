Received: from eggs.gnu.org ([2001:4830:134:3::10]:49668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d8TwY-00019x-P1
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d8TwU-00031C-HE
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:54:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34562
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1d8TwU-00030p-AS
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:54:22 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4AFs7wF085393
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 11:54:21 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ac4ex557b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 11:54:21 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Wed, 10 May 2017 16:54:19 +0100
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Wed, 10 May 2017 17:53:57 +0200
In-Reply-To: <20170510155359.32727-1-farman@linux.vnet.ibm.com>
References: <20170510155359.32727-1-farman@linux.vnet.ibm.com>
Message-Id: <20170510155359.32727-7-farman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 6/8] pc-bios/s390-ccw: Get Block Limits
 VPD device data
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

The "Block Limits" Inquiry VPD page is optional for any SCSI device,
but if it's supported it provides a hint of the maximum I/O transfer
length for this particular device. If this page is supported by the
disk, let's issue that Inquiry and use the minimum of it and the
SCSI controller limit. That will cover this scenario:

  qemu-system-s390x ...
    -device virtio-scsi-ccw,id=scsi0,max_sectors=32768 ...
    -drive file=/dev/sda,if=none,id=drive0,format=raw ...
    -device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,
            drive=drive0,id=disk0,max_io_size=1048576

controller: 32768 sectors x 512 bytes/sector = 16777216 bytes
      disk:                                     1048576 bytes

Now that we have a limit for a virtio-scsi disk, compare that with the
limit for the virtio-scsi controller when we actually build the I/O.
The minimum of these two limits should be the one we use.

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/scsi.h        | 14 ++++++++++++++
 pc-bios/s390-ccw/virtio-scsi.c | 21 ++++++++++++++++++++-
 pc-bios/s390-ccw/virtio.h      |  1 +
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/scsi.h b/pc-bios/s390-ccw/scsi.h
index 803eff8..fe3fd5a 100644
--- a/pc-bios/s390-ccw/scsi.h
+++ b/pc-bios/s390-ccw/scsi.h
@@ -33,6 +33,7 @@
 /* SCSI Inquiry Pages */
 #define SCSI_INQUIRY_STANDARD_NONE              0x00U
 #define SCSI_INQUIRY_EVPD_SUPPORTED_PAGES       0x00U
+#define SCSI_INQUIRY_EVPD_BLOCK_LIMITS          0xb0U
 
 union ScsiLun {
     uint64_t v64;        /* numeric shortcut                             */
@@ -87,6 +88,19 @@ struct ScsiInquiryEvpdPages {
 }  __attribute__((packed));
 typedef struct ScsiInquiryEvpdPages ScsiInquiryEvpdPages;
 
+struct ScsiInquiryEvpdBl {
+    uint8_t peripheral_qdt; /* b0, use (b0 & 0x1f) to get SCSI_INQ_RDT  */
+    uint8_t page_code;
+    uint16_t page_length;
+    uint8_t b4;
+    uint8_t b5;
+    uint16_t b6;
+    uint32_t max_transfer;  /* b8                                       */
+    uint32_t b12[7];        /* b12..b43 (defined fields)                */
+    uint32_t b44[5];        /* b44..b63 (reserved fields)               */
+}  __attribute__((packed));
+typedef struct ScsiInquiryEvpdBl ScsiInquiryEvpdBl;
+
 struct ScsiCdbInquiry {
     uint8_t command;     /* b0, == 0x12         */
     uint8_t b1;          /* b1, |= 0x01 (evpd)  */
diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index e34755c..b722f25 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -20,6 +20,7 @@ static VirtioScsiCmdResp resp;
 
 static uint8_t scsi_inquiry_std_response[256];
 static ScsiInquiryEvpdPages scsi_inquiry_evpd_pages_response;
+static ScsiInquiryEvpdBl scsi_inquiry_evpd_bl_response;
 
 static inline void vs_assert(bool term, const char **msgs)
 {
@@ -262,9 +263,11 @@ int virtio_scsi_read_many(VDev *vdev,
     int sector_count;
     int f = vdev->blk_factor;
     unsigned int data_size;
+    unsigned int max_transfer = MIN_NON_ZERO(vdev->config.scsi.max_sectors,
+                                             vdev->max_transfer);
 
     do {
-        sector_count = MIN_NON_ZERO(sec_num, vdev->config.scsi.max_sectors);
+        sector_count = MIN_NON_ZERO(sec_num, max_transfer);
         data_size = sector_count * virtio_get_block_size() * f;
         if (!scsi_read_10(vdev, sector * f, sector_count * f, load_addr,
                           data_size)) {
@@ -321,6 +324,7 @@ void virtio_scsi_setup(VDev *vdev)
     uint8_t data[256];
     uint32_t data_size = sizeof(data);
     ScsiInquiryEvpdPages *evpd = &scsi_inquiry_evpd_pages_response;
+    ScsiInquiryEvpdBl *evpd_bl = &scsi_inquiry_evpd_bl_response;
     int i;
 
     vdev->scsi_device = &default_scsi_device;
@@ -378,6 +382,21 @@ void virtio_scsi_setup(VDev *vdev)
 
     for (i = 0; i <= evpd->page_length; i++) {
         debug_print_int("supported EVPD page", evpd->byte[i]);
+
+        if (evpd->byte[i] != SCSI_INQUIRY_EVPD_BLOCK_LIMITS) {
+            continue;
+        }
+
+        if (!scsi_inquiry(vdev,
+                          SCSI_INQUIRY_EVPD,
+                          SCSI_INQUIRY_EVPD_BLOCK_LIMITS,
+                          evpd_bl,
+                          sizeof(*evpd_bl))) {
+            virtio_scsi_verify_response(&resp, "virtio-scsi:setup:blocklimits");
+        }
+
+        debug_print_int("max transfer", evpd_bl->max_transfer);
+        vdev->max_transfer = evpd_bl->max_transfer;
     }
 
     if (!scsi_read_capacity(vdev, data, data_size)) {
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 3388a42..1eaf865 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -277,6 +277,7 @@ struct VDev {
     bool scsi_device_selected;
     ScsiDevice selected_scsi_device;
     uint64_t netboot_start_addr;
+    uint32_t max_transfer;
 };
 typedef struct VDev VDev;
 
-- 
2.10.2
