Received: from eggs.gnu.org ([2001:4830:134:3::10]:44849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVHDL-0006W7-E2
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVHDH-00010K-1K
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:57:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVHDG-0000zM-Mu
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:57:54 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6CCsLCa005518
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:57:53 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bncjb9uwr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:57:53 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 12 Jul 2017 13:57:50 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 12 Jul 2017 14:57:42 +0200
In-Reply-To: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499864265-144136-9-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 08/11] s390x/flic: introduce modify_ais_mode
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Fei Li <sherrylf@linux.vnet.ibm.com>

In order to emulate the adapter interruption suppression (AIS)
facility properly, the guest needs to be able to modify the AIS mask.
Interrupt suppression will be handled via the flic (for kvm, via a
recently introduced kernel backend; for !kvm, in the flic code), so
let's introduce a method to change the mode via the flic interface.

Co-authored-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/intc/s390_flic.c          | 37 ++++++++++++++++++++++++++++++++++++-
 hw/intc/s390_flic_kvm.c      | 36 ++++++++++++++++++++++++++++++++++++
 include/hw/s390x/s390_flic.h |  9 ++++++++-
 3 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index d3938b3..ce7f355 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -79,15 +79,47 @@ static int qemu_s390_clear_io_flic(S390FLICState *fs, uint16_t subchannel_id,
     return -ENOSYS;
 }
 
