Received: from eggs.gnu.org ([2001:4830:134:3::10]:44850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVHDL-0006W9-EP
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVHDG-000103-JM
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:57:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVHDG-0000z8-A1
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:57:54 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6CCs5wS037639
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:57:53 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bncj8hm9q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:57:52 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 12 Jul 2017 13:57:50 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 12 Jul 2017 14:57:41 +0200
In-Reply-To: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499864265-144136-8-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 07/11] s390x: add flags field for registering
 I/O adapter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Fei Li <sherrylf@linux.vnet.ibm.com>

Introduce a new 'flags' field to IoAdapter to contain further
characteristics of the adapter, like whether the adapter is subject to
adapter-interruption suppression.

For the kvm case, pass this value in the 'flags' field when
registering an adapter.

Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/intc/s390_flic.c          | 2 +-
 hw/intc/s390_flic_kvm.c      | 3 ++-
 hw/s390x/css-bridge.c        | 2 +-
 hw/s390x/css.c               | 8 ++++++--
 hw/s390x/s390-pci-bus.c      | 3 ++-
 include/hw/s390x/css.h       | 8 +++++++-
 include/hw/s390x/s390_flic.h | 2 +-
 7 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 837158b..d3938b3 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -48,7 +48,7 @@ void s390_flic_init(void)
 
 static int qemu_s390_register_io_adapter(S390FLICState *fs, uint32_t id,
                                          uint8_t isc, bool swap,
-                                         bool is_maskable)
+                                         bool is_maskable, uint8_t flags)
 {
     /* nothing to do */
     return 0;
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 0bcd49f..15ff534 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -186,13 +186,14 @@ static int __get_all_irqs(KVMS390FLICState *flic,
 
 static int kvm_s390_register_io_adapter(S390FLICState *fs, uint32_t id,
                                         uint8_t isc, bool swap,
-                                        bool is_maskable)
+                                        bool is_maskable, uint8_t flags)
 {
     struct kvm_s390_io_adapter adapter = {
         .id = id,
         .isc = isc,
         .maskable = is_maskable,
         .swap = swap,
+        .flags = flags,
     };
     KVMS390FLICState *flic = KVM_S390_FLIC(fs);
     int r;
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 823747f..c4a9735 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -110,7 +110,7 @@ VirtualCssBus *virtual_css_bus_init(void)
     qbus_set_hotplug_handler(bus, dev, &error_abort);
 
     css_register_io_adapters(CSS_IO_ADAPTER_VIRTIO, true, false,
-                             &error_abort);
+                             0, &error_abort);
 
     return cbus;
  }
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index d67fffa..1fcbc84 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -225,6 +225,7 @@ typedef struct IoAdapter {
     uint32_t id;
     uint8_t type;
     uint8_t isc;
+    uint8_t flags;
 } IoAdapter;
 
 typedef struct ChannelSubSys {
@@ -392,10 +393,12 @@ uint32_t css_get_adapter_id(CssIoAdapterType type, uint8_t isc)
  *
  * @swap: an indication if byte swap is needed.
  * @maskable: an indication if the adapter is subject to the mask operation.
+ * @flags: further characteristics of the adapter.
+ *         e.g. suppressible, an indication if the adapter is subject to AIS.
  * @errp: location to store error information.
  */
 void css_register_io_adapters(CssIoAdapterType type, bool swap, bool maskable,
-                              Error **errp)
+                              uint8_t flags, Error **errp)
 {
     uint32_t id;
     int ret, isc;
@@ -413,12 +416,13 @@ void css_register_io_adapters(CssIoAdapterType type, bool swap, bool maskable,
 
     for (isc = 0; isc <= MAX_ISC; isc++) {
         id = (type << 3) | isc;
-        ret = fsc->register_io_adapter(fs, id, isc, swap, maskable);
+        ret = fsc->register_io_adapter(fs, id, isc, swap, maskable, flags);
         if (ret == 0) {
             adapter = g_new0(IoAdapter, 1);
             adapter->id = id;
             adapter->isc = isc;
             adapter->type = type;
+            adapter->flags = flags;
             channel_subsys.io_adapters[type][isc] = adapter;
         } else {
             error_setg_errno(errp, -ret, "Unexpected error %d when "
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 5651483..b9603e7 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -582,7 +582,8 @@ static int s390_pcihost_init(SysBusDevice *dev)
     QTAILQ_INIT(&s->pending_sei);
     QTAILQ_INIT(&s->zpci_devs);
 
-    css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false, &error_abort);
+    css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
+                             S390_ADAPTER_SUPPRESSIBLE, &error_abort);
 
     return 0;
 }
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index eb0e26f..e028960 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -167,7 +167,13 @@ typedef enum {
 
 uint32_t css_get_adapter_id(CssIoAdapterType type, uint8_t isc);
 void css_register_io_adapters(CssIoAdapterType type, bool swap, bool maskable,
-                              Error **errp);
+                              uint8_t flags, Error **errp);
+
+#ifndef CONFIG_KVM
+#define S390_ADAPTER_SUPPRESSIBLE 0x01
+#else
+#define S390_ADAPTER_SUPPRESSIBLE KVM_S390_ADAPTER_SUPPRESSIBLE
+#endif
 
 #ifndef CONFIG_USER_ONLY
 SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index caa6fc6..d4145ad 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -56,7 +56,7 @@ typedef struct S390FLICStateClass {
     DeviceClass parent_class;
 
     int (*register_io_adapter)(S390FLICState *fs, uint32_t id, uint8_t isc,
-                               bool swap, bool maskable);
+                               bool swap, bool maskable, uint8_t flags);
     int (*io_adapter_map)(S390FLICState *fs, uint32_t id, uint64_t map_addr,
                           bool do_map);
     int (*add_adapter_routes)(S390FLICState *fs, AdapterRoutes *routes);
-- 
2.7.4
