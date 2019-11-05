Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0CCC49EAA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F378920717
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F378920717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRv41-0002ZN-Kz
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iRut1-00059W-UW
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:12:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iRusz-0007q8-WE
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:12:27 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52158 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iRusv-0007j7-4L; Tue, 05 Nov 2019 04:12:21 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 3842331F2AAD5394DB38;
 Tue,  5 Nov 2019 17:12:18 +0800 (CST)
Received: from linux-OtBuvb.huawei.com (10.175.104.212) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 17:12:07 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [RFC v2 09/14] arm/sdei: override qemu_irq handler when binding
 interrupt
Date: Tue, 5 Nov 2019 17:10:51 +0800
Message-ID: <20191105091056.9541-10-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191105091056.9541-1-guoheyi@huawei.com>
References: <20191105091056.9541-1-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
 James Morse <james.morse@arm.com>, Heyi Guo <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com, Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Override qemu_irq handler to support trigger SDEI event transparently
after guest binds interrupt to SDEI event. We don't have good way to
get GIC device and to guarantee SDEI device is initialized after GIC,
so we search GIC in system bus when the first SDEI request happens or
in VMSTATE post_load().

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 target/arm/sdei.c     | 130 +++++++++++++++++++++++++++++++++++++++++-
 target/arm/sdei_int.h |   3 +
 2 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/target/arm/sdei.c b/target/arm/sdei.c
index 713ac97775..529a06c1f6 100644
--- a/target/arm/sdei.c
+++ b/target/arm/sdei.c
@@ -88,6 +88,24 @@ static void qemu_sde_cpu_init(QemuSDEState *s)
     }
 }
=20
+static int gic_int_to_irq(int num_irq, int intid, int cpu)
+{
+    if (intid >=3D GIC_INTERNAL) {
+        return intid - GIC_INTERNAL;
+    }
+    return num_irq - GIC_INTERNAL + cpu * GIC_INTERNAL + intid;
+}
+
+static int irq_to_gic_int(int num_irq, int irq, int *cpu)
+{
+    if (irq < num_irq - GIC_INTERNAL) {
+        return irq + GIC_INTERNAL;
+    }
+    irq -=3D num_irq - GIC_INTERNAL;
+    *cpu =3D irq / GIC_INTERNAL;
+    return irq % GIC_INTERNAL;
+}
+
 static inline QemuSDECpu *get_sde_cpu(QemuSDEState *s, CPUState *cs)
 {
     if (cs->cpu_index >=3D s->sdei_max_cpus) {
@@ -410,6 +428,74 @@ static void dispatch_cpu(QemuSDEState *s, CPUState *=
cs, bool is_critical)
     }
 }
