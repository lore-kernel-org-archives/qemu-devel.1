Received: from eggs.gnu.org ([2001:4830:134:3::10]:46181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1eqhQq-0001FY-53
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1eqhQo-0006hI-JN
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:44:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1eqhQo-0006gT-AH
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:44:42 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1RFhnxX084072
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 10:44:41 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gd9wbs0pw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 10:44:40 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Tue, 27 Feb 2018 10:44:39 -0500
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 10:44:19 -0500
In-Reply-To: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Message-Id: <1519746259-27710-6-git-send-email-akrowiak@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 5/5] s390x/cpumodel: Set up CPU model for AP
 device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, Tony Krowiak <akrowiak@linux.vnet.ibm.com>

A new CPU model feature and two new CPU model facilities are
introduced to support AP devices for a KVM guest.

CPU model features:

1. The KVM_S390_VM_CPU_FEAT_AP CPU model feature indicates that
   AP facilities are installed. This feature will be enabled by
   the kernel only if the AP facilities are installed on the linux
   host. This feature must be turned on from userspace to access
   AP devices from the KVM guest. The QEMU command line to turn
   this feature looks something like this:

	qemu-system-s390x ... -cpu xxx,ap=on

CPU model facilities:

1. The S390_FEAT_AP_QUERY_CONFIG_INFO feature indicates the AP Query
   Configuration Information (QCI) facility is installed. This feature
   will be enabled by the kernel only if the QCI is installed on
   the host. This facility will be set by QEMU only if the
   KVM_S390_VM_CPU_FEAT_AP CPU model feature is turned on.
   (see CPU model features above)

2. The S390_FEAT_AP_FACILITY_TEST feature indicates that the AP
   Test Facility (APFT) facility is installed. This feature will
   be enabled by the kernel only if the APFT facility is installed
   on the host. This facility will be set by QEMU for the KVM guest
   only if the KVM_S390_VM_CPU_FEAT_AP CPU model feature is turned on.
   (see CPU model features above)

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 hw/vfio/ap.c                    |    9 +++++++++
 linux-headers/asm-s390/kvm.h    |    1 +
 target/s390x/cpu_features.c     |    3 +++
 target/s390x/cpu_features_def.h |    3 +++
 target/s390x/cpu_models.c       |   12 ++++++++++++
 target/s390x/gen-features.c     |    3 +++
 target/s390x/kvm.c              |    6 ++++++
 7 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 8aa5221..b93f7d9 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -19,6 +19,7 @@
 #include "hw/s390x/ap-device.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
+#include "cpu.h"
 
 #define VFIO_AP_DEVICE_TYPE      "vfio-ap"
 #define AP_SYSFSDEV_PROP_NAME    "sysfsdev"
@@ -87,6 +88,14 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
     int ret;
 
