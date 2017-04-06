Received: from eggs.gnu.org ([2001:4830:134:3::10]:43351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cw5Pa-0004Yx-Pp
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cw5PX-0001eT-Ke
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:17:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cw5PX-0001e8-Ae
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:17:07 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v36BE13f046107
	for <qemu-devel@nongnu.org>; Thu, 6 Apr 2017 07:17:06 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29nfmgsbrt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 07:17:06 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 6 Apr 2017 12:17:03 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Thu,  6 Apr 2017 13:16:46 +0200
In-Reply-To: <20170406111646.12624-1-cornelia.huck@de.ibm.com>
References: <20170406111646.12624-1-cornelia.huck@de.ibm.com>
Message-Id: <20170406111646.12624-11-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH for-2.10 10/10] s390x: register I/O adapters
 per ISC during init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, Fei Li <sherrylf@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Fei Li <sherrylf@linux.vnet.ibm.com>

The I/O adapters should exist as soon as the bus/infrastructure
exists, and not only when the guest is actually trying to do something
with them. While the lazy allocation was not wrong, allocating at init
time is cleaner, both for the architecture and the code. Let's adjust
this by having each device type (currently for PCI and virtio-ccw)
register the adapters for each ISC (as now we don't know which ISC the
guest will use) as soon as it initializes.

Use a two-dimensional array io_adapters[type][isc] to store adapters
in ChannelSubSys, so that we can conveniently get the adapter id by
the helper function css_get_adapter_id(type, isc).

Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/css-bridge.c    |  3 ++
 hw/s390x/css.c           | 85 ++++++++++++++++++++++++++++++------------------
 hw/s390x/s390-pci-bus.c  |  3 ++
 hw/s390x/s390-pci-inst.c | 10 +++---
 hw/s390x/virtio-ccw.c    | 13 ++++----
 include/hw/s390x/css.h   |  7 ++--
 6 files changed, 74 insertions(+), 47 deletions(-)

diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 9a7f7ee60c..b54ac01d37 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -107,6 +107,9 @@ VirtualCssBus *virtual_css_bus_init(void)
     /* Enable hotplugging */
     qbus_set_hotplug_handler(bus, dev, &error_abort);
 
+    css_register_io_adapters(CSS_IO_ADAPTER_VIRTIO, true, false,
+                             &error_abort);
+
     return cbus;
  }
 
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 1b242c1fb7..c03bb20bc9 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -47,7 +47,6 @@ typedef struct IoAdapter {
     uint32_t id;
     uint8_t type;
     uint8_t isc;
-    QTAILQ_ENTRY(IoAdapter) sibling;
 } IoAdapter;
 
 typedef struct ChannelSubSys {
@@ -61,7 +60,7 @@ typedef struct ChannelSubSys {
     uint64_t chnmon_area;
     CssImage *css[MAX_CSSID + 1];
     uint8_t default_cssid;
-    QTAILQ_HEAD(, IoAdapter) io_adapters;
+    IoAdapter *io_adapters[CSS_IO_ADAPTER_TYPE_NUMS][MAX_ISC + 1];
     QTAILQ_HEAD(, IndAddr) indicator_addresses;
 } ChannelSubSys;
 
@@ -72,7 +71,6 @@ static ChannelSubSys channel_subsys = {
     .do_crw_mchk = true,
     .crws_lost = false,
     .chnmon_active = false,
-    .io_adapters = QTAILQ_HEAD_INITIALIZER(channel_subsys.io_adapters),
     .indicator_addresses =
         QTAILQ_HEAD_INITIALIZER(channel_subsys.indicator_addresses),
 };
@@ -155,44 +153,67 @@ int css_create_css_image(uint8_t cssid, bool default_image)
     return 0;
 }
 
