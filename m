Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FD7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08EA120684
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/3Axwck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EA120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itU4t-0002E4-Uy
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1itU16-0005Wv-AK
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1itU14-00037j-DN
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:10:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26109
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1itU14-00037N-7n
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579515041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qx8CU4vUpbk6cZv/6f0WoXQNz8mtd0dvMgB8MqypsPQ=;
 b=R/3Axwck6BrIaYjVArejqjk4694OFfd6UPlJLjBmOyayM0WqV/OwYIsvFE2etthtwm8+r6
 4RqotKyWDjThFV04LM8Td2phNVyRilnjTO6PHQFw7tDxIkgzRvJrHK+VkR3qkbEm9B84JT
 dJjEQksDa7DII2ECi9EtGBJR5Q1f7go=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-NEuF5oTWMJqWukTCWBKefA-1; Mon, 20 Jan 2020 05:10:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C7BC800D48;
 Mon, 20 Jan 2020 10:10:37 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7365248;
 Mon, 20 Jan 2020 10:10:35 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [RFC PATCH v3 5/6] target/arm/kvm: Implement virtual time adjustment
Date: Mon, 20 Jan 2020 11:10:22 +0100
Message-Id: <20200120101023.16030-6-drjones@redhat.com>
In-Reply-To: <20200120101023.16030-1-drjones@redhat.com>
References: <20200120101023.16030-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: NEuF5oTWMJqWukTCWBKefA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, bijan.mottahedeh@oracle.com, maz@kernel.org,
 richard.henderson@linaro.org, guoheyi@huawei.com, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a VM is stopped (such as when it's paused) guest virtual time
should stop counting. Otherwise, when the VM is resumed it will
experience time jumps and its kernel may report soft lockups. Not
counting virtual time while the VM is stopped has the side effect
of making the guest's time appear to lag when compared with real
time, and even with time derived from the physical counter. For
this reason, this change, which is enabled by default, comes with
a KVM CPU feature allowing it to be disabled, restoring legacy
behavior.

This patch only provides the implementation of the virtual time
adjustment. A subsequent patch will provide the CPU property
allowing the change to be enabled and disabled.

Reported-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 target/arm/cpu.h     |  7 ++++
 target/arm/kvm.c     | 92 ++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm32.c   |  3 ++
 target/arm/kvm64.c   |  3 ++
 target/arm/kvm_arm.h | 38 ++++++++++++++++++
 target/arm/machine.c |  7 ++++
 6 files changed, 150 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 40f2c45e17e3..2e6477c92c9c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -821,6 +821,13 @@ struct ARMCPU {
     /* KVM init features for this CPU */
     uint32_t kvm_init_features[7];
=20
+    /* KVM CPU state */
+
+    /* KVM virtual time adjustment */
+    bool kvm_adjvtime;
+    bool kvm_vtime_dirty;
+    uint64_t kvm_vtime;
+
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
=20
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b87b59a02ad8..91e38def6b29 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -359,6 +359,22 @@ static int compare_u64(const void *a, const void *b)
     return 0;
 }
=20
+/*
+ * cpreg_values are sorted in ascending order by KVM register ID
+ * (see kvm_arm_init_cpreg_list). This allows us to cheaply find
+ * the storage for a KVM register by ID with a binary search.
+ */
+static uint64_t *kvm_arm_get_cpreg_ptr(ARMCPU *cpu, uint64_t regidx)
+{
+    uint64_t *res;
+
+    res =3D bsearch(&regidx, cpu->cpreg_indexes, cpu->cpreg_array_len,
+                  sizeof(uint64_t), compare_u64);
+    assert(res);
+
+    return &cpu->cpreg_values[res - cpu->cpreg_indexes];
+}
+
 /* Initialize the ARMCPU cpreg list according to the kernel's
  * definition of what CPU registers it knows about (and throw away
  * the previous TCG-created cpreg list).
@@ -512,6 +528,23 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int level)
     return ok;
 }
=20
+void kvm_arm_cpu_pre_save(ARMCPU *cpu)
+{
+    /* KVM virtual time adjustment */
+    if (cpu->kvm_vtime_dirty) {
+        *kvm_arm_get_cpreg_ptr(cpu, KVM_REG_ARM_TIMER_CNT) =3D cpu->kvm_vt=
ime;
+    }
+}
+
+void kvm_arm_cpu_post_load(ARMCPU *cpu)
+{
+    /* KVM virtual time adjustment */
+    if (cpu->kvm_adjvtime) {
+        cpu->kvm_vtime =3D *kvm_arm_get_cpreg_ptr(cpu, KVM_REG_ARM_TIMER_C=
NT);
+        cpu->kvm_vtime_dirty =3D true;
+    }
+}
+
 void kvm_arm_reset_vcpu(ARMCPU *cpu)
 {
     int ret;
@@ -579,6 +612,50 @@ int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
     return 0;
 }
