Received: from eggs.gnu.org ([209.51.188.92]:43107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47C-0003nL-1Q
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB478-000537-OS
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43130
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB478-0004oa-EZ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:06 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4f0Z053901
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:50 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rkrjx58e3-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:41 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:29 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:24 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-51-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 50/97] virtio: do not take address of packed
 members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Paolo Bonzini <pbonzini@redhat.com>

The address of a packed member is not packed, which may cause accesses
to unaligned pointers.  Avoid this by reading the packed value before
passing it to another function.

Cc: Jason Wang <jasowang@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit d41ca5afe3bc513ecf10b3ba5aa59523e3cd54aa)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/char/virtio-serial-bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index d2dd8ab502..04e3ebe352 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -667,9 +667,9 @@ static void virtio_serial_save_device(VirtIODevice *vdev, QEMUFile *f)
 
     /* The config space (ignored on the far end in current versions) */
     get_config(vdev, (uint8_t *)&config);
-    qemu_put_be16s(f, &config.cols);
-    qemu_put_be16s(f, &config.rows);
-    qemu_put_be32s(f, &config.max_nr_ports);
+    qemu_put_be16(f, config.cols);
+    qemu_put_be16(f, config.rows);
+    qemu_put_be32(f, config.max_nr_ports);
 
     /* The ports map */
     max_nr_ports = s->serial.max_virtserial_ports;
-- 
2.17.1
