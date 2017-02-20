Received: from eggs.gnu.org ([2001:4830:134:3::10]:39416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkjD-0003uh-8n
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkj9-0005fN-9p
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53239
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cfkj9-0005f3-3F
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:51 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1K9rZwY100084
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:50 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28qsdd3c3m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:50 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 20 Feb 2017 09:57:48 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Mon, 20 Feb 2017 10:57:29 +0100
In-Reply-To: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
References: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
Message-Id: <20170220095734.7890-8-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 07/12] s390x: add property
 adapter_routes_max_batch
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

To make virtio-ccw supports more that  64 virtqueues we will have to
increase ADAPTER_ROUTES_MAX_GSI which is currently limiting the number if
possible adapter routes. Of course increasing the number of supported
routes can break backwards migration.

Let us introduce a compatibility property adapter_routes_max_batch so
client code can use the some old limit if in compatibility mode and
retain the migration compatibility.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/intc/s390_flic.c          | 28 ++++++++++++++++++++++++++++
 include/hw/s390x/s390_flic.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 6ab29efc65..bef4caf980 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -16,6 +16,8 @@
 #include "migration/qemu-file.h"
 #include "hw/s390x/s390_flic.h"
 #include "trace.h"
+#include "hw/qdev.h"
+#include "qapi/error.h"
 
 S390FLICState *s390_get_flic(void)
 {
@@ -85,6 +87,30 @@ static void qemu_s390_flic_class_init(ObjectClass *oc, void *data)
     fsc->clear_io_irq = qemu_s390_clear_io_flic;
 }
 
+static Property s390_flic_common_properties[] = {
+    DEFINE_PROP_UINT32("adapter_routes_max_batch", S390FLICState,
+                       adapter_routes_max_batch, ADAPTER_ROUTES_MAX_GSI),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void s390_flic_common_realize(DeviceState *dev, Error **errp)
+{
+    uint32_t max_batch = S390_FLIC_COMMON(dev)->adapter_routes_max_batch;
+
+    if (max_batch > ADAPTER_ROUTES_MAX_GSI) {
+        error_setg(errp, "flic adapter_routes_max_batch too big"
+                   "%d (%d allowed)", max_batch, ADAPTER_ROUTES_MAX_GSI);
+    }
+}
+
+static void s390_flic_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->props = s390_flic_common_properties;
+    dc->realize = s390_flic_common_realize;
+}
+
 static const TypeInfo qemu_s390_flic_info = {
     .name          = TYPE_QEMU_S390_FLIC,
     .parent        = TYPE_S390_FLIC_COMMON,
@@ -92,10 +118,12 @@ static const TypeInfo qemu_s390_flic_info = {
     .class_init    = qemu_s390_flic_class_init,
 };
 
+
 static const TypeInfo s390_flic_common_info = {
     .name          = TYPE_S390_FLIC_COMMON,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(S390FLICState),
+    .class_init    = s390_flic_class_init,
     .class_size    = sizeof(S390FLICStateClass),
 };
 
diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index 9094edadf5..9f0b05c71b 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -32,6 +32,8 @@ typedef struct AdapterRoutes {
 
 typedef struct S390FLICState {
     SysBusDevice parent_obj;
+    /* to limit AdapterRoutes.num_routes for compat */
+    uint32_t adapter_routes_max_batch;
 
 } S390FLICState;
 
-- 
2.11.0
