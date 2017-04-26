Received: from eggs.gnu.org ([2001:4830:134:3::10]:38020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d3ODf-0003Ob-3T
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d3ODa-0002Oa-61
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:47:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49099
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1d3ODa-0002LF-0g
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:46:58 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3QEi9rL094796
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 10:46:54 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a2ebwyu3d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 10:46:54 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Wed, 26 Apr 2017 15:46:52 +0100
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Wed, 26 Apr 2017 16:46:41 +0200
In-Reply-To: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
References: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
Message-Id: <20170426144645.12476-2-farman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v1 1/5] hw/scsi: Override the max_sectors
 value for virtio-scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Eric Farman <farman@linux.vnet.ibm.com>

The virtio spec states that the max_sectors field is
"a hint to the driver for the maximum transfer size"
that would be used for a virtio-scsi request.

It's currently hardcoded to xFFFF unless one is established
by the max_sectors parameter on the command line, but let's
roll through the associated devices and set it to anything
lower if one is set for the underlying block device and
retrieved by the BLKSECTGET ioctl.

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
---
 hw/scsi/virtio-scsi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 46a3e3f..bca9461 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -640,7 +640,11 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
                                    uint8_t *config)
 {
     VirtIOSCSIConfig *scsiconf = (VirtIOSCSIConfig *)config;
+    VirtIOSCSI *vs = VIRTIO_SCSI(vdev);
     VirtIOSCSICommon *s = VIRTIO_SCSI_COMMON(vdev);
+    SCSIDevice *d;
+    BusChild *kid;
+    unsigned int max_transfer;
 
     virtio_stl_p(vdev, &scsiconf->num_queues, s->conf.num_queues);
     virtio_stl_p(vdev, &scsiconf->seg_max, 128 - 2);
@@ -652,6 +656,14 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
     virtio_stw_p(vdev, &scsiconf->max_channel, VIRTIO_SCSI_MAX_CHANNEL);
     virtio_stw_p(vdev, &scsiconf->max_target, VIRTIO_SCSI_MAX_TARGET);
     virtio_stl_p(vdev, &scsiconf->max_lun, VIRTIO_SCSI_MAX_LUN);
+
+    QTAILQ_FOREACH(kid, &vs->bus.qbus.children, sibling) {
+        d = SCSI_DEVICE(kid->child);
+        max_transfer = blk_get_max_transfer(d->conf.blk) / d->blocksize;
+        virtio_stl_p(vdev,
+                     &scsiconf->max_sectors,
+                     MIN_NON_ZERO(max_transfer, scsiconf->max_sectors));
+    }
 }
 
 static void virtio_scsi_set_config(VirtIODevice *vdev,
-- 
2.10.2