+static int qemu_s390_modify_ais_mode(S390FLICState *fs, uint8_t isc,
+                                     uint16_t mode)
+{
+    QEMUS390FLICState *flic  = QEMU_S390_FLIC(fs);
+
+    switch (mode) {
+    case SIC_IRQ_MODE_ALL:
+        flic->simm &= ~AIS_MODE_MASK(isc);
+        flic->nimm &= ~AIS_MODE_MASK(isc);
+        break;
+    case SIC_IRQ_MODE_SINGLE:
+        flic->simm |= AIS_MODE_MASK(isc);
+        flic->nimm &= ~AIS_MODE_MASK(isc);
+        break;
+    default:
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static void qemu_s390_flic_reset(DeviceState *dev)
+{
+    QEMUS390FLICState *flic = QEMU_S390_FLIC(dev);
+
+    flic->simm = 0;
+    flic->nimm = 0;
+}
+
 static void qemu_s390_flic_class_init(ObjectClass *oc, void *data)
 {
+    DeviceClass *dc = DEVICE_CLASS(oc);
     S390FLICStateClass *fsc = S390_FLIC_COMMON_CLASS(oc);
 
+    dc->reset = qemu_s390_flic_reset;
     fsc->register_io_adapter = qemu_s390_register_io_adapter;
     fsc->io_adapter_map = qemu_s390_io_adapter_map;
     fsc->add_adapter_routes = qemu_s390_add_adapter_routes;
     fsc->release_adapter_routes = qemu_s390_release_adapter_routes;
     fsc->clear_io_irq = qemu_s390_clear_io_flic;
+    fsc->modify_ais_mode = qemu_s390_modify_ais_mode;
 }
 
 static Property s390_flic_common_properties[] = {
@@ -98,12 +130,15 @@ static Property s390_flic_common_properties[] = {
 
 static void s390_flic_common_realize(DeviceState *dev, Error **errp)
 {
-    uint32_t max_batch = S390_FLIC_COMMON(dev)->adapter_routes_max_batch;
+    S390FLICState *fs = S390_FLIC_COMMON(dev);
+    uint32_t max_batch = fs->adapter_routes_max_batch;
 
     if (max_batch > ADAPTER_ROUTES_MAX_GSI) {
         error_setg(errp, "flic property adapter_routes_max_batch too big"
                    " (%d > %d)", max_batch, ADAPTER_ROUTES_MAX_GSI);
     }
+
+    fs->ais_supported = true;
 }
 
 static void s390_flic_class_init(ObjectClass *oc, void *data)
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 15ff534..55aa35f 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -20,6 +20,7 @@
 #include "sysemu/kvm.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/adapter.h"
+#include "hw/s390x/css.h"
 #include "trace.h"
 
 #define FLIC_SAVE_INITIAL_SIZE getpagesize()
@@ -149,6 +150,26 @@ static int kvm_s390_clear_io_flic(S390FLICState *fs, uint16_t subchannel_id,
     return rc ? -errno : 0;
 }
 
+static int kvm_s390_modify_ais_mode(S390FLICState *fs, uint8_t isc,
+                                    uint16_t mode)
+{
+    KVMS390FLICState *flic = KVM_S390_FLIC(fs);
+    struct kvm_s390_ais_req req = {
+        .isc = isc,
+        .mode = mode,
+    };
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_FLIC_AISM,
+        .addr = (uint64_t)&req,
+    };
+
+    if (!fs->ais_supported) {
+        return -ENOSYS;
+    }
+
+    return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno : 0;
+}
+
 /**
  * __get_all_irqs - store all pending irqs in buffer
  * @flic: pointer to flic device state
@@ -406,6 +427,7 @@ typedef struct KVMS390FLICStateClass {
 
 static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
 {
+    S390FLICState *fs = S390_FLIC_COMMON(dev);
     KVMS390FLICState *flic_state = KVM_S390_FLIC(dev);
     struct kvm_create_device cd = {0};
     struct kvm_device_attr test_attr = {0};
@@ -438,6 +460,7 @@ static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
     flic_state->clear_io_supported = !ioctl(flic_state->fd,
                                             KVM_HAS_DEVICE_ATTR, test_attr);
 
+    fs->ais_supported = false;
     return;
 fail:
     error_propagate(errp, errp_local);
@@ -446,10 +469,12 @@ fail:
 static void kvm_s390_flic_reset(DeviceState *dev)
 {
     KVMS390FLICState *flic = KVM_S390_FLIC(dev);
+    S390FLICState *fs = S390_FLIC_COMMON(dev);
     struct kvm_device_attr attr = {
         .group = KVM_DEV_FLIC_CLEAR_IRQS,
     };
     int rc = 0;
+    uint8_t isc;
 
     if (flic->fd == -1) {
         return;
@@ -457,6 +482,16 @@ static void kvm_s390_flic_reset(DeviceState *dev)
 
     flic_disable_wait_pfault(flic);
 
+    if (fs->ais_supported) {
+        for (isc = 0; isc <= MAX_ISC; isc++) {
+            rc = kvm_s390_modify_ais_mode(fs, isc, SIC_IRQ_MODE_ALL);
+            if (rc) {
+                error_report("Failed to reset ais mode for isc %d: %s",
+                             isc, strerror(-rc));
+            }
+        }
+    }
+
     rc = ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
     if (rc) {
         trace_flic_reset_failed(errno);
@@ -479,6 +514,7 @@ static void kvm_s390_flic_class_init(ObjectClass *oc, void *data)
     fsc->add_adapter_routes = kvm_s390_add_adapter_routes;
     fsc->release_adapter_routes = kvm_s390_release_adapter_routes;
     fsc->clear_io_irq = kvm_s390_clear_io_flic;
+    fsc->modify_ais_mode = kvm_s390_modify_ais_mode;
 }
 
 static const TypeInfo kvm_s390_flic_info = {
diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index d4145ad..f500184 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -44,7 +44,7 @@ typedef struct S390FLICState {
     SysBusDevice parent_obj;
     /* to limit AdapterRoutes.num_routes for compat */
     uint32_t adapter_routes_max_batch;
-
+    bool ais_supported;
 } S390FLICState;
 
 #define S390_FLIC_COMMON_CLASS(klass) \
@@ -63,6 +63,7 @@ typedef struct S390FLICStateClass {
     void (*release_adapter_routes)(S390FLICState *fs, AdapterRoutes *routes);
     int (*clear_io_irq)(S390FLICState *fs, uint16_t subchannel_id,
                         uint16_t subchannel_nr);
+    int (*modify_ais_mode)(S390FLICState *fs, uint8_t isc, uint16_t mode);
 } S390FLICStateClass;
 
 #define TYPE_KVM_S390_FLIC "s390-flic-kvm"
@@ -73,8 +74,14 @@ typedef struct S390FLICStateClass {
 #define QEMU_S390_FLIC(obj) \
     OBJECT_CHECK(QEMUS390FLICState, (obj), TYPE_QEMU_S390_FLIC)
 
+#define SIC_IRQ_MODE_ALL 0
+#define SIC_IRQ_MODE_SINGLE 1
+#define AIS_MODE_MASK(isc) (0x80 >> isc)
+
 typedef struct QEMUS390FLICState {
     S390FLICState parent_obj;
+    uint8_t simm;
+    uint8_t nimm;
 } QEMUS390FLICState;
 
 void s390_flic_init(void);
-- 
2.7.4
