Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D921C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5221420872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5221420872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCnhI-0001Dw-Vz
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 12:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iCmfH-0001Tw-1c
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iCmfB-0006nU-Mm
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:23:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2240 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iCmez-0006ft-T2; Tue, 24 Sep 2019 11:23:26 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 62FD0D73C3932A7CBA5E;
 Tue, 24 Sep 2019 23:23:22 +0800 (CST)
Received: from linux-Bxxcye.huawei.com (10.175.104.222) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 24 Sep 2019 23:23:15 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>,
 <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [RFC PATCH 03/12] arm/sdei: add support to handle SDEI requests from
 guest
Date: Tue, 24 Sep 2019 23:21:42 +0800
Message-ID: <1569338511-3572-4-git-send-email-guoheyi@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
References: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.222]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
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
Cc: Mark
 Rutland <mark.rutland@arm.com>, Peter Maydell <peter.maydell@linaro.org>,
 James Morse <james.morse@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Jingyi Wang <wangjingyi11@huawei.com>, Heyi Guo <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com, Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support for all interfaces defined in ARM SDEI 1.0 spec.

http://infocenter.arm.com/help/topic/com.arm.doc.den0054a/ARM_DEN0054A_Software_Delegated_Exception_Interface.pdf

The exit reason KVM_EXIT_HYPERCALL is used to indicate it is an
HVC/SMC forward, and the structure kvm_run->hypercall is used to pass
arguments and return values between KVM and qemu:
Input:
  nr: the immediate value of SMC/HVC calls; not really used today.
  args[6]: x0..x5 (This is not fully conform with SMCCC which requires
           x6 as argument as well, but we can use GET_ONE_REG ioctl
           for such rare case).
Return:
  args[0..3]: x0..x3 as defined in SMCCC. We rely on KVM to extract
              args[0..3] and write them to x0..x3 when hypercall exit
              returns.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 target/arm/sdei.c | 911 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/sdei.h |  34 ++
 2 files changed, 945 insertions(+)
 create mode 100644 target/arm/sdei.h

diff --git a/target/arm/sdei.c b/target/arm/sdei.c
index 7f12d69..b40fa36 100644
--- a/target/arm/sdei.c
+++ b/target/arm/sdei.c
@@ -29,6 +29,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/reset.h"
 #include "qemu/error-report.h"
+#include "sdei.h"
 #include "sdei_int.h"
 #include "internals.h"
 #include "hw/boards.h"
@@ -84,6 +85,12 @@ static void qemu_sde_cpu_init(QemuSDEState *s)
     }
 }
 
+static inline QemuSDECpu *get_sde_cpu(QemuSDEState *s, CPUState *cs)
+{
+    assert(cs->cpu_index < s->sdei_max_cpus);
+    return &s->sde_cpus[cs->cpu_index];
+}
+
 static bool is_valid_event_number(int32_t event)
 {
     int32_t slot_id;
@@ -122,6 +129,910 @@ static QemuSDEProp *get_sde_prop_no_lock(QemuSDEState *s, int32_t event)
     return &s->sde_props_state[SDEI_EVENT_TO_SLOT(event)];
 }
 
