Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75FBC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8711D2073D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTiHxGj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8711D2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifTIi-0006a3-D5
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1ifSLU-0002O3-CA
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:33:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1ifSLR-00031v-Fc
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:33:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52901
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ifSLQ-0002zf-Qs
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576172023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n/IbXa6/cRTFnZUB1PA5FcfNgMBIt9Opu+eYgctHLuE=;
 b=YTiHxGj9IOv2hQUYyb0sbwNLxStp0G3Jn0FN4qOqOfositoZgDAKfLBEowMi4YETAxTEXD
 uwyhaDkx7u0VYC6ExKNBW2jUFBeHq5PjjJtXw1X+dtoyNULL8DjjDzaUkWTgLyA2Gwgs56
 HXPDhrzqqjdfeAIMOuu1bHb1PaAxGkY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-qPAblt0SOpKv5S9d8zcKsQ-1; Thu, 12 Dec 2019 12:33:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0F7D800D4E;
 Thu, 12 Dec 2019 17:33:37 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01B4819C4F;
 Thu, 12 Dec 2019 17:33:35 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [RFC PATCH v2 3/5] target/arm/kvm: Implement virtual time adjustment
Date: Thu, 12 Dec 2019 18:33:18 +0100
Message-Id: <20191212173320.11610-4-drjones@redhat.com>
In-Reply-To: <20191212173320.11610-1-drjones@redhat.com>
References: <20191212173320.11610-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: qPAblt0SOpKv5S9d8zcKsQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

When a VM is stopped (guest is paused) guest virtual time
should stop counting. Otherwise, when the VM is resumed it
will experience time jumps and its kernel may report soft
lockups. Not counting virtual time while the VM is stopped
has the side effect of making the guest's time appear to lag
when compared with real time, and even with time derived from
the physical counter. For this reason, this change, which is
enabled by default, comes with a KVM CPU feature allowing it
to be disabled, restoring legacy behavior.

This patch only provides the implementation of the virtual
time adjustment. A subsequent patch will provide the CPU
property allowing the change to be enabled and disabled.

Reported-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 target/arm/cpu.h     |  9 +++++++++
 target/arm/kvm.c     | 48 ++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm32.c   |  3 +++
 target/arm/kvm64.c   |  3 +++
 target/arm/kvm_arm.h | 23 +++++++++++++++++++++
 5 files changed, 86 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 83a809d4bac4..a79ea74125b3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -821,6 +821,15 @@ struct ARMCPU {
     /* KVM init features for this CPU */
     uint32_t kvm_init_features[7];
=20
+    /* KVM CPU features */
+    bool kvm_adjvtime;
+
+    /* VCPU virtual counter value used with kvm_adjvtime */
+    uint64_t kvm_vtime;
+
+    /* True if the run state is, or transitioning from, RUN_STATE_PAUSED *=
/
+    bool runstate_paused;
+
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
=20
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 5b82cefef608..a55fe7d7aefd 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -348,6 +348,24 @@ void kvm_arm_register_device(MemoryRegion *mr, uint64_=
t devid, uint64_t group,
     memory_region_ref(kd->mr);
 }
=20
+void kvm_arm_vm_state_change(void *opaque, int running, RunState state)
+{
+    CPUState *cs =3D opaque;
+    ARMCPU *cpu =3D ARM_CPU(cs);
+
+    if (running) {
+        if (cpu->kvm_adjvtime && cpu->runstate_paused) {
+            kvm_arm_set_virtual_time(cs, cpu->kvm_vtime);
+        }
+        cpu->runstate_paused =3D false;
+    } else if (state =3D=3D RUN_STATE_PAUSED) {
+        cpu->runstate_paused =3D true;
+        if (cpu->kvm_adjvtime) {
+            kvm_arm_get_virtual_time(cs, &cpu->kvm_vtime);
+        }
+    }
+}
+
 static int compare_u64(const void *a, const void *b)
 {
     if (*(uint64_t *)a > *(uint64_t *)b) {
@@ -579,6 +597,36 @@ int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
     return 0;
 }
=20
+void kvm_arm_get_virtual_time(CPUState *cs, uint64_t *cnt)
+{
+    struct kvm_one_reg reg =3D {
+        .id =3D KVM_REG_ARM_TIMER_CNT,
+        .addr =3D (uintptr_t)cnt,
+    };
+    int ret;
+
+    ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    if (ret) {
+        error_report("Failed to get KVM_REG_ARM_TIMER_CNT");
+        abort();
+    }
+}
+
+void kvm_arm_set_virtual_time(CPUState *cs, uint64_t cnt)
+{
+    struct kvm_one_reg reg =3D {
+        .id =3D KVM_REG_ARM_TIMER_CNT,
+        .addr =3D (uintptr_t)&cnt,
+    };
+    int ret;
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
index 8e14d400e8ab..16b53e45377d 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -232,6 +232,24 @@ void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *=
map);
  */
 void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
=20
+/**
+ * void kvm_arm_get_virtual_time:
+ * @cs: CPUState
+ * @cnt: the virtual counter to fill in
+ *
+ * Gets the VCPU's virtual counter and stores it in @cnt.
+ */
+void kvm_arm_get_virtual_time(CPUState *cs, uint64_t *cnt);
+
+/**
+ * void kvm_arm_set_virtual_time:
+ * @cs: CPUState
+ * @cnt: new virtual counter value
+ *
+ * Sets the VCPU's virtual counter to @cnt.
+ */
+void kvm_arm_set_virtual_time(CPUState *cs, uint64_t cnt);
+
 /**
  * kvm_arm_aarch32_supported:
  * @cs: CPUState
@@ -288,6 +306,8 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq);
 void kvm_arm_pmu_init(CPUState *cs);
 int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
=20
+void kvm_arm_vm_state_change(void *opaque, int running, RunState state);
+
 #else
=20
 static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
@@ -324,6 +344,9 @@ static inline int kvm_arm_vgic_probe(void)
     return 0;
 }
=20
+static inline void kvm_arm_get_virtual_time(CPUState *cs, uint64_t *cnt) {=
}
+static inline void kvm_arm_set_virtual_time(CPUState *cs, uint64_t cnt) {}
+
 static inline void kvm_arm_pmu_set_irq(CPUState *cs, int irq) {}
 static inline void kvm_arm_pmu_init(CPUState *cs) {}
=20
--=20
2.21.0


