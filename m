Received: from eggs.gnu.org ([2001:4830:134:3::10]:44115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ip-0005OL-RA
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ik-00081E-Iy
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8ik-00080a-An
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:58 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEhjI117414
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:57 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyh46kn4d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:56 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:55 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:51 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-31-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 30/54] s390x/kvm: Handle bpb feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

We need to handle the bpb control on reset and migration. Normally
stfle.82 is transparent (and the normal guest part works without
hypervisor activity). To prevent any issues we require full
host kernel support for this feature.

Cc: qemu-stable@nongnu.org
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20180118085628.40798-3-borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
[CH: 'Branch Prediction Blocking' -> 'Branch prediction blocking']
Signed-off-by: Cornelia Huck <cohuck@redhat.com>

(cherry picked from commit b073c87517d4d348c7bac0f0b35e8e83e6354d82)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/s390x/cpu.c              |  1 +
 target/s390x/cpu.h              |  1 +
 target/s390x/cpu_features.c     |  1 +
 target/s390x/cpu_features_def.h |  1 +
 target/s390x/gen-features.c     |  1 +
 target/s390x/kvm.c              | 14 ++++++++++++++
 target/s390x/machine.c          | 17 +++++++++++++++++
 7 files changed, 36 insertions(+)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index ae3cee91a2..d2e6b9f5c7 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -89,6 +89,7 @@ static void s390_cpu_reset(CPUState *s)
     CPUS390XState *env = &cpu->env;
 
     env->pfault_token = -1UL;
+    env->bpbc = false;
     scc->parent_reset(s);
     cpu->env.sigp_order = 0;
     s390_cpu_set_state(CPU_STATE_STOPPED, cpu);
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 4db8b5409e..23053e3b6a 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -93,6 +93,7 @@ struct CPUS390XState {
 
     uint32_t fpc;          /* floating-point control register */
     uint32_t cc_op;
+    bool bpbc;             /* branch prediction blocking */
 
     float_status fpu_status; /* passed to softfloat lib */
 
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 31a4676f05..b45ef09f93 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -89,6 +89,7 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("msa4-base", S390_FEAT_TYPE_STFL, 77, "Message-security-assist-extension-4 facility (excluding subfunctions)"),
     FEAT_INIT("edat2", S390_FEAT_TYPE_STFL, 78, "Enhanced-DAT facility 2"),
     FEAT_INIT("dfppc", S390_FEAT_TYPE_STFL, 80, "Decimal-floating-point packed-conversion facility"),
+    FEAT_INIT("bpb", S390_FEAT_TYPE_STFL, 82, "Branch prediction blocking"),
     FEAT_INIT("vx", S390_FEAT_TYPE_STFL, 129, "Vector facility"),
     FEAT_INIT("iep", S390_FEAT_TYPE_STFL, 130, "Instruction-execution-protection facility"),
     FEAT_INIT("sea_esop2", S390_FEAT_TYPE_STFL, 131, "Side-effect-access facility and Enhanced-suppression-on-protection facility 2"),
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index 4b6d4e9cc0..4487cfd53b 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -80,6 +80,7 @@ typedef enum {
     S390_FEAT_MSA_EXT_4,
     S390_FEAT_EDAT_2,
     S390_FEAT_DFP_PACKED_CONVERSION,
+    S390_FEAT_BPB,
     S390_FEAT_VECTOR,
     S390_FEAT_INSTRUCTION_EXEC_PROT,
     S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 68e6c31b4b..13a6291a3c 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -352,6 +352,7 @@ static uint16_t base_GEN14_GA1[] = {
  * support these features yet.
  */
 static uint16_t full_GEN7_GA1[] = {
+    S390_FEAT_BPB,
     S390_FEAT_SIE_F2,
     S390_FEAT_SIE_SKEY,
     S390_FEAT_SIE_GPERE,
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index b03f583032..2abc4ade6c 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -490,6 +490,11 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_GSCB;
     }
 
+    if (can_sync_regs(cs, KVM_SYNC_BPBC)) {
+        cs->kvm_run->s.regs.bpbc = env->bpbc;
+        cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_BPBC;
+    }
+
     /* Finally the prefix */
     if (can_sync_regs(cs, KVM_SYNC_PREFIX)) {
         cs->kvm_run->s.regs.prefix = env->psa;
@@ -600,6 +605,10 @@ int kvm_arch_get_registers(CPUState *cs)
         memcpy(env->gscb, cs->kvm_run->s.regs.gscb, 32);
     }
 
+    if (can_sync_regs(cs, KVM_SYNC_BPBC)) {
+        env->bpbc = cs->kvm_run->s.regs.bpbc;
+    }
+
     /* pfault parameters */
     if (can_sync_regs(cs, KVM_SYNC_PFAULT)) {
         env->pfault_token = cs->kvm_run->s.regs.pft;
@@ -2298,6 +2307,11 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         clear_bit(S390_FEAT_CMM_NT, model->features);
     }
 
+    /* bpb needs kernel support for migration, VSIE and reset */
+    if (!kvm_check_extension(kvm_state, KVM_CAP_S390_BPB)) {
+        clear_bit(S390_FEAT_BPB, model->features);
+    }
+
     /* We emulate a zPCI bus and AEN, therefore we don't need HW support */
     if (pci_available) {
         set_bit(S390_FEAT_ZPCI, model->features);
diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index b78f326d3a..84b4928755 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -194,6 +194,22 @@ const VMStateDescription vmstate_gscb = {
         }
 };
 
+static bool bpbc_needed(void *opaque)
+{
+    return s390_has_feat(S390_FEAT_BPB);
+}
+
+const VMStateDescription vmstate_bpbc = {
+    .name = "cpu/bpbc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = bpbc_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(env.bpbc, S390CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_s390_cpu = {
     .name = "cpu",
     .post_load = cpu_post_load,
@@ -228,6 +244,7 @@ const VMStateDescription vmstate_s390_cpu = {
         &vmstate_riccb,
         &vmstate_exval,
         &vmstate_gscb,
+        &vmstate_bpbc,
         NULL
     },
 };
-- 
2.11.0