-int css_register_io_adapter(CssIoAdapterType type, uint8_t isc, bool swap,
-                            bool maskable, uint32_t *id)
+uint32_t css_get_adapter_id(CssIoAdapterType type, uint8_t isc)
 {
+    if (type >= CSS_IO_ADAPTER_TYPE_NUMS || isc > MAX_ISC ||
+        !channel_subsys.io_adapters[type][isc]) {
+        return -1;
+    }
+
+    return channel_subsys.io_adapters[type][isc]->id;
+}
+
+/**
+ * css_register_io_adapters: Register I/O adapters per ISC during init
+ *
+ * @swap: an indication if byte swap is needed.
+ * @maskable: an indication if the adapter is subject to the mask operation.
+ * @errp: location to store error information.
+ */
+void css_register_io_adapters(CssIoAdapterType type, bool swap, bool maskable,
+                              Error **errp)
+{
+    uint32_t id;
+    int ret, isc;
     IoAdapter *adapter;
-    bool found = false;
-    int ret;
     S390FLICState *fs = s390_get_flic();
     S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
 
-    *id = 0;
-    QTAILQ_FOREACH(adapter, &channel_subsys.io_adapters, sibling) {
-        if ((adapter->type == type) && (adapter->isc == isc)) {
-            *id = adapter->id;
-            found = true;
-            ret = 0;
+    /*
+     * Disallow multiple registrations for the same device type.
+     * Report an error if registering for an already registered type.
+     */
+    if (channel_subsys.io_adapters[type][0]) {
+        error_setg(errp, "Adapters for type %d already registered", type);
+    }
+
+    for (isc = 0; isc <= MAX_ISC; isc++) {
+        id = (type << 3) | isc;
+        ret = fsc->register_io_adapter(fs, id, isc, swap, maskable);
+        if (ret == 0) {
+            adapter = g_new0(IoAdapter, 1);
+            adapter->id = id;
+            adapter->isc = isc;
+            adapter->type = type;
+            channel_subsys.io_adapters[type][isc] = adapter;
+        } else {
+            error_setg_errno(errp, -ret, "Unexpected error %d when "
+                             "registering adapter %d", ret, id);
             break;
         }
-        if (adapter->id >= *id) {
-            *id = adapter->id + 1;
-        }
-    }
-    if (found) {
-        goto out;
     }
-    adapter = g_new0(IoAdapter, 1);
-    ret = fsc->register_io_adapter(fs, *id, isc, swap, maskable);
-    if (ret == 0) {
-        adapter->id = *id;
-        adapter->isc = isc;
-        adapter->type = type;
-        QTAILQ_INSERT_TAIL(&channel_subsys.io_adapters, adapter, sibling);
-    } else {
-        g_free(adapter);
-        fprintf(stderr, "Unexpected error %d when registering adapter %d\n",
-                ret, *id);
+
+    /*
+     * No need to free registered adapters in kvm: kvm will clean up
+     * when the machine goes away.
+     */
+    if (ret) {
+        for (isc--; isc >= 0; isc--) {
+            g_free(channel_subsys.io_adapters[type][isc]);
+            channel_subsys.io_adapters[type][isc] = NULL;
+        }
     }
-out:
-    return ret;
+
 }
 
 static void css_clear_io_interrupt(uint16_t subchannel_id,
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 0f62363434..8b456fad6c 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -583,6 +583,9 @@ static int s390_pcihost_init(SysBusDevice *dev)
     s->bus_no = 0;
     QTAILQ_INIT(&s->pending_sei);
     QTAILQ_INIT(&s->zpci_devs);
+
+    css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false, &error_abort);
+
     return 0;
 }
 
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 214fde7ac3..8bd5a564db 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -735,12 +735,10 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
 static int reg_irqs(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib)
 {
     int ret, len;
+    uint8_t isc = FIB_DATA_ISC(ldl_p(&fib.data));
 
-    ret = css_register_io_adapter(CSS_IO_ADAPTER_PCI,
-                                  FIB_DATA_ISC(ldl_p(&fib.data)), true, false,
-                                  &pbdev->routes.adapter.adapter_id);
-    assert(ret == 0);
-
+    pbdev->routes.adapter.adapter_id = css_get_adapter_id(
+                                       CSS_IO_ADAPTER_PCI, isc);
     pbdev->summary_ind = get_indicator(ldq_p(&fib.aisb), sizeof(uint64_t));
     len = BITS_TO_LONGS(FIB_DATA_NOI(ldl_p(&fib.data))) * sizeof(unsigned long);
     pbdev->indicator = get_indicator(ldq_p(&fib.aibv), len);
@@ -759,7 +757,7 @@ static int reg_irqs(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib)
     pbdev->routes.adapter.summary_offset = FIB_DATA_AISBO(ldl_p(&fib.data));
     pbdev->routes.adapter.ind_addr = ldq_p(&fib.aibv);
     pbdev->routes.adapter.ind_offset = FIB_DATA_AIBVO(ldl_p(&fib.data));
-    pbdev->isc = FIB_DATA_ISC(ldl_p(&fib.data));
+    pbdev->isc = isc;
     pbdev->noi = FIB_DATA_NOI(ldl_p(&fib.data));
     pbdev->sum = FIB_DATA_SUM(ldl_p(&fib.data));
 
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index a81e27f7fd..823c90ad6e 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -616,10 +616,9 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                 dev->routes.adapter.ind_offset = ind_bit;
                 dev->routes.adapter.summary_offset = 7;
                 cpu_physical_memory_unmap(thinint, hw_len, 0, hw_len);
-                ret = css_register_io_adapter(CSS_IO_ADAPTER_VIRTIO,
-                                              dev->thinint_isc, true, false,
-                                              &dev->routes.adapter.adapter_id);
-                assert(ret == 0);
+                dev->routes.adapter.adapter_id = css_get_adapter_id(
+                                                 CSS_IO_ADAPTER_VIRTIO,
+                                                 dev->thinint_isc);
                 sch->thinint_active = ((dev->indicators != NULL) &&
                                        (dev->summary_indicator != NULL));
                 sch->curr_status.scsw.count = ccw.count - len;
@@ -1309,9 +1308,9 @@ static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
     dev->thinint_isc = qemu_get_byte(f);
     dev->revision = qemu_get_be32(f);
     if (s->thinint_active) {
-        return css_register_io_adapter(CSS_IO_ADAPTER_VIRTIO,
-                                       dev->thinint_isc, true, false,
-                                       &dev->routes.adapter.adapter_id);
+        dev->routes.adapter.adapter_id = css_get_adapter_id(
+                                         CSS_IO_ADAPTER_VIRTIO,
+                                         dev->thinint_isc);
     }
 
     return 0;
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index cdc73fe0aa..f1f0d7f07a 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -23,6 +23,8 @@
 #define MAX_CSSID 255
 #define MAX_CHPID 255
 
+#define MAX_ISC 7
+
 #define MAX_CIWS 62
 
 #define VIRTUAL_CSSID 0xfe
@@ -130,8 +132,9 @@ typedef enum {
     CSS_IO_ADAPTER_TYPE_NUMS,
 } CssIoAdapterType;
 
-int css_register_io_adapter(CssIoAdapterType type, uint8_t isc, bool swap,
-                            bool maskable, uint32_t *id);
+uint32_t css_get_adapter_id(CssIoAdapterType type, uint8_t isc);
+void css_register_io_adapters(CssIoAdapterType type, bool swap, bool maskable,
+                              Error **errp);
 
 #ifndef CONFIG_USER_ONLY
 SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
-- 
2.11.0