=20
+void kvm_arm_get_virtual_time(CPUState *cs)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    struct kvm_one_reg reg =3D {
+        .id =3D KVM_REG_ARM_TIMER_CNT,
+        .addr =3D (uintptr_t)&cpu->kvm_vtime,
+    };
+    int ret;
+
+    if (cpu->kvm_vtime_dirty) {
+        return;
+    }
+
+    ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    if (ret) {
+        error_report("Failed to get KVM_REG_ARM_TIMER_CNT");
+        abort();
+    }
+
+    cpu->kvm_vtime_dirty =3D true;
+}
+
+void kvm_arm_put_virtual_time(CPUState *cs)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    struct kvm_one_reg reg =3D {
+        .id =3D KVM_REG_ARM_TIMER_CNT,
+        .addr =3D (uintptr_t)&cpu->kvm_vtime,
+    };
+    int ret;
+
+    if (!cpu->kvm_vtime_dirty) {
+        return;
+    }
+
+    ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    if (ret) {
+        error_report("Failed to set KVM_REG_ARM_TIMER_CNT");
+        abort();
+    }
+
+    cpu->kvm_vtime_dirty =3D false;
+}
+
 int kvm_put_vcpu_events(ARMCPU *cpu)
 {
     CPUARMState *env =3D &cpu->env;
@@ -690,6 +767,21 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_=
run *run)
     return MEMTXATTRS_UNSPECIFIED;
 }
=20
+void kvm_arm_vm_state_change(void *opaque, int running, RunState state)
+{
+    CPUState *cs =3D opaque;
+    ARMCPU *cpu =3D ARM_CPU(cs);
+
+    if (running) {
+        if (cpu->kvm_adjvtime) {
+            kvm_arm_put_virtual_time(cs);
+        }
+    } else {
+        if (cpu->kvm_adjvtime) {
+            kvm_arm_get_virtual_time(cs);
+        }
+    }
+}
=20
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 32bf8d6757c4..3a8b437eef0b 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -16,6 +16,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "qemu/timer.h"
+#include "sysemu/runstate.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
 #include "internals.h"
@@ -198,6 +199,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return -EINVAL;
     }
=20
+    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cs);
+
     /* Determine init features for this CPU */
     memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
     if (cpu->start_powered_off) {
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 5cafcb7d36dd..e486eaf1f944 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -23,6 +23,7 @@
 #include "qemu/host-utils.h"
 #include "qemu/main-loop.h"
 #include "exec/gdbstub.h"
+#include "sysemu/runstate.h"
 #include "sysemu/kvm.h"
 #include "sysemu/kvm_int.h"
 #include "kvm_arm.h"
@@ -735,6 +736,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return -EINVAL;
     }
=20
+    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cs);
+
     /* Determine init features for this CPU */
     memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
     if (cpu->start_powered_off) {
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index b48a9c95573b..01a9a1827851 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -127,6 +127,23 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int level);
  */
 bool write_kvmstate_to_list(ARMCPU *cpu);
=20
+/**
+ * kvm_arm_cpu_pre_save:
+ * @cpu: ARMCPU
+ *
+ * Called after write_kvmstate_to_list() from cpu_pre_save() to update
+ * the cpreg list with KVM CPU state.
+ */
+void kvm_arm_cpu_pre_save(ARMCPU *cpu);
+
+/**
+ * kvm_arm_cpu_post_load:
+ * @cpu: ARMCPU
+ *
+ * Called from cpu_post_load() to update KVM CPU state from the cpreg list=
.
+ */
+void kvm_arm_cpu_post_load(ARMCPU *cpu);
+
 /**
  * kvm_arm_reset_vcpu:
  * @cpu: ARMCPU
@@ -292,6 +309,24 @@ int kvm_arm_sync_mpstate_to_kvm(ARMCPU *cpu);
  */
 int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu);
=20
+/**
+ * kvm_arm_get_virtual_time:
+ * @cs: CPUState
+ *
+ * Gets the VCPU's virtual counter and stores it in the KVM CPU state.
+ */
+void kvm_arm_get_virtual_time(CPUState *cs);
+
+/**
+ * kvm_arm_put_virtual_time:
+ * @cs: CPUState
+ *
+ * Sets the VCPU's virtual counter to the value stored in the KVM CPU stat=
e.
+ */
+void kvm_arm_put_virtual_time(CPUState *cs);
+
+void kvm_arm_vm_state_change(void *opaque, int running, RunState state);
+
 int kvm_arm_vgic_probe(void);
=20
 void kvm_arm_pmu_set_irq(CPUState *cs, int irq);
@@ -339,6 +374,9 @@ static inline void kvm_arm_pmu_set_irq(CPUState *cs, in=
t irq) {}
 static inline void kvm_arm_pmu_init(CPUState *cs) {}
=20
 static inline void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map) {=
}
+
+static inline void kvm_arm_get_virtual_time(CPUState *cs) {}
+static inline void kvm_arm_put_virtual_time(CPUState *cs) {}
 #endif
=20
 static inline const char *gic_class_name(void)
diff --git a/target/arm/machine.c b/target/arm/machine.c
index eb28b2381bb5..241890ac8cf7 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -642,6 +642,12 @@ static int cpu_pre_save(void *opaque)
             /* This should never fail */
             abort();
         }
+
+        /*
+         * kvm_arm_cpu_pre_save() must be called after
+         * write_kvmstate_to_list()
+         */
+        kvm_arm_cpu_pre_save(cpu);
     } else {
         if (!write_cpustate_to_list(cpu, false)) {
             /* This should never fail. */
@@ -744,6 +750,7 @@ static int cpu_post_load(void *opaque, int version_id)
          * we're using it.
          */
         write_list_to_cpustate(cpu);
+        kvm_arm_cpu_post_load(cpu);
     } else {
         if (!write_list_to_cpustate(cpu)) {
             return -1;
--=20
2.21.1


