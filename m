Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700E2C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:15:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4901D2084D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4901D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHWbt-0006tR-AG
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 13:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iHWT2-0006M9-H6
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iHWT0-0004rQ-Ve
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:06:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53596)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1iHWSv-0004pL-VA; Mon, 07 Oct 2019 13:06:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 301BE307CDC0;
 Mon,  7 Oct 2019 17:06:33 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94E995D9C9;
 Mon,  7 Oct 2019 17:06:30 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [RFC PATCH 3/5] target/arm/kvm: Implement cpu feature kvm-adjvtime
Date: Mon,  7 Oct 2019 19:06:20 +0200
Message-Id: <20191007170622.1814-4-drjones@redhat.com>
In-Reply-To: <20191007170622.1814-1-drjones@redhat.com>
References: <20191007170622.1814-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 07 Oct 2019 17:06:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, bijan.mottahedeh@oracle.com, maz@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When kvm-adjvtime is enabled the guest's cntvct[_el0] won't count
the time when the VM is stopped. That time is skipped by updating
cntvoff[_el2] on each transition to vm_running using the current
QEMU_CLOCK_VIRTUAL time. QEMU_CLOCK_VIRTUAL only ticks when the VM
is running.

This patch only provides the implementation. A subsequent patch
will provide the CPU property allowing the feature to be enabled.

Reported-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Suggested-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 target/arm/cpu.h     |  3 +++
 target/arm/kvm.c     | 20 ++++++++++++++++++++
 target/arm/kvm32.c   | 15 +++++++++++++++
 target/arm/kvm64.c   | 15 +++++++++++++++
 target/arm/kvm_arm.h | 12 ++++++++++++
 5 files changed, 65 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5b9c3e4cd73d..923bd5e6384d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -821,6 +821,9 @@ struct ARMCPU {
     /* KVM init features for this CPU */
     uint32_t kvm_init_features[7];
=20
+    /* KVM CPU features */
+    bool kvm_adjvtime;
+
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
=20
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7a540d9591f9..f79b9b8ef57a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -571,6 +571,26 @@ int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
     return 0;
 }
=20
+void kvm_arm_set_virtual_time(CPUState *cs)
+{
+    uint64_t cnt;
+    struct kvm_one_reg reg =3D {
+        .id =3D KVM_REG_ARM_TIMER_CNT,
+        .addr =3D (uintptr_t)&cnt,
+    };
+    int ret;
+
+    cnt =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                   cpu_get_host_tick_frequency(),
+                   NANOSECONDS_PER_SECOND);
+
+    ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    if (ret) {
+        error_report("Failed to set KVM_REG_ARM_TIMER_CNT");
+        abort();
+    }
+}
+
 int kvm_put_vcpu_events(ARMCPU *cpu)
 {
     CPUARMState *env =3D &cpu->env;
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 32bf8d6757c4..79c6013066a9 100644
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
@@ -183,6 +184,18 @@ int kvm_arm_cpreg_level(uint64_t regidx)
     return KVM_PUT_RUNTIME_STATE;
 }
=20
+static void kvm_arm_vm_state_change(void *opaque, int running, RunState =
state)
+{
+    CPUState *cs =3D opaque;
+    ARMCPU *cpu =3D ARM_CPU(cs);
+
+    if (running) {
+        if (cpu->kvm_adjvtime) {
+            kvm_arm_set_virtual_time(cs);
+        }
+    }
+}
+
 #define ARM_CPU_ID_MPIDR       0, 0, 0, 5
=20
 int kvm_arch_init_vcpu(CPUState *cs)
@@ -198,6 +211,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return -EINVAL;
     }
=20
+    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cs);
+
     /* Determine init features for this CPU */
     memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
     if (cpu->start_powered_off) {
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 5cafcb7d36dd..494cf7f8a5cd 100644
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
@@ -720,6 +721,18 @@ static int kvm_arm_sve_set_vls(CPUState *cs)
     return kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
 }
=20
+static void kvm_arm_vm_state_change(void *opaque, int running, RunState =
state)
+{
+    CPUState *cs =3D opaque;
+    ARMCPU *cpu =3D ARM_CPU(cs);
+
+    if (running) {
+        if (cpu->kvm_adjvtime) {
+            kvm_arm_set_virtual_time(cs);
+        }
+    }
+}
+
 #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
=20
 int kvm_arch_init_vcpu(CPUState *cs)
@@ -735,6 +748,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return -EINVAL;
     }
=20
+    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cs);
+
     /* Determine init features for this CPU */
     memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
     if (cpu->start_powered_off) {
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index a1cc6513f72b..d506c4e84be6 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -232,6 +232,16 @@ void kvm_arm_sve_get_vls(CPUState *cs, unsigned long=
 *map);
  */
 void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
=20
+/**
+ * void kvm_arm_set_virtual_time:
+ * @cs: CPUState
+ *
+ * Sets the guest's virtual counter offset to the difference of the host=
's
+ * current time and QEMU's QEMU_CLOCK_VIRTUAL time. This allows the
+ * guest's virtual counter to only reflect VM running time.
+ */
+void kvm_arm_set_virtual_time(CPUState *cs);
+
 /**
  * kvm_arm_aarch32_supported:
  * @cs: CPUState
@@ -323,6 +333,8 @@ static inline int kvm_arm_vgic_probe(void)
     return 0;
 }
=20
+static inline void kvm_arm_set_virtual_time(CPUState *cs) {}
+
 static inline void kvm_arm_pmu_set_irq(CPUState *cs, int irq) {}
 static inline void kvm_arm_pmu_init(CPUState *cs) {}
=20
--=20
2.20.1