+    if (!s390_has_feat(S390_FEAT_AP)) {
+        error_setg(&local_err, "Invalid device configuration: ");
+        error_append_hint(&local_err,
+                          "Verify AP facilities are enabled for the guest"
+                          "(ap=on)\n");
+        goto out_err;
+    }
+
     vfio_group = vfio_ap_get_group(vapdev, &local_err);
     if (!vfio_group) {
         goto out_err;
diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index 11def14..35a6d04 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -130,6 +130,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_PFMFI	11
 #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
 #define KVM_S390_VM_CPU_FEAT_KSS	13
+#define KVM_S390_VM_CPU_FEAT_AP		14
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index a5619f2..65b91bd 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -36,8 +36,10 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("srs", S390_FEAT_TYPE_STFL, 9, "Sense-running-status facility"),
     FEAT_INIT("csske", S390_FEAT_TYPE_STFL, 10, "Conditional-SSKE facility"),
     FEAT_INIT("ctop", S390_FEAT_TYPE_STFL, 11, "Configuration-topology facility"),
+    FEAT_INIT("qci", S390_FEAT_TYPE_STFL, 12, "Query AP Configuration facility"),
     FEAT_INIT("ipter", S390_FEAT_TYPE_STFL, 13, "IPTE-range facility"),
     FEAT_INIT("nonqks", S390_FEAT_TYPE_STFL, 14, "Nonquiescing key-setting facility"),
+    FEAT_INIT("apft", S390_FEAT_TYPE_STFL, 15, "Adjunct Processor Facilities Test facility"),
     FEAT_INIT("etf2", S390_FEAT_TYPE_STFL, 16, "Extended-translation facility 2"),
     FEAT_INIT("msa-base", S390_FEAT_TYPE_STFL, 17, "Message-security-assist facility (excluding subfunctions)"),
     FEAT_INIT("ldisp", S390_FEAT_TYPE_STFL, 18, "Long-displacement facility"),
@@ -125,6 +127,7 @@ static const S390FeatDef s390_features[] = {
 
     FEAT_INIT("dateh2", S390_FEAT_TYPE_MISC, 0, "DAT-enhancement facility 2"),
     FEAT_INIT("cmm", S390_FEAT_TYPE_MISC, 0, "Collaborative-memory-management facility"),
+    FEAT_INIT("ap", S390_FEAT_TYPE_MISC, 1, "AP facilities installed"),
 
     FEAT_INIT("plo-cl", S390_FEAT_TYPE_PLO, 0, "PLO Compare and load (32 bit in general registers)"),
     FEAT_INIT("plo-clg", S390_FEAT_TYPE_PLO, 1, "PLO Compare and load (64 bit in parameter list)"),
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index 7c5915c..8998b65 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -27,8 +27,10 @@ typedef enum {
     S390_FEAT_SENSE_RUNNING_STATUS,
     S390_FEAT_CONDITIONAL_SSKE,
     S390_FEAT_CONFIGURATION_TOPOLOGY,
+    S390_FEAT_AP_QUERY_CONFIG_INFO,
     S390_FEAT_IPTE_RANGE,
     S390_FEAT_NONQ_KEY_SETTING,
+    S390_FEAT_AP_FACILITIES_TEST,
     S390_FEAT_EXTENDED_TRANSLATION_2,
     S390_FEAT_MSA,
     S390_FEAT_LONG_DISPLACEMENT,
@@ -118,6 +120,7 @@ typedef enum {
     /* Misc */
     S390_FEAT_DAT_ENH_2,
     S390_FEAT_CMM,
+    S390_FEAT_AP,
 
     /* PLO */
     S390_FEAT_PLO_CL,
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 1d5f0da..35f91ea 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -770,6 +770,8 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_PRNO_TRNG_QRTCR, S390_FEAT_MSA_EXT_5 },
         { S390_FEAT_PRNO_TRNG, S390_FEAT_MSA_EXT_5 },
         { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
+        { S390_FEAT_AP_QUERY_CONFIG_INFO, S390_FEAT_AP },
+        { S390_FEAT_AP_FACILITIES_TEST, S390_FEAT_AP },
     };
     int i;
 
@@ -900,6 +902,16 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
     cpu->model->cpu_id_format = max_model->cpu_id_format;
     cpu->model->cpu_ver = max_model->cpu_ver;
 
+    /*
+     * If the AP facilities are not installed on the guest, then it makes
+     * no sense to enable the QCI or APFT facilities because they are only
+     * needed by AP facilities.
+     */
+    if (!test_bit(S390_FEAT_AP, cpu->model->features)) {
+        clear_bit(S390_FEAT_AP_QUERY_CONFIG_INFO, cpu->model->features);
+        clear_bit(S390_FEAT_AP_FACILITIES_TEST, cpu->model->features);
+    }
+
     check_consistency(cpu->model);
     check_compatibility(max_model, cpu->model, errp);
     if (*errp) {
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 0cdbc15..2d01b52 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -447,6 +447,9 @@ static uint16_t full_GEN12_GA1[] = {
     S390_FEAT_ADAPTER_INT_SUPPRESSION,
     S390_FEAT_EDAT_2,
     S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
+    S390_FEAT_AP,
+    S390_FEAT_AP_QUERY_CONFIG_INFO,
+    S390_FEAT_AP_FACILITIES_TEST,
 };
 
 static uint16_t full_GEN12_GA2[] = {
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index e13c890..ae20ed8 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2105,6 +2105,7 @@ static int kvm_to_feat[][2] = {
     { KVM_S390_VM_CPU_FEAT_PFMFI, S390_FEAT_SIE_PFMFI},
     { KVM_S390_VM_CPU_FEAT_SIGPIF, S390_FEAT_SIE_SIGPIF},
     { KVM_S390_VM_CPU_FEAT_KSS, S390_FEAT_SIE_KSS},
+    { KVM_S390_VM_CPU_FEAT_AP, S390_FEAT_AP},
 };
 
 static int query_cpu_feat(S390FeatBitmap features)
@@ -2214,6 +2215,11 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         error_setg(errp, "KVM: Error querying CPU features: %d", rc);
         return;
     }
+    /* AP facilities support is required to enable QCI and APFT support */
+    if (!test_bit(S390_FEAT_AP, model->features)) {
+        clear_bit(S390_FEAT_AP_QUERY_CONFIG_INFO, model->features);
+        clear_bit(S390_FEAT_AP_FACILITIES_TEST, model->features);
+    }
     /* get supported cpu subfunctions indicated via query / test bit */
     rc = query_cpu_subfunc(model->features);
     if (rc) {
-- 
1.7.1