=20
+static void qemu_sdei_irq_handler(void *opaque, int irq, int level)
+{
+    int cpu =3D 0;
+
+    irq =3D irq_to_gic_int(sde_state->num_irq, irq, &cpu);
+    trigger_sdei_by_irq(cpu, irq);
+}
+
+static void override_qemu_irq(QemuSDEState *s, int32_t event, uint32_t i=
ntid)
+{
+    qemu_irq irq;
+    QemuSDE *sde;
+    CPUState *cs;
+
+    /* SPI */
+    if (intid >=3D GIC_INTERNAL) {
+        cs =3D first_cpu;
+        irq =3D qdev_get_gpio_in(s->gic_dev,
+                               gic_int_to_irq(s->num_irq, intid, 0));
+        if (irq) {
+            qemu_irq_intercept_in(&irq, qemu_sdei_irq_handler, 1);
+        }
+        sde =3D get_sde_no_check(s, event, cs);
+        sde->irq =3D irq;
+        put_sde(sde, cs);
+        return;
+    }
+    /* PPI */
+    CPU_FOREACH(cs) {
+        irq =3D qdev_get_gpio_in(
+            s->gic_dev,
+            gic_int_to_irq(s->num_irq, intid, cs->cpu_index));
+        if (irq) {
+            qemu_irq_intercept_in(&irq, qemu_sdei_irq_handler, 1);
+        }
+        sde =3D get_sde_no_check(s, event, cs);
+        sde->irq =3D irq;
+        put_sde(sde, cs);
+    }
+}
+
+static void restore_qemu_irq(QemuSDEState *s, int32_t event, uint32_t in=
tid)
+{
+    QemuSDE *sde;
+    CPUState *cs;
+
+    /* SPI */
+    if (intid >=3D GIC_INTERNAL) {
+        cs =3D first_cpu;
+        sde =3D get_sde_no_check(s, event, cs);
+        if (sde->irq) {
+            qemu_irq_remove_intercept(&sde->irq, 1);
+            sde->irq =3D NULL;
+        }
+        put_sde(sde, cs);
+        return;
+    }
+    /* PPI */
+    CPU_FOREACH(cs) {
+        sde =3D get_sde_no_check(s, event, cs);
+        if (sde->irq) {
+            qemu_irq_remove_intercept(&sde->irq, 1);
+            sde->irq =3D NULL;
+        }
+        put_sde(sde, cs);
+    }
+}
+
 static int32_t sdei_alloc_event_num(QemuSDEState *s, bool is_critical,
                                     bool is_shared, int intid)
 {
@@ -443,6 +529,7 @@ static int32_t sdei_alloc_event_num(QemuSDEState *s, =
bool is_critical,
             sde_props[index].interrupt =3D intid;
             sde_props[index].is_shared =3D is_shared;
             sde_props[index].is_critical =3D is_critical;
+            override_qemu_irq(s, event, intid);
             s->irq_map[intid] =3D event;
             qemu_mutex_unlock(&sde_props[index].lock);
             qemu_mutex_unlock(&s->sdei_interrupt_bind_lock);
@@ -460,6 +547,7 @@ static int32_t sdei_free_event_num_locked(QemuSDEStat=
e *s, QemuSDEProp *prop)
         return SDEI_DENIED;
     }
=20
+    restore_qemu_irq(s, prop->event_id, prop->interrupt);
     s->irq_map[prop->interrupt] =3D SDEI_INVALID_EVENT_ID;
     prop->event_id =3D SDEI_INVALID_EVENT_ID;
     prop->interrupt =3D SDEI_INVALID_INTERRUPT;
@@ -992,13 +1080,33 @@ static int64_t sdei_event_pe_unmask(QemuSDEState *=
s, CPUState *cs,
     return SDEI_SUCCESS;
 }
=20
+static int dev_walkerfn(DeviceState *dev, void *opaque)
+{
+    QemuSDEState *s =3D opaque;
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_GICV3_COMMON)) {
+        GICv3State *gic =3D ARM_GICV3_COMMON(dev);
+        s->num_irq =3D gic->num_irq;
+        s->gic_dev =3D dev;
+        return -1;
+    }
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_GIC_COMMON)) {
+        GICState *gic =3D ARM_GIC_COMMON(dev);
+        s->num_irq =3D gic->num_irq;
+        s->gic_dev =3D dev;
+        return -1;
+    }
+    return 0;
+}
+
 static int64_t sdei_event_interrupt_bind(QemuSDEState *s, CPUState *cs,
                                          struct kvm_run *run)
 {
     uint64_t *args =3D (uint64_t *)(run->hypercall.args);
     uint32_t intid =3D args[1];
=20
-    if (intid < GIC_NR_SGIS || intid >=3D GIC_MAXIRQ) {
+    if (intid < GIC_NR_SGIS || intid >=3D s->num_irq) {
         return SDEI_INVALID_PARAMETERS;
     }
     return sdei_alloc_event_num(s, false, intid >=3D GIC_INTERNAL, intid=
);
@@ -1112,6 +1220,17 @@ void sdei_handle_request(CPUState *cs, struct kvm_=
run *run)
         return;
     }
=20
+    if (!sde_state->gic_dev) {
+        /* Search for ARM GIC device */
+        qbus_walk_children(sysbus_get_default(), dev_walkerfn,
+                           NULL, NULL, NULL, sde_state);
+        if (!sde_state->gic_dev) {
+            error_report("Cannot find ARM GIC device!");
+            run->hypercall.args[0] =3D SDEI_NOT_SUPPORTED;
+            return;
+        }
+    }
+
     if (func_id < SDEI_1_0_FN_BASE || func_id > SDEI_MAX_REQ) {
         error_report("Invalid SDEI function ID: 0x%x", func_id);
         run->hypercall.args[0] =3D SDEI_INVALID_PARAMETERS;
@@ -1259,11 +1378,20 @@ static int qemu_sdei_post_load(void *opaque, int =
version_id)
         }
     }
=20
+    /* Search for ARM GIC device */
+    qbus_walk_children(sysbus_get_default(), dev_walkerfn,
+                       NULL, NULL, NULL, s);
+    if (!s->gic_dev) {
+        error_report("Cannot find ARM GIC device!");
+        return 0;
+    }
+
     for (i =3D 0; i < PRIVATE_SLOT_COUNT + SHARED_SLOT_COUNT; i++) {
         int intid =3D sde_props[i].interrupt;
=20
         if (intid !=3D SDEI_INVALID_INTERRUPT) {
             s->irq_map[intid] =3D sde_props[i].event_id;
+            override_qemu_irq(s, sde_props[i].event_id, intid);
         }
     }
=20
diff --git a/target/arm/sdei_int.h b/target/arm/sdei_int.h
index d3fd7cbc10..a251b04ab5 100644
--- a/target/arm/sdei_int.h
+++ b/target/arm/sdei_int.h
@@ -63,6 +63,7 @@ typedef struct QemuSDEProp {
 typedef struct QemuSDE {
     QemuSDEProp     *prop;
     CPUState        *target_cpu;
+    qemu_irq        irq;
     QemuMutex       lock;
     bool            enabled;
     bool            running;
@@ -107,9 +108,11 @@ typedef struct QemuSDECpu {
=20
 typedef struct QemuSDEState {
     DeviceState     parent_obj;
+    DeviceState     *gic_dev;
     QemuSDEProp     sde_props_state[PRIVATE_SLOT_COUNT + SHARED_SLOT_COU=
NT];
     QemuSDECpu      *sde_cpus;
     int             sdei_max_cpus;
+    int             num_irq;
     QemuSDE         *shared_sde_array[SHARED_SLOT_COUNT];
     int32_t         irq_map[GIC_MAXIRQ];
     QemuMutex       sdei_interrupt_bind_lock;
--=20
2.19.1


