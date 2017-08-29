Received: from eggs.gnu.org ([2001:4830:134:3::10]:47962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCQ-0001Dx-Lz
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCN-0005Po-Ek
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41806
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCN-0005PV-9L
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:07 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E8Bm019422
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:06 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmsfn2w86-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:06 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:06 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:09 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-35-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 34/79] virtio-scsi: Unset hotplug handler when
 unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Fam Zheng <famz@redhat.com>

This matches the qbus_set_hotplug_handler in realize, and it releases
the final reference to the embedded VirtIODevice so that it is
properly finalized.

A use-after-free is fixed with this patch, indirectly:
virtio_device_instance_finalize wasn't called at hot-unplug, and the
vdev->listener would be a dangling pointer in the global and the per
address space listener list. See also RHBZ 1449031.

Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170518102808.30046-1-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 2cbe2de5454cf9af44b620b2b40d56361a12a45f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/scsi/virtio-scsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index bd62d08..cb1c123 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -915,6 +915,9 @@ void virtio_scsi_common_unrealize(DeviceState *dev, Error **errp)
 
 static void virtio_scsi_device_unrealize(DeviceState *dev, Error **errp)
 {
+    VirtIOSCSI *s = VIRTIO_SCSI(dev);
+
+    qbus_set_hotplug_handler(BUS(&s->bus), NULL, &error_abort);
     virtio_scsi_common_unrealize(dev, errp);
 }
 
-- 
2.7.4
