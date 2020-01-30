Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8200BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C971206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jOMy7Pyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C971206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCda-0005O7-Fy
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCUD-0005qy-8r
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCUB-0003I9-L6
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:09 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:33134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCUB-0003Fl-DK
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:07 -0500
Received: by mail-wr1-x434.google.com with SMTP id b6so4848093wrq.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uxQM5IOGoV9FN9L41ZsJ/K3NgBdc99DU1odE8TxuIao=;
 b=jOMy7PyiHzJ43iO8pKdT2mogzzvBy1ZuTT1X9QcfIbHQcIT/cSFCptpd2Ps+S6B1Dv
 ouyKtTZKn86mDodwCzVaJ14EJZ4IThNDhrnzMnh2jyZutNThvy4kAy/ZNXXv7+TT2AML
 fiy7XGVdgCOPFbS4YP4vv/n1ZT7J0qUL1c23nbDH28qoGOFtRNkfiUq6uL0N624Bd3li
 WGuTxptDnCoLXxM4iwqBdlNfc7emDzIxCRM9/vQcOBuZljPsN5eooaylOVplygVf4TGG
 urgNtrfDVx+YwnT9DlujK2Op4lJsLn/i0SeYc4G1i6/ZutNV0foxi4+xtDLECkM46+nF
 sHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uxQM5IOGoV9FN9L41ZsJ/K3NgBdc99DU1odE8TxuIao=;
 b=fTitu4JxZP0GWMUOyQsLjmVJomC77+mRCum1KiLMJoTZ4OkqGmzPt9b/EQw4FvbpOY
 zLu283DH2otXcLQCZ0CA2f52AyHGKcVgIIHtCug3i4ddui7HE4mK7/8NkDLV+NrLc3su
 js2ZcYNZdL7HSrYXzK0JtYpFrkoVl0e4g8vHvpBkLXC9mBMtk4oqo7oFt1HIiAG7TjUE
 y9MXNmQm2c1gB6V2OKomanOa54aozeoCCJjEIZ6csdBrrx5PcTf8Sv2xnymIrhgLwBD2
 OW/XzXHicmmgZWhaRChhy/86E7rjeOmpYdzFntf9ku6Ql6TLzwp1GYeIhIB0NYMr4bTR
 I/hQ==
X-Gm-Message-State: APjAAAWcGlAN+lT1m7g8WVxZU80ZM5EEv8dG479j21UsAZiaAcVBXjiV
 jfk+Xxc5rty9mnF5MU80CHgBXm31rS19Lg==
X-Google-Smtp-Source: APXvYqwKkyXRR5zEoY6NAsTTNa13YoX54JiUDeJzGKXEfLP2OP0aHFn/wYz+k7cidTlIxKGLyU+SYA==
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr6651219wrp.2.1580400966126;
 Thu, 30 Jan 2020 08:16:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.16.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:16:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/26] target/arm/kvm: Implement virtual time adjustment
Date: Thu, 30 Jan 2020 16:15:32 +0000
Message-Id: <20200130161533.8180-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Jones <drjones@redhat.com>

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
Message-id: 20200120101023.16030-6-drjones@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h     |  7 ++++
 target/arm/kvm_arm.h | 38 ++++++++++++++++++
 target/arm/kvm.c     | 92 ++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm32.c   |  3 ++
 target/arm/kvm64.c   |  3 ++
 target/arm/machine.c |  7 ++++
 6 files changed, 150 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c1aedbeac0d..608fcbd0b75 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -821,6 +821,13 @@ struct ARMCPU {
     /* KVM init features for this CPU */
     uint32_t kvm_init_features[7];
 
+    /* KVM CPU state */
+
+    /* KVM virtual time adjustment */
+    bool kvm_adjvtime;
+    bool kvm_vtime_dirty;
+    uint64_t kvm_vtime;
+
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
 
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index b48a9c95573..01a9a182785 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -127,6 +127,23 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int level);
  */
 bool write_kvmstate_to_list(ARMCPU *cpu);
 
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
+ * Called from cpu_post_load() to update KVM CPU state from the cpreg list.
+ */
+void kvm_arm_cpu_post_load(ARMCPU *cpu);
+
 /**
  * kvm_arm_reset_vcpu:
  * @cpu: ARMCPU
@@ -292,6 +309,24 @@ int kvm_arm_sync_mpstate_to_kvm(ARMCPU *cpu);
  */
 int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu);
 
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
+ * Sets the VCPU's virtual counter to the value stored in the KVM CPU state.
+ */
+void kvm_arm_put_virtual_time(CPUState *cs);
+
+void kvm_arm_vm_state_change(void *opaque, int running, RunState state);
+
 int kvm_arm_vgic_probe(void);
 
 void kvm_arm_pmu_set_irq(CPUState *cs, int irq);