+static QemuSDEProp *get_sde_prop(QemuSDEState *s, int32_t event)
+{
+    QemuSDEProp *sde_props = s->sde_props_state;
+
+    if (!is_valid_event_number(event)) {
+        return NULL;
+    }
+
+    event = SDEI_EVENT_TO_SLOT(event);
+
+    qemu_mutex_lock(&sde_props[event].lock);
+    if (sde_props[event].event_id < 0) {
+        qemu_mutex_unlock(&sde_props[event].lock);
+        return NULL;
+    }
+    return &sde_props[event];
+}
+
+static void put_sde_prop(QemuSDEProp *prop)
+{
+    qemu_mutex_unlock(&prop->lock);
+}
+
+static void sde_slot_lock(QemuSDE *sde, CPUState *cs)
+{
+    qemu_mutex_lock(&sde->lock);
+}
+
+static void sde_slot_unlock(QemuSDE *sde, CPUState *cs)
+{
+    qemu_mutex_unlock(&sde->lock);
+}
+
+/*
+ * It will always return a pointer to a preallocated sde; event number must be
+ * validated before calling this function.
+ */
+static QemuSDE *get_sde_no_check(QemuSDEState *s, int32_t event, CPUState *cs)
+{
+    QemuSDE **array = s->sde_cpus[cs->cpu_index].private_sde_array;
+    int32_t sde_index = SDEI_EVENT_TO_SLOT(event);
+    QemuSDE *sde;
+
+    if (SDEI_IS_SHARED_EVENT(event)) {
+        array = s->shared_sde_array;
+        sde_index -= PRIVATE_SLOT_COUNT;
+    }
+
+    sde = array[sde_index];
+    sde_slot_lock(sde, cs);
+    return sde;
+}
+
+static void put_sde(QemuSDE *sde, CPUState *cs)
+{
+    sde_slot_unlock(sde, cs);
+}
+
+static inline bool is_sde_nested(QemuSDECpu *sde_cpu)
+{
+    return sde_cpu->critical_running_event >= 0 &&
+           sde_cpu->normal_running_event >= 0;
+}
+
+static int32_t get_running_sde(QemuSDEState *s, CPUState *cs)
+{
+    QemuSDECpu *sde_cpu = get_sde_cpu(s, cs);
+
+    if (sde_cpu->critical_running_event >= 0) {
+        return sde_cpu->critical_running_event;
+    }
+    return sde_cpu->normal_running_event;
+}
+
+static void override_return_value(CPUState *cs, uint64_t *args)
+{
+    CPUARMState *env = &ARM_CPU(cs)->env;
+    int i;
+
+    for (i = 0; i < 4; i++) {
+        args[i] = env->xregs[i];
+    }
+}
+
+static void sde_save_cpu_ctx(CPUState *cs, QemuSDECpu *sde_cpu, bool critical)
+{
+    CPUARMState *env = &ARM_CPU(cs)->env;
+    QemuSDECpuCtx *ctx = &sde_cpu->ctx[critical ? 1 : 0];
+
+    memcpy(ctx->xregs, env->xregs, sizeof(ctx->xregs));
+    ctx->pc = env->pc;
+    ctx->pstate = pstate_read(env);
+}
+
+static void sde_restore_cpu_ctx(QemuSDEState *s, CPUState *cs, bool critical)
+{
+    CPUARMState *env = &ARM_CPU(cs)->env;
+    QemuSDECpu *sde_cpu = get_sde_cpu(s, cs);
+    QemuSDECpuCtx *ctx = &sde_cpu->ctx[critical ? 1 : 0];
+
+    /*
+     * TODO: we need to optimize to only restore affected registers by calling
+     * ioctl individialy
+     */
+    kvm_arch_get_registers(cs);
+
+    env->aarch64 = ((ctx->pstate & PSTATE_nRW) == 0);
+    memcpy(env->xregs, ctx->xregs, sizeof(ctx->xregs));
+    env->pc = ctx->pc;
+    pstate_write(env, ctx->pstate);
+    aarch64_restore_sp(env, (env->pstate >> 2) & 3);
+}
+
+static void sde_restore_cpu_ctx_for_resume(QemuSDEState *s,
+                                           CPUState *cs,
+                                           bool critical,
+                                           uint64_t resume_addr)
+{
+    CPUARMState *env = &ARM_CPU(cs)->env;
+    QemuSDECpu *sde_cpu = get_sde_cpu(s, cs);
+    QemuSDECpuCtx *ctx = &sde_cpu->ctx[critical ? 1 : 0];
+
+    /*
+     * TODO: we need to optimize to only restore affected registers by calling
+     * ioctl individialy
+     */
+    kvm_arch_get_registers(cs);
+
+    memcpy(env->xregs, ctx->xregs, sizeof(ctx->xregs));
+    env->pc = resume_addr;
+    env->aarch64 = 1;
+    /* Constructe pstate in pstate_read() */
+    env->daif = 0xF << 6;
+    /* Clear nRW/M[4] and M[3:0] */
+    env->pstate &= ~0x1F;
+    /* Set exception mode to EL1h */
+    env->pstate |= PSTATE_MODE_EL1h;
+    env->elr_el[1] = ctx->pc;
+    env->banked_spsr[KVM_SPSR_EL1 + 1] = ctx->pstate;
+    aarch64_restore_sp(env, 1);
+}
+
+static void sde_build_cpu_ctx(CPUState *cs, QemuSDECpu *sde_cpu, QemuSDE *sde)
+{
+    CPUARMState *env = &ARM_CPU(cs)->env;
+
+    env->xregs[0] = sde->prop->event_id;
+    env->xregs[1] = sde->ep_argument;
+    env->xregs[2] = env->pc;
+    env->xregs[3] = pstate_read(env);
+    env->pc = sde->ep_address;
+    env->aarch64 = 1;
+    /* Constructe pstate in pstate_read() */
+    env->daif = 0xF << 6;
+    /* Clear nRW/M[4] and M[3:0] */
+    env->pstate &= ~0x1F;
+    /* Set exception mode to EL1h */
+    env->pstate |= PSTATE_MODE_EL1h;
+    aarch64_restore_sp(env, 1);
+}
+
+static void trigger_sde(CPUState *cs, run_on_cpu_data data)
+{
+    QemuSDEState *s = sde_state;
+    QemuSDECpu *sde_cpu = get_sde_cpu(s, cs);
+    int32_t event = data.host_int;
+    QemuSDE *sde;
+
+    assert(cs == current_cpu);
+
+    if (sde_cpu->masked || sde_cpu->critical_running_event >= 0) {
+        return;
+    }
+
+    sde = get_sde_no_check(s, event, cs);
+    if (sde->event_id == SDEI_INVALID_EVENT_ID) {
+        /* Some race condition happens! */
+        put_sde(sde, cs);
+        return;
+    }
+
+    if (sde_cpu->normal_running_event >= 0 && !sde->prop->is_critical) {
+        put_sde(sde, cs);
+        return;
+    }
+
+    if (!sde->enabled || !sde->pending || sde->running) {
+        /* Some race condition happens! */
+        put_sde(sde, cs);
+        return;
+    }
+
+    sde->pending = false;
+    sde->running = true;
+
+    if (sde->prop->is_critical) {
+        sde_cpu->critical_running_event = sde->prop->event_id;
+    } else {
+        sde_cpu->normal_running_event = sde->prop->event_id;
+    }
+
+    kvm_arch_get_registers(cs);
+    sde_save_cpu_ctx(cs, sde_cpu, sde->prop->is_critical);
+    sde_build_cpu_ctx(cs, sde_cpu, sde);
+    kvm_arch_put_registers(cs, 1);
+    put_sde(sde, cs);
+}
+
+static int64_t dispatch_single(QemuSDEState *s, QemuSDE *sde, CPUState *cs)
+{
+    int32_t event = sde->prop->event_id;
+    bool pending = sde->pending;
+    bool enabled = sde->enabled;
+    CPUState *target = sde->target_cpu;
+    put_sde(sde, cs);
+
+    if (pending && enabled) {
+        /*
+         * TODO: we need to find a free-unmasked PE to trigger for shared
+         * unpinned event
+         */
+        async_run_on_cpu(target, trigger_sde,
+                         RUN_ON_CPU_HOST_INT(event));
+    }
+    return SDEI_SUCCESS;
+}
+
+static void dispatch_cpu(QemuSDEState *s, CPUState *cs, bool is_critical)
+{
+    QemuSDE *sde;
+    int i;
+
+    for (i = 0; i < PRIVATE_SLOT_COUNT + SHARED_SLOT_COUNT; i++) {
+        sde = get_sde_no_check(s, i, cs);
+        if (sde->event_id == SDEI_INVALID_EVENT_ID) {
+            put_sde(sde, cs);
+            continue;
+        }
+        if (sde->prop->is_critical != is_critical) {
+            put_sde(sde, cs);
+            continue;
+        }
+        if (!sde->enabled || !sde->pending || sde->running ||
+            sde->target_cpu != cs) {
+            put_sde(sde, cs);
+            continue;
+        }
+
+        dispatch_single(s, sde, cs);
+    }
+}
+
+static int32_t sdei_alloc_event_num(QemuSDEState *s, bool is_critical,
+                                    bool is_shared, int intid)
+{
+    int index;
+    int start = 0;
+    int count = PRIVATE_SLOT_COUNT;
+    int32_t event;
+    QemuSDEProp *sde_props = s->sde_props_state;
+
+    if (is_shared) {
+        start = PRIVATE_SLOT_COUNT;
+        count = PRIVATE_SLOT_COUNT + SHARED_SLOT_COUNT;
+    }
+
+    qemu_mutex_lock(&s->sdei_interrupt_bind_lock);
+    for (index = start; index < count; index++) {
+        qemu_mutex_lock(&sde_props[index].lock);
+        if (sde_props[index].interrupt == intid) {
+            event = sde_props[index].event_id;
+            qemu_mutex_unlock(&sde_props[index].lock);
+            qemu_mutex_unlock(&s->sdei_interrupt_bind_lock);
+            return event;
+        }
+        qemu_mutex_unlock(&sde_props[index].lock);
+    }
+
+    for (index = start; index < count; index++) {
+        qemu_mutex_lock(&sde_props[index].lock);
+        if (sde_props[index].event_id < 0) {
+            event = sde_props[index].event_id = 0x40000000 | index;
+            sde_props[index].interrupt = intid;
+            sde_props[index].is_shared = is_shared;
+            sde_props[index].is_critical = is_critical;
+            s->irq_map[intid] = event;
+            qemu_mutex_unlock(&sde_props[index].lock);
+            qemu_mutex_unlock(&s->sdei_interrupt_bind_lock);
+            return event;
+        }
+        qemu_mutex_unlock(&sde_props[index].lock);
+    }
+    qemu_mutex_unlock(&s->sdei_interrupt_bind_lock);
+    return SDEI_OUT_OF_RESOURCE;
+}
+
+static int32_t sdei_free_event_num_locked(QemuSDEState *s, QemuSDEProp *prop)
+{
+    int32_t ret = SDEI_SUCCESS;
+    if (atomic_read(&prop->refcount) > 0) {
+        ret = SDEI_DENIED;
+        goto unlock_return;
+    }
+
+    s->irq_map[prop->interrupt] = SDEI_INVALID_EVENT_ID;
+    prop->event_id = SDEI_INVALID_EVENT_ID;
+    prop->interrupt = SDEI_INVALID_INTERRUPT;
+
+unlock_return:
+    qemu_mutex_unlock(&prop->lock);
+    qemu_mutex_unlock(&s->sdei_interrupt_bind_lock);
+    return ret;
+}
+
+typedef int64_t (*sdei_single_function)(QemuSDEState *s,
+                                        CPUState *cs,
+                                        struct kvm_run *run);
+
+static int64_t sdei_version(QemuSDEState *s, CPUState *cs, struct kvm_run *run)
+{
+    return (1ULL << SDEI_VERSION_MAJOR_SHIFT) |
+           (0ULL << SDEI_VERSION_MINOR_SHIFT);
+}
+
+static int64_t unregister_single_sde(QemuSDEState *s, int32_t event,
+                                     CPUState *cs, bool force)
+{
+    QemuSDE     *sde;
+    QemuSDEProp *prop;
+    int         ret = 0;
+
+    prop = get_sde_prop(s, event);
+    if (!prop) {
+        return SDEI_INVALID_PARAMETERS;
+    }
+
+    sde = get_sde_no_check(s, event, cs);
+    if (sde->event_id == SDEI_INVALID_EVENT_ID) {
+        put_sde(sde, cs);
+        put_sde_prop(prop);
+        return SDEI_DENIED;
+    }
+
+    if (sde->running && !force) {
+        sde->unregister_pending = true;
+        ret = SDEI_PENDING;
+    } else {
+        atomic_dec(&prop->refcount);
+        sde->event_id = SDEI_INVALID_EVENT_ID;
+        sde->enabled = false;
+        sde->running = false;
+        sde->pending = false;
+        sde->unregister_pending = false;
+    }
+    put_sde(sde, cs);
+    put_sde_prop(prop);
+    return ret;
+}
+
+static int64_t sdei_private_reset_common(QemuSDEState *s, CPUState *cs,
+                                         bool force)
+{
+    int64_t ret = SDEI_SUCCESS;
+    int i;
+
+    for (i = 0; i < PRIVATE_SLOT_COUNT; i++) {
+        int64_t ret1;
+        ret1 = unregister_single_sde(s, i, cs, force);
+        /* Ignore other return values in reset interface */
+        if (ret1 == SDEI_PENDING) {
+            ret = SDEI_DENIED;
+        }
+    }
+
+    return ret;
+}
+
+static int64_t sdei_shared_reset_common(QemuSDEState *s, CPUState *cs,
+                                        bool force)
+{
+    int             i;
+    QemuSDEProp     *prop;
+    int32_t         start_event = PRIVATE_SLOT_COUNT;
+    int64_t         ret = SDEI_SUCCESS;
+
+    for (i = start_event; i < PRIVATE_SLOT_COUNT + SHARED_SLOT_COUNT; i++) {
+        int64_t ret1 = unregister_single_sde(s, i, cs, force);
+        /* Ignore other return values in reset interface */
+        if (ret1 == SDEI_PENDING) {
+            ret = SDEI_DENIED;
+        }
+    }
+    if (ret) {
+        return ret;
+    }
+
+    for (i = 0; i < PRIVATE_SLOT_COUNT + SHARED_SLOT_COUNT; i++) {
+        qemu_mutex_lock(&s->sdei_interrupt_bind_lock);
+        prop = get_sde_prop(s, i);
+        if (!prop || prop->interrupt == SDEI_INVALID_INTERRUPT) {
+            if (prop) {
+                put_sde_prop(prop);
+            }
+            qemu_mutex_unlock(&s->sdei_interrupt_bind_lock);
+            continue;
+        }
+        ret |= sdei_free_event_num_locked(s, prop);
+    }
+
+    return ret ? SDEI_DENIED : SDEI_SUCCESS;
+}
+
+
+static int64_t sdei_event_register(QemuSDEState *s, CPUState *cs,
+                                   struct kvm_run *run)
+{
+    QemuSDE *sde;
+    QemuSDEProp *prop;
+    CPUState *target = cs;
+    uint64_t *args = (uint64_t *)run->hypercall.args;
+    int32_t event = args[1];
+    uint64_t rm_mode = SDEI_EVENT_REGISTER_RM_PE;
+
+    prop = get_sde_prop(s, event);
+    if (!prop) {
+        return SDEI_INVALID_PARAMETERS;
+    }
+
+    sde = get_sde_no_check(s, event, cs);
+    if (sde->event_id != SDEI_INVALID_EVENT_ID) {
+        put_sde(sde, cs);
+        put_sde_prop(prop);
+        return SDEI_DENIED;
+    }
+
+    if (prop->is_shared) {
+        rm_mode = args[4] & 1ULL;
+        if (rm_mode == SDEI_EVENT_REGISTER_RM_PE) {
+            target = arm_get_cpu_by_id(args[5]);
+            if (!target) {
+                put_sde_prop(prop);
+                return SDEI_INVALID_PARAMETERS;
+            }
+        }
+    }
+
+    sde->target_cpu = target;
+    sde->ep_address = args[2];
+    sde->ep_argument = args[3];
+    sde->prop = prop;
+    sde->routing_mode = rm_mode;
+    sde->event_id = prop->event_id;
+
+    put_sde(sde, cs);
+    atomic_inc(&prop->refcount);
+    put_sde_prop(prop);
+
+    return SDEI_SUCCESS;
+}
+
+static int64_t sdei_event_enable(QemuSDEState *s, CPUState *cs,
+                                 struct kvm_run *run)
+{
+    QemuSDE *sde;
+    uint64_t *args = (uint64_t *)(run->hypercall.args);
+    int32_t event = args[1];
+
+    if (!is_valid_event_number(event)) {
+        return SDEI_INVALID_PARAMETERS;
+    }
+    sde = get_sde_no_check(s, event, cs);
+    if (sde->event_id == SDEI_INVALID_EVENT_ID) {
+        put_sde(sde, cs);
+        return SDEI_INVALID_PARAMETERS;
+    }
+
+    sde->enabled = true;
+    return dispatch_single(s, sde, cs);
+}
+
+static int64_t sdei_event_disable(QemuSDEState *s, CPUState *cs,
+                                  struct kvm_run *run)
+{
+    QemuSDE *sde;
+    uint64_t *args = (uint64_t *)run->hypercall.args;
+    int32_t event = args[1];
+
+    if (!is_valid_event_number(event)) {
+        return SDEI_INVALID_PARAMETERS;
+    }
+    sde = get_sde_no_check(s, event, cs);
+    if (sde->event_id == SDEI_INVALID_EVENT_ID) {
+        put_sde(sde, cs);
+        return SDEI_INVALID_PARAMETERS;
+    }
+
+    sde->enabled = false;
+    put_sde(sde, cs);
+    return SDEI_SUCCESS;
+}
+
+static int64_t sdei_event_context(QemuSDEState *s, CPUState *cs,
+                                  struct kvm_run *run)
+{
+    QemuSDECpu *sde_cpu = get_sde_cpu(s, cs);
+    uint64_t *args = (uint64_t *)(run->hypercall.args);
+    uint32_t param_id = args[1];
+    int critical;
+    QemuSDECpuCtx *ctx;
+
+    if (param_id >= SDEI_PARAM_MAX) {
+        return SDEI_INVALID_PARAMETERS;
+    }
+
+    if (sde_cpu->critical_running_event >= 0) {
+        critical = 1;
+    } else if (sde_cpu->normal_running_event >= 0) {
+        critical = 0;
+    } else {
+        return SDEI_DENIED;
+    }
+
+    ctx = &sde_cpu->ctx[critical];
+    return ctx->xregs[param_id];
+}
+
+static int64_t sdei_event_complete(QemuSDEState *s, CPUState *cs,
+                                   struct kvm_run *run)
+{
+    QemuSDE *sde;
+    QemuSDECpu *cpu = get_sde_cpu(s, cs);
+    int32_t event;
+    uint64_t *args = (uint64_t *)(run->hypercall.args);
+    bool is_critical;
+
+    event = get_running_sde(s, cs);
+    if (event < 0) {
+        return SDEI_DENIED;
+    }
+
+    assert(is_valid_event_number(event));
+    sde = get_sde_no_check(s, event, cs);
+    assert(sde->event_id != SDEI_INVALID_EVENT_ID);
+
+    sde->running = false;
+    is_critical = sde->prop->is_critical;
+    if (sde->unregister_pending) {
+        atomic_dec(&sde->prop->refcount);
+        sde->event_id = SDEI_INVALID_EVENT_ID;
+        sde->unregister_pending = false;
+    }
+    put_sde(sde, cs);
+
+    sde_restore_cpu_ctx(s, cs, is_critical);
+
+    kvm_arch_put_registers(cs, 1);
+    override_return_value(cs, args);
+    if (cpu->critical_running_event >= 0) {
+        cpu->critical_running_event = SDEI_INVALID_EVENT_ID;
+    } else {
+        cpu->normal_running_event = SDEI_INVALID_EVENT_ID;
+    }
+
+    /* TODO: we should not queue more than one sde in work queue */
+    dispatch_cpu(s, cs, true);
+    if (cpu->critical_running_event < 0 && cpu->normal_running_event < 0) {
+        dispatch_cpu(s, cs, false);
+    }
+    return args[0];
+}
+
+static int64_t sdei_event_complete_and_resume(QemuSDEState *s, CPUState *cs,
+                                              struct kvm_run *run)
+{
+    QemuSDE *sde;
+    QemuSDECpu *cpu = get_sde_cpu(s, cs);
+    int32_t event;
+    uint64_t *args = (uint64_t *)(run->hypercall.args);
+    bool is_critical;
+    uint64_t resume_addr = args[1];
+
+    event = get_running_sde(s, cs);
+    if (event < 0) {
+        return SDEI_DENIED;
+    }
+
+    assert(is_valid_event_number(event));
+    sde = get_sde_no_check(s, event, cs);
+    assert(sde->event_id != SDEI_INVALID_EVENT_ID);
+
+    sde->running = false;
+    is_critical = sde->prop->is_critical;
+
+    if (sde->unregister_pending) {
+        atomic_dec(&sde->prop->refcount);
+        sde->event_id = SDEI_INVALID_EVENT_ID;
+        sde->unregister_pending = false;
+    }
+    put_sde(sde, cs);
+
+    sde_restore_cpu_ctx_for_resume(s, cs, is_critical, resume_addr);
+    kvm_arch_put_registers(cs, 1);
+
+    override_return_value(cs, args);
+    if (cpu->critical_running_event >= 0) {
+        cpu->critical_running_event = SDEI_INVALID_EVENT_ID;
+    } else {
+        cpu->normal_running_event = SDEI_INVALID_EVENT_ID;
+    }
+
+    dispatch_cpu(s, cs, true);
+    if (cpu->critical_running_event < 0 && cpu->normal_running_event < 0) {
+        dispatch_cpu(s, cs, false);
+    }
+    return args[0];
+}
+
+static int64_t sdei_event_unregister(QemuSDEState *s, CPUState *cs,
+                                     struct kvm_run *run)
+{
+    uint64_t        *args = (uint64_t *)(run->hypercall.args);
+    int32_t         event = args[1];
+
+    return unregister_single_sde(s, event, cs, false);
+}
+
+static int64_t sdei_event_status(QemuSDEState *s, CPUState *cs,
+                                 struct kvm_run *run)
+{
+    QemuSDE *sde;
+    uint64_t *args = (uint64_t *)(run->hypercall.args);
+    int32_t event = args[1];
+    int64_t status = 0;
+
+    if (!is_valid_event(s, event)) {
+        return SDEI_INVALID_PARAMETERS;
+    }
+
+    sde = get_sde_no_check(s, event, cs);
+    if (sde->event_id == SDEI_INVALID_EVENT_ID) {
+        put_sde(sde, cs);
+        return status;
+    }
+
+    status |= SDEI_EVENT_STATUS_REGISTERED;
+    if (sde->enabled) {
+        status |= SDEI_EVENT_STATUS_ENABLED;
+    }
+    if (sde->running) {
+        status |= SDEI_EVENT_STATUS_RUNNING;
+    }
+    put_sde(sde, cs);
+    return status;
+}
+
+static int64_t sdei_event_get_info(QemuSDEState *s, CPUState *cs,
+                                   struct kvm_run *run)
+{
+    QemuSDEProp *prop;
+    QemuSDE *sde;
+    uint64_t *args = (uint64_t *)(run->hypercall.args);
+    int32_t event = args[1];
+    uint32_t info = args[2];
+    int64_t ret;
+
+    if (info > SDEI_EVENT_INFO_EV_ROUTING_AFF) {
+        return SDEI_INVALID_PARAMETERS;
+    }
+
+    prop = get_sde_prop(s, event);
+    if (!prop) {
+        return SDEI_INVALID_PARAMETERS;
+    }
+
+    switch (info) {
+    case SDEI_EVENT_INFO_EV_TYPE:
+        ret = prop->is_shared;
+        break;
+    case SDEI_EVENT_INFO_EV_SIGNALED:
+        ret = (event == SDEI_STD_EVT_SOFTWARE_SIGNAL) ? 1 : 0;
+        break;
+    case SDEI_EVENT_INFO_EV_PRIORITY:
+        ret = prop->is_critical;
+        break;
+    case SDEI_EVENT_INFO_EV_ROUTING_MODE:
+    case SDEI_EVENT_INFO_EV_ROUTING_AFF:
+        ret = SDEI_INVALID_PARAMETERS;
+        if (!prop->is_shared) {
+            break;
+        }
+        sde = get_sde_no_check(s, event, cs);
+        if (sde->event_id == SDEI_INVALID_EVENT_ID) {
+            put_sde(sde, cs);
+            ret = SDEI_DENIED;
+            break;
+        }
+        if (info == SDEI_EVENT_INFO_EV_ROUTING_MODE) {
+            ret = sde->routing_mode;
+        } else if (sde->routing_mode == SDEI_EVENT_REGISTER_RM_PE) {
+            ret = ARM_CPU(sde->target_cpu)->mp_affinity;
+        }
+        put_sde(sde, cs);
+        break;
+    default:
+        ret = SDEI_NOT_SUPPORTED;
+    }
+    put_sde_prop(prop);
+    return ret;
+}
+
+static int64_t sdei_event_routing_set(QemuSDEState *s, CPUState *cs,
+                                      struct kvm_run *run)
+{
+    QemuSDE *sde;
+    CPUState *target = cs;
+    uint64_t *args = (uint64_t *)run->hypercall.args;
+    int32_t event = args[1];
+    uint64_t mode = args[2];
+    uint64_t affinity = args[3];
+
+    if (mode & ~1ULL) {
+        return SDEI_INVALID_PARAMETERS;
+    }
+    if (mode == SDEI_EVENT_REGISTER_RM_PE) {
+        target = arm_get_cpu_by_id(affinity);
+        if (!target) {
+            return SDEI_INVALID_PARAMETERS;
+        }
+    }
+
+    if (!is_valid_event(s, event) || !SDEI_IS_SHARED_EVENT(event)) {
+        return SDEI_INVALID_PARAMETERS;
+    }
+
+    sde = get_sde_no_check(s, event, cs);
+    if (sde->event_id == SDEI_INVALID_EVENT_ID) {
+        put_sde(sde, cs);
+        return SDEI_DENIED;
+    }
+    if (sde->enabled || sde->running ||
+        sde->pending || sde->unregister_pending) {
+        put_sde(sde, cs);
+        return SDEI_DENIED;
+    }
+
+    sde->target_cpu = target;
+    sde->routing_mode = mode;
+    put_sde(sde, cs);
+
+    return SDEI_SUCCESS;
+}
+
+static int64_t sdei_event_pe_mask(QemuSDEState *s, CPUState *cs,
+                                  struct kvm_run *run)
+{
+    QemuSDECpu *sde_cpu;
+
+    sde_cpu = get_sde_cpu(s, cs);
+    if (sde_cpu->masked) {
+        return 0;
+    }
+    sde_cpu->masked = true;
+    return 1;
+}
+
+static int64_t sdei_event_pe_unmask(QemuSDEState *s, CPUState *cs,
+                                    struct kvm_run *run)
+{
+    QemuSDECpu *sde_cpu;
+
+    sde_cpu = get_sde_cpu(s, cs);
+    sde_cpu->masked = false;
+    dispatch_cpu(s, cs, true);
+    dispatch_cpu(s, cs, false);
+    return SDEI_SUCCESS;
+}
+
+static int64_t sdei_event_interrupt_bind(QemuSDEState *s, CPUState *cs,
+                                         struct kvm_run *run)
+{
+    uint64_t *args = (uint64_t *)(run->hypercall.args);
+    uint32_t intid = args[1];
+
+    if (intid < GIC_NR_SGIS || intid >= GIC_MAXIRQ) {
+        return SDEI_INVALID_PARAMETERS;
+    }
+    return sdei_alloc_event_num(s, false, intid >= 32, intid);
+}
+
+static int64_t sdei_event_interrupt_release(QemuSDEState *s, CPUState *cs,
+                                            struct kvm_run *run)
+{
+    QemuSDEProp *prop;
+    uint64_t *args = (uint64_t *)(run->hypercall.args);
+    int32_t event = args[1];
+
+    qemu_mutex_lock(&s->sdei_interrupt_bind_lock);
+    prop = get_sde_prop(s, event);
+    if (!prop) {
+        qemu_mutex_unlock(&s->sdei_interrupt_bind_lock);
+        return SDEI_INVALID_PARAMETERS;
+    }
+
+    return sdei_free_event_num_locked(s, prop);
+}
+
+static int64_t sdei_event_signal(QemuSDEState *s, CPUState *cs,
+                                 struct kvm_run *run)
+{
+    QemuSDE *sde;
+    CPUState *target_cpu;
+    uint64_t *args = (uint64_t *)(run->hypercall.args);
+    int32_t event = args[1];
+
+    if (event != SDEI_STD_EVT_SOFTWARE_SIGNAL) {
+        return SDEI_INVALID_PARAMETERS;
+    }
+
+    target_cpu = arm_get_cpu_by_id(args[2]);
+    if (!target_cpu) {
+        return SDEI_INVALID_PARAMETERS;
+    }
+
+    sde = get_sde_no_check(s, event, target_cpu);
+    if (sde->event_id == SDEI_INVALID_EVENT_ID) {
+        put_sde(sde, cs);
+        return SDEI_INVALID_PARAMETERS;
+    }
+
+    sde->pending = true;
+    return dispatch_single(s, sde, target_cpu);
+}
+
+static int64_t sdei_features(QemuSDEState *s, CPUState *cs, struct kvm_run *run)
+{
+    uint64_t *args = (uint64_t *)(run->hypercall.args);
+    uint32_t feature = args[1];
+
+    switch (feature) {
+    case SDEI_FEATURE_BIND_SLOTS:
+        return ((SHARED_SLOT_COUNT - PLAT_SHARED_SLOT_COUNT) << 16) |
+               (PRIVATE_SLOT_COUNT - PLAT_PRIVATE_SLOT_COUNT);
+    default:
+        return SDEI_INVALID_PARAMETERS;
+    }
+}
+
+static int64_t sdei_private_reset(QemuSDEState *s, CPUState *cs,
+                                  struct kvm_run *run)
+{
+    return sdei_private_reset_common(s, cs, false);
+}
+
+static int64_t sdei_shared_reset(QemuSDEState *s, CPUState *cs,
+                                 struct kvm_run *run)
+{
+    return sdei_shared_reset_common(s, cs, false);
+}
+
+static sdei_single_function sdei_functions[] = {
+    sdei_version,
+    sdei_event_register,
+    sdei_event_enable,
+    sdei_event_disable,
+    sdei_event_context,
+    sdei_event_complete,
+    sdei_event_complete_and_resume,
+    sdei_event_unregister,
+    sdei_event_status,
+    sdei_event_get_info,
+    sdei_event_routing_set,
+    sdei_event_pe_mask,
+    sdei_event_pe_unmask,
+    sdei_event_interrupt_bind,
+    sdei_event_interrupt_release,
+    sdei_event_signal,
+    sdei_features,
+    sdei_private_reset,
+    sdei_shared_reset,
+};
+
+void sdei_handle_request(CPUState *cs, struct kvm_run *run)
+{
+    uint32_t func_id = run->hypercall.args[0];
+
+    if (!sde_state) {
+        run->hypercall.args[0] = SDEI_NOT_SUPPORTED;
+        return;
+    }
+
+    if (func_id < SDEI_1_0_FN_BASE || func_id > SDEI_MAX_REQ) {
+        error_report("Invalid SDEI function ID: 0x%x", func_id);
+        run->hypercall.args[0] = SDEI_INVALID_PARAMETERS;
+        return;
+    }
+
+    func_id -= SDEI_1_0_FN_BASE;
+    if (func_id < ARRAY_SIZE(sdei_functions) && sdei_functions[func_id]) {
+        run->hypercall.args[0] = sdei_functions[func_id](sde_state, cs, run);
+    } else {
+        run->hypercall.args[0] = SDEI_NOT_SUPPORTED;
+    }
+}
+
 static void qemu_shared_sde_init(QemuSDEState *s)
 {
     int i;
diff --git a/target/arm/sdei.h b/target/arm/sdei.h
new file mode 100644
index 0000000..a69a0e4
--- /dev/null
+++ b/target/arm/sdei.h
@@ -0,0 +1,34 @@
+/*
+ * ARM SDEI emulation external interfaces
+ *
+ * Copyright (c) 2019 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * Authors:
+ *    Heyi Guo <guoheyi@huawei.com>
+ *    Jingyi Wang <wangjingyi11@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef QEMU_SDEI_H
+#define QEMU_SDEI_H
+
+#include <linux/kvm.h>
+#include <linux/arm_sdei.h>
+#include "hw/core/cpu.h"
+
+#define SDEI_MAX_REQ        SDEI_1_0_FN(0x12)
+
+void sdei_handle_request(CPUState *cs, struct kvm_run *run);
+
+#endif
-- 
1.8.3.1


