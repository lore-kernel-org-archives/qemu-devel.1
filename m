Received: from eggs.gnu.org ([2001:4830:134:3::10]:45433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6h8Y-00013B-P4
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6h8V-0005IZ-Lq
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d6h8V-0005IB-Ce
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:23 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45HXmXa118290
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 13:35:22 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a8nedj76f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 13:35:22 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 5 May 2017 18:35:19 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri,  5 May 2017 19:35:02 +0200
In-Reply-To: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170505173507.74077-6-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 05/10] virtio-ccw: add vmstate entities for
 VirtioCcwDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

As a preparation for a transition to a vmstate based migration let us
introduce vmstate entities for VirtioCcwDevice and its members. This
patch does not take care of config_vector which is common VirtIO state
but not migrated by common VirtiIO code.

No changes in behavior, we just added some dead code -- which  should
rise to life soon.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
---

Note: In this patch series the config_vector issue is handled by the
patch "virtio-ccw: use vmstate way for config migration". Further
details there.
---
 hw/intc/s390_flic.c          | 48 ++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.c        | 38 +++++++++++++++++++++++++++++++++++
 include/hw/s390x/s390_flic.h |  5 +++++
 3 files changed, 91 insertions(+)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 711c114..b889e74 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -18,6 +18,7 @@
 #include "trace.h"
 #include "hw/qdev.h"
 #include "qapi/error.h"
+#include "hw/s390x/s390-virtio-ccw.h"
 
 S390FLICState *s390_get_flic(void)
 {
@@ -137,3 +138,50 @@ static void qemu_s390_flic_register_types(void)
 }
 
 type_init(qemu_s390_flic_register_types)
+
+static bool adapter_info_so_needed(void *opaque)
+{
+    return css_migration_enabled();
+}
+
+const VMStateDescription vmstate_adapter_info_so = {
+    .name = "s390_adapter_info/summary_offset",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = adapter_info_so_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(summary_offset, AdapterInfo),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+const VMStateDescription vmstate_adapter_info = {
+    .name = "s390_adapter_info",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(ind_offset, AdapterInfo),
+        /*
+         * We do not have to migrate neither the id nor the addresses.
+         * The id is set by css_register_io_adapter and the addresses
+         * are set based on the IndAddr objects after those get mapped.
+         */
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_adapter_info_so,
+        NULL
+    }
+};
+
+const VMStateDescription vmstate_adapter_routes = {
+
+    .name = "s390_adapter_routes",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(adapter, AdapterRoutes, 1, vmstate_adapter_info, \
+                       AdapterInfo),
+        VMSTATE_END_OF_LIST()
+    }
+};
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index e7167e3..c2badfe 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -34,9 +34,47 @@
 #include "virtio-ccw.h"
 #include "trace.h"
 #include "hw/s390x/css-bridge.h"
+#include "hw/s390x/s390-virtio-ccw.h"
 
 #define NR_CLASSIC_INDICATOR_BITS 64
 
+static int virtio_ccw_dev_post_load(void *opaque, int version_id)
+{
+    VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(opaque);
+    CcwDevice *ccw_dev = CCW_DEVICE(dev);
+    CCWDeviceClass *ck = CCW_DEVICE_GET_CLASS(ccw_dev);
+
+    ccw_dev->sch->driver_data = dev;
+    if (CCW_DEVICE(dev)->sch->thinint_active) {
+        dev->routes.adapter.adapter_id = css_get_adapter_id(
+                                         CSS_IO_ADAPTER_VIRTIO,
+                                         dev->thinint_isc);
+    }
+    /* Re-fill subch_id after loading the subchannel states.*/
+    if (ck->refill_ids) {
+        ck->refill_ids(ccw_dev);
+    }
+    return 0;
+}
+
+const VMStateDescription vmstate_virtio_ccw_dev = {
+    .name = "s390_virtio_ccw_dev",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = virtio_ccw_dev_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_CCW_DEVICE(parent_obj, VirtioCcwDevice),
+        VMSTATE_PTR_TO_IND_ADDR(indicators, VirtioCcwDevice),
+        VMSTATE_PTR_TO_IND_ADDR(indicators2, VirtioCcwDevice),
+        VMSTATE_PTR_TO_IND_ADDR(summary_indicator, VirtioCcwDevice),
+        VMSTATE_STRUCT(routes, VirtioCcwDevice, 1, vmstate_adapter_routes, \
+                       AdapterRoutes),
+        VMSTATE_UINT8(thinint_isc, VirtioCcwDevice),
+        VMSTATE_INT32(revision, VirtioCcwDevice),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void virtio_ccw_bus_new(VirtioBusState *bus, size_t bus_size,
                                VirtioCcwDevice *dev);
 
diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index f9e6890..caa6fc6 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -31,6 +31,11 @@ typedef struct AdapterRoutes {
     int gsi[ADAPTER_ROUTES_MAX_GSI];
 } AdapterRoutes;
 
+extern const VMStateDescription vmstate_adapter_routes;
+
+#define VMSTATE_ADAPTER_ROUTES(_f, _s) \
+    VMSTATE_STRUCT(_f, _s, 1, vmstate_adapter_routes, AdapterRoutes)
+
 #define TYPE_S390_FLIC_COMMON "s390-flic"
 #define S390_FLIC_COMMON(obj) \
     OBJECT_CHECK(S390FLICState, (obj), TYPE_S390_FLIC_COMMON)
-- 
2.10.2
