Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B78C47095
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9049C2083B
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGgYRS+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9049C2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPrsa-0003Xy-7B
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 14:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kPrkr-000374-13
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 14:32:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49826)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kPrkc-0006Q4-LR
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 14:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602009109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=MnWZwUdy4Q6HkOQDCypZN0dlkm5RNq9Fpgh72pTp3Sk=;
 b=hGgYRS+/bndExhN56Nqd0pennwgwUQ191ZilAiC55lJxBjq72NpU78hTsW1kTs3pdCzGWm
 Fyql3GYXpTdd4mh4uE8Gj6fwEb9xvx7z1QujzhwnZ6uyDgKz6MHHnIRNjMYnRy88cYSSpp
 6b3xTG3i+wFLM6qDxh6Rll/+emm0d0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-1nGCefFENruyeOMjCzFKkQ-1; Tue, 06 Oct 2020 14:31:45 -0400
X-MC-Unique: 1nGCefFENruyeOMjCzFKkQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB74B18A8223;
 Tue,  6 Oct 2020 18:31:43 +0000 (UTC)
Received: from thuth.com (ovpn-113-60.ams2.redhat.com [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9DD86EF43;
 Tue,  6 Oct 2020 18:31:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/16] pc-bios/s390-ccw: Do not bail out early if not finding a
 SCSI disk
Date: Tue,  6 Oct 2020 20:31:11 +0200
Message-Id: <20201006183122.155609-6-thuth@redhat.com>
In-Reply-To: <20201006183122.155609-1-thuth@redhat.com>
References: <20201006183122.155609-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In case the user did not specify a boot device, we want to continue
looking for other devices if there are no valid SCSI disks on a virtio-
scsi controller. As a first step, do not panic in this case and let
the control flow carry the error to the upper functions instead.

Message-Id: <20200806105349.632-6-thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/main.c          | 14 ++++++++++----
 pc-bios/s390-ccw/s390-ccw.h      |  2 +-
 pc-bios/s390-ccw/virtio-blkdev.c |  7 +++++--
 pc-bios/s390-ccw/virtio-scsi.c   | 28 ++++++++++++++++++++--------
 pc-bios/s390-ccw/virtio-scsi.h   |  2 +-
 5 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 0d2aabbc58..7bdd12ab2e 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -218,7 +218,7 @@ static void find_boot_device(void)
     IPL_assert(found, "Boot device not found\n");
 }
 
-static void virtio_setup(void)
+static int virtio_setup(void)
 {
     VDev *vdev = virtio_get_device();
     QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
@@ -233,9 +233,14 @@ static void virtio_setup(void)
         sclp_print("Network boot device detected\n");
         vdev->netboot_start_addr = qipl.netboot_start_addr;
     } else {
-        virtio_blk_setup_device(blk_schid);
+        int ret = virtio_blk_setup_device(blk_schid);
+        if (ret) {
+            return ret;
+        }
         IPL_assert(virtio_ipl_disk_is_valid(), "No valid IPL device detected");
     }
+
+    return 0;
 }
 
 static void ipl_boot_device(void)
@@ -246,8 +251,9 @@ static void ipl_boot_device(void)
         dasd_ipl(blk_schid, cutype); /* no return */
         break;
     case CU_TYPE_VIRTIO:
-        virtio_setup();
-        zipl_load(); /* no return */
+        if (virtio_setup() == 0) {
+            zipl_load(); /* no return */
+        }
         break;
     default:
         print_int("Attempting to boot from unexpected device type", cutype);
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index dbc4c64851..9b86c120b4 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -69,7 +69,7 @@ int sclp_read(char *str, size_t count);
 unsigned long virtio_load_direct(ulong rec_list1, ulong rec_list2,
                                  ulong subchan_id, void *load_addr);
 bool virtio_is_supported(SubChannelId schid);
-void virtio_blk_setup_device(SubChannelId schid);
+int virtio_blk_setup_device(SubChannelId schid);
 int virtio_read(ulong sector, void *load_addr);
 
 /* bootmap.c */
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index 11c56261ca..7d35050292 100644
--- a/pc-bios/s390-ccw/virtio-blkdev.c
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
@@ -263,9 +263,10 @@ uint64_t virtio_get_blocks(void)
     return 0;
 }
 
