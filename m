Received: from eggs.gnu.org ([2001:4830:134:3::10]:43917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dx6eE-0001Gg-7u
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dx6eB-0007cp-2U
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:20:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dx6eA-0007cO-PO
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:20:42 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8R7KYvB140994
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 03:20:38 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d806h3acp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 03:20:37 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 27 Sep 2017 08:20:35 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 27 Sep 2017 09:20:30 +0200
In-Reply-To: <20170927072030.35737-1-borntraeger@de.ibm.com>
References: <20170927072030.35737-1-borntraeger@de.ibm.com>
Message-Id: <20170927072030.35737-4-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH v3 3/3] s390x/ais: disable ais for compat
 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Michael Roth <mdroth@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

With newer kernels that do support the ais feature (4.13) a qemu 2.11
will not only enable the ais feature for the 2.11 machine, but also for
a <=2.10 compat machine. As this feature is not available in QEMU <=2.9
(and QEMU 2.10.1), this guest will fail to migrate back to an older qemu
like 2.9 with:

error while loading state for instance 0x0 of device 's390-flic'

making the whole compat machine dis-functional.  As a permanent fix, we
need to fence the ais feature for machines <= 2.10 similar to what we do
for guarded storage, runtime instrumentation and css migration.

Due to ais being enabled on 2.10.0 (fixed in 2.10.1) this will prevent
migration of ais-enabled guests from 2.10.0 with

qemu-system-s390x: Failed to load s390-flic/ais:tmp
qemu-system-s390x: error while loading state for instance 0x0 of device 's390-flic'
qemu-system-s390x: load of migration failed: Function not implemented

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/intc/s390_flic_kvm.c            |  4 +++-
 hw/s390x/s390-virtio-ccw.c         | 10 ++++++++++
 include/hw/s390x/s390-virtio-ccw.h |  3 +++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 0a370a9..fddda2b 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -22,6 +22,7 @@
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/adapter.h"
 #include "hw/s390x/css.h"
+#include "hw/s390x/s390-virtio-ccw.h"
 #include "trace.h"
 
 #define FLIC_SAVE_INITIAL_SIZE getpagesize()
@@ -559,7 +560,8 @@ static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
                                             KVM_HAS_DEVICE_ATTR, test_attr);
     /* try enable the AIS facility */
     test_attr.group = KVM_DEV_FLIC_AISM_ALL;
-    if (!ioctl(flic_state->fd, KVM_HAS_DEVICE_ATTR, test_attr)) {
+    if (ais_allowed() &&
+        !ioctl(flic_state->fd, KVM_HAS_DEVICE_ATTR, test_attr)) {
         kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_AIS, 0);
     }
 
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 98c82c2..41b770a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -435,6 +435,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     s390mc->cpu_model_allowed = true;
     s390mc->css_migration_enabled = true;
     s390mc->gs_allowed = true;
+    s390mc->ais_allowed = true;
     mc->init = ccw_init;
     mc->reset = s390_machine_reset;
     mc->hot_add_cpu = s390_hot_add_cpu;
@@ -519,6 +520,11 @@ bool gs_allowed(void)
     return get_machine_class()->gs_allowed;
 }
 
+bool ais_allowed(void)
+{
+    return get_machine_class()->ais_allowed;
+}
+
 static char *machine_get_loadparm(Object *obj, Error **errp)
 {
     S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
@@ -742,6 +748,10 @@ static void ccw_machine_2_10_instance_options(MachineState *machine)
 
 static void ccw_machine_2_10_class_options(MachineClass *mc)
 {
+    S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
+
+    s390mc->ais_allowed = false;
+
     ccw_machine_2_11_class_options(mc);
     SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_10);
 }
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index a9a90c2..d25a98f 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -41,6 +41,7 @@ typedef struct S390CcwMachineClass {
     bool cpu_model_allowed;
     bool css_migration_enabled;
     bool gs_allowed;
+    bool ais_allowed;
 } S390CcwMachineClass;
 
 /* runtime-instrumentation allowed by the machine */
@@ -49,6 +50,8 @@ bool ri_allowed(void);
 bool cpu_model_allowed(void);
 /* guarded-storage allowed by the machine */
 bool gs_allowed(void);
+/* ais allowed by the machine */
+bool ais_allowed(void);
 
 /**
  * Returns true if (vmstate based) migration of the channel subsystem
-- 
2.9.4
