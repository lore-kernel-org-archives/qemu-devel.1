Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DDCC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4539E214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4539E214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCn4h-0000jq-LQ
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iCmfD-0001Pg-Iz
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iCmf9-0006m1-Dd
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:23:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2241 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iCmf0-0006fu-KG; Tue, 24 Sep 2019 11:23:27 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 5AF7A2C1E6C1AC4F4F26;
 Tue, 24 Sep 2019 23:23:22 +0800 (CST)
Received: from linux-Bxxcye.huawei.com (10.175.104.222) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 24 Sep 2019 23:23:15 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>,
 <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [RFC PATCH 02/12] arm/sdei: add virtual device framework
Date: Tue, 24 Sep 2019 23:21:41 +0800
Message-ID: <1569338511-3572-3-git-send-email-guoheyi@huawei.com>
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

SDEI is useful to emulate NMI on arm64 platforms. To support SDEI in
virtual machine with KVM enabled, we choose to implement SDEI
interfaces in qemu. It is targeted for KVM mode only, for the full
user space emulation can also emulate secure world and have ARM
Trusted Firmware to run on emulated EL3.

- We create a logical SDEI device to hold the states of SDEI services,
  to support VM migration.
- Only one SDEI virtual device is allowed in the whole VM to provide
  SDEI services.
- We create struct QemuSDE to hold states of each SDEI event, and
  private events with the same ID on different CPUs have their own
  QemuSDE instance.
- We create struct QemuSDEProp to hold properties of each SDEI event,
  so all private instances with the same ID will pointed to the same
  QemuSDEProp.
- We create struct QemuSDECpu to hold CPU/PE states, including the
  interrupted CPU context.
- Slot numbers for private and shared event are fixed, for guests
  cannot request more interrupt binds than BIND_SLOTS in SDEI_FEATURES
  call.
- The first PRIVATE_SLOT_COUNT slots in property array are for private
  events, and the next SHARED_SLOT_COUNT slots are for shared events.
- We use property slot index as lower bit for each allocated event
  number, so that we can get property easily from valid input event
  number, as well as the QemuSDE instance.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 target/arm/Makefile.objs |   1 +
 target/arm/sdei.c        | 351 +++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/sdei_int.h    | 106 ++++++++++++++
 3 files changed, 458 insertions(+)
 create mode 100644 target/arm/sdei.c
 create mode 100644 target/arm/sdei_int.h

diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index cf26c16..674109d 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -7,6 +7,7 @@ obj-$(CONFIG_SOFTMMU) += machine.o arch_dump.o monitor.o
 obj-$(CONFIG_SOFTMMU) += arm-powerctl.o
 
 obj-$(CONFIG_KVM) += kvm.o
+obj-$(CONFIG_KVM) += sdei.o
 obj-$(call land,$(CONFIG_KVM),$(call lnot,$(TARGET_AARCH64))) += kvm32.o
 obj-$(call land,$(CONFIG_KVM),$(TARGET_AARCH64)) += kvm64.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
