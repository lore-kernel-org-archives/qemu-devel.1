Received: from eggs.gnu.org ([2001:4830:134:3::10]:46087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1frjhC-0007I2-82
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1frjh9-000677-QF
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:54:10 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 20 Aug 2018 14:53:40 +0200
Message-Id: <20180820125341.5882-7-cohuck@redhat.com>
In-Reply-To: <20180820125341.5882-1-cohuck@redhat.com>
References: <20180820125341.5882-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] s390x/kvm: add etoken facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Provide the etoken facility. We need to handle cpu model, migration and
clear reset.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Message-Id: <20180731090448.36662-3-borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.h              |  3 +++
 target/s390x/cpu_features.c     |  3 ++-
 target/s390x/cpu_features_def.h |  3 ++-
 target/s390x/gen-features.c     |  3 ++-
 target/s390x/kvm.c              | 11 +++++++++++
 target/s390x/machine.c          | 20 +++++++++++++++++++-
 6 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 86b66dfeac..6f8861e554 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -2,6 +2,7 @@
  * S/390 virtual CPU header
  *
  *  Copyright (c) 2009 Ulrich Hecht
+ *  Copyright IBM Corp. 2012, 2018
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -68,6 +69,8 @@ struct CPUS390XState {
     uint32_t aregs[16];    /* access registers */
     uint8_t riccb[64];     /* runtime instrumentation control */
     uint64_t gscb[4];      /* guarded storage control */
+    uint64_t etoken;       /* etoken */
+    uint64_t etoken_extension; /* etoken extension */
 
     /* Fields up to this point are not cleared by initial CPU reset */
     struct {} start_initial_reset_fields;
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index d623db34a6..172fb18df7 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -1,7 +1,7 @@
 /*
  * CPU features/facilities for s390x
  *
- * Copyright 2016 IBM Corp.
+ * Copyright IBM Corp. 2016, 2018
  *
  * Author(s): David Hildenbrand <dahi@linux.vnet.ibm.com>
  *
@@ -105,6 +105,7 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("irbm", S390_FEAT_TYPE_STFL, 145, "Insert-reference-bits-multiple facility"),
     FEAT_INIT("msa8-base", S390_FEAT_TYPE_STFL, 146, "Message-security-assist-extension-8 facility (excluding subfunctions)"),
     FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancement (no translate) facility"),
+    FEAT_INIT("etoken", S390_FEAT_TYPE_STFL, 156, "Etoken facility"),
 
     /* SCLP SCCB Byte 80 - 98  (bit numbers relative to byte-80) */
     FEAT_INIT("gsls", S390_FEAT_TYPE_SCLP_CONF_CHAR, 40, "SIE: Guest-storage-limit-suppression facility"),
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index 7c5915c7b2..ac2c947f30 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -1,7 +1,7 @@
 /*
  * CPU features/facilities for s390
  *
- * Copyright 2016 IBM Corp.
+ * Copyright IBM Corp. 2016, 2018
  *
  * Author(s): Michael Mueller <mimu@linux.vnet.ibm.com>
  *            David Hildenbrand <dahi@linux.vnet.ibm.com>
@@ -93,6 +93,7 @@ typedef enum {
     S390_FEAT_INSERT_REFERENCE_BITS_MULT,
     S390_FEAT_MSA_EXT_8,
     S390_FEAT_CMM_NT,
+    S390_FEAT_ETOKEN,
 
     /* Sclp Conf Char */
     S390_FEAT_SIE_GSLS,
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 2ca5ededb3..384b61cd67 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -1,7 +1,7 @@
 /*
  * S390 feature list generator
  *
- * Copyright 2016 IBM Corp.
+ * Copyright IBM Corp. 2016, 2018
  *
  * Author(s): Michael Mueller <mimu@linux.vnet.ibm.com>
  *            David Hildenbrand <dahi@linux.vnet.ibm.com>
@@ -471,6 +471,7 @@ static uint16_t full_GEN14_GA1[] = {
     S390_FEAT_GROUP_MSA_EXT_7,
     S390_FEAT_GROUP_MSA_EXT_8,
     S390_FEAT_CMM_NT,
+    S390_FEAT_ETOKEN,
     S390_FEAT_HPMA2,
     S390_FEAT_SIE_KSS,
     S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index d923cf4240..af83955e5f 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -493,6 +493,12 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_BPBC;
     }
 
+    if (can_sync_regs(cs, KVM_SYNC_ETOKEN)) {
+        cs->kvm_run->s.regs.etoken = env->etoken;
+        cs->kvm_run->s.regs.etoken_extension  = env->etoken_extension;
+        cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_ETOKEN;
+    }
+
     /* Finally the prefix */
     if (can_sync_regs(cs, KVM_SYNC_PREFIX)) {
         cs->kvm_run->s.regs.prefix = env->psa;
@@ -607,6 +613,11 @@ int kvm_arch_get_registers(CPUState *cs)
         env->bpbc = cs->kvm_run->s.regs.bpbc;
     }
 
+    if (can_sync_regs(cs, KVM_SYNC_ETOKEN)) {
+        env->etoken = cs->kvm_run->s.regs.etoken;
+        env->etoken_extension = cs->kvm_run->s.regs.etoken_extension;
+    }
+
     /* pfault parameters */
     if (can_sync_regs(cs, KVM_SYNC_PFAULT)) {
         env->pfault_token = cs->kvm_run->s.regs.pft;
diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index bd3230d027..cb792aa103 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -1,7 +1,7 @@
 /*
  * S390x machine definitions and functions
  *
- * Copyright IBM Corp. 2014
+ * Copyright IBM Corp. 2014, 2018
  *
  * Authors:
  *   Thomas Huth <thuth@linux.vnet.ibm.com>
@@ -216,6 +216,23 @@ const VMStateDescription vmstate_bpbc = {
     }
 };
 
+static bool etoken_needed(void *opaque)
+{
+    return s390_has_feat(S390_FEAT_ETOKEN);
+}
+
+const VMStateDescription vmstate_etoken = {
+    .name = "cpu/etoken",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = etoken_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.etoken, S390CPU),
+        VMSTATE_UINT64(env.etoken_extension, S390CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_s390_cpu = {
     .name = "cpu",
     .post_load = cpu_post_load,
@@ -251,6 +268,7 @@ const VMStateDescription vmstate_s390_cpu = {
         &vmstate_exval,
         &vmstate_gscb,
         &vmstate_bpbc,
+        &vmstate_etoken,
         NULL
     },
 };
-- 
2.14.4
