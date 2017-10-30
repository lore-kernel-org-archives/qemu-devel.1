Received: from eggs.gnu.org ([2001:4830:134:3::10]:52312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e95zM-0002Hl-Ti
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e95zJ-000701-OO
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:04:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e95zJ-0006zb-FN
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:04:05 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9U93ub0041005
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 05:03:59 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dx12906kw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 05:03:57 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 30 Oct 2017 09:03:26 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 30 Oct 2017 10:03:18 +0100
In-Reply-To: <20171030090320.93625-1-borntraeger@de.ibm.com>
References: <20171030090320.93625-1-borntraeger@de.ibm.com>
Message-Id: <20171030090320.93625-3-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 2/4] s390x/kvm: use cpu model for gscb on compat
 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Starting a guest with
   <os>
    <type arch='s390x' machine='s390-ccw-virtio-2.9'>hvm</type>
  </os>
  <cpu mode='host-model'/>

on an IBM z14 results in

"qemu-system-s390x: Some features requested in the CPU model are not
available in the configuration: gs"

This is because guarded storage is fenced for compat machines that did
not have guarded storage support. While this prevents future migration
abort (by not starting the guest at all), not being able to start a
"host-model" guest is very much unexpected.  As it turns out, even if we
would modify libvirt to not expand the cpu model to contain "gs" for
compat machines, it cannot guarantee that a migration will succeed. For
example if the kernel changes its features (or the user has nested=1 on
one host but not on the other) the migration will fail nevertheless.  So
instead of fencing "gs" for machines <= 2.9 lets allow it for all
machine types that support the CPU model. This will make "host-model"
runnable all the time, while relying on the CPU model to reject invalid
migration attempts. We also need to change the migration for guarded
storage.
Additional discussions about host-model are still pending but are out
of scope of this patch.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Cornelia Huck <Cornelia Huck <cohuck@redhat.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c         | 8 --------
 include/hw/s390x/s390-virtio-ccw.h | 3 ---
 target/s390x/kvm.c                 | 2 +-
 target/s390x/machine.c             | 2 +-
 4 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index baeafdc..6a57f94 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -432,7 +432,6 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     s390mc->ri_allowed = true;
     s390mc->cpu_model_allowed = true;
     s390mc->css_migration_enabled = true;
-    s390mc->gs_allowed = true;
     mc->init = ccw_init;
     mc->reset = s390_machine_reset;
     mc->hot_add_cpu = s390_hot_add_cpu;
@@ -513,12 +512,6 @@ bool cpu_model_allowed(void)
     return get_machine_class()->cpu_model_allowed;
 }
 
-bool gs_allowed(void)
-{
-    /* for "none" machine this results in true */
-    return get_machine_class()->gs_allowed;
-}
-
 static char *machine_get_loadparm(Object *obj, Error **errp)
 {
     S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
@@ -758,7 +751,6 @@ static void ccw_machine_2_9_class_options(MachineClass *mc)
 {
     S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
 
-    s390mc->gs_allowed = false;
     ccw_machine_2_10_class_options(mc);
     SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_9);
     s390mc->css_migration_enabled = false;
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index a9a90c2..ac896e3 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -40,15 +40,12 @@ typedef struct S390CcwMachineClass {
     bool ri_allowed;
     bool cpu_model_allowed;
     bool css_migration_enabled;
-    bool gs_allowed;
 } S390CcwMachineClass;
 
 /* runtime-instrumentation allowed by the machine */
 bool ri_allowed(void);
 /* cpu model allowed by the machine */
 bool cpu_model_allowed(void);
-/* guarded-storage allowed by the machine */
-bool gs_allowed(void);
 
 /**
  * Returns true if (vmstate based) migration of the channel subsystem
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 88f27d7..b03f583 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -306,7 +306,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
             cap_ri = 1;
         }
     }
-    if (gs_allowed()) {
+    if (cpu_model_allowed()) {
         if (kvm_vm_enable_cap(s, KVM_CAP_S390_GS, 0) == 0) {
             cap_gs = 1;
         }
diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index e1b7015..b78f326 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -180,7 +180,7 @@ const VMStateDescription vmstate_exval = {
 
 static bool gscb_needed(void *opaque)
 {
-    return kvm_s390_get_gs();
+    return s390_has_feat(S390_FEAT_GUARDED_STORAGE);
 }
 
 const VMStateDescription vmstate_gscb = {
-- 
2.9.4
