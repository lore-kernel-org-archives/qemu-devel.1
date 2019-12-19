Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E951C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 04:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BEBE20684
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 04:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZNyQKtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BEBE20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihn6O-0006CI-9Z
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 23:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1ihn57-0005gv-KO
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 23:06:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1ihn53-0003gM-Sn
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 23:06:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55707
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1ihn53-0003c1-HK
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 23:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576728388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=h61PaYXdE53o1HsslQmw6NieA6e1HNb0TnT6MMXOAY0=;
 b=dZNyQKtNUxuv7TgOr+TXWWG2yUFxaSv0caggicF3hV2JmEQtnf5p88DeJfjMcHpYFZX9RF
 lDmCjQ73G8FrpTvLObe/Qg2uPRvRY7uqfFtj+3zBVDNrc0i8s7AgEhQRMlnydswYcmTtuY
 mp1jMUs6Ki45CYulIuz+pGOErEwemw4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-P8bUrv1XPCeMt36PxENRFw-1; Wed, 18 Dec 2019 23:06:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 015F818557C2;
 Thu, 19 Dec 2019 04:06:24 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-48.bne.redhat.com
 [10.64.54.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 103CE5C298;
 Thu, 19 Dec 2019 04:06:18 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Subject: [RFC PATCH] hw/arm/virt: Support NMI injection
Date: Thu, 19 Dec 2019 15:06:12 +1100
Message-Id: <20191219040612.28431-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: P8bUrv1XPCeMt36PxENRFw-1
X-Mimecast-Spam-Score: 0
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, qemu-devel@nongnu.org,
 eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This supports NMI injection for virtual machine and currently it's only
supported on GICv3 controller, which is emulated by qemu or host kernel.
The design is highlighted as below:

   * The NMI is identified by its priority (0x20). In the guest (linux)
     kernel, the GICC_PMR is set to 0x80, to block all interrupts except
     the NMIs when the external interrupt is disabled. It means the FIQ
     and IRQ bit in PSTATE isn't touched when the functionality (NMI) is
     functional.
   * LPIs aren't considered as NMIs because of their nature. It means NMI
     is either SPI or PPI. Besides, the NMIs are injected in round-robin
     fashion is there are multiple NMIs existing.
   * When the GICv3 controller is emulated by qemu, the interrupt states
     (e.g. enabled, priority) is fetched from the corresponding data struct
     directly. However, we have to pause all CPUs to fetch the interrupt
     states from host in advance if the GICv3 controller is emulated by
     host.

The testing scenario is to tweak guest (linux) kernel where the pl011 SPI
can be enabled as NMI by request_nmi(). Check "/proc/interrupts" after inje=
cting
several NMIs, to see if the interrupt count is increased or not. The result
is just as expected.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 hw/arm/virt.c                      | 24 ++++++++
 hw/intc/arm_gicv3.c                | 76 ++++++++++++++++++++++++
 hw/intc/arm_gicv3_kvm.c            | 92 ++++++++++++++++++++++++++++++
 include/hw/intc/arm_gicv3_common.h |  2 +
 4 files changed, 194 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 39ab5f47e0..fc58ee70b4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -71,6 +71,8 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/generic_event_device.h"
+#include "hw/nmi.h"
+#include "hw/intc/arm_gicv3.h"
=20
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -1980,6 +1982,25 @@ static void virt_machine_device_unplug_request_cb(Ho=
tplugHandler *hotplug_dev,
                " type: %s", object_get_typename(OBJECT(dev)));
 }
=20
+static void virt_nmi(NMIState *n, int cpu_index, Error **errp)
+{
+    VirtMachineState *vms =3D VIRT_MACHINE(n);
+    ARMGICv3CommonClass *agcc;
+
+    if (vms->gic_version !=3D 3) {
+        error_setg(errp, "NMI is only supported by GICv3");
+        return;
+    }
+
+    agcc =3D ARM_GICV3_COMMON_GET_CLASS(vms->gic);
+    if (agcc->inject_nmi) {
+        agcc->inject_nmi(vms->gic, cpu_index, errp);
+    } else {
+        error_setg(errp, "NMI injection isn't supported by %s",
+                   object_get_typename(OBJECT(vms->gic)));
+    }
+}
+
 static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *mach=