diff --git a/target/arm/sdei.c b/target/arm/sdei.c
new file mode 100644
index 0000000..7f12d69
--- /dev/null
+++ b/target/arm/sdei.c
@@ -0,0 +1,351 @@
+/*
+ * ARM SDEI emulation for ARM64 virtual machine with KVM
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
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "arm-powerctl.h"
+#include "qemu/timer.h"
+#include "sysemu/kvm.h"
+#include "sysemu/kvm_int.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/reset.h"
+#include "qemu/error-report.h"
+#include "sdei_int.h"
+#include "internals.h"
+#include "hw/boards.h"
+#include "hw/intc/arm_gicv3.h"
+#include "hw/intc/arm_gic.h"
+#include "hw/irq.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "qom/object.h"
+
+#define TYPE_QEMU_SDEI "qemu_sdei"
+#define QEMU_SDEI(obj) OBJECT_CHECK(QemuSDEState, (obj), TYPE_QEMU_SDEI)
+
+static QemuSDEState *sde_state;
+
+static void qemu_sde_prop_init(QemuSDEState *s)
+{
+    QemuSDEProp *sde_props = s->sde_props_state;
+    int i;
+    for (i = 0; i < ARRAY_SIZE(s->sde_props_state); i++) {
+        sde_props[i].event_id = SDEI_INVALID_EVENT_ID;
+        sde_props[i].interrupt = SDEI_INVALID_INTERRUPT;
+        sde_props[i].sde_index = i >= PRIVATE_SLOT_COUNT ?
+                                 i - PRIVATE_SLOT_COUNT : i;
+
+        qemu_mutex_init(&(sde_props[i].lock));
+        sde_props[i].refcount = 0;
+    }
+    sde_props[0].event_id = SDEI_STD_EVT_SOFTWARE_SIGNAL;
+    sde_props[0].interrupt = SDEI_INVALID_INTERRUPT;
+    sde_props[0].is_shared = false;
+    sde_props[0].is_critical = false;
+
+    for (i = 0; i < ARRAY_SIZE(s->irq_map); i++) {
+        s->irq_map[i] = SDEI_INVALID_EVENT_ID;
+    }
+
+    qemu_mutex_init(&s->sdei_interrupt_bind_lock);
+}
+
+static void qemu_sde_cpu_init(QemuSDEState *s)
+{
+    int i;
+    QemuSDECpu *sde_cpus;
+
+    s->sdei_max_cpus = current_machine->smp.max_cpus;
+    s->sde_cpus = g_new0(QemuSDECpu, s->sdei_max_cpus);
+    sde_cpus = s->sde_cpus;
+    for (i = 0; i < s->sdei_max_cpus; i++) {
+        sde_cpus[i].masked = true;
+        sde_cpus[i].critical_running_event = SDEI_INVALID_EVENT_ID;
+        sde_cpus[i].normal_running_event = SDEI_INVALID_EVENT_ID;
+    }
+}
+
+static bool is_valid_event_number(int32_t event)
+{
+    int32_t slot_id;
+
+    if (event < 0 || (event & 0x3F000000)) {
+        return false;
+    }
+
+    slot_id = SDEI_EVENT_TO_SLOT(event);
+    if (slot_id >= PRIVATE_SLOT_COUNT + SHARED_SLOT_COUNT) {
+        return false;
+    }
+
+    return true;
+}
+
+static bool is_valid_event(QemuSDEState *s, int32_t event)
+{
+    if (!is_valid_event_number(event)) {
+        return false;
+    }
+
+    if (s->sde_props_state[SDEI_EVENT_TO_SLOT(event)].event_id != event) {
+        return false;
+    }
+
+    return true;
+}
+
+static QemuSDEProp *get_sde_prop_no_lock(QemuSDEState *s, int32_t event)
+{
+    if (!is_valid_event(s, event)) {
+        return NULL;
+    }
+
+    return &s->sde_props_state[SDEI_EVENT_TO_SLOT(event)];
+}
+
+static void qemu_shared_sde_init(QemuSDEState *s)
+{
+    int i;
+    for (i = 0; i < SHARED_SLOT_COUNT; i++) {
+        QemuSDE *sde;
+        sde = s->shared_sde_array[i];
+        if (!sde) {
+            sde = g_new0(QemuSDE, 1);
+        }
+        sde->event_id = SDEI_INVALID_EVENT_ID;
+        sde->enabled = false;
+        sde->running = false;
+        sde->pending = false;
+        sde->unregister_pending = false;
+        qemu_mutex_init(&sde->lock);
+        s->shared_sde_array[i] = sde;
+    }
+}
+
+static void qemu_private_sde_init(QemuSDEState *s)
+{
+    int i, j;
+    for (i = 0; i < s->sdei_max_cpus; i++) {
+        QemuSDE **array = s->sde_cpus[i].private_sde_array;
+        for (j = 0; j < PRIVATE_SLOT_COUNT; j++) {
+            QemuSDE *sde;
+            sde = array[j];
+            if (!sde) {
+                sde = g_new0(QemuSDE, 1);
+            }
+            sde->event_id = SDEI_INVALID_EVENT_ID;
+            sde->enabled = false;
+            sde->running = false;
+            sde->pending = false;
+            sde->unregister_pending = false;
+            qemu_mutex_init(&sde->lock);
+            array[j] = sde;
+        }
+    }
+}
+
+static void qemu_sde_init(QemuSDEState *s)
+{
+    qemu_sde_prop_init(s);
+    qemu_sde_cpu_init(s);
+
+    qemu_shared_sde_init(s);
+    qemu_private_sde_init(s);
+}
+
+static int qemu_sdei_pre_save(void *opaque)
+{
+    QemuSDEState *s = opaque;
+    QemuSDE **array;
+    int i, j;
+
+    for (i = 0; i < s->sdei_max_cpus; i++) {
+        array = s->sde_cpus[i].private_sde_array;
+        for (j = 0; j < PRIVATE_SLOT_COUNT; j++) {
+            QemuSDE *sde = array[j];
+            if (sde->event_id != SDEI_INVALID_EVENT_ID) {
+                sde->event_id = sde->prop->event_id;
+                sde->cpu_affinity = ARM_CPU(sde->target_cpu)->mp_affinity;
+            }
+        }
+    }
+
+    array = s->shared_sde_array;
+    for (j = 0; j < SHARED_SLOT_COUNT; j++) {
+        QemuSDE *sde = array[j];
+        if (sde->event_id != SDEI_INVALID_EVENT_ID) {
+            sde->event_id = sde->prop->event_id;
+            sde->cpu_affinity = ARM_CPU(sde->target_cpu)->mp_affinity;
+        }
+    }
+
+    return 0;
+}
+
+
+static int qemu_sdei_post_load(void *opaque, int version_id)
+{
+    QemuSDEState *s = opaque;
+    QemuSDEProp *sde_props = s->sde_props_state;
+    QemuSDE **array;
+    int i, j;
+
+    for (i = 0; i < s->sdei_max_cpus; i++) {
+        array = s->sde_cpus[i].private_sde_array;
+        for (j = 0; j < PRIVATE_SLOT_COUNT; j++) {
+            QemuSDE *sde = array[j];
+            if (sde->event_id != SDEI_INVALID_EVENT_ID) {
+                sde->prop = get_sde_prop_no_lock(s, sde->event_id);
+                sde->target_cpu = arm_get_cpu_by_id(sde->cpu_affinity);
+            }
+        }
+    }
+
+    array = s->shared_sde_array;
+    for (j = 0; j < SHARED_SLOT_COUNT; j++) {
+        QemuSDE *sde = array[j];
+        if (sde->event_id != SDEI_INVALID_EVENT_ID) {
+            sde->prop = get_sde_prop_no_lock(s, sde->event_id);
+            sde->target_cpu = arm_get_cpu_by_id(sde->cpu_affinity);
+        }
+    }
+
+    for (i = 0; i < PRIVATE_SLOT_COUNT + SHARED_SLOT_COUNT; i++) {
+        if (sde_props[i].interrupt != SDEI_INVALID_INTERRUPT) {
+            s->irq_map[sde_props[i].interrupt] = sde_props[i].event_id;
+        }
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_sdes = {
+    .name = "qemu_sdei/sdes",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(enabled, QemuSDE),
+        VMSTATE_BOOL(running, QemuSDE),
+        VMSTATE_BOOL(pending, QemuSDE),
+        VMSTATE_BOOL(unregister_pending, QemuSDE),
+        VMSTATE_UINT64(ep_address, QemuSDE),
+        VMSTATE_UINT64(ep_argument, QemuSDE),
+        VMSTATE_UINT64(routing_mode, QemuSDE),
+        VMSTATE_INT32(event_id, QemuSDE),
+        VMSTATE_UINT64(cpu_affinity, QemuSDE),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_sde_props = {
+    .name = "qemu_sdei/sde_props",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_INT32(event_id, QemuSDEProp),
+        VMSTATE_INT32(interrupt, QemuSDEProp),
+        VMSTATE_BOOL(is_shared, QemuSDEProp),
+        VMSTATE_BOOL(is_critical, QemuSDEProp),
+        VMSTATE_INT32(sde_index, QemuSDEProp),
+        VMSTATE_INT32(refcount, QemuSDEProp),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_sde_cpu = {
+    .name = "qemu_sdei/sde_cpu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(private_sde_array, QemuSDECpu,
+                                           PRIVATE_SLOT_COUNT, 1,
+                                           vmstate_sdes, QemuSDE),
+        VMSTATE_UINT64_ARRAY(ctx[0].xregs, QemuSDECpu, 18),
+        VMSTATE_UINT64_ARRAY(ctx[1].xregs, QemuSDECpu, 18),
+        VMSTATE_UINT64(ctx[0].pc, QemuSDECpu),
+        VMSTATE_UINT64(ctx[1].pc, QemuSDECpu),
+        VMSTATE_UINT32(ctx[0].pstate, QemuSDECpu),
+        VMSTATE_UINT32(ctx[1].pstate, QemuSDECpu),
+        VMSTATE_INT32(critical_running_event, QemuSDECpu),
+        VMSTATE_INT32(normal_running_event, QemuSDECpu),
+        VMSTATE_BOOL(masked, QemuSDECpu),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_sde_state = {
+    .name = "qemu_sdei",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .pre_save = qemu_sdei_pre_save,
+    .post_load = qemu_sdei_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT_ARRAY(sde_props_state, QemuSDEState,
+                             PRIVATE_SLOT_COUNT + SHARED_SLOT_COUNT, 1,
+                             vmstate_sde_props, QemuSDEProp),
+        VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(shared_sde_array, QemuSDEState,
+                                           SHARED_SLOT_COUNT, 1,
+                                           vmstate_sdes, QemuSDE),
+        VMSTATE_STRUCT_VARRAY_POINTER_INT32(sde_cpus, QemuSDEState,
+                                            sdei_max_cpus,
+                                            vmstate_sde_cpu, QemuSDECpu),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+
+static void sdei_initfn(Object *obj)
+{
+    QemuSDEState *s = QEMU_SDEI(obj);
+
+    if (sde_state) {
+        error_report("Only one SDEI dispatcher is allowed!");
+        abort();
+    }
+    sde_state = s;
+
+    qemu_sde_init(s);
+}
+
+static void qemu_sde_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "SDEI_QEMU";
+    dc->vmsd = &vmstate_sde_state;
+    dc->user_creatable = true;
+}
+
+static const TypeInfo sde_qemu_info = {
+    .name          = TYPE_QEMU_SDEI,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(QemuSDEState),
+    .instance_init = sdei_initfn,
+    .class_init    = qemu_sde_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&sde_qemu_info);
+}
+
+type_init(register_types);
diff --git a/target/arm/sdei_int.h b/target/arm/sdei_int.h
new file mode 100644
index 0000000..7f69507
--- /dev/null
+++ b/target/arm/sdei_int.h
@@ -0,0 +1,106 @@
+/*
+ * ARM SDEI emulation internal interfaces
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
+#ifndef QEMU_SDEI_INT_H
+#define QEMU_SDEI_INT_H
+
+#include <linux/kvm.h>
+#include <linux/arm_sdei.h>
+#include <asm-arm64/kvm.h>
+#include "hw/intc/arm_gic_common.h"
+#include "qemu/thread.h"
+
+#define SDEI_STD_EVT_SOFTWARE_SIGNAL        0
+#define SDEI_FEATURE_BIND_SLOTS             0
+#define SDEI_PARAM_MAX                      18
+
+#define PRIVATE_SLOT_COUNT                  16
+#define PLAT_PRIVATE_SLOT_COUNT             8
+#define SHARED_SLOT_COUNT                   32
+#define PLAT_SHARED_SLOT_COUNT              16
+#define SDEI_INVALID_INTERRUPT              -1
+#define SDEI_INVALID_EVENT_ID               -1
+
+#define SDEI_EVENT_TO_SLOT(event)           ((event) & 0xFFFFFF)
+#define SDEI_IS_SHARED_EVENT(event)         \
+    (SDEI_EVENT_TO_SLOT(event) >= PRIVATE_SLOT_COUNT)
+
+typedef enum {
+    SDEI_PRIO_NORMAL        = 0,
+    SDEI_PRIO_CRITICAL      = 1,
+} QemuSDEIPriority;
+
+typedef struct QemuSDEProp {
+    QemuMutex       lock;
+    int32_t         event_id;
+    int             interrupt;
+    bool            is_shared;
+    bool            is_critical;
+    /* This is the internal index for private or shared SDE */
+    int             sde_index;
+    int             refcount;
+} QemuSDEProp;
+
+typedef struct QemuSDE {
+    QemuSDEProp     *prop;
+    CPUState        *target_cpu;
+    QemuMutex       lock;
+    bool            enabled;
+    bool            running;
+    bool            pending;
+    bool            unregister_pending;
+    uint64_t        ep_address;
+    uint64_t        ep_argument;
+    uint64_t        routing_mode;
+    int32_t         event_id;
+    /*
+     * For it is not easy to save the pointer target_cpu during migration, we
+     * add below field to save the corresponding numerical values.
+     */
+    uint64_t        cpu_affinity;
+} QemuSDE;
+
+typedef struct QemuSDECpuCtx {
+    uint64_t        xregs[18];
+    uint64_t        pc;
+    uint32_t        pstate;
+} QemuSDECpuCtx;
+
+typedef struct QemuSDECpu {
+    QemuSDE         *private_sde_array[PRIVATE_SLOT_COUNT];
+    QemuSDECpuCtx   ctx[2];
+    bool            masked;
+    int32_t         critical_running_event;
+    int32_t         normal_running_event;
+} QemuSDECpu;
+
+typedef struct QemuSDEState {
+    DeviceState     parent_obj;
+    QemuSDEProp     sde_props_state[PRIVATE_SLOT_COUNT + SHARED_SLOT_COUNT];
+    QemuSDECpu      *sde_cpus;
+    int             sdei_max_cpus;
+    QemuSDE         *shared_sde_array[SHARED_SLOT_COUNT];
+    int32_t         irq_map[GIC_MAXIRQ];
+    QemuMutex       sdei_interrupt_bind_lock;
+} QemuSDEState;
+
+#endif
-- 
1.8.3.1