-void virtio_blk_setup_device(SubChannelId schid)
+int virtio_blk_setup_device(SubChannelId schid)
 {
     VDev *vdev = virtio_get_device();
+    int ret = 0;
 
     vdev->schid = schid;
     virtio_setup_ccw(vdev);
@@ -288,9 +289,11 @@ void virtio_blk_setup_device(SubChannelId schid)
             "Config: CDB size mismatch");
 
         sclp_print("Using virtio-scsi.\n");
-        virtio_scsi_setup(vdev);
+        ret = virtio_scsi_setup(vdev);
         break;
     default:
         panic("\n! No IPL device available !\n");
     }
+
+    return ret;
 }
diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index eddfb8a7ad..2c8d0f3097 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -194,7 +194,12 @@ static bool scsi_read_capacity(VDev *vdev,
 
 /* virtio-scsi routines */
 
-static void virtio_scsi_locate_device(VDev *vdev)
+/*
+ * Tries to locate a SCSI device and and adds the information for the found
+ * device to the vdev->scsi_device structure.
+ * Returns 0 if SCSI device could be located, or a error code < 0 otherwise
+ */
+static int virtio_scsi_locate_device(VDev *vdev)
 {
     const uint16_t channel = 0; /* again, it's what QEMU does */
     uint16_t target;
@@ -220,7 +225,7 @@ static void virtio_scsi_locate_device(VDev *vdev)
         IPL_check(sdev->channel == 0, "non-zero channel requested");
         IPL_check(sdev->target <= vdev->config.scsi.max_target, "target# high");
         IPL_check(sdev->lun <= vdev->config.scsi.max_lun, "LUN# high");
-        return;
+        return 0;
     }
 
     for (target = 0; target <= vdev->config.scsi.max_target; target++) {
@@ -247,18 +252,20 @@ static void virtio_scsi_locate_device(VDev *vdev)
              */
             sdev->lun = r->lun[0].v16[0]; /* it's returned this way */
             debug_print_int("Have to use LUN", sdev->lun);
-            return; /* we have to use this device */
+            return 0; /* we have to use this device */
         }
         for (i = 0; i < luns; i++) {
             if (r->lun[i].v64) {
                 /* Look for non-zero LUN - we have where to choose from */
                 sdev->lun = r->lun[i].v16[0];
                 debug_print_int("Will use LUN", sdev->lun);
-                return; /* we have found a device */
+                return 0; /* we have found a device */
             }
         }
     }
-    panic("\n! Cannot locate virtio-scsi device !\n");
+
+    sclp_print("Warning: Could not locate a usable virtio-scsi device\n");
+    return -ENODEV;
 }
 
 int virtio_scsi_read_many(VDev *vdev,
@@ -322,17 +329,20 @@ static void scsi_parse_capacity_report(void *data,
     }
 }
 
-void virtio_scsi_setup(VDev *vdev)
+int virtio_scsi_setup(VDev *vdev)
 {
     int retry_test_unit_ready = 3;
     uint8_t data[256];
     uint32_t data_size = sizeof(data);
     ScsiInquiryEvpdPages *evpd = &scsi_inquiry_evpd_pages_response;
     ScsiInquiryEvpdBl *evpd_bl = &scsi_inquiry_evpd_bl_response;
-    int i;
+    int i, ret;
 
     vdev->scsi_device = &default_scsi_device;
-    virtio_scsi_locate_device(vdev);
+    ret = virtio_scsi_locate_device(vdev);
+    if (ret < 0) {
+        return ret;
+    }
 
     /* We have to "ping" the device before it becomes readable */
     while (!scsi_test_unit_ready(vdev)) {
@@ -417,4 +427,6 @@ void virtio_scsi_setup(VDev *vdev)
     }
     scsi_parse_capacity_report(data, &vdev->scsi_last_block,
                                (uint32_t *) &vdev->scsi_block_size);
+
+    return 0;
 }
diff --git a/pc-bios/s390-ccw/virtio-scsi.h b/pc-bios/s390-ccw/virtio-scsi.h
index 4c4f4bbc31..4b14c2c2f9 100644
--- a/pc-bios/s390-ccw/virtio-scsi.h
+++ b/pc-bios/s390-ccw/virtio-scsi.h
@@ -67,7 +67,7 @@ static inline bool virtio_scsi_response_ok(const VirtioScsiCmdResp *r)
         return r->response == VIRTIO_SCSI_S_OK && r->status == CDB_STATUS_GOOD;
 }
 
-void virtio_scsi_setup(VDev *vdev);
+int virtio_scsi_setup(VDev *vdev);
 int virtio_scsi_read_many(VDev *vdev,
                           ulong sector, void *load_addr, int sec_num);
 
-- 
2.18.2


