Received: from eggs.gnu.org ([2001:4830:134:3::10]:41477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dBfZz-00052O-9c
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dBfZw-0008SR-U4
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:56:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58834
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dBfZw-0008SF-OG
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:56:16 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4JAmvrw034105
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:56:16 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ahvaxgtmr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:56:15 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 19 May 2017 11:56:14 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri, 19 May 2017 12:55:46 +0200
In-Reply-To: <20170519105600.11589-1-cornelia.huck@de.ibm.com>
References: <20170519105600.11589-1-cornelia.huck@de.ibm.com>
Message-Id: <20170519105600.11589-8-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 07/21] pc-bios/s390-ccw: Build a reasonable
 max_sectors limit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, Eric Farman <farman@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Eric Farman <farman@linux.vnet.ibm.com>

Now that we've read all the possible limits that have been defined for
a virtio-scsi controller and the disk we're booting from, it's possible
that we are STILL going to exceed the limits of the host device.
For example, a "-device scsi-generic" device does not support the
Block Limits VPD page.

So, let's fallback to something that seems to work for most boot
configurations if larger values were specified (including if nothing
was explicitly specified, and we took default values).

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
Message-Id: <20170510155359.32727-8-farman@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 pc-bios/s390-ccw/virtio-scsi.c | 9 +++++++++
 pc-bios/s390-ccw/virtio-scsi.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index b722f25ad7..f61ecf0205 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -399,6 +399,15 @@ void virtio_scsi_setup(VDev *vdev)
         vdev->max_transfer = evpd_bl->max_transfer;
     }
 
+    /*
+     * The host sg driver will often be unhappy with particularly large
+     * I/Os that exceed the block iovec limits.  Let's enforce something
+     * reasonable, despite what the device configuration tells us.
+     */
+
+    vdev->max_transfer = MIN_NON_ZERO(VIRTIO_SCSI_MAX_SECTORS,
+                                      vdev->max_transfer);
+
     if (!scsi_read_capacity(vdev, data, data_size)) {
         virtio_scsi_verify_response(&resp, "virtio-scsi:setup:read_capacity");
     }
diff --git a/pc-bios/s390-ccw/virtio-scsi.h b/pc-bios/s390-ccw/virtio-scsi.h
index f50b38b18b..4c4f4bbc31 100644
--- a/pc-bios/s390-ccw/virtio-scsi.h
+++ b/pc-bios/s390-ccw/virtio-scsi.h
@@ -19,6 +19,8 @@
 #define VIRTIO_SCSI_CDB_SIZE   SCSI_DEFAULT_CDB_SIZE
 #define VIRTIO_SCSI_SENSE_SIZE SCSI_DEFAULT_SENSE_SIZE
 
+#define VIRTIO_SCSI_MAX_SECTORS 2048
+
 /* command-specific response values */
 #define VIRTIO_SCSI_S_OK                     0x00
 #define VIRTIO_SCSI_S_BAD_TARGET             0x03
-- 
2.13.0
