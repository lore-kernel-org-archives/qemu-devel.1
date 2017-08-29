Received: from eggs.gnu.org ([2001:4830:134:3::10]:48266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCa-0001Qm-7a
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCW-0005dq-LA
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCW-0005bN-9Z
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:16 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E8hL005492
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:15 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmvjejkm8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:15 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:14 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:22 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-48-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 47/79] virtio-serial-bus: Unset hotplug handler
 when unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ladi Prosek <lprosek@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: Ladi Prosek <lprosek@redhat.com>

Virtio serial device controls the lifetime of virtio-serial-bus and
virtio-serial-bus links back to the device via its hotplug-handler
property. This extra ref-count prevents the device from getting
finalized, leaving the VirtIODevice memory listener registered and
leading to use-after-free later on.

This patch addresses the same issue as Fam Zheng's
"virtio-scsi: Unset hotplug handler when unrealize"
only for a different virtio device.

Cc: qemu-stable@nongnu.org
Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
(cherry picked from commit f811f97040a48358b456b46ecbc9167f0131034f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/char/virtio-serial-bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index d797a67..aa9c11a 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1121,6 +1121,9 @@ static void virtio_serial_device_unrealize(DeviceState *dev, Error **errp)
         timer_free(vser->post_load->timer);
         g_free(vser->post_load);
     }
+
+    qbus_set_hotplug_handler(BUS(&vser->bus), NULL, errp);
+
     virtio_cleanup(vdev);
 }
 
-- 
2.7.4
