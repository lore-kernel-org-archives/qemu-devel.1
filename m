Received: from eggs.gnu.org ([2001:4830:134:3::10]:45698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1eKq4D-0000Kx-UX
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1eKq49-0001bb-Ni
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:29:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1eKq49-0001bM-Eg
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:29:37 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB1FFOD6059267
	for <qemu-devel@nongnu.org>; Fri, 1 Dec 2017 10:15:48 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ek86jd4hr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Dec 2017 10:15:47 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Fri, 1 Dec 2017 15:15:45 -0000
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Fri,  1 Dec 2017 16:15:38 +0100
In-Reply-To: <20171201151538.6844-1-farman@linux.vnet.ibm.com>
References: <20171201151538.6844-1-farman@linux.vnet.ibm.com>
Message-Id: <20171201151538.6844-2-farman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] vhost-scsi: add missing virtqueue_size
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Dariusz Stojaczyk <dariuszx.stojaczyk@intel.com>, Felipe Franciosi <felipe@nutanix.com>, qemu-devel@nongnu.org, Eric Farman <farman@linux.vnet.ibm.com>

Commit 5c0919d02066 ("virtio-scsi: Add virtqueue_size parameter allowing
virtqueue size to be set.") introduced a new parameter to virtio-scsi.
Later, commit 920036106044 ("vhost-user-scsi: add missing virtqueue_size
param") added that parameter to the new vhost-user-scsi interface but
neglected the existing vhost-scsi interface it was built on.

Apply the same change to vhost-scsi, so that we can boot a guest with
a device defined.  This also avoids crashing a guest when hotplugging
a vhost-scsi device.

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
---
 hw/scsi/vhost-scsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index cd4ab05233..9c1bea8ff3 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -233,6 +233,8 @@ static Property vhost_scsi_properties[] = {
     DEFINE_PROP_STRING("wwpn", VirtIOSCSICommon, conf.wwpn),
     DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
     DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues, 1),
+    DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_size,
+                       128),
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
                        0xFFFF),
     DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),
-- 
2.13.5
