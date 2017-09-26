Received: from eggs.gnu.org ([2001:4830:134:3::10]:48990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwq2T-0005pu-3M
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwq2P-0007WD-Sb
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:36:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dwq2P-0007Va-Ik
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:36:37 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8QDZkUr139470
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 09:36:33 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d7mpaxeds-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 09:36:32 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 26 Sep 2017 14:36:29 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 26 Sep 2017 15:36:23 +0200
In-Reply-To: <20170926133624.155394-1-borntraeger@de.ibm.com>
References: <20170926133624.155394-1-borntraeger@de.ibm.com>
Message-Id: <20170926133624.155394-2-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/2] s390x/ais: enable ais when migration is
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Instead of unconditionally enabling the KVM AIS capability
in the kvm arch init function, do this in the flic realize function
when we know if migration is available. This requires to initialize
flic before the CPUs.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/intc/s390_flic.c          |  8 ++------
 hw/intc/s390_flic_kvm.c      | 16 +++++++++++-----
 hw/s390x/css.c               |  4 ++--
 hw/s390x/s390-virtio-ccw.c   | 10 +++++++---
 include/hw/s390x/s390_flic.h |  1 -
 target/s390x/kvm.c           | 10 ++--------
 6 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 6eaf178..9858f0e 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -1,7 +1,7 @@
 /*
  * QEMU S390x floating interrupt controller (flic)
  *
- * Copyright 2014 IBM Corp.
+ * Copyright IBM Corp. 2014, 2017
  * Author(s): Jens Freimann <jfrei@linux.vnet.ibm.com>
  *            Cornelia Huck <cornelia.huck@de.ibm.com>
  *
@@ -136,9 +136,7 @@ static void qemu_s390_flic_reset(DeviceState *dev)
 
 bool ais_needed(void *opaque)
 {
-    S390FLICState *s = opaque;
-
-    return s->ais_supported;
+    return s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESSION);
 }
 
 static const VMStateDescription qemu_s390_flic_vmstate = {
@@ -185,8 +183,6 @@ static void s390_flic_common_realize(DeviceState *dev, Error **errp)
                    " (%d > %d)", max_batch, ADAPTER_ROUTES_MAX_GSI);
         return;
     }
-
-    fs->ais_supported = s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESSION);
 }
 
 static void s390_flic_class_init(ObjectClass *oc, void *data)
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 7ead17a..5c9d215 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -1,7 +1,7 @@
 /*
  * QEMU S390x KVM floating interrupt controller (flic)
  *
- * Copyright 2014 IBM Corp.
+ * Copyright IBM Corp. 2014, 2017
  * Author(s): Jens Freimann <jfrei@linux.vnet.ibm.com>
  *            Cornelia Huck <cornelia.huck@de.ibm.com>
  *
@@ -164,7 +164,7 @@ static int kvm_s390_modify_ais_mode(S390FLICState *fs, uint8_t isc,
         .addr = (uint64_t)&req,
     };
 
-    if (!fs->ais_supported) {
+    if (!s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESSION)) {
         return -ENOSYS;
     }
 
@@ -181,7 +181,7 @@ static int kvm_s390_inject_airq(S390FLICState *fs, uint8_t type,
         .attr = id,
     };
 
-    if (!fs->ais_supported) {
+    if (!s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESSION)) {
         return -ENOSYS;
     }
 
@@ -459,7 +459,7 @@ static int kvm_flic_ais_post_load(void *opaque, int version_id)
      * migration from a host that has AIS to a host that has no AIS.
      * In that case the target system will reject the migration here.
      */
-    if (!ais_needed(flic)) {
+    if (!s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESSION)) {
         return -ENOSYS;
     }
 
@@ -557,6 +557,12 @@ static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
     test_attr.group = KVM_DEV_FLIC_CLEAR_IO_IRQ;
     flic_state->clear_io_supported = !ioctl(flic_state->fd,
                                             KVM_HAS_DEVICE_ATTR, test_attr);
+    /* try enable the AIS facility */
+    test_attr.group = KVM_DEV_FLIC_AISM_ALL;
+    if (!ioctl(flic_state->fd, KVM_HAS_DEVICE_ATTR, test_attr)) {
+            kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_AIS, 0);
+    }
+
     return;
 fail:
     error_propagate(errp, errp_local);
@@ -578,7 +584,7 @@ static void kvm_s390_flic_reset(DeviceState *dev)
 
     flic_disable_wait_pfault(flic);
 
-    if (fs->ais_supported) {
+    if (s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESSION)) {
         for (isc = 0; isc <= MAX_ISC; isc++) {
             rc = kvm_s390_modify_ais_mode(fs, isc, SIC_IRQ_MODE_ALL);
             if (rc) {
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 75d4f30..1d4bb73 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1,7 +1,7 @@
 /*
  * Channel subsystem base support.
  *
- * Copyright 2012 IBM Corp.
+ * Copyright IBM Corp. 2012, 2017
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or (at
@@ -672,7 +672,7 @@ void css_adapter_interrupt(CssIoAdapterType type, uint8_t isc)
     }
 
     trace_css_adapter_interrupt(isc);
-    if (fs->ais_supported) {
+    if (s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESSION)) {
         if (fsc->inject_airq(fs, type, isc, adapter->flags)) {
             error_report("Failed to inject airq with AIS supported");
             exit(1);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index fafbc6d..98c82c2 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1,7 +1,7 @@
 /*
  * virtio ccw machine
  *
- * Copyright 2012 IBM Corp.
+ * Copyright IBM Corp. 2012, 2017
  * Copyright (c) 2009 Alexander Graf <agraf@suse.de>
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
  *
@@ -279,11 +279,15 @@ static void ccw_init(MachineState *machine)
     s390_sclp_init();
     s390_memory_init(machine->ram_size);
 
+    /*
+     * This might also enable some KVM features like AIS, so it must
+     * be called before the CPU model
+     */
+    s390_flic_init();
+
     /* init CPUs (incl. CPU model) early so s390_has_feature() works */
     s390_init_cpus(machine);
 
-    s390_flic_init();
-
     /* get a BUS */
     css_bus = virtual_css_bus_init();
     s390_init_ipl_dev(machine->kernel_filename, machine->kernel_cmdline,
diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index 7aab6ef..75fd83c 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -44,7 +44,6 @@ typedef struct S390FLICState {
     SysBusDevice parent_obj;
     /* to limit AdapterRoutes.num_routes for compat */
     uint32_t adapter_routes_max_batch;
-    bool ais_supported;
 } S390FLICState;
 
 #define S390_FLIC_COMMON_CLASS(klass) \
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index ebb75ca..9ee2ada 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2,7 +2,7 @@
  * QEMU S390x KVM implementation
  *
  * Copyright (c) 2009 Alexander Graf <agraf@suse.de>
- * Copyright IBM Corp. 2012
+ * Copyright IBM Corp. 2012, 2017
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -311,13 +311,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
-    /*
-     * The migration interface for ais was introduced with kernel 4.13
-     * but the capability itself had been active since 4.12. As migration
-     * support is considered necessary let's disable ais in the 2.10
-     * machine.
-     */
-    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
+    /* The AIS enablement happens in the flic realize */
 
     qemu_mutex_init(&qemu_sigp_mutex);
 
-- 
2.9.4