ine,
                                                         DeviceState *dev)
 {
@@ -2025,6 +2046,7 @@ static void virt_machine_class_init(ObjectClass *oc, =
void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
     HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
+    NMIClass *nc =3D NMI_CLASS(oc);
=20
     mc->init =3D machvirt_init;
     /* Start with max_cpus set to 512, which is the maximum supported by K=
VM.
@@ -2051,6 +2073,7 @@ static void virt_machine_class_init(ObjectClass *oc, =
void *data)
     hc->pre_plug =3D virt_machine_device_pre_plug_cb;
     hc->plug =3D virt_machine_device_plug_cb;
     hc->unplug_request =3D virt_machine_device_unplug_request_cb;
+    nc->nmi_monitor_handler =3D virt_nmi;
     mc->numa_mem_supported =3D true;
     mc->auto_enable_numa_with_memhp =3D true;
 }
@@ -2136,6 +2159,7 @@ static const TypeInfo virt_machine_info =3D {
     .instance_init =3D virt_instance_init,
     .interfaces =3D (InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
+         { TYPE_NMI },
          { }
     },
 };
diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index 66eaa97198..d3409cb6ef 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -338,6 +338,81 @@ static void gicv3_set_irq(void *opaque, int irq, int l=
evel)
     }
 }
=20
+static bool arm_gicv3_inject_nmi_once(GICv3State*s, int start, int end)
+{
+    GICv3CPUState *cs;
+    int irq_count =3D (s->num_irq + (GIC_INTERNAL * (s->num_cpu - 1)));
+    int i, cpu, irq;
+
+    /* SPIs */
+    for (i =3D start; (i < end) && (i < (s->num_irq - GIC_INTERNAL)); i++)=
 {
+        if (gicv3_gicd_enabled_test(s, i + GIC_INTERNAL) &&
+            s->gicd_ipriority[i + GIC_INTERNAL] =3D=3D 0x20) {
+
+            /*
+             * Reset the level and toggling the pending bit will ensure
+             * the interrupt is queued.
+             */
+            if (gicv3_gicd_level_test(s, i + GIC_INTERNAL)) {
+                gicv3_set_irq(s, i, false);
+            }
+
+            gicv3_gicd_pending_set(s, i + GIC_INTERNAL);
+            gicv3_set_irq(s, i, true);
+
+            s->last_nmi_index =3D (i + 1);
+            return true;
+        }
+    }
+
+    /* PPIs */
+    if (start < (s->num_irq - GIC_INTERNAL)) {
+        start =3D (s->num_irq - GIC_INTERNAL);
+    }
+
+    for (i =3D start; (i < end) && (i < irq_count); i++) {
+        cpu =3D (i - ((s->num_irq - GIC_INTERNAL))) / GIC_INTERNAL;
+        irq =3D (i - ((s->num_irq - GIC_INTERNAL))) % GIC_INTERNAL;
+        cs =3D &s->cpu[cpu];
+
+        if ((cs->gicr_ienabler0 & (1 << irq)) &&
+            cs->gicr_ipriorityr[irq] =3D=3D 0x20) {
+
+            if (extract32(cs->level, irq, 1)) {
+                gicv3_set_irq(s, i, false);
+            }
+
+            deposit32(cs->gicr_ipendr0, irq, 1, 1);
+            gicv3_set_irq(s, i, true);
+
+            s->last_nmi_index =3D (i + 1);
+            if (s->last_nmi_index > irq_count) {
+                s->last_nmi_index =3D 0;
+            }
+
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static void arm_gicv3_inject_nmi(DeviceState *dev, int cpu_index, Error **=
errp)
+{
+    GICv3State *s =3D ARM_GICV3(dev);
+    int irq_count =3D (s->num_irq + (GIC_INTERNAL * (s->num_cpu - 1)));
+    bool injected;
+
+    injected =3D arm_gicv3_inject_nmi_once(s, s->last_nmi_index, irq_count=
);
+    if (!injected) {
+        injected =3D arm_gicv3_inject_nmi_once(s, 0, s->last_nmi_index);
+    }
+
+    if (!injected) {
+        error_setg(errp, "No NMI found");
+    }
+}
+
 static void arm_gicv3_post_load(GICv3State *s)
 {
     /* Recalculate our cached idea of the current highest priority
@@ -395,6 +470,7 @@ static void arm_gicv3_class_init(ObjectClass *klass, vo=
id *data)
     ARMGICv3CommonClass *agcc =3D ARM_GICV3_COMMON_CLASS(klass);
     ARMGICv3Class *agc =3D ARM_GICV3_CLASS(klass);
=20
+    agcc->inject_nmi =3D arm_gicv3_inject_nmi;
     agcc->post_load =3D arm_gicv3_post_load;
     device_class_set_parent_realize(dc, arm_gic_realize, &agc->parent_real=
ize);
 }
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 9c7f4ab871..b076d67c52 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -31,6 +31,7 @@
 #include "gicv3_internal.h"
 #include "vgic_common.h"
 #include "migration/blocker.h"
+#include "sysemu/cpus.h"
=20
 #ifdef DEBUG_GICV3_KVM
 #define DPRINTF(fmt, ...) \
@@ -506,6 +507,96 @@ static void kvm_arm_gicv3_put(GICv3State *s)
     }
 }
=20
+static bool kvm_arm_gicv3_inject_nmi_once(GICv3State *s, int start, int en=
d)
+{
+    GICv3CPUState *cs;
+    int irq_count =3D (s->num_irq + (GIC_INTERNAL * (s->num_cpu - 1)));
+    int i, cpu, irq;
+
+    /* SPIs */
+    for (i =3D start; (i < end) && (i < (s->num_irq - GIC_INTERNAL)); i++)=
 {
+        if (gicv3_gicd_enabled_test(s, i + GIC_INTERNAL) &&
+            s->gicd_ipriority[i + GIC_INTERNAL] =3D=3D 0x20) {
+            kvm_arm_gicv3_set_irq(s, i, true);
+
+            s->last_nmi_index =3D (i + 1);
+            return true;
+        }
+    }
+
+    /* PPIs */
+    if (start < (s->num_irq - GIC_INTERNAL)) {
+        start =3D (s->num_irq - GIC_INTERNAL);
+    }
+
+    for (i =3D start; (i < end) && (i < irq_count); i++) {
+        cpu =3D (i - ((s->num_irq - GIC_INTERNAL))) / GIC_INTERNAL;
+        irq =3D (i - ((s->num_irq - GIC_INTERNAL))) % GIC_INTERNAL;
+        cs =3D &s->cpu[cpu];
+
+        if ((cs->gicr_ienabler0 & (1 << irq)) &&
+            cs->gicr_ipriorityr[irq] =3D=3D 0x20) {
+            kvm_arm_gicv3_set_irq(s, i, true);
+
+            s->last_nmi_index =3D (i + 1);
+            if (s->last_nmi_index > irq_count) {
+                s->last_nmi_index =3D 0;
+            }
+
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static void kvm_arm_gicv3_snapshot(GICv3State *s)
+{
+    GICv3CPUState *c;
+    uint32_t val;
+    int i, j;
+
+    pause_all_vcpus();
+
+    kvm_dist_getbmp(s, GICD_ISENABLER, s->enabled);
+    kvm_dist_get_priority(s, GICD_IPRIORITYR, s->gicd_ipriority);
+    for (i =3D 0; i < s->num_cpu; i++) {
+        c =3D &s->cpu[i];
+
+        kvm_gicr_access(s, GICR_ISENABLER0, i, &val, false);
+        c->gicr_ienabler0 =3D val;
+
+        for (j =3D 0; j < GIC_INTERNAL; j +=3D 4) {
+            kvm_gicr_access(s, GICR_IPRIORITYR + j, i, &val, false);
+            c->gicr_ipriorityr[j] =3D extract32(val, 0, 8);
+            c->gicr_ipriorityr[j + 1] =3D extract32(val, 8, 8);
+            c->gicr_ipriorityr[j + 2] =3D extract32(val, 16, 8);
+            c->gicr_ipriorityr[j + 3] =3D extract32(val, 24, 8);
+        }
+    }
+
+    resume_all_vcpus();
+}
+
+static void kvm_arm_gicv3_inject_nmi(DeviceState *dev,
+                                     int cpu_index, Error **errp)
+{
+    GICv3State *s =3D KVM_ARM_GICV3(dev);
+    int irq_count =3D (s->num_irq + (GIC_INTERNAL * (s->num_cpu - 1)));
+    bool injected;
+
+    kvm_arm_gicv3_snapshot(s);
+
+    injected =3D kvm_arm_gicv3_inject_nmi_once(s, s->last_nmi_index, irq_c=
ount);
+    if (!injected) {
+        injected =3D kvm_arm_gicv3_inject_nmi_once(s, 0, s->last_nmi_index=
);
+    }
+
+    if (!injected) {
+        error_setg(errp, "No NMI found");
+    }
+}
+
 static void kvm_arm_gicv3_get(GICv3State *s)
 {
     uint32_t regl, regh, reg;
@@ -882,6 +973,7 @@ static void kvm_arm_gicv3_class_init(ObjectClass *klass=
, void *data)
     ARMGICv3CommonClass *agcc =3D ARM_GICV3_COMMON_CLASS(klass);
     KVMARMGICv3Class *kgc =3D KVM_ARM_GICV3_CLASS(klass);
=20
+    agcc->inject_nmi =3D kvm_arm_gicv3_inject_nmi;
     agcc->pre_save =3D kvm_arm_gicv3_get;
     agcc->post_load =3D kvm_arm_gicv3_put;
     device_class_set_parent_realize(dc, kvm_arm_gicv3_realize,
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3=
_common.h
index 31ec9a1ae4..0ae9c45aa2 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -225,6 +225,7 @@ struct GICv3State {
=20
     int dev_fd; /* kvm device fd if backed by kvm vgic support */
     Error *migration_blocker;
+    int last_nmi_index;
=20
     /* Distributor */
=20
@@ -291,6 +292,7 @@ typedef struct ARMGICv3CommonClass {
     SysBusDeviceClass parent_class;
     /*< public >*/
=20
+    void (*inject_nmi)(DeviceState *dev, int cpu_index, Error **errp);
     void (*pre_save)(GICv3State *s);
     void (*post_load)(GICv3State *s);
 } ARMGICv3CommonClass;
--=20
2.23.0


