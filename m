Received: from eggs.gnu.org ([2001:4830:134:3::10]:39454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkjG-0003yF-GI
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:58:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkjC-0005ip-Gw
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46015
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cfkjC-0005iG-B0
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:54 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1K9rcik022519
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:53 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28pk55nyfu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:53 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 20 Feb 2017 09:57:51 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Mon, 20 Feb 2017 10:57:31 +0100
In-Reply-To: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
References: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
Message-Id: <20170220095734.7890-10-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 09/12] s390x: bump ADAPTER_ROUTES_MAX_GSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Let's increase ADAPTER_ROUTES_MAX_GSI to VIRTIO_QUEUE_MAX which is the
largest demand foreseeable at the moment. Let us add a compatibility
macro for the previous machines so client code can maintain backwards
migration compatibility

To not mess up migration compatibility for virtio-ccw
VIRTIO_CCW_QUEUE_MAX is left at it's current value, and will be dropped
when virtio-ccw is converted to use the capability of the flic
introduced by this patch.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c   |  7 ++++++-
 include/hw/s390x/s390_flic.h | 10 ++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index e9a676797a..ea244bbf55 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -336,7 +336,12 @@ static const TypeInfo ccw_machine_info = {
     type_init(ccw_machine_register_##suffix)
 
 #define CCW_COMPAT_2_8 \
-        HW_COMPAT_2_8
+        HW_COMPAT_2_8 \
+        {\
+            .driver   = TYPE_S390_FLIC_COMMON,\
+            .property = "adapter_routes_max_batch",\
+            .value    = "64",\
+        },
 
 #define CCW_COMPAT_2_7 \
         HW_COMPAT_2_7
diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index 9f0b05c71b..7f8ec7541b 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -17,8 +17,14 @@
 #include "hw/s390x/adapter.h"
 #include "hw/virtio/virtio.h"
 
-#define ADAPTER_ROUTES_MAX_GSI 64
-#define VIRTIO_CCW_QUEUE_MAX ADAPTER_ROUTES_MAX_GSI
+/*
+ * Reserve enough gsis to accommodate all virtio devices.
+ * If any other user of adapter routes needs more of these,
+ * we need to bump the value; but virtio looks like the
+ * maximum right now.
+ */
+#define ADAPTER_ROUTES_MAX_GSI VIRTIO_QUEUE_MAX
+#define VIRTIO_CCW_QUEUE_MAX 64
 
 typedef struct AdapterRoutes {
     AdapterInfo adapter;
-- 
2.11.0
