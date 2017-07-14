Received: from eggs.gnu.org ([2001:4830:134:3::10]:56022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyON-0007ld-5P
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyOK-0003eW-0a
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVyOJ-0003cQ-ON
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:11 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6EAwxnD098513
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:04:10 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpsnc7625-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:04:10 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 12:04:07 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 12:40:36 +0200
In-Reply-To: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500028867-134709-10-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 09/40] s390x/flic: introduce inject_airq callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>

Let's introduce a specialized way to inject adapter interrupts that,
unlike the common interrupt injection method, allows to take the
characteristics of the adapter into account.

For adapters subject to AIS facility:
- for non-kvm case, we handle the suppression for a given ISC in QEMU.
- for kvm case, we pass adapter id to kvm to do airq injection.

Add add tracepoint for suppressed airq and suppressing airq.

Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/intc/s390_flic.c          | 27 +++++++++++++++++++++++++++
 hw/intc/s390_flic_kvm.c      | 18 ++++++++++++++++++
 hw/intc/trace-events         |  4 ++++
 include/hw/s390x/s390_flic.h |  2 ++
 4 files changed, 51 insertions(+)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index ce7f355..efcb1dd 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -13,8 +13,11 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "hw/sysbus.h"
+#include "hw/s390x/ioinst.h"
 #include "hw/s390x/s390_flic.h"
+#include "hw/s390x/css.h"
 #include "trace.h"
+#include "cpu.h"
 #include "hw/qdev.h"
 #include "qapi/error.h"
 #include "hw/s390x/s390-virtio-ccw.h"
@@ -100,6 +103,29 @@ static int qemu_s390_modify_ais_mode(S390FLICState *fs, uint8_t isc,
     return 0;
 }
 
+static int qemu_s390_inject_airq(S390FLICState *fs, uint8_t type,
+                                 uint8_t isc, uint8_t flags)
+{
+    QEMUS390FLICState *flic = QEMU_S390_FLIC(fs);
+    bool flag = flags & S390_ADAPTER_SUPPRESSIBLE;
+    uint32_t io_int_word = (isc << 27) | IO_INT_WORD_AI;
+
+    if (flag && (flic->nimm & AIS_MODE_MASK(isc))) {
+        trace_qemu_s390_airq_suppressed(type, isc);
+        return 0;
+    }
+
+    s390_io_interrupt(0, 0, 0, io_int_word);
+
+    if (flag && (flic->simm & AIS_MODE_MASK(isc))) {
+        flic->nimm |= AIS_MODE_MASK(isc);
+        trace_qemu_s390_suppress_airq(isc, "Single-Interruption Mode",
+                                      "NO-Interruptions Mode");
+    }
+
+    return 0;
+}
+
 static void qemu_s390_flic_reset(DeviceState *dev)
 {
     QEMUS390FLICState *flic = QEMU_S390_FLIC(dev);
@@ -120,6 +146,7 @@ static void qemu_s390_flic_class_init(ObjectClass *oc, void *data)
     fsc->release_adapter_routes = qemu_s390_release_adapter_routes;
     fsc->clear_io_irq = qemu_s390_clear_io_flic;
     fsc->modify_ais_mode = qemu_s390_modify_ais_mode;
+    fsc->inject_airq = qemu_s390_inject_airq;
 }
 
 static Property s390_flic_common_properties[] = {
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 55aa35f..a587ace 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -170,6 +170,23 @@ static int kvm_s390_modify_ais_mode(S390FLICState *fs, uint8_t isc,
     return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno : 0;
 }
 
+static int kvm_s390_inject_airq(S390FLICState *fs, uint8_t type,
+                                uint8_t isc, uint8_t flags)
+{
+    KVMS390FLICState *flic = KVM_S390_FLIC(fs);
+    uint32_t id = css_get_adapter_id(type, isc);
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_FLIC_AIRQ_INJECT,
+        .attr = id,
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
@@ -515,6 +532,7 @@ static void kvm_s390_flic_class_init(ObjectClass *oc, void *data)
     fsc->release_adapter_routes = kvm_s390_release_adapter_routes;
     fsc->clear_io_irq = kvm_s390_clear_io_flic;
     fsc->modify_ais_mode = kvm_s390_modify_ais_mode;
+    fsc->inject_airq = kvm_s390_inject_airq;
 }
 
 static const TypeInfo kvm_s390_flic_info = {
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 729c128..c586714 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -73,6 +73,10 @@ flic_create_device(int err) "flic: create device failed %d"
 flic_no_device_api(int err) "flic: no Device Contral API support %d"
 flic_reset_failed(int err) "flic: reset failed %d"
 
+# hw/intc/s390_flic.c
+qemu_s390_airq_suppressed(uint8_t type, uint8_t isc) "flic: adapter I/O interrupt suppressed (type %x isc %x)"
+qemu_s390_suppress_airq(uint8_t isc, const char *from, const char *to) "flic: for isc %x, suppress airq by modifying ais mode from %s to %s"
+
 # hw/intc/aspeed_vic.c
 aspeed_vic_set_irq(int irq, int level) "Enabling IRQ %d: %d"
 aspeed_vic_update_fiq(int flags) "Raising FIQ: %d"
diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index f500184..2f173d9 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -64,6 +64,8 @@ typedef struct S390FLICStateClass {
     int (*clear_io_irq)(S390FLICState *fs, uint16_t subchannel_id,
                         uint16_t subchannel_nr);
     int (*modify_ais_mode)(S390FLICState *fs, uint8_t isc, uint16_t mode);
+    int (*inject_airq)(S390FLICState *fs, uint8_t type, uint8_t isc,
+                       uint8_t flags);
 } S390FLICStateClass;
 
 #define TYPE_KVM_S390_FLIC "s390-flic-kvm"
-- 
2.7.4