@@ -339,6 +374,9 @@ static inline void kvm_arm_pmu_set_irq(CPUState *cs, int irq) {}
 static inline void kvm_arm_pmu_init(CPUState *cs) {}
 
 static inline void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map) {}
+
+static inline void kvm_arm_get_virtual_time(CPUState *cs) {}
+static inline void kvm_arm_put_virtual_time(CPUState *cs) {}
 #endif
 
 static inline const char *gic_class_name(void)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8d828891506..e36ab0b38bf 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -357,6 +357,22 @@ static int compare_u64(const void *a, const void *b)
     return 0;
 }
 
+/*
+ * cpreg_values are sorted in ascending order by KVM register ID
+ * (see kvm_arm_init_cpreg_list). This allows us to cheaply find
+ * the storage for a KVM register by ID with a binary search.
+ */
+static uint64_t *kvm_arm_get_cpreg_ptr(ARMCPU *cpu, uint64_t regidx)
+{
+    uint64_t *res;
+
+    res = bsearch(&regidx, cpu->cpreg_indexes, cpu->cpreg_array_len,
+                  sizeof(uint64_t), compare_u64);
+    assert(res);
+
+    return &cpu->cpreg_values[res - cpu->cpreg_indexes];
+}
+
 /* Initialize the ARMCPU cpreg list according to the kernel's
  * definition of what CPU registers it knows about (and throw away
  * the previous TCG-created cpreg list).
@@ -510,6 +526,23 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int level)
     return ok;
 }
 
+void kvm_arm_cpu_pre_save(ARMCPU *cpu)
+{
+    /* KVM virtual time adjustment */
+    if (cpu->kvm_vtime_dirty) {
+        *kvm_arm_get_cpreg_ptr(cpu, KVM_REG_ARM_TIMER_CNT) = cpu->kvm_vtime;
+    }
+}
+
+void kvm_arm_cpu_post_load(ARMCPU *cpu)
+{
+    /* KVM virtual time adjustment */
+    if (cpu->kvm_adjvtime) {
+        cpu->kvm_vtime = *kvm_arm_get_cpreg_ptr(cpu, KVM_REG_ARM_TIMER_CNT);
+        cpu->kvm_vtime_dirty = true;
+    }
+}
+
 void kvm_arm_reset_vcpu(ARMCPU *cpu)
 {
     int ret;
@@ -577,6 +610,50 @@ int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
     return 0;
 }
 
+void kvm_arm_get_virtual_time(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    struct kvm_one_reg reg = {
+        .id = KVM_REG_ARM_TIMER_CNT,
+        .addr = (uintptr_t)&cpu->kvm_vtime,
+    };
+    int ret;
+
+    if (cpu->kvm_vtime_dirty) {
+        return;
+    }
+
+    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    if (ret) {
+        error_report("Failed to get KVM_REG_ARM_TIMER_CNT");
+        abort();
+    }
+
+    cpu->kvm_vtime_dirty = true;
+}
+
+void kvm_arm_put_virtual_time(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    struct kvm_one_reg reg = {
+        .id = KVM_REG_ARM_TIMER_CNT,
+        .addr = (uintptr_t)&cpu->kvm_vtime,
+    };
+    int ret;
+
+    if (!cpu->kvm_vtime_dirty) {
+        return;
+    }
+
+    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    if (ret) {
+        error_report("Failed to set KVM_REG_ARM_TIMER_CNT");
+        abort();
+    }
+
+    cpu->kvm_vtime_dirty = false;
+}
+
 int kvm_put_vcpu_events(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
@@ -688,6 +765,21 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
     return MEMTXATTRS_UNSPECIFIED;
 }
 
+void kvm_arm_vm_state_change(void *opaque, int running, RunState state)
+{
+    CPUState *cs = opaque;
+    ARMCPU *cpu = ARM_CPU(cs);
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
 
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 32bf8d6757c..3a8b437eef0 100644
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
 
+    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cs);
+
     /* Determine init features for this CPU */
     memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
     if (cpu->start_powered_off) {
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 8955d23affd..fb21ab9e737 100644
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
@@ -734,6 +735,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return -EINVAL;
     }
 
+    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cs);
+
     /* Determine init features for this CPU */
     memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
     if (cpu->start_powered_off) {
diff --git a/target/arm/machine.c b/target/arm/machine.c
index eb28b2381bb..241890ac8cf 100644
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
-- 
2.20.1


