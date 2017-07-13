Received: from eggs.gnu.org ([2001:4830:134:3::10]:35530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVbY0-00056U-V0
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVbXx-0002Gh-PM
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:40:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59764
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVbXx-0002GY-Ja
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:40:37 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6DAdSUe133187
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 06:40:36 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bp1sqkt9x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 06:40:35 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 13 Jul 2017 11:40:34 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 13 Jul 2017 12:40:28 +0200
In-Reply-To: <1499942429-55449-1-git-send-email-borntraeger@de.ibm.com>
References: <1499942429-55449-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499942429-55449-3-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH/s390-next 2/3] s390x/cpumodel: add zpci,
 aen and ais facilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>

zPCI instructions and facilities are available since IBM zEnterprise
EC12. To support z/PCI in QEMU we enable zpci, aen and ais facilities
starting with zEC12 GA1. And we always set zpci and aen bits in max cpu
model. Later they might be switched off due to applied real cpu model.
For ais bit, we only provide it in the full cpu model beginning with
zEC12 and defer its enablement in the default cpu model to a later point
in time. At the same time, disable them for 2.9 and older machines.

Because of introducing AIS facility, we could check if it's enabled to
initialize flic->ais_supported with the real value.

Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/intc/s390_flic.c             | 3 ++-
 hw/intc/s390_flic_kvm.c         | 3 ---
 hw/s390x/s390-virtio-ccw.c      | 3 +++
 target/s390x/cpu_features.c     | 3 +++
 target/s390x/cpu_features_def.h | 3 +++
 target/s390x/gen-features.c     | 5 +++++
 target/s390x/kvm.c              | 7 +++++++
 7 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index ff6e4ec..6e7c610 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -163,9 +163,10 @@ static void s390_flic_common_realize(DeviceState *dev, Error **errp)
     if (max_batch > ADAPTER_ROUTES_MAX_GSI) {
         error_setg(errp, "flic property adapter_routes_max_batch too big"
                    " (%d > %d)", max_batch, ADAPTER_ROUTES_MAX_GSI);
+        return;
     }
 
-    fs->ais_supported = true;
+    fs->ais_supported = s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESSION);
 }
 
 static void s390_flic_class_init(ObjectClass *oc, void *data)
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index a587ace..d93503f 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -444,7 +444,6 @@ typedef struct KVMS390FLICStateClass {
 
 static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
 {
-    S390FLICState *fs = S390_FLIC_COMMON(dev);
     KVMS390FLICState *flic_state = KVM_S390_FLIC(dev);
     struct kvm_create_device cd = {0};
     struct kvm_device_attr test_attr = {0};
@@ -476,8 +475,6 @@ static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
     test_attr.group = KVM_DEV_FLIC_CLEAR_IO_IRQ;
     flic_state->clear_io_supported = !ioctl(flic_state->fd,
                                             KVM_HAS_DEVICE_ATTR, test_attr);
-
-    fs->ais_supported = false;
     return;
 fail:
     error_propagate(errp, errp_local);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 23e9658..e484aed 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -503,6 +503,9 @@ DEFINE_CCW_MACHINE(2_10, "2.10", true);
 static void ccw_machine_2_9_instance_options(MachineState *machine)
 {
     ccw_machine_2_10_instance_options(machine);
+    s390_cpudef_featoff_greater(12, 1, S390_FEAT_ZPCI);
+    s390_cpudef_featoff_greater(12, 1, S390_FEAT_ADAPTER_INT_SUPPRESSION);
+    s390_cpudef_featoff_greater(12, 1, S390_FEAT_ADAPTER_EVENT_NOTIFICATION);
 }
 
 static void ccw_machine_2_9_class_options(MachineClass *mc)
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 0436dc2..8ab5cd7 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -74,6 +74,9 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("stfle53", S390_FEAT_TYPE_STFL, 53, "Various facilities introduced with z13"),
     FEAT_INIT("msa5-base", S390_FEAT_TYPE_STFL, 57, "Message-security-assist-extension-5 facility (excluding subfunctions)"),
     FEAT_INIT("ri", S390_FEAT_TYPE_STFL, 64, "CPU runtime-instrumentation facility"),
+    FEAT_INIT("zpci", S390_FEAT_TYPE_STFL, 69, "z/PCI facility"),
+    FEAT_INIT("aen", S390_FEAT_TYPE_STFL, 71, "General-purpose-adapter-event-notification facility"),
+    FEAT_INIT("ais", S390_FEAT_TYPE_STFL, 72, "General-purpose-adapter-interruption-suppression facility"),
     FEAT_INIT("te", S390_FEAT_TYPE_STFL, 73, "Transactional-execution facility"),
     FEAT_INIT("sthyi", S390_FEAT_TYPE_STFL, 74, "Store-hypervisor-information facility"),
     FEAT_INIT("aefsi", S390_FEAT_TYPE_STFL, 75, "Access-exception-fetch/store-indication facility"),
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index f5bb7ed..c939a00 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -65,6 +65,9 @@ typedef enum {
     S390_FEAT_STFLE_53,
     S390_FEAT_MSA_EXT_5,
     S390_FEAT_RUNTIME_INSTRUMENTATION,
+    S390_FEAT_ZPCI,
+    S390_FEAT_ADAPTER_EVENT_NOTIFICATION,
+    S390_FEAT_ADAPTER_INT_SUPPRESSION,
     S390_FEAT_TRANSACTIONAL_EXE,
     S390_FEAT_STORE_HYPERVISOR_INFO,
     S390_FEAT_ACCESS_EXCEPTION_FS_INDICATION,
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 8ca2b47..622ee24 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -389,6 +389,9 @@ static uint16_t full_GEN12_GA1[] = {
     S390_FEAT_CONSTRAINT_TRANSACTIONAL_EXE,
     S390_FEAT_TRANSACTIONAL_EXE,
     S390_FEAT_RUNTIME_INSTRUMENTATION,
+    S390_FEAT_ZPCI,
+    S390_FEAT_ADAPTER_EVENT_NOTIFICATION,
+    S390_FEAT_ADAPTER_INT_SUPPRESSION,
     S390_FEAT_EDAT_2,
 };
 
@@ -446,6 +449,8 @@ static uint16_t default_GEN12_GA1[] = {
     S390_FEAT_CONSTRAINT_TRANSACTIONAL_EXE,
     S390_FEAT_TRANSACTIONAL_EXE,
     S390_FEAT_RUNTIME_INSTRUMENTATION,
+    S390_FEAT_ZPCI,
+    S390_FEAT_ADAPTER_EVENT_NOTIFICATION,
     S390_FEAT_EDAT_2,
 };
 
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 78ebe83..1901153 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -302,6 +302,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
+    /* Try to enable AIS facility */
+    kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
+
     qemu_mutex_init(&qemu_sigp_mutex);
 
     return 0;
@@ -2635,6 +2638,10 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         set_bit(S390_FEAT_CMM, model->features);
     }
 
+    /* set zpci and aen facilities */
+    set_bit(S390_FEAT_ZPCI, model->features);
+    set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
+
     if (s390_known_cpu_type(cpu_type)) {
         /* we want the exact model, even if some features are missing */
         model->def = s390_find_cpu_def(cpu_type, ibc_gen(unblocked_ibc),
-- 
2.7.4
