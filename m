Received: from eggs.gnu.org ([2001:4830:134:3::10]:59424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gPrxc-0007ee-B4
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:36:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gPrxX-0008Tj-AP
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:36:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gPrxX-0008SW-2F
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:36:07 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAMGYFp2099197
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 11:36:06 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nwxns3xdp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 11:36:05 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Thu, 22 Nov 2018 16:36:03 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 22 Nov 2018 17:35:50 +0100
In-Reply-To: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1542904555-1136-2-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/6] s390x/vfio: ap: Finding the AP bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: borntraeger@de.ibm.com
Cc: cohuck@redhat.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com

In the case we will enter QEMU through interception of instructions,
we will need to retrieve the AP devices.
The base device is the AP bridge.

Let us implement a way to retrieve the AP Bridge from qtree.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 hw/s390x/ap-bridge.c         | 12 ++++++++++++
 include/hw/s390x/ap-bridge.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
index 3795d30..831ad5d 100644
--- a/hw/s390x/ap-bridge.c
+++ b/hw/s390x/ap-bridge.c
@@ -14,6 +14,18 @@
 #include "hw/s390x/ap-bridge.h"
 #include "cpu.h"
 
+DeviceState *s390_get_ap_bridge(void)
+{
+    static DeviceState *apb;
+
+    if (!apb) {
+        apb = DEVICE(object_resolve_path(TYPE_AP_BRIDGE, NULL));
+        assert(apb != NULL);
+    }
+
+    return apb;
+}
+
 static char *ap_bus_get_dev_path(DeviceState *dev)
 {
     /* at most one */
diff --git a/include/hw/s390x/ap-bridge.h b/include/hw/s390x/ap-bridge.h
index 470e439..dacb877 100644
--- a/include/hw/s390x/ap-bridge.h
+++ b/include/hw/s390x/ap-bridge.h
@@ -15,5 +15,6 @@
 #define TYPE_AP_BUS "ap-bus"
 
 void s390_init_ap(void);
+DeviceState *s390_get_ap_bridge(void);
 
 #endif
-- 
2.7.4
