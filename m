Received: from eggs.gnu.org ([2001:4830:134:3::10]:56173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.vrabel@nutanix.com>) id 1exwU2-0006X8-Vi
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.vrabel@nutanix.com>) id 1exwTz-0001ou-OI
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:13:58 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:34710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david.vrabel@nutanix.com>)
	id 1exwTz-0001oN-GU
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:13:55 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2JF9JMb024328
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 08:13:54 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com
	(mail-sn1nam02lp0018.outbound.protection.outlook.com [216.32.180.18])
	by mx0b-002c1b01.pphosted.com with ESMTP id 2gs14gj32t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 08:13:53 -0700
From: David Vrabel <david.vrabel@nutanix.com>
Date: Mon, 19 Mar 2018 15:13:27 +0000
Message-Id: <20180319151327.17989-3-david.vrabel@nutanix.com>
In-Reply-To: <20180319151327.17989-1-david.vrabel@nutanix.com>
References: <20180319151327.17989-1-david.vrabel@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/2] vhost-user-scsi: reset the device if
 supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Vrabel <david.vrabel@nutanix.com>

If the vhost-user-scsi backend supports the VHOST_USER_F_RESET_DEVICE
protocol feature, then the device can be reset when requested.

If this feature is not supported, do not try a reset as this will send
a VHOST_USER_RESET_OWNER that the backend is not expecting,
potentially putting into an inoperable state.

Signed-off-by: David Vrabel <david.vrabel@nutanix.com>
---
 hw/scsi/vhost-user-scsi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 9389ed48e0..15e2dabebb 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -37,6 +37,10 @@ static const int user_feature_bits[] = {
     VHOST_INVALID_FEATURE_BIT
 };
 
+enum VhostUserProtocolFeature {
+    VHOST_USER_PROTOCOL_F_RESET_DEVICE = 8,
+};
+
 static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostUserSCSI *s = (VHostUserSCSI *)vdev;
@@ -60,6 +64,25 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
     }
 }
 
+static void vhost_user_scsi_reset(VirtIODevice *vdev)
+{
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(vdev);
+    struct vhost_dev *dev = &vsc->dev;
+
+    /*
+     * Historically, reset was not implemented so only reset devices
+     * that are expecting it.
+     */
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
+        return;
+    }
+
+    if (dev->vhost_ops->vhost_reset_device) {
+        dev->vhost_ops->vhost_reset_device(dev);
+    }
+}
+
 static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
 }
@@ -172,6 +195,7 @@ static void vhost_user_scsi_class_init(ObjectClass *klass, void *data)
     vdc->get_features = vhost_user_scsi_get_features;
     vdc->set_config = vhost_scsi_common_set_config;
     vdc->set_status = vhost_user_scsi_set_status;
+    vdc->reset = vhost_user_scsi_reset;
     fwc->get_dev_path = vhost_scsi_common_get_fw_dev_path;
 }
 
-- 
2.11.0
